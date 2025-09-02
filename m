Return-Path: <linux-kernel+bounces-796010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7F0B3FAD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5EF37A25A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20052EBDF0;
	Tue,  2 Sep 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xb6ZPcu/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346342EBDE9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806085; cv=none; b=T/yt7GWcAGvWg3IQ2bJIE7idgHCE4x3/7TXmmEuc540w1sDlBSEHTrQXMUbbcbDGZSsKyBDfuhStoOZL+xWxkY+tP0vC9hRlRRoYkqVuYHgsAnKmhDMNfTgYwNokzRGN5twFiZuWg9gmQHVOhKaDKqCRMaHGb50JdV2OGVTFifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806085; c=relaxed/simple;
	bh=eNCr3Qsml0DgY/4i2urWK0EeUYy2WAtNI9PwH9H9Xio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqTZrIOUamWReFIBPAjCG+gL+vnmTR5T3lTJovdCP10pDpCNrzeAUrmK+AMLuv2rww1kNFFipHrNaEhWyN0okzsl3zlx+BSgysuEUeZi5IVexPnBh/tER07lfiQ0jZocuUdJAVZ4lSH4Ww88RmmsVNlcvsH8uDk0ug2vNriTAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xb6ZPcu/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Wg3D030916
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 09:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=X8F1Aylw8vvRYnvl4Vx+2yEC
	SAL/1P4EKbFDjgjCCS4=; b=Xb6ZPcu/3DtxMHqcWy4rG8k1k3LMUuMBDhpv893t
	Vry64vS3KcRkI5c5P+5EmC9T17IxqW+Qnl8BZz1uO1ZBI3aHVRLlqDZSD/eGAJ3h
	3kaIchCS0up2/Oeb1Xaozv+ve5opMxxeVBonvlKQb8JygRwN1tanbo9DvNPc6lZM
	9gM3T5X0qcotf74lDfUG7/g7eaTnoew6gckPrkAdmwVXWCMYUo9rzXM0D7pAh22Y
	l8r5dylc2QI2IghY4vzmynI8PUA40U5LCy9IbSgEYCtJh4EkmqPXaXK62vddlQPn
	UrNw1H3qPqUGh+OxJVRAtFZ6IEzwuDXYtGE8gezUUw/qAQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48wqvw92c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:41:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b35083d560so1592961cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806080; x=1757410880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8F1Aylw8vvRYnvl4Vx+2yECSAL/1P4EKbFDjgjCCS4=;
        b=N0Y0Lv4sAln0bNxP/qW5oPCTCjH02wWblk+hEjZM1PvEcPI5G7bn7hHOM8SzkRraU9
         LxOMwT4OkeNkB3lOulYy9KjfIPEg5Hd4kM3SXjEEv46BaVJfOs8wtM6R20zxmUEQei4J
         Y5zHG98NCKNgV7DOCqIye4wAt1x6wjJANAffrfPx3wtaRIh2bOi/RqhpmQSnr9mRyjst
         HfPZ/dgSndBRG4c9FBdTpaMAZLAg2cAd1Stgig5v9Bn9xYqOjIsSPNkZm+ej66qG5jB1
         xdIQN2LRCHGceP4A+6JplOHKRfDK0R4q++Uqge2DRH8aoBpnjoDzoFXFkiNahaXpAM+b
         xRIA==
X-Forwarded-Encrypted: i=1; AJvYcCWSLAZ0R/aGVqlbofOlNGnRfvArSitMIq2FQ6pOYIde9GrtKP48xw5+4Pa/SSWuI5fPGXCvVFsS6+RZzvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW5hVgaKBRGqw0jTw27tN+ulu04NNhhHOgCDjUZF/X2kYFJYes
	mCSEva2eaj62K+Kgf4G25uleU0R1B4SL8hs/Ny3vfGfBHzbv9CSZ4Q+BNGVUVfIn38RZ1XAgGE6
	H5noeQyuqy8sohPrGkBEDWlL7Sjd6fWfuckGzT5jaRz1Ynk0MlzZzbd8hoRnB8dzbFqI=
