Return-Path: <linux-kernel+bounces-785236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF38FB347F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAC85E0CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3476301014;
	Mon, 25 Aug 2025 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZspILKvF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E102FDC3B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140657; cv=none; b=LzJ5F39HIQscfa5vDNqoYxsNgC/YCoaiCkMOCXYrkOePqziob7BRe8uLgarA2vtVSPbFhhYngQcPf8NLUmZyYvIZWMlo90TfGiLZJXhCTzSnrRts0HE09T4ceg09pP2soSnhIGwdik7PdV7GmQcLPn7f3k+Z76N/SefwjqRVZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140657; c=relaxed/simple;
	bh=5rffhWlHaMM9NYWWbtLlVs1vIMOIydqOcfqzIMaoRho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvaDHFHSBEVrdB6SgXxa+a8jKb0PXLy5ZbIXhxFBOc02TktVj4q9c9vazVRiq9D+z8G9H+yKg/cBqZmW1qxzcdbty80cVmXAFLPqdPa29Fxslb/AaOV1Reo0ddLVPJqZ7P7FfmxxWRiNTTg5peavBf37R03LQCi/d7SmP0xEvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZspILKvF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PG9ajt006049
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jrK6peDEUA+3SL53OzlkDtdt
	0fhhvGzt5hC7i2Ev/TE=; b=ZspILKvFLiB3LXXDIzSk+2kGOluIqieGTOur9XPr
	e+twuhC0JviSUowvNL1zm9MBjtlvlpmMAjI/Sp2WTiADiumMQlkwJpHl8do3a1UL
	q3TKAQomy8hGjHK1uraEPM+1Muyloy3KZ7ArIzIDWSumiZmtI+tHP5Jb/XJ01YaQ
	/TFNaAX+7r2GIzaQUM3tUt2ovtey5oXfAOEo5iSJ9Y/fJlUZUPxbBHlHZ43BYYz7
	Vy5d4QUpAJJIRxTmiHXMh8HtSX94NuwdVhLd03q4KI85tf+AVKHb2EwxaUMfSm2J
	4nRjRYlPh5+Wva43OsZg1zNOnhqwFZk6/09mOJUEvlhDOA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6thwu75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:50:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b1292b00cfso45535201cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756140654; x=1756745454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrK6peDEUA+3SL53OzlkDtdt0fhhvGzt5hC7i2Ev/TE=;
        b=nT0PZ28DHUZgzFZ5dTEPUf5kMid3JOug/YBb8h4ZS46r2ulU0sTndQ2GMJqIv+Big6
         KwCqaqynLFcDduvnooLY0FQFgFQyYy6YVnvyIFft5r/HEH85uXicRcHd/rnEaW0fnQrl
         pto2qR6GLrenykmgPYqSpC0RgrMVfNLHtlKlLMLy9y7wLv1DOnI2Oij8pedXfwV7wIE6
         ymbt9grBabz1gkdf12/p29Ttj7cs9zglZdpqdBoUlL7zVxXSJ6gxswkFHn8jm8SpuoNL
         MSH6zYHjbbiV7tQYc4+V1D0EMHSMi20cjQQGwKFPITfJ3hIlDCOqEk0L/yYLmL5Xk2Zv
         /09Q==
X-Forwarded-Encrypted: i=1; AJvYcCXL69VoSI3hr9TPNPDggBxkEzSx2ZEl8/Zm71Rx+Mh2oGH2iWxTzwALGtv98kfKRugSBFXOupLJYRFIwgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4wfBwMFeWoy6SK5fdUkrzJVedrWhJsBTgFR0U0CZm2k4zEd42
	1oxWBwJVzF5hc8xeYINYS3Qt3+POA1PvnrMBUgndCkDXae9ZeoRpssrenZIClDjugTC397SjwSW
	//YfM524GVTnjSzc+saLBKpDlpTwL3lDsjlCVrcirLXDNF8mPTgWvSBrZ4yCZStu0MNg=
