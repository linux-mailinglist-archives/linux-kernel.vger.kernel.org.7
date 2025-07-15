Return-Path: <linux-kernel+bounces-732489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110E4B06793
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271D23B8402
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1151828C864;
	Tue, 15 Jul 2025 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Phh0UF8h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3D229CE1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610339; cv=none; b=oql6ji6KAdMufOURsm/rokAptOzcBlXgDlsA8CCtDbhOvpu9h7aaM1BIULiOf4N3h6A98MqSmWpSvQM7kknIBMiI+uCJFYQK0mAKOS4BqrUI1up4XsCQLIGC1GjblDJjxnoSD0OnD1lUxUcuG8qIL8IIFXPTJaZuLv53w/0u0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610339; c=relaxed/simple;
	bh=Ugj3SvyZeQC/ZYk7Yjls7+GuE+Ryu5ToxJ5cbuJU0Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyY7QTEj5zADndz/iZ/I6lZcX/+c/Sw44YcpN3BneAU+7Wq98f/zbLJAeElgTeE9yhErQST+inCFwcnHgtSi7CkCKW7it199kWNF0CjYO2Ni/zMclb825Dt59YWimC/QJXtN5rQaqtyeT8cqzvQi2QB5PGS+1ZYT6us/AA/Ijws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Phh0UF8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF399C4CEE3;
	Tue, 15 Jul 2025 20:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752610334;
	bh=Ugj3SvyZeQC/ZYk7Yjls7+GuE+Ryu5ToxJ5cbuJU0Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Phh0UF8hnir7yoDF8nMzQrr9gLcs5wJi+PfJm2hyasiCV39b8bvPjsG7rZx8C8osq
	 smDi4x1lcZqYGB6QuqG1PsPATyY3QJNgkLAQVCWDjinX1MBrJgPPvp9DoAu9nwI0te
	 kEv5HKyfmd5obpA6C5uNJHNdom4Oz+27N+hRmTr1c/5TIgqWaPZFVeT1LNKmP8OFng
	 NT6fzcDCHnul2v4VE0kySQLhE1A6cOhVAgkzzmpNB8juCuOYkHWRJqTTVjrcFfqTU9
	 EUtc7HZmRRlDeqadzTihCqf6Ui3SFtuOeQsRq5VM1adRdVO45KmgerdfM1NQCPqTKe
	 Xtv5LNKxgDaVQ==
Date: Tue, 15 Jul 2025 13:12:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	acme@kernel.org, tglx@linutronix.de, willy@infradead.org,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v5 06/14] perf bench mem: Allow mapping of hugepages
Message-ID: <aHa2HHWaShp-Vk4m@google.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-7-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710005926.1159009-7-ankur.a.arora@oracle.com>

On Wed, Jul 09, 2025 at 05:59:18PM -0700, Ankur Arora wrote:
> Page sizes that can be selected: 4KB, 2MB, 1GB.
> 
> Both the reservation and node from which hugepages are allocated
> from are expected to be addressed by the user.

It'd be nice if you could provide an example in the commit message when
you introduce a new command line option.  Also please update
Documentation/perf-bench.txt.

Thanks,
Namhyung

> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  tools/perf/bench/mem-functions.c | 33 ++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index 914f9048d982..e4d713587d45 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -25,11 +25,17 @@
>  #include <sys/mman.h>
>  #include <errno.h>
>  #include <linux/time64.h>
> +#include <linux/log2.h>
>  
>  #define K 1024
>  
> +#define PAGE_SHIFT_4KB		12
> +#define PAGE_SHIFT_2MB		21
> +#define PAGE_SHIFT_1GB		30
> +
>  static const char	*size_str	= "1MB";
>  static const char	*function_str	= "all";
> +static const char	*page_size_str	= "4KB";
>  static unsigned int	nr_loops	= 1;
>  static bool		use_cycles;
>  static int		cycles_fd;
> @@ -39,6 +45,10 @@ static const struct option options[] = {
>  		    "Specify the size of the memory buffers. "
>  		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
>  
> +	OPT_STRING('p', "page", &page_size_str, "4KB",
> +		    "Specify page-size for mapping memory buffers. "
> +		    "Available sizes: 4KB, 2MB, 1GB (case insensitive)"),
> +
>  	OPT_STRING('f', "function", &function_str, "all",
>  		    "Specify the function to run, \"all\" runs all available functions, \"help\" lists them"),
>  
> @@ -60,6 +70,7 @@ struct bench_params {
>  	size_t		size;
>  	size_t		size_total;
>  	unsigned int	nr_loops;
> +	unsigned int	page_shift;
>  };
>  
>  struct bench_mem_info {
> @@ -202,7 +213,8 @@ static void __bench_mem_function(struct bench_mem_info *info, struct bench_param
>  	if (r->fn.fini) r->fn.fini(info, p, &src, &dst);
>  	return;
>  out_init_failed:
> -	printf("# Memory allocation failed - maybe size (%s) is too large?\n", size_str);
> +	printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
> +			p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
>  	goto out_free;
>  }
>  
> @@ -210,6 +222,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
>  {
>  	int i;
>  	struct bench_params p = { 0 };
> +	unsigned int page_size;
>  
>  	argc = parse_options(argc, argv, options, info->usage, 0);
>  
> @@ -229,6 +242,15 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
>  	}
>  	p.size_total = (size_t)p.size * p.nr_loops;
>  
> +	page_size = (unsigned int)perf_atoll((char *)page_size_str);
> +	if (page_size != (1 << PAGE_SHIFT_4KB) &&
> +	    page_size != (1 << PAGE_SHIFT_2MB) &&
> +	    page_size != (1 << PAGE_SHIFT_1GB)) {
> +		fprintf(stderr, "Invalid page-size:%s\n", page_size_str);
> +		return 1;
> +	}
> +	p.page_shift = ilog2(page_size);
> +
>  	if (!strncmp(function_str, "all", 3)) {
>  		for (i = 0; info->functions[i].name; i++)
>  			__bench_mem_function(info, &p, i);
> @@ -285,11 +307,14 @@ static int do_memcpy(const struct function *r, struct bench_params *p,
>  	return 0;
>  }
>  
> -static void *bench_mmap(size_t size, bool populate)
> +static void *bench_mmap(size_t size, bool populate, unsigned int page_shift)
>  {
>  	void *p;
>  	int extra = populate ? MAP_POPULATE : 0;
>  
> +	if (page_shift != PAGE_SHIFT_4KB)
> +		extra |= MAP_HUGETLB | (page_shift << MAP_HUGE_SHIFT);
> +
>  	p = mmap(NULL, size, PROT_READ|PROT_WRITE,
>  		 extra | MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>  
> @@ -307,11 +332,11 @@ static bool mem_alloc(struct bench_mem_info *info, struct bench_params *p,
>  {
>  	bool failed;
>  
> -	*dst = bench_mmap(p->size, true);
> +	*dst = bench_mmap(p->size, true, p->page_shift);
>  	failed = *dst == NULL;
>  
>  	if (info->alloc_src) {
> -		*src = bench_mmap(p->size, true);
> +		*src = bench_mmap(p->size, true, p->page_shift);
>  		failed = failed || *src == NULL;
>  	}
>  
> -- 
> 2.43.5
> 

