Return-Path: <linux-kernel+bounces-828087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AB8B93E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB792E0774
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0818225A334;
	Tue, 23 Sep 2025 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HbT+EyYZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE062CCC0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592269; cv=none; b=QnXqEMqvW6EIMExgR+byNFFHggMUriAfdW6+HGjyKZads/u4SUWRjCJXFfapg4j+7XsVaSMR/OY9ONC3FfSQZ5ORj/f6mBt4hwIEVirhFoXaElMn6RNN5vLkP45CSeQDBj1H9Y6U/AIwWpsCzs8hg2W1aA7jhxqHltdtfPrDnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592269; c=relaxed/simple;
	bh=1UA/JMW/6ws9D0KKAt1X+3qRFo1WfZp44Srm7f6QszM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoGVlmmbbYoSrB/zs2cULgn2KWtRjLyewGZTW03eiv285592Zo0Banb/c+Zb+pejDIfEREhmmhEJK1ny+wEF7jqdhNMVrw559GLUfn51ILx6Bjvon/uAKCYE7sK2t+pTci0TrVT1qPGBGmabniVCWPBPfoNg+jJdmqvUiK5FKcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HbT+EyYZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MH68sn027923
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=blGX09WoQhb3bpD9uXLe6knE
	f02Pncslxk30iBw4+Ic=; b=HbT+EyYZtZpYCLO1dxixXsRhadg6B8kUP9JAfwtz
	oBkxhHBK/jMJCbhd8ZgsWfL/stIfx7zh60yFlTJpRm0EzBGTikXd6O2Nsg+Ouful
	wEH2XRn03SoHwMRzN/UqVB9eaGt4M9gGsaXxXswXV5qo5SC8cDyTI0ftgoLvXagk
	xeFbO4y6cYKmmaYwCa2UnEdDMWTTe0ZU8VB5rISw6ipIWWUrxYn1WueHDL4F+sYB
	pgUWYRnRnPETzBF5ogadm2Q9j+CPQ8ZYuiH20087xTGgeSMyr4MNFsIhkEch4z3d
	J+baI6igSxlGc1ckih1IXd1pts6taMA6MDlQEgOFBVsupA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajes709-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:51:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b31bea5896so50394131cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758592265; x=1759197065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blGX09WoQhb3bpD9uXLe6knEf02Pncslxk30iBw4+Ic=;
        b=HMraDYZSISLu/oQpiVwgFBOv9o6YMH6Nr2oG9IrYxh6tPZQDKx0dhi7Hae33qX7IzW
         UX1mV7rm5pY7Orj8S2B5f0J/pKHgnm0cDZkn73h4Td6/tiAzo1tN+8LjmTssBE8UCmYo
         A4saKzJtemt/rriuj5JOK00a5jnOGM2Wxi+XnVETTxQ5lUdJ6jLJWQVDRo5Bps1HFMZ6
         5INCYiO1Z1+XpcJyyPDIXAcajJ5dKjnX//cwSLGhuJjZVtnyQcgg5IBK5SlHdoUX5Ovz
         4nQarEO2VV0dFHVdMikMvWsa8i7K8s/Fgw9YQaPh75toQA9ULQrFUWl5GLF8PzctvAz3
         Xs0g==
X-Forwarded-Encrypted: i=1; AJvYcCUbKTKhf8NL37QyZ4k1Kz+CK46Zsf1/oUn9FtZJDKDMoBrbqc6CjvNH5gx37+7uxxH4TB9BHTOFpgUn+4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbtscfEbsNefl4ov96bC4ljD8WNz3PCF/W/V2v1sB41OPWlqvn
	iAlATUg66KQcvP4/FZU6wVqTPCTce8s6QyGtfMk5g8FeXqf4OvoneAbuNGdrboMtElKzdYGoOGa
	gwksxjqlhXCzX6WRq0EpFjzClxrxLTRCm3PDpx0Mz6A8p4Vr2xyu+qXZrOMDMZ4TEtIY=
