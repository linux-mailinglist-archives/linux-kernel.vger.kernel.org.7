Return-Path: <linux-kernel+bounces-732487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A23B06787
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992F3175354
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653E29B796;
	Tue, 15 Jul 2025 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcMbcwTd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8519CCF5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610194; cv=none; b=W12nGKJGsGodRS9TEEPwYKDFqKB/S2CXd1O85VFYJNqg6pDslNdxj2T1+EYDjsUzfxCQutYFzqn0R5jdeBEhmaAnbIC2iGFibhmrIxsEZeuEQfQ5Zs7j2n9aVmkQ3Vi8a9P+wwpmvhMO5g2vQp2/Qx7qpYiDVMGXv+EUANv+AW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610194; c=relaxed/simple;
	bh=Q9cYMUnVsqy9zgA08E5wnAg8X4F1feIzSkYK2sNicZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lq3PuLUYDXHb2vseT3z0mDSF9ILCLHxdBjPplbpWtM7g9eZ7Tc2gtcV0OWjw1AYwukDZGM21y7s4TAFN+SpG2Q4n/ab8GYa5bRH7EdGkuhn+ZBeSBzLMYlzj/HcPmxcHXcJEK47yl588XD87xdNEYbYfVvKkRlnGVGE672IBE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcMbcwTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53804C4CEF5;
	Tue, 15 Jul 2025 20:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752610194;
	bh=Q9cYMUnVsqy9zgA08E5wnAg8X4F1feIzSkYK2sNicZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcMbcwTdP4CqQwvr0aZozIf34ikYuyeKHIfH1yDGVKPlmn5rCk5Z0nJ3Eb+a+L9VB
	 /Dn8MLRpkW9PPG5c5JMQD5GB7XYNs+gcv8WbnGsC/uxZ3AKBI7KwyNIVPJzupBt4Ia
	 g+ku3MiFnEEHUyw4JjHrOpFw/nwCdo9TSCst9c8XkCgpCZXuYSt06EN8Ww2hU8MCMA
	 F916f1lqjaxuD5lzQUlDzjcdSGCvw4s2lNrYHrAJ4f6WoMiOaDj7dJUpws2j22wsWK
	 SIpjlv9Z6tlcZyTKr9CPAwQ/RmoRVUqJib5djEcCJONKTRXL02fEXGl79yjySVmPSq
	 WyKfi8uceQzow==
Date: Tue, 15 Jul 2025 13:09:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	acme@kernel.org, tglx@linutronix.de, willy@infradead.org,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v5 05/14] perf bench mem: Switch from zalloc() to mmap()
Message-ID: <aHa1kNCmugRYDuIM@google.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-6-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710005926.1159009-6-ankur.a.arora@oracle.com>

On Wed, Jul 09, 2025 at 05:59:17PM -0700, Ankur Arora wrote:
> Using mmap() ensures that the buffer is always aligned at a fixed
> boundary. Switch to that to remove one source of variability.
> 
> Since we always want to read/write from the the allocated buffers map
> with pagetables pre-populated.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/bench/mem-functions.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index 06d3ee6f5d69..914f9048d982 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -22,9 +22,9 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <sys/time.h>
> +#include <sys/mman.h>
>  #include <errno.h>
>  #include <linux/time64.h>
> -#include <linux/zalloc.h>
>  
>  #define K 1024
>  
> @@ -285,16 +285,33 @@ static int do_memcpy(const struct function *r, struct bench_params *p,
>  	return 0;
>  }
>  
> +static void *bench_mmap(size_t size, bool populate)
> +{
> +	void *p;
> +	int extra = populate ? MAP_POPULATE : 0;
> +
> +	p = mmap(NULL, size, PROT_READ|PROT_WRITE,
> +		 extra | MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +
> +	return p == MAP_FAILED ? NULL : p;
> +}
> +
> +static void bench_munmap(void *p, size_t size)
> +{
> +	if (p)
> +		munmap(p, size);
> +}
> +
>  static bool mem_alloc(struct bench_mem_info *info, struct bench_params *p,
>  		      void **src, void **dst)
>  {
>  	bool failed;
>  
> -	*dst = zalloc(p->size);
> +	*dst = bench_mmap(p->size, true);
>  	failed = *dst == NULL;
>  
>  	if (info->alloc_src) {
> -		*src = zalloc(p->size);
> +		*src = bench_mmap(p->size, true);
>  		failed = failed || *src == NULL;
>  	}
>  
> @@ -305,8 +322,8 @@ static void mem_free(struct bench_mem_info *info __maybe_unused,
>  		     struct bench_params *p __maybe_unused,
>  		     void **src, void **dst)
>  {
> -	free(*dst);
> -	free(*src);
> +	bench_munmap(*dst, p->size);
> +	bench_munmap(*src, p->size);
>  
>  	*dst = *src = NULL;
>  }
> -- 
> 2.43.5
> 

