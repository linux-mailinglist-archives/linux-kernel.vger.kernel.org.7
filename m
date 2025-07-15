Return-Path: <linux-kernel+bounces-732481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B95D8B06774
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC59B171DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D26285C98;
	Tue, 15 Jul 2025 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aamh6zhg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE54DF76
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609861; cv=none; b=lmZgpkzjwOoydWq5Pj0G8VZB2ilZX+0QTAj8OLxEnRL0hAklUxvzXvrds0XLY9vIW1FZhzgMpzY710drYOtQpDe858MrqTvLUQAk8qsHOqU8FcHOVtBAYjAOmEgxwBKLUiKpgmHAcdjS97s0D5s6vDNoKc+28YKzYlXH3Vsr39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609861; c=relaxed/simple;
	bh=OKC/WrbCugWmfw4kWzTGSKbml7jMOGQBJeszqTV0fDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIxGKkL4inrv7XKuE/3L33UsqflIrs/WJVrQ+CKO62grcj42M8WvunihYS3CxhXAms4TQE6YGxKOHOLCfKpv60T9FDrrlxT8K4ivS/cVrXPM8GQnSmLAFVddkMA6Ck7ZHrtyA76mBUgxD/SStu7y92VMDKuIUnPMqJDak6Y1YqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aamh6zhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A18C4CEE3;
	Tue, 15 Jul 2025 20:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752609859;
	bh=OKC/WrbCugWmfw4kWzTGSKbml7jMOGQBJeszqTV0fDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aamh6zhgupF5oTFFWjy1Pl2sksJr7KEijt+a0hR2NMDnx661aHRWH4SGr+P+axPuP
	 B378ik3uRQdDvzMWaetFgO7qu+sB9RLvS0gsucKu6pLbCLvWzGG2NKCG1Xkky5OKbz
	 q4i1NzaljZlkuHWL4ojhfGv6hJzqRxMlxQX/2RK9p13qW9hZVQUirHMivhZFDrig8D
	 L9xSpdj+ZskfjIzNTyjpMYUzg5Sq2A8Mlcn74At7DysSlV4vuRfXJZvb5VnOTTR4PK
	 Nh4yGthLXjXn/mfRDg4zAK1ueXiSn+ufWwqS/jZAQQnl2ooOrlHjRwSz4xa925wmBd
	 rbo+JCJQuf1Jg==
Date: Tue, 15 Jul 2025 13:04:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	acme@kernel.org, tglx@linutronix.de, willy@infradead.org,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v5 01/14] perf bench mem: Remove repetition around time
 measurement
Message-ID: <aHa0QLtTCe1BmkMd@google.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710005926.1159009-2-ankur.a.arora@oracle.com>

Hello,

