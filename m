Return-Path: <linux-kernel+bounces-866887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D522EC00F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C94188E45B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B1D30F817;
	Thu, 23 Oct 2025 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ERRuSMqz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C040C309F1B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220883; cv=none; b=QsHrZCzYr7VlRlQ3xk6Q7gxAw8288ltUqkJZYdGL9s5A/udLM+CEY2VRfsjDU2uhwNWsDMVbh7ZRLEch5XiNOWmQaAHyyLw6uUC1EqV3ujFk43PZE586sXNvxl1St/QF11jqr0A5GdMSe/RDT4v/woeQc4zgcWva7W41WKltSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220883; c=relaxed/simple;
	bh=xgyOM0BDgOZaPTwKa5g6GcOjB33jTljJLH+mwWNy4PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjOcUlSnk75HPaejzjEh2ej2le6OI/ZS6QAgt3qQxkq//Q2g9/PYDOIZv2Fmb7AAEQfth6REjAkMERT86Lrc+RFKhxjn2huSlPOIOIp2MyCLoPzYbmk09MiZsRADBV+Dv9J3wO+n4WPRbbbf9eJyB7HKwzMKiWpwA+Miwd+jIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ERRuSMqz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7eGuq026255
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=goeKdp/WYHhJWHlaAy8C59qV
	Sxphru8lrJomaYpY0h0=; b=ERRuSMqzetasBthM5RxIR9p9b2FPm8/Zi9gQWLY0
	SWJKLQH3qGe3Mq76R8uVPpVyCGW6AW4M+wZYJS71aQ53AZ+Nf/5DX9OLRbl5YVyW
	6qwP1S9MqpLVA0Twp8C7onzazAZ7yLPI4VIwdcN37Ve+vNEmQZhurqmqh7mpB45T
	2lSiqaiSCf7Uxy5HbdFZ4D2n9ujUKPqm0fjLd4M1R6tiEWB9MrI5FMxCphd0eb4+
	8Iq0Ow4f6r4c9YyLla5aA5Qj2ChVclZVYiHAdvpK8Ybxhcvi6xc4XhKNcT2x4pt3
	jF8MdXeQ5d+4ji3YvPL4ROa5SEEAWvGxM48KJyDiXqbwFg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8jd06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:01:20 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-556fd0bcc47so1652814e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220879; x=1761825679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goeKdp/WYHhJWHlaAy8C59qVSxphru8lrJomaYpY0h0=;
        b=WWIXDw/DqGb6Pk9TK0WcoqfLCEOmeUo+xZNK4TvtzPcMpcART2/dWBwEa/BJ4MCYBc
         EQaIVcRbCJwnimEr06LBeYjh3kx29NrYzX9JY18iBURtnK0TBzsLRh8DO+0XIxqSVPY+
         uLOIv0FZ2nvsVd122VNI5m95wLSAyw1FEHvNaYUJUoW+tbTne/bH+ICa61CDQ1Re93xo
         6XOg6oqZXZ6Kv8TlhzNY9eaN4tveqKcfOR+DvzotSZYuDFa45dvNMqH65YcNjm9J5iPU
         cwzteOVAkrKjF3bTVmYd+dJtXEvuocSpcP+tcogyr4OOlE6f+MQnsv6Rl4VSTaM/EETK
         nLYg==
X-Forwarded-Encrypted: i=1; AJvYcCXrZFjuZNeGTujD5/Q/NhDIET10QIdwAPS5jhOAuYNaFs8chrDkeigA6W4vImScdTuYRTtfoAx+gYSfzbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeCfXo1BFsLeLJXWQnpVxCwYk9iZCrzte83f6xcoMZCP0zAAsH
	2iZNsVt3kXcNBGZs+7cTLf0CBw+iurOi9pPkHPBKpdyFgzrGzrA+qNSOhEK0c4MxnHOVKTSO8+D
	kd0uDykB1XSEsKmxs9c1K8oWoIH/koRYjTozJAERhRlF1LD0Zn7J4BmaKSvejfOkj1DulNvheJB
	4=
X-Gm-Gg: ASbGncs2rau0U7rcl98LyJBeUHBC0KJudzFO2sbz1JZc4T9ynPTztvjxufIaSGvSC7H
	9Z1mTdqKDf3TXV9je380RGm5/dQ6xXe1AZB9gRdtbxAz0vCrrRqu2Gr00y3YsOmXIbQZS1WyEJw
	SDE07Il5x9/f+q35knfGzwrjQV131E/ceudMM8M+/sfsNbI+9+Trj5wn4Ue4WDJCHnkbKv2pKxb
	2+FUSnYvV36eaUGuEhTbzSz8KGE7sFaYmT/Rc/eqfkFkTUbwQWSkchGP1Rk3jTRYDvi0vCHOhsO
	pDCgPrE5FYcdG+1joxlVcC4Uxj9Xlm9Hz5O7mzDapXwaDE/Jz3Z485EOuR1I/jVE1chgrPyNIMB
	nP0M5fdOVsBNowBNCQbk8mtXI4bYIaYpcdeDQpI3394IsO720SM9KMhZjdXRQ1XU/upopgL00t9
	L7MfOC6sPo+uUR
