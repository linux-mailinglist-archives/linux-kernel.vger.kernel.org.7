Return-Path: <linux-kernel+bounces-849932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9F3BD15DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A4D5347811
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0EA1E9905;
	Mon, 13 Oct 2025 04:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OS5QkaqD"
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F104FBF0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760329004; cv=none; b=uWFk8K+Q6FAbqE6JnL3SktFYyo0nhRqtC1A8E3AdOBVX1v+Zt9SjKP/FtLmyju0DLjNFNiCwjqu+Axuq4pXmR92DT6aq8WKQKNYK8AW4M/F+ShqCQ6lkNh+EJpvzL7AGJRiQFzE+pUNrAwvI3rGvqQJS++J+U3FlnPWddhKnzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760329004; c=relaxed/simple;
	bh=8ja+TJqGvLeNIMgD9u2PTZoJCpyPPZQ22s1Q/sy/37g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d4JKTDXT8LSc1HeYHlzm1n3A8Hmof2RZIh0Fv0yVvbM658/VObP0SfEvGPrLpMVHdrYdhczRqbsTK8eHpjoQfjFI2LRikBXjnZMiwDic/eRrpz1GlDwNPElCnOnqYceBs0XFzDUPZhFYnVgQvE2SK1hhWdrhgn6MmLRRqnCwCpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OS5QkaqD; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LKAFH59CbQyepEzpm1HPlJx8KhoAqmWuzmeytifxrvM=;
	b=OS5QkaqDosO3GrDu1jOEC4SD20IOt7dwm28/90MrTUxz62JvZp8saTOTXMcJogSh726P2MujG
	rwwwpmFI4aZibjX7IiTpvXsCRqZgHPyIkLYX7t7IarMxNf35JRm6o87PNcm8ezjD4OnbJV7L+xQ
	mkW6seR0ua2DnZc+2O4zRYo=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4clPDD6tkRz1cyQ3;
	Mon, 13 Oct 2025 12:16:12 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id D84721A0171;
	Mon, 13 Oct 2025 12:16:31 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 12:16:31 +0800
Message-ID: <62036acc-04f3-4dec-98c9-343def13d3c4@huawei.com>
Date: Mon, 13 Oct 2025 12:16:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix crafted invalid cases for encoded extents
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: LKML <linux-kernel@vger.kernel.org>, Robert Morris <rtm@mit.edu>, Robert
 Morris <rtm@csail.mit.edu>
References: <2cda3cc5-f837-4627-9587-051ed10839b9@linux.alibaba.com>
 <20251012135925.158921-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251012135925.158921-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)



On 2025/10/12 21:59, Gao Xiang wrote:
> Robert recently reported two corrupted images that can cause system
> crashes, which are related to the new encoded extents introduced
> in Linux 6.15:
> 
>    - The first one [1] has plen != 0 (e.g. plen == 0x2000000) but
>      (plen & Z_EROFS_EXTENT_PLEN_MASK) == 0. It is used to represent
>      special extents such as sparse extents (!EROFS_MAP_MAPPED), but
>      previously only plen == 0 was handled;
> 
>    - The second one [2] has pa 0xffffffffffdcffed and plen 0xb4000,
>      then "cur [0xfffffffffffff000] += bvec.bv_len [0x1000]" in
>      "} while ((cur += bvec.bv_len) < end);" wraps around, causing an
>      out-of-bound access of pcl->compressed_bvecs[] in
>      z_erofs_submit_queue().  EROFS only supports 48-bit physical block
>      addresses (up to 1EiB for 4k blocks), so add a sanity check to
>      enforce this.
> 
> Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
> Reported-by: Robert Morris <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/r/75022.1759355830@localhost
> Closes: https://lore.kernel.org/r/80524.1760131149@localhost
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
> v2:
>   - `pend` should be converted to blocks and then be compared.
> 
>   fs/erofs/zmap.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 798223e6da9c..87032f90fe84 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -596,7 +596,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
>   			vi->z_fragmentoff = map->m_plen;
>   			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
>   				vi->z_fragmentoff |= map->m_pa << 32;
> -		} else if (map->m_plen) {
> +		} else if (map->m_plen & Z_EROFS_EXTENT_PLEN_MASK) {
>   			map->m_flags |= EROFS_MAP_MAPPED |
>   				EROFS_MAP_FULL_MAPPED | EROFS_MAP_ENCODED;
>   			fmt = map->m_plen >> Z_EROFS_EXTENT_PLEN_FMT_BIT;
> @@ -715,6 +715,7 @@ static int z_erofs_map_sanity_check(struct inode *inode,
>   				    struct erofs_map_blocks *map)
>   {
>   	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
> +	u64 pend;
>   
>   	if (!(map->m_flags & EROFS_MAP_ENCODED))
>   		return 0;
> @@ -732,6 +733,10 @@ static int z_erofs_map_sanity_check(struct inode *inode,
>   	if (unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
>   		     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
>   		return -EOPNOTSUPP;
> +	/* Filesystems beyond 48-bit physical block addresses are invalid */
> +	if (unlikely(check_add_overflow(map->m_pa, map->m_plen, &pend) ||
> +		     (pend >> sbi->blkszbits) >= BIT_ULL(48)))
> +		return -EFSCORRUPTED;
>   	return 0;
>   }
>   