X-Gm-Gg: ASbGncuyje7jBDmyzLgDnTh15uYalgqjWbFv/OYf8ZtzcJfawABZlwOU5M0ne7jvU2i
	br0/xUT/FQ2UwYWWAkeib8AoBFBRia7QvUk1WGC8geNc0DAxtAUbFo4aoa9/Vwe4hFcpr53yHkB
	Hsb21ABvihdO/a7HBkz5akUlz0P4PmnXAEZswwNOSSf4jZDuuH8LoPxIsxmfwsAQ6lCNOfK9myw
	a5woUGbqQM1K+2tZxVC+GULL2Kt8rCmQWOoz8s4WEs2SLzORTvvOIqsyAuXdxXTaDKGj66TX6Tt
	ajPDbTjQvwSGxLX3p94fGLJ2Xx2Z8oZkD8i3Mt55p/iWrs2Yb3O0gtTliMVwuwXU4r2egRUotp+
	eChpmduMkJkgHjsNkcMiLPd1LECS696Ei3+nrzGfmziixwuyaiHQw
X-Received: by 2002:a05:622a:1a86:b0:4b0:c1c8:ba6b with SMTP id d75a77b69052e-4b31d84640bmr144942241cf.23.1756806079710;
        Tue, 02 Sep 2025 02:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1kM1KKXIRQLni8+uR7WNKiFx9E+rFnyVU/tfrtMInNL9wYmJHshcvZJNSvNe3Lbzu//4Sng==
X-Received: by 2002:a05:622a:1a86:b0:4b0:c1c8:ba6b with SMTP id d75a77b69052e-4b31d84640bmr144941971cf.23.1756806078981;
        Tue, 02 Sep 2025 02:41:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c904dbsm3631981fa.17.2025.09.02.02.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:41:18 -0700 (PDT)
Date: Tue, 2 Sep 2025 12:41:16 +0300
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
Message-ID: <lngtq2tw4qajgjk57un5xrveblkmtjkkz3yjgue53vp6wwmqmf@owderf4zerfq>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDAyNCBTYWx0ZWRfXx7QrUhLru69B
 1WRfA7EU/ToOGPLb42X96jlC39u1cGTPuaBE+iUwnihkPAVFjCtY5ZXRg8HI3ySIr7Eii5Z1NfQ
 db5n5gBd5x4UIlrm613AnsEmGTtZFXichpUnY4vwgINmYHqEfLLBl9VXutAjiZOHkjbepxpuyz4
 M3neTkGQ3Q5Qj3swLbKQnHIVzuiKHasb7vyzLudiA2wZ2rMWVS6nqHLRRG71jpMdovKENemzThw
 bpV7W2MJfKUB0FAeCSD/LhvKW14DQwbN5jSCVl0vOXbOeoTCfxEBnp5kGj6BI3eq7uZ7Z4Gry8L
 5Q9g36vB1Nqh0SntwQEBI7GEDaw0IVP9E57V2+G4lXm/UAI/kHIYGcqklYWh8K0JEwolKNXqVud
 TzGN1acz
X-Authority-Analysis: v=2.4 cv=WKh/XmsR c=1 sm=1 tr=0 ts=68b6bbc1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KSwXNKDnAPCPISpuv5EA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: TJp08efjz0P-Abiifz_Ljr8-SQbyn4JK
X-Proofpoint-ORIG-GUID: TJp08efjz0P-Abiifz_Ljr8-SQbyn4JK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020024

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
> +	dp->mst_supported = FALSE;
> +
> +	if (desc->mst_streams > DEFAULT_STREAM_COUNT) {
> +		dp->max_stream = desc->mst_streams;

We should keep compatibility with earlier DT files which didn't define
enough stream clocks for DP MST case. Please check how many stream
clocks are actually present in the DT and set max_stream accordingly.

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

