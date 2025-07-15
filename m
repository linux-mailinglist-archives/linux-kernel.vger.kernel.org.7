Return-Path: <linux-kernel+bounces-732499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F7AB067AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C329E4E17E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4222BE64E;
	Tue, 15 Jul 2025 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cnj5i1Mh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255E277CBD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610820; cv=none; b=aKbkDJ1hL7djKuwO2HO49N43lARNOWzXyylJR39o6YlP65ESHt1yWxItdQqWX6Bx3v2SViYWUtohoaKEMPhm1o78odLSBgot4PrcCk3UnMmg+CLea3Fdsl5LbgQFes4hHGvJ7seKkY3ql5SvS5tPrgNXuUcplY5Zm+AqJnQIjCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610820; c=relaxed/simple;
	bh=VDjHAjEESu5pACeK6VWZE2soOFSvFsRrQ2uQNbZDJ7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uz/Jg6d7p2zKb6lt70T9Rmc59zrE5eDIhUuB9e1SpY3nUyMtLsjtOc7+5zWBlYH8F3xkuI/GRJxZuDH9efq8zdOdUyL17l3hrFfO0jYVEoOXjZFvDzN6mdfevjBoQkD6nSRXimDvP1e++5QYVCodkognAHNAN7IfBiHmafDKqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cnj5i1Mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BB3C4CEE3;
	Tue, 15 Jul 2025 20:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752610818;
	bh=VDjHAjEESu5pACeK6VWZE2soOFSvFsRrQ2uQNbZDJ7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cnj5i1MhTWs2rFnzlbhjXQX5rr74QpEWOkAvyZHnxVt3uXPO/EapOeoxjGk0Deumx
	 XV0SijHYXCXsm51ZIEmco6LeXKq3hKTJaxjTMpwZ/b3IMRFqacZajluxMND8dkeYoS
	 Lz2INE6t9b/j2AnAwiv5WPshSJPMlHqAIM+HLXxo3yCtOi/wbYahRA5jUcpHIBhaj/
	 xLU+8zQFSkV5TxPFpateKiHB/WNeoJGm5LwQGFB0pFcHoQEN5nVfx3jQ/FqJYaHupc
	 HEEXbpzBMBGh+RCkBom9smRDL5mAwwXj4s+UzdDaz4IfHkhkeUY/sSEtja7ZEY/a6Z
	 MPPJZ/Oerzg1g==
Date: Tue, 15 Jul 2025 13:20:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	acme@kernel.org, tglx@linutronix.de, willy@infradead.org,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v5 09/14] perf bench mem: Add mmap() workloads
Message-ID: <aHa3_9ijsm3FC6_8@google.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-10-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710005926.1159009-10-ankur.a.arora@oracle.com>

On Wed, Jul 09, 2025 at 05:59:21PM -0700, Ankur Arora wrote:
> Add two mmap() workloads: one that eagerly populates a region and
> another that demand faults it in.
> 
> The intent is to probe the memory subsytem performance incurred
> by mmap().

Maybe better to name 'mmap' as other tests named after the actual
function.  Also please update the documentation.

Thanks,
Namhyung


