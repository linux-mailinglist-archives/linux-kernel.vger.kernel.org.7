Return-Path: <linux-kernel+bounces-772177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C258BB28F98
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 18:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BE21891320
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EA32E2EF1;
	Sat, 16 Aug 2025 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eviCU05i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12B2E5D00
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755362646; cv=none; b=CsedCEHxN/KRZl7v4M/yOGdKFvHpQeuuiFca4e4ZQCcYGKE7Rw1170u5JYpZNfNVsOR9gTZ379C0HSG3ThrVeB7s4cNxMUuyzgjuOYsrfHygP4K4iTk4YNcp7rJbWMyaarMtcUAajnnaUgvgJcGvcMf4TSKrGRP6Iv27HbmSUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755362646; c=relaxed/simple;
	bh=M1v9jE8zv5ZlP4USgnNp//k3jmeRXqSFG0BlEJ0NjZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RErrDB7x6NvRpwvfoH2weoRD60wZS6zii/ayz49fLpmN/TRiatIMr/BkRb6ouFH9rOtyg8J4fcfl4n2PPnvJBnZMBdhSrYysHml5nZp9D8y8fBZ5fACf6/64IMC9KCs4v0kQCvlJDhtbnyYvxo1nG1pJTLnFQuRt3LOhP45GZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eviCU05i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57GFurdm024945
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 16:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=a/ND+XYFn3bL2xeCI3dtf6zp
	ZRcNozLAv93BypE9ZnA=; b=eviCU05iYpXey7dc7sazo4iNuti+3tBp1aPPfcvI
	Rua2duSY7N74qH4pxfNzd1vSHtBfkpijRKRXrht5BKU/okzZ681C9hZZKjVhbZts
	7amj4OkSuzLSKTJ9mxLyB4ICXA2MBiUhZ9deQWiv8TE+QLRrrSy4tf85yo17Gn9s
	2oqwdOiJDIJTy35WhSZ7gj3Ud/f2t+rDKlweQxBMnSwvqsjkF4I/zqM+EUd311Sh
	k6Wv37EjbJiV3tg7dOIUWUFZx6L4bXu35+agW68JzEZOLm84oSQBM+kd8VPbGOix
	4YTAQSTHyM9o0jevVHt7vzHeQBVyQ76Tha57t2dnEQBRFQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj740wbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 16:44:03 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9f57ef93so59243406d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 09:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755362642; x=1755967442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/ND+XYFn3bL2xeCI3dtf6zpZRcNozLAv93BypE9ZnA=;
        b=lYwyM3GiLcKWesHIy7P8ARWnHbduOClLBL+bah8bY1GypSL24/NvemqW8iwnm5noNk
         8yB5ABlFOQ0g4l3jRSmx9NYnxLkZG/5MDcbIfTjZ7aCEDkXv+4IMjpAVjukgGKDlwpum
         FpZJoJflul6+K5uv7sEEP6hXHdeoQ3gb9I9yjSZ3hFLciOmn53zVXz0Aym+wXzSQHTwE
         hRAs4mOKcec9stVn9jE9rIBQHffjXo68N2oxuM2F7e+y58UUDFiRoo6MoGgKLVq0edbu
         aK0Y1zmz2ydn1LK2Xio4hqSzuWFXVLdG0osiTV9Bz6Dn3ZABy9D/0PQ36mBmi6gRQv8D
         JQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa1sQLZDyRLB+m57YDK9cXCZtgk1LPpNMfq+lL2fKz1DM3A7QrdATFx5+gtlgFK/xopAHX+TIDcruAryE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXS1v40LX3IShmh09RKjrAGQz3zDHgR5HhEyg1kV04OKJ8F0dD
	9Ceh6ZTtoWeOQNyKCNkWsvCD2XPViybs8oZ3Sg+63LvVp2bnBdfnnunZCmOIpXmqqaBe9jlKt5M
	bAOLdYhgd2vLR/PhqFAcCbjSigUek5n8pA8LoEDxj3HlfEb/ylVOArIllMV3JEKpIR7U=
