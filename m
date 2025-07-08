Return-Path: <linux-kernel+bounces-720829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4A9AFC0D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1AE422F8E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4832B1386C9;
	Tue,  8 Jul 2025 02:30:10 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A119220F24
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751941809; cv=none; b=YsX2uE126gsUvVV+pfTuhGxDsYvUPt7huA8Z67mHZFF02bIdtcOzFDTQmA+k1mpo33fEq1jHU9/kTsGeC09+rSV8hwS+Nx226qsjt6p1VK+uxWF/wYvg0MTAPEJ16Mu7gwCd1hvAAiIies3Q5AzYFuGJN9dzIQFeBno+qYqMuBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751941809; c=relaxed/simple;
	bh=kBwFoiImc05wFpA6fOjaL/D0R61XhsMbJjQgEh1NSaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ViyOZh2cLI0Ix2o/+mh4Nx4r4zSmG2ZAy+LntZbl/MzoTo4HBRYLIXiituEh/CkppPYbTz9JBD/gik8WXzv1KFz7TQlrZzYaIiN0bqVD15b2NYbKdLBzwp+4++1nc6Wvvbfzewo0JmimxMyajvDH50mwXAQD2kufOkL2dooSVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bblQK6JZpz2SSkl;
	Tue,  8 Jul 2025 10:28:09 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F35614011B;
	Tue,  8 Jul 2025 10:30:03 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 10:30:02 +0800
Message-ID: <3d04116f-5cee-4d41-9150-abbeb18f80be@huawei.com>
Date: Tue, 8 Jul 2025 10:30:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: do sanity check on m->type in
 z_erofs_load_compact_lcluster()
To: Chao Yu <chao@kernel.org>, <xiang@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Yue Hu
	<zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
	<dhavale@google.com>
References: <20250707084723.2725437-1-chao@kernel.org>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250707084723.2725437-1-chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/7/7 16:47, Chao Yu wrote:
> All below functions will do sanity check on m->type, let's move sanity
> check to z_erofs_load_compact_lcluster() for cleanup.
> - z_erofs_map_blocks_fo
> - z_erofs_get_extent_compressedlen
> - z_erofs_get_extent_decompressedlen
> - z_erofs_extent_lookback
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/erofs/zmap.c | 60 ++++++++++++++++++-------------------------------
>   1 file changed, 22 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 0bebc6e3a4d7..e530b152e14e 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -240,6 +240,13 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
>   static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
>   					   unsigned int lcn, bool lookahead)
>   {
> +	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
> +		erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
> +				m->type, lcn, EROFS_I(m->inode)->nid);
> +		DBG_BUGON(1);
> +		return -EOPNOTSUPP;
> +	}
> +

Hi, Chao,

After moving the condition in here, there is no need to check in 
z_erofs_extent_lookback, z_erofs_get_extent_compressedlen and 
z_erofs_get_extent_decompressedlen. Because in z_erofs_map_blocks_fo, 
the condition has been checked in before. Right?

Thanks,
Hongbo

>   	switch (EROFS_I(m->inode)->datalayout) {
>   	case EROFS_INODE_COMPRESSED_FULL:
>   		return z_erofs_load_full_lcluster(m, lcn);
> @@ -265,12 +272,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>   		if (err)
>   			return err;
>   
> -		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
> -			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
> -				  m->type, lcn, vi->nid);
> -			DBG_BUGON(1);
> -			return -EOPNOTSUPP;
> -		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
> +		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>   			lookback_distance = m->delta[0];
>   			if (!lookback_distance)
>   				break;
> @@ -333,17 +335,13 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>   		}
>   		if (m->compressedblks)
>   			goto out;
> -	} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
> -		/*
> -		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
> -		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
> -		 */
> -		m->compressedblks = 1;
> -		goto out;
>   	}
> -	erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
> -	DBG_BUGON(1);
> -	return -EFSCORRUPTED;
> +
> +	/*
> +	 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type rather
> +	 * than CBLKCNT, it's a 1 block-sized pcluster.
> +	 */
> +	m->compressedblks = 1;
>   out:
>   	m->map->m_plen = erofs_pos(sb, m->compressedblks);
>   	return 0;
> @@ -379,11 +377,6 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
>   			if (lcn != headlcn)
>   				break;	/* ends at the next HEAD lcluster */
>   			m->delta[1] = 1;
> -		} else {
> -			erofs_err(inode->i_sb, "unknown type %u @ lcn %llu of nid %llu",
> -				  m->type, lcn, vi->nid);
> -			DBG_BUGON(1);
> -			return -EOPNOTSUPP;
>   		}
>   		lcn += m->delta[1];
>   	}
> @@ -429,10 +422,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
>   	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
>   	end = (m.lcn + 1ULL) << lclusterbits;
>   
> -	switch (m.type) {
> -	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
> -	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
> +	if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>   		if (endoff >= m.clusterofs) {
>   			m.headtype = m.type;
>   			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
> @@ -443,7 +433,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
>   			 */
>   			if (ztailpacking && end > inode->i_size)
>   				end = inode->i_size;
> -			break;
> +			goto map_block;
>   		}
>   		/* m.lcn should be >= 1 if endoff < m.clusterofs */
>   		if (!m.lcn) {
> @@ -455,19 +445,13 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
>   		end = (m.lcn << lclusterbits) | m.clusterofs;
>   		map->m_flags |= EROFS_MAP_FULL_MAPPED;
>   		m.delta[0] = 1;
> -		fallthrough;
> -	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
> -		/* get the corresponding first chunk */
> -		err = z_erofs_extent_lookback(&m, m.delta[0]);
> -		if (err)
> -			goto unmap_out;
> -		break;
> -	default:
> -		erofs_err(sb, "unknown type %u @ offset %llu of nid %llu",
> -			  m.type, ofs, vi->nid);
> -		err = -EOPNOTSUPP;
> -		goto unmap_out;
>   	}
> +
> +	/* get the corresponding first chunk */
> +	err = z_erofs_extent_lookback(&m, m.delta[0]);
> +	if (err)
> +		goto unmap_out;
> +map_block:
>   	if (m.partialref)
>   		map->m_flags |= EROFS_MAP_PARTIAL_REF;
>   	map->m_llen = end - map->m_la;

