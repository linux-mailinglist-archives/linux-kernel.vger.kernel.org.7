Return-Path: <linux-kernel+bounces-868025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A574C042D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14AF71A012A6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC452690D5;
	Fri, 24 Oct 2025 02:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vja0226+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736E0260592
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274431; cv=none; b=WDkaDrKSaLj1+KB9wFi4SMajutyX1yAboUN5VYuxnwR5PnZl7DyqBsz2qas3qXwyV9LtOWKvvf/QPehUajV+6zxLhsiQRz5j+qAQrXk2PiDN2WirqKLUbdSqrkiWrNeD9TgyYm2aERouTRmbZyqCnlJN+7KxsOO3eqyqdO8vra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274431; c=relaxed/simple;
	bh=U+R/krFdn2oQp4eD5VO+HFcwd5Bqsa7nZCUpHpx/EXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoM1IrK35/nkSb4+0uif3eRA5BKGbWHrjEWSAWXzUwvIznwvO5jnAQvrU9gjIgXILizJoJ+u7KtiFXsJJskCcUNdxiez/gRlDYdKwgxguU7QJfqWF5pJkZsW0E34z6WMoM4kRdC7+ERWI0O3zQPUTzGVkWd+6s4c+Fpa+fa91Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vja0226+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEcGtC018614
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1AnIMj/fZtv1MiyLm9YqLVrG
	zqa9XAiNsyWK56Y5qGo=; b=Vja0226+k7TqLJsdNzB7NAhTv83mniRwbs+/iN4l
	bAutC44mvZXPxxhNkhut4dLi6e0/ybvoCnBm2SU0bDHBJtSnHBIF4r9V+HetGgnm
	auNxwl3Js//PqXhkxNV9hkRojRaBc5e5JiUpVER8amWVHKgG+RiMCtiPeHFgfRis
	8KdxXA90O7WiQVY8AqG9uPax7YQ8SzPEgr6ka4L/L4ri4hcolF/qYlF2CMofYGcD
	uJ9NFoDKXrmpFcM8yAxm1QW65cslDyL1u3q1wya90wTnfysYOPzHaoAQnLje6fQO
	sQdaNIERLIaz2boCfV8IC5sKQyBOl38+l1QdkmxTDyBtOA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08ptt25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:53:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c1ed305b4so33659706d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761274426; x=1761879226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AnIMj/fZtv1MiyLm9YqLVrGzqa9XAiNsyWK56Y5qGo=;
        b=HJVHIpSd1KBm/QgbBhZlhC/0dXWlCbtIbWOrFFxj2VEIGE8QG7XXMYfxpR4zyVmHiO
         BEXJPS+bMiRhG/VYChL/nXNAecFQVCtTsMVhe3nJzN2OxHQhG/YpQqpNss13hc7atAOy
         ZG1KIQd8y4z+GPRIgCsj1nfl3si5/vODjmte6/4/mc9aR6RDvumWQtty+MJWVlZSbrq4
         Ut3zOK3LFx4P5nkR6OVbbs/DEYeEIht7j/1l/0sO8ncKV2C4/er+S2gWdHEf8CL6ihmX
         12qWIZPcjKwHNFq6IIHrwWnvMkXPVKnFBZe5yUfmzpWTDwu4U7QHQVWyPCgyE6oHeXIt
         MdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUIYUW7Ze6SdNKUKiVACkNkq+aV3mkm7dyP2XPjnc55IWAGK0caMWEu/RTaAtJxg2eR98NPQ8H2aaL9S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuY1XmH+hYgeSvyD3fRClwVoay6TK+qnnbpGKxcnnjTt9Yr57t
	HxKn7CRXpZWtXOVRcxYbP+Oj8Z0XRhGUKsZU19QbQ4P+VOIw6latmn9Zys6BaKdA2sD0lZqJ6L1
	xZKe8iL57y80XSyjPFwrbTBNCJmnAI5CfPkvuF2raNbFwn/yJOBJSif6BNQzojl5JOYlCBhbzcj
	U=
