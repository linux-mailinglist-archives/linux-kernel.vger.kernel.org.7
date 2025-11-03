Return-Path: <linux-kernel+bounces-882261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7FEC2A027
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 05:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D01584EAC2E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 04:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700B3289374;
	Mon,  3 Nov 2025 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OtM8VIIu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ayl8dtNe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAE9AD2C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762142466; cv=none; b=YImDTnOLl/ZJLNcr5bqiWj/DDOTekREnTggR3s4pxGKl4gBfoIKx/4L+yoEnxT1gQwgZMCptnF9AqXIE6n0PylZJMyu1xmXbN1G2gHbLXj1/q9z3W0NGf3iHWN5u3g9JjTSI5gRkYAG+68SJcBzCvFvJIHNyijnbo0pftnabbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762142466; c=relaxed/simple;
	bh=KTCHBedtUTHPyNKGUiRPC+ZB2Ima8y1JyHWnOajzTUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDPK9qza/vIrqOdxgoIXMtYlStOPUZUEeeJh+psp1JEqWoyE7sylvBYfdiDkcvX7B0ktQcoK3EEjS6MlPY6xSPbUfFOIxHiaFmRVVGurK42vnkB5qBAdm8tQB6XeL6MvCVVWKW88/jsWXL0ihaffwtojpNwPTygQ5Wb7KvmmC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OtM8VIIu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ayl8dtNe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2M8vux1224589
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 04:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BqZVWtvZB01lHMDhWvhuziwX
	8RpB8DpNtZTndZIHXgg=; b=OtM8VIIu6EV3q/gqLC//i4PeKqEI+2AfaAF8ucL3
	S66Amy+FETzxX+5JJll3ntgww8612f4zgviKNMywRr7jJU+4qRSIcI6N4OIU2m1b
	zrxujBLtb8L5V7+I3Es8WP/bLNViZsE9LvMnO0E8RtkH4DuzwekgqUJ4BdVohf45
	qYy54hUio7x+YtsvAMk5G6hLved7G9UORlagsuhq4X77FZ5VfMh0IIFQaNfMAY3R
	eEFVJLAVkOXsCXIRXOB1TzZCT2Yu95JMOiAa1Pxwr/XS6/cIFz4RZJM6xvn8n9zt
	+YWXUTeGOynuPD8POgLOThRtnoUrESjo9Jf4i6oHsWRd7A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6f0w8hub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:01:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4eb9e480c15so60791111cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 20:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762142461; x=1762747261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BqZVWtvZB01lHMDhWvhuziwX8RpB8DpNtZTndZIHXgg=;
        b=Ayl8dtNevrPJ84j984oSFdmPuuqLOElWMxEPBVX47vDAW26Zbk5O2pM0MRsmcAo6HN
         CKWXqshz05X0DGHjxAOVFzobBiV+iRxaDwR5AcdB+R+RKEels/KFUFn2c7WcHVA45tzz
         10QetpimPTWvd/hxPur0+pbfHser2IxRxpgxa6A8RtsXl8mKbArsvA2bjOXeVHXZxxrH
         +7FEkb44VIP1IXjnrR+KhMS9NvOgYj29oFao/bdprsgaUNpRIRv7DeEEt3oCmxbuXZdn
         prh5+JZ+7zLXmaQkhN5vQugnfbrgKgw5OPtVs3XkKiTPgsBUrOvxdZnxNuplokbyVTRb
         FEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762142461; x=1762747261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqZVWtvZB01lHMDhWvhuziwX8RpB8DpNtZTndZIHXgg=;
        b=Av8IM3zmNshGEzOKmxxuUiLeYnm/n2Oxox4yRROntPyw81foevzTS1B2+PuRJwbUJu
         z8v0RqbgYIwFCpaM+0lEfotrt5hf7JNFBNZOWWACaKIxX+dEzMKINv9Ik6N+iyTjyjTd
         lz0LjE9i1N/AyHsWBex3nQYYa+p8njMF/2wZQlJ2RBbK39W3E2vYTym4cbfBPjIaflew
         0JPn5t5PLeGlF1zJL3/gGdArIvlx8BW74w5NqmKl6q5ZVn53TsaPdi0ShmS6eNr10nBg
         BDYdUlbJWpgCIzwIYD7MLFqgMFvDflN2nzO8WgEq2FVdsthKSlvj1FjP/xg6siduJVmu
         qYEA==
