Return-Path: <linux-kernel+bounces-720838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636CAFC100
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598D73A4B32
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD30D1F4171;
	Tue,  8 Jul 2025 02:45:31 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B9188006
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751942731; cv=none; b=N9YwadQmj28P8R0qvq4ZlTIQX2hoRlKEj1L4e8+1LfbhyUufOg546Rsx9KhrsmZ53MRMSnG1UGRLmokqQtPWr92XE5xwq14CXai4b6wFkXdDwX93iwiylssJ6W7tClmdbU0yfuZtT4FUG/V4Jl7iBI1Gzq2azF3yj2W+hM9WLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751942731; c=relaxed/simple;
	bh=YfxRj5s+jENBuu7mUTraH2fWygobTQ2Z55EG7oWbOTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Weh0FyRSotKqQkMRKEAbip2q3FyH+YOS+wjy/nVCxWI3sB2jg5OpcncndRI2Fr7T4amTqdemvh80wCIO6y6fMvgwtZibgdLKbt6u5t14fCRcOKZk/AlwyIgbw9TKwhQqjE27Q9I4Vz+FO3iTo7nILfk98yBUPFNqBuwauQs+Trs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bblj35d8NzWfxm;
	Tue,  8 Jul 2025 10:40:55 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id F36CE180B64;
	Tue,  8 Jul 2025 10:45:20 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 10:45:20 +0800
Message-ID: <e759af7b-0aef-4f3e-a84b-91a24602b32c@huawei.com>
Date: Tue, 8 Jul 2025 10:45:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: do sanity check on m->type in
 z_erofs_load_compact_lcluster()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
	<xiang@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Yue Hu
	<zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
	<dhavale@google.com>
References: <20250707084723.2725437-1-chao@kernel.org>
 <3d04116f-5cee-4d41-9150-abbeb18f80be@huawei.com>
 <1a27683d-580b-4fa9-bd86-902ea78afe46@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <1a27683d-580b-4fa9-bd86-902ea78afe46@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/7/8 10:35, Gao Xiang wrote:
> 
> 
> On 2025/7/8 10:30, Hongbo Li wrote:
>>
>>
>> On 2025/7/7 16:47, Chao Yu wrote:
>>> All below functions will do sanity check on m->type, let's move sanity
>>> check to z_erofs_load_compact_lcluster() for cleanup.
>>> - z_erofs_map_blocks_fo
>>> - z_erofs_get_extent_compressedlen
>>> - z_erofs_get_extent_decompressedlen
>>> - z_erofs_extent_lookback
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>   fs/erofs/zmap.c | 60 ++++++++++++++++++-------------------------------
>>>   1 file changed, 22 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>>> index 0bebc6e3a4d7..e530b152e14e 100644
>>> --- a/fs/erofs/zmap.c
>>> +++ b/fs/erofs/zmap.c
>>> @@ -240,6 +240,13 @@ static int z_erofs_load_compact_lcluster(struct 
>>> z_erofs_maprecorder *m,
>>>   static int z_erofs_load_lcluster_from_disk(struct 
>>> z_erofs_maprecorder *m,
>>>                          unsigned int lcn, bool lookahead)
>>>   {
>>> +    if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>> +        erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid 
>>> %llu",
>>> +                m->type, lcn, EROFS_I(m->inode)->nid);
>>> +        DBG_BUGON(1);
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +
>>
>> Hi, Chao,
>>
>> After moving the condition in here, there is no need to check in 
>> z_erofs_extent_lookback, z_erofs_get_extent_compressedlen and 
>> z_erofs_get_extent_decompressedlen. Because in z_erofs_map_blocks_fo, 
>> the condition has been checked in before. Right?
> 
> I've replied some similar question.
> 
> Because z_erofs_get_extent_compressedlen and 
> z_erofs_get_extent_decompressedlen()
> use the different lcn (lcluster) against z_erofs_map_blocks_fo().
> 
> So if a new lcn(lcluster number) is loaded, we'd check if the type is 
> valid.
> 
Ok, the type will change after loading.

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 

