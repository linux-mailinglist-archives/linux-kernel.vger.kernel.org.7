Return-Path: <linux-kernel+bounces-732484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F49B06781
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1792518876F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8040F286D75;
	Tue, 15 Jul 2025 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNpu++l9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F0BE65
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609978; cv=none; b=JEW1GqKk+/QAdbH/8xHuzyeEgYcFxgKjTyXg3R8YWhU+4HNZUkdBN71YQ+ySPephskqbtgStCvPYOQfbarhiaP9nIOGjx9CTZ7oghQ0iFxVr7Eady0nRsuwaRE5Uyn3LGDKFpveaoP0cKPOeWeh4DHRLj6bNlBvxa1KOY6AEiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609978; c=relaxed/simple;
	bh=xozF1Gv6XMBXHrdxPUdk15zH0lRQ4LG8HUiGBxCudEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxnxdPOZhi2I4BEX78B4qzJGhg2AoLsbKucKHtuvxeu0DczFxABSgGNqHBj5C+knWEznnSHBf5w7rvILhSqUUJz/lOCm3hSI9Hnuwqxtczx0qs+fI0WjVMYpXOVEGqXUnRsMszPEQt2783/gvv4oNA2LFHYuMyn7Pao7mfyM4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNpu++l9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D98C4CEE3;
	Tue, 15 Jul 2025 20:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752609974;
	bh=xozF1Gv6XMBXHrdxPUdk15zH0lRQ4LG8HUiGBxCudEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UNpu++l9xEkiFcJUudJvlR6mpvFI4vrQwy4mQM/t9Ai+SDkko1kzXluA9kLKMvHyZ
	 8LuHGl1pQmMFYI4Ae5hQaYG7acmbntsBoCZuxq0Xg9Mb9dM47FRgZjZSzKv/InJHFX
	 3aEmxlgee+mM4ZFLYNDuAxk25pl6qtJiAQAmMqjqyggOYRobCsAGeoD5cBgF04MAab
	 dV8M77wVumcmmD9nX4NlmB9yMs4erZoVWMY7/1xaTzGNuMKzG8zAq72mT4bqNPHusg
	 pzKR4uKnRDqwJaYCFfbMx8PGZU9CV5ecXt0R0E1rcPeoaIhbxQqYcL+XDWFdcpuP7R
	 Hsab5jji3Rurg==
Date: Tue, 15 Jul 2025 13:06:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	acme@kernel.org, tglx@linutronix.de, willy@infradead.org,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v5 03/14] perf bench mem: Move mem op parameters into a
 structure
Message-ID: <aHa0tPPBcfKSK-E5@google.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710005926.1159009-4-ankur.a.arora@oracle.com>

