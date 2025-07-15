Return-Path: <linux-kernel+bounces-732493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7602BB067A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D522D7B191C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8269F263C8E;
	Tue, 15 Jul 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvSMAu9v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DDE20485B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610649; cv=none; b=u/vVX1v08+vPe9qyukwyMAfXEyP+ABG9rg373juhLt8hvnmAW+zuq1jR09RVeyqWlGuZVDfAan6oVyCwZj7CurDcigxvbFM59TKH+CyeTymVLMPNW972dpmpS8UeLNEtL9NqyTJJmoUFfQVsJQz3vy9MymjxPtRG8rIouE64JFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610649; c=relaxed/simple;
	bh=ZVUoEHrFKDa2T3shxXnxjvESjxznAX/XpvM1/FjZYA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKUvYwMpzTyqhxWsK6d0UuGmQfdTwRqRtSqN1PLz7yecpjZJfOZraa6rzlhkP/x+z8167yVfvk5lPO4Ak/RBdyT4UHR+JgGowEUpGFTKwU2Xwaey1XEZbNPEJeGGPbNVz9b6xHpdHbKaK7KFIU0Ht18npnsbjqZavCrHWE+Frto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvSMAu9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10BFC4CEE3;
	Tue, 15 Jul 2025 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752610648;
	bh=ZVUoEHrFKDa2T3shxXnxjvESjxznAX/XpvM1/FjZYA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvSMAu9vM0iQjcTZ9SHZVG63bWX1lFYImGLv//AYGYoW82ayxFKbXMiv0HROtHpq3
	 b9RS03k6aIp9kyVjyZu3Z2PuUaSqFxY2Z6EVv/gZhO7oIbuT6+OnD3E25IqJ9fQ1mj
	 KK2+Y06NzWi9ndMYwlXjGcOnztH1JOrIM1udOxRBURsFPp7BP0RJqOKCVUKqpU30cC
	 UyQ6f/ndVvwJ6LGJP87k/EOuDOcCczT91gUDcUP6fD4Vey6KyLlKybZw1SmeOCQScS
	 XYE732hQWpiu41qPPEMD6wPrJcJovDgzuotnjPSHtAFI798wQ3uCLbc2gIgXyXPCgc
	 GSJsMSUVOambQ==
Date: Tue, 15 Jul 2025 13:17:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	acme@kernel.org, tglx@linutronix.de, willy@infradead.org,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v5 07/14] perf bench mem: Allow chunking on a memory
 region
Message-ID: <aHa3VgRA8qm8U9my@google.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-8-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710005926.1159009-8-ankur.a.arora@oracle.com>

On Wed, Jul 09, 2025 at 05:59:19PM -0700, Ankur Arora wrote:
> There can be a significant gap in memset/memcpy performance depending
> on the size of the region being operated on.
> 
> With chunk-size=4kb:
> 
>   $ echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
> 
>   $ perf bench mem memset -p 4kb -k 4kb -s 4gb -l 10 -f x86-64-stosq
>   # Running 'mem/memset' benchmark:
>   # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
>   # Copying 4gb bytes ...
> 
>       13.011655 GB/sec
> 
> With chunk-size=1gb:
> 
>   $ echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
> 
>   $ perf bench mem memset -p 4kb -k 1gb -s 4gb -l 10 -f x86-64-stosq
>   # Running 'mem/memset' benchmark:
>   # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
>   # Copying 4gb bytes ...
> 
>       21.936355 GB/sec
> 
> So, allow the user to specify the chunk-size.
> 
> The default value is identical to the total size of the region, which
> preserves current behaviour.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Again, please update the documentation.  With that,

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/bench/mem-functions.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index e4d713587d45..412d18f2cb2e 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -36,6 +36,7 @@
>  static const char	*size_str	= "1MB";
>  static const char	*function_str	= "all";
>  static const char	*page_size_str	= "4KB";
> +static const char	*chunk_size_str	= "0";
>  static unsigned int	nr_loops	= 1;
>  static bool		use_cycles;
>  static int		cycles_fd;
> @@ -49,6 +50,10 @@ static const struct option options[] = {
>  		    "Specify page-size for mapping memory buffers. "
>  		    "Available sizes: 4KB, 2MB, 1GB (case insensitive)"),
>  
> +	OPT_STRING('k', "chunk", &chunk_size_str, "0",
> +		    "Specify the chunk-size for each invocation. "
> +		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
> +
>  	OPT_STRING('f', "function", &function_str, "all",
>  		    "Specify the function to run, \"all\" runs all available functions, \"help\" lists them"),
>  
> @@ -69,6 +74,7 @@ union bench_clock {
>  struct bench_params {
>  	size_t		size;
>  	size_t		size_total;
> +	size_t		chunk_size;
>  	unsigned int	nr_loops;
>  	unsigned int	page_shift;
>  };
> @@ -242,6 +248,14 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
>  	}
>  	p.size_total = (size_t)p.size * p.nr_loops;
>  
> +	p.chunk_size = (size_t)perf_atoll((char *)chunk_size_str);
> +	if ((s64)p.chunk_size < 0 || (s64)p.chunk_size > (s64)p.size) {
> +		fprintf(stderr, "Invalid chunk_size:%s\n", chunk_size_str);
> +		return 1;
> +	}
> +	if (!p.chunk_size)
> +		p.chunk_size = p.size;
> +
>  	page_size = (unsigned int)perf_atoll((char *)page_size_str);
>  	if (page_size != (1 << PAGE_SHIFT_4KB) &&
>  	    page_size != (1 << PAGE_SHIFT_2MB) &&
> @@ -299,7 +313,8 @@ static int do_memcpy(const struct function *r, struct bench_params *p,
>  
>  	clock_get(&start);
>  	for (unsigned int i = 0; i < p->nr_loops; ++i)
> -		fn(dst, src, p->size);
> +		for (size_t off = 0; off < p->size; off += p->chunk_size)
> +			fn(dst + off, src + off, min(p->chunk_size, p->size - off));
>  	clock_get(&end);
>  
>  	*rt = clock_diff(&start, &end);
> @@ -401,7 +416,8 @@ static int do_memset(const struct function *r, struct bench_params *p,
>  
>  	clock_get(&start);
>  	for (unsigned int i = 0; i < p->nr_loops; ++i)
> -		fn(dst, i, p->size);
> +		for (size_t off = 0; off < p->size; off += p->chunk_size)
> +			fn(dst + off, i, min(p->chunk_size, p->size - off));
>  	clock_get(&end);
>  
>  	*rt = clock_diff(&start, &end);
> -- 
> 2.43.5
> 

