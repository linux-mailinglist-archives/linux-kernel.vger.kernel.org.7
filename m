Return-Path: <linux-kernel+bounces-785326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE90B34917
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D966F161093
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C867B305E33;
	Mon, 25 Aug 2025 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXqurqiy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD52FF648
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143734; cv=none; b=ilaCGnXnHI5OGM734zOQh3Uun4cC5mnz74C2+lJ87RStBQsvcIC5/ICFCY3tNO0jPUCFKYAHSjdZkpC5Z4dMuaniEdx/ONNXzswgVfzkYIgtEjENQPdTdNGtZ+OHH2d8fTztVIiy53oI0F7FMn7C5hLhDM/pUkmQDqzfJgKbnJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143734; c=relaxed/simple;
	bh=O0qGHqa21DZ+mvkJwshOOZ3pF1P9e1KUk2sx0IIba4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB7SJbBfVu4XyKyi7xBhogaGINeiEf+MQ9oprNkczZQ8PVr4NO9s945Cv34/whvaYaa2pkA7Id9pYVMXWIB9bjInLpJGOOH2z4al+ahIHxqxcNzU7n4mIvuucznHdOdfpSjvsBn+sBtkT1TdDuFoL5h6Su/DT1KSkL0mHs/Uyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oXqurqiy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PH4u9T020583
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NwZKoiB17+RzcYdQtzPEWYcl
	qT54d7+6tCe4wXrETLw=; b=oXqurqiy/ry0fDEjB8N+cp+O9iBBGReyv7E6gTTm
	r3ADwD4ZHC2PeapULGvo7fbVPGpkuJn5ZAj3lTZ9ctFFB103EybPFpEvFsFs6TeZ
	qHcCS7ak0rqJouVN+pZZFi7AFZZy/3xiGJh7qaoKcwLvAtsKvNCUQNRq7O10FkUE
	TcTmNrsipGCt6HtYNdJcv+ul8gvr3uVNjoq4dy5bPcsblPpcSY4mi/7Lb+BNewEo
	ZvVWKJKOqMlxD4RG9a6ET2dn9h/1Ta+GBJq7bR4Zd0KPlwwUg0Ny9sxRzppkWzqQ
	vTfu8TSUc2KkaBPw3bY7WSQuSPLGSNTpQqS+nNO4B/NnIQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5duqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:42:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b10993f679so127479611cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756143730; x=1756748530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwZKoiB17+RzcYdQtzPEWYclqT54d7+6tCe4wXrETLw=;
        b=ipyExu95WGrjWpwvGSHHkQTWJnhJUAbAywdY631ONKlPEcGcmzPjv0Zhz2tuIc5Q3S
         nMeT0kOjY0yxXQE0eL4peXnIUm2dl0VrW88Bj8nRsXdmhKDWLuP3QEC4bJEfq+fn98OH
         /fjg6rdoR3MkUzZyVBMs6m6nWV9HsIPvzKRAWTdvT3QBLSZA61DLyhg4nHyFgvVor6aF
         tORxQL5fgy7xzIN5p+qmDjaOSTEPN45so/d44HHkhFoXMPeVNweBssQnPhEHUgHCszq6
         OSX2J7qKqIp+HjCTn1iNlheNpDqEq8h42qaycgaUVvfpdTLLj7aAVu3d0E36uAdcsZE1
         KOeg==
X-Forwarded-Encrypted: i=1; AJvYcCWWrDKAUzaEULDNo+xItxYCCe9sWvfJOxTQibkfmf/Yd7wxkOLZK/rVggQ1dRLGS2TUGaeCzpifAHOPe0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9MThqLMgnFzIGYXdBqCYIRkM16OXTFQROc28l5sbcFRa5qxUB
	I1yTKITRixj8w7qv/heoMQzGQRXlaPz481O5BdiNAX1KQWBH2EKoo85MiwlTztqOqu0F07Vsy7q
	lLHaD2FXrBrLfQhI0PDRhbod0PB76MqAR4N0lTichoWNYY5Z2iR5QPsjew97PQwx8MmI=
X-Gm-Gg: ASbGncsgoibmLpZZ0W2DCKck8VvGbMJVlI1NBNTjDIFHMjNNsF+//AWoQNOhEyGqBl/
	eDFsnBi/cXW90i3t8C2ktgTcaBAGi82L5qudYic/ghf6cB7DFEhWq0EME7fgK8lpobzRPqoX49p
	89TNYsE15pIbisH06fqhyKBXUGlqtsspNbvpLUld3dWZqQlOyzzCQ53tXiUpLXa5X6z27RMHZ1n
	ZmsUBfQiGEi0Ew6sbkJu1jn6d7hupN3u39+q+f42xje0Mpzx+w2VeK0XXnPNwEo4oBRl7CEEFnB
	6gXxhjxKpXUF5M62t35zM/7MjJvvL/V4+iXed19gMQeLJuXCqAtDXZRR6MebUcPWVtzIzLEUgYU
	yseVQ5Yp5YGD/2Ubi+QuF2vtWOqtJ2etczCTOVGTy7Mpq9jQCzf/R
