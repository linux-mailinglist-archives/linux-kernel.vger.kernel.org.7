Return-Path: <linux-kernel+bounces-813782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B96B3B54A98
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69857581F89
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92982F3C2C;
	Fri, 12 Sep 2025 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MW+FPQwl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877382DC778
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675131; cv=none; b=lHMz6IMeTdjUmxMiTVPlH6S/9wzGkC0SQzBQxCAPGH78bP54WxWCTWiVsojhUVnS3jruLnXepiXq8/aFXRudh0vL94KpagT7XXXogJY0SsiYoZ3vBH8nq0nR+PbAeV2eRYOIqYe7hNgEjLk6nrqZXFjpgrbKYNbrAt/ulHDzzR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675131; c=relaxed/simple;
	bh=03+wyp6aIeVPz9t0pV+DPj7ar4IffsWKjZg/T1XbWC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEeP+ccnRhxgpGvlWbP/DzLzCs2jGBNCBx7Bj7Gt/K2SAtsqnLu6yyNi01E9TFWOAw8rfuDwMT9TC5raEBCXH06aNyvEAvPxjj64Atox5pge62K/3MgzhUYE+KCuN3upfantE2Bk0rOGHX+ZyiCfGfMLVSBzLNlrpbR8PcdmvqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MW+FPQwl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fGlI019755
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ohxWiDpU3AbnS+UuB5k3uTeL
	Adfv2H657D5P1upIvkQ=; b=MW+FPQwl0WXbDItnUmSLSyc0GbmzLyjyN+1txKc9
	AT8xH8wJevXZk+3JGPM/TL/TeFRxNl3xa+KYO+gVkQJibvA1hRV14iyuYwuCQD/k
	H6TQpfFx6o9mf+cU9fgLeQWIvyXyz6gBoLqL44Lh7tsBn89d2vYo2EdJBDoMeqpt
	TT0KXvoKXXTNMHzTHYymhlwEPkYue4dvA1klpbeN+GBZIqZeU/yPXK29s1Nmj+NK
	lH2MLswbDAoOsfcI6fFPUnlcyNvueBJVPGA/xxt4gjfJXJRzefcTAKNoYcHr9XpY
	Bvy0I3PdXjtYA4YgRe7OaVCk+4JsJLwYYDlNZvhHIPwr2A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t387tuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:05:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-72048b6e865so31477886d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757675128; x=1758279928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohxWiDpU3AbnS+UuB5k3uTeLAdfv2H657D5P1upIvkQ=;
        b=UTpe+U6UEOeadjLvNQEch5ny7PkfaMMOOUJvUGT73hlr+iF51r1UqzrtHMtizm3xRg
         uWsxhBmiFMqxgEval6c9GP53OvgwmEAO3YvHabtyv6aMRx0g8+9r5948Vn1owiDz2xpC
         cNlla5nYY/iRbdOrIYM/hio7e2dmST344YmIDX1ZkYqkj8eB5+lXTWfcpdV+qoMFqQik
         5JPJd3KXKHSBZ+h7YKiVVdz637TBZsXfjzUBKC7vwdTC/TNMovFVqNdlKYsa7kitQBBh
         GPvOvGLlS3+Uyt5OJQux36dqrF7LShSoBkU6RwT5NCsKFj1hg6Zo2Hk6+kN64C977m2a
         suNw==
X-Forwarded-Encrypted: i=1; AJvYcCW1APm3oyk9oDmzyCuLvl5fT2Jg/0VlQEfI4qWXMekm5zYBghbhDnV3fSxVYLWXXZtlyK9yjv/DPumR/HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytX7pR+6cprQUGYJu2S1gtIJuzvqrTzZ+lVzs1lEYk+y3mrHtm
	KFrvVOWm6IdmJoOId2Bcw0F6IPr+TcofQSuO/OiPaXOchNgjd1iwss7s+jYFbOG6UdkGC08T+6z
	fAKqx19s2Bw4sqvea5y/4/XAogAlxI0dL6jFkNNq4zZ4d6O4lXNQSfDHuXQXkGXF9MaE=
X-Gm-Gg: ASbGncsjh+1Mw7TiQ/MPGw+cP5I9+EAExzw8H7wP7lOUH+aKboTr5Hhat0LffiysUq5
	Z53JEshXan43NPDMjgMkzSO+//Y52hD184BpWNAv6YiuSCt5pRsKfeUfukNwIiqA/5wnaX25Zmp
	vzGQwjCi5Cz21yaPaxhwvbZ6EkpZOt8XCxqniWpUJm8LycbPAnNiwtakt6ie15mkIa689fGOjRc
	NLdr3mmt8rBypOrWt/fYbZLlwho9J859ZQKtCwrPbAMrtDxV5bAhCm+H/LfTtKc2lSxEKWCNYt3
	uczRDMPN1oQPNG7sBn6WNEZj4jo19TeOy/ncNZBFBxa9LqT42NSKyKG0cp17KOnA6jhaDwqzkK3
	XF3kcYVe7bzdAzueTH94woobPjzEncoU9BS3++69N5F+032zY462g