X-Gm-Gg: ASbGncsTgvWidn/WIdl7Lj+S2WJxjFUAmwQeZXsN3jalvbsoidZRtRfjv32puFGWu+A
	nyg7o4qAENiZGx0xHNeYBEblcOxYqqHu1j7aLhM/7bU5Fcm3LHp1GKadScilgLyFJkK6FQVUbNJ
	YkDw7pagAJfoeq1YGQWcwJLGoysgZ45gHxtRkow5x0GknWQ/IlZtHHjBGeiOpC8udUVObiiT67l
	wq0NfC9/Cp9oEn7Qg+v2Uj2mX7Ea9dz4qI1dvsrsaRUGQMRwt4Ta7AXKsx1wEAdzFUO2qt23vMq
	AcSn+VGWmhJ9QWxH4P46TeCclrmSyTz8hw2GmY7LMdmwRBeOS95Nrgg2iEPSkR+J1262kPXtUdy
	f9IuqYJxgizrR0+Rb+nbQm+f1DsbrJPyBk8xRucQkbLgOXGuFMfNn
X-Received: by 2002:a05:622a:294:b0:4b2:9bdc:5da2 with SMTP id d75a77b69052e-4b2aab6797amr162388431cf.76.1756140653483;
        Mon, 25 Aug 2025 09:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLHZdiFKldHnq/hjsXNMEr2yDqWUyubbDvhtKmQyFhUwo+jZoQ3RY2EppFdHKWmCE4ejb+OA==
X-Received: by 2002:a05:622a:294:b0:4b2:9bdc:5da2 with SMTP id d75a77b69052e-4b2aab6797amr162387811cf.76.1756140652710;
        Mon, 25 Aug 2025 09:50:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c136a1sm1696542e87.52.2025.08.25.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:50:52 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:50:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 02/38] drm/msm/dp: remove dp_display's dp_mode and use
 dp_panel's instead
Message-ID: <aa35nnvo4mugk363rwa3cndjwj5sukfchdxv65yob2uf5ugskz@gus3l4d6vccc>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-2-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-2-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0MyBTYWx0ZWRfX+ktWEbqZum5J
 4KGaPjPPPTde+FWG3WGG3Fnjud3P+d6AdrgGGbqrCOysVNmOR0JqA65kRmTnGBD1MsRBl5esra9
 ZWUbwqy37ylwIjm1/4Kv8nCIISDGeUn9wWJjPCxqWnUtNIOnzSudrk4ZafGrw1xvLDnpyoOafYg
 WhTsluXVN5OM1Z1w+UbKjvuoE+r1MfVa97uwfQ1eVF1H2J3J7BjYXUhC1YuWQ0nenUzzD42+5tA
 RZ/XZ9VCH8P/KwWQPJi+uYpDtyFHnxDfMc5PeZwPfNFxoY/HNMa9SdkPjUpkZlpYtc2Kir5ND+G
 T4o01tZaee+/mQFYba0ggUttMmtMDDnkdO1Ew6vCQ34t16rxf/uWY1mfZu4jiH8l/8W1VoLoeKu
 qx3VQA9M
X-Proofpoint-ORIG-GUID: yEq3pL5qMutdK_SRveKtUm6NcdtfSYEQ
X-Proofpoint-GUID: yEq3pL5qMutdK_SRveKtUm6NcdtfSYEQ
X-Authority-Analysis: v=2.4 cv=W544VQWk c=1 sm=1 tr=0 ts=68ac946f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=uIfkYmwNqBCjC_dUfjAA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230043

