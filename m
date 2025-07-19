Return-Path: <linux-kernel+bounces-737689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6CBB0AF69
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF5D4E6861
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B4A221F01;
	Sat, 19 Jul 2025 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SdRgksaU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7CB2036FF
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752922436; cv=none; b=lFUUhYSyaJDZvToLLsGDW6b83o8KSbIZsMB8Zfsx49mjU91W0kfbeLReSNNvVPGL8JcqVUt5NdC1n9ZIAbmG/hHePZk2dU2ZzH3xYFgUM5b1IfrrTgNiVcsXyddlc6SF/FzrAV7Klghu9RB+qiiWmlAlScpXx7drUW6rFRXuik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752922436; c=relaxed/simple;
	bh=R68RVaZmjRSkOEe/XAUeN/NzBKTsIcCDe6z2wPq6oqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3gOQ+Vt9eO050ZQWZ/0nVid55NijJdSRRnNVL1L9y6mgYaoAOVtNAaOA3PAnMUhsuj1faKo/YnlakyMMMffhjod+TTjrvNodM9Drkkd86uG0n2BPh3xRtgYMlP1r1QkFlffa9x5HEje/4hG1T7o7asZAbyhYZQBIezzmUkK22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SdRgksaU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J4EDS4032135
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aqHtp61gi/MVVqpPkBkPz7nq
	zj2NZMIcHn+kla2ZN4c=; b=SdRgksaU3n0/sMpQ8XUiiDYGoQ70xrm0QbQr8PDg
	S0+acoJzMc8l4SYRgpySDuIJSlEcsc2Hwby8/Wt/hNGd90zWTuI0BQ+7oE+t49ht
	9apLGxz83+0t7M2CAMACWcMiYuCppt0E9xdoBFGUlExRGIjTvBP6mXG2regVuHzR
	qZu6bD8W4MID62X2DgD9kIkEIDjO6koIqjP7ry4/5SGzaLyayxxeNQXfaREoEUVQ
	hPUFsnGMEKXZHeHrcXFxqM41p+xgeQISAbSFix/xXhW1WDcGLBO/73pKi172Zfk+
	NMogtuaHI361nKygSHQn/MvffjIaC+BaWrXm4J6RaFdMaA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480459ggj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:53:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e2c8137662so504858085a.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752922432; x=1753527232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqHtp61gi/MVVqpPkBkPz7nqzj2NZMIcHn+kla2ZN4c=;
        b=cfEG53Vwz6OKQOnqjF6vID+XhqUNPKXy8gvSnST06ra4nMuBH5A28jzTK/C9+wEvoW
         98Sb4jLPv+j+gI6zlO3nHObKhdNFKCn6wq5wuW6yjrN5OyQAXsx7XesjhujU7KfL/sRL
         EHxCb8Jxm5l82vfMTnyZlBzcJnGGhxHaDcNibIb6a4MMURSrLCJz1WR3wo98CJr25110
         fLYaqrxiokvRUMjjINI3m+aXE+N27qa+OCIjXazwoRc9Wz+KQH5uSfmFCfvqSqI5Rsn8
         MYqlE/0J4aBHgSgwhpEuAhWAsYTbyIKVy3FAFycmI7PKXIZ6ulwhX1FBQeV36tlpnw36
         LtVg==
X-Forwarded-Encrypted: i=1; AJvYcCVSdhaZsFE8llviaGbetv1NMJlQcdQpLKe+MYDc+ZL7az6RbDKqkDlym3+BDrGSjLHDMQDUp04gF/VQIpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6pXfzi0lXjgnO8vVynWteYeHA7ScUgvb1RPAqNnlHu3fAnwrW
	XKQ5xouq3CQ1qErW9CCRhQWOhqab8aI8sfbFm+KHeunPFXSu4EJn7ZzxluLK8X5E2cABA3MpH8L
	Xrs6AiMLxECQnv67cUoowo80mkIEeZa+y5FtYIYrJy3VPGCEhL4cE5xwH2IKaSIWY1xQ=
