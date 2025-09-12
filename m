Return-Path: <linux-kernel+bounces-813787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BA2B54AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F1B6803EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D7A2FF17B;
	Fri, 12 Sep 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IaVkP+Qq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5B92F3C2C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675254; cv=none; b=Q2mT9FOwtUvVRzPidITSeWG0KMcYqHsiybB2N7V1DYKF5hGEsmGQDdfClsLqBxlNdtvU3hxdcKUlV97dfMPt8wGbjbCrPWtK3focy189kqV1n39MXjaWqV10hIr+powaP53fIZc0xeLJiwHH26rp8WqmzIBy6H/QeC0SA0dTiXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675254; c=relaxed/simple;
	bh=n1rlD6zh8aCgRgvGePDHX/y4HVdSbut1KCX3GCzNwrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYoUbu7Z1LUVBdMSAsprfRSuRzatjq/MkMvnbw2vh4GiU3DUxvmiDfztHWnUPCIOpMyqvXtyy0YtEswG5Evb83RjdLqZHhj5oX0uuBGVR9JIQo1q/t1931UtTgfMApIEoNEbWT0+JhOWQYpTZdrSNmTJL5QqCd4A1ZCkaxbW/qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IaVkP+Qq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fEuZ001288
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Wuz/SrWcESRGcCo6gCYLmsKe
	MNM5PGRQfy8MjBCPiko=; b=IaVkP+QqorLtlosBQlebP9mE3Uv5KNkPPk1P8+JE
	Zq9dpAgX+ekM1Zs0k/O2YbThYvj3Sx0Qwp2kKBJaM3FvKYVmgHKgOeH58p9OkycZ
	+jzas3wHOArWzLbMyOid5tMhfksUCpGsj200QR7a93K17uIMHkWg+l+PDsf/cOEU
	/rFEnbA7GHi+j/STB5y8mnnmBF+wMs/fS4aZh4hxR0a9iSKfvZQ3hWSn+UgPmWMX
	vG619QtR/QeZ9jImLqttdZdEEsagjpIAtlT2EtoAU3Z7qNuXuJDHFMV4Kaomvq7Z
	kbsyNFy+0n6rbFNxRZEL2VMUyBx12fkNcEcRHGWBCnFhrA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493f6h6e0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:07:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b31bea5896so19214241cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757675251; x=1758280051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wuz/SrWcESRGcCo6gCYLmsKeMNM5PGRQfy8MjBCPiko=;
        b=FjdR/znZYcyCtRDKrlkaxRPMsYg8zK3HuSfGRdOwmZhDfD+tkeBojrvfaHkSETxfZa
         bcQs4ZEueCZsO93hWJ+E1wfxvtNBsg1KNzkOoHsCUYwny6QC6GJ+e+oQVwvhoVUVWdkU
         RuiWijHbI3ZWIjOfTaKupoSjBHUxMq5HYR78W8UPJV/JX54+orkzmOeWHxch6f8wL3in
         qSPe9qb5hrJ4D6lG0NB4/EHUbweQkiib4lp1SWKL/p5KyIbNpPl3oNMzkFkUUeohg0zZ
         BaViPwhNQKICWbRfxhtPGx4VWKy7fyBZ4eO+hl74szBM5EhvHMpQxZmdzczY8DBh1Qww
         zUbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXen/TOsu5TjYraNH9bMHtxRb7qmtPN7byOLJICiT+MDnOKfmGzdq7E1FrJOmUPbORdVi3N1QTjGxPuRaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgF7Ii2zk6G/L/YVZI9uSnpaD9k8JTOMvXVLESDT9hbyn5zvAR
	8LNcS+aIk3yIzoWPxj97dMcEMkC6bxpKuXjM8RysA+ph7rvLMMxmhy2xTZde7Xtu7h9Vf9REbmA
	4TxqbdqrR/IZ8zJOJTpAOjoeT4eVjY/aRCbqw/f44lQCe6KVW5wm4F9JwWyNEnP4SAds=
