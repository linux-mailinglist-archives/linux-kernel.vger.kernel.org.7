Return-Path: <linux-kernel+bounces-868040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 455C9C0436D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D95DC4ED3C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CC4270553;
	Fri, 24 Oct 2025 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fYsRSshu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE024BD04
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275166; cv=none; b=eOEDfC3JupAPbkjjL1ubcRWUy5/WyH7oXn9B5ou5n0/XyDfdPllVID7RWd3C/GaDHjNf1bLXw2zPFwvX/r8jPsjGsSBjq7XcL0Zkx0UvrFdH1zNFQ1Ir5HpV4Q1cHuFbeW2NE+YEVVVMYjfE/mJ7A+DIwRIhFWvZ80WdnGEzWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275166; c=relaxed/simple;
	bh=xflPyfFGMKye4kmK4AGn6eBGVRiTFsFbDcF+ogX1/Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbAUUgaeXq4nClqG6qmR9LnWH8Y1sE9OXCIP+3PWQa/AEs002nIXPWXdPpsCMB81YNxN8I5hzHKiH6AZgz5X/yjfphEdDQeQNcOaUwSq6Dl0ubazRE5rXry9ED4AQvjDvk1t5+ss8mIrRNoqsbTtVGc/5ppX6ZJ0vDrP9v/CT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fYsRSshu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEP3WS005790
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4ytYg5wIvSCF5vB30aPZTmXG
	+DpyzHPysWUr4KYo2nU=; b=fYsRSshuTvO+iBk5tEhQCKqPmdb2or6LOosi9rAC
	sE8n0mV26VqAOMrivDpDydH4xNXeb3a6WM/rCkaPQ4XhSCaJPOutS4w830G1eZ4b
	pjagGIwREvBJ0Zl3PayxpEFyQD0p0DysLmVSDRNnltMj9PPJHVYkkyBGLf42Ikms
	aiW4Sfojd2PpUhxTt2ScCh+Q+66/Rhv74ouHZOBoKOKTHtKwnIWxb57jbAibCUwk
	0Z614UqV4ncT72ley/V4M0nB1MMfYz/HqWVCLXbYc+pD3AczEXH/vJkavOAD0mQe
	J+CzFpbxF3KXG7sTqHFetW/ssn+EwLQRpL+yjYzOMw2uuw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27jah2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:06:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7916b05b94bso49344876d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761275163; x=1761879963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ytYg5wIvSCF5vB30aPZTmXG+DpyzHPysWUr4KYo2nU=;
        b=amfdsq0v2ixfWqMlGeszF2Y96iKPpuLvgcDYXQ1TmxyciWR3LKQRFV0qosaUmukybX
         nkst2TxnnjqWcjXG4BxyAK22+j5iJfbiO/jvEKXtDUA60xaG+7pizbkLiNGEBhyq7Fd4
         s/l/T7gePhjnN7yq6G7RTPR4Qn51t4yn6uOJ2ET7i09c6c2WT8ZGEogsLw7JljKUVKk6
         Wck55dXIsntQ00lWhJLU05F8dI6RdpCUTRBQylxiCPvEvEIPpfiYKowU62QiqzW0QiGs
         JXW6scHCW+XTEuSempsMTDxDCJbNmyc9FHmML5BCiqS/dpeQ1OvfTFtNpKgNFkPEEciM
         PLgA==
X-Forwarded-Encrypted: i=1; AJvYcCWQEue+OUlj8QkIrtH6euO/YYzI2Ga3g8yLtoZVac1xo4YAJzgyL9lIANHxMo+1XbngmDhoPcDM6pcXdO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS3HeiJHNQ5IiQgMfnWHfR/GFNXvMEnN/aFSom/UWbfvrRt34R
	s3k8RsdeGX2hKigCqpGGwxo8RZaOXHAEgc7RMUPNpoxTEk1P4L765c+2MCC4kVyDBZEL7Jb8TyL
	JG+9rw4wZpfKyE6Zi1XWyFz00/5B9YSMw9I1rtLSQxWn3T1ffdmGSMr+tfrQHf/d/gqc=
X-Gm-Gg: ASbGncu8sN2TAp8GHQZX4olUQsHDygUvofyftHQH0FwBsA5I05D2KGa+wE17cCRMGUV
	lNfFs5R1wv3s88ksfmrhZPV53v8Wp2d5OjIafXu/qK0FrheYh0iemSNFGxTKoWT9XRSqC9uWu3l
	VqBj5yDM2DTeMlNie7AkgEz9EQpi95Pb5AgiqEbhbJtMBC8do4fugjJ9KQj9NWfQQnCzXzOhPo4
	h86SxKWpfEjISJzrp3M/zfhdVyjfsrVaNU3QnyK+fG6Ov47f2C5hWOdkgw/zIgxm1VqLj6yODSn
	WEi4oLEGKnFtetLVGgiWGtlSvdIvJCtmSvCvt5MxpQxyTTg6if2CNpXzO/HgaqaWL8VIaSeNu4R
	7kzjFQBUBuLkvzlfqQ0cOifS1v/U4zJEvjFdabRsNY2kG6mi4DLu80gI5lkpJ
X-Received: by 2002:a05:6214:27ef:b0:87c:dff0:7c1a with SMTP id 6a1803df08f44-87cdff07dd8mr268989846d6.13.1761275162826;
        Thu, 23 Oct 2025 20:06:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkcreB+0KcKKEZo2+yTp/pEKF7bGUgeuh4BxWqNNLIOy98t8bmDiGhZCsT7X+sb2q+MU8G/Q==
