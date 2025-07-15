Return-Path: <linux-kernel+bounces-731046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CF9B04DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC9B1AA3FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05722C08CE;
	Tue, 15 Jul 2025 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VUzmvTnC"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A82C033B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547253; cv=none; b=FE3vqssnmC1jtKQPJxxyPenvpCF9Rxs9nKsPXA/+GRMVsiyqd+Y+uvZIAbaD2Cz6+5/fFX7bs9r6HeTuZJwfOAwOsXBDYktHMOFP0hWoepRCBAvQ69NEB8BwAOHZi4le0xCCkOtnghV/6ScQrirVXKHJDW/ow4YX+uZiGTprD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547253; c=relaxed/simple;
	bh=T3I6y6uy2cOhFfnM54X4vmCxsVloctGSedpLcLw7rns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqUcpS+eihb9Z73bOh1ZtBDAsRbebVqaHs0GHMDDLjZXgNi2GwYmUExmYp+LMHfQE4yafzqVb73h+phvSGWXvge15LnktTVF4oQr6lBggI/otjHj4E1V96LCuw4YyVebYa23xYOIyDT0gClAZNdT0Mos3SR92/BxFlqkd/h6yw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VUzmvTnC; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752547248; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eMp9SekpA/hk1MuVf4hR4grFiLI//nlf6f4bjluGqs0=;
	b=VUzmvTnCgi80hWyOod+Dk34sa2N47J22+lh+LFPe51IxcXvTIRJn3r1rYHC4glamV5koZ6z6kyOjFMY4KOwjzlPvMKrWOQiVChC1830iOYH9IMUYi9BR/de2AF2DZN+J5+rORPQ29YqmP+XY7a1YXXUGtaUzZnrb3OJXfr5oP2c=
Received: from 30.221.131.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj-brfJ_1752547247 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 10:40:47 +0800
Message-ID: <e0a95041-f0b2-49e3-be7a-6a7f2c2c5851@linux.alibaba.com>
Date: Tue, 15 Jul 2025 10:40:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs: unify meta buffers in z_erofs_fill_inode()
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250714090907.4095645-1-hsiangkao@linux.alibaba.com>
 <20250714090907.4095645-2-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250714090907.4095645-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/14 17:09, Gao Xiang wrote:
> There is no need to keep additional local metabufs since we already
> have one in `struct erofs_map_blocks`.
> 
> This was actually a leftover when applying meta buffers to zmap
> operations, see commit 09c543798c3c ("erofs: use meta buffers for
> zmap operations").
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/zmap.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index ff1d0751fc61..9afc8a68bacb 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -620,13 +620,12 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
>   	return 0;
>   }
>   
> -static int z_erofs_fill_inode_lazy(struct inode *inode)
> +static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
>   	struct super_block *const sb = inode->i_sb;
>   	int err, headnr;
>   	erofs_off_t pos;
> -	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>   	struct z_erofs_map_header *h;
>   
>   	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags)) {
> @@ -646,7 +645,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>   		goto out_unlock;
>   
>   	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
> -	h = erofs_read_metabuf(&buf, sb, pos);
> +	h = erofs_read_metabuf(&map->buf, sb, pos);
>   	if (IS_ERR(h)) {
>   		err = PTR_ERR(h);
>   		goto out_unlock;
> @@ -684,7 +683,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>   		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
>   			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
>   		err = -EOPNOTSUPP;
> -		goto out_put_metabuf;
> +		goto out_unlock;
>   	}
>   
>   	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
> @@ -693,7 +692,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>   		erofs_err(sb, "per-inode big pcluster without sb feature for nid %llu",
>   			  vi->nid);
>   		err = -EFSCORRUPTED;
> -		goto out_put_metabuf;
> +		goto out_unlock;
>   	}
>   	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
>   	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
> @@ -701,27 +700,20 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>   		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
>   			  vi->nid);
>   		err = -EFSCORRUPTED;
> -		goto out_put_metabuf;
> +		goto out_unlock;
>   	}
>   
>   	if (vi->z_idata_size ||
>   	    (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
> -		struct erofs_map_blocks map = {
> -			.buf = __EROFS_BUF_INITIALIZER
> -		};
> -
> -		err = z_erofs_map_blocks_fo(inode, &map,
> +		err = z_erofs_map_blocks_fo(inode, map,
>   					    EROFS_GET_BLOCKS_FINDTAIL);
> -		erofs_put_metabuf(&map.buf);
>   		if (err < 0)
> -			goto out_put_metabuf;
> +			goto out_unlock;

Note that it has a regression, so need to discard this part.

Thanks,
Gao Xiang

