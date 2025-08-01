Return-Path: <linux-kernel+bounces-753144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1360B17F32
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CFE5871C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF5E223719;
	Fri,  1 Aug 2025 09:24:52 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E72213E89
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040291; cv=none; b=lmqrWDatCNCHfQom4gys/mCzSq+9CYUU0Yeav90pUM4/7rRJ1cjUUSYy6oALaCuH+sdVAkuKja4Z/I08uXRlvuws1O/AG4AgNs9bwx8uISm4sQ0MAb4yniprbz+F7sj8kx2Q+m8V8lroevv/BNNGGEJ3Zfh9P4AoP/rnjUaySHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040291; c=relaxed/simple;
	bh=KFyQqUvWusPmLNyr3ZHMCKOwiHWG2kvdhYivq2mIuUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OEntoFsArtp1z27r+pAvMDEGBPGOX5chTmkC2rcxcdZHXJA/0obi8HLeHkniXFshV1qWKO4fjN1GdgtdRz2PgudOoVQySOfHQ6nPwXuipcNmWrQS7nSODQhRXW4M2ZnN5ngenh4ePOvdfq2mEp/mZrjis4q9NPp9rYKw6YQNxo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4btgVf414fztT1p;
	Fri,  1 Aug 2025 17:23:38 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id E92211402DF;
	Fri,  1 Aug 2025 17:24:40 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 17:24:40 +0800
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 17:24:40 +0800
Message-ID: <c43ba749-5748-4646-ab35-0ab8c0e1fa78@huawei.com>
Date: Fri, 1 Aug 2025 17:24:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 drm-dp 08/11] drm/hisilicon/hibmc: fix no showing when
 no connectors connected
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <liangjian010@huawei.com>,
	<chenjianmin@huawei.com>, <fengsheng5@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<jani.nikula@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <shiyongbang@huawei.com>
References: <20250718065125.2892404-1-shiyongbang@huawei.com>
 <20250718065125.2892404-9-shiyongbang@huawei.com>
 <tqbbkhod5et6yxyfhzmgelborrhwjaazk6ylkw3srlqmmkp6ou@jefvdyktsuds>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <tqbbkhod5et6yxyfhzmgelborrhwjaazk6ylkw3srlqmmkp6ou@jefvdyktsuds>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100007.china.huawei.com (7.202.195.175)


> On Fri, Jul 18, 2025 at 02:51:22PM +0800, Yongbang Shi wrote:
>> From: Baihan Li <libaihan@huawei.com>
>>
>> Our chip support KVM over IP feature, so hibmc diiver need to support
> I assume that KVM-over-IP doesnt provide EDID reads. This needs to be
> stated in the commit message.

Okay!


