Return-Path: <linux-kernel+bounces-773070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BF2B29B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FEC95E740D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B95283144;
	Mon, 18 Aug 2025 07:45:01 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B70927CCF0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503101; cv=none; b=pNu8UZh+9z67eDl7I27vc63IZ0qVnnIt5dtW+fLPn1sY8/cIL8BE66SwscT7/PXCg9hWr6MqjIiSyBcsZaHf6QmYatmqWr/5Zph1Kkp1Sj29WpfG69ymig2CevwnY1PQq+Fq6lXZ8kljMB+cyKcavvrr3VrPbndGtwOo3fwDm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503101; c=relaxed/simple;
	bh=g4ONOxm0/VVrS2pMOFkdUfLc6wVu5Lh4XD7UvyAAQtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HnA+hkmX07mrJcubJbTzlGiL34fnMqT2CSn6IRI3P9+O5hlZxvvaESxctG/cKLcvKCQqdBuTloEZRThEQfFt0ZTqRFnNjz6hE+8yb3jcVWRtekSjgNiJPsx9zG08GaIQDVtECQ1HANLJdP7wxF7FxO1UnVoy7/KjwFjOdEgccxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c54Vs6dHmzvX44;
	Mon, 18 Aug 2025 15:44:53 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id C5BD6140132;
	Mon, 18 Aug 2025 15:44:56 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 15:44:56 +0800
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 15:44:55 +0800
Message-ID: <d85d1411-80cb-4e5d-87bd-ae7c45f5fd0c@huawei.com>
Date: Mon, 18 Aug 2025 15:44:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 drm-dp 11/11] drm/hisilicon/hibmc: moving HDCP cfg
 after the dp reset operation.
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <liangjian010@huawei.com>,
	<chenjianmin@huawei.com>, <fengsheng5@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<shiyongbang@huawei.com>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
 <20250813094238.3722345-12-shiyongbang@huawei.com>
 <vsnpvyvebdzvythe3q4xj6ks5ionjtnd5jcsjjfbv3ptgdrw46@3ccvex2wqjho>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <vsnpvyvebdzvythe3q4xj6ks5ionjtnd5jcsjjfbv3ptgdrw46@3ccvex2wqjho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100007.china.huawei.com (7.202.195.175)


> On Wed, Aug 13, 2025 at 05:42:38PM +0800, Yongbang Shi wrote:
>> From: Baihan Li <libaihan@huawei.com>
>>
>> The DP reset was adding in the former commit, so move HDCP cfg after DP
>> controller deresets, so that configuration takes effect.
>>
>> Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
>> Signed-off-by: Baihan Li <libaihan@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> This should be squashed into reset commit.

Okay, thanks!


>> ---
>> ChangeLog:
>> v3 -> v4:
>>    - fix the commit subject, suggested by Dmitry Baryshkov.
>> v2 -> v3:
>>    - split into 2 commits, suggested by Dmitry Baryshkov.
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>> index 18beef71d85f..73a0c0156092 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>> @@ -176,8 +176,6 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>>   	dp_dev->link.cap.lanes = 0x2;
>>   	dp_dev->link.cap.link_rate = DP_LINK_BW_8_1;
>>   
>> -	/* hdcp data */
>> -	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
>>   	/* int init */
>>   	writel(0, dp_dev->base + HIBMC_DP_INTR_ENABLE);
>>   	writel(HIBMC_DP_INT_RST, dp_dev->base + HIBMC_DP_INTR_ORIGINAL_STATUS);
>> @@ -187,6 +185,8 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>>   	writel(0, dp_dev->base + HIBMC_DP_DPTX_RST_CTRL);
>>   	usleep_range(30, 50);
>>   	writel(HIBMC_DP_DPTX_RST, dp_dev->base + HIBMC_DP_DPTX_RST_CTRL);
>> +	/* hdcp data */
>> +	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
>>   	/* clock enable */
>>   	writel(HIBMC_DP_CLK_EN, dp_dev->base + HIBMC_DP_DPTX_CLK_CTRL);
>>   
>> -- 
>> 2.33.0
>>