X-Gm-Gg: ASbGncsng+XNCX5aYE5T+Vum5aPMzeeFhN+O5pKNnJd34Y2gJ964TYBAVxrzimFBwYy
	kKu8LF151qWFZvzS+czBz3csmYeCYmlI5WG5odZnwiVwtUzFd1DZwmKMYOAq8s/SwwxT4r8jUg4
	J2u7N7tD+td1L1/WfPoJkCJLmQMBxItlimHVHr0f+WnFwG5JCxQ8jIRVDz0nCE6jvBzVBzv5pVy
	RgC/fTqYUCF7k569KsnYkE0wuXCfx7flRXYDdNjxPqFbugAdqmEvTuEqHyIujPIO7ggLVNnSKsr
	/TKSDK6+4OjjT5UnqOmoUGgj86RzGovvHsact4yN/KXD0niuCMBZY/h/s22ZRzL3323zmxxezAN
	gjOWefpXnh5bifJEYIffqBIrAJOwkHejWeCV/4XDRYTg95Vgtv912ADlCFjkS
X-Received: by 2002:a05:6214:410e:b0:84d:5b71:8a85 with SMTP id 6a1803df08f44-87fb6439ca3mr7555946d6.31.1761274426377;
        Thu, 23 Oct 2025 19:53:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaOFp5HaH9aqEVFvfJ1oTbXXQsaapZSMekoXbvaSSF90t+H5yygdjMIo9XC0v72zQIgKxbbA==
X-Received: by 2002:a05:6214:410e:b0:84d:5b71:8a85 with SMTP id 6a1803df08f44-87fb6439ca3mr7555606d6.31.1761274425663;
        Thu, 23 Oct 2025 19:53:45 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f8fb6d2e4sm28732776d6.13.2025.10.23.19.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 19:53:45 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:53:34 +0800
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
Subject: Re: [PATCH 02/12] drm/msm/dpu: Add support for Kaanapali DPU
Message-ID: <aPrqLrOPMLzwN5k1@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-3-yuanjie.yang@oss.qualcomm.com>
 <b35l5nwswf6t4k32edqccytrfjbvaloqoh4hksfkqrqmrsx4ee@3aatdgwmxp4g>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b35l5nwswf6t4k32edqccytrfjbvaloqoh4hksfkqrqmrsx4ee@3aatdgwmxp4g>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX5LwGW7CwZElI
 Pd24z265jVD3CYPw6CNcRg8XEcOl8AP0ZqjvQxSlI9sgQtJMmd30gAx4DIxDrMBGPBua6malohH
 MSQUeTlxgqTHkBDslW9M+kBNhnoyHc4s0q+sIuscbW8TCE1xOGN5S65H1fhTltIGgeW8P26ICto
 LEs8XH7i+IO9kmvCQjmh/yWklfhC1WUGvMs/86ydebfCyWOU+qiTqRU3E3AKYwjqsuMbBpWJxKw
 itlLSp+DoRj6yxnmz+AI6AWuOhMGNWTq8ojmH6QhioZwJ2nnyLrA7bmtRp8uPcBZgNUSViTj1fV
 Ya5gM3VQbLUt5og+6v8OmjLUhEMbYzJ0fnrLZCxQwp0aRLyWhzACOW8iQEd1RNwFV72PIoKWKvS
 8jab9PTkxzobUIbB4k2VCiiZa1BYzA==
X-Proofpoint-GUID: IrEt6EpYTdwNBBKfnGB4eC2q_5td3EJK
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68faea3b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0tOC-D8kvco1IiGT83AA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: IrEt6EpYTdwNBBKfnGB4eC2q_5td3EJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

On Thu, Oct 23, 2025 at 02:56:49PM +0300, Dmitry Baryshkov wrote:
> On Thu, Oct 23, 2025 at 03:53:51PM +0800, yuanjie yang wrote:
> > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > Add support for Display Processing Unit (DPU) version 13.0
> > on the Kaanapali platform. This version introduces changes
> > to the SSPP sub-block structure. Add common block and rectangle
> > blocks to accommodate these structural modifications for compatibility.
> 
> This needs to come up differently: first implement driver changes for
> the changed SSPP blocks, then add Kaananapali catalog entries.
OK, will adjust patch order.

