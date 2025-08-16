Return-Path: <linux-kernel+bounces-771772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01257B28B64
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 625AAB609CE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC8B226CE5;
	Sat, 16 Aug 2025 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DwNmQcRv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE692264DB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755329264; cv=none; b=Siuvw8UPSyoXpShnIG28zSLgetY4BdwjsKC7/KBOsIcBPkRs4taJOHsdxBYWO9Yqg30kLH9WjOcTv9InPnVA6D0sGkJq3P+vK4EqLYkELbDDfLLwJujbikgYvMOEcxpFDLGfxirSuGiWLZRxwKNmbQmd8ONzPuwIlNswGWSPdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755329264; c=relaxed/simple;
	bh=BnYohvptaGZB3VhqiXPQ4b4Ep+yyPU2M3Io47dY3YDo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PzubLD5DPDmlcXb99CfrPqw19mdOcLwJnv0yrsuDASCseRLjEce2ow0VLTGbYUSG8N2ldS9HSmfUBoKFYDPRAeX+sSaX4T/4mEArlW8IlUygOxXCWZUKc+UyjdKJSzAVyQbDnOoSVUD5WP+hobiMQDAEGAynADn0dFwyY74onUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DwNmQcRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9BCC4CEEF;
	Sat, 16 Aug 2025 07:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755329263;
	bh=BnYohvptaGZB3VhqiXPQ4b4Ep+yyPU2M3Io47dY3YDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DwNmQcRv7mxNbBeAZGK4Q2LQ/w+qHBgOmDFNoTZUO9wKbE0+Nhs3OGrksj3YP7AHH
	 kYyeBtYrtq/cl5FbOAmUf6/Pg7xZE0d1bPz1QIwbZri44l6zwhIDTUVz9Oimd0gm2E
	 KtR6fp+zyFs1L/2wmRC46cMS5tJj4wLSMKYKT4E4=
Date: Sat, 16 Aug 2025 00:27:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Ye Liu <liuye@kylinos.cn>, Johannes
 Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <jackmanb@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: simplify lowmem_reserve max
 calculation
Message-Id: <20250816002742.5582d91edc4905e3af69480e@linux-foundation.org>
In-Reply-To: <20250815024509.37900-1-ye.liu@linux.dev>
References: <20250815024509.37900-1-ye.liu@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 10:45:09 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> Use max() to find the maximum lowmem_reserve value and min_t() to
> cap it to managed_pages in calculate_totalreserve_pages(), instead
> of open-coding the comparisons. No functional change.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6235,16 +6235,13 @@ static void calculate_totalreserve_pages(void)
>  			unsigned long managed_pages = zone_managed_pages(zone);
>  
>  			/* Find valid and maximum lowmem_reserve in the zone */
> -			for (j = i; j < MAX_NR_ZONES; j++) {
> -				if (zone->lowmem_reserve[j] > max)
> -					max = zone->lowmem_reserve[j];
> -			}
> +			for (j = i; j < MAX_NR_ZONES; j++)
> +				max = max(max, zone->lowmem_reserve[j]);
>  
>  			/* we treat the high watermark as reserved pages. */
>  			max += high_wmark_pages(zone);
>  
> -			if (max > managed_pages)
> -				max = managed_pages;
> +			max = min_t(unsigned long, max, managed_pages);
>  

Use of max_t/min_t is usually a sign that we messed up the type choices
somewhere.

In this case, I'd say that zone.lowmem_reserve[] should have been
ulong.  Oh well.

