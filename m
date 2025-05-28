Return-Path: <linux-kernel+bounces-664682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF13AC5F09
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 04:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228BF7B0FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 02:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D646199947;
	Wed, 28 May 2025 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fLu2xJSW"
Received: from mail-m1973179.qiye.163.com (mail-m1973179.qiye.163.com [220.197.31.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A86157493
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748397745; cv=none; b=MPoVO5KBDpxQElVs4uJ0GRWCyAN1R/fPuFILlK5lNgGKqQbsiqXVcshUhnTaZR7a/rEbm9YukRr5gHedF/JOZgMHz257xkQJL7olxnJAE575SZ513H2eQmsQA2AI8X8mhJruj3sd0wG8XCGbnSoiCaRtNyEurXjosP7ij3q/S74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748397745; c=relaxed/simple;
	bh=HRgAzfTIec+dmfaKZK6uEWLqRxaLMQqEBB67UFMsHxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbYLlTYw4Fu9s+Ehq3XihF/1nohiDQWZVAJy/wOE59GwpUf/h/dlecFuR1x9xThVMJm1Vh7BjTERWsTCzD0ZtA9mYOryYUYZospHh0noqLIdJEBydraFxPI2cLbCObDk3vE31xLd29jxNGAoR+IO8aDLmriAYA4Vl/xefuQILUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fLu2xJSW; arc=none smtp.client-ip=220.197.31.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [127.0.0.1] (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 16a0c918b;
	Wed, 28 May 2025 09:56:58 +0800 (GMT+08:00)
Message-ID: <bc321a71-1934-4889-bd8e-3bb593c8feba@rock-chips.com>
Date: Wed, 28 May 2025 09:56:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/rockchip: cdn-dp: Convert to drm bridge
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Chaoyi Chen <kernel@airkyi.com>
Cc: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250527081447.304-1-kernel@airkyi.com>
 <e2dnvpbze4xuubggduqr3p5nnhg7huk3dnpdcb6tldxbrn2qtn@bfsewz5trfv3>
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <e2dnvpbze4xuubggduqr3p5nnhg7huk3dnpdcb6tldxbrn2qtn@bfsewz5trfv3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh9DTlZOSB0eTB1NQ00YGkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	5VSktLVUpCS0tZBg++
X-HM-Tid: 0a97149b688003abkunm77e47d98241a65
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pjo6GQw4LTE3NksaNTgaNyMw
	ODFPCwhVSlVKTE9DSEJMT0lPSU5DVTMWGhIXVRgTGhQCElUYEx4VOwkUGBBWGBMSCwhVGBQWRVlX
	WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBQkNCTzcG
DKIM-Signature:a=rsa-sha256;
	b=fLu2xJSWp2q3mIFbhxKUfmzkkg7OGqq2VSI2np3hR6rk7UET9jBFcx/7ez3nOPi5SrHt5GHYxbVMvrqqLJVHS/Cvx1h9RTIWSsTcQLCswYLMkygSFFz0Hlod73nPcG63IIP/RfmbZwidfVCe0E9+xjjMA/xWiH0fXeMfxSJI0xo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=dXyIr6GWGoafvoq9UPbumJcJpzJMA1NBV0qBispuyFM=;
	h=date:mime-version:subject:message-id:from;

Hi Dmitry,

On 2025/5/28 4:25, Dmitry Baryshkov wrote:
> On Tue, May 27, 2025 at 04:14:47PM +0800, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> Convert it to drm bridge driver, it will be convenient for us to
>> migrate the connector part to the display driver later.
>> Considering that some code depend on the connector, the following
>> changes have been made:
>> - Only process edid in &drm_bridge_funcs.edid_read(), so no need to
>> store additional edid info.
>> - Now cdn_dp_get_sink_capability() only focused on reading DPCD_REV.
>> - Update bpc info in cdn_dp_bridge_atomic_enable() instead of
>> cdn_dp_encoder_mode_set(). Actually, the bpc data will be used in
>> cdn_dp_bridge_atomic_enable().
>> - Switch to use DRM_BRIDGE_OP_DP_AUDIO helpers.
>>
>> This patch also convert to use devm_drm_bridge_alloc() API.
>>
>> Tested with RK3399 EVB IND board.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>
>> Changes in v3:
>> - Link to V2: https://lore.kernel.org/all/20250523011310.120-1-kernel@airkyi.com/
>> - Switch to use DRM_BRIDGE_OP_DP_AUDIO helpers
>> - Remove the dependency for connector
>> - Remove the extra stored edid
>> - Code cleanup
>>
>> Changes in v2:
>> - Link to V1: https://lore.kernel.org/all/20250507035148.415-1-kernel@airkyi.com/
>> - Use drm_atomic_get_new_connector_for_encoder() to get connector
>> - Convert to use devm_drm_bridge_alloc() API
>> - Fix typo: cdn_dp_connector_edid_read -> cdn_dp_bridge_edid_read
>>
>>   drivers/gpu/drm/rockchip/cdn-dp-core.c | 279 ++++++++++---------------
>>   drivers/gpu/drm/rockchip/cdn-dp-core.h |   9 +-
>>   2 files changed, 110 insertions(+), 178 deletions(-)
>>
>
>> @@ -595,16 +546,41 @@ static bool cdn_dp_check_link_status(struct cdn_dp_device *dp)
>>   static void cdn_dp_audio_handle_plugged_change(struct cdn_dp_device *dp,
>>   					       bool plugged)
>>   {
>> -	if (dp->codec_dev)
>> -		dp->plugged_cb(dp->codec_dev, plugged);
>> +	if (dp->sink_has_audio)
>> +		drm_connector_hdmi_audio_plugged_notify(dp->connector, plugged);
> I'd say, notify always and let userspace figure it out via the ELD. Then
> you shouldn't need sink_has_audio. This would match the behaviour of
> HDMI drivers.

Oh, I find that there are similar usages in qcom msm driver. Is there 
any more progress?


>
>>   }
>>   
> [...]
>
>> @@ -705,8 +681,6 @@ static int cdn_dp_encoder_atomic_check(struct drm_encoder *encoder,
>>   
>>   static const struct drm_encoder_helper_funcs cdn_dp_encoder_helper_funcs = {
>>   	.mode_set = cdn_dp_encoder_mode_set,
>> -	.enable = cdn_dp_encoder_enable,
>> -	.disable = cdn_dp_encoder_disable,
>>   	.atomic_check = cdn_dp_encoder_atomic_check,
> Nit: for the future cleanup, it should probably be possible to get rid
> of these encoder ops too by moving them to the bridge ops.

Interesting, have these patches been submitted upstream yet?


>
>>   };
>>   
> [...]
>
>> @@ -1006,7 +947,8 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
>>   
>>   out:
>>   	mutex_unlock(&dp->lock);
>> -	drm_connector_helper_hpd_irq_event(&dp->connector);
>> +	if (dp->connector)
>> +		drm_connector_helper_hpd_irq_event(dp->connector);
> drm_bridge_hpd_notify(). I think then you don't need dp->connector.

That make sense! Will fix in v4.


>
>>   }
>>   
>>   static int cdn_dp_pd_event(struct notifier_block *nb,
>> @@ -1062,26 +1004,35 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
>>   
>>   	drm_encoder_helper_add(encoder, &cdn_dp_encoder_helper_funcs);
>>   
>> -	connector = &dp->connector;
>> -	connector->polled = DRM_CONNECTOR_POLL_HPD;
>> -	connector->dpms = DRM_MODE_DPMS_OFF;
>> -
>> -	ret = drm_connector_init(drm_dev, connector,
>> -				 &cdn_dp_atomic_connector_funcs,
>> -				 DRM_MODE_CONNECTOR_DisplayPort);
>> -	if (ret) {
>> -		DRM_ERROR("failed to initialize connector with drm\n");
>> -		goto err_free_encoder;
>> -	}
>> +	dp->bridge.ops =
>> +			DRM_BRIDGE_OP_DETECT |
>> +			DRM_BRIDGE_OP_EDID |
>> +			DRM_BRIDGE_OP_HPD |
>> +			DRM_BRIDGE_OP_DP_AUDIO;
>> +	dp->bridge.of_node = dp->dev->of_node;
>> +	dp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
>> +	dp->bridge.hdmi_audio_dev = dp->dev;
>> +	dp->bridge.hdmi_audio_max_i2s_playback_channels = 8;
>> +	dp->bridge.hdmi_audio_spdif_playback = 1;
>> +	dp->bridge.hdmi_audio_dai_port = -1;
>> +
>> +	ret = devm_drm_bridge_add(dev, &dp->bridge);
>> +	if (ret)
>> +		return ret;
>>   
>> -	drm_connector_helper_add(connector, &cdn_dp_connector_helper_funcs);
>> +	ret = drm_bridge_attach(encoder, &dp->bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>> +	if (ret)
>> +		return ret;
>>   
>> -	ret = drm_connector_attach_encoder(connector, encoder);
>> -	if (ret) {
>> -		DRM_ERROR("failed to attach connector and encoder\n");
>> -		goto err_free_connector;
>> +	connector = drm_bridge_connector_init(drm_dev, encoder);
>> +	if (IS_ERR(connector)) {
>> +		ret = PTR_ERR(connector);
>> +		dev_err(dp->dev, "failed to init bridge connector: %d\n", ret);
>> +		return ret;
>>   	}
>>   
>> +	drm_connector_attach_encoder(connector, encoder);
>> +
>>   	for (i = 0; i < dp->ports; i++) {
>>   		port = dp->port[i];
>>   
>> @@ -1101,30 +1052,19 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
>>   	schedule_work(&dp->event_work);
>>   
>>   	return 0;
>> -
>> -err_free_connector:
>> -	drm_connector_cleanup(connector);
>> -err_free_encoder:
>> -	drm_encoder_cleanup(encoder);
>> -	return ret;
>>   }
>>   
>>   static void cdn_dp_unbind(struct device *dev, struct device *master, void *data)
>>   {
>>   	struct cdn_dp_device *dp = dev_get_drvdata(dev);
>>   	struct drm_encoder *encoder = &dp->encoder.encoder;
>> -	struct drm_connector *connector = &dp->connector;
>>   
>>   	cancel_work_sync(&dp->event_work);
>> -	cdn_dp_encoder_disable(encoder);
>>   	encoder->funcs->destroy(encoder);
>> -	connector->funcs->destroy(connector);
>>   
>>   	pm_runtime_disable(dev);
>>   	if (dp->fw_loaded)
>>   		release_firmware(dp->fw);
>> -	drm_edid_free(dp->drm_edid);
>> -	dp->drm_edid = NULL;
>>   }
>>   
>>   static const struct component_ops cdn_dp_component_ops = {
>> @@ -1171,9 +1111,10 @@ static int cdn_dp_probe(struct platform_device *pdev)
>>   	int ret;
>>   	int i;
>>   
>> -	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
>> -	if (!dp)
>> -		return -ENOMEM;
>> +	dp = devm_drm_bridge_alloc(dev, struct cdn_dp_device, bridge,
>> +				   &cdn_dp_bridge_funcs);
>> +	if (IS_ERR(dp))
>> +		return PTR_ERR(dp);
>>   	dp->dev = dev;
>>   
>>   	match = of_match_node(cdn_dp_dt_ids, pdev->dev.of_node);
>> @@ -1209,19 +1150,11 @@ static int cdn_dp_probe(struct platform_device *pdev)
>>   	mutex_init(&dp->lock);
>>   	dev_set_drvdata(dev, dp);
>>   
>> -	ret = cdn_dp_audio_codec_init(dp, dev);
>> -	if (ret)
>> -		return ret;
>> -
>>   	ret = component_add(dev, &cdn_dp_component_ops);
>>   	if (ret)
>> -		goto err_audio_deinit;
>> +		return ret;
>>   
>>   	return 0;
>> -
>> -err_audio_deinit:
>> -	platform_device_unregister(dp->audio_pdev);
>> -	return ret;
>>   }
>>   
>>   static void cdn_dp_remove(struct platform_device *pdev)
>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
>> index 17498f576ce7..6aa3ce489382 100644
>> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
>> @@ -8,6 +8,8 @@
>>   #define _CDN_DP_CORE_H
>>   
>>   #include <drm/display/drm_dp_helper.h>
>> +#include <drm/drm_bridge.h>
>> +#include <drm/drm_bridge_connector.h>
> This include can go to the C file instead of the header.

Okay, will fix in v4.


>
>>   #include <drm/drm_panel.h>
>>   #include <drm/drm_probe_helper.h>
>>   #include <sound/hdmi-codec.h>
>> @@ -65,12 +67,12 @@ struct cdn_dp_port {
>>   struct cdn_dp_device {
>>   	struct device *dev;
>>   	struct drm_device *drm_dev;
>> -	struct drm_connector connector;
>> +	struct drm_bridge bridge;
>> +	struct drm_connector *connector;
>>   	struct rockchip_encoder encoder;
>>   	struct drm_display_mode mode;
>>   	struct platform_device *audio_pdev;
>>   	struct work_struct event_work;
>> -	const struct drm_edid *drm_edid;
>>   
>>   	struct mutex lock;
>>   	bool connected;
>> @@ -102,8 +104,5 @@ struct cdn_dp_device {
>>   
>>   	u8 dpcd[DP_RECEIVER_CAP_SIZE];
>>   	bool sink_has_audio;
>> -
>> -	hdmi_codec_plugged_cb plugged_cb;
>> -	struct device *codec_dev;
>>   };
>>   #endif  /* _CDN_DP_CORE_H */
>> -- 
>> 2.49.0
>>