On Wed, Jul 09, 2025 at 05:59:15PM -0700, Ankur Arora wrote:
> Move benchmark function parameters in struct bench_params.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/bench/mem-functions.c | 63 +++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index b8f020379197..fb17d36a6f6c 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -30,7 +30,7 @@
>  
>  static const char	*size_str	= "1MB";
>  static const char	*function_str	= "all";
> -static int		nr_loops	= 1;
> +static unsigned int	nr_loops	= 1;
>  static bool		use_cycles;
>  static int		cycles_fd;
>  
> @@ -42,7 +42,7 @@ static const struct option options[] = {
>  	OPT_STRING('f', "function", &function_str, "all",
>  		    "Specify the function to run, \"all\" runs all available functions, \"help\" lists them"),
>  
> -	OPT_INTEGER('l', "nr_loops", &nr_loops,
> +	OPT_UINTEGER('l', "nr_loops", &nr_loops,
>  		    "Specify the number of loops to run. (default: 1)"),
>  
>  	OPT_BOOLEAN('c', "cycles", &use_cycles,
> @@ -56,6 +56,12 @@ union bench_clock {
>  	struct timeval	tv;
>  };
>  
> +struct bench_params {
> +	size_t		size;
> +	size_t		size_total;
> +	unsigned int	nr_loops;
> +};
> +
>  typedef void *(*memcpy_t)(void *, const void *, size_t);
>  typedef void *(*memset_t)(void *, int, size_t);
>  
> @@ -134,17 +140,19 @@ static double timeval2double(struct timeval *ts)
>  
>  struct bench_mem_info {
>  	const struct function *functions;
> -	union bench_clock (*do_op)(const struct function *r, size_t size, void *src, void *dst);
> +	union bench_clock (*do_op)(const struct function *r, struct bench_params *p,
> +				   void *src, void *dst);
>  	const char *const *usage;
>  	bool alloc_src;
>  };
>  
> -static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t size, size_t size_total)
> +static void __bench_mem_function(struct bench_mem_info *info, struct bench_params *p,
> +				 int r_idx)
>  {
>  	const struct function *r = &info->functions[r_idx];
>  	double result_bps = 0.0;
>  	union bench_clock rt = { 0 };
> -	void *src = NULL, *dst = zalloc(size);
> +	void *src = NULL, *dst = zalloc(p->size);
>  
>  	printf("# function '%s' (%s)\n", r->name, r->desc);
>  
> @@ -152,7 +160,7 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
>  		goto out_alloc_failed;
>  
>  	if (info->alloc_src) {
> -		src = zalloc(size);
> +		src = zalloc(p->size);
>  		if (src == NULL)
>  			goto out_alloc_failed;
>  	}
> @@ -160,23 +168,23 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
>  	if (bench_format == BENCH_FORMAT_DEFAULT)
>  		printf("# Copying %s bytes ...\n\n", size_str);
>  
> -	rt = info->do_op(r, size, src, dst);
> +	rt = info->do_op(r, p, src, dst);
>  
>  	switch (bench_format) {
>  	case BENCH_FORMAT_DEFAULT:
>  		if (use_cycles) {
> -			printf(" %14lf cycles/byte\n", (double)rt.cycles/(double)size_total);
> +			printf(" %14lf cycles/byte\n", (double)rt.cycles/(double)p->size_total);
>  		} else {
> -			result_bps = (double)size_total/timeval2double(&rt.tv);
> +			result_bps = (double)p->size_total/timeval2double(&rt.tv);
>  			print_bps(result_bps);
>  		}
>  		break;
>  
>  	case BENCH_FORMAT_SIMPLE:
>  		if (use_cycles) {
> -			printf("%lf\n", (double)rt.cycles/(double)size_total);
> +			printf("%lf\n", (double)rt.cycles/(double)p->size_total);
>  		} else {
> -			result_bps = (double)size_total/timeval2double(&rt.tv);
> +			result_bps = (double)p->size_total/timeval2double(&rt.tv);
>  			printf("%lf\n", result_bps);
>  		}
>  		break;
> @@ -198,8 +206,7 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
>  static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *info)
>  {
>  	int i;
> -	size_t size;
> -	size_t size_total;
> +	struct bench_params p = { 0 };
>  
>  	argc = parse_options(argc, argv, options, info->usage, 0);
>  
> @@ -211,17 +218,17 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
>  		}
>  	}
>  
> -	size = (size_t)perf_atoll((char *)size_str);
> -	size_total = (size_t)size * nr_loops;
> -
> -	if ((s64)size <= 0) {
> +	p.nr_loops = nr_loops;
> +	p.size = (size_t)perf_atoll((char *)size_str);
> +	if ((s64)p.size <= 0) {
>  		fprintf(stderr, "Invalid size:%s\n", size_str);
>  		return 1;
>  	}
> +	p.size_total = (size_t)p.size * p.nr_loops;
>  
>  	if (!strncmp(function_str, "all", 3)) {
>  		for (i = 0; info->functions[i].name; i++)
> -			__bench_mem_function(info, i, size, size_total);
> +			__bench_mem_function(info, &p, i);
>  		return 0;
>  	}
>  
> @@ -240,7 +247,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
>  		return 1;
>  	}
>  
> -	__bench_mem_function(info, i, size, size_total);
> +	__bench_mem_function(info, &p, i);
>  
>  	return 0;
>  }
> @@ -257,18 +264,17 @@ static void memcpy_prefault(memcpy_t fn, size_t size, void *src, void *dst)
>  	fn(dst, src, size);
>  }
>  
> -static union bench_clock do_memcpy(const struct function *r, size_t size,
> +static union bench_clock do_memcpy(const struct function *r, struct bench_params *p,
>  				   void *src, void *dst)
>  {
>  	union bench_clock start, end;
>  	memcpy_t fn = r->fn.memcpy;
> -	int i;
>  
> -	memcpy_prefault(fn, size, src, dst);
> +	memcpy_prefault(fn, p->size, src, dst);
>  
>  	clock_get(&start);
> -	for (i = 0; i < nr_loops; ++i)
> -		fn(dst, src, size);
> +	for (unsigned int i = 0; i < p->nr_loops; ++i)
> +		fn(dst, src, p->size);
>  	clock_get(&end);
>  
>  	return clock_diff(&start, &end);
> @@ -305,22 +311,21 @@ int bench_mem_memcpy(int argc, const char **argv)
>  	return bench_mem_common(argc, argv, &info);
>  }
>  
> -static union bench_clock do_memset(const struct function *r, size_t size,
> +static union bench_clock do_memset(const struct function *r, struct bench_params *p,
>  				   void *src __maybe_unused, void *dst)
>  {
>  	union bench_clock start, end;
>  	memset_t fn = r->fn.memset;
> -	int i;
>  
>  	/*
>  	 * We prefault the freshly allocated memory range here,
>  	 * to not measure page fault overhead:
>  	 */
> -	fn(dst, -1, size);
> +	fn(dst, -1, p->size);
>  
>  	clock_get(&start);
> -	for (i = 0; i < nr_loops; ++i)
> -		fn(dst, i, size);
> +	for (unsigned int i = 0; i < p->nr_loops; ++i)
> +		fn(dst, i, p->size);
>  	clock_get(&end);
>  
>  	return clock_diff(&start, &end);
> -- 
> 2.43.5
> 