X-Gm-Gg: ASbGncssQEO4VnJEc/+nzkc3CyjoiRrl9lTnerGpBhUe+BClL5MIoF4deuJeaSwjrgy
	mVMO1GZpu8gNOuqfNn9jz8z/8c2h9fO0S5+iEmtIwzExH+Rpg8UrW/3xlZSaA1YV2wc99tQCkb/
	3Sv8SpKGe+LqBaQ+qpGyyakf2ST9us9a4pRBfrvJmjKgo8E5soLWSD3IW+QIsSPsEE0IwHNK/EV
	z+ToMC8NSxiCrF2z1cR9UF5P47Z9VnUGkVasF+KOlvGQrTAbcuzeN9ow0BlPuj0gWQ7bWN2iJrC
	rGKcE+y2XiHtXzHWkdRGDHQD103x/dOxCLrYyns5t/s64azO1tJKAO40DZ+DNGUDoScr7263Cr2
	5FoDKKljDi7HvR8Xty2wnxgpAGqgve4DkiGASCKH+3HfdYFnCQsVB
X-Received: by 2002:a05:622a:11:b0:4b4:9773:5866 with SMTP id d75a77b69052e-4b77d0c8726mr26900771cf.65.1757675250823;
        Fri, 12 Sep 2025 04:07:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEiDGwKFNmyX2dYy+yuf7JY3W0Iytw1CrXm3NUr783uLSdnhKB6N+spTNVyCrcHKwChFTEdw==
X-Received: by 2002:a05:622a:11:b0:4b4:9773:5866 with SMTP id d75a77b69052e-4b77d0c8726mr26900321cf.65.1757675250170;
        Fri, 12 Sep 2025 04:07:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a8211c9sm7300031fa.37.2025.09.12.04.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:07:29 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:07:26 +0300
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
Subject: Re: [PATCH v5 00/17] Apply drm_bridge_connector and panel_bridge
 helper for the Analogix DP driver
Message-ID: <s76pkp6cir2s2x6xzhnuhkmvirn3l7gnrhlpuachldbeqztwoo@xqnsyyjxctxy>
References: <20250912085846.7349-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912085846.7349-1-damon.ding@rock-chips.com>
X-Proofpoint-ORIG-GUID: WgsFcQY2WMTSl84nYnWmqqz40EK1h0z8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE3NyBTYWx0ZWRfX4oNYtmI3EEiM
 11TBAlpcAYVMPtKyO9+TwyxtE1jcNED9Sn4N8/3Bk4H5RujIRigvgiOThuZeCqcRhxbqWYWZJST
 f5O5gJLQgZX8FCJSmc2xn9wjKsVl8/sofN7r91OLDxfSyVdUTVGpt1JJkgX9RIH4IrBtrqf8HQc
 QVM9nMqpjJd5ds3TXKon/yrO3LAZwlo5r13VEuPkEqhAxtnda8DnPw74qjb+TvMtb2c6sRpxxyC
 B/niJYxRkkoumwgPM2v+oEdia52V2Hy4MTQ88tGvEkBE+gwDb7FVoucYKrHg4h+qPUV6LQ8GuaL
 gzHe/ZfnGUOOewvwdaXSJXNad8kJyeTEGvMCqj6jZn4JmD3MYwnEOTbGq157lC1doL9FMSoD1iO
 +XKLAq/x
X-Authority-Analysis: v=2.4 cv=WPB/XmsR c=1 sm=1 tr=0 ts=68c3fef4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=TUyDhR3qWEo6SlV7cHcA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: WgsFcQY2WMTSl84nYnWmqqz40EK1h0z8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100177