On Mon, Aug 25, 2025 at 10:15:48PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> dp_display caches the current display mode and then passes it onto
> the panel to be used for programming the panel params. Remove this
> two level passing and directly populate the panel's dp_display_mode
> instead.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 66 ++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index dadf31bc37763c4f07f68b76fbbe33fb77b20850..632a1191e4e48fecd7dbda2f6ec6b8ed0aeebc93 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -60,7 +60,6 @@ struct msm_dp_display_private {
>  	struct msm_dp_panel   *panel;
>  	struct msm_dp_ctrl    *ctrl;
>  
> -	struct msm_dp_display_mode msm_dp_mode;
>  	struct msm_dp msm_dp_display;
>  
>  	/* wait for audio signaling */
> @@ -649,16 +648,29 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>  }
>  
>  static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
> -			       struct msm_dp_display_mode *mode)
> +				   const struct drm_display_mode *adjusted_mode,
> +				   struct msm_dp_panel *msm_dp_panel)
>  {
> -	struct msm_dp_display_private *dp;
> +	u32 bpp;
>  
> -	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +	drm_mode_copy(&msm_dp_panel->msm_dp_mode.drm_mode, adjusted_mode);
> +
> +	if (msm_dp_display_check_video_test(msm_dp_display))
> +		bpp = msm_dp_display_get_test_bpp(msm_dp_display);
> +	else
> +		bpp = msm_dp_panel->connector->display_info.bpc * 3;
> +
> +	msm_dp_panel->msm_dp_mode.bpp = bpp ? bpp : 24; /* Default bpp */
>  
> -	drm_mode_copy(&dp->panel->msm_dp_mode.drm_mode, &mode->drm_mode);
> -	dp->panel->msm_dp_mode.bpp = mode->bpp;
> -	dp->panel->msm_dp_mode.out_fmt_is_yuv_420 = mode->out_fmt_is_yuv_420;
> -	msm_dp_panel_init_panel_info(dp->panel);
> +	msm_dp_panel->msm_dp_mode.v_active_low =
> +		!!(adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC);
> +	msm_dp_panel->msm_dp_mode.h_active_low =
> +		!!(adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC);
> +	msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 =
> +		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode) &&
> +		msm_dp_panel->vsc_sdp_supported;
> +
> +	msm_dp_panel_init_panel_info(msm_dp_panel);
>  	return 0;
>  }
>  
> @@ -1328,7 +1340,7 @@ bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	if (dp->msm_dp_mode.out_fmt_is_yuv_420)
> +	if (dp->panel->msm_dp_mode.out_fmt_is_yuv_420)
>  		return false;
>  
>  	return dp->wide_bus_supported;
> @@ -1389,10 +1401,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>  	bool force_link_train = false;
>  
>  	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
> -	if (!msm_dp_display->msm_dp_mode.drm_mode.clock) {
> -		DRM_ERROR("invalid params\n");
> -		return;
> -	}
>  
>  	if (dp->is_edp)
>  		msm_dp_hpd_plug_handle(msm_dp_display, 0);
> @@ -1405,12 +1413,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>  	if (msm_dp_display->link->sink_count == 0)
>  		return;
>  
> -	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);

Why is it being moved from atomic_enable? You can access crtc_state here
and thus the adjusted_mode. The mode_set is clearly declared as
deprecated. We should move moving code from that function rather than
adding code to it.

> -	if (rc) {
> -		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
> -		return;
> -	}
> -
>  	if (dp->link_ready && !dp->power_on) {
>  		msm_dp_display_host_phy_init(msm_dp_display);
>  		force_link_train = true;
> @@ -1479,31 +1481,11 @@ void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
>  	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>  	msm_dp_panel = msm_dp_display->panel;
>  
> -	memset(&msm_dp_display->msm_dp_mode, 0x0, sizeof(struct msm_dp_display_mode));
> -
> -	if (msm_dp_display_check_video_test(dp))
> -		msm_dp_display->msm_dp_mode.bpp = msm_dp_display_get_test_bpp(dp);
> -	else /* Default num_components per pixel = 3 */
> -		msm_dp_display->msm_dp_mode.bpp = dp->connector->display_info.bpc * 3;
> -
> -	if (!msm_dp_display->msm_dp_mode.bpp)
> -		msm_dp_display->msm_dp_mode.bpp = 24; /* Default bpp */
> -
> -	drm_mode_copy(&msm_dp_display->msm_dp_mode.drm_mode, adjusted_mode);
> -
> -	msm_dp_display->msm_dp_mode.v_active_low =
> -		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NVSYNC);
> -
> -	msm_dp_display->msm_dp_mode.h_active_low =
> -		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NHSYNC);
> -
> -	msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 =
> -		drm_mode_is_420_only(&dp->connector->display_info, adjusted_mode) &&
> -		msm_dp_panel->vsc_sdp_supported;
> +	msm_dp_display_set_mode(dp, adjusted_mode, msm_dp_panel);
>  
>  	/* populate wide_bus_support to different layers */
> -	msm_dp_display->ctrl->wide_bus_en =
> -		msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
> +	msm_dp_display->ctrl->wide_bus_en = msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ?
> +		false : msm_dp_display->wide_bus_supported;
>  }
>  
>  void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

