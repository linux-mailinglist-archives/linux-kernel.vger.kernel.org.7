Return-Path: <linux-kernel+bounces-812893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1FDB53DED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4655E1CC3E81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E805D341ABE;
	Thu, 11 Sep 2025 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLf2dXol"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF0327A2C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626755; cv=none; b=DooG5JvhOt1p0KXdpsrzpKMpbHOiPzU//JPHLfPY3Asor9vgGxd7ZWwL5Gg95S0Zs+EHG5D9kIylxtodObdtlgJVCCK3eADfSp035rlQ87Yc+fDp9o0btVmhS4AoskgdSX7Q1T/hfyH+htuB5Uy/JCNDtg3XIUzrxtMGRx/tpZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626755; c=relaxed/simple;
	bh=0y8tQXdcPB2L7E0a0QqA24/a8+3TwtpEi/wWOnoCupo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3zSE8wzBvjXttc5Tfelnxsxgu+fim5TEeGdcZE774VH4vNICsKXtF3COfdoEBpe3mLyJ2B3wfsSRZ0ZhZUHpKYSzcLDfUNBEJvNf679KyNiIfbfHao/WP/Zt2iNnAAYd2W5YrtBwR1RBkbAVVOMnKSnSVq2RkbMALl4TDzmjcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLf2dXol; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-88762f20125so88077539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626753; x=1758231553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llgmacej1inhZdixBhbo0c+/OM0TIwP7M6hLrupTHpw=;
        b=VLf2dXolE4+wK0lhlIqWM07U8L+Zses3o/M7q4QkIpy4Koj52TaAaFtrAmYPrNOwkc
         d1D8dQyulPuJpm8dttq7WacNnNIP6sMZIDgaz1fOA29DDVON6cckG1n5trKiAmiO5oA7
         LSbQLd+hT95fLiHBqYit8U5JTqc44SGbzaDZIn+vYR1J7FqNtlzx0ce/GT4DsGZfA/pa
         509kp36nGIrebtTa9ZWdIoY4WFU9nfugZhr4H1m/vpERi8GpBtAqiDrLc+dvDXyOunqY
         +R+d4mQApYLx9fEBKYIneZmH+zuVnsmzxXUmB6XkOe/dEE6mmrGfp/VBTmw4jTPjww/f
         7gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626753; x=1758231553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llgmacej1inhZdixBhbo0c+/OM0TIwP7M6hLrupTHpw=;
        b=qHP/wcGba6E/OHLTrRrq/bx03vTHV8DQioZeGwtvAqHDzbphbsF+ocHnQeg7mVIprz
         n5j0Pv+hj+kFXzozI3SPIfB5fCoQ/uHrgO51nQ7S42XLvRmi75kM+VCnAgzGkUu/DmVp
         OKYsYbXuaLcrA/fOnduFSl+4RvLm4MwRyp3OO+aPzu1CQWRju1JOcvAU7RM2k7Vk1cA9
         bGhtKlBEqRP6LoNQnQ1ij48Lr+82hSW1riS6K5bKmhkZEbV8JxbcqxCCGspS80Ag2bCm
         fXUQ/3ty9JfbQDnrgP6Jf/782ppziAvQLR1Haue1gi9+SE81zvx/oIxY/3YAeInKqyon
         E7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWCYg1c40se92SA7MJuKoUZWggkM2cM3GeXF30iZ/aV6Fax3E5t2ApVZd66g2ejHjvYvVT87l+XnwrQMX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10JzPZ0ekk5OmQhSonjQgTUKHMjTOkBS/ZYtwee0QT9t8XnuN
	s1iOVtKErlAgQlp1t5QVdDN705Txjezjju34SJJPZKKvI2rregt89LsyraKzDw==
X-Gm-Gg: ASbGncuQJ1+DKLjKQ8VSAhM8x7gox3sDSVupKb/mG2rfsa9sE8vWTuy6JQsYKzyoo3F
	8e5DetItYdH8sNUpre/agXOEZAgqzoW582mZGq8AULHaQpdl9pd0Rc4GnWutuGudPJLiB8kAHqv
	OIAez/IZrJQ7502HYaaipyS9GGzuz7PCv+kPmflBekVAsfOoCv0a6LWgjr7qK+eRErWCMwJovj4
	DgD5qkFWxLwqpY9vq/Rymulf+LDe9AfFSsoqcP4Tsx9s+BTVOSVjgrwciBZQTWE+qw6PjJPyX9o
	radyAVgYJuV/GK6gRvp0QmuQdhAACneSBBIVvhNDwRGGcJ9wqC9DtmZTjJDF/nYK1mMirDnxUht
	6PoCoNA3F1Sue/upKJXp1ZZtLn2NeR+Evh+4DdiQ0IKNfJeR5m5GIButm7lOH3QvTb92qQKbWDJ
	1hTuA=
