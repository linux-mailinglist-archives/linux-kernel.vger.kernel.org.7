Return-Path: <linux-kernel+bounces-838133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ED0BAE83B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7113AF47F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD27235045;
	Tue, 30 Sep 2025 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pe4Y/dsR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B171222565
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263485; cv=none; b=iN6/QimQqZicm1zjrzkozTS2S52HHH3pr6tZZc9D7WuhDm2EAFkeNPORHEMtIrYwBeZkqlSCft2EGB9Adm/R9UESFNAvpnLAg02UrwInBFBGlreTrj4IIEekw+mCks8ieQ3lnLRiAKQkQZ8EYiTQRRnaB4v8QJxhrxnKiUrPsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263485; c=relaxed/simple;
	bh=kfQqOG3eCJg32IjZw+ZQCxJ2xnF8nSOsHLMk+gCmMfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sjhfi1zvXRSjclFp6js7IyS/myrHKgVp0FSfi1cpcfEeHmByTzm8GtXRYh1AGZO5PHlqBV4vr02BkLR5tLy4EbFK6qBz82fmWu/46AOcV+pFPk4tV4RUqbGhXvFI/PxPH1ys4l0tZklDTm4gx331CIAaIwIZKetByRNRtyybe+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pe4Y/dsR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UCDoNM012468
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sdLCuj5V1B6mGqY302QitcGK
	Fp9JJVU/Ya21+9Ly7EM=; b=Pe4Y/dsRASMVOkBpq1opV2LmbOdpxDfVc7aI+ElS
	544wIH3lQYA5SQiUMZQp28vek9ObwV7iz4w5vSnE7J6E8IHtOQJ9ckTV1jlERRwm
	/TbtSHV0W/1HHnQUknINy73i9V+ig57gpREelyC0QDOeIbrviiLhLLnyEo1lUJlu
	clNg+5gsqLIPJX8z27r3tLuiyZrTYejLf00vyCyGbF5nHBIeKquXRSrH8sn1bkA8
	4VQ+AnhjucwyY1qmVl7s9xGCGCkn67p7AurHo/w0O/S0x7arWbbM3X/Ltj67qCxd
	3eTuof2oqS+cN5qfBi+MgrgTzORxYpFN0fEgTMkCoWpdxQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a62caq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:18:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4de5fe839aeso114133521cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263482; x=1759868282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdLCuj5V1B6mGqY302QitcGKFp9JJVU/Ya21+9Ly7EM=;
        b=vpfYXqgCj0EDw/4o+bFGc+H9vAXdJ6jBrpIKxgAzpMZ+6ed0C8/OvMqdeJi1M+pJuD
         OHks3TsnIozmzcAL1fFTLL4qBkOsWB5unVfcbkvyWNav1Gq+/Y7bfCRVDWkYdrt7robl
         N9Q7PA9whWI8a+AYg38agg3kR9i95VVyVNR0rm+DQdIgdN0eV5mWfzXddc6ffqCGBrr6
         9Ba6eWiqnniHoFGkJLJExK/PFZ8x6/UrJNw4BQN6WDXm2h6I7aXgzzljg+XIb9lYDuxT
         YSyqQYfhYAKS8KXVe7arLHxAo7N806dbDFAx+ibnwKpkisTPVT7gqwmj+atNR0a5M5+W
         PSNg==
X-Forwarded-Encrypted: i=1; AJvYcCXsn89c0134xGzv7PBWuhVEXJRSAMYUUkd5lH4jAGotmC8E8rev4SP/NGWJlE+YnvDJzJdGCXbFABYPHdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2aJPel5kU+xQHfVwFSzCK7p9Gmh/xDy9WyYjFM8URYDVuC1q
	izfLw+B9suzj1+2n4YYEtrLYv3PiDoMQLb5XWtu7gap8opV4kjSGYCNaUANHln8C0dYBGIkwCOH
	S264oepK7NkxsydxMSQ6w7kRGQJgj4bxOyfLpYV6DEtAitQd0e8DhyExxKgq4yb7erEU=
X-Gm-Gg: ASbGncsZRSqKt5yIk98zVa+Gvx0yzAxVN5r/Kn3hAg+w+QwGraYjjIYHWpCudxKau4A
	HLT58CDUVpFG2kq/IbCzUnlSqHAsV54wGlQ/OrI0KlhujvG4wKC9fbYKV32jLp9NZSgbXfXxkFb
	Ti9vDfT4x/+q5MX3vG+iFLZn9wlHvszbMNaikovpMPf06cvhIyAMA9AfIKo3qPoToUHDZQQUole
	Ao4yiBOdus0ncUtsbJj7HRbnFVC6jqku3x1fael+IYGTiRFDe3iEIbBU43wTRcBPdkTOK8YfTRe
	HgIbgfkMlTi/imQduK7In2YNVs9fS5GH0biZfRiFCxmOqQlFw5OqgiEgtugPM/kCGG5IK1zTrKv
	WzUtWzPPqa6wmAbW9O4BidqfHYoE468c0RtZYxetJ1mvzV+L8ZjPyNOytbA==
X-Received: by 2002:a05:622a:30b:b0:4db:f72a:b816 with SMTP id d75a77b69052e-4e41ca1cd94mr12855501cf.22.1759263481835;
        Tue, 30 Sep 2025 13:18:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzLJ/aNHaWVThXpiXhQPhNd6bXcsrZRT/lYLsQU/H/2CL9o9NPlqCKuAEDT1vBgHAP0z6Niw==
X-Received: by 2002:a05:622a:30b:b0:4db:f72a:b816 with SMTP id d75a77b69052e-4e41ca1cd94mr12854801cf.22.1759263481206;
        Tue, 30 Sep 2025 13:18:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-585f4a77b82sm3072757e87.27.2025.09.30.13.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:17:59 -0700 (PDT)
