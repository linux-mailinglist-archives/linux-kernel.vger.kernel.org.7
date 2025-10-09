Return-Path: <linux-kernel+bounces-846197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B9DBC7428
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB3A189A897
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91298202961;
	Thu,  9 Oct 2025 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MzJBZR1j"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E160EAE7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759978945; cv=none; b=fIhZkcVAs81iDBDYybHFXfOwFMvW9k0Gd8ZuJA/culPe9g3AY2upLb0WKPy50MV9m+qeHVQGLLsY1KrVtKZLgs5Lx6mTvhpxUKO80nqqGnIXleyZt1ckM93NZoI21y+q+E55f/5ZObvVt+5SxhbSXIzuZ2hCdeNGy0cwbZgMM5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759978945; c=relaxed/simple;
	bh=dRcpP3k2SHY47KtTeACUpPfZm1ZVRewOjnsqoA8GaD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTEdWZmRHfH4Nd+tSfPFkbQa1taaWV5IQwRICYKF0VBR71VaGHtvNaRRzmnQkheTj2EO7dOLUqZvn4ZFNYmIKEfdjKGoTr1FFI6BAoYr1qvKICOZ3ge5HzgaMxtyi6yMKTgKtodeXd/AVxAaOhs0NxLtHWyg0naaDcZ1SR4rnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MzJBZR1j; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c6c9bb5e-b70e-4daa-9b8b-53b6a8ac87fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759978940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGHS6LE86054/Y/Y1qdGFobY6PczmcGdCwMWRLQoAl8=;
	b=MzJBZR1jiS0OT2kLL2Wju4EEgOrpVx3DaHe59BtCj7i5nbw6rjCxfp9FsZgC0n1d+zi3wU
	YWlGyKzjxNOUgHdoR7Pj/x4ETw31p2xWXH+i5J29Oz0djvsMsbaRKoLPqP/CHUARPhJIl3
	g48tu2/3fBlMgJvlKpEj+3F7+oUlB2s=
Date: Thu, 9 Oct 2025 11:02:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] mm/zswap: remove unnecessary dlen writes for
 incompressible pages
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251003203851.43128-1-sj@kernel.org>
 <20251003203851.43128-2-sj@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20251003203851.43128-2-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/10/4 04:38, SeongJae Park wrote:
> Incompressible pages handling logic in zswap_compress() is setting
> 'dlen' as PAGE_SIZE twice.  Once before deciding whether to save the
> content as is, and once again after it is decided to save it as is.
> But the value of 'dlen' is used only if it is decided to save the
> content as is, so the first write is unnecessary.  It is not causing
> real user issues, but making code confusing to read.  Remove the
> unnecessary write operation.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>   mm/zswap.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index c1af782e54ec..80619c8589a7 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -894,7 +894,6 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>   	 * to the active LRU list in the case.
>   	 */
>   	if (comp_ret || !dlen || dlen >= PAGE_SIZE) {
> -		dlen = PAGE_SIZE;
>   		if (!mem_cgroup_zswap_writeback_enabled(
>   					folio_memcg(page_folio(page)))) {
>   			comp_ret = comp_ret ? comp_ret : -EINVAL;