X-Gm-Gg: ASbGnct36E1P1N6EJyM/qw7RLiyNk7MjznJgZE1pFr4Sp+WMtvt3Rjxvrhl3FTm672o
	3SeutC6Y6Qulj8LRu0GNV08W3KNDXciF/b68V9y8dZBfq4HqJWq0zBxST3Rl//5+ygEE/wA/Dm5
	wo+9/HrTArnrRpIHdk9js2+Y0KsZinZzkjPPIi6/rnAHNIomHsYn9TcQy40Vyz40uBqfQ9+cHPn
	8HbRjh+H0/fXXwW26WcOtdh5gVbMkRqNN7uWgELo89gg19Xm182eLJxe0Vnr1WGff2ZVwpNb3P7
	K9H1EkjcDadlMKiBTJ+cgxM9mWVI9E70bmtrVX5iT4B9LlbqgJf6sbOixe5BFfiaoveyk9XWkXR
	Mye6MhBW8XBS7FMWr1pX24BtrCWLT9x7g4PhW+jYkOEkZJGrEb45K
X-Received: by 2002:a05:622a:1f96:b0:4ce:ae67:40f8 with SMTP id d75a77b69052e-4d3666ca61emr11081351cf.10.1758592264466;
        Mon, 22 Sep 2025 18:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiCQyIsieZF93srBLlgPSQWIGi07RyXUwKp7d3cbULl7hBa0u9Hen853Ri882BPPxhp5+37g==
X-Received: by 2002:a05:622a:1f96:b0:4ce:ae67:40f8 with SMTP id d75a77b69052e-4d3666ca61emr11081131cf.10.1758592263632;
        Mon, 22 Sep 2025 18:51:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57b72016aecsm2149035e87.33.2025.09.22.18.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 18:51:01 -0700 (PDT)
Date: Tue, 23 Sep 2025 04:50:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Yubing Zhang <yubing.zhang@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Amit Sunil Dhamne <amitsd@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaoyi Chen <chaoyi.chen@rock-chips.com>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 5/7] drm/rockchip: cdn-dp: Add multiple bridges to
 support PHY port selection
Message-ID: <idyrlzhd5sotg3ylr7vbwmczimglffc75nafxbnhhm3ot2jn4w@ixerm6elfmre>
References: <20250922012039.323-1-kernel@airkyi.com>
 <20250922012039.323-6-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922012039.323-6-kernel@airkyi.com>
X-Proofpoint-GUID: R1i2jd5Zqr2amv2adujyqVOtVRZDc1Rx
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d1fd0a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=mj751xbbuVm9A0Iq0NgA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX+oZvIh1byP53
 pgy55I7/5fEjW6hYAY0tS2U1ICXHmnDpyfV2ssRwuwy5KBnLeR7e2RYnCDYFQv417Tl7nxyzfUI
 P7N9e3V0oRSN1QmLy1BPqKN/nnrK7kYYVgnbiktuo2n+v8z+nX5vvGKyz1lLR8yWeRlODGfdyQK
 37Cqt8ADILe9lLy79Qoge0tfTG9+uz0Ig7mY79c9E7Nyhvv3AI+ERTzoRBQCqPbdePUIJaomzTa
 yo8aSDwqYKyh4MJbeb17QLHmQ3tlTtkJF6v1K06sNTH5bAWbLSrZqQRQxUp3f34mV3fxkSeX26b
 3AlK8rxPjlUjg8eFEEYdrR5QfMI9v3Mf15LXytWfKxnx5lje8ATt/JXJu3X/OxhLpdCfzHK1CP5
 SAo9Ji+R
