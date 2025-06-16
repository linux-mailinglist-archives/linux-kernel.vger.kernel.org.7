Return-Path: <linux-kernel+bounces-688599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD8FADB48F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 16:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E40C7A4B57
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B1F202F87;
	Mon, 16 Jun 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1ZcJGm7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA88488;
	Mon, 16 Jun 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085734; cv=none; b=PhVajKKmV9MeT1RZGc0B7LLiNuRvZRRg6GJopXeNG2HP5ZowarkRp6s0Du6YJT7pp1PeJIy9H2+lhd4GZzktvFry6MQ2DJY1usO3zvUTIDfLL7YKyo4PQOdnyVvDM2sloRRROW8CF1XZ47JtPQ4fEHWdXZj7gegrVlfuu41LoVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085734; c=relaxed/simple;
	bh=hHnys39r5rQ888A/YzcobRKqIr3EZK/DFAoRVXWQ1tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dbgm8lsql+O8Zw2dQs3toYtmRP/YBXwFQcMeQcZsy9Qu0TQQ83GvZkiWmsSnypedZYhrKLzqgKvDUivSf2faZQ95w/yXAbLhMCGmn8VL3kB4dPKo88HcKScUm/WHjgi7fP41FVaF30kW3Abg6EXyIw5OvmwPgYkgcM6wO7e4uSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1ZcJGm7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750085732; x=1781621732;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=hHnys39r5rQ888A/YzcobRKqIr3EZK/DFAoRVXWQ1tE=;
  b=X1ZcJGm7rxM8qAAdhwbmTOvYbU+2BWLv+7+JSAqGG7alXBGEeb3mBFPo
   RcwgNT3wsX9JQpbWyhS9+R4PFC7J6oCEW9jU27dBc9n9N7bswI270ol7Q
   X3UAxCt1e2ScTVrCAopQrQBjNMWK8pXG5FpefgToUfHtwgY24hbWvKGZI
   j4J+uAkwiiUlXzA7HopixwiqhZo+dFey/glY4yBEE2t2DqPg7FB0HeKYr
   UOBql3+x0qdKRKxfzkpLlNj6dj8QdoNxS3r38aBTzDi7c1RNq2iMYw0At
   z5VtPQWS706rOZtCJSYcQqHjc1NPdV59CRm/XSeAFowk8RXJ+txC1BbjE
   A==;
X-CSE-ConnectionGUID: s71zIdqoR66tfylSctoDiQ==
X-CSE-MsgGUID: ux7e6hvyTAWgmAQUA7NuGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52151673"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="52151673"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 07:55:30 -0700
X-CSE-ConnectionGUID: HTgPmMJlS0+QZPhQRTQpgw==
X-CSE-MsgGUID: Sbv6MwnhTv6Aq3EI+qkb8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="148963973"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 07:55:30 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 87D1A20B5736;
	Mon, 16 Jun 2025 07:55:27 -0700 (PDT)
