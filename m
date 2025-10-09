Return-Path: <linux-kernel+bounces-847313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F14BCA82F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C3E04FCB48
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EDF2F5A13;
	Thu,  9 Oct 2025 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1pDQOAA"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF792F3C16
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032758; cv=none; b=UGdRCbd3BuBuKetrDfAFmmSx6Xm4J4vcyQIvqyi9JQYc49B/wITPvDsaXsV8jhu26vqUF27f3mBX26DBK+Li0pJfKbwSsXvHKwLNt3G3piM5s7yTN5cLx1x8DNT1jXEGx+C2350IwfR86xRRuZEvnWHjmVTgtbsD9TTQLl96vis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032758; c=relaxed/simple;
	bh=IT6AUxG7GcxMyUFjCJ/sU+IvzOP9x5ns5pQZqWMN9dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIc6O6MyqHjJGVKQFATaKlw4mIKrXDWGLtU1kdL5lEYH05vEsA0SLadcoWsaHj+Hxk+L5QwFiNMFRyLAWpHTiWUXdbKOcdmfrqUicORRc6E4gd+9yiSxmEXNfs8vzZ6YAgmb9uLAWgZKxs/g2KHXf9snecaibmfEpcdqEkurt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1pDQOAA; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-92790f12293so54872639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032756; x=1760637556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5dZYlkWsj0ZEEitjTrF4YjoePePLbd6bheWS2OZneg=;
        b=a1pDQOAAGhiwCH4EVC6PyNEXpCs6CIoOx7N27DOiOei8mKfVUQoC3X6tk4msMXQ8ZL
         RvgXjUTBSa6o39GedFrKsBCqGAJCSxC7ClNAcKEHNNRRg5pPXsYxpbovGGRqMpJ4nVH6
         xVWQjv/+owkyCastwj3jWnlHeIJ6dt9dBZM+UJDQ+uRloFPeDupNPfbR8k38AyHzXTzU
         6dwth8CNhMmnr5GlfK3cH/rZYCWtPMm/uyaJENbLpOiHIISGmpZ7jjAzWl1NwOAhNiSE
         ym2pfMu26gISrFxu20utlMIG7smPu56cGYtqgEpRJKcoyCDaRIb3o3pc3vruJn+Q49Yf
         g3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032756; x=1760637556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5dZYlkWsj0ZEEitjTrF4YjoePePLbd6bheWS2OZneg=;
        b=s/bx2F3K72C4seBcpWZUWBPjYIXA5LBkj/7Ui4RuxJkahmW/u+UADVJx6bzZVgL1Dl
         Qb2Iq04h/8AOsWMEVHjDm5lPFRIRFVKn01fw0Rh1w4F+tMsk/gWaQaN3rPtKKPJ5D1aq
         y44KtprMDp6GIOCpOEVCC9ftjdkhypIRR2UDuHdNiPQ8lYKTLYeQ79pDyklWvedENSv+
         EGHtOOiK+96xClZxWzi5MifcwkyYX2GgJHjIqNaZaPrKKFGJXCNMsc7hgSbSwr76fOxH
         7DRT/3bqgybND/c3BmHfXBsLS0WPsiEohXnSNky42vrGmBUAfyfH2Z3QGVCF/TdwIinV
         JSIw==
X-Forwarded-Encrypted: i=1; AJvYcCXaRAixkY4k6qccg1IkqDc7BLNaiY1Dxf9OFsSeNBi6zCdfz/88NG7nrNoBXI5vFBQFXJdsc6O5fLMM8Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4VhcUGayKeLPfjcLeXFGnoCG1xyNrmq0cP87EcpKZ9bNLbqE0
	xlrXCMaBOcosfPSxJqLuGQfyxc3s5iL9k3fBj4C5LX89tvZ3RfowZiz+
X-Gm-Gg: ASbGncvnVwBisG+LkEB+soIzvA5V1LU+YhSV7JMCrsSqewYW5OcG/69btU1zJH/Mj9n
	51h7XZIYiTw73wjBx3aMudurjcvlv5o39gqXG0K8/Z8CeWvh93450B58qkYBLt6d6ZRVywIzhu+
	lxhv/EBYB24ed7dUzNug4hlsp5orQ8Yl4vTJ6pOr55Rg2I5OrPTFSCjxluA7KPYqL84iOQ4uGWf
	vXz4jIvv2R/BBlQJZtsKa6bN2d/ANOzvTdmMqzHhCBXp15v39Yoc32eS2b5YP1hkAOa4PEnijwV
	YhG7gP6sxA097g2eOsyBc653nwtqBatxoNE0T5Hv0+EbjgYEZSmJhey81q60YPm6hMalnm8i/Vu
	lUOUQni30ks9krzdLuFUaLjMMIxlHs4/bLLboOO+PYrX2OnKADjL+76GVGJhR3VqYZHYlstAqFI
	8PJitDSQ1KOcQM2fW1jEcwE50YzkHtgOD9tel7OA==
X-Google-Smtp-Source: AGHT+IHEWGVhtAuxACrF15TMBTJdVDkb5oi4cU4Syu6r807ljXBmyTG7+iiL0/3UAgEv3Zk1RERmEQ==
X-Received: by 2002:a05:6e02:348a:b0:42f:880a:cff7 with SMTP id e9e14a558f8ab-42f880ad12bmr87822445ab.13.1760032755551;
        Thu, 09 Oct 2025 10:59:15 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:59:15 -0700 (PDT)
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
Subject: [PATCH v5 26/30] dyndbg: split multi-query strings with %
Date: Thu,  9 Oct 2025 11:58:30 -0600
Message-ID: <20251009175834.1024308-27-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
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
index b05d186e78a1..5de74a1be4e5 100644
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