>> displaying without any connectors plugged in. If no connectors connected,
>> set the vdac connector status to 'connected' to handle BMC KVM. Use
>> is_connected to check all physical outputs.
>> For get_modes: using BMC modes for connector if no display is attached to
>> phys VGA cable, otherwise use EDID modes by drm_connector_helper_get_modes.
>>
>> Fixes: 4c962bc929f1 ("drm/hisilicon/hibmc: Add vga connector detect functions")
>> Signed-off-by: Baihan Li <libaihan@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> ---
>> ChangeLog:
>> v2 -> v3:
>>    - fix hibmc_connector_get_modes() and hibmc_vdac_detect() to realize BMC KVM, suggested by Dmitry Baryshkov.
>> ---
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |  5 +-
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  4 ++
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 55 +++++++++++++------
>>   3 files changed, 45 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> index 99b30a6c7e06..262ebe6138f0 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> @@ -58,9 +58,12 @@ static int hibmc_dp_detect(struct drm_connector *connector,
>>   {
>>   	struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
>>   
>> -	if (!hibmc_dp_detect_link(&priv->dp))
>> +	if (!hibmc_dp_detect_link(&priv->dp)) {
>> +		priv->is_connected |= BIT(0);
> Magic value BIT(0)
>
>>   		return connector_status_connected;
>> +	}
>>   
>> +	priv->is_connected &= ~BIT(0);
>>   	return connector_status_disconnected;
>>   }
>>   
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> index ca8502e2760c..d68588ecec9b 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> @@ -31,6 +31,7 @@ struct hibmc_vdac {
>>   	struct drm_connector connector;
>>   	struct i2c_adapter adapter;
>>   	struct i2c_algo_bit_data bit_data;
>> +	int phys_status;
>>   };
>>   
>>   struct hibmc_drm_private {
>> @@ -43,6 +44,9 @@ struct hibmc_drm_private {
>>   	struct drm_crtc crtc;
>>   	struct hibmc_vdac vdac;
>>   	struct hibmc_dp dp;
>> +
>> +	/* VGA and DP phys connect status, BIT(0) is DP, BIT(1) is VGA */
> #define those.
>
>> +	int is_connected;
> And you need a lock around this one, otherwise you might get a race
> between DP's and VGA's code setting and clearing bits here.

Okay, thanks for your advice!
I will modify all of the above issues.


>>   };
>>   
>>   static inline struct hibmc_vdac *to_hibmc_vdac(struct drm_connector *connector)
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> index 841e81f47b68..3cdf640d1785 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> @@ -25,27 +25,18 @@
>>   static int hibmc_connector_get_modes(struct drm_connector *connector)
>>   {
>>   	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
>> -	const struct drm_edid *drm_edid;
>>   	int count;
>>   
>> -	drm_edid = drm_edid_read_ddc(connector, &vdac->adapter);
>> -
>> -	drm_edid_connector_update(connector, drm_edid);
>> -
>> -	if (drm_edid) {
>> -		count = drm_edid_connector_add_modes(connector);
>> -		if (count)
>> -			goto out;
>> +	if (vdac->phys_status == connector_status_connected) {
>> +		count = drm_connector_helper_get_modes(connector);
>> +	} else {
>> +		drm_edid_connector_update(connector, NULL);
>> +		count = drm_add_modes_noedid(connector,
>> +					     connector->dev->mode_config.max_width,
>> +					     connector->dev->mode_config.max_height);
>> +		drm_set_preferred_mode(connector, 1024, 768); // 1024x768
>>   	}
>>   
>> -	count = drm_add_modes_noedid(connector,
>> -				     connector->dev->mode_config.max_width,
>> -				     connector->dev->mode_config.max_height);
>> -	drm_set_preferred_mode(connector, 1024, 768);
>> -
>> -out:
>> -	drm_edid_free(drm_edid);
>> -
>>   	return count;
>>   }
>>   
>> @@ -57,10 +48,38 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
>>   	drm_connector_cleanup(connector);
>>   }
>>   
>> +static int hibmc_vdac_detect(struct drm_connector *connector,
>> +			     struct drm_modeset_acquire_ctx *ctx,
>> +			     bool force)
>> +{
>> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
>> +	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
>> +	enum drm_connector_status status;
>> +
>> +	status = drm_connector_helper_detect_from_ddc(connector, ctx, force);
>> +
>> +	vdac->phys_status = status;
>> +
>> +	if (status == connector_status_connected) {
>> +		priv->is_connected |= BIT(1);
>> +		return connector_status_connected;
>> +	}
>> +
>> +	priv->is_connected &= ~BIT(1);
>> +
>> +	/* if all connectors are disconnected,
>> +	 * return connected to support BMC KVM display.
>> +	 */
>> +	if (!priv->is_connected)
>> +		return connector_status_connected;
>> +
>> +	return connector_status_disconnected;
>> +}
>> +
>>   static const struct drm_connector_helper_funcs
>>   	hibmc_connector_helper_funcs = {
>>   	.get_modes = hibmc_connector_get_modes,
>> -	.detect_ctx = drm_connector_helper_detect_from_ddc,
>> +	.detect_ctx = hibmc_vdac_detect,
>>   };
>>   
>>   static const struct drm_connector_funcs hibmc_connector_funcs = {
>> -- 
>> 2.33.0
>>