X-Gm-Gg: ASbGncurLiP8uCiwf86SUkCC72YkGPTif8KZsHCenaT8b82cea8hvUT8dJ7XZYvjuFO
	uuoBP53K7GSB++h8Dny+Gn+1qLKu4g/sLl2F6IAA/9TFhYEaJ4vAuuW7ZTRJ2yHrCuqRxsphtP6
	VNvCCTH2Cc4mCIqY2KESDthkZzkwX5YY4znI0hiHGD1e5AQjc9wAVQWPwDOtkP61XgC2hkIy8XR
	WmgbtaooMPoIumUaiy30Ul7nV2S5vGaNgZrCyHirDHR+ibPxSUE6OGMG9ki3zaONf1FfPnoJngO
	7XUQkHQnZvZxk9OwC9pBXvnfZ3Sb4XlyKJceiewjop1Pio9Jl9O8mr4r12sC0AaFd5Y9YjFtrqD
	cDJtD79IGJGUo/4cy4qYgdJyuuOvrBtLF1miZLJHO0wJ68ylaS0JY
X-Received: by 2002:a05:620a:440a:b0:7d4:49fa:3c59 with SMTP id af79cd13be357-7e34356c61bmr2239108185a.15.1752922432074;
        Sat, 19 Jul 2025 03:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPrmyV8egRcX0tplCS17IxY7fqr0+H6cJp69VeGuqF/GMP4bJno9IhBcl041AaSBLD5rosBg==
X-Received: by 2002:a05:620a:440a:b0:7d4:49fa:3c59 with SMTP id af79cd13be357-7e34356c61bmr2239105885a.15.1752922431592;
        Sat, 19 Jul 2025 03:53:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9b1b1sm677727e87.35.2025.07.19.03.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 03:53:50 -0700 (PDT)
Date: Sat, 19 Jul 2025 13:53:47 +0300
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaoyi Chen <chaoyi.chen@rock-chips.com>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/5] drm/rockchip: cdn-dp: Support handle lane info
 and HPD without extcon
Message-ID: <t3th2tqbnkmsqssypxvye6vsfhpw37sf7wyl53cso3r5pqa7qp@gn74pj75j4pb>
References: <20250718062619.99-1-kernel@airkyi.com>
 <20250718062619.99-4-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718062619.99-4-kernel@airkyi.com>
X-Proofpoint-ORIG-GUID: GLC6id8MG5WRKfP8cCJNE_32EE4UZh1I
X-Authority-Analysis: v=2.4 cv=fdyty1QF c=1 sm=1 tr=0 ts=687b7941 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=ady2-bcLGFUvj2b528oA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: GLC6id8MG5WRKfP8cCJNE_32EE4UZh1I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDEwOCBTYWx0ZWRfX181ebAdbN8sb
 40g6bSilI1cTwfQYKVT6b9ZQNh8Nyg22uN1wYYNJJm4WV6zJOtEAoMF2/1WQDLep+XhBe5Kl5OQ
 4XgfYVpA8MSNNHw3TbTWwnnpFCIrJ4b5fpwpk5ORZ6KHX6JOe2MxJyhN7tCOlDjVsX59A9KQPgO
 TsncgVpBnWaGejtv0Td7o5nPRLjIDT8bQ4G7U2VrawKuU1mGz3JueNvcG3AyM6iZc/lrvB/Yo0A
 ps48MWoVDMD2MSAuryzBbvcvXdDI4c9UMvSzAFGzKhliQAF8w/3uY7iwKnZm5x5x9B23wqsoYxN
 074mEbrTDUk62gGGQUYZ+aSzdaPr5wDSvfUTWqaGI39dzAiDySrzEzxR5h+NAZ7gcWNLl/eAq1V
 XWXBIw2GBZlkjX6dUJARg3EnAvL3Gz9JrqxBLO5Sc3GMT3RPN9nKVoKZnMrUBvBuGxjcZfd+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190108

On Fri, Jul 18, 2025 at 02:26:17PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> This patch add support for get PHY lane info and handle HPD state
> without help of extcon.
> 
> There is no extcon needed if the Type-C controller is present. In this
> case, cdn_dp_hpd_notify() will handle HPD event from USB/DP combo PHY,
> and the lane info can be get from PHY instead of extcon.

The DP AltMode driver will send drm_connector_oob_hotplug_event() to the
DRM connector associated with the USB-C connector fwnode. However your
DP connector will have fwnode set to the DP controller, if I'm not
mistaken. So I doubt that HPD events are going to be delivered
correctly.