On Wed, Jul 09, 2025 at 05:59:13PM -0700, Ankur Arora wrote:
> We have two copies of each mem benchmark: one using cycles to
> measure time, the second for gettimeofday().
> 
> Unify.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/bench/mem-functions.c | 110 +++++++++++++------------------
>  1 file changed, 46 insertions(+), 64 deletions(-)
> 
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index 19d45c377ac1..8599ed96ee1f 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -51,6 +51,11 @@ static const struct option options[] = {
>  	OPT_END()
>  };
>  
> +union bench_clock {
> +	u64		cycles;
> +	struct timeval	tv;
> +};
> +
>  typedef void *(*memcpy_t)(void *, const void *, size_t);
>  typedef void *(*memset_t)(void *, int, size_t);
>  
> @@ -91,6 +96,26 @@ static u64 get_cycles(void)
>  	return clk;
>  }
>  
> +static void clock_get(union bench_clock *t)
> +{
> +	if (use_cycles)
> +		t->cycles = get_cycles();
> +	else
> +		BUG_ON(gettimeofday(&t->tv, NULL));
> +}
> +
> +static union bench_clock clock_diff(union bench_clock *s, union bench_clock *e)
> +{
> +	union bench_clock t;
> +
> +	if (use_cycles)
> +		t.cycles = e->cycles - s->cycles;
> +	else
> +		timersub(&e->tv, &s->tv, &t.tv);
> +
> +	return t;
> +}
> +
>  static double timeval2double(struct timeval *ts)
>  {
>  	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC;
> @@ -109,8 +134,7 @@ static double timeval2double(struct timeval *ts)
>  
>  struct bench_mem_info {
>  	const struct function *functions;
> -	u64 (*do_cycles)(const struct function *r, size_t size, void *src, void *dst);
> -	double (*do_gettimeofday)(const struct function *r, size_t size, void *src, void *dst);
> +	union bench_clock (*do_op)(const struct function *r, size_t size, void *src, void *dst);
>  	const char *const *usage;
>  	bool alloc_src;
>  };
> @@ -119,7 +143,7 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
>  {
>  	const struct function *r = &info->functions[r_idx];
>  	double result_bps = 0.0;
> -	u64 result_cycles = 0;
> +	union bench_clock rt = { 0 };
>  	void *src = NULL, *dst = zalloc(size);
>  
>  	printf("# function '%s' (%s)\n", r->name, r->desc);
> @@ -136,25 +160,23 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
>  	if (bench_format == BENCH_FORMAT_DEFAULT)
>  		printf("# Copying %s bytes ...\n\n", size_str);
>  
> -	if (use_cycles) {
> -		result_cycles = info->do_cycles(r, size, src, dst);
> -	} else {
> -		result_bps = info->do_gettimeofday(r, size, src, dst);
> -	}
> +	rt = info->do_op(r, size, src, dst);
>  
>  	switch (bench_format) {
>  	case BENCH_FORMAT_DEFAULT:
>  		if (use_cycles) {
> -			printf(" %14lf cycles/byte\n", (double)result_cycles/size_total);
> +			printf(" %14lf cycles/byte\n", (double)rt.cycles/size_total);
>  		} else {
> +			result_bps = size_total/timeval2double(&rt.tv);
>  			print_bps(result_bps);
>  		}
>  		break;
>  
>  	case BENCH_FORMAT_SIMPLE:
>  		if (use_cycles) {
> -			printf("%lf\n", (double)result_cycles/size_total);
> +			printf("%lf\n", (double)rt.cycles/size_total);
>  		} else {
> +			result_bps = size_total/timeval2double(&rt.tv);
>  			printf("%lf\n", result_bps);
>  		}
>  		break;
> @@ -235,38 +257,21 @@ static void memcpy_prefault(memcpy_t fn, size_t size, void *src, void *dst)
>  	fn(dst, src, size);
>  }
>  
> -static u64 do_memcpy_cycles(const struct function *r, size_t size, void *src, void *dst)
> +static union bench_clock do_memcpy(const struct function *r, size_t size,
> +				   void *src, void *dst)
>  {
> -	u64 cycle_start = 0ULL, cycle_end = 0ULL;
> +	union bench_clock start, end;
>  	memcpy_t fn = r->fn.memcpy;
>  	int i;
>  
>  	memcpy_prefault(fn, size, src, dst);
>  
> -	cycle_start = get_cycles();
> +	clock_get(&start);
>  	for (i = 0; i < nr_loops; ++i)
>  		fn(dst, src, size);
> -	cycle_end = get_cycles();
> +	clock_get(&end);
>  
> -	return cycle_end - cycle_start;
> -}
> -
> -static double do_memcpy_gettimeofday(const struct function *r, size_t size, void *src, void *dst)
> -{
> -	struct timeval tv_start, tv_end, tv_diff;
> -	memcpy_t fn = r->fn.memcpy;
> -	int i;
> -
> -	memcpy_prefault(fn, size, src, dst);
> -
> -	BUG_ON(gettimeofday(&tv_start, NULL));
> -	for (i = 0; i < nr_loops; ++i)
> -		fn(dst, src, size);
> -	BUG_ON(gettimeofday(&tv_end, NULL));
> -
> -	timersub(&tv_end, &tv_start, &tv_diff);
> -
> -	return (double)(((double)size * nr_loops) / timeval2double(&tv_diff));
> +	return clock_diff(&start, &end);
>  }
>  
>  struct function memcpy_functions[] = {
> @@ -292,8 +297,7 @@ int bench_mem_memcpy(int argc, const char **argv)
>  {
>  	struct bench_mem_info info = {
>  		.functions		= memcpy_functions,
> -		.do_cycles		= do_memcpy_cycles,
> -		.do_gettimeofday	= do_memcpy_gettimeofday,
> +		.do_op			= do_memcpy,
>  		.usage			= bench_mem_memcpy_usage,
>  		.alloc_src              = true,
>  	};
> @@ -301,9 +305,10 @@ int bench_mem_memcpy(int argc, const char **argv)
>  	return bench_mem_common(argc, argv, &info);
>  }
>  
> -static u64 do_memset_cycles(const struct function *r, size_t size, void *src __maybe_unused, void *dst)
> +static union bench_clock do_memset(const struct function *r, size_t size,
> +				   void *src __maybe_unused, void *dst)
>  {
> -	u64 cycle_start = 0ULL, cycle_end = 0ULL;
> +	union bench_clock start, end;
>  	memset_t fn = r->fn.memset;
>  	int i;
>  
> @@ -313,34 +318,12 @@ static u64 do_memset_cycles(const struct function *r, size_t size, void *src __m
>  	 */
>  	fn(dst, -1, size);
>  
> -	cycle_start = get_cycles();
> +	clock_get(&start);
>  	for (i = 0; i < nr_loops; ++i)
>  		fn(dst, i, size);
> -	cycle_end = get_cycles();
> +	clock_get(&end);
>  
> -	return cycle_end - cycle_start;
> -}
> -
> -static double do_memset_gettimeofday(const struct function *r, size_t size, void *src __maybe_unused, void *dst)
> -{
> -	struct timeval tv_start, tv_end, tv_diff;
> -	memset_t fn = r->fn.memset;
> -	int i;
> -
> -	/*
> -	 * We prefault the freshly allocated memory range here,
> -	 * to not measure page fault overhead:
> -	 */
> -	fn(dst, -1, size);
> -
> -	BUG_ON(gettimeofday(&tv_start, NULL));
> -	for (i = 0; i < nr_loops; ++i)
> -		fn(dst, i, size);
> -	BUG_ON(gettimeofday(&tv_end, NULL));
> -
> -	timersub(&tv_end, &tv_start, &tv_diff);
> -
> -	return (double)(((double)size * nr_loops) / timeval2double(&tv_diff));
> +	return clock_diff(&start, &end);
>  }
>  
>  static const char * const bench_mem_memset_usage[] = {
> @@ -366,8 +349,7 @@ int bench_mem_memset(int argc, const char **argv)
>  {
>  	struct bench_mem_info info = {
>  		.functions		= memset_functions,
> -		.do_cycles		= do_memset_cycles,
> -		.do_gettimeofday	= do_memset_gettimeofday,
> +		.do_op			= do_memset,
>  		.usage			= bench_mem_memset_usage,
>  	};
>  
> -- 
> 2.43.5
> 

