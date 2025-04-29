Return-Path: <linux-kernel+bounces-625775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD29AA1C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 22:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFA6466668
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 20:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C07626B0B6;
	Tue, 29 Apr 2025 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDxaTlWx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A726A098;
	Tue, 29 Apr 2025 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745960113; cv=none; b=eVirJoeLkxHO041dhXcO1lrewk4hql5g0U+OP2i4aARMqYWTOLtJkFDbYJqhXk10q3qBfhWXatN2MEu2lVNSe7gOKzAUlK22/8uziwsFPAnkKZgS5Km6k8cIIZ5iXg3aonvm98Tm1P5ReqzZ/nE/6R6TH4wLCvZkWPNc7w8LvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745960113; c=relaxed/simple;
	bh=/0y9zIkkW34EpalpBx+Fh5N+gon4XwsxX9BRUZVHh6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8k8p6GjpjuVcbX05oQ55nYM7h1eztgrwrTcBtev+khovCuWnTPrF5FHowQFRTFPVWBEl9kXWh/x+Y6nXO131f5MydAwAsMMDecoOqst/xFBt/yPIP96YqxsCxf19XIVQ/8RBK2X/SDj5ot1vRut0YaFovBhUuLU0RrjWRPuepg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDxaTlWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E24C4CEEA;
	Tue, 29 Apr 2025 20:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745960112;
	bh=/0y9zIkkW34EpalpBx+Fh5N+gon4XwsxX9BRUZVHh6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDxaTlWx3JI48XY61I/G60SGkwr7wdysTInoEQFzlMRAn3At1LETu15LRZtkeuirn
	 8EcmEAUROgyjsn9NycGx+4KGPOYTHfA/KYCI0tT3YRT6iwp4Mmd5GXwnB3dKRQsFfS
	 DUoNlfZowAeOGcomfSH++sP3HK9i8jF3vntq99BGuKJs8i/az70MpC15vhew/7KZrk
	 pNtI7k9p2IsqeYjuIE8jv2y0zbOEfcB5e7MfO5wl5jNMtkCm+xItneQenopkef1BgA
	 MJN+NcuBZewH5GnJ3oseEy3to/gJxNPiOEM1/y3nchqqJQyDeO9qkjG84iGBsyX//o
	 KX+S+YBCYXwFQ==
Date: Tue, 29 Apr 2025 17:55:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Mario <jmario@redhat.com>,
	Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v4 4/4] perf test amd ibs: Add sample period unit test
Message-ID: <aBE8raTOCVZLfw7J@x1>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
 <20250429035938.1301-5-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429035938.1301-5-ravi.bangoria@amd.com>

On Tue, Apr 29, 2025 at 03:59:38AM +0000, Ravi Bangoria wrote:
> IBS Fetch and IBS Op PMUs has various constraints on supported sample
> periods. Add perf unit tests to test those.
> 
> Running it in parallel with other tests causes intermittent failures.
> Mark it exclusive to force it to run sequentially. Sample output on a
> Zen5 machine:

I've applied the series and will test it now, but found some problems
when building in some non-glibc systems, namely the use of PAGE_SIZE,
that is used in libc headers, even in glibc, its just that in glibc we
happen not to include that header where PAGE_SIZE gets redefined:

⬢ [acme@toolbx perf-tools-next]$ grep PAGE_SIZE /usr/include/sys/*.h
/usr/include/sys/user.h:#define PAGE_SIZE		(1UL << PAGE_SHIFT)
/usr/include/sys/user.h:#define PAGE_MASK		(~(PAGE_SIZE-1))
/usr/include/sys/user.h:#define NBPG			PAGE_SIZE
⬢ [acme@toolbx perf-tools-next]$

So I folded the following patch, see if it is acceptable and please ack.

Thanks for respining it!

- Arnaldo

diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch/x86/tests/amd-ibs-period.c
index 0cf3656e4b9bdacf..946b0a377554fb81 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-period.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
@@ -17,13 +17,13 @@
 #include "strbuf.h"
 #include "../util/env.h"
 
-#define PAGE_SIZE               sysconf(_SC_PAGESIZE)
+static int page_size;
 
 #define PERF_MMAP_DATA_PAGES    32L
-#define PERF_MMAP_DATA_SIZE     (PERF_MMAP_DATA_PAGES * PAGE_SIZE)
+#define PERF_MMAP_DATA_SIZE     (PERF_MMAP_DATA_PAGES * page_size)
 #define PERF_MMAP_DATA_MASK     (PERF_MMAP_DATA_SIZE - 1)
 #define PERF_MMAP_TOTAL_PAGES   (PERF_MMAP_DATA_PAGES + 1)
-#define PERF_MMAP_TOTAL_SIZE    (PERF_MMAP_TOTAL_PAGES * PAGE_SIZE)
+#define PERF_MMAP_TOTAL_SIZE    (PERF_MMAP_TOTAL_PAGES * page_size)
 
 #define rmb()                   asm volatile("lfence":::"memory")
 
@@ -59,15 +59,15 @@ static int dummy_workload_1(unsigned long count)
 		0xcc, /* int 3 */
 	};
 
-	p = zalloc(2 * PAGE_SIZE);
+	p = zalloc(2 * page_size);
 	if (!p) {
 		printf("malloc() failed. %m");
 		return 1;
 	}
 
-	func = (void *)((unsigned long)(p + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1));
+	func = (void *)((unsigned long)(p + page_size - 1) & ~(page_size - 1));
 
