Return-Path: <linux-kernel+bounces-732486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293E6B06786
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E526500AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9515029B220;
	Tue, 15 Jul 2025 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU2D23OA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7E25392B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610159; cv=none; b=uH1FFk6XiYAox413dbwytogql+RVHA+u8pVbpCBF45o+DiUOz94VNzw+ZMHzYYfjXJtf7p+qfiT7zAosCQKIurpg6sWPBig0jyadpadKic+YxCu9J0tQFw67TplFncoJwJX2+fIQCGSVa9LYB81MXkINvCY9OQpsD3nUnG3QuWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610159; c=relaxed/simple;
	bh=pTKBkYQxvCJDM7hqD1VYZUb+zcoxH0Ug4ny+3/JvRhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZWadQraaeBAgfivP0UuK425qIXmlSgOEfs7bOHmBN7jpvBlFTFXi2EWuTuLy5WmukJlcpk9cZ6Ap7PXIxLl/5i+X0skSeGVh+B3pIjoStFtNgKgoCo5o2ObjQnxN29DBa7W0dfyrX66ZMkemMLzODATf1VkjP15WJ3eBfctNTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU2D23OA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BD7C4CEE3;
	Tue, 15 Jul 2025 20:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752610156;
	bh=pTKBkYQxvCJDM7hqD1VYZUb+zcoxH0Ug4ny+3/JvRhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TU2D23OAqudCoNC4V8XWPYNNIjzy6FGC8nqR25Kxg7VgDawOAK1O3lfmWdLC30Wp5
	 BKTqCdbpmLyDzha6pYAFXZX/7in3ZLjRsHM+GyamQL1Bb7Wn1XcCoYmGW8yneXQAW6
	 +yHXSlJGCqUYSHtb5akY2bQXjhNrEGZJO+iCBuwRNukU2shBv5BaeIbhrfAu+X5WSj
	 3ayHxiUyZJ8KycRteji/XFpcX05vyj0O/TB3oA4y79M9z4JwoLxL3VvuqQ7W1eoo6Y
	 esa5xXwSW4HQMajyD0A8k3NTDCreyD7A1JxfXTDF3zyzr4x6PliWx73pzU56hce9UE
	 q73YunaeeSZhg==
Date: Tue, 15 Jul 2025 13:09:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	acme@kernel.org, tglx@linutronix.de, willy@infradead.org,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v5 04/14] perf bench mem: Pull out init/fini logic
Message-ID: <aHa1avFkfdqoo69S@google.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-5-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710005926.1159009-5-ankur.a.arora@oracle.com>

On Wed, Jul 09, 2025 at 05:59:16PM -0700, Ankur Arora wrote:
> No functional change.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

A nitpick below.