Date: Tue, 30 Sep 2025 23:17:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, jingoohan1@gmail.com, p.zabel@pengutronix.de,
        hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
        dianders@chromium.org, m.szyprowski@samsung.com,
        luca.ceresoli@bootlin.com, jani.nikula@intel.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 07/18] drm/exynos: exynos_dp: Apply legacy bridge to
 parse the display-timings node
Message-ID: <73bpf77trhqdo5amfxbn4qhlwf4ta7hmouwfen7m3aslycd3bj@72artzwafbmq>
References: <20250930090920.131094-1-damon.ding@rock-chips.com>
 <20250930090920.131094-8-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930090920.131094-8-damon.ding@rock-chips.com>
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68dc3afa cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=tHzXnULJKltlW3Z4dK8A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: VK27mPJDEoe5mvrSJhjzq_uTeqePxwsE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX5j7B+TZaBNFt
 Y7u960WRxdBV3SQ3Syc/MVAiLkZgAxl/FYvg3sM8Jl9eXbQUEnOeS28W+krExucVesdp27gT7rW
 bvysiJBgxNegimTvBRXquShF8jkR3hWx+d5clTaGPssiGNr4iRefALwtjV9FYU74EBW23bRl0HJ
 ZG/1UoDEPcFSReptDXBPkkZCWq100D1s3n6nmlAyhOXDJxdkgHsw29VN8GFmm1WFDHX0en/utOO
 99LSRkz/FbPSvKqNzBwqLkwWI2vU609u47D/XlDHG8ynTwypCWD9AOsuND+MP93RyRYtpg76Wt6
 Weoml7DBILYKbXtUiqbJVTkNmoAVMCaKjGkHamPyF/THcK9XCe1/6F14qVO6kNa7FlplJO1kCBG
 L8eNo6+IJREES+R4L60bciyptERFiw==
X-Proofpoint-ORIG-GUID: VK27mPJDEoe5mvrSJhjzq_uTeqePxwsE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On Tue, Sep 30, 2025 at 05:09:09PM +0800, Damon Ding wrote:
> If there is neither a panel nor a bridge, the display timing can be
> parsed from the display-timings node under the dp node.
> 
> In order to get rid of &analogix_dp_plat_data.get_modes() and make
> the codes more consistent, apply DRM legacy bridge to parse display
> timings.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> ------
> 
> Changes in v6:
> - Apply DRM legacy bridge to parse display timings intead of
>   implementing the same codes only for Exynos DP.
> ---
>  drivers/gpu/drm/exynos/Kconfig     |  1 +
>  drivers/gpu/drm/exynos/exynos_dp.c | 71 +++++++++---------------------
>  2 files changed, 22 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
> index 0d13828e7d9e..66665d317848 100644
> --- a/drivers/gpu/drm/exynos/Kconfig
> +++ b/drivers/gpu/drm/exynos/Kconfig
> @@ -72,6 +72,7 @@ config DRM_EXYNOS_DP
>  	select DRM_ANALOGIX_DP
>  	select DRM_DISPLAY_DP_HELPER
>  	default DRM_EXYNOS
> +	select DRM_LEGACY_BRIDGE
>  	select DRM_PANEL
>  	help
>  	  This enables support for DP device.
> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
> index e20513164032..507d0a98fe5b 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
> @@ -19,6 +19,7 @@
>  #include <video/videomode.h>
>  
>  #include <drm/bridge/analogix_dp.h>
> +#include <drm/bridge/legacy-bridge.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_crtc.h>
> @@ -38,11 +39,23 @@ struct exynos_dp_device {
>  	struct drm_device          *drm_dev;
>  	struct device              *dev;
>  
> -	struct videomode           vm;
>  	struct analogix_dp_device *adp;
>  	struct analogix_dp_plat_data plat_data;
>  };
>  
> +static int exynos_dp_legacy_bridge_init(struct exynos_dp_device *dp,
> +					struct drm_bridge **bridge)
> +{
> +	if (!bridge)
> +		return -EINVAL;

Well, this can't happen, can it?

> +
> +	*bridge = devm_drm_legacy_bridge(dp->dev, dp->dev->of_node, DRM_MODE_CONNECTOR_eDP);
> +	if (IS_ERR(*bridge))
> +		return PTR_ERR(*bridge);
> +
> +	return 0;
> +}

I'd suggest inlining the function. It doesn't make sense to have
one-line wrapper.

> +
>  static int exynos_dp_crtc_clock_enable(struct analogix_dp_plat_data *plat_data,
>  				bool enable)
>  {

[...]

>  static int exynos_dp_bridge_attach(struct analogix_dp_plat_data *plat_data,
>  				   struct drm_bridge *bridge,
>  				   struct drm_connector *connector)
>  {
>  	struct exynos_dp_device *dp = to_dp(plat_data);
> +	enum drm_bridge_attach_flags flags = 0;
>  	int ret;
>  
>  	/* Pre-empt DP connector creation if there's a bridge */
>  	if (plat_data->next_bridge) {
> -		ret = drm_bridge_attach(&dp->encoder, plat_data->next_bridge, bridge,
> -					0);
> +		if (drm_bridge_is_legacy(plat_data->next_bridge))

I see... You are going to kill this line in one of the next patches, but
the API will stay. I suggest adding a flag to the exynos_dp_device and
then removing the flag once you migrate to drm_bridge_connector.

> +			flags = DRM_BRIDGE_ATTACH_NO_CONNECTOR;
> +
> +		ret = drm_bridge_attach(&dp->encoder, plat_data->next_bridge, bridge, flags);
>  		if (ret)
>  			return ret;
>  	}

-- 
With best wishes
Dmitry

