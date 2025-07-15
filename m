Return-Path: <linux-kernel+bounces-732494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4822B067A2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EDD563C05
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EB1271440;
	Tue, 15 Jul 2025 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyVCCDuM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEEC262FD4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610696; cv=none; b=WdQEh6qZQChQr0Y+qaFECbyAiTYRZyL11rsGL2MiR/bb0smsJNpaVE8tcsotQmzJtsIxqV4zlkzOkXV19I5QI+s7+AKoA0fkuhm70ReIuCKY9GME0vUzn6enpYscCZCuezoKmzmO7xZYMeUZezai9wkeC+GWGdoEhAqLfDTRDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610696; c=relaxed/simple;
	bh=PLfZVjiWCJ9WF14jCAJgKwD4VJ4Dt11gzQfmw+/2c3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrJMyCaOCESt5DZU3Ad8XZTqDkcjFNI+5yru8KeUoYZN8UUIe+/uFp3LHjGDpPngqvJ0YUyxXyOQ+yVXVoJoBZ35Qf6YTDx37ShbtAJsIrt2rHy4g6wDsH+W95FXkKo549F1F5aaqyRQ0EXXSvKvFzKRsz5clVgc8uyAwhLPBuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyVCCDuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867B8C4CEE3;
	Tue, 15 Jul 2025 20:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752610696;
	bh=PLfZVjiWCJ9WF14jCAJgKwD4VJ4Dt11gzQfmw+/2c3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyVCCDuMqPBzMTOlmzPDbdUwwqhOPgyLtx3ZhVBAuEnk9j+E2uv0m1iIg/M3X2T3P
	 eRwvimDqdtiR5EoCNbTtsSgNZB/5bpE8BjcYO6vKZEvXPFNXcOZ/KNOJ8sbt/dxoUL
	 jdraJ6hFFwOnEWhYdfO7uifUJS07RNmufbn0O50JCFAmasowEJIjWsMPR+QjB2kkOt
	 TGTK+W8WAZaJNcY5SHJ7bqYYDIxnmMrm+F1p5DS/dlOWoqfbIDoc6qXFcqtzSISmSZ
	 5NBaxlPvaTw3MxArqkDBWLig9VJbd7r0HE2VvIsaMCbqRQdFqyvVHrjmUGuN6wAWlM
	 +oUxtlbQL1T5w==
Date: Tue, 15 Jul 2025 13:18:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	acme@kernel.org, tglx@linutronix.de, willy@infradead.org,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v5 08/14] perf bench mem: Refactor mem_options
Message-ID: <aHa3hryUxeb62oBy@google.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-9-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710005926.1159009-9-ankur.a.arora@oracle.com>

On Wed, Jul 09, 2025 at 05:59:20PM -0700, Ankur Arora wrote:
> Split mem benchmark options into common and memset/memcpy specific.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/bench/mem-functions.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index 412d18f2cb2e..8a37da149327 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -41,7 +41,7 @@ static unsigned int	nr_loops	= 1;
>  static bool		use_cycles;
>  static int		cycles_fd;
>  
> -static const struct option options[] = {
> +static const struct option bench_common_options[] = {
>  	OPT_STRING('s', "size", &size_str, "1MB",
>  		    "Specify the size of the memory buffers. "
>  		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
> @@ -50,10 +50,6 @@ static const struct option options[] = {
>  		    "Specify page-size for mapping memory buffers. "
>  		    "Available sizes: 4KB, 2MB, 1GB (case insensitive)"),
>  
> -	OPT_STRING('k', "chunk", &chunk_size_str, "0",
> -		    "Specify the chunk-size for each invocation. "
> -		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
> -
>  	OPT_STRING('f', "function", &function_str, "all",
>  		    "Specify the function to run, \"all\" runs all available functions, \"help\" lists them"),
>  
> @@ -66,6 +62,14 @@ static const struct option options[] = {
>  	OPT_END()
>  };
>  
> +static const struct option bench_mem_options[] = {
> +	OPT_STRING('k', "chunk", &chunk_size_str, "0",
> +		    "Specify the chunk-size for each invocation. "
> +		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
> +	OPT_PARENT(bench_common_options),
> +	OPT_END()
> +};
> +
>  union bench_clock {
>  	u64		cycles;
>  	struct timeval	tv;
> @@ -84,6 +88,7 @@ struct bench_mem_info {
>  	int (*do_op)(const struct function *r, struct bench_params *p,
>  		     void *src, void *dst, union bench_clock *rt);
>  	const char *const *usage;
> +	const struct option *options;
>  	bool alloc_src;
>  };
>  
> @@ -230,7 +235,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
>  	struct bench_params p = { 0 };
>  	unsigned int page_size;
>  
> -	argc = parse_options(argc, argv, options, info->usage, 0);
> +	argc = parse_options(argc, argv, info->options, info->usage, 0);
>  
>  	if (use_cycles) {
>  		i = init_cycles();
> @@ -396,6 +401,7 @@ int bench_mem_memcpy(int argc, const char **argv)
>  		.functions		= memcpy_functions,
>  		.do_op			= do_memcpy,
>  		.usage			= bench_mem_memcpy_usage,
> +		.options		= bench_mem_options,
>  		.alloc_src              = true,
>  	};
>  
> @@ -453,6 +459,7 @@ int bench_mem_memset(int argc, const char **argv)
>  		.functions		= memset_functions,
>  		.do_op			= do_memset,
>  		.usage			= bench_mem_memset_usage,
> +		.options		= bench_mem_options,
>  	};
>  
>  	return bench_mem_common(argc, argv, &info);
> -- 
> 2.43.5
> 