X-Gm-Gg: ASbGncvmwWViLOWmUZqtPE54tPQdaZcRJzCgx1okBPWeNOCWb0PmX9UJz5iyEC9APlj
	GYn6VhZ3MfH0wmIzbzCIpL6sxSUcnho4FI0iyp4jtvNdxPrKybZyHu6vQ48nIvuR891x1Z5fUMh
	pOS4QsTtF5WRyy0kklL5fnTAU1cXV9ciKel2EBRvFVsCShX+NcO/M30OfE+234Cxv4k/ZFI41pi
	w6NZQIo55Zx8PjqoqIBL2HGdEhHuF8K2ttUqfbTwa00lbGQmkzXXjBeL7pAlIBBS4dxUhdwh7Db
	YckTd2nBE6p9aUigu82XFmQ0cme/ysIajsqCSU2bA2ZnKvWnTDxelCVZshaf5IXE1+JnXLChF0s
	fQCmLQ5x38yr5UQ62MAUlYItpsqKgFB0+2IrkaReL3Yrja1ridNLs
X-Received: by 2002:a05:6214:20a3:b0:709:b6a7:5f16 with SMTP id 6a1803df08f44-70ba7bdbf6cmr79169186d6.28.1755362642254;
        Sat, 16 Aug 2025 09:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtpiAuhV34fMzTAghfd19E6ldXdihh8WZnwVajDj9v8RLDbwhpqckO6fSzgT61D94aqN7wwQ==
X-Received: by 2002:a05:6214:20a3:b0:709:b6a7:5f16 with SMTP id 6a1803df08f44-70ba7bdbf6cmr79168496d6.28.1755362641652;
        Sat, 16 Aug 2025 09:44:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a645fcbsm10108661fa.69.2025.08.16.09.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 09:43:59 -0700 (PDT)
Date: Sat, 16 Aug 2025 19:43:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jingoohan1@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, hjc@rock-chips.com, heiko@sntech.de,
        andy.yan@rock-chips.com, l.stach@pengutronix.de, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 07/13] drm/bridge: analogix_dp: Apply
 drm_bridge_connector helper
Message-ID: <incxmqneeurgli5h6p3hn3bgztxrzyk5eq2h5nq4lgzalohslq@mvehvr4cgyim>
References: <20250814104753.195255-1-damon.ding@rock-chips.com>
 <20250814104753.195255-8-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814104753.195255-8-damon.ding@rock-chips.com>
X-Proofpoint-GUID: Bsx-hZ8Fl1_ANf4aoCcxCwyqNBtQGdTb
X-Proofpoint-ORIG-GUID: Bsx-hZ8Fl1_ANf4aoCcxCwyqNBtQGdTb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfXz7g0z26nxg6F
 R5qQHiH2KJFgfL8Dxo/AzQd2O8m7YHxOPeglfPO5XFTCIfBCMCqJhyAwj5lRUcuC/N+Ot5PHikV
 q6WnC6l0BGgsoVfFdNK4X+2jjdCiRJADLkppOjg9oJNmUH/2XSI/p5mRKSO/VOCu+KydnMRHis2
 7hy5Zb7dJA50OfvmqtqkNVM6B0w/wDUzl7mI/jqFkkO4zmDpHkkiH74ygQbD4XXgQRFRXSKl8RU
 TUQNORIuZ8OW/ViSfl7uutgzmg0WpiibMzPAwe/a983tPueMTZyHtCuW+dWQ+Na8KABZA9Ed/OJ
 +5bvpNb01+AtboD39iGerl6ZLalrUL1ZA/B1jHW+7ymTJpUtp5vzxvzO6pvX5C7+R8zw2rawZVP
 V2APJJ/d
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a0b553 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=s8YR1HE3AAAA:8 a=CixiMOkOpjwi1I4l6n8A:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033

