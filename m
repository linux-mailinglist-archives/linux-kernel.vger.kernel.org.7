Return-Path: <linux-kernel+bounces-593607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB66A7FB74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 12:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769E13A6FB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A7D268FF9;
	Tue,  8 Apr 2025 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm0b+wwa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238C266F13;
	Tue,  8 Apr 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106996; cv=none; b=bu0WXTEINjA5I9O3yf8720CHHy+i+yLX66n1aguJ6F9z7jNf16n+2LmNlm1zExapuI/+RHOaUcKNTqkX5NXhXl4fHz6F+GEcJLMVgLIoq59o7EE15TzV+Kv62SgiWIXAaf4XJrDLOlqI1bLwY+L/Aq3wJl+iKfsjQCjuPz5zPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106996; c=relaxed/simple;
	bh=IVWVxy8Iyjwhz+B3KhlfqTCOeB9G5zFT4ISB8zvAsy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaFBBPOkG2GsGiPk6GPirYZ85j/3w02n3eW18+f+0PdWT+JrNURfL7Iitn9QmPk8Qn+TkCT19msugnrKnp5lfBV9Rt+e9ieWlk5BwzlVragPSpJrVYrg5lgHuh+CRxdImdarj7cNF0FIjvPlKjKSQTelWJzHnxn80PNeMOYyv1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm0b+wwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88246C4AF09;
	Tue,  8 Apr 2025 10:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744106996;
	bh=IVWVxy8Iyjwhz+B3KhlfqTCOeB9G5zFT4ISB8zvAsy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gm0b+wwaqvH6p3e9SqV8JdmIAGE2MY0aWGNdCCxDR50kszF6Pxl30cX1ohUVLycCK
	 RE2GnkHSPsQPCvif2wL0D/ujd3wVOzwPPMhvbkRp9hk9Vou9f8tf6n35Q1TEp2nn/w
	 7TLqwEAREIMmaviHXdKIA7Mm3jeTUcysl9j6Wm7FcktqWEcMISHNpyZGLEG3C66qr5
	 G2VshhxFwMJWUdrJnYFaPPBfD3grsd7gXpjztdK3aaBu+bSnT0lV+MQ71ZywR5Bo9X
	 APl2zZ/ZzFaoIZgw0UdCneb+XMGMv4NtHmOqv8Bl7UIcn3ZdQunQ9XfIcIoQAWVzzI
	 DSk+AyGVRSXWQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1u25tt-00000008RVX-0HaZ;
	Tue, 08 Apr 2025 18:09:49 +0800
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/33] scripts/kernel-doc.py: properly handle struct_group macros
Date: Tue,  8 Apr 2025 18:09:09 +0800
Message-ID: <74dee485f70b7ce85e90496bfdd360283a677a58.1744106241.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744106241.git.mchehab+huawei@kernel.org>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Handing nested parenthesis with regular expressions is not an
easy task. It is even harder with Python's re module, as it
has a limited subset of regular expressions, missing more
advanced features.

We might use instead Python regex module, but still the
regular expressions are very hard to understand. So, instead,
add a logic to properly match delimiters.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py | 220 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 213 insertions(+), 7 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 90808d538de7..fb96d42d287c 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -167,6 +167,172 @@ class Re:
     def group(self, num):
         return self.last_match.group(num)
 
