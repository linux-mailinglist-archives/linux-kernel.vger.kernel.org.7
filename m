Return-Path: <linux-kernel+bounces-738129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4E9B0B4CE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811D91898989
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 10:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135AA1E51EC;
	Sun, 20 Jul 2025 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="MqHVQJQe"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EE64A23;
	Sun, 20 Jul 2025 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753006036; cv=none; b=PGHIYXqXjBW6l0BOMV3bPDjUPrS7lpSDRShM9+JuXbkw+1w/b9M9j0oTeN6jqfvFuXCokflY2X1vBTBLWFOT00HP6GTqyXQtMwN3IWS35BZfM8tlRvMIGNdbwli0OxQ/IuPqO7uwd3T+x3xNl2D8GFy0TUogyrZqDvO/anAEATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753006036; c=relaxed/simple;
	bh=6mN67hZadsyweT7MULaeH8/5vhBeDbL2Trh3WMoneNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flihyLJ1FV7MFOKhR/BvWBnp6vLuIPqCNBcFfcJEn0Nw3DZUM6cto9S6KM+rpBkkGCGHvTa/MJJbVL4S3MO4qoKJq31saL58CNZm0UNVPaJaavMCZl7vylYQYiZtKOHbO6OPp47sAYyaq9WM0kpPwCEpZ2nxkrttBUNNoduSNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=MqHVQJQe; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1753006019;
	bh=HRxfufF4OUe+W5VRpXOA9RrWw0ix/G9yeSyBfXtoFkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=MqHVQJQelHI/KZnfskIVRZ7CcfZLRt/n6SLTeAEWWZ7AMO2sq8saTenv+lR5KAR6j
	 VbpPICty3T/ujG2D4m7n4497mQ5wzlqSPE+pJL4kaRjPEhKB/uTAmsaIGkbQMyD8F8
	 LqXTCwjbBUwTz6csN2zr+rokcg+M0wJK458ISVEc=
X-QQ-mid: esmtpgz14t1753006014t51320e67
X-QQ-Originating-IP: F7PdjKICQ8nRZpWX1lEhOBgGMEMX4m1ChMp59nydQx0=
Received: from [192.168.0.103] ( [117.25.58.172])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 20 Jul 2025 18:06:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11197095626192148985
Message-ID: <61E98DE80D7F342D+8e29ec49-1291-48f5-b47e-17aed7c4b032@airkyi.com>
Date: Sun, 20 Jul 2025 18:06:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] drm/rockchip: cdn-dp: Support handle lane info and
 HPD without extcon
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20250718062619.99-1-kernel@airkyi.com>
 <20250718062619.99-4-kernel@airkyi.com>
 <t3th2tqbnkmsqssypxvye6vsfhpw37sf7wyl53cso3r5pqa7qp@gn74pj75j4pb>
From: air windows <kernel@airkyi.com>
In-Reply-To: <t3th2tqbnkmsqssypxvye6vsfhpw37sf7wyl53cso3r5pqa7qp@gn74pj75j4pb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OFfQQ3bkz2z4et79pb1eegZJVLlzJ8KmsuIsU3+kaxV3BcZoBlBFrGQs
	DrkkF0C/7pKqoNew1CMgI8iPWeUqOo+yY8Oj+De/Tt6CCyuyCjzVX7Lh27bEYRtqHkiGwBz
	qgnieV9iozlCeHJSQci2wLuqR/hJwRmfJJr7VJj/8k0JFS/iYGpeMEzv53t8czcHTNeoeXX
	WujnXSpAvLqSYxXuBJKVvvqs/cjPqohjTMicdV0HT7LfIK4R2r1T3hdMR9dwMzIvR35wP1Z
	piUNfoiwxdvV6oV5y2wR1LgjrO2tyFhLh6tMMkKRRrVARFFofERJajVt+BjAoJ3XpmJlxPO
	IxxlycKpeuzsShL/5BP8Z2EXoP4Xc/Wal/QNqbs55Q43kLeLPdBj2qIayRKFZc/vBfWnLo0
	cW9VACSv93/FWW0rk5cnP6sZdz0qasDBZ/N8W/aEdWOjLkJK2xp8jxFWSU+vUf9M53KZaq9
	bLyCrS739fXCqy0pgl7PHOJF6XMAqO/kzlcNjFVZ2YOifgpJV5+ONdM+Sn73ILsKnPUuMKz
	iWkL4v+OTWU01IAx84xcST5iuhPtkTP6SwrBAjJFDawHhhk9ByIgW9Z+zLkJvab+Ps9csC+
	IzVm5HtX9tXNofIJWqNzSoIT08UaVT5iB11XGF3wmh5miDbUfiPLuh9zM5glCfXDnB5hWSR
	GLSqxI+MZ0BDBkPO8cCj2qVlbTrXFVLjR4A7pv5WbiUGLvMDXOh8JnSgwmSTHQofIllxKxQ
	gpemu7SSJJ6Kfqs9DRUVM8a44ezBFkzC4EXiexe3otGnoskRAhXI7yL4aKmex0n3OQU/TzC
	GmYgqqq7Vt0s/mSCfAiD9AHMNVa1pgMwxs7mT/o1LcObeYMOGudFg1AM3DHqG/JJfmPjmdp
	8WNjPGSyYbfTHVGPNwVqjFaPF2WatzjOaQ41myHpBzOSiKz6v3pHYEUWau9Q4g3UC/COnHJ
	KphCWXbUkDQ8n/dt6q0MfzJaaH2uS7zpEhd0nsGCPD61OFc6fuPV3siHp
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