On Thu, Aug 14, 2025 at 06:47:47PM +0800, Damon Ding wrote:
> Apply drm_bridge_connector helper for Analogix DP driver.
> 
> The following changes have been made:
> - Apply drm_bridge_connector helper to get rid of &drm_connector_funcs
>   and &drm_connector_helper_funcs.
> - Remove unnecessary parameter struct drm_connector* for callback
>   &analogix_dp_plat_data.attach.
> - Remove &analogix_dp_device.connector.
> - Convert analogix_dp_atomic_check()/analogix_dp_detect() to
>   &drm_bridge_funcs.atomic_check()/&drm_bridge_funcs.detect().
> - Split analogix_dp_get_modes() into &drm_bridge_funcs.get_modes() and
>   &drm_bridge_funcs.edid_read().
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> ------
> 
> Changes in v2:
> - For &drm_bridge.ops, remove DRM_BRIDGE_OP_HPD and add
>   DRM_BRIDGE_OP_EDID.
> - Add analogix_dp_bridge_edid_read().
> - Move &analogix_dp_plat_data.skip_connector deletion to the previous
>   patches.
> 
> Changes in v3:
> - Rebase with the new devm_drm_bridge_alloc() related commit
>   48f05c3b4b70 ("drm/bridge: analogix_dp: Use devm_drm_bridge_alloc()
>   API").
> - Expand the commit message.
> - Call drm_bridge_get_modes() in analogix_dp_bridge_get_modes() if the
>   bridge is available.
> - Remove unnecessary parameter struct drm_connector* for callback
>   &analogix_dp_plat_data.attach.
> - In order to decouple the connector driver and the bridge driver, move
>   the bridge connector initilization to the Rockchip and Exynos sides.
> 
> Changes in v4:
> - Expand analogix_dp_bridge_detect() parameters to &drm_bridge and
>   &drm_connector.
> - Rename the &analogix_dp_plat_data.bridge to
>   &analogix_dp_plat_data.next_bridge.
> ---
>  .../drm/bridge/analogix/analogix_dp_core.c    | 145 ++++++++----------
>  .../drm/bridge/analogix/analogix_dp_core.h    |   1 -
>  drivers/gpu/drm/exynos/exynos_dp.c            |  18 ++-
>  .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  11 +-
>  include/drm/bridge/analogix_dp.h              |   3 +-
>  5 files changed, 88 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 7876b310aaed..a8ed44ec8ef5 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -947,24 +947,16 @@ static int analogix_dp_disable_psr(struct analogix_dp_device *dp)
>  	return analogix_dp_send_psr_spd(dp, &psr_vsc, true);
>  }
>  
> -static int analogix_dp_get_modes(struct drm_connector *connector)
> +static int analogix_dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connector *connector)
>  {
> -	struct analogix_dp_device *dp = to_dp(connector);
> -	const struct drm_edid *drm_edid;
> +	struct analogix_dp_device *dp = to_dp(bridge);
>  	int num_modes = 0;
>  
> -	if (dp->plat_data->panel) {
> +	if (dp->plat_data->panel)
>  		num_modes += drm_panel_get_modes(dp->plat_data->panel, connector);
> -	} else {
> -		drm_edid = drm_edid_read_ddc(connector, &dp->aux.ddc);
>  
> -		drm_edid_connector_update(&dp->connector, drm_edid);
> -
> -		if (drm_edid) {
> -			num_modes += drm_edid_connector_add_modes(&dp->connector);
> -			drm_edid_free(drm_edid);
> -		}
> -	}
> +	if (dp->plat_data->next_bridge)
> +		num_modes += drm_bridge_get_modes(dp->plat_data->next_bridge, connector);

If there is a next bridge which provides OP_MODES, then
drm_bridge_connector will use it for get_modes() and skip this one
completely. I'm not sure what's the value of this call.

>  
>  	if (dp->plat_data->get_modes)
>  		num_modes += dp->plat_data->get_modes(dp->plat_data, connector);
> @@ -972,51 +964,39 @@ static int analogix_dp_get_modes(struct drm_connector *connector)
>  	return num_modes;
>  }
>  
> -static struct drm_encoder *
> -analogix_dp_best_encoder(struct drm_connector *connector)
> +static const struct drm_edid *analogix_dp_bridge_edid_read(struct drm_bridge *bridge,
> +							   struct drm_connector *connector)
>  {
> -	struct analogix_dp_device *dp = to_dp(connector);
> +	struct analogix_dp_device *dp = to_dp(bridge);
> +	const struct drm_edid *drm_edid = NULL;
>  
> -	return dp->encoder;
> -}
> +	drm_edid = drm_edid_read_ddc(connector, &dp->aux.ddc);
>  
> +	if (dp->plat_data->get_modes)
> +		dp->plat_data->get_modes(dp->plat_data, connector);


So, we have DDC, but we still want to return platform modes? What is the
usecase for that?

There might be some, but I think it deserves a comment in the source
file.

