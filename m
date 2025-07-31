Return-Path: <linux-kernel+bounces-752542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BB8B176EF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3667A5E68
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072FD253F38;
	Thu, 31 Jul 2025 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qh2OlH6R"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07973239E91
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992623; cv=none; b=U3LZfcK5/LCpTumNefPPzwl7Twj2Hk9WB61p3TUC8QucXeNnb9LzZvhTvvj66Pqwu55PT9lUdYpG4cjf95G6cfcoMB0+VeFHQWQqnrCEaoLsk+LJLpHF0OXGG8y7X/N6zpoERFNv7cdf9DmyzUW+g09li7e2wSDMEQWNUo6QI0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992623; c=relaxed/simple;
	bh=WxHeXqjT8Zn5BVhJpoljQ0LzCywOZf7PcfAXTNZ+ojE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rsEHyYKuOlGM/GQueXiSSlfnSctCHJk3ugqD5Hk3TuG3ycTqVkMHyZZklY5e6PrAhb7Mpnrx9W8/Kd7NzgZmfEP+PuI4wuTvasufFQoSQmcYW2mTQkOglhqzVBQUGerbxd/NmE4/VMXd8r0JbC4fONr8q+DQYfqYBv3if7xmKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sudarsanm.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qh2OlH6R; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sudarsanm.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3928ad6176so1262511a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753992621; x=1754597421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J09bJnyFyHUEqMAMcKAT+RUtJuszd341ngKo2pBlF9A=;
        b=qh2OlH6RA3WEFLqgdPIpXXXmlZXu9Ggt4zjXuR+U6ICybIavTyQaH1Bgm3p5uuJYca
         ysmDfqsa0E6YcGFb00ZPrHButkcWsMoKMc9DN124deKuc18ddi/a9Tc3w0IfK4tDK7Q/
         766YYct1AJ8GU0bqWopxodmSCpD7uczJmrBrLo6Jn7Lnc22SAXPsP5sBmeQTZMl8lUxM
         6kRa7aw6pzaWiuDdi/R58fbKl93GQKxWGfAIGz/hKkoJI4xRKh1GKUBzzyzuzIpIhpie
         U5Ucxg2395uK34ymxMDI3MxiqBW2wzgjUfMPJL8k9Pj7P1Nq5+5DU0kli5IDAcoEnBLt
         yJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753992621; x=1754597421;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J09bJnyFyHUEqMAMcKAT+RUtJuszd341ngKo2pBlF9A=;
        b=LgRTG82CfZt/jfOEDhr0gPu25dfXgRJISkzmC/FppTEj0mZv+Q5lFZSOLhLMRF+jxi
         04rRDavKWv2vfXEW5Myn+dtr483ewvatcz8LtTckHi4tIX8gxvbJ8yWnGaapb9o3hpSE
         XNYDQ0o+dqSwuHycMh6HUKFDM/PJhkXuG0ebxlsUdemj4bU7d4hV2Uu3xTIWslf7KOml
         ruuesTfS+YrFIfWIwsbTzQ4e67CMUfkJSPJi0/pNiSVBAJiAS6IzNLR7t2g+vGEn08Dc
         zYIJIHYu4fHiP4eYJiO6x6sIohAhfxx4Upn5/gQnwVCDjH+WUfs9FteLMuUxMI75R3uo
         amgA==
X-Forwarded-Encrypted: i=1; AJvYcCVhqyI5RnGniTsztCAa573whYzYyWzlrrkF6zRsAAu/9ViQIKwguxbQY4LPch1r6YgMTXxMVsp8FPAiNMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBXrayvf9+yQCGDtv3Uc+AxIsaxyJmO1OudqIoNKX07BOiEEHi
	p4IvA7ibwCBXEEZFEZCWFtzt+2xFl15jO89JdPBC0RfN5PRpWIU3EMXHBp5HlgZWhn3Qgr5x1Yl
	hPv4BJDsiA7NPqnG0+g==
