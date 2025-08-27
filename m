Return-Path: <linux-kernel+bounces-787537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA82CB37797
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7361B64ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F227F24DD11;
	Wed, 27 Aug 2025 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hgTIAS6y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE962472B1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260802; cv=none; b=WIC+YTGYnGhBxyABue4t8KjKhj8ql24eje0G1gKc/MN9fo5aBCeQ1en7tUxbHB5XU7XuurVyxmaI+vlaDx8BsyTlvf4q4ZQ76fz3/RpjXRdbrnsE7q5iS6tYxJLaYfFGZD8HFhxWiTmt/MMKPg7schBkA/4M9IkpuTpuzrka4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260802; c=relaxed/simple;
	bh=31xzUCd2w+RjdiecsXImYkR5SG0HS35zBroNDDwiWR0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Sy5v6oyTk9SbO8G6d4Kop8ZhCl6SD1gBIuji3BXAE/xAZoGG7FNT9LjGB1ee1mts7QPqOq8x7pN/6LT1POyyQQ9yfPS0Tm2hE8Tzlbk+Ke2+bhWolb7615pnR9N6bRkYCEpM3AcfSTGtn+zb5pr+8J9KD6xQ8473/sJJdhpLzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hgTIAS6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70614C4CEF1;
	Wed, 27 Aug 2025 02:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756260801;
	bh=31xzUCd2w+RjdiecsXImYkR5SG0HS35zBroNDDwiWR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hgTIAS6yP/wrdJ0SA2Mce6/+XNZ4GoM0RcWE+3Y8geFt4RR8cFij/JCSKDywrlkZt
	 HjEkPsZWhSn1ogFHu5QDI2c6dSrV2vc0Pm0jjbC/Acz5cZAXiKpekrSZrwORbESDo2
	 koHcbNaKVIyqOUCnwuzCqRatMlcik1tLtH7ZHZjg=
Date: Tue, 26 Aug 2025 19:13:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Harmonize should_compact_retry() type
Message-Id: <20250826191320.d5aa551eb5abef316de41175@linux-foundation.org>
In-Reply-To: <20250826-cleanup-should_compact_retry-v1-1-d2ca89727fcf@google.com>
References: <20250826-cleanup-should_compact_retry-v1-1-d2ca89727fcf@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 14:06:54 +0000 Brendan Jackman <jackmanb@google.com> wrote:

> Currently order is signed in one version of the function and unsigned in
> the other. Tidy that up.
> 
> In page_alloc.c, order is unsigned in the vast majority of cases. But,
> there is a cluster of exceptions in compaction-related code (probably
> stemming from the fact that compact_control.order is signed). So, prefer
> local consistency and make this one signed too.
> 

grumble, pet peeve.  Negative orders make no sense.  Can we make
cc->order unsigned in order (heh) to make everything nice?

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4182,7 +4182,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>  }
>  
>  static inline bool
> -should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_flags,
> +should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  		     enum compact_result compact_result,
>  		     enum compact_priority *compact_priority,
>  		     int *compaction_retries)
> 