> > 
> > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > ---
> >  .../disp/dpu1/catalog/dpu_13_0_kaanapali.h    | 492 ++++++++++++++++++
> >  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |  44 ++
> >  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  29 +-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
> >  4 files changed, 565 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h
> > 
> > +
> > +static const struct dpu_cwb_cfg kaanapali_cwb[] = {
> > +	{
> > +		.name = "cwb_0", .id = CWB_0,
> > +		.base = 0x169200, .len = 0x20,
> > +	},
> > +	{
> > +		.name = "cwb_1", .id = CWB_1,
> > +		.base = 0x169600, .len = 0x20,
> > +	},
> > +	{
> > +		.name = "cwb_2", .id = CWB_2,
> > +		.base = 0x16A200, .len = 0x20,
> > +	},
> > +	{
> > +		.name = "cwb_3", .id = CWB_3,
> > +		.base = 0x16A600, .len = 0x20,
> 
> lowercase hex
OK, will fix.

> > +	},
> > +};
> > +
> 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > index 6641455c4ec6..5a24ed0f818c 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > @@ -241,6 +241,25 @@ static const u32 wb2_formats_rgb_yuv[] = {
> >  	.rotation_cfg = NULL, \
> >  	}
> >  
> > +/* kaanapali SSPP common configuration */
> > +#define _KAANAPALI_VIG_SBLK(scaler_ver) \
> 
> And then it gets reused for some other platform... No. Please come up
> with a generic enough name.
_KAANAPALI_VIG_SBLK --> _VIG_SBLK_REC0_REC1

This "_VIG_SBLK_REC0_REC1" is a good name here? 