X-Proofpoint-ORIG-GUID: R1i2jd5Zqr2amv2adujyqVOtVRZDc1Rx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On Mon, Sep 22, 2025 at 09:20:37AM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The RK3399 has two USB/DP combo PHY and one CDN-DP controller. And
> the CDN-DP can be switched to output to one of the PHYs. If both ports
> are plugged into DP, DP will select the first port for output.
> 
> This patch adds support for multiple bridges, enabling users to flexibly
> select the output port. For each PHY port, a separate encoder and bridge
> are registered.
> 
> The change is based on the DRM AUX HPD bridge, rather than the
> extcon approach. This requires the DT to correctly describe the
> connections between the PHY, USB connector, and DP controller.
> And cdn_dp_parse_hpd_bridge_dt() will parses it and determines
> whether to register one or two bridges.
> 
> Since there is only one DP controller, only one of the PHY ports can
> output at a time. The key is how to switch between different PHYs,
> which is handled by cdn_dp_switch_port() and cdn_dp_enable().
> 
> There are two cases:
> 
> 1. Neither bridge is enabled. In this case, both bridges can
> independently read the EDID, and the PHY port may switch before
> reading the EDID.
> 
> 2. One bridge is already enabled. In this case, other bridges are not
> allowed to read the EDID.
> 
> Since the scenario of two ports plug in at the same time is rare,
> I don't have a board which support two TypeC connector to test this.
> Therefore, I tested forced switching on a single PHY port, as well as
> output using a fake PHY port alongside a real PHY port.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/Kconfig       |   1 +
>  drivers/gpu/drm/rockchip/cdn-dp-core.c | 398 +++++++++++++++++++++----
>  drivers/gpu/drm/rockchip/cdn-dp-core.h |  23 +-
>  3 files changed, 366 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index faf50d872be3..3a6266279323 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -55,6 +55,7 @@ config ROCKCHIP_CDN_DP
>  	select DRM_DISPLAY_HELPER
>  	select DRM_BRIDGE_CONNECTOR
>  	select DRM_DISPLAY_DP_HELPER
> +	select DRM_AUX_HPD_BRIDGE
>  	help
>  	  This selects support for Rockchip SoC specific extensions
>  	  for the cdn DP driver. If you want to enable Dp on
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index 1e27301584a4..784f5656fcc4 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -27,16 +27,17 @@
>  #include "cdn-dp-core.h"
>  #include "cdn-dp-reg.h"
>  
> -static inline struct cdn_dp_device *bridge_to_dp(struct drm_bridge *bridge)
> +static int cdn_dp_switch_port(struct cdn_dp_device *dp, struct cdn_dp_port *prev_port,
> +			      struct cdn_dp_port *port);
> +
> +static inline struct cdn_dp_bridge *bridge_to_dp_bridge(struct drm_bridge *bridge)
>  {
> -	return container_of(bridge, struct cdn_dp_device, bridge);
> +	return container_of(bridge, struct cdn_dp_bridge, bridge);
>  }
>  
> -static inline struct cdn_dp_device *encoder_to_dp(struct drm_encoder *encoder)
> +static inline struct cdn_dp_device *bridge_to_dp(struct drm_bridge *bridge)
>  {
> -	struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
> -
> -	return container_of(rkencoder, struct cdn_dp_device, encoder);
> +	return bridge_to_dp_bridge(bridge)->parent;
>  }
>  
>  #define GRF_SOC_CON9		0x6224
> @@ -191,14 +192,27 @@ static int cdn_dp_get_sink_count(struct cdn_dp_device *dp, u8 *sink_count)
>  static struct cdn_dp_port *cdn_dp_connected_port(struct cdn_dp_device *dp)
>  {
>  	struct cdn_dp_port *port;
> -	int i, lanes;
> +	int i, lanes[MAX_PHY];
>  
>  	for (i = 0; i < dp->ports; i++) {
>  		port = dp->port[i];
> -		lanes = cdn_dp_get_port_lanes(port);
> -		if (lanes)
> +		lanes[i] = cdn_dp_get_port_lanes(port);
> +		if (!dp->hpd_bridge_valid)
>  			return port;
>  	}
> +
> +	if (dp->hpd_bridge_valid) {
> +		/* If more than one port is available, pick the last active port */
> +		if (dp->active_port > 0 && lanes[dp->active_port])
> +			return dp->port[dp->active_port];
> +
> +		/* If the last active port is not available, pick an available port in order */
> +		for (i = 0; i < dp->bridge_count; i++) {
> +			if (lanes[i])
> +				return dp->port[i];
> +		}
> +	}
> +
>  	return NULL;
>  }
>  
> @@ -239,10 +253,11 @@ static enum drm_connector_status
>  cdn_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
>  {
>  	struct cdn_dp_device *dp = bridge_to_dp(bridge);
> +	struct cdn_dp_bridge *dp_bridge = bridge_to_dp_bridge(bridge);
>  	enum drm_connector_status status = connector_status_disconnected;
>  
>  	mutex_lock(&dp->lock);
> -	if (dp->connected)
> +	if (dp_bridge->connected && dp->connected)
>  		status = connector_status_connected;
>  	mutex_unlock(&dp->lock);
>  
> @@ -253,10 +268,36 @@ static const struct drm_edid *
>  cdn_dp_bridge_edid_read(struct drm_bridge *bridge, struct drm_connector *connector)
>  {
>  	struct cdn_dp_device *dp = bridge_to_dp(bridge);
> -	const struct drm_edid *drm_edid;
> +	struct cdn_dp_bridge *dp_bridge = bridge_to_dp_bridge(bridge);
> +	struct cdn_dp_port *port = dp->port[dp_bridge->id];
> +	struct cdn_dp_port *prev_port;
> +	const struct drm_edid *drm_edid = NULL;
> +	int i, ret;
>  
>  	mutex_lock(&dp->lock);
> +
> +	/* More than one port is available */
> +	if (dp->bridge_count > 1 && !port->phy_enabled) {
> +		for (i = 0; i < dp->bridge_count; i++) {
> +			/* Another port already enable */
> +			if (dp->bridge_list[i] != dp_bridge && dp->bridge_list[i]->enabled)
> +				goto unlock;
> +			/* Find already enabled port */
> +			if (dp->port[i]->phy_enabled)
> +				prev_port = dp->port[i];
> +		}
> +
> +		/* Switch to current port */
> +		if (prev_port) {
> +			ret = cdn_dp_switch_port(dp, prev_port, port);
> +			if (ret)
> +				goto unlock;
> +		}
> +	}
> +
>  	drm_edid = drm_edid_read_custom(connector, cdn_dp_get_edid_block, dp);

So... If I try reading EDID for the PHY 2 while PHY 1 is enabled, will
it return NULL, even if there is a monitor there? It totally feels like
this is one of the rare cases when caching EDIDs might make sense.

> +
> +unlock:
>  	mutex_unlock(&dp->lock);
>  
>  	return drm_edid;
> @@ -267,12 +308,13 @@ cdn_dp_bridge_mode_valid(struct drm_bridge *bridge,
>  			 const struct drm_display_info *display_info,
>  			 const struct drm_display_mode *mode)
>  {
> +	struct cdn_dp_bridge *dp_bridge = bridge_to_dp_bridge(bridge);
>  	struct cdn_dp_device *dp = bridge_to_dp(bridge);
>  	u32 requested, actual, rate, sink_max, source_max = 0;
>  	u8 lanes, bpc;
>  
>  	/* If DP is disconnected, every mode is invalid */
> -	if (!dp->connected)
> +	if (!dp_bridge->connected || !dp->connected)
>  		return MODE_BAD;
>  
>  	switch (display_info->bpc) {
> @@ -571,6 +613,7 @@ static void cdn_dp_display_info_update(struct cdn_dp_device *dp,
>  static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struct drm_atomic_state *state)
>  {
>  	struct cdn_dp_device *dp = bridge_to_dp(bridge);
> +	struct cdn_dp_bridge *dp_bridge = bridge_to_dp_bridge(bridge);
>  	struct drm_connector *connector;
>  	int ret, val;
>  
> @@ -580,7 +623,7 @@ static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struct drm_at
>  
>  	cdn_dp_display_info_update(dp, &connector->display_info);
>  
> -	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, &dp->encoder.encoder);
> +	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, &dp_bridge->encoder.encoder);
>  	if (ret < 0) {
>  		DRM_DEV_ERROR(dp->dev, "Could not get vop id, %d", ret);
>  		return;
> @@ -599,6 +642,9 @@ static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struct drm_at
>  
>  	mutex_lock(&dp->lock);
>  
> +	if (dp->hpd_bridge_valid)
> +		dp->active_port = dp_bridge->id;
> +

Don't you need to switch port here? Consider reading EDID from port 1,
port 2 then enabling output on port 1.

>  	ret = cdn_dp_enable(dp);
>  	if (ret) {
>  		DRM_DEV_ERROR(dp->dev, "Failed to enable bridge %d\n",
> @@ -631,6 +677,7 @@ static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struct drm_at
>  		goto out;
>  	}
>  
> +	dp_bridge->enabled = true;
>  out:
>  	mutex_unlock(&dp->lock);
>  }
> @@ -638,9 +685,11 @@ static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struct drm_at
>  static void cdn_dp_bridge_atomic_disable(struct drm_bridge *bridge, struct drm_atomic_state *state)
>  {
>  	struct cdn_dp_device *dp = bridge_to_dp(bridge);
> +	struct cdn_dp_bridge *dp_bridge = bridge_to_dp_bridge(bridge);
>  	int ret;
>  
>  	mutex_lock(&dp->lock);
> +	dp_bridge->enabled = false;
>  
>  	if (dp->active) {
>  		ret = cdn_dp_disable(dp);
> @@ -885,7 +934,8 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
>  {
>  	struct cdn_dp_device *dp = container_of(work, struct cdn_dp_device,
>  						event_work);
> -	int ret;
> +	bool connected;
> +	int i, ret;
>  
>  	mutex_lock(&dp->lock);
>  
> @@ -944,9 +994,12 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
>  
>  out:
>  	mutex_unlock(&dp->lock);
> -	drm_bridge_hpd_notify(&dp->bridge,
> -			      dp->connected ? connector_status_connected
> -					    : connector_status_disconnected);
> +	for (i = 0; i < dp->bridge_count; i++) {
> +		connected = dp->connected && dp->bridge_list[i]->connected;
> +		drm_bridge_hpd_notify(&dp->bridge_list[i]->bridge,
> +				      connected ? connector_status_connected
> +						: connector_status_disconnected);
> +	}
>  }
>  
>  static int cdn_dp_pd_event(struct notifier_block *nb,
> @@ -966,28 +1019,99 @@ static int cdn_dp_pd_event(struct notifier_block *nb,
>  	return NOTIFY_DONE;
>  }
>  
> -static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
> +static void cdn_dp_typec_hpd_cb(void *data, enum drm_connector_status status)
>  {
> -	struct cdn_dp_device *dp = dev_get_drvdata(dev);
> -	struct drm_encoder *encoder;
> -	struct drm_connector *connector;
> -	struct cdn_dp_port *port;
> -	struct drm_device *drm_dev = data;
> -	int ret, i;
> +	struct cdn_dp_hpd_bridge *hpd_bridge = data;
> +	struct cdn_dp_device *dp = hpd_bridge->parent;
>  
> -	ret = cdn_dp_parse_dt(dp);
> -	if (ret < 0)
> -		return ret;
> +	dp->bridge_list[hpd_bridge->id]->connected = status == connector_status_connected;
> +	schedule_work(&dp->event_work);
> +}
>  
> -	dp->drm_dev = drm_dev;
> -	dp->connected = false;
> -	dp->active = false;
> -	dp->active_port = -1;
> -	dp->fw_loaded = false;
> +static void cdn_dp_bridge_hpd_enable(struct cdn_dp_device *dp)
> +{
> +	int i;
>  
> -	INIT_WORK(&dp->event_work, cdn_dp_pd_event_work);
> +	if (!dp->hpd_bridge_valid)
> +		return;
> +
> +	for (i = 0; i < dp->bridge_count; i++) {
> +		drm_bridge_hpd_enable(dp->hpd_bridge_list[i].bridge, cdn_dp_typec_hpd_cb,
> +				      &dp->hpd_bridge_list[i]);
> +	}
> +}
> +
> +static void cdn_dp_bridge_hpd_disable(struct cdn_dp_device *dp)
> +{
> +	int i;
> +
> +	if (!dp->hpd_bridge_valid)
> +		return;
> +
> +	for (i = 0; i < dp->bridge_count; i++) {
> +		drm_bridge_hpd_disable(dp->hpd_bridge_list[i].bridge);
> +	}
> +}
> +
> +static int cdn_dp_switch_port(struct cdn_dp_device *dp, struct cdn_dp_port *prev_port,
> +			      struct cdn_dp_port *port)
> +{
> +	int ret;
> +
> +	if (dp->active)
> +		return 0;
> +
> +	cdn_dp_bridge_hpd_disable(dp);
> +
> +	ret = cdn_dp_disable_phy(dp, prev_port);
> +	if (ret)
> +		goto out;
> +	ret = cdn_dp_enable_phy(dp, port);
> +	if (ret)
> +		goto out;
> +
> +	ret = cdn_dp_get_sink_capability(dp);
> +	if (ret) {
> +		cdn_dp_disable_phy(dp, port);
> +		goto out;
> +	}
> +
> +	dp->active = true;
> +	dp->lanes = port->lanes;
> +
> +	if (!cdn_dp_check_link_status(dp)) {
> +		dev_info(dp->dev, "Connected with sink; re-train link\n");
> +
> +		ret = cdn_dp_train_link(dp);
> +		if (ret) {
> +			dev_err(dp->dev, "Training link failed: %d\n", ret);
> +			goto out;
> +		}
> +
> +		ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_IDLE);
> +		if (ret) {
> +			dev_err(dp->dev, "Failed to idle video %d\n", ret);
> +			goto out;
> +		}
> +
> +		ret = cdn_dp_config_video(dp);
> +		if (ret)
> +			dev_err(dp->dev, "Failed to configure video: %d\n", ret);
> +	}
>  
> -	encoder = &dp->encoder.encoder;
> +out:
> +	cdn_dp_bridge_hpd_enable(dp);
> +	return ret;
> +}
> +
> +static int cdn_bridge_add(struct device *dev,
> +			  struct drm_bridge *bridge,
> +			  struct drm_encoder *encoder)
> +{
> +	struct cdn_dp_device *dp = dev_get_drvdata(dev);
> +	struct drm_device *drm_dev = dp->drm_dev;
> +	struct drm_connector *connector;
> +	int ret;
>  
>  	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
>  							     dev->of_node);
> @@ -1002,23 +1126,23 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
>  
>  	drm_encoder_helper_add(encoder, &cdn_dp_encoder_helper_funcs);
>  
> -	dp->bridge.ops =
> -			DRM_BRIDGE_OP_DETECT |
> -			DRM_BRIDGE_OP_EDID |
> -			DRM_BRIDGE_OP_HPD |
> -			DRM_BRIDGE_OP_DP_AUDIO;
> -	dp->bridge.of_node = dp->dev->of_node;
> -	dp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
> -	dp->bridge.hdmi_audio_dev = dp->dev;
> -	dp->bridge.hdmi_audio_max_i2s_playback_channels = 8;
> -	dp->bridge.hdmi_audio_spdif_playback = 1;
> -	dp->bridge.hdmi_audio_dai_port = -1;
> -
> -	ret = devm_drm_bridge_add(dev, &dp->bridge);
> +	bridge->ops =
> +		DRM_BRIDGE_OP_DETECT |
> +		DRM_BRIDGE_OP_EDID |
> +		DRM_BRIDGE_OP_HPD |
> +		DRM_BRIDGE_OP_DP_AUDIO;
> +	bridge->of_node = dp->dev->of_node;
> +	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
> +	bridge->hdmi_audio_dev = dp->dev;
> +	bridge->hdmi_audio_max_i2s_playback_channels = 8;
> +	bridge->hdmi_audio_spdif_playback = 1;
> +	bridge->hdmi_audio_dai_port = -1;
> +
> +	ret = devm_drm_bridge_add(dev, bridge);
>  	if (ret)
>  		return ret;
>  
> -	ret = drm_bridge_attach(encoder, &dp->bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> +	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>  	if (ret)
>  		return ret;
>  
> @@ -1031,6 +1155,167 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
>  
>  	drm_connector_attach_encoder(connector, encoder);
>  
> +	return 0;
> +}
> +
> +static int cdn_dp_parse_hpd_bridge_dt(struct cdn_dp_device *dp)
> +{
> +	struct device_node *np = dp->dev->of_node;
> +	struct device_node *port __free(device_node) = of_graph_get_port_by_id(np, 1);
> +	struct drm_bridge *bridge;
> +	int count = 0;
> +	int ret = 0;
> +	int i;
> +
> +	/* If device use extcon, do not use hpd bridge */
> +	for (i = 0; i < dp->ports; i++) {
> +		if (dp->port[i]->extcon) {
> +			dp->bridge_count = 1;
> +			return 0;
> +		}
> +	}
> +
> +	/*
> +	 *
> +	 * &dp_out {
> +	 *	dp_controller_output0: endpoint@0 {
> +	 * 		remote-endpoint = <&dp_phy0_in>
> +	 * 	};
> +	 *
> +	 * 	dp_controller_output1: endpoint@1 {
> +	 * 		remote-endpoint = <&dp_phy1_in>
> +	 * 	};
> +	 * };
> +	 *
> +	 * &tcphy0_dp {
> +	 * 	port {
> +	 * 		tcphy0_typec_dp: endpoint@0 {
> +	 * 			reg = <0>;
> +	 * 			remote-endpoint = <&usbc0_dp>;
> +	 * 		};
> +	 *
> +	 * 		dp_phy0_in: endpoint@1 {
> +	 * 			reg = <1>;
> +	 * 			remote-endpoint = <&dp_controller_output0>;
> +	 * 		};
> +	 * 	};
> +	 * };
> +	 *
> +	 * &tcphy1_dp {
> +	 * 	...
> +	 * };
> +	 *
> +	 * usbcon0: connector {
> +	 * 	...
> +	 * 	ports {
> +	 * 		...
> +	 * 		port@2 {
> +	 * 			reg = <2>;
> +	 *
> +	 * 			usbc0_dp: endpoint {
> +	 * 				remote-endpoint = <&tcphy0_typec_dp>;
> +	 * 			};
> +	 * 		};
> +	 * 	};
> +	 * };
> +	 *
> +	 * usbcon1: connector {
> +	 * 	...
> +	 * };
> +	 *
> +	 */
> +
> +	/* One endpoint may correspond to one HPD bridge. */
> +	for_each_of_graph_port_endpoint(port, dp_ep) {
> +		/* Try to get "port" node of correspond PHY device */
> +		struct device_node *phy_ep __free(device_node) =
> +			of_graph_get_remote_endpoint(dp_ep);
> +		struct device_node *phy_port __free(device_node) =
> +			of_get_parent(phy_ep);
> +
> +		if (!phy_port) {
> +			continue;
> +		}
> +
> +		/*
> +		 * A PHY port may contain two endpoints: USB connector port or CDN-DP port.
> +		 * Try to find the node of USB connector.

And then there can be a retimer between PHY and the USB-C connector. Or
some signal MUX. Or DP-to-HDMI bridge. Please, don't parse DT for other
devices. Instead you can add drm_aux_bridge to your PHY and let DRM core
build the bridge chain following OF graph.

> +		 */
> +		for_each_of_graph_port_endpoint(phy_port, typec_ep) {
> +			struct device_node *connector_port __free(device_node) =
> +				of_graph_get_remote_port_parent(typec_ep);
> +			struct device_node *hpd_bridge_np __free(device_node) =
> +				of_get_parent(connector_port);
> +
> +			if (typec_ep == phy_ep)
> +				continue;
> +
> +			bridge = of_drm_find_bridge(hpd_bridge_np);
> +			if (!bridge) {
> +				ret = -EPROBE_DEFER;
> +				goto out;
> +			}
> +
> +			dp->hpd_bridge_valid = true;
> +			dp->hpd_bridge_list[count].bridge = bridge;
> +			dp->hpd_bridge_list[count].parent = dp;
> +			dp->hpd_bridge_list[count].id = count;
> +			count++;
> +			break;
> +		}
> +	}
> +
> +out:
> +	dp->bridge_count = count ? count : 1;
> +	return ret;
> +}
> +
> +static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
> +{
> +	struct cdn_dp_device *dp = dev_get_drvdata(dev);
> +	struct drm_bridge *bridge;
> +	struct drm_encoder *encoder;
> +	struct cdn_dp_port *port;
> +	struct drm_device *drm_dev = data;
> +	struct cdn_dp_bridge *bridge_list;
> +	int ret, i;
> +
> +	ret = cdn_dp_parse_dt(dp);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = cdn_dp_parse_hpd_bridge_dt(dp);
> +	if (ret)
> +		return ret;
> +
> +	dp->drm_dev = drm_dev;
> +	dp->connected = false;
> +	dp->active = false;
> +	dp->active_port = -1;
> +	dp->fw_loaded = false;
> +
> +	for (i = 0; i < dp->bridge_count; i++) {
> +		bridge_list = devm_drm_bridge_alloc(dev, struct cdn_dp_bridge, bridge,
> +						    &cdn_dp_bridge_funcs);
> +		if (IS_ERR(bridge_list))
> +			return PTR_ERR(bridge_list);
> +		bridge_list->id = i;
> +		bridge_list->parent = dp;
> +		if (!dp->hpd_bridge_valid)
> +			bridge_list->connected = true;
> +		dp->bridge_list[i] = bridge_list;
> +	}
> +
> +	for (i = 0; i < dp->bridge_count; i++) {
> +		encoder = &dp->bridge_list[i]->encoder.encoder;
> +		bridge = &dp->bridge_list[i]->bridge;
> +		ret = cdn_bridge_add(dev, bridge, encoder);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	INIT_WORK(&dp->event_work, cdn_dp_pd_event_work);
> +
>  	for (i = 0; i < dp->ports; i++) {
>  		port = dp->port[i];
>  
> @@ -1050,6 +1335,7 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
>  
>  	pm_runtime_enable(dev);
>  
> +	cdn_dp_bridge_hpd_enable(dp);
>  	schedule_work(&dp->event_work);
>  
>  	return 0;
> @@ -1058,10 +1344,14 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
>  static void cdn_dp_unbind(struct device *dev, struct device *master, void *data)
>  {
>  	struct cdn_dp_device *dp = dev_get_drvdata(dev);
> -	struct drm_encoder *encoder = &dp->encoder.encoder;
> +	struct drm_encoder *encoder;
> +	int i;
>  
>  	cancel_work_sync(&dp->event_work);
> -	encoder->funcs->destroy(encoder);
> +	for (i = 0; i < dp->bridge_count; i++) {
> +		encoder = &dp->bridge_list[i]->encoder.encoder;
> +		encoder->funcs->destroy(encoder);
> +	}
>  
>  	pm_runtime_disable(dev);
>  	if (dp->fw_loaded)
> @@ -1112,10 +1402,10 @@ static int cdn_dp_probe(struct platform_device *pdev)
>  	int ret;
>  	int i;
>  
> -	dp = devm_drm_bridge_alloc(dev, struct cdn_dp_device, bridge,
> -				   &cdn_dp_bridge_funcs);
> -	if (IS_ERR(dp))
> -		return PTR_ERR(dp);
> +	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
> +	if (!dp)
> +		return -ENOMEM;
> +
>  	dp->dev = dev;
>  
>  	match = of_match_node(cdn_dp_dt_ids, pdev->dev.of_node);
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
> index e9c30b9fd543..215f3da61af2 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
> @@ -38,6 +38,8 @@ enum vic_pxl_encoding_format {
>  	Y_ONLY = 0x10,
>  };
>  
> +struct cdn_dp_device;
> +
>  struct video_info {
>  	bool h_sync_polarity;
>  	bool v_sync_polarity;
> @@ -63,16 +65,33 @@ struct cdn_dp_port {
>  	u8 id;
>  };
>  
> +struct cdn_dp_bridge {
> +	struct cdn_dp_device *parent;
> +	struct drm_bridge bridge;
> +	struct rockchip_encoder encoder;
> +	bool connected;
> +	bool enabled;
> +	int id;
> +};
> +
> +struct cdn_dp_hpd_bridge {
> +	struct cdn_dp_device *parent;
> +	struct drm_bridge *bridge;
> +	int id;
> +};
> +
>  struct cdn_dp_device {
>  	struct device *dev;
>  	struct drm_device *drm_dev;
> -	struct drm_bridge bridge;
> -	struct rockchip_encoder encoder;
> +	int bridge_count;
> +	struct cdn_dp_bridge *bridge_list[MAX_PHY];
> +	struct cdn_dp_hpd_bridge hpd_bridge_list[MAX_PHY];
>  	struct drm_display_mode mode;
>  	struct platform_device *audio_pdev;
>  	struct work_struct event_work;
>  
>  	struct mutex lock;
> +	bool hpd_bridge_valid;
>  	bool connected;
>  	bool active;
>  	bool suspended;
> -- 
> 2.49.0
> 

-- 
With best wishes
Dmitry

