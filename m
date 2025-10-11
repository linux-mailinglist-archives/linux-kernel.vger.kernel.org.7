Return-Path: <linux-kernel+bounces-849267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C53BCFB14
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1721189B244
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F6D27874F;
	Sat, 11 Oct 2025 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVdsgXu+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CAE246793
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760208733; cv=none; b=qsxtI4rkW86x6Cs0A1Xs3xmXMS45zSeMeLtPCi/HeYiY2IuWq6V0UYBg7aU2j9zLiV8pZRinc/xUbUOYuf4m5pmFHVOYwbEvjxdkxcqzA+S+cLnz8AAS+6fNWUQTQxWfNRNVjoXAV9T3Ds3V8kYlsVtdIuMFwWuLeaU0+TIDVyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760208733; c=relaxed/simple;
	bh=+r/j+yc/WLsHEp+xoY3Czgt6T1OgW9NeIuuGMbjdpAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0upCaIM4przaQxA5h03Yz2t4SvRK7UuW0HedPh684tg9NvUXpGd3dzsb64VEnWoWRvlabKyVLGeAgwGBvJxtQut8aqf8vGcXMr1skwu/V1jdtHG7MZS/g4HDpydNqM4TCNKLEfEr3qVbKXfb3lqrjitYdisAfjCXNwgajcmx1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVdsgXu+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59BHfqYi000818
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/+pzSiIjVBnWxA/hQntIwuWV
	dEB2AAtnUsGXY13DWPI=; b=SVdsgXu+Dv9XNolVHUB2L3Cuv0aSMuggEYDMC+i9
	6k5APB5vDU1bJiw9zKOgXB+sCZqw8MNDqdi1wl+bbjsaYb1xX5y99eqorLOmFN9/
	En7o9HnNswuxn7OzMK5UmryBhtbd/WZZPtur3trLWlPfz2a6rPezyR0VRrn7yTM8
	ZoZzBoI7ojkheJ/5uAaGE3yTASujDDp4UPtmiCMEcfXAtzyk3SZC34Udr6jJhuJ8
	2mCaEtTfuVKF/zpdBVIx7rCX1A9TAz82niaGoknye/d/Npl0auFXVvlaAJ/qQHH7
	KI3wuOvexIohrqY0k2X7OHrD5HoBqN2ByGjcNNG/jIPAwA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdfry40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:52:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-828bd08624aso1648260385a.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760208730; x=1760813530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+pzSiIjVBnWxA/hQntIwuWVdEB2AAtnUsGXY13DWPI=;
        b=hEEnqV2V38IrhBneeaH16cvRhuQgg4oalkCgBD6PHt4AXXcPvdCFZ8RcBKjEXbOXvC
         pyEO+gvxvwrfG/vmSK/RIiaPe37VoAoKmx9bPAepm+iD3LCWAjHIN1d8cIWn7DDHJdC/
         uUbWG4UmQhEEOO6E8cFWpNDINciG2uUht1vb30TDBN6QyxR1+tSako5BSB1Zy46+uZox
         VuDdkck5X+pQlokktmpM4VxawceYtn8J/prMZqdJBD3M/2g0YTW/Q4uDbxn8k/ex0+gk
         mcLb2x7az78AykJJYSyiDhD4xQsFECrqTqe/ddziAi6MJi76Ok1dC7D1UWEc59DQLl9H
         RU/A==
X-Forwarded-Encrypted: i=1; AJvYcCWUM4bEu7ViIvWfqREiY+ItVSkG3PN+9TDCcHIgLbRQDzAvEMmKyFEDLu5/nhNp3yJuWqax+bSSDrhJ+Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytywTm7HPx5h2nvmWmwpGNxoOTj9Nmz9Icqz46oLdLPYnPxbcH
	yS7+XQJp3MciRE9KoqkHufeieP1ZbKgJP9NHc32Kb9qeylTgRoWbFCy5kPaDNLg+LYMEjLNYTdX
	FaZW6O28fJKc7LCHTkuZhcXHry+gew3V+E8fMzIyY4yNtMQwGNQPPJVyYu+jjcXyIz9U=
X-Gm-Gg: ASbGncsMUocUva8CgwomPo6Btx5mUWAamlWoVd/1lIyDzO91AVN08Q9ocXdNukiS/ZT
	XTAWG4kyjp7DHOXiCVb2Aws5GmrpEq27t4b5Zx1P4VbYZyDO4g+35ZTMwntTY/CachkIp4eIrxB
	geUNdZ85kDP3uIaywv53IievxViD5xHF80cDG2XJxdQ1ettwcDrUbvv9XI2UqwCZCBD894C+P1p
	hOEcUcHYf4DqalvG3KXoRGWKmzfKyI1cNnLHrIaxO8ztxkdOiBYlji9AcbGCDiNLNGbfcktdY9k
	f50sqkw8Thg5RqJ8b5rgtwTKBw7TCa609W/6JizB8GXfE8OUhUq77oLzOZLxKcmUJrIRkc4vGLf
	naZkLrKWP+9tp9/GjFtfEVOQBa0pjYUMF4K4Ml+1pRUClvTBhSS8c
X-Received: by 2002:a05:620a:400f:b0:85b:a906:127c with SMTP id af79cd13be357-88353558d25mr2318571185a.54.1760208729760;
        Sat, 11 Oct 2025 11:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/k0JIMwDDe8wKbfoitr+GmGj4WmEClMNGgNYD1vA6WxUaESVw6RtRzEdEu71iz8UzlrWicA==
