Return-Path: <linux-kernel+bounces-720832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9327AFC0E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910E41AA5C87
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7873C22156A;
	Tue,  8 Jul 2025 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bQgdw0Rk"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5021B908
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751942127; cv=none; b=ioZXgPQJrFHw/RLH8Xy48hlS3cNdVbWofVc8yJdah3If7LxuEtoo1Neu4IW0/mpiSIXbmMcsmcNGUC2/S8q11aPuizSJMDw/blWt1Ai7b4jp/PQ8n1pu/7sXq4qO3qYrff3So1MWQSHqt03UM+HE80s/bkRgmwV/+05NbiWXkks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751942127; c=relaxed/simple;
	bh=sFC8PKwu9nWxKpvGlMwBOzZRtxkZmrq/5Q3gD3HOggk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k33dOsSTr1q9KbmePmzV3rwxWNTt1nBnlB2paNsu/a4NBo4av/VLQbOL1+/wRfYDye8Yc9g6pmphd5C5rBwV03+YP2AVJ0TPCEq9cfKLEOr1o6hF8UbEfc8hUha86ORrWQk7u9BRg4IzG1kfgJyz4dCyMvTNJct+kzovNJU0kIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bQgdw0Rk; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751942116; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DJouJoPGQ/wtVO05sl/QvXv0R/AiW/eMB9jzTKKTOXM=;
	b=bQgdw0RkX5coDIOUcKUgRzvERx6VZAttrZG43pe+0b+3JxM6/Vjd+FEeV1p+jhUj6B3li5DO9CBUgXIGszNFr3G+IAmaw/IyEtQ+/IbSKOcurIaqnjn/g1lE5BhW7PgABFPYE+ilc8CfmBHOVyn2fcKxh8Fc8fRkRJBMGFKR0Lw=
Received: from 30.221.131.215(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiIzyXk_1751942101 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 10:35:16 +0800
Message-ID: <1a27683d-580b-4fa9-bd86-902ea78afe46@linux.alibaba.com>
Date: Tue, 8 Jul 2025 10:35:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: do sanity check on m->type in
 z_erofs_load_compact_lcluster()
To: Hongbo Li <lihongbo22@huawei.com>, Chao Yu <chao@kernel.org>,
 xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>
References: <20250707084723.2725437-1-chao@kernel.org>
 <3d04116f-5cee-4d41-9150-abbeb18f80be@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3d04116f-5cee-4d41-9150-abbeb18f80be@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/8 10:30, Hongbo Li wrote:
> 
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
>> ---
>>   fs/erofs/zmap.c | 60 ++++++++++++++++++-------------------------------
>>   1 file changed, 22 insertions(+), 38 deletions(-)
>>
>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>> index 0bebc6e3a4d7..e530b152e14e 100644
>> --- a/fs/erofs/zmap.c
>> +++ b/fs/erofs/zmap.c
>> @@ -240,6 +240,13 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
>>   static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
>>                          unsigned int lcn, bool lookahead)
>>   {
>> +    if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>> +        erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
>> +                m->type, lcn, EROFS_I(m->inode)->nid);
>> +        DBG_BUGON(1);
>> +        return -EOPNOTSUPP;
>> +    }
>> +
> 
> Hi, Chao,
> 
> After moving the condition in here, there is no need to check in z_erofs_extent_lookback, z_erofs_get_extent_compressedlen and z_erofs_get_extent_decompressedlen. Because in z_erofs_map_blocks_fo, the condition has been checked in before. Right?

I've replied some similar question.

Because z_erofs_get_extent_compressedlen and z_erofs_get_extent_decompressedlen()
use the different lcn (lcluster) against z_erofs_map_blocks_fo().

So if a new lcn(lcluster number) is loaded, we'd check if the type is valid.

Thanks,
Gao Xiang