> 
> > +	{ \
> > +	.cmn_blk = {.name = "cmn_blk", \
> > +		.base = 0, .len = 0x100,},	\
> 
> No, sblks shouldn't have .base set to 0. It's the main block.

OK will drop it.

> > +	.sspp_rec0_blk = {.name = "sspp_rec0", \
> > +		.base = 0x1000, .len = 0x180,},	\
> > +	.csc_blk = {.name = "csc", \
> > +		.base = 0x1800, .len = 0x100,}, \
> > +	.scaler_blk = {.name = "scaler", \
> > +		.version = scaler_ver, \
> > +		.base = 0x2000, .len = 0xec,}, \
> > +	.sspp_rec1_blk = {.name = "sspp_rec1", \
> > +		.base = 0x3000, .len = 0x180,},	\
> > +	.format_list = plane_formats_yuv, \
> > +	.num_formats = ARRAY_SIZE(plane_formats_yuv), \
> > +	.rotation_cfg = NULL, \
> > +	}
> > +
> >  #define _VIG_SBLK_ROT(scaler_ver, rot_cfg) \
> >  	{ \
> >  	.scaler_blk = {.name = "scaler", \
> > @@ -329,6 +348,9 @@ static const struct dpu_sspp_sub_blks dpu_vig_sblk_qseed3_3_3 =
> >  static const struct dpu_sspp_sub_blks dpu_vig_sblk_qseed3_3_4 =
> >  				_VIG_SBLK(SSPP_SCALER_VER(3, 4));
> >  
> > +static const struct dpu_sspp_sub_blks dpu_vig_sblk_qseed3_3_5 =
> > +				_KAANAPALI_VIG_SBLK(SSPP_SCALER_VER(3, 5));
> > +
> >  static const struct dpu_sspp_sub_blks dpu_rgb_sblk = _RGB_SBLK();
> >  
> >  static const struct dpu_sspp_sub_blks dpu_dma_sblk = _DMA_SBLK();
> > @@ -412,6 +434,11 @@ static const struct dpu_pingpong_sub_blks sc7280_pp_sblk = {
> >  	.len = 0x20, .version = 0x20000},
> >  };
> >  
> > +static const struct dpu_pingpong_sub_blks kaanapali_pp_sblk = {
> > +	.dither = {.name = "dither", .base = 0xc0,
> > +	.len = 0x40, .version = 0x30000},
> > +};
> > +
> >  /*************************************************************
> >   * DSC sub blocks config
> >   *************************************************************/
> > @@ -452,6 +479,13 @@ static const struct dpu_cdm_cfg dpu_cdm_5_x = {
> >  	.base = 0x79200,
> >  };
> >  
> > +static const struct dpu_cdm_cfg dpu_cdm_kaanapali_x = {
> 
> 13_x
OK, will fix.

> > +	.name = "cdm_0",
> > +	.id = CDM_0,
> > +	.len = 0x240,
> > +	.base = 0x19e000,
> > +};
> > +
> >  /*************************************************************
> >   * VBIF sub blocks config
> >   *************************************************************/
> > @@ -639,6 +673,10 @@ static const struct dpu_qos_lut_entry sc7180_qos_linear[] = {
> >  	{.fl = 0, .lut = 0x0011222222335777},
> >  };
> >  
> > +static const struct dpu_qos_lut_entry kaanapali_qos_linear[] = {
> > +	{.fl = 0, .lut = 0x0011223344556666},
> > +};
> > +
> >  static const struct dpu_qos_lut_entry sm6350_qos_linear_macrotile[] = {
> >  	{.fl = 0, .lut = 0x0011223445566777 },
> >  };
> > @@ -668,6 +706,10 @@ static const struct dpu_qos_lut_entry sc7180_qos_macrotile[] = {
> >  	{.fl = 0, .lut = 0x0011223344556677},
> >  };
> >  
> > +static const struct dpu_qos_lut_entry kaanapali_qos_macrotile[] = {
> > +	{.fl = 0, .lut = 0x0011223344556666},
> > +};
> > +
> >  static const struct dpu_qos_lut_entry sc8180x_qos_macrotile[] = {
> >  	{.fl = 10, .lut = 0x0000000344556677},
> >  };
> > @@ -726,3 +768,5 @@ static const struct dpu_qos_lut_entry sc7180_qos_nrt[] = {
> >  
> >  #include "catalog/dpu_10_0_sm8650.h"
> >  #include "catalog/dpu_12_0_sm8750.h"
> > +#include "catalog/dpu_13_0_kaanapali.h"
> > +
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > index f0768f54e9b3..99c81c24630f 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > @@ -208,6 +208,30 @@ struct dpu_dsc_blk {
> >  	u32 len;
> >  };
> >  
> > +/**
> > + * struct dpu_sspp_rec_blk - sspp rec sub-blk information
> 
> SSPP, REC
OK, will fix.
 
> > + * @name: string name for debug purposes
> > + * @base: offset of this sub-block relative to the block offset
> > + * @len: register block length of this sub-block
> > + */
> > +struct dpu_sspp_rec_blk {
> > +	char name[DPU_HW_BLK_NAME_LEN];
> > +	u32 base;
> > +	u32 len;
> > +};
> > +
> > +/**
> > + * struct dpu_sspp_cmn_blk - sspp common sub-blk information
> > + * @name: string name for debug purposes
> > + * @base: offset of this sub-block relative to the block offset
> > + * @len: register block length of this sub-block
> > + */
> > +struct dpu_sspp_cmn_blk {
> > +	char name[DPU_HW_BLK_NAME_LEN];
> > +	u32 base;
> > +	u32 len;
> > +};
> > +
> >  /**
> >   * enum dpu_qos_lut_usage - define QoS LUT use cases
> >   */
> > @@ -294,7 +318,9 @@ struct dpu_sspp_sub_blks {
> >  	u32 qseed_ver;
> >  	struct dpu_scaler_blk scaler_blk;
> >  	struct dpu_pp_blk csc_blk;
> > -
> > +	struct dpu_sspp_cmn_blk cmn_blk;
> > +	struct dpu_sspp_rec_blk sspp_rec0_blk;
> > +	struct dpu_sspp_rec_blk sspp_rec1_blk;
> >  	const u32 *format_list;
> >  	u32 num_formats;
> >  	const struct dpu_rotation_cfg *rotation_cfg;
> > @@ -778,6 +804,7 @@ extern const struct dpu_mdss_cfg dpu_sa8775p_cfg;
> >  extern const struct dpu_mdss_cfg dpu_sm8550_cfg;
> >  extern const struct dpu_mdss_cfg dpu_sm8650_cfg;
> >  extern const struct dpu_mdss_cfg dpu_sm8750_cfg;
> > +extern const struct dpu_mdss_cfg dpu_kaanapali_cfg;
> >  extern const struct dpu_mdss_cfg dpu_x1e80100_cfg;
> >  
> >  #endif /* _DPU_HW_CATALOG_H */
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > index 4e5a8ecd31f7..15bec44324d5 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > @@ -1505,6 +1505,7 @@ static const struct dev_pm_ops dpu_pm_ops = {
> >  };
> >  
> >  static const struct of_device_id dpu_dt_match[] = {
> > +	{ .compatible = "qcom,kaanapali-dpu", .data = &dpu_kaanapali_cfg, },
> >  	{ .compatible = "qcom,msm8917-mdp5", .data = &dpu_msm8917_cfg, },
> >  	{ .compatible = "qcom,msm8937-mdp5", .data = &dpu_msm8937_cfg, },
> >  	{ .compatible = "qcom,msm8953-mdp5", .data = &dpu_msm8953_cfg, },
> > -- 
> > 2.34.1
> > 
> 
> -- 
> With best wishes
> Dmitry

Thanks,
Yuanjie