X-Forwarded-Encrypted: i=1; AJvYcCWAkD/rlPn2OWfgd4jCQUx22C3iJlc3an5SfusGg82poiLlfNHR+D4n41+EJ4q7AiLtx2+/fWONd20Frf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznA/ZOzHL6pxdsXFlSelBv5xlVPcOSB1PNJ4OYUXPxpGc+qtdy
	DuHyR8T6D3YariNHfnP7B8OejMKwozfnlxR9qhaSUDw6zyEb65CHmDtfHTNdq/ZRqzxrbUM+Cyc
	3SJQurTqojeVaFrDZgZ0PtT6mxiz6xuIVE2E7Lf0o0Mt/5GMZHOn0rS8brcA17sbsNfo=
X-Gm-Gg: ASbGnctSRSfDw+XmGVn85iY96ggUvWQuIFYb5fLNVVo2+lmUyoIb7fvDDWfPMtoFfhy
	qdgcSKZPnjZL0prT6WRpukhZ/kvZ5caYXIMiorJ9VOjhlonw8krCzLoYCOPGC0phkF/zt+m9wI1
	OPtxdujx2pBtSQhrm64ZE57VB2p3uRj9zk0wQ23pJKDIGjtem1qz0kthT/xq1bpiigBmcqoyy2g
	T6OqJS9C/TRMudnE3DDmhCVvYwemuB2johTGB2tLyH6VRcpaowP2qB416y7UJ3ZwolzZfSOrG1e
	K3E5HUYB2iZNghPu32L64BgA+jwaOAtUnFQBTa7GeOBSwzx5hdTAsTvDMeIpxh6C/a18bPvTMcm
	0u5uY5nf3lYVIN9wvnHrPJw6ftjc1bx4x3tf6mXrmvmmIjUWYz+1mBubA9Jm8axuIgAcq3yDJAo
	rJyRc77qSyB78T
X-Received: by 2002:a05:622a:986:b0:4e7:2844:b5ba with SMTP id d75a77b69052e-4ed30df358amr162632171cf.27.1762142461163;
        Sun, 02 Nov 2025 20:01:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgslzu3J94CkQXnMCfCenunuSO8sFC/hoLWJyhjIPrs3wspZRnHXndVjUUPy44N7dZHlcIHA==
X-Received: by 2002:a05:622a:986:b0:4e7:2844:b5ba with SMTP id d75a77b69052e-4ed30df358amr162631081cf.27.1762142460117;
        Sun, 02 Nov 2025 20:01:00 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a1c0baabcsm20998571fa.43.2025.11.02.20.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 20:00:59 -0800 (PST)
Date: Mon, 3 Nov 2025 06:00:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Yubing Zhang <yubing.zhang@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Amit Sunil Dhamne <amitsd@google.com>,
        Chaoyi Chen <chaoyi.chen@rock-chips.com>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 03/10] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
Message-ID: <rzozpbqmymdczerh3iijxxtz3xnsznoku7w2mquikwv6u5osvo@7h43hwc2fpzm>
References: <20251029071435.88-1-kernel@airkyi.com>
 <20251029071435.88-4-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029071435.88-4-kernel@airkyi.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDAzNCBTYWx0ZWRfX+gc+s1dRa1al
 SfwcygrggpUy7O4xTAzRhJG6HZVp+5NFHQWPjCbb7oICifm1a9hEVd5xqnZeZPRaJlAGpkhDprj
 3YLH0kvKFJIDYu6qSwTN2NFPsYZlSYypzM80gQLzDadZuJahTknWk3thmz0+WLLyZzG6YE9tPo1
 bszwbffW4FVYVDZziP8oyd0eu7CSYyIkHydYc5umOXEE9OZEbbv/NeR6hmtra22BOFrYVyj9vtA
 7qPTWDBUBtYBTBPF0ohEX5XnuiE/HoovQkZW8O74xEk7Z66umXFpQQmPhXDksfFSHLOhaMQfrUz
 SNGnPZyk54p1pVvXaCQHjaPE0N/TMniGkZ+U+VR6gHmTHSlu40r5F/d1oRg+dm+Tq8YOQS8fqep
 9nhV2HTf0pDmFEuwj5/0KT05u0CgQQ==