X-Received: by 2002:a05:620a:400f:b0:85b:a906:127c with SMTP id af79cd13be357-88353558d25mr2318568685a.54.1760208729193;
        Sat, 11 Oct 2025 11:52:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f88ddsm2167029e87.31.2025.10.11.11.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 11:52:08 -0700 (PDT)
Date: Sat, 11 Oct 2025 21:52:06 +0300
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
Subject: Re: [PATCH v5 6/8] drm/rockchip: cdn-dp: Add multiple bridges to
 support PHY port selection
Message-ID: <qzcdulyj2enho7l6vyvad7ln46zk2u4z7rnsjv2nv4tbw5j6jf@6oenbixoh3sp>
References: <20251011033233.97-1-kernel@airkyi.com>
 <20251011033233.97-7-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011033233.97-7-kernel@airkyi.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfXz2XdFj0HYjR8
 9CC3tYH5GAwJvkTdbJWKOUNFbuBpafVK8n5XgN8gBPK14xhpCZGJyskUQTvAEVNYexAR+23Or9c
 OxeKJsbF//cPjVk8eNOGClWAuCfvh6o3jK32YNWxetuFueTyJmVyRhv5aH1NFph0Ub6Jh+5pY+J
 bjrUZQ8q5jeY71RDgZ3mKKOFW1VsJtndgng8G6hNrWUbhtq0ZC+6tkxKM0f9XPKh9LuRt0CdyGk
 kfTO1h7MiN6N1sRup18FVJk5XGCQr13iAgQfzr7T19VFl6CWK2nYhBYIAuR3N9xcWHKSmD3BSSo
 l5mR08Ivt6F24ng3ciIycgNwbmmLJ7MpXskn1BVFbEvjMmbGGW/9u9WLrMz1ovOopUK7OTTe3EQ
 uaoS/APXCZhndlrxyG827CDE1M1Zyw==
X-Proofpoint-GUID: 4aWX0uv8ZuMFh1VpvVo6y4wSV9QOwF7w
X-Proofpoint-ORIG-GUID: 4aWX0uv8ZuMFh1VpvVo6y4wSV9QOwF7w
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68eaa75b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s8YR1HE3AAAA:8 a=Vq1njTOzTen_YWzSrCwA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

On Sat, Oct 11, 2025 at 11:32:31AM +0800, Chaoyi Chen wrote:
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
> connections between the first bridge in bridge chain and DP
> controller. For example, the bridge chain may be like this:
> 
> PHY aux birdge -> fsa4480 analog audio switch bridge ->
> onnn,nb7vpq904m USB reminder bridge -> USB-C controller AUX HPD bridge
> 
> In this case, the connection relationships among the PHY aux bridge
> and the DP contorller need to be described in DT.
> 
> In addition, the cdn_dp_parse_hpd_bridge_dt() will parses it and
> determines whether to register one or two bridges.
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
> allowed to read the EDID. So we will try to return the cached EDID.
> 
> Since the scenario of two ports plug in at the same time is rare,
> I don't have a board which support two TypeC connector to test this.
> Therefore, I tested forced switching on a single PHY port, as well as
> output using a fake PHY port alongside a real PHY port.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
> 
> Changes in v5:
> - By parsing the HPD bridge chain, set the connector's of_node to the
> of_node corresponding to the USB-C connector.
> - Return EDID cache when other port is already enabled.
> 
>  drivers/gpu/drm/rockchip/Kconfig       |   2 +
>  drivers/gpu/drm/rockchip/cdn-dp-core.c | 355 +++++++++++++++++++++----
>  drivers/gpu/drm/rockchip/cdn-dp-core.h |  24 +-
>  3 files changed, 324 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index faf50d872be3..7472ec923cfd 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -55,6 +55,8 @@ config ROCKCHIP_CDN_DP
>  	select DRM_DISPLAY_HELPER
>  	select DRM_BRIDGE_CONNECTOR
>  	select DRM_DISPLAY_DP_HELPER
> +	select DRM_AUX_BRIDGE
> +	select DRM_AUX_HPD_BRIDGE

You are not using them in this driver, so this is not correct. Please
declare Kconfig dependencies for the drivers that actually call the API,
otherwise the LKP or somebody else can get compile errors because this
driver wasn't selected.

>  	help
>  	  This selects support for Rockchip SoC specific extensions
>  	  for the cdn DP driver. If you want to enable Dp on

[...]

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
> +	 */
> +
> +	/* One endpoint may correspond to one HPD bridge. */
> +	for_each_of_graph_port_endpoint(port, dp_ep) {
> +		struct device_node *phy_bridge_node __free(device_node) =
> +			of_graph_get_remote_port_parent(dp_ep);
> +
> +		bridge = of_drm_find_bridge(phy_bridge_node);
> +		if (!bridge) {
> +			ret = -EPROBE_DEFER;
> +			goto out;
> +		}
> +
> +		dp->hpd_bridge_valid = true;
> +		dp->hpd_bridge_list[count].bridge = bridge;
> +		dp->hpd_bridge_list[count].parent = dp;
> +		dp->hpd_bridge_list[count].id = count;

This looks misnamed. They are not necessarily HPD bridges. There can be
a random chain between your controller and the actual output / connector
/etc.

> +		count++;
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
> +	struct drm_bridge *bridge, *hpd_bridge;
> +	struct drm_encoder *encoder;
> +	struct cdn_dp_port *port;
> +	struct drm_device *drm_dev = data;
> +	struct cdn_dp_bridge *bridge_list;

Why is it bridge_list?

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

-- 
With best wishes
Dmitry

