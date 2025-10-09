Return-Path: <linux-kernel+bounces-847312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF87BCA832
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DDD1A65B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0822F5468;
	Thu,  9 Oct 2025 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCFAeds4"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954802F39C5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032757; cv=none; b=jNgw61MLAORDQPj0QBFfQKOnZRIDu8cfLjQ8EDW/XY7ROlxBBpcXkNfq8NB/u5yL96ayp/TYX0bkTM3YFM/YCtyZEELdgs+GEH6c0ZKy9HkfPF6Pj1QFrqhknWOBkJXLj6mim16MU44C5qo9LgbrUlGHREfmI6PJ1KzOT1c7Oww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032757; c=relaxed/simple;
	bh=Mk2Kq1oV8Ntz1L8OhJe0Ppcl6bWBwPIp/SjTlJK2Gpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cw6XZBOJ5OonKC5ekurQw83/xWsTupaDMlfgH6HuvJ0FHJO9HYeLalp3m1RgTG5Ml2xCtNHXz9nRpjcdmuVClIj4Z923YR2tkgjksnO24JOzwvbE1w0Tb4cK+hdCatl7BM4F/aaefu/yBojoQxgnv8vxQrBO2tC6ZzTLACSv39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCFAeds4; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-92aee734485so49239739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032754; x=1760637554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj6+/m+YvJ4nvGYtValsKBvS5LCfNDkFuITQxB3i5qw=;
        b=XCFAeds4OuMYY2RhMbNMd+/CEPkCG1RGtCDR03GYiKqVJ++nGlM72qmn4TWo44oHUJ
         QaY5kO7QOCTdoy7Ja5VTEG4d/DdMPNXY5J5wtYfX754CLIqJuOOV7dl/dagh48kglqf4
         hSkstW0LJuCmB4+FcRK2LZKaQi7QfzbHFC5oaVh1xKYegD/GC6mpYyXdjeecLPpP2F49
         VUHcqqWcpuPjb5GEsyoAyPKYbogzy4u1cTEYL4VlEWDWGi+QvcDXC66NtdJRQikoZxez
         vcA31l1eqPvxGVaxYAtn01hAHaAZX6Wo/KJDyCf3WQ8MGgpGVxX5Wl8xNgxuxb3P2CN6
         kI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032754; x=1760637554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj6+/m+YvJ4nvGYtValsKBvS5LCfNDkFuITQxB3i5qw=;
        b=BdVhNZzU8hkm5iGBzXav1C1lUFWNdqDGUYovinW+VXUvwkXyADyNicUPs3rhvD/ajS
         anMOONsyJ18a6hjAdkOjtIunE+xenm8QhBt0EqBBWc/JxZw9H393CwqrmNa2VKiu4Hbp
         BZaZ76xFdGxh+KVmvX+xvOPXiGTtbIX0JIbyMtJ0a1iEsY+0O2o+zPYCcvLjIGff7LzE
         IDfW7B4taLfuaPfXaxCq6Q7H17urjTmnmECzfal2hd56mBcseYvSys07evi7pEBmHCSj
         yQ8+V3g0coAdBDiDGuO4Q+I+KX1dpPjJ63UWIKFtMqfzrVv43D591qUQCXmXYUCKxICa
         QD+A==
X-Forwarded-Encrypted: i=1; AJvYcCW8S46RE9USFWfOhv+NGmAfaurNKuPECo1CyARYEW2AiRWKz+zNxGSKWn/xCHPiAckeu1nWbIeseWoWV3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVrlIUDny5rSQL91Nuz3j8NvZ1yIhL+LTZd0ND3DkFDJnBK1+A
	lSaMV15MgLxY29vmoyCB+3bn/KDlo0FpZcmXTdLygwHT3cVguOLn7EBK
X-Gm-Gg: ASbGncuSgLa+fIrfUjULap1vLww4my01II8//V3SLZ7pqATPV6Tv3Ddn74jdBr26gzk
	LlmthdVYbVg95Jb2WAAD+RKpop/yNWa1ZR3Y4kO7nHxMFcsgxdTOzE6zllvZNCV6rbjMKGPIQsb
	/+5/nik1Rcftm1ClSgY+P+1eWE26X15I71jmgbFgHOFTn2yMj+9Rgdn+gFt/uk8F7MkSpbjsID1
	R9gTFuAKd7CiOmRgeWFvVhSFEuFEJLJEq3dGWbekp5wRxJ3v/Vn30JP/2j7RwsHbQKJU3FAaVtm
	X273SObD5gQ0fmVjAN2+XFLrru3uGK8ZY2SgqJtfzNNhx06hBBHINF2FGLnxUpiyjoK7uGo/CcU
	L9QslJJ2bF1mDcsB5RUTdb5HLXBWxFQMWToYC5CKeOIpxrRcwIU5bpG0eQ/AebeLz/L6XRhcJB/
	Y63cJKXWsNUk3htXO9mOK54hVOChssoRSPLE6eNA==
X-Google-Smtp-Source: AGHT+IF1wlfvaIMMrTodeuYFfX2PbnlKbpq3sHn29eEPjyMIjYw6+Qq5SpudC+MM1kOs5ShBVQ7J2g==
X-Received: by 2002:a05:6602:2b0e:b0:912:5455:f0b0 with SMTP id ca18e2360f4ac-93bd188eab3mr968983239f.9.1760032754468;
        Thu, 09 Oct 2025 10:59:14 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:59:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 25/30] dyndbg: treat comma as a token separator
Date: Thu,  9 Oct 2025 11:58:29 -0600
Message-ID: <20251009175834.1024308-26-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
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
index 9ae2d6458a99..b05d186e78a1 100644
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


