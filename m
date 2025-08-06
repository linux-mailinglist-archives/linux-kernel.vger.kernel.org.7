Return-Path: <linux-kernel+bounces-758436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F17B1CF19
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4036C189CDA8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9A22618F;
	Wed,  6 Aug 2025 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0vWdZQZb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969591F5842
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754519507; cv=none; b=pxbp39GGnYv+brqD2hgjlIjiRtPTx/ItWZI6KTzhjfZw/reuvEqPrw3R+nVcQr5SlH5WOWWnlRyCVmGuoHoyfA3dUAabVrX9+ceBF1PI1Jy5QWVg7ockLPhFopR/JtCm5/YEJKxjk6dOufH5GatqTAF8MzSmavntU376HKexdQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754519507; c=relaxed/simple;
	bh=T6+uShLeoY6F/m9tC6dyztroVw6fvcKgFR56j+bfdJM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gaxl80E4Ek70ODvHuPY+a9dfnbKodRSOU0MQGMBI9DwdHxuy7Q6skhhcnt0UYyXFx+cejhKblHvzveoBUQw3++XdrJsWSaxwaDsGqCbznJOfcwJS9HqYMZHW8i32VKkVPaLTMdh+fAlwOwXK+pgN1kUabXQhF5XRbfE1aTXURCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0vWdZQZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960D5C4CEE7;
	Wed,  6 Aug 2025 22:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754519506;
	bh=T6+uShLeoY6F/m9tC6dyztroVw6fvcKgFR56j+bfdJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0vWdZQZbYxNhpejmITKVe/DBQt4Jetkt6LpIKRdMA7af/7GIYi3igR6VNlHLc4RLx
	 QNSAZ9Cb4VXzQonlKiMkFGr63gY2ITaCvdCnn71Qd2g6HeF3VgGTsVJHKfuv1RDuJE
	 YgnTESkgX8U/sOoKL/NmcBu7KCA0dWsIsMdz4LFw=
Date: Wed, 6 Aug 2025 15:31:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song
 <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>, "Huang, Ying"
 <ying.huang@linux.alibaba.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swapfile.c: introduce function
 alloc_swap_scan_list()
Message-Id: <20250806153146.ee1ee22dc8f6381ff5a6d882@linux-foundation.org>
In-Reply-To: <20250806-swap-scan-list-v1-1-a5fe2d9340a2@kernel.org>
References: <20250806-swap-scan-list-v1-1-a5fe2d9340a2@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 06 Aug 2025 10:34:45 -0700 Chris Li <chrisl@kernel.org> wrote:

> This the alloc_swap_scan_list() will scan the whole list or the first
> cluster.
> 
> This reduces the repeat patterns of isolating a cluster then scanning
> that cluster. As a result, cluster_alloc_swap_entry() is shorter and shallower.
> 
> No functional change.
> ...
>
> ---
>  mm/swapfile.c | 86 ++++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 47 insertions(+), 39 deletions(-)

A nice little patch.

> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4a0cf4fb348d..fcb1e57d8108 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -820,6 +820,29 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
>  	return found;
>  }
>  
> +static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
> +					 struct list_head *list,
> +					 unsigned int order,
> +					 unsigned char usage,
> +					 bool scan_all)
> +{
> +	int found = SWAP_ENTRY_INVALID;

but this function returns an unsigned int

> +
> +	do {
> +		struct swap_cluster_info *ci = isolate_lock_cluster(si, list);
> +		unsigned long offset;
> +
> +		if (!ci)
> +			break;
> +		offset = cluster_offset(si, ci);
> +		found = alloc_swap_scan_cluster(si, ci, offset, order, usage);

so does that one

> +		if (found)
> +			return found;

`break' here.  To avoid multiple return points and for consistency.

> +	} while (scan_all);
> +
> +	return found;
> +}
> +
>  static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
>  {
>  	long to_scan = 1;