X-Received: by 2002:a05:622a:211:b0:4b2:a07c:d728 with SMTP id d75a77b69052e-4b2aaa2b1d3mr173862421cf.27.1756143729904;
        Mon, 25 Aug 2025 10:42:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeCzCtDd568aAnN/B2JcD7EdU/1ndGpfZU0hZl1xPRFEteCvWyj6thJySnvMEtk6k9eUZZiQ==
X-Received: by 2002:a05:622a:211:b0:4b2:a07c:d728 with SMTP id d75a77b69052e-4b2aaa2b1d3mr173861471cf.27.1756143728641;
        Mon, 25 Aug 2025 10:42:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c8bbedsm1749862e87.85.2025.08.25.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:42:07 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:42:06 +0300
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
Subject: Re: [PATCH v3 12/38] drm/msm/dp: introduce max_streams for DP
 controller MST support
Message-ID: <ltlmp5ytl2f7no7aqq7sl54pwd4f53fuema23xnuwu5uthhbg3@7wamwvv22nle>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-12-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-12-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX5rKqcdYHxSvU
 JGkNZ943vQoxJtbmZ1bo6k3NVt35MTlBKHrgJ2XzrBrPhIJxdkLv0VWTI0ZPlt+FI8qmPW+lBKn
 hX2rxoLwDDr3n22eGoRKy4+eUJVcKv6zoacuWb5CsITSwhINc18+037IuOOeLdLsnp9vRhr3AZ7
 c+AjYW1SLdns7IHCjpHB8hsZA4JnrSfw/2iO9XMttsJrFqBK1/9YKspQitQ16BfyCN7SBzzp+v3
 vdc9RNTtJ9wBAxY7OXPO095i5O7ufOpvG89GyJ+Y3b4jY2mbddziQvYik/SSG2/+i4CFuNLYbvV
 vCCyN0doMjD9P85eM1m9rbNSYZbqdlXXxT8DzcnkzZjHQH9fh35QD6jaJblZ7Luc3urDL8HOliM
 S2DrvMWW
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68aca073 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KSwXNKDnAPCPISpuv5EA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: LyCpaA1l5sZ8UHYvJdpMDbXFyn26POGd
X-Proofpoint-ORIG-GUID: LyCpaA1l5sZ8UHYvJdpMDbXFyn26POGd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Mon, Aug 25, 2025 at 10:15:58PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Introduce the `mst_streams` field in each DP controller descriptor to
> specify the number of supported MST streams. Most platforms support 2 or
> 4 MST streams, while platforms without MST support default to a single
> stream (`DEFAULT_STREAM_COUNT = 1`).
> 
> This change also accounts for platforms with asymmetric stream support,
> e.g., DP0 supporting 4 streams and DP1 supporting 2.

How?

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 21 +++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 78d932bceb581ee54116926506b1025bd159108f..a8477a0a180137f15cbb1401c3964636aa32626c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -33,6 +33,7 @@ module_param(psr_enabled, bool, 0);
>  MODULE_PARM_DESC(psr_enabled, "enable PSR for eDP and DP displays");
>  
>  #define HPD_STRING_SIZE 30
> +#define DEFAULT_STREAM_COUNT 1
>  
>  enum {
>  	ISR_DISCONNECTED,
> @@ -52,6 +53,7 @@ struct msm_dp_display_private {
>  	bool core_initialized;
>  	bool phy_initialized;
>  	bool audio_supported;
> +	bool mst_supported;

Why do we need the separate boot field here? Isn't it enough to check the max_stream?

>  
>  	struct drm_device *drm_dev;
>  
> @@ -84,12 +86,15 @@ struct msm_dp_display_private {
>  
>  	void __iomem *p0_base;
>  	size_t p0_len;
> +
> +	int max_stream;
>  };
>  
>  struct msm_dp_desc {
>  	phys_addr_t io_start;
>  	unsigned int id;
>  	bool wide_bus_supported;
> +	int mst_streams;
>  };
>  
>  static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
> @@ -1213,6 +1218,15 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>  	return 0;
>  }
>  
> +int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display)
> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	return dp->max_stream;
> +}
> +
>  static int msm_dp_display_probe(struct platform_device *pdev)
>  {
>  	int rc = 0;
> @@ -1239,6 +1253,13 @@ static int msm_dp_display_probe(struct platform_device *pdev)
>  	dp->msm_dp_display.is_edp =
>  		(dp->msm_dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
>  	dp->hpd_isr_status = 0;
> +	dp->max_stream = DEFAULT_STREAM_COUNT;

Just use 1 it's not that magic to define it.

> +	dp->mst_supported = FALSE;
> +
> +	if (desc->mst_streams > DEFAULT_STREAM_COUNT) {
> +		dp->max_stream = desc->mst_streams;
> +		dp->mst_supported = TRUE;
> +	}
>  
>  	rc = msm_dp_display_get_io(dp);
>  	if (rc)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 37c6e87db90ce951274cdae61f26d76dc9ef3840..7727cf325a89b4892d2370a5616c4fa76fc88485 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -29,6 +29,7 @@ struct msm_dp {
>  	bool psr_supported;
>  };
>  
> +int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display);
>  int msm_dp_display_get_modes(struct msm_dp *msm_dp_display);
>  bool msm_dp_display_check_video_test(struct msm_dp *msm_dp_display);
>  int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