X-Received: by 2002:a05:6122:c457:10b0:54a:8deb:21a7 with SMTP id 71dfb90a1353d-556a1fe00b0mr1375539e0c.4.1761220877769;
        Thu, 23 Oct 2025 05:01:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYxrTX1ih+hGngZciP+iHFYfeFoyaVhepsbpmQ8PJc+gldudoSg8FgGhwuto7pKkQZUsY/ew==
X-Received: by 2002:a05:6122:c457:10b0:54a:8deb:21a7 with SMTP id 71dfb90a1353d-556a1fe00b0mr1375509e0c.4.1761220877262;
        Thu, 23 Oct 2025 05:01:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d66bbd08sm4052251fa.4.2025.10.23.05.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:01:16 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:01:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 04/12] drm/msm/mdss: Add support for Kaanapali
Message-ID: <7yrjpxx2uqb7ox6yk55hsdj2cgexvcoqjjutmhnjokciy7pnl4@a3zdvmn7wmto>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-5-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023075401.1148-5-yuanjie.yang@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 1OgAmMMHP-TOKkJHYDizkW83FbF8xGDY
X-Proofpoint-GUID: 1OgAmMMHP-TOKkJHYDizkW83FbF8xGDY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfX6ZOCNLrfh6Eh
 b3kmhTRzlEPcncAcLXWLm5UTzpLVtJMfKEgYeKV7S2Ecayj1Ks9v2yRjAmn8HgzagTm6VZxtdI4
 /J2u3ybs37zcm7GNjjLV2dkBXcFrmHNK3nhfssMFQJyP5tO/M6FIgnYmPnFVshVk39CwmxY/c35
 BObk79smiJoEuzEuvToDnC7e1COg4JWivj8P0h+Y2ZABPc4+wJPjlP/QJxYlz1yN178wT+wJ098
 mgFJRaRNnp/oRvj1BeXBFjDmp3FVM7QRRgGHlvCMrbJqeK04vGGZvTEiNLn+i4KqrpdOEZbiv4X
 EQIl/fwV1v2FfIpKlZSqI0f89uNEdgoTNRcoPP7MJXjvsMjna4BGJAYJf0nA7Yo29KvEQEyBkUR
 0iTaTG4Fu7Gilurn9jKhzypwfoGE/w==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fa1910 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=FJEgi42wPuteDVaKdBsA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

On Thu, Oct 23, 2025 at 03:53:53PM +0800, yuanjie yang wrote:
> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> Add mdss support for the Qualcomm Kaanapali platform.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 22 ++++++++++++++++++++++
>  include/linux/soc/qcom/ubwc.h  |  1 +
>  2 files changed, 23 insertions(+)

Where can I find the UBWC config for Kaanapali?

> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 2d0e3e784c04..665751d2b999 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -243,6 +243,24 @@ static void msm_mdss_setup_ubwc_dec_50(struct msm_mdss *msm_mdss)
>  	writel_relaxed(1, msm_mdss->mmio + REG_MDSS_UBWC_PREDICTION_MODE);
>  }
>  
> +static void msm_mdss_setup_ubwc_dec_60(struct msm_mdss *msm_mdss)
> +{
> +	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
> +	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
> +		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit);
> +
> +	if (data->ubwc_bank_spread)
> +		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
> +
> +	if (data->macrotile_mode)
> +		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
> +
> +	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
> +
> +	writel_relaxed(5, msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
> +	writel_relaxed(1, msm_mdss->mmio + REG_MDSS_UBWC_PREDICTION_MODE);
> +}
> +
>  static int msm_mdss_enable(struct msm_mdss *msm_mdss)
>  {
>  	int ret, i;
> @@ -296,6 +314,9 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
>  	case UBWC_5_0:
>  		msm_mdss_setup_ubwc_dec_50(msm_mdss);
>  		break;
> +	case UBWC_6_0:
> +		msm_mdss_setup_ubwc_dec_60(msm_mdss);
> +		break;
>  	default:
>  		dev_err(msm_mdss->dev, "Unsupported UBWC decoder version %x\n",
>  			msm_mdss->mdss_data->ubwc_dec_version);
> @@ -552,6 +573,7 @@ static const struct msm_mdss_data data_153k6 = {
>  };
>  
>  static const struct of_device_id mdss_dt_match[] = {
> +	{ .compatible = "qcom,kaanapali-mdss", .data = &data_57k },
>  	{ .compatible = "qcom,mdss", .data = &data_153k6 },
>  	{ .compatible = "qcom,msm8998-mdss", .data = &data_76k8 },
>  	{ .compatible = "qcom,qcm2290-mdss", .data = &data_76k8 },
> diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
> index 1ed8b1b16bc9..0a4edfe3d96d 100644
> --- a/include/linux/soc/qcom/ubwc.h
> +++ b/include/linux/soc/qcom/ubwc.h
> @@ -52,6 +52,7 @@ struct qcom_ubwc_cfg_data {
>  #define UBWC_4_0 0x40000000
>  #define UBWC_4_3 0x40030000
>  #define UBWC_5_0 0x50000000
> +#define UBWC_6_0 0x60000000

This should be tied with the ubwc config changes as this chunk goes into
a different subsystem.

>  
>  #if IS_ENABLED(CONFIG_QCOM_UBWC_CONFIG)
>  const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

