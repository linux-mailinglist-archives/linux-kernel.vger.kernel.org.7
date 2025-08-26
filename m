Return-Path: <linux-kernel+bounces-786357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7941B358CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8B9166B66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBADB2FDC31;
	Tue, 26 Aug 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XOuHedPu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EBE219300
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200380; cv=none; b=Qcidl0zwqbcHesY3LRLTMhvrkHxQEbvgQIYEBLJgpflZLI+PxPlHcSArRuyXMEAM2zVUJeEKOU8x1pQfMrZr1CVFUS7UxBELf5NRQP+NJSn2BkHu7Tk8Y2yep269nZlvuYJRNGR+3sw8dvCpPCNJCZaJmZF0Nj6nDXIVFQbUQ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200380; c=relaxed/simple;
	bh=w20xTJTLkS1bRL9QlG5IoYd9EhhYPVaLwgYFKYLFwLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1dPZF+foUCNIYOMwmiQhekdqehOCkY4k2EdQZaJ0PaSJeSY3jc1uo18CL7bvn4iIj8TdEwhmPsUDqUbFaz+W1IG47noTnxugtpPmentWKAoHl28lGDARWJHKq/o/WxKSWIph7I3nLJHduFHE6bixRTN0/ei4fJBDTzjQiYJzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XOuHedPu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q4MQdA020705
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7KgDcKLK3b159g1W/t3sHnMu
	AA3fp8hQ8bh2XnHJ4Gc=; b=XOuHedPukwV2WWTwQlYfxX5/a2iR0+oJ8xUiQ9En
	OjLXPMJPmxWkkRBeWoSd6iFocYiVWJ6YmTOlpvYTig5msjnVJs3LGupRh1XlM5zw
	wM97wUlfeYI8ygDchqRFcpxyKsQUdislQIYS9BVMk+j0vR3QO5eSrjTT5qPl2U/A
	72Wnm5UhJd8qciTwCnpxH5HJ3t0/k1FnB/5dhztcv0nPoPPxGr3Lxs51xy7Nfxoy
	pXDVCQD3ALX76UUQk6nXkasTCcxDqGrEVicPI/Twh2Gqr8JWGtFN3gwpFQRfYTPW
	6c8yq9kDp3/e7JjHnZpZVTZSDyyMminjrhsnSJ1uRdIcxQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x88a5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:26:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b10946ab41so129303451cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200374; x=1756805174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KgDcKLK3b159g1W/t3sHnMuAA3fp8hQ8bh2XnHJ4Gc=;
        b=CZkiBVPVqygudm9H08e7iCl8LQp2XvH/3pa5l6d3TQ+pjJr6f1NSsJ1aUS6XrJL8yi
         jCOaouBWuJzCliXk78teTtJ/OCiPV9Dpqx3CUrmiHNJekhUYktAQDmu6F1GoUK8yt/Nx
         +7llOV6m05dBE+2DLp5ZE6H+FaAZHjAWRNUOhQxsyO/hP2Q2ZddxR9kHANdiz/b5F/cH
         fKtuyX+YC12A2fax4nuSmQUh0/qoUsUhSxVHA6yg+Ace9LjZPuPHxI+fuZPcKGYrtdnP
         YlpaXMMxeudpWFdFJQii/4BgG7qyK1sBCorHXQK8ZIq+aoZ8l4/eTtARIqSWBCDpp95/
         IsIg==
X-Forwarded-Encrypted: i=1; AJvYcCWKpGgw4uHD98T8jBRnEKwbgp6YGX0wv6D0Kbzu7xJKdHDlmpBZXwlukTjPHMFqvv1l/GNJEZ5XriFL5YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjaIlalK1op5XM7TDjLXRJ1HuecCHql+UzL+Enfr/B0s0/bpF
	Z8vAiju2io+6Vy1HwGnUsu/SUXRDsOJmot41GuzLMie8p10FIWuhVuasneWN8bnv4Wvfp6Rqqq9
	at/2RaQ7JFfcIzRS1RJm0PgwMT1WYMky4oRvYTDpBasyTh4tPXKGO0LYv5guvnjsTRpw=
