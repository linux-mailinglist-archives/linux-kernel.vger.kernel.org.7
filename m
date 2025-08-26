Return-Path: <linux-kernel+bounces-787314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 177BFB3746B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7FA1BA1EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D382F9C39;
	Tue, 26 Aug 2025 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CNIM5pfC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C9283121
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243646; cv=none; b=Cfn1zO2dIvcfdOJY4Mir2rC/yT8KrXR4WXOtJFLRO78PmAeVfL2qLGU/vTGCGXjChQ3a5AkqUFWsqVO2joIx001am9Byc0F8+fDxQ9gR1OTE1ImyXc9mFzvkMDOdRiQGeX8JSKMAmv7PDqI2TzsdwV6c8vZjNeSL/tTHTCJzd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243646; c=relaxed/simple;
	bh=dmqHdTfTty2LEZopIBUjCDz7DuzOdwYoRcFlQ1S+tG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn6TJ17kISSdUkQJjJzpr/Jtog8D5P86W3nl5DliaTmS6WCJE7GeLFL1cupdAkK8VAOhaX3qTM0QhN0IZGrkfo0Y7sEt9hy4q5oV63LyZTxv9xcBi41SwUZaOQMix4KlGfLD0BcO61oRLkwWLWKzK8iIVsM5UkAieKb3rvCuV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CNIM5pfC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QJIwlL004377
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bIo/bxAc1/HcsI6XoyI6p5b5
	8gGGdsJvr4jN4wNxvTA=; b=CNIM5pfClhqSsKo5Yp7stRbW59+cMz3Xqi3wYlNv
	Z6UhPbo1DzuE9oYk5djwmSJ0dnu4zDfNOd+quoVf6VY4622sLKIT6uxA2vYAlw7T
	6pnarV4O2Grt0fpSZkoD9OkFQtpCQkQPvF9YQnnKBScAY+Hk10c7CHMhqiUNy2Ni
	+5MhWfKnaQsuVR/VNceY57TPYE0MoUBOZONEZeAYLiLACGkPB/QStHDnJfYGmgjx
	jMPbzgDQubOo5kOjbQQqH/HVM8ki6uvfPdUGHpOfVhXsQ28Vtd/WJQ4MBIQZKHxI
	cHIArfK4riV+BcfnZQmbM7ovUxg34zAg0INdpWYp2BJqyA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xptkqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:27:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109bc5ecaso175029631cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756243642; x=1756848442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIo/bxAc1/HcsI6XoyI6p5b58gGGdsJvr4jN4wNxvTA=;
        b=wDnksRRUPkhRtHGHFcJVVZigrct/QWeLzp+gnUNVzRGQvgWIAJdMtPuNAtb7mKB/yC
         D9Q7x4HvhAb6+BrqazU8z4kJZveFRF9Xz82j1mUlYIFRPYXLDKlwjZJ7/PglaXgy/7/R
         3g1+ytBMTYK9KcRXypX7joFeQkqj4sYmHcpBprmI8ui+3kONIgYvek5HqGfsG5fiFTVl
         H511oZHS1DcAMwxxguoHokynlTw+DcQIDBirr9S7+wCYcdC3OlPF+RfqL+wzNfkekHnG
         vgXS31KhxfsKw2s2Sb1H1j2oiQMQjaVzfu0lEbs78ThK+K/njYqYNOX9dLcB4MYqQ5wj
         I2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXByydLlW6gNaawiakJqTpgUx4qT6FihKwTWKXwiKP+76h3OwDKbMalk6UY3lhMqzprXCijpjCM8i1Uywk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSrPMezp2YIxUkH5zgbzyTdoDY4vCeUrYYhRI5JMMwoyjQT6tB
	2u2vZXONAMLD8NnaldEJdAQY1U4KbaGRkkyPMLFltAumJhNsuxG11v2K9LL1ZPqIimt6J2YocPP
	YDk6cOab85wyDBz2OZHqrOz0f3CS9O8KBZWA4LzYY6cR1aZzQ3DxKnBsjmWmh7v5L/lY=
X-Gm-Gg: ASbGncuuHSaiWq0krMeXNU5BhyZ7597V3wVfjDrapaY0XoSoLZKHZ2c206esOoqjSRn
	cvIGvOjghgKfF7r34c46wW6z7R3Hbk8VNeHpvX3KzmQ4BbcRC9Qv7FkpfIIqvlqjbfKK/mNWVrX
	zPJNPxvx6ep3K+/Bj3dC4U+TpYj0ozxFdGMVyMzcQkHx+mOEtlFVD8N9FhBvEtt1Uj3jXtbBBsL
	y8MBoHAdROdFef/E1DiGWSM/xDdneIJdCXIwTirv5f2s98ZGms9M2BzydjfjHZKjfWoPDD7LK+n
	+K8c0OIWrIrqZilPAQEcfI7zTfQ+X7a6wLy/436uxLhoid3b8l5Iz7w7H0Qo1jllcb7sB4bZay0
	DtEM7G4YahcQCo/0kwnuI4lny79NJnUzqb8pWtJm10kAQVHApMq6f
