Return-Path: <linux-kernel+bounces-773740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAC0B2A8AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8417687F54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B546261B9B;
	Mon, 18 Aug 2025 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/Eo1Zb0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2PMTLTq7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382221CC55
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525303; cv=none; b=CwI7va4n41IANOJyvSNMiIgY68Wlj6w3gbwhjLJA2PXM3FHdw/WuFvoYGfMl9mnFOZk72iaNKqaPyAu0u7giC5d4SNcU3Qkb56jpITDzauyuvhILn07DL6E2HofUMlJCeXMODg9ilUdH/iLcKaIXtbD/I9UzH+DNHko/ge8vylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525303; c=relaxed/simple;
	bh=0eCUlqAAsqJcNGUR1OnZEimZckJHmDPQMr7i0sDlfOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl2y++qV9ekeoa9un/pPjr9LL1pfRdaOkbTyj7Nk9J5CxlIPY9PlFXd/7oJrPOTxB/JtgiSq21lZSTEy1RAMUMYZphkl+36hWjZcDC3iszkhfrAedUpJ7DeVlT2GmJHiSMFh8VbZU4kMdsLMGffySwf2ficxnjoZEzRKGudKEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/Eo1Zb0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2PMTLTq7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 15:54:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755525300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9sw/LNj8FrRJkDdgvvdNZRPlm9O6QUXm10PZqzxzM4=;
	b=Y/Eo1Zb00jzjYyZwmEUO9+bWMM3WxhgdB7qgJtYQ9i98O1Ldp+nGebnTsUkXMJVzkG7T7f
	s5A8fkOnDjaM+tldFNFBRBJo2vv7E+PV1g46YlB5F8iTW+DU/GL1iUTCKk0jt1M3AhwT1k
	TIHDgxJd2RdPqZcU8u+hd4X0FqAi0sgwoP1Th8m00l3PvO0waPLEIxNpiFlEH+ClpFCRMs
	vIybQ+Un9fuDwh5mCKNHmkcOSXMAVT8ytExsnFUsp1kUcoBTwdEUmKG+bacrmRMSYDd13q
	CuPK2wiTtGT3C2sL9tKVw9O0ZAwnhiJON/eFdxBVik7RNlUf/x9AFmu3mUDzQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755525300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9sw/LNj8FrRJkDdgvvdNZRPlm9O6QUXm10PZqzxzM4=;
	b=2PMTLTq7uZOhLA8fv53FDc01p5knY4G7Tta3A/7QbmfKc4reJ03p+la/0UgTVhc2gArTiH
	5URM5Sk0eDgJbnBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2] selftests/futex: Compile also on libnuma < 2.0.16
Message-ID: <20250818135458.F352St6W@linutronix.de>
References: <202507150858.bedaf012-lkp@intel.com>
 <20250715075735.tdXLHcEA@linutronix.de>
 <20250715095203.vVbUIvob@linutronix.de>
 <87h5z5tq51.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87h5z5tq51.ffs@tglx>

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
v1=E2=80=A6v2:
   - typo in LIBNUMA fixed
   - avoid __maybe_unused

 .../selftests/futex/functional/Makefile       |  5 ++++-
 .../futex/functional/futex_numa_mpol.c        | 21 +++++++++----------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/test=
ing/selftests/futex/functional/Makefile
index 8cfb87f7f7c50..6f7887f585afb 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
+PKG_CONFIG ?=3D pkg-config
+LIBNUMA_TEST =3D $(shell sh -c "$(PKG_CONFIG) numa --atleast-version 2.0.1=
6 > /dev/null 2>&1 && echo SUFFICIENT || echo NO")
+
 INCLUDES :=3D -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS :=3D $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS :=3D $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES) -=
DLIBNUMA_VER_$(LIBNUMA_TEST)=3D1
 LDLIBS :=3D -lpthread -lrt -lnuma
=20
 LOCAL_HDRS :=3D \
diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/t=
ools/testing/selftests/futex/functional/futex_numa_mpol.c
index a9ecfb2d3932a..120ea7d5a3cf9 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -125,11 +125,6 @@ static void test_futex(void *futex_ptr, int must_fail)
 	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG |=
 FUTEX2_NUMA);
 }
=20
-static void test_futex_mpol(void *futex_ptr, int must_fail)
-{
-	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG |=
 FUTEX2_NUMA | FUTEX2_MPOL);
-}
-
 static void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
@@ -142,7 +137,7 @@ static void usage(char *prog)
 int main(int argc, char *argv[])
 {
 	struct futex32_numa *futex_numa;
-	int mem_size, i;
+	int mem_size;
 	void *futex_ptr;
 	int c;
=20
@@ -165,7 +160,7 @@ int main(int argc, char *argv[])
 	}
=20
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
=20
 	mem_size =3D sysconf(_SC_PAGE_SIZE);
 	futex_ptr =3D mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | =
MAP_ANONYMOUS, 0, 0);
@@ -201,8 +196,11 @@ int main(int argc, char *argv[])
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
@@ -221,15 +219,16 @@ int main(int argc, char *argv[])
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
2.50.1