X-Gm-Gg: ASbGncteHaOzwRkeR5fmEUOXo+uEMx4ArAx02+vBGjUe86BJeK3khrgBVSVzs982+dQ
	sg3GJPuHqgK80RvPbs68VITHqUWPq1MdEMORVMZM4e3p6h0bwtSaBrBWCP/NPTdFeBYMDnPhyq+
	i0ggEXOC0uG8AiEQXdu4h/W/gmGF0jHTLUfrWQeAEdgdx8zjuhOjUXJ8yA2NxfUgB2mol0JLULV
	YeT/nZgVC8HOJsrYiNZtoaEt1q4Tn5uplN1YzI+OepEOLE791+FXMYDmhBeBpMb23XX62XqQk5I
	lBIGABwceCFNpHrC2B07b/rBTGAZlFSRQGLj5xXp/uubcG8mU9jOa4a1gLS4EBJ7qUSfhUlcm61
	6kL2NVZh7i36+4h1H+0WhY4IvP3LgGgjNCd0r/rj4k+/U/JDk0s+F
X-Received: by 2002:ac8:7d0f:0:b0:4ab:958a:6003 with SMTP id d75a77b69052e-4b2e76f6c0emr6050981cf.27.1756200374135;
        Tue, 26 Aug 2025 02:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLI2pBmaxUZlk2JfGZiIZiLVPRGKwKddxYmLZBVub9Mv5V9yCX6KNDj8QRrTIRv5+E0q1Vzg==
X-Received: by 2002:ac8:7d0f:0:b0:4ab:958a:6003 with SMTP id d75a77b69052e-4b2e76f6c0emr6050811cf.27.1756200373545;
        Tue, 26 Aug 2025 02:26:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c11ffesm2214856e87.40.2025.08.26.02.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:26:12 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:26:09 +0300
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
Subject: Re: [PATCH v3 26/38] drm/msm/dp: add an API to initialize MST on
 sink side
Message-ID: <4u5bt5y4suecanvxni2fnljdzrxnkjrg2dgkwzpj4pztvyoef3@nopu6m7w543n>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-26-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-26-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: YuItibdB1d2F2VMmdNLPWE0zNcLLPVZI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfXw8hS+DbYVd1m
 HDt5ijZyvseYJ95Fsz9ZanJ5dp4dkSIHCJCuYSYnxZ0vDIgP6BkNnAC2HPEgpCMjt8+T5Ge5mw/
 Zdq1YrK363jMWPK0YmnXwlYx5T2IpilJ9SQs2l5PefNdFXy+HXj0bBKMen9akJWKT2Dt2zengWi
 cnoNhfNK7M1OSnNjkR49c9koR1OhCRcqeuORKeuelwPeyDl+6kSMlR6dxj1s0d8GlhJ3XEzRtjG
 E6eMLp95WUb+K0DUyJovZmAuFQlQtuy7+dPm8T1foTwix2rjzYSlOPTx2sO4zyrxrC5h4HFn9px
 kee3ojPXe7sg8XhKACZj7KWoezNGLShH8EesCQ5+9o+5Izf9atVe1f/KA11BKne4YQtzSjtAl9T
 zhV8OGXJ
X-Proofpoint-GUID: YuItibdB1d2F2VMmdNLPWE0zNcLLPVZI
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ad7db7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=7z2oCe98pf8tU8XqQ0sA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