On Fri, Sep 12, 2025 at 04:58:29PM +0800, Damon Ding wrote:
> PATCH 1 is a small format optimization for struct analogid_dp_device.
> PATCH 2 is to perform mode setting in &drm_bridge_funcs.atomic_enable.
> PATCH 3-9 are preparations for apply drm_bridge_connector helper.
> PATCH 10 is to apply the drm_bridge_connector helper.
> PATCH 11-14 are to move the panel/bridge parsing to the Analogix side.
> PATCH 15-16 are preparations for apply panel_bridge helper.
> PATCH 17 is to apply the panel_bridge helper.
> 
> Damon Ding (17):
>   drm/bridge: analogix_dp: Formalize the struct analogix_dp_device
>   drm/bridge: analogix_dp: Move &drm_bridge_funcs.mode_set to
>     &drm_bridge_funcs.atomic_enable
>   drm/bridge: analogix_dp: Add &analogix_dp_plat_data.next_bridge
>   drm/exynos: exynos_dp: Remove &exynos_dp_device.ptn_bridge
>   drm/exynos: exynos_dp: Remove unused &exynos_dp_device.connector
>   drm/bridge: analogix_dp: Remove redundant
>     &analogix_dp_plat_data.skip_connector
>   drm/exynos: exynos_dp: Add legacy bridge to parse the display-timings
>     node
>   drm/bridge: analogix_dp: Move the color format check to
>     .atomic_check() for Rockchip platforms
>   drm/bridge: analogix_dp: Remove unused
>     &analogix_dp_plat_data.get_modes()
>   drm/bridge: analogix_dp: Apply drm_bridge_connector helper
>   drm/bridge: analogix_dp: Add new API analogix_dp_finish_probe()
>   drm/rockchip: analogix_dp: Apply analogix_dp_finish_probe()
>   drm/rockchip: analogix_dp: Apply &analogix_dp_plat_data.attach() to
>     attach next bridge
>   drm/exynos: exynos_dp: Apply analogix_dp_finish_probe()
>   drm/bridge: analogix_dp: Remove panel disabling and enabling in
>     analogix_dp_set_bridge()
>   drm/bridge: analogix_dp: Remove bridge disabing and panel unpreparing
>     in analogix_dp_unbind()
>   drm/bridge: analogix_dp: Apply panel_bridge helper

This patch didn't make it to the maling list.

> 
>  drivers/gpu/drm/bridge/analogix/Kconfig       |   1 +
>  .../drm/bridge/analogix/analogix_dp_core.c    | 394 ++++++++++--------
>  .../drm/bridge/analogix/analogix_dp_core.h    |   5 +-
>  drivers/gpu/drm/exynos/exynos_dp.c            | 168 ++++----
>  drivers/gpu/drm/rockchip/Kconfig              |   1 -
>  .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  74 ++--
>  include/drm/bridge/analogix_dp.h              |   9 +-
>  7 files changed, 342 insertions(+), 310 deletions(-)
> 
> ---
> 
> Changes in v2:
> - Update Exynos DP driver synchronously.
> - Move the panel/bridge parsing to the Analogix side.
> 
> Changes in v3:
> - Rebase for the existing devm_drm_bridge_alloc() applying commit.
> - Fix the typographical error of panel/bridge check in exynos_dp_bind().
> - Squash all commits related to skip_connector deletion in both Exynos and
>   Analogix code into one.
> - Apply panel_bridge helper to make the codes more concise.
> - Fix the handing of bridge in analogix_dp_bridge_get_modes().
> - Remove unnecessary parameter struct drm_connector* for callback
>   &analogix_dp_plat_data.attach().
> - In order to decouple the connector driver and the bridge driver, move
>   the bridge connector initilization to the Rockchip and Exynos sides.
> 
> Changes in v4:
> - Rebase for the applied &drm_bridge_funcs.detect() modification commit.
> - Rename analogix_dp_find_panel_or_bridge() to analogix_dp_finish_probe().
> - Drop the drmm_encoder_init() modification commit.
> - Rename the &analogix_dp_plat_data.bridge to
>   &analogix_dp_plat_data.next_bridge.
> 
> Changes in v5:
> - Add legacy bridge to parse the display-timings node under the dp node
>   for Exynos side.
> - Move color format check to &drm_connector_helper_funcs.atomic_check()
>   in order to get rid of &analogix_dp_plat_data.get_modes().
> - Remove unused callback &analogix_dp_plat_data.get_modes().
> - Distinguish the &drm_bridge->ops of Analogix bridge based on whether
>   the downstream device is a panel, a bridge or neither.
> - Select DRM_DISPLAY_DP_AUX_BUS for DRM_ANALOGIX_DP, and remove it for
>   ROCKCHIP_ANALOGIX_DP.
> - Apply rockchip_dp_attach() to support the next bridge attachment for
>   the Rockchip side.
> - Move next_bridge attachment from Analogix side to Rockchip/Exynos sides.
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