X-Received: by 2002:a05:6214:27ef:b0:87c:dff0:7c1a with SMTP id 6a1803df08f44-87cdff07dd8mr268989566d6.13.1761275162274;
        Thu, 23 Oct 2025 20:06:02 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9e824a77sm27351446d6.60.2025.10.23.20.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:06:01 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:05:50 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Message-ID: <aPrtDoW7QlNSH12X@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-5-yuanjie.yang@oss.qualcomm.com>
 <7yrjpxx2uqb7ox6yk55hsdj2cgexvcoqjjutmhnjokciy7pnl4@a3zdvmn7wmto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7yrjpxx2uqb7ox6yk55hsdj2cgexvcoqjjutmhnjokciy7pnl4@a3zdvmn7wmto>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX4OtHaD1DUoEV
 R+szNySmcy3aH1WxcltRMcf1BUFEV7/l/0LQcYQJTT1dwyc9IbWi/xs+CFFCKUQBEx9Zik0bOgn
 AIQczaOkF0Fij+1a9QPpr2fUSKb3rjzWCPjQoyfwnxC8aSaihIFVhqSkjBpMvyI1+9Nu/tg8+vY
 r8MqsCGI69woxkDGLRRkFkYaFL5E07g16T3N+Jcxxrk7uFBLeouZCPCKxZEjEPlpmlVXWp5Eetp
 ikG4roEGZoU0BrVZSKKGrsAwVlubYjRnBtvYdh6VDPqULJkGn8euW3UWfVxFTZHrGbjJ5y36ArJ
 zuUC/dabH0hDyTroxXiA08gloo1FHLI9f+OrXrDmidmtNjXFUcetZMy500b5AzgoXQatlnVlDBR
 V0NUNX0oC/t4CsDpDN3I1K8gMk+XiA==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68faed1b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1k5Ug2qgVVKK0g3C12EA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: SToAnzsB1ZUseaQsPTRRqYSIsGcWzH2m
X-Proofpoint-ORIG-GUID: SToAnzsB1ZUseaQsPTRRqYSIsGcWzH2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On Thu, Oct 23, 2025 at 03:01:14PM +0300, Dmitry Baryshkov wrote:
> On Thu, Oct 23, 2025 at 03:53:53PM +0800, yuanjie yang wrote:
> > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > Add mdss support for the Qualcomm Kaanapali platform.
> > 
> > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_mdss.c | 22 ++++++++++++++++++++++
> >  include/linux/soc/qcom/ubwc.h  |  1 +
> >  2 files changed, 23 insertions(+)
> 
> Where can I find the UBWC config for Kaanapali?

https://lore.kernel.org/all/20250930-kaana-gpu-support-v1-1-73530b0700ed@oss.qualcomm.com/
I see UBWC config is in gpu patch list, so I don't push UBWC config patch in my patch list.

so I should wait gpu patch applied and rebase this patch ?

Thanks,
Yuanjie

> > 
> > diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> > index 2d0e3e784c04..665751d2b999 100644
> > --- a/drivers/gpu/drm/msm/msm_mdss.c
> > +++ b/drivers/gpu/drm/msm/msm_mdss.c
> > @@ -243,6 +243,24 @@ static void msm_mdss_setup_ubwc_dec_50(struct msm_mdss *msm_mdss)
> >  	writel_relaxed(1, msm_mdss->mmio + REG_MDSS_UBWC_PREDICTION_MODE);
> >  }
> >  
> > +static void msm_mdss_setup_ubwc_dec_60(struct msm_mdss *msm_mdss)
> > +{
> > +	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
> > +	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
> > +		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit);
> > +
> > +	if (data->ubwc_bank_spread)
> > +		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
> > +
> > +	if (data->macrotile_mode)
> > +		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
> > +
> > +	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
> > +
> > +	writel_relaxed(5, msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
> > +	writel_relaxed(1, msm_mdss->mmio + REG_MDSS_UBWC_PREDICTION_MODE);
> > +}
> > +
> >  static int msm_mdss_enable(struct msm_mdss *msm_mdss)
> >  {
> >  	int ret, i;
> > @@ -296,6 +314,9 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
> >  	case UBWC_5_0:
> >  		msm_mdss_setup_ubwc_dec_50(msm_mdss);
> >  		break;
> > +	case UBWC_6_0:
> > +		msm_mdss_setup_ubwc_dec_60(msm_mdss);
> > +		break;
> >  	default:
> >  		dev_err(msm_mdss->dev, "Unsupported UBWC decoder version %x\n",
> >  			msm_mdss->mdss_data->ubwc_dec_version);
> > @@ -552,6 +573,7 @@ static const struct msm_mdss_data data_153k6 = {
> >  };
> >  
> >  static const struct of_device_id mdss_dt_match[] = {
> > +	{ .compatible = "qcom,kaanapali-mdss", .data = &data_57k },
> >  	{ .compatible = "qcom,mdss", .data = &data_153k6 },
> >  	{ .compatible = "qcom,msm8998-mdss", .data = &data_76k8 },
> >  	{ .compatible = "qcom,qcm2290-mdss", .data = &data_76k8 },
> > diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
> > index 1ed8b1b16bc9..0a4edfe3d96d 100644
> > --- a/include/linux/soc/qcom/ubwc.h
> > +++ b/include/linux/soc/qcom/ubwc.h
> > @@ -52,6 +52,7 @@ struct qcom_ubwc_cfg_data {
> >  #define UBWC_4_0 0x40000000
> >  #define UBWC_4_3 0x40030000
> >  #define UBWC_5_0 0x50000000
> > +#define UBWC_6_0 0x60000000
> 
> This should be tied with the ubwc config changes as this chunk goes into
> a different subsystem.
> 
> >  
> >  #if IS_ENABLED(CONFIG_QCOM_UBWC_CONFIG)
> >  const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void);
> > -- 
> > 2.34.1
> > 
> 
> -- 
> With best wishes
> Dmitry

