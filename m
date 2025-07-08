Return-Path: <linux-kernel+bounces-721412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA099AFC8E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA641BC3161
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD02C374B;
	Tue,  8 Jul 2025 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2nMeY4m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F11221282
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971876; cv=none; b=PkfIy99EAmHC/1cd+oMQm+37sTC/GZYz/zwlstBTLLtsXNWXTrxRbh343gUmn28PGt7Nh3sacBnSdOCMno9CsUvXLdaldG6W7iKQQk9TLX8HfRtCad/GDiDBVAXTDOA0gDumg+nMbHaFNOsmk1GyCTh2HibJt1VKexx/BMbNUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971876; c=relaxed/simple;
	bh=IWFwLdVjUFsiW9YXkXJxZjlcfthKmL+sH9ZCpSOBw4w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XAIQsapvrwBkxIFTOi8L0awV7XuGipeAINae08/CFWDtdpN93W+gD5nwTJoTWbAg6tHsdziPtR2KEkks9vN+C4dib8pWElmASU+kiKBf3jWcjyODlmJ2l5fWHj0TweqxFCyNjtGxUMYNpOn9PD/vj0yJ1fwzPyZ4jsyRYb9WIBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2nMeY4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ABEC4CEED;
	Tue,  8 Jul 2025 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751971876;
	bh=IWFwLdVjUFsiW9YXkXJxZjlcfthKmL+sH9ZCpSOBw4w=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=A2nMeY4mB10I8KbrIph0HGhFnahBmPKzxHl4RyuYtLWM/odPIBKxP3BaEOp4cKa49
	 uzUEx/wsRAQYvRU25GT1NU1TTaVK7LIMFt7KDWfGrrj4yIGOXs5zQ5BBwfNkLptH6G
	 /rPVvmNX35dPPR2AVgPjdkrlRPuHms83NA1LNxi8fwJcBmwTS9kHqSMv3fdhIn+l88
	 aohtGTgJtYjtc4jwIRS4K8USCTaKGcDhnwAEa22ClBDoalAjmrWWSMoh2i2hfshrQY
	 gIQtuR5XjlhgApC3Pn8QOlkHPR8AweA013F+iNarLhYyswyyZo5YfCLSUmF6/S+/lL
	 6C9yQe1bRFWwQ==
Message-ID: <a2431122-9b24-410c-92b4-53b9f0783e02@kernel.org>
Date: Tue, 8 Jul 2025 18:51:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH] erofs: do sanity check on m->type in
 z_erofs_load_compact_lcluster()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250707084723.2725437-1-chao@kernel.org>
 <e367f45a-b511-4f64-a528-807317004a2e@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <e367f45a-b511-4f64-a528-807317004a2e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/8/25 10:58, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/7/7 16:47, Chao Yu wrote:
>> All below functions will do sanity check on m->type, let's move sanity
>> check to z_erofs_load_compact_lcluster() for cleanup.
>> - z_erofs_map_blocks_fo
>> - z_erofs_get_extent_compressedlen
>> - z_erofs_get_extent_decompressedlen
>> - z_erofs_extent_lookback
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
> How about appending the following diff to tidy up the code
> a bit further (avoid `goto map_block` and `goto out`)?

Xiang,

Looks good to me, will append the diff in the patch.

Thanks,

> 
> 
>  fs/erofs/zmap.c | 67 +++++++++++++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index e530b152e14e..431199452542 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -327,21 +327,18 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>      DBG_BUGON(lcn == initial_lcn &&
>            m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
>  
> -    if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
> -        if (m->delta[0] != 1) {
> -            erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
> -            DBG_BUGON(1);
> -            return -EFSCORRUPTED;
> -        }
> -        if (m->compressedblks)
> -            goto out;
> +    if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD && m->delta[0] != 1) {
> +        erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
> +        DBG_BUGON(1);
> +        return -EFSCORRUPTED;
>      }
>  
>      /*
>       * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type rather
>       * than CBLKCNT, it's a 1 block-sized pcluster.
>       */
> -    m->compressedblks = 1;
> +    if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD || !m->compressedblks)
> +        m->compressedblks = 1;
>  out:
>      m->map->m_plen = erofs_pos(sb, m->compressedblks);
>      return 0;
> @@ -422,36 +419,34 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
>      map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
>      end = (m.lcn + 1ULL) << lclusterbits;
>  
> -    if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
> -        if (endoff >= m.clusterofs) {
> -            m.headtype = m.type;
> -            map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
> -            /*
> -             * For ztailpacking files, in order to inline data more
> -             * effectively, special EOF lclusters are now supported
> -             * which can have three parts at most.
> -             */
> -            if (ztailpacking && end > inode->i_size)
> -                end = inode->i_size;
> -            goto map_block;
> +    if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD && endoff >= m.clusterofs) {
> +        m.headtype = m.type;
> +        map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
> +        /*
> +         * For ztailpacking files, in order to inline data more
> +         * effectively, special EOF lclusters are now supported
> +         * which can have three parts at most.
> +         */
> +        if (ztailpacking && end > inode->i_size)
> +            end = inode->i_size;
> +    } else {
> +        if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
> +            /* m.lcn should be >= 1 if endoff < m.clusterofs */
> +            if (!m.lcn) {
> +                erofs_err(sb, "invalid logical cluster 0 at nid %llu",
> +                      vi->nid);
> +                err = -EFSCORRUPTED;
> +                goto unmap_out;
> +            }
> +            end = (m.lcn << lclusterbits) | m.clusterofs;
> +            map->m_flags |= EROFS_MAP_FULL_MAPPED;
> +            m.delta[0] = 1;
>          }
> -        /* m.lcn should be >= 1 if endoff < m.clusterofs */
> -        if (!m.lcn) {
> -            erofs_err(sb, "invalid logical cluster 0 at nid %llu",
> -                  vi->nid);
> -            err = -EFSCORRUPTED;
> +        /* get the corresponding first chunk */
> +        err = z_erofs_extent_lookback(&m, m.delta[0]);
> +        if (err)
>              goto unmap_out;
> -        }
> -        end = (m.lcn << lclusterbits) | m.clusterofs;
> -        map->m_flags |= EROFS_MAP_FULL_MAPPED;
> -        m.delta[0] = 1;
>      }
> -
> -    /* get the corresponding first chunk */
> -    err = z_erofs_extent_lookback(&m, m.delta[0]);
> -    if (err)
> -        goto unmap_out;
> -map_block:
>      if (m.partialref)
>          map->m_flags |= EROFS_MAP_PARTIAL_REF;
>      map->m_llen = end - map->m_la;