>  
> -static int analogix_dp_atomic_check(struct drm_connector *connector,
> -				    struct drm_atomic_state *state)
> -{
> -	struct analogix_dp_device *dp = to_dp(connector);
> -	struct drm_connector_state *conn_state;
> -	struct drm_crtc_state *crtc_state;
> +	return drm_edid;
> +}
>  
> -	conn_state = drm_atomic_get_new_connector_state(state, connector);
> -	if (WARN_ON(!conn_state))
> -		return -ENODEV;
> +static int analogix_dp_bridge_atomic_check(struct drm_bridge *bridge,
> +					   struct drm_bridge_state *bridge_state,
> +					   struct drm_crtc_state *crtc_state,
> +					   struct drm_connector_state *conn_state)
> +{
> +	struct analogix_dp_device *dp = to_dp(bridge);
>  
>  	conn_state->self_refresh_aware = true;
>  
> -	if (!conn_state->crtc)
> -		return 0;
> -
> -	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
> -	if (!crtc_state)
> -		return 0;
> -
>  	if (crtc_state->self_refresh_active && !dp->psr_supported)
>  		return -EINVAL;
>  
>  	return 0;
>  }
>  
> -static const struct drm_connector_helper_funcs analogix_dp_connector_helper_funcs = {
> -	.get_modes = analogix_dp_get_modes,
> -	.best_encoder = analogix_dp_best_encoder,
> -	.atomic_check = analogix_dp_atomic_check,
> -};
> -
>  static enum drm_connector_status
> -analogix_dp_detect(struct drm_connector *connector, bool force)
> +analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
>  {
> -	struct analogix_dp_device *dp = to_dp(connector);
> +	struct analogix_dp_device *dp = to_dp(bridge);
>  	enum drm_connector_status status = connector_status_disconnected;
>  
>  	if (dp->plat_data->panel)
> @@ -1028,21 +1008,11 @@ analogix_dp_detect(struct drm_connector *connector, bool force)
>  	return status;
>  }
>  
> -static const struct drm_connector_funcs analogix_dp_connector_funcs = {
> -	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.detect = analogix_dp_detect,
> -	.destroy = drm_connector_cleanup,
> -	.reset = drm_atomic_helper_connector_reset,
> -	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> -	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> -};
> -
>  static int analogix_dp_bridge_attach(struct drm_bridge *bridge,
>  				     struct drm_encoder *encoder,
>  				     enum drm_bridge_attach_flags flags)
>  {
>  	struct analogix_dp_device *dp = to_dp(bridge);
> -	struct drm_connector *connector = NULL;
>  	int ret = 0;
>  
>  	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
> @@ -1050,31 +1020,8 @@ static int analogix_dp_bridge_attach(struct drm_bridge *bridge,
>  		return -EINVAL;
>  	}
>  
> -	if (!dp->plat_data->next_bridge) {
> -		connector = &dp->connector;
> -		connector->polled = DRM_CONNECTOR_POLL_HPD;
> -
> -		ret = drm_connector_init(dp->drm_dev, connector,
> -					 &analogix_dp_connector_funcs,
> -					 DRM_MODE_CONNECTOR_eDP);
> -		if (ret) {
> -			DRM_ERROR("Failed to initialize connector with drm\n");
> -			return ret;
> -		}
> -
> -		drm_connector_helper_add(connector,
> -					 &analogix_dp_connector_helper_funcs);
> -		drm_connector_attach_encoder(connector, encoder);
> -	}
> -
> -	/*
> -	 * NOTE: the connector registration is implemented in analogix
> -	 * platform driver, that to say connector would be exist after
> -	 * plat_data->attch return, that's why we record the connector
> -	 * point after plat attached.
> -	 */
>  	if (dp->plat_data->attach) {
> -		ret = dp->plat_data->attach(dp->plat_data, bridge, connector);
> +		ret = dp->plat_data->attach(dp->plat_data, bridge);
>  		if (ret) {
>  			DRM_ERROR("Failed at platform attach func\n");
>  			return ret;
> @@ -1178,14 +1125,21 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
>  }
>  
>  static void analogix_dp_bridge_mode_set(struct drm_bridge *bridge,
> +					struct drm_atomic_state *state,
>  					const struct drm_display_mode *mode)
>  {
>  	struct analogix_dp_device *dp = to_dp(bridge);
> -	struct drm_display_info *display_info = &dp->connector.display_info;
>  	struct video_info *video = &dp->video_info;
>  	struct device_node *dp_node = dp->dev->of_node;
> +	struct drm_connector *connector;
> +	struct drm_display_info *display_info;
>  	int vic;
>  
> +	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
> +	if (!connector)
> +		return;
> +	display_info = &connector->display_info;
> +
>  	/* Input video interlaces & hsync pol & vsync pol */
>  	video->interlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
>  	video->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NVSYNC);
> @@ -1269,7 +1223,7 @@ static void analogix_dp_bridge_atomic_enable(struct drm_bridge *bridge,
>  	new_crtc_state = drm_atomic_get_new_crtc_state(old_state, crtc);
>  	if (!new_crtc_state)
>  		return;
> -	analogix_dp_bridge_mode_set(bridge, &new_crtc_state->adjusted_mode);
> +	analogix_dp_bridge_mode_set(bridge, old_state, &new_crtc_state->adjusted_mode);
>  
>  	old_crtc_state = drm_atomic_get_old_crtc_state(old_state, crtc);
>  	/* Not a full enable, just disable PSR and continue */
> @@ -1385,7 +1339,11 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
>  	.atomic_enable = analogix_dp_bridge_atomic_enable,
>  	.atomic_disable = analogix_dp_bridge_atomic_disable,
>  	.atomic_post_disable = analogix_dp_bridge_atomic_post_disable,
> +	.atomic_check = analogix_dp_bridge_atomic_check,
>  	.attach = analogix_dp_bridge_attach,
> +	.get_modes = analogix_dp_bridge_get_modes,
> +	.edid_read = analogix_dp_bridge_edid_read,
> +	.detect = analogix_dp_bridge_detect,
>  };
>  
>  static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
> @@ -1615,6 +1573,7 @@ EXPORT_SYMBOL_GPL(analogix_dp_resume);
>  
>  int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
>  {
> +	struct drm_bridge *bridge = &dp->bridge;
>  	int ret;
>  
>  	dp->drm_dev = drm_dev;
> @@ -1628,7 +1587,16 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
>  		return ret;
>  	}
>  
> -	ret = drm_bridge_attach(dp->encoder, &dp->bridge, NULL, 0);
> +	bridge->ops = DRM_BRIDGE_OP_DETECT |
> +		      DRM_BRIDGE_OP_EDID |

Should this be limited to the !panel cases? Otherwise OP_EDID overrides
OP_MODES and the analogix_dp_bridge_get_modes() will never be called.

> +		      DRM_BRIDGE_OP_MODES;
> +	bridge->of_node = dp->dev->of_node;
> +	bridge->type = DRM_MODE_CONNECTOR_eDP;
> +	ret = devm_drm_bridge_add(dp->dev, &dp->bridge);
> +	if (ret)
> +		goto err_unregister_aux;
> +
> +	ret = drm_bridge_attach(dp->encoder, bridge, NULL, 0);
>  	if (ret) {
>  		DRM_ERROR("failed to create bridge (%d)\n", ret);
>  		goto err_unregister_aux;
> @@ -1646,7 +1614,6 @@ EXPORT_SYMBOL_GPL(analogix_dp_bind);
>  void analogix_dp_unbind(struct analogix_dp_device *dp)
>  {
>  	analogix_dp_bridge_disable(&dp->bridge);
> -	dp->connector.funcs->destroy(&dp->connector);
>  
>  	drm_panel_unprepare(dp->plat_data->panel);
>  
> @@ -1656,7 +1623,8 @@ EXPORT_SYMBOL_GPL(analogix_dp_unbind);
>  
>  int analogix_dp_start_crc(struct drm_connector *connector)
>  {
> -	struct analogix_dp_device *dp = to_dp(connector);
> +	struct analogix_dp_device *dp;
> +	struct drm_bridge *bridge;
>  
>  	if (!connector->state->crtc) {
>  		DRM_ERROR("Connector %s doesn't currently have a CRTC.\n",
> @@ -1664,13 +1632,26 @@ int analogix_dp_start_crc(struct drm_connector *connector)
>  		return -EINVAL;
>  	}
>  
> +	bridge = drm_bridge_chain_get_first_bridge(connector->encoder);
> +	if (bridge->type != DRM_MODE_CONNECTOR_eDP)
> +		return -EINVAL;
> +
> +	dp = to_dp(bridge);
> +
>  	return drm_dp_start_crc(&dp->aux, connector->state->crtc);
>  }
>  EXPORT_SYMBOL_GPL(analogix_dp_start_crc);
>  
>  int analogix_dp_stop_crc(struct drm_connector *connector)
>  {
> -	struct analogix_dp_device *dp = to_dp(connector);
> +	struct analogix_dp_device *dp;
> +	struct drm_bridge *bridge;
> +
> +	bridge = drm_bridge_chain_get_first_bridge(connector->encoder);
> +	if (bridge->type != DRM_MODE_CONNECTOR_eDP)
> +		return -EINVAL;
> +
> +	dp = to_dp(bridge);
>  
>  	return drm_dp_stop_crc(&dp->aux);
>  }
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> index 91b215c6a0cf..17347448c6b0 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -154,7 +154,6 @@ struct analogix_dp_device {
>  	struct drm_encoder	*encoder;
>  	struct device		*dev;
>  	struct drm_device	*drm_dev;
> -	struct drm_connector	connector;
>  	struct drm_bridge	bridge;
>  	struct drm_dp_aux	aux;
>  	struct clk		*clock;
> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
> index 702128d76ae3..65579873ceea 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
> @@ -21,6 +21,7 @@
>  #include <drm/bridge/analogix_dp.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_bridge_connector.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_panel.h>
> @@ -95,8 +96,7 @@ static int exynos_dp_get_modes(struct analogix_dp_plat_data *plat_data,
>  }
>  
>  static int exynos_dp_bridge_attach(struct analogix_dp_plat_data *plat_data,
> -				   struct drm_bridge *bridge,
> -				   struct drm_connector *connector)
> +				   struct drm_bridge *bridge)
>  {
>  	struct exynos_dp_device *dp = to_dp(plat_data);
>  	int ret;
> @@ -147,6 +147,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
>  	struct exynos_dp_device *dp = dev_get_drvdata(dev);
>  	struct drm_encoder *encoder = &dp->encoder;
>  	struct drm_device *drm_dev = data;
> +	struct drm_connector *connector;
>  	int ret;
>  
>  	dp->drm_dev = drm_dev;
> @@ -168,10 +169,19 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
>  	dp->plat_data.encoder = encoder;
>  
>  	ret = analogix_dp_bind(dp->adp, dp->drm_dev);
> -	if (ret)
> +	if (ret) {
>  		dp->encoder.funcs->destroy(&dp->encoder);
> +		return ret;
> +	}
> +
> +	connector = drm_bridge_connector_init(dp->drm_dev, dp->plat_data.encoder);
> +	if (IS_ERR(connector)) {
> +		ret = PTR_ERR(connector);
> +		dev_err(dp->dev, "Failed to initialize bridge_connector\n");
> +		return ret;
> +	}
>  
> -	return ret;
> +	return drm_connector_attach_encoder(connector, dp->plat_data.encoder);
>  }
>  
>  static void exynos_dp_unbind(struct device *dev, struct device *master,
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index d30f0983a53a..87dfb48206db 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -25,6 +25,7 @@
>  #include <drm/display/drm_dp_helper.h>
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge_connector.h>
>  #include <drm/bridge/analogix_dp.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_panel.h>
> @@ -394,6 +395,7 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
>  {
>  	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
>  	struct drm_device *drm_dev = data;
> +	struct drm_connector *connector;
>  	int ret;
>  
>  	dp->drm_dev = drm_dev;
> @@ -413,7 +415,14 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
>  	if (ret)
>  		goto err_cleanup_encoder;
>  
> -	return 0;
> +	connector = drm_bridge_connector_init(dp->drm_dev, dp->plat_data.encoder);
> +	if (IS_ERR(connector)) {
> +		ret = PTR_ERR(connector);
> +		dev_err(dp->dev, "Failed to initialize bridge_connector\n");
> +		goto err_cleanup_encoder;
> +	}
> +
> +	return drm_connector_attach_encoder(connector, dp->plat_data.encoder);
>  err_cleanup_encoder:
>  	dp->encoder.encoder.funcs->destroy(&dp->encoder.encoder);
>  	return ret;
> diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
> index f06da105d8f2..ffc05f3de232 100644
> --- a/include/drm/bridge/analogix_dp.h
> +++ b/include/drm/bridge/analogix_dp.h
> @@ -33,8 +33,7 @@ struct analogix_dp_plat_data {
>  
>  	int (*power_on)(struct analogix_dp_plat_data *);
>  	int (*power_off)(struct analogix_dp_plat_data *);
> -	int (*attach)(struct analogix_dp_plat_data *, struct drm_bridge *,
> -		      struct drm_connector *);
> +	int (*attach)(struct analogix_dp_plat_data *, struct drm_bridge *);
>  	int (*get_modes)(struct analogix_dp_plat_data *,
>  			 struct drm_connector *);
>  };
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