> ---
>  tools/perf/bench/mem-functions.c             | 103 +++++++++++++------
>  tools/perf/bench/mem-memcpy-arch.h           |   2 +-
>  tools/perf/bench/mem-memcpy-x86-64-asm-def.h |   4 +
>  tools/perf/bench/mem-memset-arch.h           |   2 +-
>  tools/perf/bench/mem-memset-x86-64-asm-def.h |   4 +
>  5 files changed, 81 insertions(+), 34 deletions(-)
> 
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index fb17d36a6f6c..06d3ee6f5d69 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -62,15 +62,31 @@ struct bench_params {
>  	unsigned int	nr_loops;
>  };
>  
> +struct bench_mem_info {
> +	const struct function *functions;
> +	int (*do_op)(const struct function *r, struct bench_params *p,
> +		     void *src, void *dst, union bench_clock *rt);
> +	const char *const *usage;
> +	bool alloc_src;
> +};
> +
> +typedef bool (*mem_init_t)(struct bench_mem_info *, struct bench_params *,
> +			   void **, void **);
> +typedef void (*mem_fini_t)(struct bench_mem_info *, struct bench_params *,
> +			   void **, void **);
>  typedef void *(*memcpy_t)(void *, const void *, size_t);
>  typedef void *(*memset_t)(void *, int, size_t);
>  
>  struct function {
>  	const char *name;
>  	const char *desc;
> -	union {
> -		memcpy_t memcpy;
> -		memset_t memset;
> +	struct {
> +		mem_init_t init;
> +		mem_fini_t fini;
> +		union {
> +			memcpy_t memcpy;
> +			memset_t memset;
> +		};
>  	} fn;
>  };
>  
> @@ -138,37 +154,24 @@ static double timeval2double(struct timeval *ts)
>  			printf(" %14lf GB/sec\n", x / K / K / K);	\
>  	} while (0)
>  
> -struct bench_mem_info {
> -	const struct function *functions;
> -	union bench_clock (*do_op)(const struct function *r, struct bench_params *p,
> -				   void *src, void *dst);
> -	const char *const *usage;
> -	bool alloc_src;
> -};
> -
>  static void __bench_mem_function(struct bench_mem_info *info, struct bench_params *p,
>  				 int r_idx)
>  {
>  	const struct function *r = &info->functions[r_idx];
>  	double result_bps = 0.0;
>  	union bench_clock rt = { 0 };
> -	void *src = NULL, *dst = zalloc(p->size);
> +	void *src = NULL, *dst = NULL;
>  
>  	printf("# function '%s' (%s)\n", r->name, r->desc);
>  
> -	if (dst == NULL)
> -		goto out_alloc_failed;
> -
> -	if (info->alloc_src) {
> -		src = zalloc(p->size);
> -		if (src == NULL)
> -			goto out_alloc_failed;
> -	}
> +	if (r->fn.init && r->fn.init(info, p, &src, &dst))
> +		goto out_init_failed;
>  
>  	if (bench_format == BENCH_FORMAT_DEFAULT)
>  		printf("# Copying %s bytes ...\n\n", size_str);
>  
> -	rt = info->do_op(r, p, src, dst);
> +	if (info->do_op(r, p, src, dst, &rt))
> +		goto out_test_failed;
>  
>  	switch (bench_format) {
>  	case BENCH_FORMAT_DEFAULT:
> @@ -194,11 +197,11 @@ static void __bench_mem_function(struct bench_mem_info *info, struct bench_param
>  		break;
>  	}
>  
> +out_test_failed:
>  out_free:
> -	free(src);
> -	free(dst);
> +	if (r->fn.fini) r->fn.fini(info, p, &src, &dst);
>  	return;
> -out_alloc_failed:
> +out_init_failed:
>  	printf("# Memory allocation failed - maybe size (%s) is too large?\n", size_str);
>  	goto out_free;
>  }
> @@ -264,8 +267,8 @@ static void memcpy_prefault(memcpy_t fn, size_t size, void *src, void *dst)
>  	fn(dst, src, size);
>  }
>  
> -static union bench_clock do_memcpy(const struct function *r, struct bench_params *p,
> -				   void *src, void *dst)
> +static int do_memcpy(const struct function *r, struct bench_params *p,
> +		     void *src, void *dst, union bench_clock *rt)
>  {
>  	union bench_clock start, end;
>  	memcpy_t fn = r->fn.memcpy;
> @@ -277,16 +280,47 @@ static union bench_clock do_memcpy(const struct function *r, struct bench_params
>  		fn(dst, src, p->size);
>  	clock_get(&end);
>  
> -	return clock_diff(&start, &end);
> +	*rt = clock_diff(&start, &end);
> +
> +	return 0;
> +}
> +
> +static bool mem_alloc(struct bench_mem_info *info, struct bench_params *p,
> +		      void **src, void **dst)
> +{
> +	bool failed;
> +
> +	*dst = zalloc(p->size);
> +	failed = *dst == NULL;
> +
> +	if (info->alloc_src) {
> +		*src = zalloc(p->size);
> +		failed = failed || *src == NULL;
> +	}
> +
> +	return failed;
> +}
> +
> +static void mem_free(struct bench_mem_info *info __maybe_unused,
> +		     struct bench_params *p __maybe_unused,
> +		     void **src, void **dst)
> +{
> +	free(*dst);
> +	free(*src);
> +
> +	*dst = *src = NULL;

There's zfree() to handle free and reset together.  But probably not
needed as you want to convert it to mmap later.

Thanks,
Namhyung

>  }
>  
>  struct function memcpy_functions[] = {
>  	{ .name		= "default",
>  	  .desc		= "Default memcpy() provided by glibc",
> +	  .fn.init	= mem_alloc,
> +	  .fn.fini	= mem_free,
>  	  .fn.memcpy	= memcpy },
>  
>  #ifdef HAVE_ARCH_X86_64_SUPPORT
> -# define MEMCPY_FN(_fn, _name, _desc) {.name = _name, .desc = _desc, .fn.memcpy = _fn},
> +# define MEMCPY_FN(_fn, _init, _fini, _name, _desc)	\
> +	{.name = _name, .desc = _desc, .fn.memcpy = _fn, .fn.init = _init, .fn.fini = _fini },
>  # include "mem-memcpy-x86-64-asm-def.h"
>  # undef MEMCPY_FN
>  #endif
> @@ -311,8 +345,8 @@ int bench_mem_memcpy(int argc, const char **argv)
>  	return bench_mem_common(argc, argv, &info);
>  }
>  
> -static union bench_clock do_memset(const struct function *r, struct bench_params *p,
> -				   void *src __maybe_unused, void *dst)
> +static int do_memset(const struct function *r, struct bench_params *p,
> +		     void *src __maybe_unused, void *dst, union bench_clock *rt)
>  {
>  	union bench_clock start, end;
>  	memset_t fn = r->fn.memset;
> @@ -328,7 +362,9 @@ static union bench_clock do_memset(const struct function *r, struct bench_params
>  		fn(dst, i, p->size);
>  	clock_get(&end);
>  
> -	return clock_diff(&start, &end);
> +	*rt = clock_diff(&start, &end);
> +
> +	return 0;
>  }
>  
>  static const char * const bench_mem_memset_usage[] = {
> @@ -339,10 +375,13 @@ static const char * const bench_mem_memset_usage[] = {
>  static const struct function memset_functions[] = {
>  	{ .name		= "default",
>  	  .desc		= "Default memset() provided by glibc",
> +	  .fn.init	= mem_alloc,
> +	  .fn.fini	= mem_free,
>  	  .fn.memset	= memset },
>  
>  #ifdef HAVE_ARCH_X86_64_SUPPORT
> -# define MEMSET_FN(_fn, _name, _desc) { .name = _name, .desc = _desc, .fn.memset = _fn },
> +# define MEMSET_FN(_fn, _init, _fini, _name, _desc) \
> +	{.name = _name, .desc = _desc, .fn.memset = _fn, .fn.init = _init, .fn.fini = _fini },
>  # include "mem-memset-x86-64-asm-def.h"
>  # undef MEMSET_FN
>  #endif
> diff --git a/tools/perf/bench/mem-memcpy-arch.h b/tools/perf/bench/mem-memcpy-arch.h
> index 5bcaec5601a8..852e48cfd8fe 100644
> --- a/tools/perf/bench/mem-memcpy-arch.h
> +++ b/tools/perf/bench/mem-memcpy-arch.h
> @@ -2,7 +2,7 @@
>  
>  #ifdef HAVE_ARCH_X86_64_SUPPORT
>  
> -#define MEMCPY_FN(fn, name, desc)		\
> +#define MEMCPY_FN(fn, init, fini, name, desc)		\
>  	void *fn(void *, const void *, size_t);
>  
>  #include "mem-memcpy-x86-64-asm-def.h"
> diff --git a/tools/perf/bench/mem-memcpy-x86-64-asm-def.h b/tools/perf/bench/mem-memcpy-x86-64-asm-def.h
> index 6188e19d3129..f43038f4448b 100644
> --- a/tools/perf/bench/mem-memcpy-x86-64-asm-def.h
> +++ b/tools/perf/bench/mem-memcpy-x86-64-asm-def.h
> @@ -1,9 +1,13 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  
>  MEMCPY_FN(memcpy_orig,
> +	mem_alloc,
> +	mem_free,
>  	"x86-64-unrolled",
>  	"unrolled memcpy() in arch/x86/lib/memcpy_64.S")
>  
>  MEMCPY_FN(__memcpy,
> +	mem_alloc,
> +	mem_free,
>  	"x86-64-movsq",
>  	"movsq-based memcpy() in arch/x86/lib/memcpy_64.S")
> diff --git a/tools/perf/bench/mem-memset-arch.h b/tools/perf/bench/mem-memset-arch.h
> index 53f45482663f..278c5da12d63 100644
> --- a/tools/perf/bench/mem-memset-arch.h
> +++ b/tools/perf/bench/mem-memset-arch.h
> @@ -2,7 +2,7 @@
>  
>  #ifdef HAVE_ARCH_X86_64_SUPPORT
>  
> -#define MEMSET_FN(fn, name, desc)		\
> +#define MEMSET_FN(fn, init, fini, name, desc)	\
>  	void *fn(void *, int, size_t);
>  
>  #include "mem-memset-x86-64-asm-def.h"
> diff --git a/tools/perf/bench/mem-memset-x86-64-asm-def.h b/tools/perf/bench/mem-memset-x86-64-asm-def.h
> index 247c72fdfb9d..80ad1b7ea770 100644
> --- a/tools/perf/bench/mem-memset-x86-64-asm-def.h
> +++ b/tools/perf/bench/mem-memset-x86-64-asm-def.h
> @@ -1,9 +1,13 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  
>  MEMSET_FN(memset_orig,
> +	mem_alloc,
> +	mem_free,
>  	"x86-64-unrolled",
>  	"unrolled memset() in arch/x86/lib/memset_64.S")
>  
>  MEMSET_FN(__memset,
> +	mem_alloc,
> +	mem_free,
>  	"x86-64-stosq",
>  	"movsq-based memset() in arch/x86/lib/memset_64.S")
> -- 
> 2.43.5
> 