X-Google-Smtp-Source: AGHT+IHgx/cYgrYinezSkOTAmAfU/9csyQH9piPDnBU/wf7uG2ssY6nBUVDU1MMbLwCPMAV4sTmBpXU9mwzHGbM=
X-Received: from pgng29.prod.google.com ([2002:a63:375d:0:b0:b31:d832:f7b0])
 (user=sudarsanm job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:8095:b0:23d:dcb9:d50d with SMTP id adf61e73a8af0-23ddcb9f6dcmr3837708637.25.1753992621200;
 Thu, 31 Jul 2025 13:10:21 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:10:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731201009.888945-1-sudarsanm@google.com>
Subject: [PATCH] selftests/mm: pass filename as input param to VM_PFNMAP tests
From: Sudarsan Mahendran <sudarsanm@google.com>
To: linux-kselftest@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	trivial@kernel.org, Sudarsan Mahendran <sudarsanm@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable these tests to be run on other pfnmap'ed memory like
NVIDIA's EGM.

Add '--' as a separator to pass in file path. This allows
passing of cmd line arguments to kselftest_harness.
Use '/dev/mem' as default filename.

Existing test passes:
	pfnmap
	TAP version 13
	1..6
	# Starting 6 tests from 1 test cases.
	# PASSED: 6 / 6 tests passed.
	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

Pass params to kselftest_harness:
	pfnmap -r pfnmap:mremap_fixed
	TAP version 13
	1..1
	# Starting 1 tests from 1 test cases.
	#  RUN           pfnmap.mremap_fixed ...
	#            OK  pfnmap.mremap_fixed
	ok 1 pfnmap.mremap_fixed
	# PASSED: 1 / 1 tests passed.
	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Pass random file name as input:
	pfnmap -- /dev/blah
	TAP version 13
	1..6
	# Starting 6 tests from 1 test cases.
	#  RUN           pfnmap.madvise_disallowed ...
	#      SKIP      Cannot open '/dev/blah'

Signed-off-by: Sudarsan Mahendran <sudarsanm@google.com>
---
 tools/testing/selftests/mm/pfnmap.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
index 866ac023baf5..2d4e8b165f91 100644
--- a/tools/testing/selftests/mm/pfnmap.c
+++ b/tools/testing/selftests/mm/pfnmap.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Basic VM_PFNMAP tests relying on mmap() of '/dev/mem'
+ * Basic VM_PFNMAP tests relying on mmap() of input file provided.
+ * Use '/dev/mem' as default.
  *
  * Copyright 2025, Red Hat, Inc.
  *
@@ -25,6 +26,7 @@
 #include "vm_util.h"
 
 static sigjmp_buf sigjmp_buf_env;
+static char *file = "/dev/mem";
 
 static void signal_handler(int sig)
 {
@@ -117,19 +119,19 @@ FIXTURE_SETUP(pfnmap)
 	if (find_ram_target(&self->phys_addr, self->pagesize))
 		SKIP(return, "Cannot find ram target in '/proc/iomem'\n");
 
-	self->dev_mem_fd = open("/dev/mem", O_RDONLY);
+	self->dev_mem_fd = open(file, O_RDONLY);
 	if (self->dev_mem_fd < 0)
-		SKIP(return, "Cannot open '/dev/mem'\n");
+		SKIP(return, "Cannot open '%s'\n", file);
 
 	self->size1 = self->pagesize * 2;
 	self->addr1 = mmap(NULL, self->size1, PROT_READ, MAP_SHARED,
 			   self->dev_mem_fd, self->phys_addr);
 	if (self->addr1 == MAP_FAILED)
-		SKIP(return, "Cannot mmap '/dev/mem'\n");
+		SKIP(return, "Cannot mmap '%s'\n", file);
 
 	/* ... and want to be able to read from them. */
 	if (test_read_access(self->addr1, self->size1, self->pagesize))
-		SKIP(return, "Cannot read-access mmap'ed '/dev/mem'\n");
+		SKIP(return, "Cannot read-access mmap'ed '%s'\n", file);
 
 	self->size2 = 0;
 	self->addr2 = MAP_FAILED;
@@ -246,4 +248,14 @@ TEST_F(pfnmap, fork)
 	ASSERT_EQ(ret, 0);
 }
 
-TEST_HARNESS_MAIN
+int main(int argc, char **argv)
+{
+	for (int i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "--") == 0) {
+			if (i + 1 < argc && strlen(argv[i + 1]) > 0)
+				file = argv[i + 1];
+			return test_harness_run(i, argv);
+		}
+	}
+	return test_harness_run(argc, argv);
+}
-- 
2.50.1.565.gc32cd1483b-goog


