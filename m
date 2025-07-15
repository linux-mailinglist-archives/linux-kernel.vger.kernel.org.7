Return-Path: <linux-kernel+bounces-732483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8074B0677F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8B83AF64C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C364B2877E9;
	Tue, 15 Jul 2025 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrvQPjIp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6BE19066B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609939; cv=none; b=SOLJjItRPJmFUs4FsK1EwKyjpgA1iWzUe57tD917qWsZ2JrqH+93MwF6ZG0sMMhfw4losnBlX2poLojeIwiM21bZJsKLdBPB+A61K9fAr9lrgXAt9veLBWukc+5IX2sXGhsU3+828ZcITIG4nliFjbXFgvgIbmk5K3R30k1c5gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609939; c=relaxed/simple;
	bh=HGj+b5u2y+iRJezZTE2uihoa30LW+LxcNFrFq2MAUlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FI3DjWgANrlghRIZJyicoOEbFlvADlZ83uUX3epytWiZjoLMr4L+ATjwqhQrbeMXwB1hiR4HZd4IYN3CIIi6WjBAWPZaVAazfJ81w5WiaLkDKt0YNWf+Jf96m8cvwJxXjNqupOedjlbBe2R/o3SKDo1bUVGucOnZ1RGIStQAc3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrvQPjIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06F7C4CEE3;
	Tue, 15 Jul 2025 20:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752609937;
	bh=HGj+b5u2y+iRJezZTE2uihoa30LW+LxcNFrFq2MAUlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrvQPjIpDnV1MFMJeONfPse+7A86XoXMkrz/2eVyoOlGXoGLsE2A4ohd5aUN30nqB
	 Q/VaCwaIHdIfveQaYBw8ML/EkxQjH/KqpJcMEiaZdl3bCzpT0o74czN3yuAdk8SA2w
	 Q3yASUODws5cAcM7753ikIstGlUMsZVHfhScedb8YDW8xv/kSSSp6SsB+iRevL1kMw
	 mr0e5ZpDdBQrOYLYP9Z2nEEfs2EOYlIRY1Ppj1q6ePC3rDNKFtOxgWEshK0ALAJ3V5
	 FtHTd7aV5ZfAgBmk0danbYoRmczvD7qwY4uvEQD7EtDZc9O+ULoYXQ0lkde/QJ6NXT
	 AUahiMHx18ewQ==
Date: Tue, 15 Jul 2025 13:05:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	acme@kernel.org, tglx@linutronix.de, willy@infradead.org,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v5 02/14] perf bench mem: Defer type munging of size to
 float
Message-ID: <aHa0j7AtLgnd_53B@google.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-3-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710005926.1159009-3-ankur.a.arora@oracle.com>

On Wed, Jul 09, 2025 at 05:59:14PM -0700, Ankur Arora wrote:
> Do type conversion to double at the point of use.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

A nitpick below.

> ---
>  tools/perf/bench/mem-functions.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index 8599ed96ee1f..b8f020379197 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -139,7 +139,7 @@ struct bench_mem_info {
>  	bool alloc_src;
>  };
>  
> -static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t size, double size_total)
> +static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t size, size_t size_total)
>  {
>  	const struct function *r = &info->functions[r_idx];
>  	double result_bps = 0.0;
> @@ -165,18 +165,18 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
>  	switch (bench_format) {
>  	case BENCH_FORMAT_DEFAULT:
>  		if (use_cycles) {
> -			printf(" %14lf cycles/byte\n", (double)rt.cycles/size_total);
> +			printf(" %14lf cycles/byte\n", (double)rt.cycles/(double)size_total);
>  		} else {
> -			result_bps = size_total/timeval2double(&rt.tv);
> +			result_bps = (double)size_total/timeval2double(&rt.tv);
>  			print_bps(result_bps);
>  		}
>  		break;
>  
>  	case BENCH_FORMAT_SIMPLE:
>  		if (use_cycles) {
> -			printf("%lf\n", (double)rt.cycles/size_total);
> +			printf("%lf\n", (double)rt.cycles/(double)size_total);
>  		} else {
> -			result_bps = size_total/timeval2double(&rt.tv);
> +			result_bps = (double)size_total/timeval2double(&rt.tv);
>  			printf("%lf\n", result_bps);
>  		}
>  		break;
> @@ -199,7 +199,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
>  {
>  	int i;
>  	size_t size;
> -	double size_total;
> +	size_t size_total;
>  
>  	argc = parse_options(argc, argv, options, info->usage, 0);
>  
> @@ -212,7 +212,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
>  	}
>  
>  	size = (size_t)perf_atoll((char *)size_str);
> -	size_total = (double)size * nr_loops;
> +	size_total = (size_t)size * nr_loops;

No need to cast.

Thanks,
Namhyung

>  
>  	if ((s64)size <= 0) {
>  		fprintf(stderr, "Invalid size:%s\n", size_str);
> -- 
> 2.43.5
> 

