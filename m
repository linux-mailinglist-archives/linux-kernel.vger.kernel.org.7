Return-Path: <linux-kernel+bounces-807214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DF3B4A1AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB67C4E2D09
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758E52FE049;
	Tue,  9 Sep 2025 05:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gFUO10Cm"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F822FD7CE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 05:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397517; cv=none; b=BAFk8etqzDViQeQCEx8ch0Z5x2cGYOGqVqjkBMwnpXTuHV4nnEYXUHH+FDj/EiXfRMyjrJ4o+R2X7KG4czBDXnYn83H2SOx5enUTtvsd5ookNpImpw/kNc/Cnh1rP7Sw2QP8eU56EgpI2NZjF0AzL+XDF4X7cD4i5642USkLu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397517; c=relaxed/simple;
	bh=J3SRZ/NIuZwyFJbcoNur/BRTRAZ5QdUuVSslgMc/94Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcG0GTe8ZjAxBl9z83HAdgJVZUUgh+XYWrkhxIxD/LDFYUeO62047lTX82cygrH9c0DZSzrtaMHg09jci3T3Twof2Mn+XZMgfGrCFXEpxrO4maYESx1JHxQn/ARq8VsplJMcRkp8nmEJNdbAKabaerF+VlXg+EyOKbpAIcr7fvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gFUO10Cm; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757397505; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=btmA0dgras/e+IP/547OTg6AjeVnYhqLnZKh6bgWqc4=;
	b=gFUO10Cma+EsKe1zZcHp1IQZD1AYQm6BGkvNuyF5yBqhwuRn5nfbqXyYPH7j4yRUCbS81eDfnIHmCFuh5F22fBJK0HFUlw/Q/Aw7624tH3ZWs6C2+EmibSK8kN4Iqr4qXdBhMFgEbjlna/KX5nVmafb1dT+FswxbDFCt7dvMNVo=
Received: from 30.74.144.127(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wncf147_1757397504 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 13:58:24 +0800
Message-ID: <c245dbb5-2e2b-4308-a296-f711b74002eb@linux.alibaba.com>
Date: Tue, 9 Sep 2025 13:58:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: fix too little space for tmpfs only fallback
 4KB
To: Vernon Yang <vernon2gm@gmail.com>, hughd@google.com,
 akpm@linux-foundation.org, da.gomez@samsung.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vernon Yang <yanglincheng@kylinos.cn>
References: <20250908123128.900254-1-vernon2gm@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250908123128.900254-1-vernon2gm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/8 20:31, Vernon Yang wrote:
> From: Vernon Yang <yanglincheng@kylinos.cn>
> 
> When the system memory is sufficient, allocating memory is always
> successful, but when tmpfs size is low (e.g. 1MB), it falls back
> directly from 2MB to 4KB, and other small granularity (8KB ~ 1024KB)
> will not be tried.
> 
> Therefore add check whether the remaining space of tmpfs is sufficient
> for allocation. If there is too little space left, try smaller large
> folio.

I don't think so.

For a tmpfs mount with 'huge=within_size' and 'size=1M', if you try to 
write 1M data, it will allocate an order 8 large folio and will not 
fallback to order 0.

For a tmpfs mount with 'huge=always' and 'size=1M', if you try to write 
1M data, it will not completely fallback to order 0 either, instead, it 
will still allocate some order 1 to order 7 large folios.

I'm not sure if this is your actual user scenario. If your files are 
small and you are concerned about not getting large folio allocations, I 
recommend using the 'huge=within_size' mount option.

> Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")

No, this doesn't fix anything.

> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> ---
>   mm/shmem.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 8c592c6db2a0..b20affd57b23 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1820,6 +1820,7 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
>   					   unsigned long orders)
>   {
>   	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
> +	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>   	pgoff_t aligned_index;
>   	unsigned long pages;
>   	int order;
> @@ -1835,6 +1836,18 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
>   	while (orders) {
>   		pages = 1UL << order;
>   		aligned_index = round_down(index, pages);
> +
> +		/*
> +		 * Check whether the remaining space of tmpfs is sufficient for
> +		 * allocation. If there is too little space left, try smaller
> +		 * large folio.
> +		 */
> +		if (sbinfo->max_blocks && percpu_counter_read(&sbinfo->used_blocks)
> +						+ pages > sbinfo->max_blocks) {
> +			order = next_order(&orders, order);
> +			continue;
> +		}
> +
>   		/*
>   		 * Check for conflict before waiting on a huge allocation.
>   		 * Conflict might be that a huge page has just been allocated


