Return-Path: <linux-kernel+bounces-844867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A46BC2F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8D619A2939
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587C925A642;
	Tue,  7 Oct 2025 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QQwYGDnf"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFD34BA35
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880430; cv=none; b=hiw18icsIrkhit+ejhR5Zloll40P8P8w62odt5xlarTAFuCVzAqSeXJ2UB5e6XTovZT29NyIYAcOrMUTLuFtyVimQrjsgBE3Biu79qOHYYSkkp/JtYO2u8JpIMcuT2JUA5mbKKkqlsMTOPG/Rgt69P7W4s5vEV0Tv96QzQy3xE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880430; c=relaxed/simple;
	bh=O9IT2UqMKd1y5wYKawwLhVBN79wDZ/3r8JKijhAgbzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvQBG5sUtAKZCa6o/hM2iXzBULtm6uEmTvZThQjpoBv9Y25dc8JfMTVBCq/hGP6CWfZo/WMmZ8WELdIgM6vumrsKZBdXR7B02SIC3LxlC9Bx1yCFZLHStd0uIqeUAtLT47vAUEcPrPWlvUc2ceu3S8L1ifvWQf9kTgxaq7xsxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QQwYGDnf; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 Oct 2025 23:40:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759880427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yKja+MW72xoxssH4FoUzg9b9lYAFP0NscU4QRLzkw/w=;
	b=QQwYGDnfGC+BjMzSWhdtP2Mm6J0fN66xBNaMU/Gpm0HQgyY82FDF2eelIAZPCd7HLi/ojy
	rQvEb3GS4EKks00ZFIT02TMeGhjoBfJJO1Zor0Li6Uc/z18wVGfADNWB4hA7xRyqs2T3Ba
	mIx/gTUE9eOHzBZ6EuZsqdvppJ02oL0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm/zswap: remove unnecessary dlen writes for
 incompressible pages
Message-ID: <xdsrooh5v7hdkfzr4rmwg6bmg2kd7wediwk7efjexu3ken3wec@so6hlaxqvafh>
References: <20251003203851.43128-1-sj@kernel.org>
 <20251003203851.43128-2-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003203851.43128-2-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 03, 2025 at 01:38:48PM -0700, SeongJae Park wrote:
> Incompressible pages handling logic in zswap_compress() is setting
> 'dlen' as PAGE_SIZE twice.  Once before deciding whether to save the
> content as is, and once again after it is decided to save it as is.
> But the value of 'dlen' is used only if it is decided to save the
> content as is, so the first write is unnecessary.  It is not causing
> real user issues, but making code confusing to read.  Remove the
> unnecessary write operation.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  mm/zswap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index c1af782e54ec..80619c8589a7 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -894,7 +894,6 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>  	 * to the active LRU list in the case.
>  	 */
>  	if (comp_ret || !dlen || dlen >= PAGE_SIZE) {
> -		dlen = PAGE_SIZE;
>  		if (!mem_cgroup_zswap_writeback_enabled(
>  					folio_memcg(page_folio(page)))) {
>  			comp_ret = comp_ret ? comp_ret : -EINVAL;
> -- 
> 2.39.5

