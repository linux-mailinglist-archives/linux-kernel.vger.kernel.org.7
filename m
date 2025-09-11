Return-Path: <linux-kernel+bounces-812894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED08DB53DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C8316CA83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2724934F489;
	Thu, 11 Sep 2025 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsiT5cvx"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B22329F2F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626756; cv=none; b=mXriOCkRXByfu1JXDUssy60ZbrDT/1ee3RyZ+76cn9E1ilvNB9FFnptVA6hl9SA8Jh/78rBJSO93CpxKN/cVFwc7rOZwaTdd2m4O2IpIwVDRQ3X+l6Q+58dtrvlGXNOdyQPErGgykJpLBJSPfnv/N3l4lccJnUcfmNWgyBFLZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626756; c=relaxed/simple;
	bh=kYBlYY7aBzrfpvv8jq0U5AckDZRqdPeLya7ULfnxf9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k62/2QzyyH5N3rl9jHvHSpjvn5lXDsikeA/JD/BaYSx0FSWuJKXYmgUbtNiV+ZHNHMOino6tXgO318wRDyrIwmA801V/EeHy5bKThhfYW/D6bXEIHpDKoXkqInhW0A4dpCnSdihmp5wfMrLFBc0IYacx3Z5KNaSV2EvD963dhcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsiT5cvx; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88776dcac7aso47976539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626754; x=1758231554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbFerO6UxPrQxcGjjPDKdFxV7+8kL7Wgw3cGfnE1Lz8=;
        b=UsiT5cvxQ1VapT2fzUt5WrpWo38N83HWIiSmx5YUv3jLidivhocb4Sja+EcUqDuNy4
         WLg7iL0sdeYDuKqC09+uvaZot8qJKHwuEvGwDVDmmvh7yaPMzkzf/eEyuAQnZ6a7NVyG
         CNlSa8Z7ZyF4HQ/5+m2fa2B0B01tJ6FDrq90O3232p55kw13V97n2sp8u9gNqPmtANAP
         nVcV2R9gRS1xm5TCooEUyK9HtuT7JDOVabDkjeMKI/tZiGtuEauGxmFb2J4Hnv4fs/Xc
         BU3KcBAjL8sXdzrOjNrebIvgW4E7f5GizGC3XOBBTVQwfYuAHu2WuiLAQc3RiIrHrDYh
         agaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626754; x=1758231554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbFerO6UxPrQxcGjjPDKdFxV7+8kL7Wgw3cGfnE1Lz8=;
        b=qumtVoP36Q27XtP5NHwdbiIN32FuSigy7Lq8yAi2f6sX472TXPhsV9HdCtiEqBCUGp
         OT1kwBRBSV+Xod0rAZmS91IDInUFj+/ep6nNbQq2gJOoat0+G8OMJlAH7hZNUqsFChLG
         BiLIF0coIT5HMiOM3juH3num+05rVz60ndlEndyuJxIp0ztDfokc9SHEVwbMXFnv+ohr
         V0q19Tt6GXodYL/of2xMkPHIVUzVuCbSaCz0ctX7WgmmpiomMADqon4/cuW3JZ/I1/mM
         q0POB/Xp12+nVEpkWGTQclQyHPFrP7xnR2vbUByHufPjY4eW2+T/8FAW0McEkLlDMTeZ
         lKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvrb9tUu1WXFVeeXM7fOMAP4DO8j2AYZyPYCuQHve4lAGmDhc4Y2pHRmiNSzx0xcBvXIeUUJIlz2oJ6mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrx6RlvR1gMRVhA+8fpjcwWXJ5cfeKdZMniiFb3Dxo2dMz2o8Q
	34pWclOqtedmfMrFY0oowinbxhe6UPRTCrw4S103Vqv9V7woI8lgfAHR
X-Gm-Gg: ASbGncv/eBbf9qzHj587OYlkIFIYkfr9ytIVwmRJ5KHWxhUUrsq0Z/NTtpsOZGWgiyq
	z8XOERohruHfg+sLRlj0VmkBBRcMEKTn8Jurtbz+bB1Bh4AoVFLoq7EyGsdsS8XqGaldZ2STSdg
	i+9dQDZZbiwNkNP4cgnOh2wha/Au8wDY6zfCrHb/p62c4cH1jMFmqucCMqXFgrw9jrrSQGwuq/6
	49qFXskbXm8VMA6idU+nR9x6jVCWnZ7D9PTcXTKLUvX/oYht9si4gd26P5yVBzfNFzgbIKAKP7k
	47AXwCuYVnucTgMHhFF0t7zV3QwQZ1Qj23F3hCIy7y4rxCN5esLPGlrSiaikeRNIIlHVjvqc30C
	5IiA3tN4sY/qD97Rqli1ojIYsI6WqWUVKMGqSrBOXvT+Gu/LAssP7lNoPKv7deXPc6BXUhrtOup
	9yNkjY/qnwjZvEzg==
