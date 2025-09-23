Return-Path: <linux-kernel+bounces-828178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3775B941C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8791518A5FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B9425A63D;
	Tue, 23 Sep 2025 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SlPVi1oS"
Received: from mail-m49246.qiye.163.com (mail-m49246.qiye.163.com [45.254.49.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A0261B77;
	Tue, 23 Sep 2025 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598411; cv=none; b=R0mYWkyeuMPvU9WA+HDHclDhM2m4QVceQLQ4kQbpEembwK8wdW+xMI96cvTwiKjIcvm5Nw0nLewFefv3TL3rKXFyFeqoeCw+uM/QhNWbbXxUBwuWUnGlIodnuqeVrkqzLTUFLYBW6M/VrYuqSTFIjHHDwZuvr1kC9aE8/gB2YUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598411; c=relaxed/simple;
	bh=VqUMiiM7hsXD3pV/3u1hW+94Zag/cE7MMKx8KibXWPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbV427JSeaiz91X1vJm++tocCR1wMnyoO03H4uYCRstfCAE4hZ2cb2PpveLko6XsC3PzI6fuASrW2MWZlCnIzQzTtWJZEMJSEwX6V8GvqvyxswGHxyNZMUFcukaEgy+T7A7LL+GLYEvX8BEhTC4IrC7/ayWrBeWNDcvXqiWqqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SlPVi1oS; arc=none smtp.client-ip=45.254.49.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 23b8da0fb;
	Tue, 23 Sep 2025 11:33:21 +0800 (GMT+08:00)
Message-ID: <ccaa0f30-6b18-4d44-bda5-e90e1b087ecc@rock-chips.com>
Date: Tue, 23 Sep 2025 11:33:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] drm/rockchip: cdn-dp: Add multiple bridges to
 support PHY port selection
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Chaoyi Chen <kernel@airkyi.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20250922012039.323-1-kernel@airkyi.com>
 <20250922012039.323-6-kernel@airkyi.com>
 <idyrlzhd5sotg3ylr7vbwmczimglffc75nafxbnhhm3ot2jn4w@ixerm6elfmre>
 <e10484e2-fafb-4e50-866f-f409c12259a5@rock-chips.com>
 <3n6gvt2lcf24smt6njiqoqt5h4733z36hwvc2zfyft62d25uu5@vwl26mmsfzbz>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <3n6gvt2lcf24smt6njiqoqt5h4733z36hwvc2zfyft62d25uu5@vwl26mmsfzbz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9974a20c3803abkunmdfc552bfe7f27
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5JT1ZPGh5ISxgYTkoeH0hWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SlPVi1oSXf0cIDR90Gbl+WHVoEiSBgo/rezRMw1ZUjKfpSHz1UnY+sIXOOZrJPeGg4fHewcX/QApxVfWX35I0knqL4JTlhgJbWI3kVYHwzv+KXNfumqhePewOGGBuAq4ZTr4jrTvcKoPs/6xS+A5nqnloqTsSH6n8gM3BROQ29w=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=6j251N+TTWj2dwg/qF59bibn6Pq6K+CmCvwfdrpKx7o=;
	h=date:mime-version:subject:message-id:from;

On 9/23/2025 11:22 AM, Dmitry Baryshkov wrote:

> On Tue, Sep 23, 2025 at 10:09:38AM +0800, Chaoyi Chen wrote:
>> On 9/23/2025 9:50 AM, Dmitry Baryshkov wrote:
>>
>>> On Mon, Sep 22, 2025 at 09:20:37AM +0800, Chaoyi Chen wrote:
>>>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>>
>>>> The RK3399 has two USB/DP combo PHY and one CDN-DP controller. And
>>>> the CDN-DP can be switched to output to one of the PHYs. If both ports
>>>> are plugged into DP, DP will select the first port for output.
>>>>
>>>> This patch adds support for multiple bridges, enabling users to flexibly
>>>> select the output port. For each PHY port, a separate encoder and bridge
>>>> are registered.
>>>>
>>>> The change is based on the DRM AUX HPD bridge, rather than the
>>>> extcon approach. This requires the DT to correctly describe the
>>>> connections between the PHY, USB connector, and DP controller.
>>>> And cdn_dp_parse_hpd_bridge_dt() will parses it and determines
>>>> whether to register one or two bridges.
>>>>
>>>> Since there is only one DP controller, only one of the PHY ports can
>>>> output at a time. The key is how to switch between different PHYs,
>>>> which is handled by cdn_dp_switch_port() and cdn_dp_enable().
>>>>
>>>> There are two cases:
>>>>
>>>> 1. Neither bridge is enabled. In this case, both bridges can
>>>> independently read the EDID, and the PHY port may switch before
>>>> reading the EDID.
>>>>
>>>> 2. One bridge is already enabled. In this case, other bridges are not
>>>> allowed to read the EDID.
>>>>
>>>> Since the scenario of two ports plug in at the same time is rare,
>>>> I don't have a board which support two TypeC connector to test this.
>>>> Therefore, I tested forced switching on a single PHY port, as well as
>>>> output using a fake PHY port alongside a real PHY port.
>>>>
>>>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>> ---
>>>>    drivers/gpu/drm/rockchip/Kconfig       |   1 +
>>>>    drivers/gpu/drm/rockchip/cdn-dp-core.c | 398 +++++++++++++++++++++----
>>>>    drivers/gpu/drm/rockchip/cdn-dp-core.h |  23 +-
>>>>    3 files changed, 366 insertions(+), 56 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
>>>> index faf50d872be3..3a6266279323 100644
>>>> --- a/drivers/gpu/drm/rockchip/Kconfig
>>>> +++ b/drivers/gpu/drm/rockchip/Kconfig
>>>> @@ -55,6 +55,7 @@ config ROCKCHIP_CDN_DP
>>>>    	select DRM_DISPLAY_HELPER
>>>>    	select DRM_BRIDGE_CONNECTOR
>>>>    	select DRM_DISPLAY_DP_HELPER
>>>> +	select DRM_AUX_HPD_BRIDGE
>>>>    	help
>>>>    	  This selects support for Rockchip SoC specific extensions
>>>>    	  for the cdn DP driver. If you want to enable Dp on
>>>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>>>> index 1e27301584a4..784f5656fcc4 100644
>>>> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
>>>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>>>> @@ -27,16 +27,17 @@
>>>>    #include "cdn-dp-core.h"
>>>>    #include "cdn-dp-reg.h"
>>>> -static inline struct cdn_dp_device *bridge_to_dp(struct drm_bridge *bridge)
>>>> +static int cdn_dp_switch_port(struct cdn_dp_device *dp, struct cdn_dp_port *prev_port,
>>>> +			      struct cdn_dp_port *port);
>>>> +
>>>> +static inline struct cdn_dp_bridge *bridge_to_dp_bridge(struct drm_bridge *bridge)
>>>>    {
>>>> -	return container_of(bridge, struct cdn_dp_device, bridge);
>>>> +	return container_of(bridge, struct cdn_dp_bridge, bridge);
>>>>    }
>>>> -static inline struct cdn_dp_device *encoder_to_dp(struct drm_encoder *encoder)
>>>> +static inline struct cdn_dp_device *bridge_to_dp(struct drm_bridge *bridge)
>>>>    {
>>>> -	struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
>>>> -
>>>> -	return container_of(rkencoder, struct cdn_dp_device, encoder);
>>>> +	return bridge_to_dp_bridge(bridge)->parent;
>>>>    }
>>>>    #define GRF_SOC_CON9		0x6224
>>>> @@ -191,14 +192,27 @@ static int cdn_dp_get_sink_count(struct cdn_dp_device *dp, u8 *sink_count)
>>>>    static struct cdn_dp_port *cdn_dp_connected_port(struct cdn_dp_device *dp)
>>>>    {
>>>>    	struct cdn_dp_port *port;
>>>> -	int i, lanes;
>>>> +	int i, lanes[MAX_PHY];
>>>>    	for (i = 0; i < dp->ports; i++) {
>>>>    		port = dp->port[i];
>>>> -		lanes = cdn_dp_get_port_lanes(port);
>>>> -		if (lanes)
>>>> +		lanes[i] = cdn_dp_get_port_lanes(port);
>>>> +		if (!dp->hpd_bridge_valid)
>>>>    			return port;
>>>>    	}
>>>> +
>>>> +	if (dp->hpd_bridge_valid) {
>>>> +		/* If more than one port is available, pick the last active port */
>>>> +		if (dp->active_port > 0 && lanes[dp->active_port])
>>>> +			return dp->port[dp->active_port];
>>>> +
>>>> +		/* If the last active port is not available, pick an available port in order */
>>>> +		for (i = 0; i < dp->bridge_count; i++) {
>>>> +			if (lanes[i])
>>>> +				return dp->port[i];
>>>> +		}
>>>> +	}
>>>> +
>>>>    	return NULL;
>>>>    }
>>>> @@ -239,10 +253,11 @@ static enum drm_connector_status
>>>>    cdn_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
>>>>    {
>>>>    	struct cdn_dp_device *dp = bridge_to_dp(bridge);
>>>> +	struct cdn_dp_bridge *dp_bridge = bridge_to_dp_bridge(bridge);
>>>>    	enum drm_connector_status status = connector_status_disconnected;
>>>>    	mutex_lock(&dp->lock);
>>>> -	if (dp->connected)
>>>> +	if (dp_bridge->connected && dp->connected)
>>>>    		status = connector_status_connected;
>>>>    	mutex_unlock(&dp->lock);
>>>> @@ -253,10 +268,36 @@ static const struct drm_edid *
>>>>    cdn_dp_bridge_edid_read(struct drm_bridge *bridge, struct drm_connector *connector)
>>>>    {
>>>>    	struct cdn_dp_device *dp = bridge_to_dp(bridge);
>>>> -	const struct drm_edid *drm_edid;
>>>> +	struct cdn_dp_bridge *dp_bridge = bridge_to_dp_bridge(bridge);
>>>> +	struct cdn_dp_port *port = dp->port[dp_bridge->id];
>>>> +	struct cdn_dp_port *prev_port;
>>>> +	const struct drm_edid *drm_edid = NULL;
>>>> +	int i, ret;
>>>>    	mutex_lock(&dp->lock);
>>>> +
>>>> +	/* More than one port is available */
>>>> +	if (dp->bridge_count > 1 && !port->phy_enabled) {
>>>> +		for (i = 0; i < dp->bridge_count; i++) {
>>>> +			/* Another port already enable */
>>>> +			if (dp->bridge_list[i] != dp_bridge && dp->bridge_list[i]->enabled)
>>>> +				goto unlock;
>>>> +			/* Find already enabled port */
>>>> +			if (dp->port[i]->phy_enabled)
>>>> +				prev_port = dp->port[i];
>>>> +		}
>>>> +
>>>> +		/* Switch to current port */
>>>> +		if (prev_port) {
>>>> +			ret = cdn_dp_switch_port(dp, prev_port, port);
>>>> +			if (ret)
>>>> +				goto unlock;
>>>> +		}
>>>> +	}
>>>> +
>>>>    	drm_edid = drm_edid_read_custom(connector, cdn_dp_get_edid_block, dp);
>>> So... If I try reading EDID for the PHY 2 while PHY 1 is enabled, will
>>> it return NULL, even if there is a monitor there? It totally feels like
>>> this is one of the rare cases when caching EDIDs might make sense.
>> Of course. I did consider using cache, but if the monitor changes, then caching the EDID doesn't seem to be of much use…
> Yes... It might still be better to invalidate the cache on the plug
> event rather than always reporting empty EDID when another monitor is
> enabled.

Hmm, I will add cache in v5.


>
-- 
Best,
Chaoyi


