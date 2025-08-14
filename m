Return-Path: <linux-kernel+bounces-768769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9A4B26541
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 958B27BFD49
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014C42FCC01;
	Thu, 14 Aug 2025 12:19:48 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44DD15D3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173987; cv=none; b=basuaOl94ueXd8LPwAoz/Hq4W/+hqofRZqpQj+mL0jhxAY+5FuWKWdKUrs+p1ioDaJSHypHWtpPQTu+78dBeulxnIEDvr4qJ1832zPSAQTGhI1AzVZxsK0K+vlkbLKKf2cqqtbtTqZldKSxnpYSIxOtx1Y+Nh8buGepDN3siHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173987; c=relaxed/simple;
	bh=A7TwX+6vzT7UwTiDp02xeDkZGg8b0d/GRe+by0OpddI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uaYc5K5NXM6GZLHxSEOxcw1c7aGFfOEDveNfg965SN5yU4kA3ZLUnC1ExHyEDspuC1OqMkiDb2lorENdSLY35inK1Za0/CgIIslyImRk0oCT3A83WdnMLtU6FJ4xZ/rHIgfQhX/GqdxgswZ4ezcvYj9OAZrIUbJeixH+/1xrcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c2khp1tjmzdcHb;
	Thu, 14 Aug 2025 20:15:22 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C11B14027A;
	Thu, 14 Aug 2025 20:19:42 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 20:19:42 +0800
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 20:19:41 +0800
Message-ID: <1dd93bb7-4f67-4b9b-8b6a-d7c5c77cf807@huawei.com>
Date: Thu, 14 Aug 2025 20:19:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 drm-dp 02/11] drm/hisilicon/hibmc: fix dp
 probabilistical detect errors after HPD irq
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
 <20250813094238.3722345-3-shiyongbang@huawei.com>
 <aayi7zjrmru2ancexrqmcutams6ohde3nrkhqacixwp45dsk4v@7ig6hqzahdxf>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <aayi7zjrmru2ancexrqmcutams6ohde3nrkhqacixwp45dsk4v@7ig6hqzahdxf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq100007.china.huawei.com (7.202.195.175)


> On Wed, Aug 13, 2025 at 05:42:29PM +0800, Yongbang Shi wrote:
>> From: Baihan Li <libaihan@huawei.com>
>>
>> The debouncing when HPD pulled out still remains sometimes, 200ms still can
>> not ensure helper_detect() is correct. So add a flag to hold the sink
>> status, and changed detect_ctx() functions by using flag to check status.
> THis doesn't explain what is wrong with
> drm_connector_helper_detect_from_ddc(). In the end, this function
> doesn't use the HPD pin.

I'm sorry about the misunderstanding.
The issue is that after plugging or unplugging the monitor, the driver takes no action sometimes
even though an interrupt is triggered. The root cause is that drm_connector_helper_detect_from_ddc()
still returns connected status when the monitor is unplugged.
And I will fix the way in the end.

Thanks,
Baihan Li!


>> Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
>> Signed-off-by: Baihan Li <libaihan@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> ---
>> ChangeLog:
>> v3 -> v4:
>>    - remove link training process in hibmc_dp_detect(), suggested by Dmitry Baryshkov.
>>    - remove if (dev->registered), suggested by Dmitry Baryshkov.
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  1 +
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 19 ++++++++++++-------
>>   2 files changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
>> index 665f5b166dfb..68867475508c 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
>> @@ -50,6 +50,7 @@ struct hibmc_dp {
>>   	struct drm_dp_aux aux;
>>   	struct hibmc_dp_cbar_cfg cfg;
>>   	u32 irq_status;
>> +	int hpd_status;
>>   };
>>   
>>   int hibmc_dp_hw_init(struct hibmc_dp *dp);
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> index d06832e62e96..ded38530ecda 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> @@ -34,9 +34,12 @@ static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
>>   static int hibmc_dp_detect(struct drm_connector *connector,
>>   			   struct drm_modeset_acquire_ctx *ctx, bool force)
>>   {
>> -	mdelay(200);
>> +	struct hibmc_dp *dp = to_hibmc_dp(connector);
>>   
>> -	return drm_connector_helper_detect_from_ddc(connector, ctx, force);
>> +	if (dp->hpd_status)
>> +		return connector_status_connected;
>> +	else
>> +		return connector_status_disconnected;
>>   }
>>   
>>   static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
>> @@ -115,21 +118,23 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
>>   {
>>   	struct drm_device *dev = (struct drm_device *)arg;
>>   	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>> +	struct hibmc_dp *dp = &priv->dp;
>>   	int idx;
>>   
>>   	if (!drm_dev_enter(dev, &idx))
>>   		return -ENODEV;
>>   
>> -	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
>> +	if (((dp->irq_status & DP_MASKED_SINK_HPD_PLUG_INT) && !dp->hpd_status)) {
>>   		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
>> -		hibmc_dp_hpd_cfg(&priv->dp);
>> +		hibmc_dp_hpd_cfg(dp);
>> +		dp->hpd_status = 1;
>>   	} else {
>>   		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
>> -		hibmc_dp_reset_link(&priv->dp);
>> +		hibmc_dp_reset_link(dp);
>> +		dp->hpd_status = 0;
>>   	}
>>   
>> -	if (dev->registered)
>> -		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
>> +	drm_connector_helper_hpd_irq_event(&priv->dp.connector);
>>   
>>   	drm_dev_exit(idx);
>>   
>> -- 
>> 2.33.0
>>