> 
>   $ perf bench mem map -s 4gb -p 4kb -l 10 -f populate
>   # Running 'mem/map' benchmark:
>   # function 'populate' (Eagerly populated map)
>   # Copying 4gb bytes ...
> 
>        1.811691 GB/sec
> 
>   $ perf bench mem map -s 4gb -p 2mb -l 10 -f populate
>   # Running 'mem/map' benchmark:
>   # function 'populate' (Eagerly populated map)
>   # Copying 4gb bytes ...
> 
>       12.272017 GB/sec
> 
>   $ perf bench mem map -s 4gb -p 1gb -l 10 -f populate
>   # Running 'mem/map' benchmark:
>   # function 'populate' (Eagerly populated map)
>   # Copying 4gb bytes ...
> 
>       17.085927 GB/sec
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  tools/perf/bench/bench.h         |  1 +
>  tools/perf/bench/mem-functions.c | 96 ++++++++++++++++++++++++++++++++
>  tools/perf/builtin-bench.c       |  1 +
>  3 files changed, 98 insertions(+)
> 
> diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> index 9f736423af53..46484bb0eefb 100644
> --- a/tools/perf/bench/bench.h
> +++ b/tools/perf/bench/bench.h
> @@ -28,6 +28,7 @@ int bench_syscall_fork(int argc, const char **argv);
>  int bench_syscall_execve(int argc, const char **argv);
>  int bench_mem_memcpy(int argc, const char **argv);
>  int bench_mem_memset(int argc, const char **argv);
> +int bench_mem_map(int argc, const char **argv);
>  int bench_mem_find_bit(int argc, const char **argv);
>  int bench_futex_hash(int argc, const char **argv);
>  int bench_futex_wake(int argc, const char **argv);
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index 8a37da149327..ea62e3583a70 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -40,6 +40,7 @@ static const char	*chunk_size_str	= "0";
>  static unsigned int	nr_loops	= 1;
>  static bool		use_cycles;
>  static int		cycles_fd;
> +static unsigned int	seed;
>  
>  static const struct option bench_common_options[] = {
>  	OPT_STRING('s', "size", &size_str, "1MB",
> @@ -81,6 +82,7 @@ struct bench_params {
>  	size_t		chunk_size;
>  	unsigned int	nr_loops;
>  	unsigned int	page_shift;
> +	unsigned int	seed;
>  };
>  
>  struct bench_mem_info {
> @@ -98,6 +100,7 @@ typedef void (*mem_fini_t)(struct bench_mem_info *, struct bench_params *,
>  			   void **, void **);
>  typedef void *(*memcpy_t)(void *, const void *, size_t);
>  typedef void *(*memset_t)(void *, int, size_t);
> +typedef void (*map_op_t)(void *, size_t, unsigned int, bool);
>  
>  struct function {
>  	const char *name;
> @@ -108,6 +111,7 @@ struct function {
>  		union {
>  			memcpy_t memcpy;
>  			memset_t memset;
> +			map_op_t map_op;
>  		};
>  	} fn;
>  };
> @@ -160,6 +164,14 @@ static union bench_clock clock_diff(union bench_clock *s, union bench_clock *e)
>  	return t;
>  }
>  
> +static void clock_accum(union bench_clock *a, union bench_clock *b)
> +{
> +	if (use_cycles)
> +		a->cycles += b->cycles;
> +	else
> +		timeradd(&a->tv, &b->tv, &a->tv);
> +}
> +
>  static double timeval2double(struct timeval *ts)
>  {
>  	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC;
> @@ -270,6 +282,8 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
>  	}
>  	p.page_shift = ilog2(page_size);
>  
> +	p.seed = seed;
> +
>  	if (!strncmp(function_str, "all", 3)) {
>  		for (i = 0; info->functions[i].name; i++)
>  			__bench_mem_function(info, &p, i);
> @@ -464,3 +478,85 @@ int bench_mem_memset(int argc, const char **argv)
>  
>  	return bench_mem_common(argc, argv, &info);
>  }
> +
> +static void map_page_touch(void *dst, size_t size, unsigned int page_shift, bool random)
> +{
> +	unsigned long npages = size / (1 << page_shift);
> +	unsigned long offset = 0, r = 0;
> +
> +	for (unsigned long i = 0; i < npages; i++) {
> +		if (random)
> +			r = rand() % (1 << page_shift);
> +
> +		*((char *)dst + offset + r) = *(char *)(dst + offset + r) + i;
> +		offset += 1 << page_shift;
> +	}
> +}
> +
> +static int do_map(const struct function *r, struct bench_params *p,
> +		  void *src __maybe_unused, void *dst __maybe_unused,
> +		  union bench_clock *accum)
> +{
> +	union bench_clock start, end, diff;
> +	map_op_t fn = r->fn.map_op;
> +	bool populate = strcmp(r->name, "populate") == 0;
> +
> +	if (p->seed)
> +		srand(p->seed);
> +
> +	for (unsigned int i = 0; i < p->nr_loops; i++) {
> +		clock_get(&start);
> +		dst = bench_mmap(p->size, populate, p->page_shift);
> +		if (!dst)
> +			goto out;
> +
> +		fn(dst, p->size, p->page_shift, p->seed);
> +		clock_get(&end);
> +		diff = clock_diff(&start, &end);
> +		clock_accum(accum, &diff);
> +
> +		bench_munmap(dst, p->size);
> +	}
> +
> +	return 0;
> +out:
> +	printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
> +			p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
> +	return -1;
> +}
> +
> +static const char * const bench_mem_map_usage[] = {
> +	"perf bench mem map <options>",
> +	NULL
> +};
> +
> +static const struct function map_functions[] = {
> +	{ .name		= "populate",
> +	  .desc		= "Eagerly populated map",
> +	  .fn.map_op	= map_page_touch },
> +
> +	{ .name		= "demand",
> +	  .desc		= "Demand loaded map",
> +	  .fn.map_op	= map_page_touch },
> +
> +	{ .name = NULL, }
> +};
> +
> +int bench_mem_map(int argc, const char **argv)
> +{
> +	static const struct option bench_map_options[] = {
> +		OPT_UINTEGER('r', "randomize", &seed,
> +			    "Seed to randomize page RW offset with."),
> +		OPT_PARENT(bench_common_options),
> +		OPT_END()
> +	};
> +
> +	struct bench_mem_info info = {
> +		.functions		= map_functions,
> +		.do_op			= do_map,
> +		.usage			= bench_mem_map_usage,
> +		.options		= bench_map_options,
> +	};
> +
> +	return bench_mem_common(argc, argv, &info);
> +}
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index 2c1a9f3d847a..a20bd9882f0a 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -65,6 +65,7 @@ static struct bench mem_benchmarks[] = {
>  	{ "memcpy",	"Benchmark for memcpy() functions",		bench_mem_memcpy	},
>  	{ "memset",	"Benchmark for memset() functions",		bench_mem_memset	},
>  	{ "find_bit",	"Benchmark for find_bit() functions",		bench_mem_find_bit	},
> +	{ "map",	"Benchmark for mmap() mappings",		bench_mem_map		},
>  	{ "all",	"Run all memory access benchmarks",		NULL			},
>  	{ NULL,		NULL,						NULL			}
>  };
> -- 
> 2.43.5
> 

