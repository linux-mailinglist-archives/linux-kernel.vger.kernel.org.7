Return-Path: <linux-kernel+bounces-731608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0744B0571B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C337B9061
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBE42D77E0;
	Tue, 15 Jul 2025 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dkF8WAD8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ze2PkYdD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC982D4B75
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573129; cv=none; b=aoK5UlMRyjkslFC0AEp+LQbRgYQA/9qBwwwKWHjBMI+R44Uh2FbIfkvGNDgcDuRIxCz5/9xRDkhF7+cDO+lKtAZxWLJYqqiTRcRV5L8ETfZp9xUU2SPLzoOSjV8aWam5uHS7cKT+BoZWu2sYNnqpLWelUmKtNCiLLE0i0xrZ2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573129; c=relaxed/simple;
	bh=Pvu2GOQUgiIM1fbnkHfoqhS3pz1LWxB7+bpqqL/aWjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTWE9guVDrCPnMSaWW46W94UFDhDT/YHiayXRZoBUT9ncbXwVUqhmxJjXmJYgNlLRvaE4NYI3dZm/IX9ETojaT4CGCX1zoGv4uFct5cN6PrUhxbECQUts9Sm2D+EzDhNywIQGpNw5ejIPA4yb1tpYTfKyWaDx8lqJaBPE7wK+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dkF8WAD8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ze2PkYdD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Jul 2025 11:52:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752573125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2VhGgw4/UqaaNBtcG5mDVpUZmR3y2iF9PATwl4kf07g=;
	b=dkF8WAD8UAZySvzxC52TNg9OMSL6ZvuQDKdBmz674G0DQTryLyUpe+Z2b6aqyMk0FkITIa
	WC4SXRwHvP9r3Z2OqPDJ+lq+Umt1FuRKEe4rl3w4RNO7BqkxATx5GDiYM/gJRdErT4MaN6
	RdJ9bMI4Yn/EIAP18fzWzwjZZ2+N7i/Olza5+b+wIy+aJToMRk1BKYM9jSPmJ2jpWY4lW0
	pPHQaS+anIqKZzm5O5vQ1sQz4fNkmizmEOy3I3i1P9zXEBsddCrSZGLBTrMi0mimP7uvjW
	TSWHowreqs71oirUhhUaRzZ1nuE1ID0tUNgR+VgmjYdrWFPy470Y41j+9McHSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752573125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2VhGgw4/UqaaNBtcG5mDVpUZmR3y2iF9PATwl4kf07g=;
	b=Ze2PkYdDzj3kpPZbcsSfBlY2Rrh9c96RTc0eTzsnyBsz58ETVDkYA/aavfa5CsVitxNNgR
	dxv6NMor+X8bRhBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] selftests/futex: Compile also on libnuma < 2.0.16
Message-ID: <20250715095203.vVbUIvob@linutronix.de>
References: <202507150858.bedaf012-lkp@intel.com>
 <20250715075735.tdXLHcEA@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715075735.tdXLHcEA@linutronix.de>

After using numa_set_mempolicy_home_node() the test fails to compile on
systems with libnuma library versioned lower than 2.0.16.

In order to allow lower library version add a pkg-config related check
and exclude that part of the code. Without the proper MPOL setup it
can't be tested.

Make a total number of tests two. The first one is the first batch and
the second is the MPOL related one. The goal is to let the user know if
it has been skipped due to library limitation.

Remove test_futex_mpol(), it was unused and it is now complained by the
compiler if the part is not compiled.

Mark the variable i __maybe_unused since the compiler now complains if
the MPOL tests are not compiled.

Fixes: 0ecb4232fc65e ("selftests/futex: Set the home_node in futex_numa_mpol")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202507150858.bedaf012-lkp@intel.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../selftests/futex/functional/Makefile       |  5 ++++-
 .../futex/functional/futex_numa_mpol.c        | 21 ++++++++++---------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 8cfb87f7f7c50..361631828629c 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
+PKG_CONFIG ?= pkg-config
+LIBNUMA_TEST = $(shell sh -c "$(PKG_CONFIG) numa --atleast-version 2.0.16 > /dev/null 2>&1 && echo SUFFICIENT || echo NO")
+
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES) -DLIBUNMA_VER_$(LIBNUMA_TEST)=1
 LDLIBS := -lpthread -lrt -lnuma
 
 LOCAL_HDRS := \
diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index a9ecfb2d3932a..a8af1657da083 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -22,6 +22,8 @@
 
 #define MAX_THREADS	64
 
+#define __maybe_unused __attribute__((__unused__))
+
 static pthread_barrier_t barrier_main;
 static pthread_t threads[MAX_THREADS];
 
@@ -125,11 +127,6 @@ static void test_futex(void *futex_ptr, int must_fail)
 	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
 }
 
-static void test_futex_mpol(void *futex_ptr, int must_fail)
-{
-	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
-}
-
 static void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
@@ -142,7 +139,7 @@ static void usage(char *prog)
 int main(int argc, char *argv[])
 {
 	struct futex32_numa *futex_numa;
-	int mem_size, i;
+	int mem_size, i __maybe_unused;
 	void *futex_ptr;
 	int c;
 
@@ -165,7 +162,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
 
 	mem_size = sysconf(_SC_PAGE_SIZE);
 	futex_ptr = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
@@ -201,7 +198,10 @@ int main(int argc, char *argv[])
 	ksft_print_msg("Memory back to RW\n");
 	test_futex(futex_ptr, 0);
 
+	ksft_test_result_pass("futex2 memory boundarie tests passed\n");
+
 	/* MPOL test. Does not work as expected */
+#ifdef LIBUNMA_VER_SUFFICIENT
 	for (i = 0; i < 4; i++) {
 		unsigned long nodemask;
 		int ret;
@@ -221,15 +221,16 @@ int main(int argc, char *argv[])
 			ret = futex2_wake(futex_ptr, 0, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
 			if (ret < 0)
 				ksft_test_result_fail("Failed to wake 0 with MPOL: %m\n");
-			if (0)
-				test_futex_mpol(futex_numa, 0);
 			if (futex_numa->numa != i) {
 				ksft_exit_fail_msg("Returned NUMA node is %d expected %d\n",
 						   futex_numa->numa, i);
 			}
 		}
 	}
-	ksft_test_result_pass("NUMA MPOL tests passed\n");
+	ksft_test_result_pass("futex2 MPOL hints test passed\n");
+#else
+	ksft_test_result_skip("futex2 MPOL hints. Reqiuire libnuma 2.0.16+\n");
+#endif
 	ksft_finished();
 	return 0;
 }
-- 
2.50.0


