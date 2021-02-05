#
# Convenience script to get a chapter of the Bible with <sup>xx</sup> prefixing.
# The idea is that the result can be copy-pasted to a Markdown file with the
# Bible study for that chapter.
#
# Example usage: ./scripts/get_bible_chapter.sh Genesis 1
#

BOOK=${1?book must be provided}
CHAPTER=${2?chapter must be provided}

SQL=$(cat <<EOF
    select concat('> <sup>', v, '</sup> ', t) from t_kjv where b = (
        select b from key_english where n = '$BOOK'
    )
    and c = $CHAPTER
EOF
)

mysql -N -e "$SQL" | cat