-	ret = mprotect(func, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC);
+	ret = mprotect(func, page_size, PROT_READ | PROT_WRITE | PROT_EXEC);
 	if (ret) {
 		printf("mprotect() failed. %m");
 		goto out;
@@ -150,7 +150,7 @@ static int rb_read(struct perf_event_mmap_page *rb, void *dest, size_t size)
 	unsigned long data_tail, data_head;
 
 	/* Casting to (void *) is needed. */
-	base = (void *)rb + PAGE_SIZE;
+	base = (void *)rb + page_size;
 
 	data_head = rb->data_head;
 	rmb();
@@ -918,6 +918,8 @@ int test__amd_ibs_period(struct test_suite *test __maybe_unused,
 	char perf[PATH_MAX] = {'\0'};
 	int ret = TEST_OK;
 
+	page_size = sysconf(_SC_PAGESIZE);
+
 	/*
 	 * Reading perf_event_max_sample_rate only once _might_ cause some
 	 * of the test to fail if kernel changes it after reading it here.
 
> Without kernel fixes:
> 
>   $ sudo ./perf test -vv 112
>   112: AMD IBS sample period:
>   --- start ---
>   test child forked, pid 8774
>   Using CPUID AuthenticAMD-26-2-1
> 
>   IBS config tests:
>   -----------------
>   Fetch PMU tests:
>   0xffff            : Ok   (nr samples: 1078)
>   0x1000            : Ok   (nr samples: 17030)
>   0xff              : Ok   (nr samples: 41068)
>   0x1               : Ok   (nr samples: 40543)
>   0x0               : Ok
>   0x10000           : Ok
>   Op PMU tests:
>   0x0               : Ok
>   0x1               : Fail
>   0x8               : Fail
>   0x9               : Ok   (nr samples: 40543)
>   0xf               : Ok   (nr samples: 40543)
>   0x1000            : Ok   (nr samples: 18736)
>   0xffff            : Ok   (nr samples: 1168)
>   0x10000           : Ok
>   0x100000          : Fail (nr samples: 14)
>   0xf00000          : Fail (nr samples: 1)
>   0xf0ffff          : Fail (nr samples: 1)
>   0x1f0ffff         : Fail (nr samples: 1)
>   0x7f0ffff         : Fail (nr samples: 0)
>   0x8f0ffff         : Ok
>   0x17f0ffff        : Ok
> 
>   IBS sample period constraint tests:
>   -----------------------------------
>   Fetch PMU test:
>   freq 0, sample_freq         0: Ok
>   freq 0, sample_freq         1: Fail
>   freq 0, sample_freq        15: Fail
>   freq 0, sample_freq        16: Ok   (nr samples: 1604)
>   freq 0, sample_freq        17: Ok   (nr samples: 1604)
>   freq 0, sample_freq       143: Ok   (nr samples: 1604)
>   freq 0, sample_freq       144: Ok   (nr samples: 1604)
>   freq 0, sample_freq       145: Ok   (nr samples: 1604)
>   freq 0, sample_freq      1234: Ok   (nr samples: 1566)
>   freq 0, sample_freq      4103: Ok   (nr samples: 1119)
>   freq 0, sample_freq     65520: Ok   (nr samples: 2264)
>   freq 0, sample_freq     65535: Ok   (nr samples: 2263)
>   freq 0, sample_freq     65552: Ok   (nr samples: 1166)
>   freq 0, sample_freq   8388607: Ok   (nr samples: 268)
>   freq 0, sample_freq 268435455: Ok   (nr samples: 8)
>   freq 1, sample_freq         0: Ok
>   freq 1, sample_freq         1: Ok   (nr samples: 4)
>   freq 1, sample_freq        15: Ok   (nr samples: 4)
>   freq 1, sample_freq        16: Ok   (nr samples: 4)
>   freq 1, sample_freq        17: Ok   (nr samples: 4)
>   freq 1, sample_freq       143: Ok   (nr samples: 5)
>   freq 1, sample_freq       144: Ok   (nr samples: 5)
>   freq 1, sample_freq       145: Ok   (nr samples: 5)
>   freq 1, sample_freq      1234: Ok   (nr samples: 7)
>   freq 1, sample_freq      4103: Ok   (nr samples: 35)
>   freq 1, sample_freq     65520: Ok   (nr samples: 642)
>   freq 1, sample_freq     65535: Ok   (nr samples: 636)
>   freq 1, sample_freq     65552: Ok   (nr samples: 651)
>   freq 1, sample_freq   8388607: Ok
>   Op PMU test:
>   freq 0, sample_freq         0: Ok
>   freq 0, sample_freq         1: Fail
>   freq 0, sample_freq        15: Fail
>   freq 0, sample_freq        16: Fail
>   freq 0, sample_freq        17: Fail
>   freq 0, sample_freq       143: Fail
>   freq 0, sample_freq       144: Ok   (nr samples: 1604)
>   freq 0, sample_freq       145: Ok   (nr samples: 1604)
>   freq 0, sample_freq      1234: Ok   (nr samples: 1604)
>   freq 0, sample_freq      4103: Ok   (nr samples: 1604)
>   freq 0, sample_freq     65520: Ok   (nr samples: 2227)
>   freq 0, sample_freq     65535: Ok   (nr samples: 2296)
>   freq 0, sample_freq     65552: Ok   (nr samples: 2213)
>   freq 0, sample_freq   8388607: Ok   (nr samples: 250)
>   freq 0, sample_freq 268435455: Ok   (nr samples: 8)
>   freq 1, sample_freq         0: Ok
>   freq 1, sample_freq         1: Fail (nr samples: 4)
>   freq 1, sample_freq        15: Fail (nr samples: 4)
>   freq 1, sample_freq        16: Fail (nr samples: 4)
>   freq 1, sample_freq        17: Fail (nr samples: 4)
>   freq 1, sample_freq       143: Fail (nr samples: 5)
>   freq 1, sample_freq       144: Fail (nr samples: 5)
>   freq 1, sample_freq       145: Fail (nr samples: 5)
>   freq 1, sample_freq      1234: Fail (nr samples: 8)
>   freq 1, sample_freq      4103: Fail (nr samples: 33)
>   freq 1, sample_freq     65520: Fail (nr samples: 546)
>   freq 1, sample_freq     65535: Fail (nr samples: 544)
>   freq 1, sample_freq     65552: Fail (nr samples: 555)
>   freq 1, sample_freq   8388607: Ok
> 
>   IBS ioctl() tests:
>   ------------------
>   Fetch PMU tests
>   ioctl(period = 0x0      ): Ok
>   ioctl(period = 0x1      ): Fail
>   ioctl(period = 0xf      ): Fail
>   ioctl(period = 0x10     ): Ok
>   ioctl(period = 0x11     ): Fail
>   ioctl(period = 0x1f     ): Fail
>   ioctl(period = 0x20     ): Ok
>   ioctl(period = 0x80     ): Ok
>   ioctl(period = 0x8f     ): Fail
>   ioctl(period = 0x90     ): Ok
>   ioctl(period = 0x91     ): Fail
>   ioctl(period = 0x100    ): Ok
>   ioctl(period = 0xfff0   ): Ok
>   ioctl(period = 0xffff   ): Fail
>   ioctl(period = 0x10000  ): Ok
>   ioctl(period = 0x1fff0  ): Ok
>   ioctl(period = 0x1fff5  ): Fail
>   ioctl(freq   = 0x0      ): Ok
>   ioctl(freq   = 0x1      ): Ok
>   ioctl(freq   = 0xf      ): Ok
>   ioctl(freq   = 0x10     ): Ok
>   ioctl(freq   = 0x11     ): Ok
>   ioctl(freq   = 0x1f     ): Ok
>   ioctl(freq   = 0x20     ): Ok
>   ioctl(freq   = 0x80     ): Ok
>   ioctl(freq   = 0x8f     ): Ok
>   ioctl(freq   = 0x90     ): Ok
>   ioctl(freq   = 0x91     ): Ok
>   ioctl(freq   = 0x100    ): Ok
>   Op PMU tests
>   ioctl(period = 0x0      ): Ok
>   ioctl(period = 0x1      ): Fail
>   ioctl(period = 0xf      ): Fail
>   ioctl(period = 0x10     ): Fail
>   ioctl(period = 0x11     ): Fail
>   ioctl(period = 0x1f     ): Fail
>   ioctl(period = 0x20     ): Fail
>   ioctl(period = 0x80     ): Fail
>   ioctl(period = 0x8f     ): Fail
>   ioctl(period = 0x90     ): Ok
>   ioctl(period = 0x91     ): Fail
>   ioctl(period = 0x100    ): Ok
>   ioctl(period = 0xfff0   ): Ok
>   ioctl(period = 0xffff   ): Fail
>   ioctl(period = 0x10000  ): Ok
>   ioctl(period = 0x1fff0  ): Ok
>   ioctl(period = 0x1fff5  ): Fail
>   ioctl(freq   = 0x0      ): Ok
>   ioctl(freq   = 0x1      ): Ok
>   ioctl(freq   = 0xf      ): Ok
>   ioctl(freq   = 0x10     ): Ok
>   ioctl(freq   = 0x11     ): Ok
>   ioctl(freq   = 0x1f     ): Ok
>   ioctl(freq   = 0x20     ): Ok
>   ioctl(freq   = 0x80     ): Ok
>   ioctl(freq   = 0x8f     ): Ok
>   ioctl(freq   = 0x90     ): Ok
>   ioctl(freq   = 0x91     ): Ok
>   ioctl(freq   = 0x100    ): Ok
> 
>   IBS freq (negative) tests:
>   --------------------------
>   freq 1, sample_freq 200000: Fail
> 
>   IBS L3MissOnly test: (takes a while)
>   --------------------
>   Fetch L3MissOnly: Fail (nr_samples: 1213)
>   Op L3MissOnly:    Ok   (nr_samples: 1193)
>   ---- end(-1) ----
>   112: AMD IBS sample period                                           : FAILED!
> 
> With kernel fixes:
> 
>   $ sudo ./perf test -vv 112
>   112: AMD IBS sample period:
>   --- start ---
>   test child forked, pid 6939
>   Using CPUID AuthenticAMD-26-2-1
> 
>   IBS config tests:
>   -----------------
>   Fetch PMU tests:
>   0xffff            : Ok   (nr samples: 969)
>   0x1000            : Ok   (nr samples: 15540)
>   0xff              : Ok   (nr samples: 40555)
>   0x1               : Ok   (nr samples: 40543)
>   0x0               : Ok
>   0x10000           : Ok
>   Op PMU tests:
>   0x0               : Ok
>   0x1               : Ok
>   0x8               : Ok
>   0x9               : Ok   (nr samples: 40543)
>   0xf               : Ok   (nr samples: 40543)
>   0x1000            : Ok   (nr samples: 19156)
>   0xffff            : Ok   (nr samples: 1169)
>   0x10000           : Ok
>   0x100000          : Ok   (nr samples: 1151)
>   0xf00000          : Ok   (nr samples: 76)
>   0xf0ffff          : Ok   (nr samples: 73)
>   0x1f0ffff         : Ok   (nr samples: 33)
>   0x7f0ffff         : Ok   (nr samples: 10)
>   0x8f0ffff         : Ok
>   0x17f0ffff        : Ok
> 
>   IBS sample period constraint tests:
>   -----------------------------------
>   Fetch PMU test:
>   freq 0, sample_freq         0: Ok
>   freq 0, sample_freq         1: Ok
>   freq 0, sample_freq        15: Ok
>   freq 0, sample_freq        16: Ok   (nr samples: 1203)
>   freq 0, sample_freq        17: Ok   (nr samples: 1604)
>   freq 0, sample_freq       143: Ok   (nr samples: 1604)
>   freq 0, sample_freq       144: Ok   (nr samples: 1604)
>   freq 0, sample_freq       145: Ok   (nr samples: 1604)
>   freq 0, sample_freq      1234: Ok   (nr samples: 1604)
>   freq 0, sample_freq      4103: Ok   (nr samples: 1343)
>   freq 0, sample_freq     65520: Ok   (nr samples: 2254)
>   freq 0, sample_freq     65535: Ok   (nr samples: 2136)
>   freq 0, sample_freq     65552: Ok   (nr samples: 1158)
>   freq 0, sample_freq   8388607: Ok   (nr samples: 257)
>   freq 0, sample_freq 268435455: Ok   (nr samples: 8)
>   freq 1, sample_freq         0: Ok
>   freq 1, sample_freq         1: Ok   (nr samples: 4)
>   freq 1, sample_freq        15: Ok   (nr samples: 4)
>   freq 1, sample_freq        16: Ok   (nr samples: 4)
>   freq 1, sample_freq        17: Ok   (nr samples: 4)
>   freq 1, sample_freq       143: Ok   (nr samples: 5)
>   freq 1, sample_freq       144: Ok   (nr samples: 5)
>   freq 1, sample_freq       145: Ok   (nr samples: 5)
>   freq 1, sample_freq      1234: Ok   (nr samples: 8)
>   freq 1, sample_freq      4103: Ok   (nr samples: 34)
>   freq 1, sample_freq     65520: Ok   (nr samples: 458)
>   freq 1, sample_freq     65535: Ok   (nr samples: 628)
>   freq 1, sample_freq     65552: Ok   (nr samples: 396)
>   freq 1, sample_freq   8388607: Ok
>   Op PMU test:
>   freq 0, sample_freq         0: Ok
>   freq 0, sample_freq         1: Ok
>   freq 0, sample_freq        15: Ok
>   freq 0, sample_freq        16: Ok
>   freq 0, sample_freq        17: Ok
>   freq 0, sample_freq       143: Ok
>   freq 0, sample_freq       144: Ok   (nr samples: 1604)
>   freq 0, sample_freq       145: Ok   (nr samples: 1604)
>   freq 0, sample_freq      1234: Ok   (nr samples: 1604)
>   freq 0, sample_freq      4103: Ok   (nr samples: 1604)
>   freq 0, sample_freq     65520: Ok   (nr samples: 2250)
>   freq 0, sample_freq     65535: Ok   (nr samples: 2158)
>   freq 0, sample_freq     65552: Ok   (nr samples: 2296)
>   freq 0, sample_freq   8388607: Ok   (nr samples: 243)
>   freq 0, sample_freq 268435455: Ok   (nr samples: 6)
>   freq 1, sample_freq         0: Ok
>   freq 1, sample_freq         1: Ok   (nr samples: 4)
>   freq 1, sample_freq        15: Ok   (nr samples: 4)
>   freq 1, sample_freq        16: Ok   (nr samples: 4)
>   freq 1, sample_freq        17: Ok   (nr samples: 4)
>   freq 1, sample_freq       143: Ok   (nr samples: 4)
>   freq 1, sample_freq       144: Ok   (nr samples: 5)
>   freq 1, sample_freq       145: Ok   (nr samples: 4)
>   freq 1, sample_freq      1234: Ok   (nr samples: 6)
>   freq 1, sample_freq      4103: Ok   (nr samples: 27)
>   freq 1, sample_freq     65520: Ok   (nr samples: 542)
>   freq 1, sample_freq     65535: Ok   (nr samples: 550)
>   freq 1, sample_freq     65552: Ok   (nr samples: 552)
>   freq 1, sample_freq   8388607: Ok
> 
>   IBS ioctl() tests:
>   ------------------
>   Fetch PMU tests
>   ioctl(period = 0x0      ): Ok
>   ioctl(period = 0x1      ): Ok
>   ioctl(period = 0xf      ): Ok
>   ioctl(period = 0x10     ): Ok
>   ioctl(period = 0x11     ): Ok
>   ioctl(period = 0x1f     ): Ok
>   ioctl(period = 0x20     ): Ok
>   ioctl(period = 0x80     ): Ok
>   ioctl(period = 0x8f     ): Ok
>   ioctl(period = 0x90     ): Ok
>   ioctl(period = 0x91     ): Ok
>   ioctl(period = 0x100    ): Ok
>   ioctl(period = 0xfff0   ): Ok
>   ioctl(period = 0xffff   ): Ok
>   ioctl(period = 0x10000  ): Ok
>   ioctl(period = 0x1fff0  ): Ok
>   ioctl(period = 0x1fff5  ): Ok
>   ioctl(freq   = 0x0      ): Ok
>   ioctl(freq   = 0x1      ): Ok
>   ioctl(freq   = 0xf      ): Ok
>   ioctl(freq   = 0x10     ): Ok
>   ioctl(freq   = 0x11     ): Ok
>   ioctl(freq   = 0x1f     ): Ok
>   ioctl(freq   = 0x20     ): Ok
>   ioctl(freq   = 0x80     ): Ok
>   ioctl(freq   = 0x8f     ): Ok
>   ioctl(freq   = 0x90     ): Ok
>   ioctl(freq   = 0x91     ): Ok
>   ioctl(freq   = 0x100    ): Ok
>   Op PMU tests
>   ioctl(period = 0x0      ): Ok
>   ioctl(period = 0x1      ): Ok
>   ioctl(period = 0xf      ): Ok
>   ioctl(period = 0x10     ): Ok
>   ioctl(period = 0x11     ): Ok
>   ioctl(period = 0x1f     ): Ok
>   ioctl(period = 0x20     ): Ok
>   ioctl(period = 0x80     ): Ok
>   ioctl(period = 0x8f     ): Ok
>   ioctl(period = 0x90     ): Ok
>   ioctl(period = 0x91     ): Ok
>   ioctl(period = 0x100    ): Ok
>   ioctl(period = 0xfff0   ): Ok
>   ioctl(period = 0xffff   ): Ok
>   ioctl(period = 0x10000  ): Ok
>   ioctl(period = 0x1fff0  ): Ok
>   ioctl(period = 0x1fff5  ): Ok
>   ioctl(freq   = 0x0      ): Ok
>   ioctl(freq   = 0x1      ): Ok
>   ioctl(freq   = 0xf      ): Ok
>   ioctl(freq   = 0x10     ): Ok
>   ioctl(freq   = 0x11     ): Ok
>   ioctl(freq   = 0x1f     ): Ok
>   ioctl(freq   = 0x20     ): Ok
>   ioctl(freq   = 0x80     ): Ok
>   ioctl(freq   = 0x8f     ): Ok
>   ioctl(freq   = 0x90     ): Ok
>   ioctl(freq   = 0x91     ): Ok
>   ioctl(freq   = 0x100    ): Ok
> 
>   IBS freq (negative) tests:
>   --------------------------
>   freq 1, sample_freq 200000: Ok
> 
>   IBS L3MissOnly test: (takes a while)
>   --------------------
>   Fetch L3MissOnly: Ok   (nr_samples: 1301)
>   Op L3MissOnly:    Ok   (nr_samples: 1590)
>   ---- end(0) ----
>   112: AMD IBS sample period                                           : Ok
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/arch/x86/include/arch-tests.h   |    1 +
>  tools/perf/arch/x86/tests/Build            |    1 +
>  tools/perf/arch/x86/tests/amd-ibs-period.c | 1001 ++++++++++++++++++++
>  tools/perf/arch/x86/tests/arch-tests.c     |    2 +
>  4 files changed, 1005 insertions(+)
>  create mode 100644 tools/perf/arch/x86/tests/amd-ibs-period.c
> 
> diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
> index c0421a26b875..4fd425157d7d 100644
> --- a/tools/perf/arch/x86/include/arch-tests.h
> +++ b/tools/perf/arch/x86/include/arch-tests.h
> @@ -14,6 +14,7 @@ int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
>  int test__bp_modify(struct test_suite *test, int subtest);
>  int test__x86_sample_parsing(struct test_suite *test, int subtest);
>  int test__amd_ibs_via_core_pmu(struct test_suite *test, int subtest);
> +int test__amd_ibs_period(struct test_suite *test, int subtest);
>  int test__hybrid(struct test_suite *test, int subtest);
>  
>  extern struct test_suite *arch_tests[];
> diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
> index 86262c720857..5e00cbfd2d56 100644
> --- a/tools/perf/arch/x86/tests/Build
> +++ b/tools/perf/arch/x86/tests/Build
> @@ -10,6 +10,7 @@ perf-test-$(CONFIG_AUXTRACE) += insn-x86.o
>  endif
>  perf-test-$(CONFIG_X86_64) += bp-modify.o
>  perf-test-y += amd-ibs-via-core-pmu.o
> +perf-test-y += amd-ibs-period.o
>  
>  ifdef SHELLCHECK
>    SHELL_TESTS := gen-insn-x86-dat.sh
> diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch/x86/tests/amd-ibs-period.c
> new file mode 100644
> index 000000000000..0cf3656e4b9b
> --- /dev/null
> +++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
> @@ -0,0 +1,1001 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <sched.h>
> +#include <sys/syscall.h>
> +#include <sys/mman.h>
> +#include <sys/ioctl.h>
> +#include <string.h>
> +
> +#include "arch-tests.h"
> +#include "linux/perf_event.h"
> +#include "linux/zalloc.h"
> +#include "tests/tests.h"
> +#include "../perf-sys.h"
> +#include "pmu.h"
> +#include "pmus.h"
> +#include "debug.h"
> +#include "util.h"
> +#include "strbuf.h"
> +#include "../util/env.h"
> +
> +#define PAGE_SIZE               sysconf(_SC_PAGESIZE)
> +
> +#define PERF_MMAP_DATA_PAGES    32L
> +#define PERF_MMAP_DATA_SIZE     (PERF_MMAP_DATA_PAGES * PAGE_SIZE)
> +#define PERF_MMAP_DATA_MASK     (PERF_MMAP_DATA_SIZE - 1)
> +#define PERF_MMAP_TOTAL_PAGES   (PERF_MMAP_DATA_PAGES + 1)
> +#define PERF_MMAP_TOTAL_SIZE    (PERF_MMAP_TOTAL_PAGES * PAGE_SIZE)
> +
> +#define rmb()                   asm volatile("lfence":::"memory")
> +
> +enum {
> +	FD_ERROR,
> +	FD_SUCCESS,
> +};
> +
> +enum {
> +	IBS_FETCH,
> +	IBS_OP,
> +};
> +
> +struct perf_pmu *fetch_pmu;
> +struct perf_pmu *op_pmu;
> +unsigned int perf_event_max_sample_rate;
> +
> +/* Dummy workload to generate IBS samples. */
> +static int dummy_workload_1(unsigned long count)
> +{
> +	int (*func)(void);
> +	int ret = 0;
> +	char *p;
> +	char insn1[] = {
> +		0xb8, 0x01, 0x00, 0x00, 0x00, /* mov 1,%eax */
> +		0xc3, /* ret */
> +		0xcc, /* int 3 */
> +	};
> +
> +	char insn2[] = {
> +		0xb8, 0x02, 0x00, 0x00, 0x00, /* mov 2,%eax */
> +		0xc3, /* ret */
> +		0xcc, /* int 3 */
> +	};
> +
> +	p = zalloc(2 * PAGE_SIZE);
> +	if (!p) {
> +		printf("malloc() failed. %m");
> +		return 1;
> +	}
> +
> +	func = (void *)((unsigned long)(p + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1));
> +
> +	ret = mprotect(func, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC);
> +	if (ret) {
> +		printf("mprotect() failed. %m");
> +		goto out;
> +	}
> +
> +	if (count < 100000)
> +		count = 100000;
> +	else if (count > 10000000)
> +		count = 10000000;
> +	while (count--) {
> +		memcpy(func, insn1, sizeof(insn1));
> +		if (func() != 1) {
> +			pr_debug("ERROR insn1\n");
> +			ret = -1;
> +			goto out;
> +		}
> +		memcpy(func, insn2, sizeof(insn2));
> +		if (func() != 2) {
> +			pr_debug("ERROR insn2\n");
> +			ret = -1;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	free(p);
> +	return ret;
> +}
> +
> +/* Another dummy workload to generate IBS samples. */
> +static void dummy_workload_2(char *perf)
> +{
> +	char bench[] = " bench sched messaging -g 10 -l 5000 > /dev/null 2>&1";
> +	char taskset[] = "taskset -c 0 ";
> +	int ret __maybe_unused;
> +	struct strbuf sb;
> +	char *cmd;
> +
> +	strbuf_init(&sb, 0);
> +	strbuf_add(&sb, taskset, strlen(taskset));
> +	strbuf_add(&sb, perf, strlen(perf));
> +	strbuf_add(&sb, bench, strlen(bench));
> +	cmd = strbuf_detach(&sb, NULL);
> +	ret = system(cmd);
> +	free(cmd);
> +}
> +
> +static int sched_affine(int cpu)
> +{
> +	cpu_set_t set;
> +
> +	CPU_ZERO(&set);
> +	CPU_SET(cpu, &set);
> +	if (sched_setaffinity(getpid(), sizeof(set), &set) == -1) {
> +		pr_debug("sched_setaffinity() failed. [%m]");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static void
> +copy_sample_data(void *src, unsigned long offset, void *dest, size_t size)
> +{
> +	size_t chunk1_size, chunk2_size;
> +
> +	if ((offset + size) < (size_t)PERF_MMAP_DATA_SIZE) {
> +		memcpy(dest, src + offset, size);
> +	} else {
> +		chunk1_size = PERF_MMAP_DATA_SIZE - offset;
> +		chunk2_size = size - chunk1_size;
> +
> +		memcpy(dest, src + offset, chunk1_size);
> +		memcpy(dest + chunk1_size, src, chunk2_size);
> +	}
> +}
> +
> +static int rb_read(struct perf_event_mmap_page *rb, void *dest, size_t size)
> +{
> +	void *base;
> +	unsigned long data_tail, data_head;
> +
> +	/* Casting to (void *) is needed. */
> +	base = (void *)rb + PAGE_SIZE;
> +
> +	data_head = rb->data_head;
> +	rmb();
> +	data_tail = rb->data_tail;
> +
> +	if ((data_head - data_tail) < size)
> +		return -1;
> +
> +	data_tail &= PERF_MMAP_DATA_MASK;
> +	copy_sample_data(base, data_tail, dest, size);
> +	rb->data_tail += size;
> +	return 0;
> +}
> +
> +static void rb_skip(struct perf_event_mmap_page *rb, size_t size)
> +{
> +	size_t data_head = rb->data_head;
> +
> +	rmb();
> +
> +	if ((rb->data_tail + size) > data_head)
> +		rb->data_tail = data_head;
> +	else
> +		rb->data_tail += size;
> +}
> +
> +/* Sample period value taken from perf sample must match with expected value. */
> +static int period_equal(unsigned long exp_period, unsigned long act_period)
> +{
> +	return exp_period == act_period ? 0 : -1;
> +}
> +
> +/*
> + * Sample period value taken from perf sample must be >= minimum sample period
> + * supported by IBS HW.
> + */
> +static int period_higher(unsigned long min_period, unsigned long act_period)
> +{
> +	return min_period <= act_period ? 0 : -1;
> +}
> +
> +static int rb_drain_samples(struct perf_event_mmap_page *rb,
> +			    unsigned long exp_period,
> +			    int *nr_samples,
> +			    int (*callback)(unsigned long, unsigned long))
> +{
> +	struct perf_event_header hdr;
> +	unsigned long period;
> +	int ret = 0;
> +
> +	/*
> +	 * PERF_RECORD_SAMPLE:
> +	 * struct {
> +	 *	struct perf_event_header hdr;
> +	 *	{ u64			 period;     } && PERF_SAMPLE_PERIOD
> +	 * };
> +	 */
> +	while (1) {
> +		if (rb_read(rb, &hdr, sizeof(hdr)))
> +			return ret;
> +
> +		if (hdr.type == PERF_RECORD_SAMPLE) {
> +			(*nr_samples)++;
> +			period = 0;
> +			if (rb_read(rb, &period, sizeof(period)))
> +				pr_debug("rb_read(period) error. [%m]");
> +			ret |= callback(exp_period, period);
> +		} else {
> +			rb_skip(rb, hdr.size - sizeof(hdr));
> +		}
> +	}
> +	return ret;
> +}
> +
> +static long perf_event_open(struct perf_event_attr *attr, pid_t pid,
> +			    int cpu, int group_fd, unsigned long flags)
> +{
> +	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
> +}
> +
> +static void fetch_prepare_attr(struct perf_event_attr *attr,
> +			       unsigned long long config, int freq,
> +			       unsigned long sample_period)
> +{
> +	memset(attr, 0, sizeof(struct perf_event_attr));
> +
> +	attr->type = fetch_pmu->type;
> +	attr->size = sizeof(struct perf_event_attr);
> +	attr->config = config;
> +	attr->disabled = 1;
> +	attr->sample_type = PERF_SAMPLE_PERIOD;
> +	attr->freq = freq;
> +	attr->sample_period = sample_period; /* = ->sample_freq */
> +}
> +
> +static void op_prepare_attr(struct perf_event_attr *attr,
> +			    unsigned long config, int freq,
> +			    unsigned long sample_period)
> +{
> +	memset(attr, 0, sizeof(struct perf_event_attr));
> +
> +	attr->type = op_pmu->type;
> +	attr->size = sizeof(struct perf_event_attr);
> +	attr->config = config;
> +	attr->disabled = 1;
> +	attr->sample_type = PERF_SAMPLE_PERIOD;
> +	attr->freq = freq;
> +	attr->sample_period = sample_period; /* = ->sample_freq */
> +}
> +
> +struct ibs_configs {
> +	/* Input */
> +	unsigned long config;
> +
> +	/* Expected output */
> +	unsigned long period;
> +	int fd;
> +};
> +
> +/*
> + * Somehow first Fetch event with sample period = 0x10 causes 0
> + * samples. So start with large period and decrease it gradually.
> + */
> +struct ibs_configs fetch_configs[] = {
> +	{ .config =  0xffff, .period = 0xffff0, .fd = FD_SUCCESS },
> +	{ .config =  0x1000, .period = 0x10000, .fd = FD_SUCCESS },
> +	{ .config =    0xff, .period =   0xff0, .fd = FD_SUCCESS },
> +	{ .config =     0x1, .period =    0x10, .fd = FD_SUCCESS },
> +	{ .config =     0x0, .period =      -1, .fd = FD_ERROR   },
> +	{ .config = 0x10000, .period =      -1, .fd = FD_ERROR   },
> +};
> +
> +struct ibs_configs op_configs[] = {
> +	{ .config =        0x0, .period =        -1, .fd = FD_ERROR   },
> +	{ .config =        0x1, .period =        -1, .fd = FD_ERROR   },
> +	{ .config =        0x8, .period =        -1, .fd = FD_ERROR   },
> +	{ .config =        0x9, .period =      0x90, .fd = FD_SUCCESS },
> +	{ .config =        0xf, .period =      0xf0, .fd = FD_SUCCESS },
> +	{ .config =     0x1000, .period =   0x10000, .fd = FD_SUCCESS },
> +	{ .config =     0xffff, .period =   0xffff0, .fd = FD_SUCCESS },
> +	{ .config =    0x10000, .period =        -1, .fd = FD_ERROR   },
> +	{ .config =   0x100000, .period =  0x100000, .fd = FD_SUCCESS },
> +	{ .config =   0xf00000, .period =  0xf00000, .fd = FD_SUCCESS },
> +	{ .config =   0xf0ffff, .period =  0xfffff0, .fd = FD_SUCCESS },
> +	{ .config =  0x1f0ffff, .period = 0x1fffff0, .fd = FD_SUCCESS },
> +	{ .config =  0x7f0ffff, .period = 0x7fffff0, .fd = FD_SUCCESS },
> +	{ .config =  0x8f0ffff, .period =        -1, .fd = FD_ERROR   },
> +	{ .config = 0x17f0ffff, .period =        -1, .fd = FD_ERROR   },
> +};
> +
> +static int __ibs_config_test(int ibs_type, struct ibs_configs *config, int *nr_samples)
> +{
> +	struct perf_event_attr attr;
> +	int fd, i;
> +	void *rb;
> +	int ret = 0;
> +
> +	if (ibs_type == IBS_FETCH)
> +		fetch_prepare_attr(&attr, config->config, 0, 0);
> +	else
> +		op_prepare_attr(&attr, config->config, 0, 0);
> +
> +	/* CPU0, All processes */
> +	fd = perf_event_open(&attr, -1, 0, -1, 0);
> +	if (config->fd == FD_ERROR) {
> +		if (fd != -1) {
> +			close(fd);
> +			return -1;
> +		}
> +		return 0;
> +	}
> +	if (fd <= -1)
> +		return -1;
> +
> +	rb = mmap(NULL, PERF_MMAP_TOTAL_SIZE, PROT_READ | PROT_WRITE,
> +		  MAP_SHARED, fd, 0);
> +	if (rb == MAP_FAILED) {
> +		pr_debug("mmap() failed. [%m]\n");
> +		return -1;
> +	}
> +
> +	ioctl(fd, PERF_EVENT_IOC_RESET, 0);
> +	ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
> +
> +	i = 5;
> +	while (i--) {
> +		dummy_workload_1(1000000);
> +
> +		ret = rb_drain_samples(rb, config->period, nr_samples,
> +				       period_equal);
> +		if (ret)
> +			break;
> +	}
> +
> +	ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
> +	munmap(rb, PERF_MMAP_TOTAL_SIZE);
> +	close(fd);
> +	return ret;
> +}
> +
> +static int ibs_config_test(void)
> +{
> +	int nr_samples = 0;
> +	unsigned long i;
> +	int ret = 0;
> +	int r;
> +
> +	pr_debug("\nIBS config tests:\n");
> +	pr_debug("-----------------\n");
> +
> +	pr_debug("Fetch PMU tests:\n");
> +	for (i = 0; i < ARRAY_SIZE(fetch_configs); i++) {
> +		nr_samples = 0;
> +		r = __ibs_config_test(IBS_FETCH, &(fetch_configs[i]), &nr_samples);
> +
> +		if (fetch_configs[i].fd == FD_ERROR) {
> +			pr_debug("0x%-16lx: %-4s\n", fetch_configs[i].config,
> +				 !r ? "Ok" : "Fail");
> +		} else {
> +			/*
> +			 * Although nr_samples == 0 is reported as Fail here,
> +			 * the failure status is not cascaded up because, we
> +			 * can not decide whether test really failed or not
> +			 * without actual samples.
> +			 */
> +			pr_debug("0x%-16lx: %-4s (nr samples: %d)\n", fetch_configs[i].config,
> +				 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
> +		}
> +
> +		ret |= r;
> +	}
> +
> +	pr_debug("Op PMU tests:\n");
> +	for (i = 0; i < ARRAY_SIZE(op_configs); i++) {
> +		nr_samples = 0;
> +		r = __ibs_config_test(IBS_OP, &(op_configs[i]), &nr_samples);
> +
> +		if (op_configs[i].fd == FD_ERROR) {
> +			pr_debug("0x%-16lx: %-4s\n", op_configs[i].config,
> +				 !r ? "Ok" : "Fail");
> +		} else {
> +			/*
> +			 * Although nr_samples == 0 is reported as Fail here,
> +			 * the failure status is not cascaded up because, we
> +			 * can not decide whether test really failed or not
> +			 * without actual samples.
> +			 */
> +			pr_debug("0x%-16lx: %-4s (nr samples: %d)\n", op_configs[i].config,
> +				 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
> +		}
> +
> +		ret |= r;
> +	}
> +
> +	return ret;
> +}
> +
> +struct ibs_period {
> +	/* Input */
> +	int freq;
> +	unsigned long sample_freq;
> +
> +	/* Output */
> +	int ret;
> +	unsigned long period;
> +};
> +
> +struct ibs_period fetch_period[] = {
> +	{ .freq = 0, .sample_freq =         0, .ret = FD_ERROR,   .period =        -1 },
> +	{ .freq = 0, .sample_freq =         1, .ret = FD_ERROR,   .period =        -1 },
> +	{ .freq = 0, .sample_freq =       0xf, .ret = FD_ERROR,   .period =        -1 },
> +	{ .freq = 0, .sample_freq =      0x10, .ret = FD_SUCCESS, .period =      0x10 },
> +	{ .freq = 0, .sample_freq =      0x11, .ret = FD_SUCCESS, .period =      0x10 },
> +	{ .freq = 0, .sample_freq =      0x8f, .ret = FD_SUCCESS, .period =      0x80 },
> +	{ .freq = 0, .sample_freq =      0x90, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 0, .sample_freq =      0x91, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 0, .sample_freq =     0x4d2, .ret = FD_SUCCESS, .period =     0x4d0 },
> +	{ .freq = 0, .sample_freq =    0x1007, .ret = FD_SUCCESS, .period =    0x1000 },
> +	{ .freq = 0, .sample_freq =    0xfff0, .ret = FD_SUCCESS, .period =    0xfff0 },
> +	{ .freq = 0, .sample_freq =    0xffff, .ret = FD_SUCCESS, .period =    0xfff0 },
> +	{ .freq = 0, .sample_freq =   0x10010, .ret = FD_SUCCESS, .period =   0x10010 },
> +	{ .freq = 0, .sample_freq =  0x7fffff, .ret = FD_SUCCESS, .period =  0x7ffff0 },
> +	{ .freq = 0, .sample_freq = 0xfffffff, .ret = FD_SUCCESS, .period = 0xffffff0 },
> +	{ .freq = 1, .sample_freq =         0, .ret = FD_ERROR,   .period =        -1 },
> +	{ .freq = 1, .sample_freq =         1, .ret = FD_SUCCESS, .period =      0x10 },
> +	{ .freq = 1, .sample_freq =       0xf, .ret = FD_SUCCESS, .period =      0x10 },
> +	{ .freq = 1, .sample_freq =      0x10, .ret = FD_SUCCESS, .period =      0x10 },
> +	{ .freq = 1, .sample_freq =      0x11, .ret = FD_SUCCESS, .period =      0x10 },
> +	{ .freq = 1, .sample_freq =      0x8f, .ret = FD_SUCCESS, .period =      0x10 },
> +	{ .freq = 1, .sample_freq =      0x90, .ret = FD_SUCCESS, .period =      0x10 },
> +	{ .freq = 1, .sample_freq =      0x91, .ret = FD_SUCCESS, .period =      0x10 },
> +	{ .freq = 1, .sample_freq =     0x4d2, .ret = FD_SUCCESS, .period =      0x10 },
> +	{ .freq = 1, .sample_freq =    0x1007, .ret = FD_SUCCESS, .period =      0x10 },
> +	{ .freq = 1, .sample_freq =    0xfff0, .ret = FD_SUCCESS, .period =      0x10 },
> +	{ .freq = 1, .sample_freq =    0xffff, .ret = FD_SUCCESS, .period =      0x10 },
> +	{ .freq = 1, .sample_freq =   0x10010, .ret = FD_SUCCESS, .period =      0x10 },
> +	/* ret=FD_ERROR because freq > default perf_event_max_sample_rate (100000) */
> +	{ .freq = 1, .sample_freq =  0x7fffff, .ret = FD_ERROR,   .period =        -1 },
> +};
> +
> +struct ibs_period op_period[] = {
> +	{ .freq = 0, .sample_freq =         0, .ret = FD_ERROR,   .period =        -1 },
> +	{ .freq = 0, .sample_freq =         1, .ret = FD_ERROR,   .period =        -1 },
> +	{ .freq = 0, .sample_freq =       0xf, .ret = FD_ERROR,   .period =        -1 },
> +	{ .freq = 0, .sample_freq =      0x10, .ret = FD_ERROR,   .period =        -1 },
> +	{ .freq = 0, .sample_freq =      0x11, .ret = FD_ERROR,   .period =        -1 },
> +	{ .freq = 0, .sample_freq =      0x8f, .ret = FD_ERROR,   .period =        -1 },
> +	{ .freq = 0, .sample_freq =      0x90, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 0, .sample_freq =      0x91, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 0, .sample_freq =     0x4d2, .ret = FD_SUCCESS, .period =     0x4d0 },
> +	{ .freq = 0, .sample_freq =    0x1007, .ret = FD_SUCCESS, .period =    0x1000 },
> +	{ .freq = 0, .sample_freq =    0xfff0, .ret = FD_SUCCESS, .period =    0xfff0 },
> +	{ .freq = 0, .sample_freq =    0xffff, .ret = FD_SUCCESS, .period =    0xfff0 },
> +	{ .freq = 0, .sample_freq =   0x10010, .ret = FD_SUCCESS, .period =   0x10010 },
> +	{ .freq = 0, .sample_freq =  0x7fffff, .ret = FD_SUCCESS, .period =  0x7ffff0 },
> +	{ .freq = 0, .sample_freq = 0xfffffff, .ret = FD_SUCCESS, .period = 0xffffff0 },
> +	{ .freq = 1, .sample_freq =         0, .ret = FD_ERROR,   .period =        -1 },
> +	{ .freq = 1, .sample_freq =         1, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 1, .sample_freq =       0xf, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 1, .sample_freq =      0x10, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 1, .sample_freq =      0x11, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 1, .sample_freq =      0x8f, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 1, .sample_freq =      0x90, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 1, .sample_freq =      0x91, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 1, .sample_freq =     0x4d2, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 1, .sample_freq =    0x1007, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 1, .sample_freq =    0xfff0, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 1, .sample_freq =    0xffff, .ret = FD_SUCCESS, .period =      0x90 },
> +	{ .freq = 1, .sample_freq =   0x10010, .ret = FD_SUCCESS, .period =      0x90 },
> +	/* ret=FD_ERROR because freq > default perf_event_max_sample_rate (100000) */
> +	{ .freq = 1, .sample_freq =  0x7fffff, .ret = FD_ERROR,   .period =        -1 },
> +};
> +
> +static int __ibs_period_constraint_test(int ibs_type, struct ibs_period *period,
> +					int *nr_samples)
> +{
> +	struct perf_event_attr attr;
> +	int ret = 0;
> +	void *rb;
> +	int fd;
> +
> +	if (period->freq && period->sample_freq > perf_event_max_sample_rate)
> +		period->ret = FD_ERROR;
> +
> +	if (ibs_type == IBS_FETCH)
> +		fetch_prepare_attr(&attr, 0, period->freq, period->sample_freq);
> +	else
> +		op_prepare_attr(&attr, 0, period->freq, period->sample_freq);
> +
> +	/* CPU0, All processes */
> +	fd = perf_event_open(&attr, -1, 0, -1, 0);
> +	if (period->ret == FD_ERROR) {
> +		if (fd != -1) {
> +			close(fd);
> +			return -1;
> +		}
> +		return 0;
> +	}
> +	if (fd <= -1)
> +		return -1;
> +
> +	rb = mmap(NULL, PERF_MMAP_TOTAL_SIZE, PROT_READ | PROT_WRITE,
> +		  MAP_SHARED, fd, 0);
> +	if (rb == MAP_FAILED) {
> +		pr_debug("mmap() failed. [%m]\n");
> +		close(fd);
> +		return -1;
> +	}
> +
> +	ioctl(fd, PERF_EVENT_IOC_RESET, 0);
> +	ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
> +
> +	if (period->freq) {
> +		dummy_workload_1(100000);
> +		ret = rb_drain_samples(rb, period->period, nr_samples,
> +				       period_higher);
> +	} else {
> +		dummy_workload_1(period->sample_freq * 10);
> +		ret = rb_drain_samples(rb, period->period, nr_samples,
> +				       period_equal);
> +	}
> +
> +	ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
> +	munmap(rb, PERF_MMAP_TOTAL_SIZE);
> +	close(fd);
> +	return ret;
> +}
> +
> +static int ibs_period_constraint_test(void)
> +{
> +	unsigned long i;
> +	int nr_samples;
> +	int ret = 0;
> +	int r;
> +
> +	pr_debug("\nIBS sample period constraint tests:\n");
> +	pr_debug("-----------------------------------\n");
> +
> +	pr_debug("Fetch PMU test:\n");
> +	for (i = 0; i < ARRAY_SIZE(fetch_period); i++) {
> +		nr_samples = 0;
> +		r = __ibs_period_constraint_test(IBS_FETCH, &fetch_period[i],
> +						 &nr_samples);
> +
> +		if (fetch_period[i].ret == FD_ERROR) {
> +			pr_debug("freq %d, sample_freq %9ld: %-4s\n",
> +				 fetch_period[i].freq, fetch_period[i].sample_freq,
> +				 !r ? "Ok" : "Fail");
> +		} else {
> +			/*
> +			 * Although nr_samples == 0 is reported as Fail here,
> +			 * the failure status is not cascaded up because, we
> +			 * can not decide whether test really failed or not
> +			 * without actual samples.
> +			 */
> +			pr_debug("freq %d, sample_freq %9ld: %-4s (nr samples: %d)\n",
> +				 fetch_period[i].freq, fetch_period[i].sample_freq,
> +				 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
> +		}
> +		ret |= r;
> +	}
> +
> +	pr_debug("Op PMU test:\n");
> +	for (i = 0; i < ARRAY_SIZE(op_period); i++) {
> +		nr_samples = 0;
> +		r = __ibs_period_constraint_test(IBS_OP, &op_period[i],
> +						 &nr_samples);
> +
> +		if (op_period[i].ret == FD_ERROR) {
> +			pr_debug("freq %d, sample_freq %9ld: %-4s\n",
> +				 op_period[i].freq, op_period[i].sample_freq,
> +				 !r ? "Ok" : "Fail");
> +		} else {
> +			/*
> +			 * Although nr_samples == 0 is reported as Fail here,
> +			 * the failure status is not cascaded up because, we
> +			 * can not decide whether test really failed or not
> +			 * without actual samples.
> +			 */
> +			pr_debug("freq %d, sample_freq %9ld: %-4s (nr samples: %d)\n",
> +				 op_period[i].freq, op_period[i].sample_freq,
> +				 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
> +		}
> +		ret |= r;
> +	}
> +
> +	return ret;
> +}
> +
> +struct ibs_ioctl {
> +	/* Input */
> +	int freq;
> +	unsigned long period;
> +
> +	/* Expected output */
> +	int ret;
> +};
> +
> +struct ibs_ioctl fetch_ioctl[] = {
> +	{ .freq = 0, .period =     0x0, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =     0x1, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =     0xf, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =    0x10, .ret = FD_SUCCESS },
> +	{ .freq = 0, .period =    0x11, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =    0x1f, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =    0x20, .ret = FD_SUCCESS },
> +	{ .freq = 0, .period =    0x80, .ret = FD_SUCCESS },
> +	{ .freq = 0, .period =    0x8f, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =    0x90, .ret = FD_SUCCESS },
> +	{ .freq = 0, .period =    0x91, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =   0x100, .ret = FD_SUCCESS },
> +	{ .freq = 0, .period =  0xfff0, .ret = FD_SUCCESS },
> +	{ .freq = 0, .period =  0xffff, .ret = FD_ERROR   },
> +	{ .freq = 0, .period = 0x10000, .ret = FD_SUCCESS },
> +	{ .freq = 0, .period = 0x1fff0, .ret = FD_SUCCESS },
> +	{ .freq = 0, .period = 0x1fff5, .ret = FD_ERROR   },
> +	{ .freq = 1, .period =     0x0, .ret = FD_ERROR   },
> +	{ .freq = 1, .period =     0x1, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =     0xf, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x10, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x11, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x1f, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x20, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x80, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x8f, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x90, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x91, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =   0x100, .ret = FD_SUCCESS },
> +};
> +
> +struct ibs_ioctl op_ioctl[] = {
> +	{ .freq = 0, .period =     0x0, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =     0x1, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =     0xf, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =    0x10, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =    0x11, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =    0x1f, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =    0x20, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =    0x80, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =    0x8f, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =    0x90, .ret = FD_SUCCESS },
> +	{ .freq = 0, .period =    0x91, .ret = FD_ERROR   },
> +	{ .freq = 0, .period =   0x100, .ret = FD_SUCCESS },
> +	{ .freq = 0, .period =  0xfff0, .ret = FD_SUCCESS },
> +	{ .freq = 0, .period =  0xffff, .ret = FD_ERROR   },
> +	{ .freq = 0, .period = 0x10000, .ret = FD_SUCCESS },
> +	{ .freq = 0, .period = 0x1fff0, .ret = FD_SUCCESS },
> +	{ .freq = 0, .period = 0x1fff5, .ret = FD_ERROR   },
> +	{ .freq = 1, .period =     0x0, .ret = FD_ERROR   },
> +	{ .freq = 1, .period =     0x1, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =     0xf, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x10, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x11, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x1f, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x20, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x80, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x8f, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x90, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =    0x91, .ret = FD_SUCCESS },
> +	{ .freq = 1, .period =   0x100, .ret = FD_SUCCESS },
> +};
> +
> +static int __ibs_ioctl_test(int ibs_type, struct ibs_ioctl *ibs_ioctl)
> +{
> +	struct perf_event_attr attr;
> +	int ret = 0;
> +	int fd;
> +	int r;
> +
> +	if (ibs_type == IBS_FETCH)
> +		fetch_prepare_attr(&attr, 0, ibs_ioctl->freq, 1000);
> +	else
> +		op_prepare_attr(&attr, 0, ibs_ioctl->freq, 1000);
> +
> +	/* CPU0, All processes */
> +	fd = perf_event_open(&attr, -1, 0, -1, 0);
> +	if (fd <= -1) {
> +		pr_debug("event_open() Failed\n");
> +		return -1;
> +	}
> +
> +	r = ioctl(fd, PERF_EVENT_IOC_PERIOD, &ibs_ioctl->period);
> +	if ((ibs_ioctl->ret == FD_SUCCESS && r <= -1) ||
> +	    (ibs_ioctl->ret == FD_ERROR && r >= 0)) {
> +		ret = -1;
> +	}
> +
> +	close(fd);
> +	return ret;
> +}
> +
> +static int ibs_ioctl_test(void)
> +{
> +	unsigned long i;
> +	int ret = 0;
> +	int r;
> +
> +	pr_debug("\nIBS ioctl() tests:\n");
> +	pr_debug("------------------\n");
> +
> +	pr_debug("Fetch PMU tests\n");
> +	for (i = 0; i < ARRAY_SIZE(fetch_ioctl); i++) {
> +		r = __ibs_ioctl_test(IBS_FETCH, &fetch_ioctl[i]);
> +
> +		pr_debug("ioctl(%s = 0x%-7lx): %s\n",
> +			 fetch_ioctl[i].freq ? "freq  " : "period",
> +			 fetch_ioctl[i].period, r ? "Fail" : "Ok");
> +		ret |= r;
> +	}
> +
> +	pr_debug("Op PMU tests\n");
> +	for (i = 0; i < ARRAY_SIZE(op_ioctl); i++) {
> +		r = __ibs_ioctl_test(IBS_OP, &op_ioctl[i]);
> +
> +		pr_debug("ioctl(%s = 0x%-7lx): %s\n",
> +			 op_ioctl[i].freq ? "freq  " : "period",
> +			 op_ioctl[i].period, r ? "Fail" : "Ok");
> +		ret |= r;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ibs_freq_neg_test(void)
> +{
> +	struct perf_event_attr attr;
> +	int fd;
> +
> +	pr_debug("\nIBS freq (negative) tests:\n");
> +	pr_debug("--------------------------\n");
> +
> +	/*
> +	 * Assuming perf_event_max_sample_rate <= 100000,
> +	 * config: 0x300D40 ==> MaxCnt: 200000
> +	 */
> +	op_prepare_attr(&attr, 0x300D40, 1, 0);
> +
> +	/* CPU0, All processes */
> +	fd = perf_event_open(&attr, -1, 0, -1, 0);
> +	if (fd != -1) {
> +		pr_debug("freq 1, sample_freq 200000: Fail\n");
> +		close(fd);
> +		return -1;
> +	}
> +
> +	pr_debug("freq 1, sample_freq 200000: Ok\n");
> +
> +	return 0;
> +}
> +
> +struct ibs_l3missonly {
> +	/* Input */
> +	int freq;
> +	unsigned long sample_freq;
> +
> +	/* Expected output */
> +	int ret;
> +	unsigned long min_period;
> +};
> +
> +struct ibs_l3missonly fetch_l3missonly = {
> +	.freq = 1,
> +	.sample_freq = 10000,
> +	.ret = FD_SUCCESS,
> +	.min_period = 0x10,
> +};
> +
> +struct ibs_l3missonly op_l3missonly = {
> +	.freq = 1,
> +	.sample_freq = 10000,
> +	.ret = FD_SUCCESS,
> +	.min_period = 0x90,
> +};
> +
> +static int __ibs_l3missonly_test(char *perf, int ibs_type, int *nr_samples,
> +				 struct ibs_l3missonly *l3missonly)
> +{
> +	struct perf_event_attr attr;
> +	int ret = 0;
> +	void *rb;
> +	int fd;
> +
> +	if (l3missonly->sample_freq > perf_event_max_sample_rate)
> +		l3missonly->ret = FD_ERROR;
> +
> +	if (ibs_type == IBS_FETCH) {
> +		fetch_prepare_attr(&attr, 0x800000000000000UL, l3missonly->freq,
> +				   l3missonly->sample_freq);
> +	} else {
> +		op_prepare_attr(&attr, 0x10000, l3missonly->freq,
> +				l3missonly->sample_freq);
> +	}
> +
> +	/* CPU0, All processes */
> +	fd = perf_event_open(&attr, -1, 0, -1, 0);
> +	if (l3missonly->ret == FD_ERROR) {
> +		if (fd != -1) {
> +			close(fd);
> +			return -1;
> +		}
> +		return 0;
> +	}
> +	if (fd == -1) {
> +		pr_debug("perf_event_open() failed. [%m]\n");
> +		return -1;
> +	}
> +
> +	rb = mmap(NULL, PERF_MMAP_TOTAL_SIZE, PROT_READ | PROT_WRITE,
> +		  MAP_SHARED, fd, 0);
> +	if (rb == MAP_FAILED) {
> +		pr_debug("mmap() failed. [%m]\n");
> +		close(fd);
> +		return -1;
> +	}
> +
> +	ioctl(fd, PERF_EVENT_IOC_RESET, 0);
> +	ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
> +
> +	dummy_workload_2(perf);
> +
> +	ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
> +
> +	ret = rb_drain_samples(rb, l3missonly->min_period, nr_samples, period_higher);
> +
> +	munmap(rb, PERF_MMAP_TOTAL_SIZE);
> +	close(fd);
> +	return ret;
> +}
> +
> +static int ibs_l3missonly_test(char *perf)
> +{
> +	int nr_samples = 0;
> +	int ret = 0;
> +	int r = 0;
> +
> +	pr_debug("\nIBS L3MissOnly test: (takes a while)\n");
> +	pr_debug("--------------------\n");
> +
> +	if (perf_pmu__has_format(fetch_pmu, "l3missonly")) {
> +		nr_samples = 0;
> +		r = __ibs_l3missonly_test(perf, IBS_FETCH, &nr_samples, &fetch_l3missonly);
> +		if (fetch_l3missonly.ret == FD_ERROR) {
> +			pr_debug("Fetch L3MissOnly: %-4s\n", !r ? "Ok" : "Fail");
> +		} else {
> +			/*
> +			 * Although nr_samples == 0 is reported as Fail here,
> +			 * the failure status is not cascaded up because, we
> +			 * can not decide whether test really failed or not
> +			 * without actual samples.
> +			 */
> +			pr_debug("Fetch L3MissOnly: %-4s (nr_samples: %d)\n",
> +				 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
> +		}
> +		ret |= r;
> +	}
> +
> +	if (perf_pmu__has_format(op_pmu, "l3missonly")) {
> +		nr_samples = 0;
> +		r = __ibs_l3missonly_test(perf, IBS_OP, &nr_samples, &op_l3missonly);
> +		if (op_l3missonly.ret == FD_ERROR) {
> +			pr_debug("Op L3MissOnly:    %-4s\n", !r ? "Ok" : "Fail");
> +		} else {
> +			/*
> +			 * Although nr_samples == 0 is reported as Fail here,
> +			 * the failure status is not cascaded up because, we
> +			 * can not decide whether test really failed or not
> +			 * without actual samples.
> +			 */
> +			pr_debug("Op L3MissOnly:    %-4s (nr_samples: %d)\n",
> +				 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
> +		}
> +		ret |= r;
> +	}
> +
> +	return ret;
> +}
> +
> +static unsigned int get_perf_event_max_sample_rate(void)
> +{
> +	unsigned int max_sample_rate = 100000;
> +	FILE *fp;
> +	int ret;
> +
> +	fp = fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
> +	if (!fp) {
> +		pr_debug("Can't open perf_event_max_sample_rate. Asssuming %d\n",
> +			 max_sample_rate);
> +		goto out;
> +	}
> +
> +	ret = fscanf(fp, "%d", &max_sample_rate);
> +	if (ret == EOF) {
> +		pr_debug("Can't read perf_event_max_sample_rate. Assuming 100000\n");
> +		max_sample_rate = 100000;
> +	}
> +	fclose(fp);
> +
> +out:
> +	return max_sample_rate;
> +}
> +
> +int test__amd_ibs_period(struct test_suite *test __maybe_unused,
> +			 int subtest __maybe_unused)
> +{
> +	char perf[PATH_MAX] = {'\0'};
> +	int ret = TEST_OK;
> +
> +	/*
> +	 * Reading perf_event_max_sample_rate only once _might_ cause some
> +	 * of the test to fail if kernel changes it after reading it here.
> +	 */
> +	perf_event_max_sample_rate = get_perf_event_max_sample_rate();
> +	fetch_pmu = perf_pmus__find("ibs_fetch");
> +	op_pmu = perf_pmus__find("ibs_op");
> +
> +	if (!x86__is_amd_cpu() || !fetch_pmu || !op_pmu)
> +		return TEST_SKIP;
> +
> +	perf_exe(perf, sizeof(perf));
> +
> +	if (sched_affine(0))
> +		return TEST_FAIL;
> +
> +	/*
> +	 * Perf event can be opened in two modes:
> +	 * 1 Freq mode
> +	 *   perf_event_attr->freq = 1, ->sample_freq = <frequency>
> +	 * 2 Sample period mode
> +	 *   perf_event_attr->freq = 0, ->sample_period = <period>
> +	 *
> +	 * Instead of using above interface, IBS event in 'sample period mode'
> +	 * can also be opened by passing <period> value directly in a MaxCnt
> +	 * bitfields of perf_event_attr->config. Test this IBS specific special
> +	 * interface.
> +	 */
> +	if (ibs_config_test())
> +		ret = TEST_FAIL;
> +
> +	/*
> +	 * IBS Fetch and Op PMUs have HW constraints on minimum sample period.
> +	 * Also, sample period value must be in multiple of 0x10. Test that IBS
> +	 * driver honors HW constraints for various possible values in Freq as
> +	 * well as Sample Period mode IBS events.
> +	 */
> +	if (ibs_period_constraint_test())
> +		ret = TEST_FAIL;
> +
> +	/*
> +	 * Test ioctl() with various sample period values for IBS event.
> +	 */
> +	if (ibs_ioctl_test())
> +		ret = TEST_FAIL;
> +
> +	/*
> +	 * Test that opening of freq mode IBS event fails when the freq value
> +	 * is passed through ->config, not explicitly in ->sample_freq. Also
> +	 * use high freq value (beyond perf_event_max_sample_rate) to test IBS
> +	 * driver do not bypass perf_event_max_sample_rate checks.
> +	 */
> +	if (ibs_freq_neg_test())
> +		ret = TEST_FAIL;
> +
> +	/*
> +	 * L3MissOnly is a post-processing filter, i.e. IBS HW checks for L3
> +	 * Miss at the completion of the tagged uOp. The sample is discarded
> +	 * if the tagged uOp did not cause L3Miss. Also, IBS HW internally
> +	 * resets CurCnt to a small pseudo-random value and resumes counting.
> +	 * A new uOp is tagged once CurCnt reaches to MaxCnt. But the process
> +	 * repeats until the tagged uOp causes an L3 Miss.
> +	 *
> +	 * With the freq mode event, the next sample period is calculated by
> +	 * generic kernel on every sample to achieve desired freq of samples.
> +	 *
> +	 * Since the number of times HW internally reset CurCnt and the pseudo-
> +	 * random value of CurCnt for all those occurrences are not known to SW,
> +	 * the sample period adjustment by kernel goes for a toes for freq mode
> +	 * IBS events. Kernel will set very small period for the next sample if
> +	 * the window between current sample and prev sample is too high due to
> +	 * multiple samples being discarded internally by IBS HW.
> +	 *
> +	 * Test that IBS sample period constraints are honored when L3MissOnly
> +	 * is ON.
> +	 */
> +	if (ibs_l3missonly_test(perf))
> +		ret = TEST_FAIL;
> +
> +	return ret;
> +}
> diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
> index a216a5d172ed..bfee2432515b 100644
> --- a/tools/perf/arch/x86/tests/arch-tests.c
> +++ b/tools/perf/arch/x86/tests/arch-tests.c
> @@ -25,6 +25,7 @@ DEFINE_SUITE("x86 bp modify", bp_modify);
>  #endif
>  DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
>  DEFINE_SUITE("AMD IBS via core pmu", amd_ibs_via_core_pmu);
> +DEFINE_SUITE_EXCLUSIVE("AMD IBS sample period", amd_ibs_period);
>  static struct test_case hybrid_tests[] = {
>  	TEST_CASE_REASON("x86 hybrid event parsing", hybrid, "not hybrid"),
>  	{ .name = NULL, }
> @@ -50,6 +51,7 @@ struct test_suite *arch_tests[] = {
>  #endif
>  	&suite__x86_sample_parsing,
>  	&suite__amd_ibs_via_core_pmu,
> +	&suite__amd_ibs_period,
>  	&suite__hybrid,
>  	NULL,
>  };
> -- 
> 2.43.0

