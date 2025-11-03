Return-Path: <linux-kernel+bounces-882780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E77EC2B6DE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4CCA345B55
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F8030149E;
	Mon,  3 Nov 2025 11:38:09 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EDC2F39D7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169889; cv=none; b=GCldmfD3pZZHuRaxYwlz7V2sKmyvztDDH70MxgvVMdfdJsJVgZUdP/LmeeArMlyPkc0/6fE22ab2A604KJ1IMOcevsgvquLYcK+D9zFTLPrfA0ArEezsFZzfJrbHBBM4hUw/CULETyfOn3x4CPAdKQ2XB4dVt6AZHCt7BK6eluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169889; c=relaxed/simple;
	bh=pLhcJQ+cQULFH93MVEe/lkcPignc/5wKPaXvCi80ymU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibIKNqNsWVypQfwIsvGgzeUuGwf95dOcqoXzLkTeO4hmLDwIaOYL10eGyBmfbbzIGhTsDPDode8jj9bULvyHxtC2VPP8icu/F6oz9KsB6/QHcR3vfmey76OdWxmH/FVjhMu8wbC+qR93N2EQ+uRBwCQg4Zd5DuSRRT3rAaejNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d0V2M62JmzHnGjc;
	Mon,  3 Nov 2025 19:38:03 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CA7F140370;
	Mon,  3 Nov 2025 19:38:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Nov
 2025 11:38:04 +0000
Date: Mon, 3 Nov 2025 11:38:03 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Li Chen <me@linux.beauty>
CC: <dm-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Dongsheng Yang
	<dongsheng.yang@linux.dev>, Zheng Gu <cengku@gmail.com>
Subject: Re: [PATCH 3/3] dm-pcache: avoid leaking invalid metadata in
 pcache_meta_find_latest()
Message-ID: <20251103113803.00001448@huawei.com>
In-Reply-To: <20251030123323.967081-4-me@linux.beauty>
References: <20251030123323.967081-1-me@linux.beauty>
	<20251030123323.967081-4-me@linux.beauty>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 30 Oct 2025 20:33:21 +0800
Li Chen <me@linux.beauty> wrote:

> From: Li Chen <chenl311@chinatelecom.cn>
> 
> Before this change pcache_meta_find_latest() was copying each
> slot directly into meta_ret while scanning. If no valid slot
> was found and the function returned NULL, meta_ret still held
> whatever was last copied (possibly CRC-bad). Later users
> (e.g. cache_segs_init) could mistakenly trust that data.
> 
> Allocate a temporary buffer instead and only populate meta_ret after a
> valid/latest header is found. If no valid header exists we return NULL
> without touching meta_ret.
> 
> Also add __free(kvfree) so the temporary buffer is always freed, and
> include the needed headers.
> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>  drivers/md/dm-pcache/pcache_internal.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-pcache/pcache_internal.h b/drivers/md/dm-pcache/pcache_internal.h
> index b7a3319d2bd3e..ac28f9dd2986f 100644
> --- a/drivers/md/dm-pcache/pcache_internal.h
> +++ b/drivers/md/dm-pcache/pcache_internal.h
> @@ -4,6 +4,8 @@
>  
>  #include <linux/delay.h>
>  #include <linux/crc32c.h>
> +#include <linux/slab.h>
> +#include <linux/cleanup.h>
>  
>  #define pcache_err(fmt, ...)							\
>  	pr_err("dm-pcache: %s:%u " fmt, __func__, __LINE__, ##__VA_ARGS__)
> @@ -79,14 +81,17 @@ static inline void __must_check *pcache_meta_find_latest(struct pcache_meta_head
>  					u32 meta_size, u32 meta_max_size,
>  					void *meta_ret)
>  {
> -	struct pcache_meta_header *meta, *latest = NULL;
> +	struct pcache_meta_header *latest = NULL;
> +	struct pcache_meta_header *meta __free(kvfree);
>  	u32 i, seq_latest = 0;
> -	void *meta_addr;
>  
> -	meta = meta_ret;
> +	meta = kvzalloc(meta_size, GFP_KERNEL);
See the guidance notes in cleanup.h  THis hsould be

	struct pcache_meta_header *meta __free(kvfree) =
		kvzalloc(meta_size, GFP_KERNEL);

That is the constructor and destructor must be together. Inline variable
declarations are fine for this one type of use.

> +	if (!meta)
> +		return ERR_PTR(-ENOMEM);
>  
>  	for (i = 0; i < PCACHE_META_INDEX_MAX; i++) {
> -		meta_addr = (void *)header + (i * meta_max_size);
> +		void *meta_addr = (void *)header + (i * meta_max_size);
> +
>  		if (copy_mc_to_kernel(meta, meta_addr, meta_size)) {
>  			pcache_err("hardware memory error when copy meta");
>  			return ERR_PTR(-EIO);