X-Authority-Analysis: v=2.4 cv=LcAxKzfi c=1 sm=1 tr=0 ts=690828fe cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=s8YR1HE3AAAA:8 a=KKAkSRfTAAAA:8 a=GMWCpaOuOXG1PATvt-oA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=jGH_LyMDp9YhSvY-UuyI:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: lYHQNbtg7217PlWqMMpKCozlpA3Pa9o_
X-Proofpoint-GUID: lYHQNbtg7217PlWqMMpKCozlpA3Pa9o_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030034

On Wed, Oct 29, 2025 at 03:14:28PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> Several USB-C controller drivers have already implemented the DP HPD
> bridge function provided by aux-hpd-bridge.c, but there are still
> some USB-C controller driver that have not yet implemented it.
> 
> This patch implements a generic DP HPD bridge based on aux-hpd-bridge.c,
> so that other USB-C controller drivers don't need to implement it again.

This doesn't describe the problem that you are trying to solve.

> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
> 
> Changes in v8:
> - Merge generic DP HPD bridge into one module.
> 
>  drivers/gpu/drm/bridge/Kconfig                |  5 +-
>  drivers/gpu/drm/bridge/Makefile               |  8 +++-
>  drivers/gpu/drm/bridge/aux-hpd-bridge.c       | 23 ++++++++-
>  drivers/gpu/drm/bridge/aux-hpd-bridge.h       | 13 +++++
>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 47 +++++++++++++++++++
>  5 files changed, 93 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-bridge.h
>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index a250afd8d662..17257b223a28 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -23,13 +23,16 @@ config DRM_AUX_BRIDGE
>  	  build bridges chain.
>  
>  config DRM_AUX_HPD_BRIDGE
> -	tristate
> +	tristate "AUX HPD bridge support"

Why? No, this is supposed to be selected by other drivers. Users don't
know an wouldn't know what is this.