> 
> The extcon device should still be supported if Type-C controller is
> not present.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
> 
> Changes in v2:
> - Ignore duplicate HPD events.
> 
>  drivers/gpu/drm/rockchip/cdn-dp-core.c | 37 ++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index 24f6b3879f4b..b574b059b58d 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -156,6 +156,9 @@ static int cdn_dp_get_port_lanes(struct cdn_dp_port *port)
>  	int dptx;
>  	u8 lanes;
>  
> +	if (!edev)
> +		return phy_get_bus_width(port->phy);
> +
>  	dptx = extcon_get_state(edev, EXTCON_DISP_DP);
>  	if (dptx > 0) {
>  		extcon_get_property(edev, EXTCON_DISP_DP,
> @@ -219,7 +222,7 @@ static bool cdn_dp_check_sink_connection(struct cdn_dp_device *dp)
>  	 * some docks need more time to power up.
>  	 */
>  	while (time_before(jiffies, timeout)) {
> -		if (!extcon_get_state(port->extcon, EXTCON_DISP_DP))
> +		if (port->extcon && !extcon_get_state(port->extcon, EXTCON_DISP_DP))
>  			return false;
>  
>  		if (!cdn_dp_get_sink_count(dp, &sink_count))
> @@ -385,11 +388,14 @@ static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
>  		goto err_power_on;
>  	}
>  
> -	ret = extcon_get_property(port->extcon, EXTCON_DISP_DP,
> -				  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
> -	if (ret) {
> -		DRM_DEV_ERROR(dp->dev, "get property failed\n");
> -		goto err_power_on;
> +	property.intval = 0;
> +	if (port->extcon) {
> +		ret = extcon_get_property(port->extcon, EXTCON_DISP_DP,
> +					  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
> +		if (ret) {
> +			DRM_DEV_ERROR(dp->dev, "get property failed\n");
> +			goto err_power_on;
> +		}
>  	}
>  
>  	port->lanes = cdn_dp_get_port_lanes(port);
> @@ -821,6 +827,17 @@ static int cdn_dp_audio_mute_stream(struct drm_connector *connector,
>  	return ret;
>  }
>  
> +static void cdn_dp_hpd_notify(struct drm_bridge *bridge,
> +			      enum drm_connector_status status)
> +{
> +	struct cdn_dp_device *dp = bridge_to_dp(bridge);
> +	enum drm_connector_status last_status =
> +		dp->connected ? connector_status_connected : connector_status_disconnected;
> +
> +	if (last_status != status)
> +		schedule_work(&dp->event_work);
> +}
> +
>  static const struct drm_bridge_funcs cdn_dp_bridge_funcs = {
>  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> @@ -831,6 +848,7 @@ static const struct drm_bridge_funcs cdn_dp_bridge_funcs = {
>  	.atomic_disable = cdn_dp_bridge_atomic_disable,
>  	.mode_valid = cdn_dp_bridge_mode_valid,
>  	.mode_set = cdn_dp_bridge_mode_set,
> +	.hpd_notify = cdn_dp_hpd_notify,
>  
>  	.dp_audio_prepare = cdn_dp_audio_prepare,
>  	.dp_audio_mute_stream = cdn_dp_audio_mute_stream,
> @@ -1028,6 +1046,9 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
>  	for (i = 0; i < dp->ports; i++) {
>  		port = dp->port[i];
>  
> +		if (!port->extcon)
> +			continue;
> +
>  		port->event_nb.notifier_call = cdn_dp_pd_event;
>  		ret = devm_extcon_register_notifier(dp->dev, port->extcon,
>  						    EXTCON_DISP_DP,
> @@ -1120,14 +1141,14 @@ static int cdn_dp_probe(struct platform_device *pdev)
>  		    PTR_ERR(phy) == -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
>  
> -		if (IS_ERR(extcon) || IS_ERR(phy))
> +		if (IS_ERR(phy) || PTR_ERR(extcon) != -ENODEV)
>  			continue;
>  
>  		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>  		if (!port)
>  			return -ENOMEM;
>  
> -		port->extcon = extcon;
> +		port->extcon = IS_ERR(extcon) ? NULL : extcon;
>  		port->phy = phy;
>  		port->dp = dp;
>  		port->id = i;
> -- 
> 2.49.0
> 

-- 
With best wishes
Dmitry