X-Google-Smtp-Source: AGHT+IESAW2JSmdJUX0oyOH/lAOalZ4BMH3NBiiOx/LvIoO9hqFymfc+Gpl1dS63M/xDNiq3L8mtzw==
X-Received: by 2002:a05:6602:7216:b0:88c:30f3:32c9 with SMTP id ca18e2360f4ac-89033c6d33amr134528039f.15.1757626752607;
        Thu, 11 Sep 2025 14:39:12 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:39:12 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 25/30] dyndbg: treat comma as a token separator
Date: Thu, 11 Sep 2025 15:38:18 -0600
Message-ID: <20250911213823.374806-26-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911213823.374806-1-jim.cromie@gmail.com>
References: <20250911213823.374806-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Treat comma as a token terminator, just like a space.  This allows a
user to avoid quoting hassles when spaces are otherwise needed:

 :#> modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

or as a boot arg:

 drm.dyndbg=class,DRM_UT_CORE,+p  # todo: support multi-query here

Given the many ways a boot-line +args can be assembled and then passed
in/down/around shell based tools, this may allow side-stepping all
sorts of quoting hassles thru those layers.

existing query format:

 modprobe test_dynamic_debug dyndbg="class D2_CORE +p"

new format:

 modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p

ALSO

selftests-dyndbg: add comma_terminator_tests

New fn validates parsing and effect of queries using combinations of
commas and spaces to delimit the tokens.

It manipulates pr-debugs in builtin module/params, so might have deps
I havent foreseen on odd configurations.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
- skip comma tests if no builtins
-v3 squash in tests and doc
---
 .../admin-guide/dynamic-debug-howto.rst       |  9 +++++---
 lib/dynamic_debug.c                           | 17 +++++++++++----
 .../dynamic_debug/dyndbg_selftest.sh          | 21 ++++++++++++++++++-
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 63a511f2337b..e2dbb5d9b314 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -78,11 +78,12 @@ Command Language Reference
 ==========================
 
 At the basic lexical level, a command is a sequence of words separated
-by spaces or tabs.  So these are all equivalent::
+by spaces, tabs, or commas.  So these are all equivalent::
 
   :#> ddcmd file svcsock.c line 1603 +p
   :#> ddcmd "file svcsock.c line 1603 +p"
   :#> ddcmd '  file   svcsock.c     line  1603 +p  '
+  :#> ddcmd file,svcsock.c,line,1603,+p
 
 Command submissions are bounded by a write() system call.
 Multiple commands can be written together, separated by ``;`` or ``\n``::
@@ -167,9 +168,11 @@ module
     The given string is compared against the module name
     of each callsite.  The module name is the string as
     seen in ``lsmod``, i.e. without the directory or the ``.ko``
-    suffix and with ``-`` changed to ``_``.  Examples::
+    suffix and with ``-`` changed to ``_``.
 
-	module sunrpc
+    Examples::
+
+	module,sunrpc	# with ',' as token separator
 	module nfsd
 	module drm*	# both drm, drm_kms_helper
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 440fe2f483a3..9cb2c95a0559 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -299,6 +299,14 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 	return nfound;
 }
 
+static char *skip_spaces_and_commas(const char *str)
+{
+	str = skip_spaces(str);
+	while (*str == ',')
+		str = skip_spaces(++str);
+	return (char *)str;
+}
+
 /*
  * Split the buffer `buf' into space-separated words.
  * Handles simple " and ' quoting, i.e. without nested,
@@ -312,8 +320,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and comma */
+		buf = skip_spaces_and_commas(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -329,7 +337,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
@@ -601,7 +609,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = skip_spaces_and_commas(query);
+
 		if (!query || !*query || *query == '#')
 			continue;
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 465fad3f392c..c7bf521f36ee 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -216,7 +216,7 @@ function check_err_msg() {
 function basic_tests {
     echo -e "${GREEN}# BASIC_TESTS ${NC}"
     if [ $LACK_DD_BUILTIN -eq 1 ]; then
-	echo "SKIP"
+	echo "SKIP - test requires params, which is a builtin module"
 	return
     fi
     ddcmd =_ # zero everything
@@ -238,8 +238,27 @@ EOF
     ddcmd =_
 }
 
+function comma_terminator_tests {
+    echo -e "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
+    if [ $LACK_DD_BUILTIN -eq 1 ]; then
+	echo "SKIP - test requires params, which is a builtin module"
+	return
+    fi
+    # try combos of spaces & commas
+    check_match_ct '\[params\]' 4 -r
+    ddcmd module,params,=_		# commas as spaces
+    ddcmd module,params,+mpf		# turn on module's pr-debugs
+    check_match_ct =pmf 4
+    ddcmd ,module ,, ,  params, -p
+    check_match_ct =mf 4
+    ddcmd " , module ,,, ,  params, -m"	#
+    check_match_ct =f 4
+    ddcmd =_
+}
+
 tests_list=(
     basic_tests
+    comma_terminator_tests
 )
 
 # Run tests
-- 
2.51.0