在 2025/7/19 18:53, Dmitry Baryshkov 写道:

> On Fri, Jul 18, 2025 at 02:26:17PM +0800, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> This patch add support for get PHY lane info and handle HPD state
>> without help of extcon.
>>
>> There is no extcon needed if the Type-C controller is present. In this
>> case, cdn_dp_hpd_notify() will handle HPD event from USB/DP combo PHY,
>> and the lane info can be get from PHY instead of extcon.
> The DP AltMode driver will send drm_connector_oob_hotplug_event() to the
> DRM connector associated with the USB-C connector fwnode. However your
> DP connector will have fwnode set to the DP controller, if I'm not
> mistaken. So I doubt that HPD events are going to be delivered
> correctly.

Yes, that's exactly the case for the DP Altmode driver! I've thought of a few approaches, but none of them are elegant. Now it relying on the PHY driver to call the drm_connector_oob_hotplug_event(). You'll find the relevant code in the PHY driver.


>
>> The extcon device should still be supported if Type-C controller is
>> not present.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> - Ignore duplicate HPD events.
>>
>>   drivers/gpu/drm/rockchip/cdn-dp-core.c | 37 ++++++++++++++++++++------
>>   1 file changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>> index 24f6b3879f4b..b574b059b58d 100644
>> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>> @@ -156,6 +156,9 @@ static int cdn_dp_get_port_lanes(struct cdn_dp_port *port)
>>   	int dptx;
>>   	u8 lanes;
>>   
>> +	if (!edev)
>> +		return phy_get_bus_width(port->phy);
>> +
>>   	dptx = extcon_get_state(edev, EXTCON_DISP_DP);
>>   	if (dptx > 0) {
>>   		extcon_get_property(edev, EXTCON_DISP_DP,
>> @@ -219,7 +222,7 @@ static bool cdn_dp_check_sink_connection(struct cdn_dp_device *dp)
>>   	 * some docks need more time to power up.
>>   	 */
>>   	while (time_before(jiffies, timeout)) {
>> -		if (!extcon_get_state(port->extcon, EXTCON_DISP_DP))
>> +		if (port->extcon && !extcon_get_state(port->extcon, EXTCON_DISP_DP))
>>   			return false;
>>   
>>   		if (!cdn_dp_get_sink_count(dp, &sink_count))
>> @@ -385,11 +388,14 @@ static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
>>   		goto err_power_on;
>>   	}
>>   
>> -	ret = extcon_get_property(port->extcon, EXTCON_DISP_DP,
>> -				  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
>> -	if (ret) {
>> -		DRM_DEV_ERROR(dp->dev, "get property failed\n");
>> -		goto err_power_on;
>> +	property.intval = 0;
>> +	if (port->extcon) {
>> +		ret = extcon_get_property(port->extcon, EXTCON_DISP_DP,
>> +					  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
>> +		if (ret) {
>> +			DRM_DEV_ERROR(dp->dev, "get property failed\n");
>> +			goto err_power_on;
>> +		}
>>   	}
>>   
>>   	port->lanes = cdn_dp_get_port_lanes(port);
>> @@ -821,6 +827,17 @@ static int cdn_dp_audio_mute_stream(struct drm_connector *connector,
>>   	return ret;
>>   }
>>   
>> +static void cdn_dp_hpd_notify(struct drm_bridge *bridge,
>> +			      enum drm_connector_status status)
>> +{
>> +	struct cdn_dp_device *dp = bridge_to_dp(bridge);
>> +	enum drm_connector_status last_status =
>> +		dp->connected ? connector_status_connected : connector_status_disconnected;
>> +
>> +	if (last_status != status)
>> +		schedule_work(&dp->event_work);
>> +}
>> +
>>   static const struct drm_bridge_funcs cdn_dp_bridge_funcs = {
>>   	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>>   	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>> @@ -831,6 +848,7 @@ static const struct drm_bridge_funcs cdn_dp_bridge_funcs = {
>>   	.atomic_disable = cdn_dp_bridge_atomic_disable,
>>   	.mode_valid = cdn_dp_bridge_mode_valid,
>>   	.mode_set = cdn_dp_bridge_mode_set,
>> +	.hpd_notify = cdn_dp_hpd_notify,
>>   
>>   	.dp_audio_prepare = cdn_dp_audio_prepare,
>>   	.dp_audio_mute_stream = cdn_dp_audio_mute_stream,
>> @@ -1028,6 +1046,9 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
>>   	for (i = 0; i < dp->ports; i++) {
>>   		port = dp->port[i];
>>   
>> +		if (!port->extcon)
>> +			continue;
>> +
>>   		port->event_nb.notifier_call = cdn_dp_pd_event;
>>   		ret = devm_extcon_register_notifier(dp->dev, port->extcon,
>>   						    EXTCON_DISP_DP,
>> @@ -1120,14 +1141,14 @@ static int cdn_dp_probe(struct platform_device *pdev)
>>   		    PTR_ERR(phy) == -EPROBE_DEFER)
>>   			return -EPROBE_DEFER;
>>   
>> -		if (IS_ERR(extcon) || IS_ERR(phy))
>> +		if (IS_ERR(phy) || PTR_ERR(extcon) != -ENODEV)
>>   			continue;
>>   
>>   		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>>   		if (!port)
>>   			return -ENOMEM;
>>   
>> -		port->extcon = extcon;
>> +		port->extcon = IS_ERR(extcon) ? NULL : extcon;
>>   		port->phy = phy;
>>   		port->dp = dp;
>>   		port->id = i;
>> -- 
>> 2.49.0
>>