On Mon, Aug 25, 2025 at 10:16:12PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> If the DP controller is capable of supporting multiple streams
> then initialize the DP sink in MST mode by programming the DP_MSTM_CTRL
> DPCD register to enable MST mode.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 55 ++++++++++++++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index cb433103d439ac6b8089bdecf0ee6be35c914db1..84df34306fb557341bea288ea8c13b0c81b11919 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -14,6 +14,7 @@
>  #include <linux/string_choices.h>
>  #include <drm/display/drm_dp_aux_bus.h>
>  #include <drm/display/drm_hdmi_audio_helper.h>
> +#include <drm/display/drm_dp_mst_helper.h>
>  #include <drm/drm_edid.h>
>  
>  #include "msm_drv.h"
> @@ -297,6 +298,35 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
>  	return lttpr_count;
>  }
>  
> +static void msm_dp_display_mst_init(struct msm_dp_display_private *dp)
> +{
> +	const unsigned long clear_mstm_ctrl_timeout_us = 100000;
> +	u8 old_mstm_ctrl;
> +	struct msm_dp *msm_dp = &dp->msm_dp_display;
> +	int ret;
> +
> +	/* clear sink mst state */
> +	drm_dp_dpcd_readb(dp->aux, DP_MSTM_CTRL, &old_mstm_ctrl);
> +	drm_dp_dpcd_writeb(dp->aux, DP_MSTM_CTRL, 0);
> +
> +	/* add extra delay if MST old state is on*/
> +	if (old_mstm_ctrl) {
> +		drm_dbg_dp(dp->drm_dev, "wait %luus to set DP_MSTM_CTRL set 0\n",
> +			   clear_mstm_ctrl_timeout_us);
> +		usleep_range(clear_mstm_ctrl_timeout_us,
> +			     clear_mstm_ctrl_timeout_us + 1000);
> +	}
> +
> +	ret = drm_dp_dpcd_writeb(dp->aux, DP_MSTM_CTRL,
> +				 DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
> +	if (ret < 0) {

I didn't catch this up in the previous patches. We have two sets of DPCD
accessors: the older ones which can return error or the size of the data
that was actually read / written (which might be less than the size of
the buffer passed to the function) and newer ones, which return error or
0. drm_dp_dpcd_writeb() is from the first group, so if it was
successful, it should be returning 1. It's all a pain to handle, so
please start using newer accessors in your patches (the full conversion
of the MSM driver is on my todo list, but it's intrusive, so was
delaying it...).

TL;DR: inside your code please use drm_dp_dpcd_read_byte() /
drm_dp_dpcd_write_byte() / drm_dp_dpcd_read_data() /
drm_dp_dpcd_write_data().

> +		DRM_ERROR("sink mst enablement failed\n");
> +		return;
> +	}
> +
> +	msm_dp->mst_active = true;
> +}
> +
>  static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  {
>  	struct drm_connector *connector = dp->msm_dp_display.connector;
> @@ -315,18 +345,20 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	if (rc)
>  		goto end;
>  
> -	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
> -	drm_edid_connector_update(connector, drm_edid);
> +	if (!dp->mst_supported || !drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd)) {

In several previous patches, the functions initializing MST can
return an error, leaving the user with half-initialized MST. Are those
errors a safety coding or do they have some real-use usecase? In the
latter case, it would be nice to keep SST wokring if enabling MST fails.

> +		drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
> +		drm_edid_connector_update(connector, drm_edid);
>  
> -	if (!drm_edid) {
> -		DRM_ERROR("panel edid read failed\n");
> -		/* check edid read fail is due to unplug */
> -		if (!msm_dp_aux_is_link_connected(dp->aux))
> -			return -ETIMEDOUT;
> -	}
> +		if (!drm_edid) {
> +			DRM_ERROR("panel edid read failed\n");
> +			/* check edid read fail is due to unplug */
> +			if (!msm_dp_aux_is_link_connected(dp->aux))
> +				return -ETIMEDOUT;
> +		}
>  
> -	if (rc)
> -		goto end;
> +		if (rc)
> +			goto end;
> +	}
>  
>  	msm_dp_link_process_request(dp->link);
>  
> @@ -349,6 +381,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	 */
>  	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>  
> +	if (dp->mst_supported && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
> +		msm_dp_display_mst_init(dp);
> +
>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
>  
>  	if (!dp->msm_dp_display.internal_hpd)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

