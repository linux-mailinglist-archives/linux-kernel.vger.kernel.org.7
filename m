Return-Path: <linux-kernel+bounces-709511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A6EAEDEDD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 15:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B4D403BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 13:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3240D28BAA1;
	Mon, 30 Jun 2025 13:16:16 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DA928983D
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289375; cv=none; b=Yi/xMt5hdfM/IMNpK2GWbxczmPKlUhbVj0j0AD7w5KtrBuUejxrPszADTOApX7nkxk50g3xDGC28+303Hs0+qrewwnYsdRMY319rFy5I6XaxlWJQaGwoJyOBZ4k48isdIsVIjlIVrV5amk+PAcifADyLRGMnJutyfG0v/5H8+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289375; c=relaxed/simple;
	bh=yI7xS4fu494AShE82Sd/Hk6100qffahcYlstR3+0jvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UuEyTikOJgX2yYtAomz6ulF26YVlj5pyG2FsXU3YhjsbMa2xaHzJ8kLsL7XcJbVPJgvKRlpl25zFsAsGdcslEspy7hE/MPqmf/Y5apDbTz7lN7R20bGzidNJvE1JB2ONhRWd3eg2LSL1L6np2XqSxVRw6WfuI1+SResPSTyM4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bW66w2ys8z13MgC;
	Mon, 30 Jun 2025 21:13:44 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id BEE451402CF;
	Mon, 30 Jun 2025 21:16:11 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Jun 2025 21:16:11 +0800
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Jun 2025 21:16:10 +0800
Message-ID: <297f550b-8561-4ab9-ab7b-b7b47078803d@huawei.com>
Date: Mon, 30 Jun 2025 21:16:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 drm-dp 08/10] drm/hisilicon/hibmc: fix no showing when
 no connectors connected
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <liangjian010@huawei.com>,
	<chenjianmin@huawei.com>, <lidongming5@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<jani.nikula@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <shiyongbang@huawei.com>
References: <20250620093104.2016196-1-shiyongbang@huawei.com>
 <20250620093104.2016196-9-shiyongbang@huawei.com>
 <d3d23wf72e66e2lyj3jqsmajuskx5zbqok33o2sx3wrd3nipje@wavrn6adtbtx>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <d3d23wf72e66e2lyj3jqsmajuskx5zbqok33o2sx3wrd3nipje@wavrn6adtbtx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq100007.china.huawei.com (7.202.195.175)


> On Fri, Jun 20, 2025 at 05:31:02PM +0800, Yongbang Shi wrote:
>> From: Baihan Li <libaihan@huawei.com>
>>
>> Our chip support KVM over IP feature, so hibmc driver need to support
>> displaying without any connectors plugged in. Deleting the detect_ctx()
>> of VGA to make it connected when no connector is detected.
> I think, there is more than that. Please see how AST driver handles the
> same issue. I think you need something similar.

Okay, thanks for your advice!


>> Fixes: 4c962bc929f1 ("drm/hisilicon/hibmc: Add vga connector detect functions")
>> Signed-off-by: Baihan Li <libaihan@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> index 841e81f47b68..953474d04b5c 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> @@ -60,7 +60,6 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
>>   static const struct drm_connector_helper_funcs
>>   	hibmc_connector_helper_funcs = {
>>   	.get_modes = hibmc_connector_get_modes,
>> -	.detect_ctx = drm_connector_helper_detect_from_ddc,
>>   };
>>   
>>   static const struct drm_connector_funcs hibmc_connector_funcs = {
>> -- 
>> 2.33.0
>>