X-Received: by 2002:ad4:5cae:0:b0:725:cd10:3d1d with SMTP id 6a1803df08f44-767bc5e525dmr30639246d6.16.1757675128293;
        Fri, 12 Sep 2025 04:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKv2Tcc0omb5IKgx/KH/GT6a7+rHlMbIBMJwADkJ0xx5dKz4aNr6q+JalITdK6SvCqNVjAPg==
X-Received: by 2002:ad4:5cae:0:b0:725:cd10:3d1d with SMTP id 6a1803df08f44-767bc5e525dmr30638416d6.16.1757675127615;
        Fri, 12 Sep 2025 04:05:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65564946sm1077186e87.127.2025.09.12.04.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:05:26 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:05:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jingoohan1@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, hjc@rock-chips.com, heiko@sntech.de,
        andy.yan@rock-chips.com, dianders@chromium.org,
        m.szyprowski@samsung.com, luca.ceresoli@bootlin.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 13/17] drm/rockchip: analogix_dp: Apply
 &analogix_dp_plat_data.attach() to attach next bridge
Message-ID: <2cu3ge6kjeibfznvt6c52xn2rp5zb3wk3pkb7gly34qrjlueem@7wqyowascpn5>
References: <20250912085846.7349-1-damon.ding@rock-chips.com>
 <20250912085846.7349-14-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912085846.7349-14-damon.ding@rock-chips.com>
X-Proofpoint-ORIG-GUID: Wvssg8YMJFs8PB5khaxpFpQlf_COXQ4Q
X-Proofpoint-GUID: Wvssg8YMJFs8PB5khaxpFpQlf_COXQ4Q
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c3fe79 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=Fz8SCyDB7bCRA1NsBX0A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX9PPNFdoo2FO4
 QxkT1EEKF6ENmrnkS+iQI/eX51OYRI/L0/EeENiu+bFa4ithe+erK1R2n1IYR9ooGer4xl57gD/
 O94UkJxnFAjHLAf5tIJUbfanrHphxjT8hqkIy05WXXw6RbHRcToUaU2Qa5YcKHtQIBlHLhJlKLS
 wMnBK6APuys0Hr41jPE3JK+RJ+dMN+fgCCr5dzHRsoeKFtRz6L6Qegy+9azAfS6NXXC6SK25jyC
 0FzePlVSs9Z8UWR+iWHcUXZLZsl6HoMiPXk+XIsJkJjgz07oyuqjBwLhs72IuHglTXz9Z2JwXgP
 tJpwZ/g3MZTxeNH1KtzZRFO8grtRCPRXSeLojSO04TYynbl+hu0KQwNG6lD18qJiPHmDPHbciLy
 rbK9D1IS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

On Fri, Sep 12, 2025 at 04:58:42PM +0800, Damon Ding wrote:
> There may be the panel or bridge after &analogix_dp_device.bridge.
> Add rockchip_dp_attach() to support the next bridge attachment for
> the Rockchip side.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 0784f19a2ed9..39f1ed293c75 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -164,6 +164,24 @@ static int rockchip_dp_powerdown(struct analogix_dp_plat_data *plat_data)
>  	return 0;
>  }
>  
> +static int rockchip_dp_attach(struct analogix_dp_plat_data *plat_data,
> +				     struct drm_bridge *bridge)
> +{
> +	struct rockchip_dp_device *dp = pdata_encoder_to_dp(plat_data);
> +	int ret;
> +
> +	if (plat_data->next_bridge) {
> +		ret = drm_bridge_attach(&dp->encoder.encoder, plat_data->next_bridge, bridge,
> +					DRM_BRIDGE_ATTACH_NO_CONNECTOR);

Can this be handled inside analogix_dp_bridge's attach callback?

> +		if (ret) {
> +			dev_err(dp->dev, "failed to attach following panel or bridge (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static bool
>  rockchip_dp_drm_encoder_mode_fixup(struct drm_encoder *encoder,
>  				   const struct drm_display_mode *mode,
> @@ -452,6 +470,7 @@ static int rockchip_dp_probe(struct platform_device *pdev)
>  	dp->plat_data.dev_type = dp->data->chip_type;
>  	dp->plat_data.power_on = rockchip_dp_poweron;
>  	dp->plat_data.power_off = rockchip_dp_powerdown;
> +	dp->plat_data.attach = rockchip_dp_attach;
>  	dp->plat_data.ops = &rockchip_dp_component_ops;
>  
>  	ret = rockchip_dp_of_probe(dp);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