Message-ID: <83ee6240-b270-4057-bc8d-4dcc9ddc1b9b@linux.intel.com>
Date: Mon, 16 Jun 2025 10:55:26 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Expand user space event reading (rdpmc)
 tests
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Howard Chu <howardchu95@gmail.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250614004528.1652860-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250614004528.1652860-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-06-13 8:45 p.m., Ian Rogers wrote:
> Test that disabling rdpmc support via /sys/bus/event_source/cpu*/rdpmc
> disables reading in the mmap (libperf read support will fallback to
> using a system call).
> Test all hybrid PMUs support rdpmc.
> Ensure hybrid PMUs use the correct CPU to rdpmc the correct
> event. Previously the test would open cycles or instructions with no
> extended type then rdpmc it on whatever CPU. This could fail/skip due
> to which CPU the test was scheduled upon.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks for the fix.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan> ---
>  tools/perf/tests/mmap-basic.c | 289 +++++++++++++++++++++++++---------
>  tools/perf/tests/tests.h      |   9 ++
>  tools/perf/util/affinity.c    |  18 +++
>  tools/perf/util/affinity.h    |   2 +
>  4 files changed, 240 insertions(+), 78 deletions(-)
> 
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index 04b547c6bdbe..3c89d3001887 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -1,15 +1,18 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
> +#include <fcntl.h>
>  #include <inttypes.h>
>  #include <stdlib.h>
>  #include <perf/cpumap.h>
>  
> +#include "cpumap.h"
>  #include "debug.h"
>  #include "event.h"
>  #include "evlist.h"
>  #include "evsel.h"
>  #include "thread_map.h"
>  #include "tests.h"
> +#include "util/affinity.h"
>  #include "util/mmap.h"
>  #include "util/sample.h"
>  #include <linux/err.h>
> @@ -172,99 +175,199 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
>  	return err;
>  }
>  
> -static int test_stat_user_read(int event)
> -{
> -	struct perf_counts_values counts = { .val = 0 };
> -	struct perf_thread_map *threads;
> -	struct perf_evsel *evsel;
> -	struct perf_event_mmap_page *pc;
> -	struct perf_event_attr attr = {
> -		.type	= PERF_TYPE_HARDWARE,
> -		.config	= event,
> -#ifdef __aarch64__
> -		.config1 = 0x2,		/* Request user access */
> -#endif
> -	};
> -	int err, i, ret = TEST_FAIL;
> -	bool opened = false, mapped = false;
> +enum user_read_state {
> +	USER_READ_ENABLED,
> +	USER_READ_DISABLED,
> +	USER_READ_UNKNOWN,
> +};
>  
> -	threads = perf_thread_map__new_dummy();
> -	TEST_ASSERT_VAL("failed to create threads", threads);
> +static enum user_read_state set_user_read(struct perf_pmu *pmu, enum user_read_state enabled)
> +{
> +	char buf[2] = {0, '\n'};
> +	ssize_t len;
> +	int events_fd, rdpmc_fd;
> +	enum user_read_state old_user_read = USER_READ_UNKNOWN;
> +
> +	if (enabled == USER_READ_UNKNOWN)
> +		return USER_READ_UNKNOWN;
> +
> +	events_fd = perf_pmu__event_source_devices_fd();
> +	if (events_fd < 0)
> +		return USER_READ_UNKNOWN;
> +
> +	rdpmc_fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
> +	if (rdpmc_fd < 0) {
> +		close(events_fd);
> +		return USER_READ_UNKNOWN;
> +	}
>  
> -	perf_thread_map__set_pid(threads, 0, 0);
> +	len = read(rdpmc_fd, buf, sizeof(buf));
> +	if (len != sizeof(buf))
> +		pr_debug("%s read failed\n", __func__);
>  
> -	evsel = perf_evsel__new(&attr);
> -	TEST_ASSERT_VAL("failed to create evsel", evsel);
> +	// Note, on Intel hybrid disabling on 1 PMU will implicitly disable on
> +	// all the core PMUs.
> +	old_user_read = (buf[0] == '1') ? USER_READ_ENABLED : USER_READ_DISABLED;
>  
> -	err = perf_evsel__open(evsel, NULL, threads);
> -	if (err) {
> -		pr_err("failed to open evsel: %s\n", strerror(-err));
> -		ret = TEST_SKIP;
> -		goto out;
> +	if (enabled != old_user_read) {
> +		buf[0] = (enabled == USER_READ_ENABLED) ? '1' : '0';
> +		len = write(rdpmc_fd, buf, sizeof(buf));
> +		if (len != sizeof(buf))
> +			pr_debug("%s write failed\n", __func__);
>  	}
> -	opened = true;
> +	close(rdpmc_fd);
> +	close(events_fd);
> +	return old_user_read;
> +}
>  
> -	err = perf_evsel__mmap(evsel, 0);
> -	if (err) {
> -		pr_err("failed to mmap evsel: %s\n", strerror(-err));
> -		goto out;
> +static int test_stat_user_read(u64 event, enum user_read_state enabled)
> +{
> +	struct perf_pmu *pmu = NULL;
> +	struct perf_thread_map *threads = perf_thread_map__new_dummy();
> +	int ret = TEST_OK;
> +
> +	pr_err("User space counter reading %" PRIu64 "\n", event);
> +	if (!threads) {
> +		pr_err("User space counter reading [Failed to create threads]\n");
> +		return TEST_FAIL;
>  	}
> -	mapped = true;
> +	perf_thread_map__set_pid(threads, 0, 0);
>  
> -	pc = perf_evsel__mmap_base(evsel, 0, 0);
> -	if (!pc) {
> -		pr_err("failed to get mmapped address\n");
> -		goto out;
> -	}
> +	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> +		enum user_read_state saved_user_read_state = set_user_read(pmu, enabled);
> +		struct perf_event_attr attr = {
> +			.type	= PERF_TYPE_HARDWARE,
> +			.config	= perf_pmus__supports_extended_type()
> +			? event | ((u64)pmu->type << PERF_PMU_TYPE_SHIFT)
> +				: event,
> +#ifdef __aarch64__
> +			.config1 = 0x2,		/* Request user access */
> +#endif
> +		};
> +		struct perf_evsel *evsel = NULL;
> +		int err;
> +		struct perf_event_mmap_page *pc;
> +		bool mapped = false, opened = false, rdpmc_supported;
> +		struct perf_counts_values counts = { .val = 0 };
> +
> +
> +		pr_debug("User space counter reading for PMU %s\n", pmu->name);
> +		/*
> +		 * Restrict scheduling to only use the rdpmc on the CPUs the
> +		 * event can be on. If the test doesn't run on the CPU of the
> +		 * event then the event will be disabled and the pc->index test
> +		 * will fail.
> +		 */
> +		if (pmu->cpus != NULL)
> +			cpu_map__set_affinity(pmu->cpus);
> +
> +		/* Make the evsel. */
> +		evsel = perf_evsel__new(&attr);
> +		if (!evsel) {
> +			pr_err("User space counter reading for PMU %s [Failed to allocate evsel]\n",
> +				pmu->name);
> +			ret = TEST_FAIL;
> +			goto cleanup;
> +		}
>  
> -	if (!pc->cap_user_rdpmc || !pc->index) {
> -		pr_err("userspace counter access not %s\n",
> -			!pc->cap_user_rdpmc ? "supported" : "enabled");
> -		ret = TEST_SKIP;
> -		goto out;
> -	}
> -	if (pc->pmc_width < 32) {
> -		pr_err("userspace counter width not set (%d)\n", pc->pmc_width);
> -		goto out;
> -	}
> +		err = perf_evsel__open(evsel, NULL, threads);
> +		if (err) {
> +			pr_err("User space counter reading for PMU %s [Failed to open evsel]\n",
> +				pmu->name);
> +			ret = TEST_SKIP;
> +			goto cleanup;
> +		}
> +		opened = true;
> +		err = perf_evsel__mmap(evsel, 0);
> +		if (err) {
> +			pr_err("User space counter reading for PMU %s [Failed to mmap evsel]\n",
> +				pmu->name);
> +			ret = TEST_FAIL;
> +			goto cleanup;
> +		}
> +		mapped = true;
> +
> +		pc = perf_evsel__mmap_base(evsel, 0, 0);
> +		if (!pc) {
> +			pr_err("User space counter reading for PMU %s [Failed to get mmaped address]\n",
> +				pmu->name);
> +			ret = TEST_FAIL;
> +			goto cleanup;
> +		}
>  
> -	perf_evsel__read(evsel, 0, 0, &counts);
> -	if (counts.val == 0) {
> -		pr_err("failed to read value for evsel\n");
> -		goto out;
> -	}
> +		if (saved_user_read_state == USER_READ_UNKNOWN)
> +			rdpmc_supported = pc->cap_user_rdpmc && pc->index;
> +		else
> +			rdpmc_supported = (enabled == USER_READ_ENABLED);
>  
> -	for (i = 0; i < 5; i++) {
> -		volatile int count = 0x10000 << i;
> -		__u64 start, end, last = 0;
> +		if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index)) {
> +			pr_err("User space counter reading for PMU %s [Failed unexpected supported counter access %d %d]\n",
> +				pmu->name, pc->cap_user_rdpmc, pc->index);
> +			ret = TEST_FAIL;
> +			goto cleanup;
> +		}
>  
> -		pr_debug("\tloop = %u, ", count);
> +		if (!rdpmc_supported && pc->cap_user_rdpmc) {
> +			pr_err("User space counter reading for PMU %s [Failed unexpected unsupported counter access %d]\n",
> +				pmu->name, pc->cap_user_rdpmc);
> +			ret = TEST_FAIL;
> +			goto cleanup;
> +		}
> +
> +		if (rdpmc_supported && pc->pmc_width < 32) {
> +			pr_err("User space counter reading for PMU %s [Failed width not set %d]\n",
> +				pmu->name, pc->pmc_width);
> +			ret = TEST_FAIL;
> +			goto cleanup;
> +		}
>  
>  		perf_evsel__read(evsel, 0, 0, &counts);
> -		start = counts.val;
> +		if (counts.val == 0) {
> +			pr_err("User space counter reading for PMU %s [Failed read]\n", pmu->name);
> +			ret = TEST_FAIL;
> +			goto cleanup;
> +		}
>  
> -		while (count--) ;
> +		for (int i = 0; i < 5; i++) {
> +			volatile int count = 0x10000 << i;
> +			__u64 start, end, last = 0;
>  
> -		perf_evsel__read(evsel, 0, 0, &counts);
> -		end = counts.val;
> +			pr_debug("\tloop = %u, ", count);
>  
> -		if ((end - start) < last) {
> -			pr_err("invalid counter data: end=%llu start=%llu last= %llu\n",
> -				end, start, last);
> -			goto out;
> -		}
> -		last = end - start;
> -		pr_debug("count = %llu\n", end - start);
> -	}
> -	ret = TEST_OK;
> +			perf_evsel__read(evsel, 0, 0, &counts);
> +			start = counts.val;
> +
> +			while (count--) ;
>  
> -out:
> -	if (mapped)
> -		perf_evsel__munmap(evsel);
> -	if (opened)
> -		perf_evsel__close(evsel);
> -	perf_evsel__delete(evsel);
> +			perf_evsel__read(evsel, 0, 0, &counts);
> +			end = counts.val;
>  
> +			if ((end - start) < last) {
> +				pr_err("User space counter reading for PMU %s [Failed invalid counter data: end=%llu start=%llu last= %llu]\n",
> +					pmu->name, end, start, last);
> +				ret = TEST_FAIL;
> +				goto cleanup;
> +			}
> +			last = end - start;
> +			pr_debug("count = %llu\n", last);
> +		}
> +		pr_debug("User space counter reading for PMU %s [Success]\n", pmu->name);
> +cleanup:
> +		if (mapped)
> +			perf_evsel__munmap(evsel);
> +		if (opened)
> +			perf_evsel__close(evsel);
> +		perf_evsel__delete(evsel);
> +
> +		/* If the affinity was changed, then put it back to all CPUs. */
> +		if (pmu->cpus != NULL) {
> +			struct perf_cpu_map *cpus = cpu_map__online();
> +
> +			cpu_map__set_affinity(cpus);
> +			perf_cpu_map__put(cpus);
> +		}
> +		set_user_read(pmu, saved_user_read_state);
> +	}
>  	perf_thread_map__put(threads);
>  	return ret;
>  }
> @@ -272,20 +375,32 @@ static int test_stat_user_read(int event)
>  static int test__mmap_user_read_instr(struct test_suite *test __maybe_unused,
>  				      int subtest __maybe_unused)
>  {
> -	return test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
> +	return test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS, USER_READ_ENABLED);
>  }
>  
>  static int test__mmap_user_read_cycles(struct test_suite *test __maybe_unused,
>  				       int subtest __maybe_unused)
>  {
> -	return test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);
> +	return test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES, USER_READ_ENABLED);
> +}
> +
> +static int test__mmap_user_read_instr_disabled(struct test_suite *test __maybe_unused,
> +					       int subtest __maybe_unused)
> +{
> +	return test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS, USER_READ_DISABLED);
> +}
> +
> +static int test__mmap_user_read_cycles_disabled(struct test_suite *test __maybe_unused,
> +						int subtest __maybe_unused)
> +{
> +	return test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES, USER_READ_DISABLED);
>  }
>  
>  static struct test_case tests__basic_mmap[] = {
>  	TEST_CASE_REASON("Read samples using the mmap interface",
>  			 basic_mmap,
>  			 "permissions"),
> -	TEST_CASE_REASON("User space counter reading of instructions",
> +	TEST_CASE_REASON_EXCLUSIVE("User space counter reading of instructions",
>  			 mmap_user_read_instr,
>  #if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
>  			 (defined(__riscv) && __riscv_xlen == 64)
> @@ -294,13 +409,31 @@ static struct test_case tests__basic_mmap[] = {
>  			 "unsupported"
>  #endif
>  		),
> -	TEST_CASE_REASON("User space counter reading of cycles",
> +	TEST_CASE_REASON_EXCLUSIVE("User space counter reading of cycles",
>  			 mmap_user_read_cycles,
>  #if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
>  			 (defined(__riscv) && __riscv_xlen == 64)
>  			 "permissions"
>  #else
>  			 "unsupported"
> +#endif
> +		),
> +	TEST_CASE_REASON_EXCLUSIVE("User space counter disabling instructions",
> +			 mmap_user_read_instr_disabled,
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
> +			 (defined(__riscv) && __riscv_xlen == 64)
> +			 "permissions"
> +#else
> +			 "unsupported"
> +#endif
> +		),
> +	TEST_CASE_REASON_EXCLUSIVE("User space counter disabling cycles",
> +			 mmap_user_read_cycles_disabled,
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
> +			 (defined(__riscv) && __riscv_xlen == 64)
> +			 "permissions"
> +#else
> +			 "unsupported"
>  #endif
>  		),
>  	{	.name = NULL, }
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index bb7951c61971..4c128a959441 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -71,6 +71,15 @@ struct test_suite {
>  		.exclusive = true,			\
>  	}
>  
> +#define TEST_CASE_REASON_EXCLUSIVE(description, _name, _reason)	\
> +	{						\
> +		.name = #_name,				\
> +		.desc = description,			\
> +		.run_case = test__##_name,		\
> +		.skip_reason = _reason,			\
> +		.exclusive = true,			\
> +	}
> +
>  #define DEFINE_SUITE(description, _name)		\
>  	struct test_case tests__##_name[] = {           \
>  		TEST_CASE(description, _name),		\
> diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
> index 38dc4524b7e8..4fe851334296 100644
> --- a/tools/perf/util/affinity.c
> +++ b/tools/perf/util/affinity.c
> @@ -5,6 +5,7 @@
>  #include <stdlib.h>
>  #include <linux/bitmap.h>
>  #include <linux/zalloc.h>
> +#include <perf/cpumap.h>
>  #include "perf.h"
>  #include "cpumap.h"
>  #include "affinity.h"
> @@ -83,3 +84,20 @@ void affinity__cleanup(struct affinity *a)
>  	if (a != NULL)
>  		__affinity__cleanup(a);
>  }
> +
> +void cpu_map__set_affinity(const struct perf_cpu_map *cpumap)
> +{
> +	int cpu_set_size = get_cpu_set_size();
> +	unsigned long *cpuset = bitmap_zalloc(cpu_set_size * 8);
> +	struct perf_cpu cpu;
> +	int idx;
> +
> +	if (!cpuset)
> +		return;
> +
> +	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, cpumap)
> +		__set_bit(cpu.cpu, cpuset);
> +
> +	sched_setaffinity(0, cpu_set_size, (cpu_set_t *)cpuset);
> +	zfree(&cpuset);
> +}
> diff --git a/tools/perf/util/affinity.h b/tools/perf/util/affinity.h
> index 0ad6a18ef20c..7341194b2298 100644
> --- a/tools/perf/util/affinity.h
> +++ b/tools/perf/util/affinity.h
> @@ -4,6 +4,7 @@
>  
>  #include <stdbool.h>
>  
> +struct perf_cpu_map;
>  struct affinity {
>  	unsigned long *orig_cpus;
>  	unsigned long *sched_cpus;
> @@ -13,5 +14,6 @@ struct affinity {
>  void affinity__cleanup(struct affinity *a);
>  void affinity__set(struct affinity *a, int cpu);
>  int affinity__setup(struct affinity *a);
> +void cpu_map__set_affinity(const struct perf_cpu_map *cpumap);
>  
>  #endif // PERF_AFFINITY_H