>  	depends on DRM_BRIDGE && OF
>  	select AUXILIARY_BUS
>  	help
>  	  Simple bridge that terminates the bridge chain and provides HPD
>  	  support.
>  
> +	  Specifically, if you want a default Type-C DisplayPort HPD bridge for
> +	  each port of the Type-C controller, say Y here.
> +
>  menu "Display Interface Bridges"
>  	depends on DRM && DRM_BRIDGE
>  
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index c7dc03182e59..2998937444bc 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,6 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_DRM_AUX_BRIDGE) += aux-bridge.o
> -obj-$(CONFIG_DRM_AUX_HPD_BRIDGE) += aux-hpd-bridge.o
> +
> +hpd-bridge-y := aux-hpd-bridge.o
> +ifneq ($(CONFIG_TYPEC),)
> +hpd-bridge-y += aux-hpd-typec-dp-bridge.o
> +endif
> +obj-$(CONFIG_DRM_AUX_HPD_BRIDGE) += hpd-bridge.o
> +
>  obj-$(CONFIG_DRM_CHIPONE_ICN6211) += chipone-icn6211.o
>  obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
>  obj-$(CONFIG_DRM_CROS_EC_ANX7688) += cros-ec-anx7688.o
> diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> index 2e9c702c7087..11ad6dc776c7 100644
> --- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> +++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> @@ -12,6 +12,8 @@
>  #include <drm/drm_bridge.h>
>  #include <drm/bridge/aux-bridge.h>
>  
> +#include "aux-hpd-bridge.h"
> +
>  static DEFINE_IDA(drm_aux_hpd_bridge_ida);
>  
>  struct drm_aux_hpd_bridge_data {
> @@ -204,7 +206,26 @@ static struct auxiliary_driver drm_aux_hpd_bridge_drv = {
>  	.id_table = drm_aux_hpd_bridge_table,
>  	.probe = drm_aux_hpd_bridge_probe,
>  };
> -module_auxiliary_driver(drm_aux_hpd_bridge_drv);
> +
> +static int drm_aux_hpd_bridge_mod_init(void)
> +{
> +	int ret;
> +
> +	ret = auxiliary_driver_register(&drm_aux_hpd_bridge_drv);
> +	if (ret)
> +		return ret;
> +
> +	return drm_aux_hpd_typec_dp_bridge_init();
> +}
> +
> +static void drm_aux_hpd_bridge_mod_exit(void)
> +{
> +	drm_aux_hpd_typec_dp_bridge_exit();
> +	auxiliary_driver_unregister(&drm_aux_hpd_bridge_drv);
> +}
> +
> +module_init(drm_aux_hpd_bridge_mod_init);
> +module_exit(drm_aux_hpd_bridge_mod_exit);
>  
>  MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
>  MODULE_DESCRIPTION("DRM HPD bridge");
> diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.h b/drivers/gpu/drm/bridge/aux-hpd-bridge.h
> new file mode 100644
> index 000000000000..69364731c2f1
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef AUX_HPD_BRIDGE_H
> +#define AUX_HPD_BRIDGE_H
> +
> +#if IS_REACHABLE(CONFIG_TYPEC)
> +int drm_aux_hpd_typec_dp_bridge_init(void);
> +void drm_aux_hpd_typec_dp_bridge_exit(void);
> +#else
> +static inline int drm_aux_hpd_typec_dp_bridge_init(void) { return 0; }
> +static inline void drm_aux_hpd_typec_dp_bridge_exit(void) { }
> +#endif /* IS_REACHABLE(CONFIG_TYPEC) */
> +
> +#endif /* AUX_HPD_BRIDGE_H */
> diff --git a/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> new file mode 100644
> index 000000000000..6f2a1fca0fc5
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <linux/of.h>
> +#include <linux/usb/typec_altmode.h>
> +#include <linux/usb/typec_dp.h>
> +#include <linux/usb/typec_notify.h>
> +
> +#include <drm/bridge/aux-bridge.h>
> +
> +#include "aux-hpd-bridge.h"
> +
> +#if IS_REACHABLE(CONFIG_TYPEC)
> +static int drm_typec_bus_event(struct notifier_block *nb,
> +			       unsigned long action, void *data)
> +{

This feels like this should be a part of the Type-C subsystem rather
than DRM.

> +	struct typec_altmode *alt = (struct typec_altmode *)data;
> +
> +	if (action != TYPEC_ALTMODE_REGISTERED)
> +		goto done;
> +
> +	if (is_typec_partner(&alt->dev) || alt->svid != USB_TYPEC_DP_SID)
> +		goto done;
> +
> +	/*
> +	 * alt->dev.parent->parent : USB-C controller device
> +	 * alt->dev.parent         : USB-C connector device
> +	 */
> +	drm_dp_hpd_bridge_register(alt->dev.parent->parent,
> +				   to_of_node(alt->dev.parent->fwnode));
> +
> +done:
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block drm_typec_event_nb = {
> +	.notifier_call = drm_typec_bus_event,
> +};
> +
> +int drm_aux_hpd_typec_dp_bridge_init(void)
> +{
> +	return typec_altmode_register_notify(&drm_typec_event_nb);
> +}
> +
> +void drm_aux_hpd_typec_dp_bridge_exit(void)
> +{
> +	typec_altmode_unregister_notify(&drm_typec_event_nb);
> +}
> +#endif
> -- 
> 2.49.0
> 

-- 
With best wishes
Dmitry

