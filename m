Return-Path: <linux-kernel+bounces-726978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C894B0138E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D2E17B3926
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185F1D6DDD;
	Fri, 11 Jul 2025 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ndyMqOhB"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B342F5E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215320; cv=none; b=nnonMqDr/ARkslwdzL8jOhXWcFs6UpYQupDUhUJiK1ZqqJwZ0WvQEsVcFoStzirSV07FSfo5ZCETDY5Ako/A6owyhUDMdpQdR52VRsGmlaMB+H3WpBYhsEscgq3cfw6ncBdX+sFjDC7/SK8A2UjLvWUdjoKaTgJ71308GawKHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215320; c=relaxed/simple;
	bh=bk0I0OO7Ide9pbnrVs4F/jv4jlkDs4EFODVG/sHS+2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwS5PBznjNLdG4b7b6zJMzJ8Sk/hqW0AZpVdl5iPa7/awRnRoJmQK+KpQcuhJPx6J/HWYpDtKbFL2VZDWcydXrc3IuY8xEBdhXS344ZuVfO2TsFkbdObQZI75wGX+jMPmnJMwVoareu0TVnQ2pYzipZKioAcXSBWAHBKztNiEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ndyMqOhB; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752215309; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rtpI047k16F6WKVc1Nno4+p1oxOQn3UL3hgRRvrDrFw=;
	b=ndyMqOhBi79Od2+oAF4eKh4BrRS+VRIJ9Im3cjihQLY/n27H0cl1MdrV34N32J9affNqEFrupozRna628WgYjBQPBtfxIHW9lzAqM0kHW3Ih2f1N3Jl9m1/DWOMEm1o7uU7iAc5TkPvfa+NusuykxvmdvsGM4uj43k5XSwEdB7Y=
Received: from 30.74.144.131(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wifv0NS_1752214989 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Jul 2025 14:23:10 +0800
Message-ID: <57e82add-b8d5-49cb-8a3e-58c7c65768d0@linux.alibaba.com>
Date: Fri, 11 Jul 2025 14:23:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] mm/shmem, swap: simplify swapin path and result
 handling
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
References: <20250710033706.71042-1-ryncsn@gmail.com>
 <20250710033706.71042-7-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250710033706.71042-7-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/10 11:37, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Slightly tidy up the different handling of swap in and error handling
> for SWP_SYNCHRONOUS_IO and non-SWP_SYNCHRONOUS_IO devices. Now swapin
> will always use either shmem_swap_alloc_folio or shmem_swapin_cluster,
> then check the result.
> 
> Simplify the control flow and avoid a redundant goto label.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM, with a nit as follows.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/shmem.c | 45 +++++++++++++++++++--------------------------
>   1 file changed, 19 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 847e6f128485..80f5b8c73eb8 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2320,40 +2320,33 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   			count_memcg_event_mm(fault_mm, PGMAJFAULT);
>   		}
>   
> -		/* Skip swapcache for synchronous device. */
>   		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
> +			/* Direct mTHP swapin skipping swap cache & readhaed */
>   			folio = shmem_swap_alloc_folio(inode, vma, index, swap, order, gfp);

Nit: the 'mTHP' word can be confusing, since we will skip swapcache for 
order 0 too. Please drop it.