+class NestedMatch:
+    """
+    Finding nested delimiters is hard with regular expressions. It is
+    even harder on Python with its normal re module, as there are several
+    advanced regular expressions that are missing.
+
+    This is the case of this pattern:
+
+            '\\bSTRUCT_GROUP(\\(((?:(?>[^)(]+)|(?1))*)\\))[^;]*;'
+
+    which is used to properly match open/close parenthesis of the
+    string search STRUCT_GROUP(),
+
+    Add a class that counts pairs of delimiters, using it to match and
+    replace nested expressions.
+
+    The original approach was suggested by:
+        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
+
+    Although I re-implemented it to make it more generic and match 3 types
+    of delimiters. The logic checks if delimiters are paired. If not, it
+    will ignore the search string.
+    """
+
+    # TODO:
+    # Right now, regular expressions to match it are defined only up to
+    #       the start delimiter, e.g.:
+    #
+    #       \bSTRUCT_GROUP\(
+    #
+    # is similar to: STRUCT_GROUP\((.*)\)
+    # except that the content inside the match group is delimiter's aligned.
+    #
+    # The content inside parenthesis are converted into a single replace
+    # group (e.g. r`\1').
+    #
+    # It would be nice to change such definition to support multiple
+    # match groups, allowing a regex equivalent to.
+    #
+    #   FOO\((.*), (.*), (.*)\)
+    #
+    # it is probably easier to define it not as a regular expression, but
+    # with some lexical definition like:
+    #
+    #   FOO(arg1, arg2, arg3)
+
+
+    DELIMITER_PAIRS = {
+        '{': '}',
+        '(': ')',
+        '[': ']',
+    }
+
+    RE_DELIM = re.compile(r'[\{\}\[\]\(\)]')
+
+    def _search(self, regex, line):
+        """
+        Finds paired blocks for a regex that ends with a delimiter.
+
+        The suggestion of using finditer to match pairs came from:
+        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
+        but I ended using a different implementation to align all three types
+        of delimiters and seek for an initial regular expression.
+
+        The algorithm seeks for open/close paired delimiters and place them
+        into a stack, yielding a start/stop position of each match  when the
+        stack is zeroed.
+
+        The algorithm shoud work fine for properly paired lines, but will
+        silently ignore end delimiters that preceeds an start delimiter.
+        This should be OK for kernel-doc parser, as unaligned delimiters
+        would cause compilation errors. So, we don't need to rise exceptions
+        to cover such issues.
+        """
+
+        stack = []
+
+        for match_re in regex.finditer(line):
+            start = match_re.start()
+            offset = match_re.end()
+
+            d = line[offset -1]
+            if d not in self.DELIMITER_PAIRS:
+                continue
+
+            end = self.DELIMITER_PAIRS[d]
+            stack.append(end)
+
+            for match in self.RE_DELIM.finditer(line[offset:]):
+                pos = match.start() + offset
+
+                d = line[pos]
+
+                if d in self.DELIMITER_PAIRS:
+                    end = self.DELIMITER_PAIRS[d]
+
+                    stack.append(end)
+                    continue
+
+                # Does the end delimiter match what it is expected?
+                if stack and d == stack[-1]:
+                    stack.pop()
+
+                    if not stack:
+                        yield start, offset, pos + 1
+                        break
+
+    def search(self, regex, line):
+        """
+        This is similar to re.search:
+
+        It matches a regex that it is followed by a delimiter,
+        returning occurrences only if all delimiters are paired.
+        """
+
+        for t in self._search(regex, line):
+
+            yield line[t[0]:t[2]]
+
+    def sub(self, regex, sub, line, count=0):
+        """
+        This is similar to re.sub:
+
+        It matches a regex that it is followed by a delimiter,
+        replacing occurrences only if all delimiters are paired.
+
+        if r'\1' is used, it works just like re: it places there the
+        matched paired data with the delimiter stripped.
+
+        If count is different than zero, it will replace at most count
+        items.
+        """
+        out = ""
+
+        cur_pos = 0
+        n = 0
+
+        found = False
+        for start, end, pos in self._search(regex, line):
+            out += line[cur_pos:start]
+
+            # Value, ignoring start/end delimiters
+            value = line[end:pos - 1]
+
+            # replaces \1 at the sub string, if \1 is used there
+            new_sub = sub
+            new_sub = new_sub.replace(r'\1', value)
+
+            out += new_sub
+
+            # Drop end ';' if any
+            if line[pos] == ';':
+                pos += 1
+
+            cur_pos = pos
+            n += 1
+
+            if count and count >= n:
+                break
+
+        # Append the remaining string
+        l = len(line)
+        out += line[cur_pos:l]
+
+        return out
+
 #
 # Regular expressions used to parse kernel-doc markups at KernelDoc class.
 #
@@ -738,22 +904,49 @@ class KernelDoc:
             (Re(r'\s*____cacheline_aligned_in_smp', re.S),  ' '),
             (Re(r'\s*____cacheline_aligned', re.S),  ' '),
 
-            # Unwrap struct_group() based on this definition:
+            # Unwrap struct_group macros based on this definition:
             # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
             # which has variants like: struct_group(NAME, MEMBERS...)
+            # Only MEMBERS arguments require documentation.
+            #
+            # Parsing them happens on two steps:
+            #
+            # 1. drop struct group arguments that aren't at MEMBERS,
+            #    storing them as STRUCT_GROUP(MEMBERS)
+            #
+            # 2. remove STRUCT_GROUP() ancillary macro.
+            #
+            # The original logic used to remove STRUCT_GROUP() using an
+            # advanced regex:
+            #
+            #   \bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;
+            #
+            # with two patterns that are incompatible with
+            # Python re module, as it has:
+            #
+            #   - a recursive pattern: (?1)
+            #   - an atomic grouping: (?>...)
+            #
+            # I tried a simpler version: but it didn't work either:
+            #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
+            #
+            # As it doesn't properly match the end parenthesis on some cases.
+            #
+            # So, a better solution was crafted: there's now a NestedMatch
+            # class that ensures that delimiters after a search are properly
+            # matched. So, the implementation to drop STRUCT_GROUP() will be
+            # handled in separate.
 
             (Re(r'\bstruct_group\s*\(([^,]*,)', re.S),  r'STRUCT_GROUP('),
             (Re(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S),  r'STRUCT_GROUP('),
             (Re(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S),  r'struct \1 \2; STRUCT_GROUP('),
             (Re(r'\b__struct_group\s*\(([^,]*,){3}', re.S),  r'STRUCT_GROUP('),
 
-            # This is incompatible with Python re, as it uses:
-            #  recursive patterns ((?1)) and atomic grouping ((?>...)):
-            #   '\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;'
-            # Let's see if this works instead:
-            (Re(r'\bSTRUCT_GROUP\(([^\)]+)\)[^;]*;', re.S),  r'\1'),
-
             # Replace macros
+            #
+            # TODO: it is better to also move those to the NestedMatch logic,
+            # to ensure that parenthesis will be properly matched.
+
             (Re(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),  r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
             (Re(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S),  r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
             (Re(r'DECLARE_BITMAP\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S),  r'unsigned long \1[BITS_TO_LONGS(\2)]'),
@@ -765,9 +958,22 @@ class KernelDoc:
             (Re(r'DEFINE_DMA_UNMAP_LEN\s*\(' + args_pattern + r'\)', re.S),  r'__u32 \1'),
         ]
 
+        # Regexes here are guaranteed to have the end limiter matching
+        # the start delimiter. Yet, right now, only one replace group
+        # is allowed.
+
+        sub_nested_prefixes = [
+            (re.compile(r'\bSTRUCT_GROUP\('),  r'\1'),
+        ]
+
         for search, sub in sub_prefixes:
             members = search.sub(sub, members)
 
+        nested = NestedMatch()
+
+        for search, sub in sub_nested_prefixes:
+            members = nested.sub(search, sub, members)
+
         # Keeps the original declaration as-is
         declaration = members
 
-- 
2.49.0


