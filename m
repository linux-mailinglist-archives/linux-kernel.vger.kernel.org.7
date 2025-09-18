Return-Path: <linux-kernel+bounces-754296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EEEB1925F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 06:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F13E16725A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 04:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D81286412;
	Sun,  3 Aug 2025 03:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1LOiB+h"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1EC285C86;
	Sun,  3 Aug 2025 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754193555; cv=none; b=WngIHEMkIbqBlkVsIIjyByDKX+6ZolukpNRaJuZtUmbRGAz6evMLmTkRxTH5uxHFuClE877y9Z2bZ2pT4neBa/7FC+oXKkdCq2Qem3B2+H2HIbDU1k/7GEmVrzbppD9V5rt0RgXuhO5pye+VHxX3QV5rvMDrzD2K9KpnuNtsPJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754193555; c=relaxed/simple;
	bh=hesI4dm3s4j1+X5aTp+etFPGxZP+aiHovIljjEOVtBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJiiTn67xojDRKdr4eA8Vgzka3YMJhLiJS2SVahrIJvUoRa8878zEumytcjQzV22JqX+zfHnXPcOa88xNuXl2104aSqD7u2pGwHWzUrQ5fW87BHiU3tqwpVZSPsiyYN09tbFyUz2amXxy4DpJ4in7yQf4T4aUZoUAf4g1E7p0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1LOiB+h; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e3e4c564ffso20213875ab.2;
        Sat, 02 Aug 2025 20:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754193550; x=1754798350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh5DtSmdlg1q4BLyqHiCWDwX2HlPvGGP8eXC9e2gYuw=;
        b=K1LOiB+hjStWa0j9zc6yM420jw8S1RN4G/93GuNVDHKe25L78JSC/iuUKVbUZlnBlO
         6u3mhsdHrZdXkjT8LahI53lpKa/JXHkRvYNH2wJbzWH7Oiqj72NJ9IvhWYbTcLDR8aZm
         16LkhKCwxMS39oj8JDSYiZDp7alzCKLe46k25nqlKczEbT+795Dmx9DiIxQDeMVJaofz
         K2TkYafXwfIIMsYFTGZM7tYWZYXcA9D1ZFRH51Vv4ImbcO2VELrrbtJB7z3kV3BeXVA+
         E4CHzWWmKzx13HXEWZpF5DXJCTvufN7ZjYjiPfYMfrwWvYEjjm62oYQBN2phdMUKWEKi
         8Ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754193550; x=1754798350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh5DtSmdlg1q4BLyqHiCWDwX2HlPvGGP8eXC9e2gYuw=;
        b=B2pkTardnLJpkOi9j1MPVoUE+msA2AF3NSlPBt0hJWDhLTWLb+Sq9jFRIy9K4dpHJN
         VLOkTqzNq7krNkU5GQt4EYawtT+UlRDE0Bvxf3v8gGwlgo47kdeF1Ekbp6vLlWevbCpQ
         hccT81w6Ps/b2k5JaIRtKonbQu8Vsn93kdKALJSf5hBc01PGAw6UOit73e8PwlAQYAjI
         9y+DWExpR8h8FVlM49Xo3rj8k1Phl1MLKjRENE5T43hY2gFsTQ5/586c0KipcYI0gcF2
         7yxWmqoE6DKqo3edXH3RIvuEYEPe6gHFPO1UTcJiJ4Rei4jWxloj/GGSvpD6BcjQcrj6
         FFjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpLBZGgtxMegueFD2XcBxttsRisMbdxvQXDIsW+2oYD/Pr3DzsgleNrHWHXFFAkgZe9ZWK0SDp8rLKbvzN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7pc8h83Gy713XQdta1Zf7jkWnDtRPh3HNpIyr9GBWLawPk63
	VlrPlHMJ7f6wjHXsPC3JkjDXIGIgEbIJ/9ruVyA7mNKRejo1qbAcKMibsgeFBKY9lbg=
X-Gm-Gg: ASbGncsdHjgDeTOnrsj7FhBuUSEh0QAtzS0fuHAmfe+HyBSR03pPgd2RfLwuM9DNWXA
	1KJ2GDa4E/R6EIVfAUNR9/iazCFZ5s99OFk6w2hG3Tddy2oRsEp9wGIq5ICTzFuO40tP2lE5SMG
	i+mwUDGEW77K7a3oUC2w5WhI6qEhn52DmSS+xUvcavsOJtgnMGuAXtw0zCkssZ6lVotYTSj6Z7Y
	wbm0aX3gAow49uVrUD9x8+4dPMhFXs4WEXi1hOHT06otVBjDE/bYErWmBafmav8G6zDsa716l0K
	6LhB1jqKc3folE8PTPszTGeTA3hU+wLW3LasLINhA5ljwXSvaKZxN1OYW7u4H3c3GSmuENEMUIJ
	CC7zbjp56HvX+6BzhBAxOB3UNTvgOsFKmRmcG3rfStJnHsQ8a9CTJ1Kn91oU0X77ds3Cc8OUdqL
	1dmQ==
X-Google-Smtp-Source: AGHT+IGzml5f7C+H5Kt0Jq64zG4cgAy45VHUQatQ7Tr04zry1DUjTuhWBZAgrxnx7adjKMLqc/eW8Q==
X-Received: by 2002:a05:6e02:1f06:b0:3e2:9e9d:a978 with SMTP id e9e14a558f8ab-3e4161cef34mr112108265ab.21.1754193549778;
        Sat, 02 Aug 2025 20:59:09 -0700 (PDT)
Received: from frodo.raven-morpho.ts.net (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-50a55df0940sm2268319173.106.2025.08.02.20.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 20:59:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	quic_saipraka@quicinc.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	quic_psodagud@quicinc.com,
	maz@kernel.org,
	arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	mingo@redhat.com,
	jim.cromie@gmail.com
Subject: [PATCH v4 24/58] dyndbg: treat comma as a token separator
Date: Sat,  2 Aug 2025 21:57:42 -0600
Message-ID: <20250803035816.603405-25-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250803035816.603405-1-jim.cromie@gmail.com>
References: <20250803035816.603405-1-jim.cromie@gmail.com>
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
index 63a511f2337bc..e2dbb5d9b3144 100644
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
index f7c81a9140bd2..17651a8267567 100644
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
index 465fad3f392cc..c7bf521f36ee3 100755
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
2.50.1