X-Google-Smtp-Source: AGHT+IGIrMadyBnnytodYMBtXn/NVn8LrGaqu/QjA0Twm++Ed0Go98HFF+RGCwsUlB9+xXDB3VmH6w==
X-Received: by 2002:a5e:db07:0:b0:881:8a58:3bc2 with SMTP id ca18e2360f4ac-890350b77bfmr109855839f.6.1757626753623;
        Thu, 11 Sep 2025 14:39:13 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:39:13 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 26/30] dyndbg: split multi-query strings with %
Date: Thu, 11 Sep 2025 15:38:19 -0600
Message-ID: <20250911213823.374806-27-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911213823.374806-1-jim.cromie@gmail.com>
References: <20250911213823.374806-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit
85f7f6c0edb8 ("dynamic_debug: process multiple debug-queries on a line")

Multi-query commands have been allowed:

  modprobe drm dyndbg="class DRM_UT_CORE +p; class DRM_UT_KMS +p"
  modprobe drm dyndbg=<<EOX
     class DRM_UT_CORE +p
     class DRM_UT_KMS +p
  EOX

More recently, the need for quoting was avoided by treating a comma
like a space/token-terminator:

  modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

That works, but it needs the escaped semicolon, which is a shell
special-char (one of the bash control operators), so it is brittle
when passed in/down/around scripts.  In particular, it fails when
passed to vng (virtme-ng).

So this patch adds '%' to the existing ';' and '\n' multi-command
separators, which is more shell-friendly, so you can more fully avoid
quoting and escaping hassles.

NOTE: it does break format matching on '%' patterns:

bash-5.2# ddcmd 'format "find-me: %foo" +p'
[  203.900581] dyndbg: read 26 bytes from userspace
[  203.900883] dyndbg: query 0: "format "find-me: " mod:*
[  203.901118] dyndbg: unclosed quote: find-me:
[  203.901355] dyndbg: tokenize failed
[  203.901529] dyndbg: query 1: "foo" +p" mod:*
[  203.901957] dyndbg: split into words: "foo"" "+p"
[  203.902243] dyndbg: op='+' flags=0x1 maskp=0xffffffff
[  203.902458] dyndbg: expecting pairs of match-spec <value>
[  203.902703] dyndbg: query parse failed
[  203.902871] dyndbg: processed 2 queries, with 0 matches, 2 errs
bash: echo: write error: Invalid argument

The '%' splits the input into 2 queries, and both fail.  Given the
limited utility of matching against the working parts of a format
string "foo: %d bar %s", nothing is actually lost here.

selftests-dyndbg: test_percent_splitting

This does basic testing of classmaps using '%' separated
multi-queries.  It modprobes test_dynamic_debug with several classes
enabled, and counts to verify that the expected sites show the
enablement in the control file.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
-v3 squash feature, test, doc together
    gate new test, which needs test-dynamic-debug.ko

test-percent-escape
---
 .../admin-guide/dynamic-debug-howto.rst       |  8 ++++---
 lib/dynamic_debug.c                           |  2 +-
 .../dynamic_debug/dyndbg_selftest.sh          | 24 +++++++++++++++++++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index e2dbb5d9b314..1ceadf4f28f9 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -85,10 +85,12 @@ by spaces, tabs, or commas.  So these are all equivalent::
   :#> ddcmd '  file   svcsock.c     line  1603 +p  '
   :#> ddcmd file,svcsock.c,line,1603,+p
 
-Command submissions are bounded by a write() system call.
-Multiple commands can be written together, separated by ``;`` or ``\n``::
+Command submissions are bounded by a write() system call.  Multiple
+commands can be written together, separated by ``%``, ``;`` or ``\n``::
 
-  :#> ddcmd "func pnpacpi_get_resources +p; func pnp_assign_mem +p"
+  :#> ddcmd func foo +p % func bar +p
+  :#> ddcmd func foo +p \; func bar +p
+  :#> ddcmd "func foo +p ; func bar +p"
   :#> ddcmd <<"EOC"
   func pnpacpi_get_resources +p
   func pnp_assign_mem +p
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9cb2c95a0559..283d86115eba 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -605,7 +605,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	int i, errs = 0, exitcode = 0, rc, nfound = 0;
 
 	for (i = 0; query; query = split) {
-		split = strpbrk(query, ";\n");
+		split = strpbrk(query, "%;\n");
 		if (split)
 			*split++ = '\0';
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index c7bf521f36ee..513f6cb1db1d 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -256,9 +256,33 @@ function comma_terminator_tests {
     ddcmd =_
 }
 
+function test_percent_splitting {
+    echo -e "${GREEN}# TEST_PERCENT_SPLITTING - multi-command splitting on % ${NC}"
+    if [ $LACK_TMOD -eq 1 ]; then
+	echo "SKIP - test requires test-dynamic-debug.ko"
+	return
+    fi
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+    modprobe test_dynamic_debug dyndbg=class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+    check_match_ct test_dynamic_debug 23 -r
+    # add flags to those callsites
+    ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml
+    check_match_ct =pmf 1
+    check_match_ct =plt 1
+    check_match_ct =pml 1
+    check_match_ct test_dynamic_debug 23 -r
+    ifrmmod test_dynamic_debug
+}
+
 tests_list=(
     basic_tests
     comma_terminator_tests
+    test_percent_splitting
 )
 
 # Run tests
-- 
2.51.0


