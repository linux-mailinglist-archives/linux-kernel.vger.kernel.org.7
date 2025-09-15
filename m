Return-Path: <linux-kernel+bounces-817800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69813B586B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1500C7B295A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A141F2C11C6;
	Mon, 15 Sep 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MgHBPEv7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fHXffJKs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0DD2C028A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971599; cv=none; b=dlMXuEpH0mbyLb8RRVUUVQG2+KS2Aah6B1PuQCWq7h3pw9NNfZrK0dgSaHlwv6ELhMCCA2N5BCgYfGck8Q8piyh7j+/PSOnGfhuwIsMFzJxaWiFk7LFrVtoyMEA6pAQuWrqPNqXHGS2qfmj6vEgZYMp8quEVUF9FKE2HwaXmWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971599; c=relaxed/simple;
	bh=dr922krkn3hTKNerCcihi/Uwzwm+Q3m5iVVRm+3rbJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kceIKw2Xyhxo+i2rCCfDEIrts/L85F+s/lXk6ukB1hRXTjQsPAHqsisqPQb9qD4iDaDg2kKhrkOHdakPoj7CdzoaZL63IArbnky0j+SwLu6T1zbQhxe6hXoB0+FY7Wbz/xO0vprewiQXCaF67vEjpCJoHBYjfkM2P+O/8OC9bgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MgHBPEv7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fHXffJKs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757971595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lncqhFfIQHgTUezFqndTiqcMxgd5BZtZaRBFHNPNwhs=;
	b=MgHBPEv7SFoKvsb4sJDQlDGUL9FuOXEb7jeNmF6ZQioAt7C7Bkguzn3db1pLVc0aUUw91h
	7QFybSeBmIeKU74wqMFpgXWEzDTd8h2ZrabDnSPcrLrXyHQQuf+BmBhEIgTOboPci8YeuH
	si6SEYUeqi2pbhlYpsHI5r3ZANrqOykayz7Drf1MktD4lEuqVsfOh5Q+KOXvhKaMaYLnst
	X2CepdvkrZv0GeM1i//bFhuPL4C2oyKqXHJ9zUrlIQkYV/HDmLoaVMfnvALgKQ+k3hwBNX
	DYfWecYeDtDpslY//XYT6/5SX9xj7f/JV+G2ljMHqy0yheL2ntnJAFnogPbXCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757971595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lncqhFfIQHgTUezFqndTiqcMxgd5BZtZaRBFHNPNwhs=;
	b=fHXffJKsDBYx4L61k/7n2IDXVcU2FmSnc1M7HKHPFrNW1AGshGMvY0pNIcL1nriKLW7wGs
	C1AHPbL3MXZzNOCA==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 3/3] selftest/futex: Compile also with libnuma < 2.0.16
Date: Mon, 15 Sep 2025 23:26:30 +0200
Message-ID: <20250915212630.965328-4-bigeasy@linutronix.de>
In-Reply-To: <20250915212630.965328-1-bigeasy@linutronix.de>
References: <20250915212630.965328-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

Fixes: 0ecb4232fc65e ("selftests/futex: Set the home_node in futex_numa_mpo=
l")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202507150858.bedaf012-lkp@intel.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../selftests/futex/functional/Makefile       |  5 ++++-
 .../futex/functional/futex_numa_mpol.c        | 21 +++++++++----------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/test=
ing/selftests/futex/functional/Makefile
index ddfa61d857b9b..bd50aecfca8a3 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
+PKG_CONFIG ?=3D pkg-config
+LIBNUMA_TEST =3D $(shell sh -c "$(PKG_CONFIG) numa --atleast-version 2.0.1=
6 > /dev/null 2>&1 && echo SUFFICIENT || echo NO")
+
 INCLUDES :=3D -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS :=3D $(CFLAGS) -g -O2 -Wall -pthread -D_FILE_OFFSET_BITS=3D64 -D_TI=
ME_BITS=3D64 $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS :=3D $(CFLAGS) -g -O2 -Wall -pthread -D_FILE_OFFSET_BITS=3D64 -D_TI=
ME_BITS=3D64 $(INCLUDES) $(KHDR_INCLUDES) -DLIBNUMA_VER_$(LIBNUMA_TEST)=3D1
 LDLIBS :=3D -lpthread -lrt -lnuma
=20
 LOCAL_HDRS :=3D \
diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/t=
ools/testing/selftests/futex/functional/futex_numa_mpol.c
index 5f4e3111269c3..722427fe90bf0 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -131,11 +131,6 @@ static void test_futex(void *futex_ptr, int err_value)
 	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG |=
 FUTEX2_NUMA);
 }
=20
-static void test_futex_mpol(void *futex_ptr, int err_value)
-{
-	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG |=
 FUTEX2_NUMA | FUTEX2_MPOL);
-}
-
 static void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
@@ -148,7 +143,7 @@ static void usage(char *prog)
 int main(int argc, char *argv[])
 {
 	struct futex32_numa *futex_numa;
-	int mem_size, i;
+	int mem_size;
 	void *futex_ptr;
 	int c;
=20
@@ -171,7 +166,7 @@ int main(int argc, char *argv[])
 	}
=20
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
=20
 	mem_size =3D sysconf(_SC_PAGE_SIZE);
 	futex_ptr =3D mmap(NULL, mem_size * 2, PROT_READ | PROT_WRITE, MAP_PRIVAT=
E | MAP_ANONYMOUS, 0, 0);
@@ -211,8 +206,11 @@ int main(int argc, char *argv[])
 	ksft_print_msg("Memory back to RW\n");
 	test_futex(futex_ptr, 0);
=20
+	ksft_test_result_pass("futex2 memory boundarie tests passed\n");
+
 	/* MPOL test. Does not work as expected */
-	for (i =3D 0; i < 4; i++) {
+#ifdef LIBNUMA_VER_SUFFICIENT
+	for (int i =3D 0; i < 4; i++) {
 		unsigned long nodemask;
 		int ret;
=20
@@ -231,15 +229,16 @@ int main(int argc, char *argv[])
 			ret =3D futex2_wake(futex_ptr, 0, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG =
| FUTEX2_NUMA | FUTEX2_MPOL);
 			if (ret < 0)
 				ksft_test_result_fail("Failed to wake 0 with MPOL: %m\n");
-			if (0)
-				test_futex_mpol(futex_numa, 0);
 			if (futex_numa->numa !=3D i) {
 				ksft_exit_fail_msg("Returned NUMA node is %d expected %d\n",
 						   futex_numa->numa, i);
 			}
 		}
 	}
-	ksft_test_result_pass("NUMA MPOL tests passed\n");
+	ksft_test_result_pass("futex2 MPOL hints test passed\n");
+#else
+	ksft_test_result_skip("futex2 MPOL hints test requires libnuma 2.0.16+\n"=
);
+#endif
 	ksft_finished();
 	return 0;
 }
--=20
2.51.0