X-Received: by 2002:ac8:7fc4:0:b0:4b2:f065:f335 with SMTP id d75a77b69052e-4b2f0660a97mr1488691cf.45.1756243642182;
        Tue, 26 Aug 2025 14:27:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKIt6P0fuMEsH8NvyaiAVm/Kf2jDGyOZA1QvNb9R/GVo1OnUDlsUPq2uC7/OisC4xU3v5yIQ==
X-Received: by 2002:ac8:7fc4:0:b0:4b2:f065:f335 with SMTP id d75a77b69052e-4b2f0660a97mr1488301cf.45.1756243641588;
        Tue, 26 Aug 2025 14:27:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c02201sm2449625e87.4.2025.08.26.14.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 14:27:20 -0700 (PDT)
Date: Wed, 27 Aug 2025 00:27:18 +0300
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
Subject: Re: [PATCH v3 35/38] drm/msm/dp: initialize dp_mst module for each
 DP MST controller
Message-ID: <yztpuhehjydmtefynpa7gt2keysdjpsdmrke6nkjsv7jnhkvkq@cve5yzs7v2sx>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-35-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-35-01faacfcdedd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68ae26bb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=lMSRVfgScpy8wSuMpmwA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: aFGALeT5AH_p_lCEAHXaJDfLrHjJVDwl
X-Proofpoint-ORIG-GUID: aFGALeT5AH_p_lCEAHXaJDfLrHjJVDwl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX+io0zxCikMqG
 S0A6pdw0XaWR0P1XLm+9LGsQ2kzymFJcvWaM1A9OYawuwbtB6We6XleRjzURnnePpDHkOKA75XF
 PSDR3YkmzQseb49r15tfSjK+eVXm3reK7Q9VkRKmpnyaAJklZ5SXTPb/UkQ68aI1m6ch381kwpT
 VM/7neyRV1AZHYti+KRLCn4kPkWzk32VgGX670U9cyGXW2j56Ox1dIMS9DOpM0yEiwdQ5JAS9zP
 3vwwmaRvyoNLq4ESdsMeXEK+Aadq4P626iZUmh3MlkLTjw4eGgYN/MNb6623Ma0OeWjgaYYPUNm
 c3jBnJI7p9TrHcPmPcCq9k/oVE7pqgxO2JqtGtSSrk79dXk/Kxn6z9TbPJowX4/xXSkLfV6MDUt
 DNELBjlJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Mon, Aug 25, 2025 at 10:16:21PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> For each MST capable DP controller, initialize a dp_mst module to
> manage its DP MST operations. The DP MST module for each controller
> is the central entity to manage its topology related operations as
> well as interfacing with the rest of the DP driver.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 6 ++++++
>  drivers/gpu/drm/msm/dp/dp_display.c     | 9 +++++++++
>  drivers/gpu/drm/msm/msm_drv.h           | 6 ++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 0b9d9207f4f69e0d0725ff265c624828b5816a8b..4036d3445946930e635401109ac4720ed2282c2f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -681,6 +681,12 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>  		stream_cnt = msm_dp_get_mst_max_stream(priv->kms->dp[i]);
>  
>  		if (stream_cnt > 1) {
> +			rc = msm_dp_mst_register(priv->kms->dp[i]);
> +			if (rc) {
> +				DPU_ERROR("dp_mst_init failed for DP, rc = %d\n", rc);
> +				return rc;
> +			}
> +
>  			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
>  				info.stream_id = stream_id;
>  				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 909c84a5c97f56138d0d62c5d856d2fd18d36b8c..897ef653b3cea08904bb3595e8ac10fd7fcf811f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1586,6 +1586,15 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
>  	return 0;
>  }
>  
> +inline int msm_dp_mst_register(struct msm_dp *msm_dp_display)

Why is it inline? Also please move this to a corresponding patch (the
one which adds msm_dp_mst_init).

> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	return msm_dp_mst_init(msm_dp_display, dp->max_stream, dp->aux);
> +}
> +
>  void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display)
>  {
>  	int rc = 0;
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 3e64ec7b7dbe1d1107e85def9aa80277131f40bf..c46c88cf06598df996a17c23631570fda078b371 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -365,6 +365,7 @@ bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
>  
>  int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
>  int msm_dp_mst_drm_bridge_init(struct msm_dp *dp_display, struct drm_encoder *encoder);
> +int msm_dp_mst_register(struct msm_dp *dp_display);
>  
>  #else
>  static inline int __init msm_dp_register(void)
> @@ -392,6 +393,11 @@ static inline int msm_dp_mst_drm_bridge_init(struct msm_dp *dp_display, struct d
>  	return -EINVAL;
>  }
>  
> +static inline int msm_dp_mst_register(struct msm_dp *dp_display)
> +{
> +	return -EINVAL;
> +}
> +
>  static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
>  {
>  }
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

