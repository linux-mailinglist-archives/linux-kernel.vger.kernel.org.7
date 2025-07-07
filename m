Return-Path: <linux-kernel+bounces-719535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6CAAFAF4A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 11:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2013B23DE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 09:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C16028CF6F;
	Mon,  7 Jul 2025 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kuQ/ec3y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F628BABF
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751879598; cv=none; b=Yu+VcuVAE3nWiI/9xWlBkQldTBwy8Oz7EI9V1v+G+RsQ9ZRGAC2m1LBvY9Uqb0xuVq5F4CF4EuEX1RWUKnEMz3buveXOQ7AahvihAH5TvN6ZCW0wSooeJDulKp/mRXS+Gsqx1jdJGCxpbBLd51YW20bK/UcE8zNHrpcyis1Gm4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751879598; c=relaxed/simple;
	bh=9e/j/TisrlOj1sag55zujCuH8hWns0AKFl54gX2S1nI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BonbCX0/EiB0WG/0lLJUiQQYIyg52tmiCxOLhhWaAMH9fV0beUoZUvRStWRudj+dKtIkYLh5mvpO39UP5A1HZCLgIB2+gKkEgwyWLcZb18cV+3Ov0HIoqTLtrJK/8N4RJ3hDtmlqhiKJgALgzyh0YsZ2Hpqo9B021UJN0VPJKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kuQ/ec3y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566MviLZ010726
	for <linux-kernel@vger.kernel.org>; Mon, 7 Jul 2025 09:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0ToO/s6QUGdOhjPrMVyWmlZz
	BvPNufyts6PWBcHykjY=; b=kuQ/ec3yxvLyAJ/kMeVyzb0NQzGRo/iOFnVFIG1k
	ArgaQIIsVWVWKyfiNA0gcbLRHvhOBZ+mT8y1S+nK6x97WoTtt9LMGrNJO0fX3sRW
	x4WS6u4Pj+41raEhgKrUT9Cpup9cwMlmINuXEQtbc9c+SUghUzDoYD2Q0UFy4ZcJ
	+cie/3ays9tMcF1T37nK/wTqYh1Sc+fsrQ+CBEUKSBQpQKdymmIK1nYVTSh1WXBv
	vdNtf3RKlGv47vG2ydu+R/kFGH/+K5DAwBvh/W+Uw3XptbujXxtjLRs5ECiHvOAN
	lqM7v7yeKK35hHZlmAm7FALiqGjsx+mblGPrRwNqmp7emg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvtkbcwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 09:13:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d399070cecso515123885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 02:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751879594; x=1752484394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ToO/s6QUGdOhjPrMVyWmlZzBvPNufyts6PWBcHykjY=;
        b=HHXmssOY/mT1oKivkxrdtjnksaXBmGQEyWV4bDzA7v4feFj1I2t6950wm36sQmflBc
         LhMN5rYZSMWn6x63aH5GBn0pR+xlU+hn927c406vzDIaPC4ihtJak/EHZgov5pUzMgEd
         FHGiuptufTxDGXw67FNK3dNGxaTwjf+FEXUjSSYy0HxWMsRerQAS4jgm5OJEVALkAVYX
         6x2gboAEOSA9mvMAxqeC4Y70IwaAhHlw6i/35Fv3sLaFAM0wMY01pcbj3S3tadbND02D
         EIdvPyluljhooO+vDJ0p4BiUQKBKwpt/X8anQMfiQGKN2I3ffE4JOwDlMkp4To8pIzJy
         Ga2A==
X-Forwarded-Encrypted: i=1; AJvYcCVRlDrc9vmeFZhLPS3ez5a15NgxaBJww3plKKwqETDQhwgz1HAeZ5ew1YOV9CUFQsb5amHcUjr4ShyTYKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfc8V++XruPVHNwi9LY2Da/l30ESmmEyK7Dt11sYiDKXNqkJXi
	kp3kJS/Y6/8Xkpc+oXnGHKucS3mdpw5oCgOuXx9GrYcprtzVMLbVsSzn9OlbjtcMLTwXc+Vgzjq
	NwXCSruqXkTXlOScMufK6tKv3WtY58iL+ERRK5S9SUjkibX15DaHa+gQfV77xzsLA5F0=
X-Gm-Gg: ASbGncsEG5w5wBHQuyObvdQYBtF+xmnUdNQjlq41R1ht0+5LJZoksBsbXY7VMx7oANx
	vAdXXzkGiwticW6KSTndlXX0CA65xY8VjQmpc/2L2ndcRuQk6gMkorlXGzPVDp5lUJDLZqrXRBR
	YeSHjmtE9PZppVl2/hl5HwSqMXcHPnsklyyt16GQkQb/RLZ2IHEf8QtLvMtsGuI2MnTruqWTTes
	tsT4ERlx76LjIz5wtJGlK01vfixR6Rfi12f5NU3SXmFoWeOUsiqVDGdse7F6XaOW6FV39S3kttR
	aW3ECodBPoFsdkcET3lUUgPlxfCGK21nnnO2HES4yzEOmbQ1jbFRZT0=
X-Received: by 2002:a05:620a:468c:b0:7cd:4b5b:a1fc with SMTP id af79cd13be357-7d5df0ccfe3mr1619155485a.7.1751879594406;
        Mon, 07 Jul 2025 02:13:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAFe4T5tQYs9PjuLRj+UZEMUkkXmUbbWQsMax8XLLrVdvN7NAhevIHROXyKYcWrOl7ui+sRQ==
X-Received: by 2002:a05:620a:468c:b0:7cd:4b5b:a1fc with SMTP id af79cd13be357-7d5df0ccfe3mr1619152285a.7.1751879593840;
        Mon, 07 Jul 2025 02:13:13 -0700 (PDT)
Received: from trex (97.red-79-144-186.dynamicip.rima-tde.net. [79.144.186.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0af7sm9802520f8f.35.2025.07.07.02.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 02:13:13 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 7 Jul 2025 11:13:11 +0200
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, krzk+dt@kernel.org,
        bryan.odonoghue@linaro.org, quic_vgarodia@quicinc.com,
        mchehab@kernel.org, robh@kernel.org, conor+dt@kernel.org,
        konradybcio@kernel.org, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] media: venus: hfi_plat_v6_lite: Populate decode
 capabilities
Message-ID: <aGuPpzU0VCg45Plg@trex>
References: <20250626135931.700937-1-jorge.ramirez@oss.qualcomm.com>
 <20250626135931.700937-4-jorge.ramirez@oss.qualcomm.com>
 <bac6a881-90b6-4f33-d9a8-61aa8daea330@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bac6a881-90b6-4f33-d9a8-61aa8daea330@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA1MiBTYWx0ZWRfX23rfMLt706+i
 Tz3XmpQkK4VQ7K+yhizdtP4+ftbpdkMIePlXtJftRj1XGYLoyyjLFBg1ffnRADxdRYW4yYmbFJE
 tndCWG8Ja/E0oEXGB1yvT+Z4qb9weqqWmNBNIeiSK0Gne3ZNJ+KANKtSDluKhQWDnqtKhxzlM0N
 J/EiFrufXkHH7870Tv+cN3nz2S4T6ZrGT4t15XJE+0mZ8iWjfV6RJuF5mcrIBuejXpqiJS1b0Jq
 qpuJRFhMbLdg4Kl1OV2EOzJTOEVq8Qvuln3j5h8JeMvt+9QgLtkQlIYGPycuCyCRllHpuh0OCGr
 Al8ez5mhvb4Orfy1/idTfLsrd5qoj8OECelz7bDkjNmf3WMkazD4mpzD2iUKSrHB0RFGoiUEBgS
 Rdd5OhFuaAkIte8kzQkDA5ZlUXTpxyOUoLneqASVZCPQUaIHemMsBwUHku2pqMOhZwGX3rQ3
X-Authority-Analysis: v=2.4 cv=Vq0jA/2n c=1 sm=1 tr=0 ts=686b8fab cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=oX6B8lV6/A+qF9mARCc04Q==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=BJ39GPuVWatAwBIpdsYA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 21C-2Q3BxAyeZH06YKlR7c9psUtWJZU2
X-Proofpoint-GUID: 21C-2Q3BxAyeZH06YKlR7c9psUtWJZU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507070052

On 27/06/25 19:02:13, Dikshita Agarwal wrote:
> 
> 
> On 6/26/2025 7:29 PM, Jorge Ramirez-Ortiz wrote:
> > Add hfi platform file with decoding capabilities for hfi v6_lite.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/venus/Makefile    |   2 +-
> >  .../media/platform/qcom/venus/hfi_platform.c  |   2 +
> >  .../media/platform/qcom/venus/hfi_platform.h  |   1 +
> >  .../qcom/venus/hfi_platform_v6_lite.c         | 148 ++++++++++++++++++
> >  4 files changed, 152 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/media/platform/qcom/venus/hfi_platform_v6_lite.c
> > 
> > diff --git a/drivers/media/platform/qcom/venus/Makefile b/drivers/media/platform/qcom/venus/Makefile
> > index 91ee6be10292..4a6a942db58b 100644
> > --- a/drivers/media/platform/qcom/venus/Makefile
> > +++ b/drivers/media/platform/qcom/venus/Makefile
> > @@ -5,7 +5,7 @@ venus-core-objs += core.o helpers.o firmware.o \
> >  		   hfi_venus.o hfi_msgs.o hfi_cmds.o hfi.o \
> >  		   hfi_parser.o pm_helpers.o dbgfs.o \
> >  		   hfi_platform.o hfi_platform_v4.o \
> > -		   hfi_platform_v6.o hfi_plat_bufs_v6.o \
> > +		   hfi_platform_v6.o hfi_plat_bufs_v6.o hfi_platform_v6_lite.o \
> s/hfi_platform_v6_lite/hfi_platform_v4_lite

will remove, will use platform_v4 instead

> >  
> >  venus-dec-objs += vdec.o vdec_ctrls.o
> >  venus-enc-objs += venc.o venc_ctrls.o
> > diff --git a/drivers/media/platform/qcom/venus/hfi_platform.c b/drivers/media/platform/qcom/venus/hfi_platform.c
> > index 643e5aa138f5..f56b8f9946d7 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_platform.c
> > +++ b/drivers/media/platform/qcom/venus/hfi_platform.c
> > @@ -13,6 +13,8 @@ const struct hfi_platform *hfi_platform_get(enum hfi_version version)
> >  		return &hfi_plat_v4;
> >  	case HFI_VERSION_6XX:
> >  		return &hfi_plat_v6;
> > +	case HFI_VERSION_6XX_LITE:
> > +		return &hfi_plat_v6_lite;
> update here as well.

yes, this function wont get changed

> >  	default:
> >  		break;
> >  	}
> > diff --git a/drivers/media/platform/qcom/venus/hfi_platform.h b/drivers/media/platform/qcom/venus/hfi_platform.h
> > index ec89a90a8129..6356e4bd0de2 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_platform.h
> > +++ b/drivers/media/platform/qcom/venus/hfi_platform.h
> > @@ -58,6 +58,7 @@ struct hfi_platform {
> >  
> >  extern const struct hfi_platform hfi_plat_v4;
> >  extern const struct hfi_platform hfi_plat_v6;
> > +extern const struct hfi_platform hfi_plat_v6_lite;
> ditto

neither this one

> >  
> >  const struct hfi_platform *hfi_platform_get(enum hfi_version version);
> >  unsigned long hfi_platform_get_codec_vpp_freq(enum hfi_version version, u32 codec,
> > diff --git a/drivers/media/platform/qcom/venus/hfi_platform_v6_lite.c b/drivers/media/platform/qcom/venus/hfi_platform_v6_lite.c
> > new file mode 100644
> > index 000000000000..41958a3e353b
> > --- /dev/null
> > +++ b/drivers/media/platform/qcom/venus/hfi_platform_v6_lite.c
> > @@ -0,0 +1,148 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2025, The Linux Foundation. All rights reserved.
> > + */
> > +#include "hfi_platform.h"
> > +
> > +static const struct hfi_plat_caps caps[] = {
> > +{
> > +	.codec = HFI_VIDEO_CODEC_H264,
> > +	.domain = VIDC_SESSION_TYPE_DEC,
> > +	.caps[0] = {HFI_CAPABILITY_FRAME_WIDTH, 128, 1920, 1},
> > +	.caps[1] = {HFI_CAPABILITY_FRAME_HEIGHT, 128, 1080, 1},
> > +	.caps[2] = {HFI_CAPABILITY_MBS_PER_FRAME, 64, 8160, 1},
> > +	.caps[3] = {HFI_CAPABILITY_BITRATE, 1, 60000000, 1 },
> > +	.caps[4] = {HFI_CAPABILITY_MBS_PER_SECOND, 64, 244800, 1},
> > +	.caps[5] = {HFI_CAPABILITY_FRAMERATE, 1, 120, 1},
> > +	.caps[6] = {HFI_CAPABILITY_MAX_VIDEOCORES, 0, 1, 1},
> > +	.num_caps = 7,
> > +	.pl[0] = {HFI_H264_PROFILE_BASELINE, HFI_H264_LEVEL_1},
> > +	.pl[1] = {HFI_H264_PROFILE_MAIN, HFI_H264_LEVEL_41},
> > +	.pl[2] = {HFI_H264_PROFILE_HIGH, HFI_H264_LEVEL_5},
> > +	.pl[3] = {HFI_H264_PROFILE_CONSTRAINED_BASE, HFI_H264_LEVEL_41},
> > +	.pl[4] = {HFI_H264_PROFILE_CONSTRAINED_HIGH, HFI_H264_LEVEL_41},
> what is the reference for these values?

what do you mean? what should be the reference? I didnt see a downstream
equivalente to base on so based on the 4XX settings these seem
consistent.

IS there any internal document that you can point me to please?


> > +	.num_pl = 5,
> > +	.fmts[0] = {HFI_BUFFER_OUTPUT, HFI_COLOR_FORMAT_NV12_UBWC},
> > +	.fmts[1] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12_UBWC},
> > +	.fmts[2] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
> > +	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
> > +	.num_fmts = 4,
> > +}, {
> > +	.codec = HFI_VIDEO_CODEC_HEVC,
> > +	.domain = VIDC_SESSION_TYPE_DEC,
> > +	.caps[0] = {HFI_CAPABILITY_FRAME_WIDTH, 128, 1920, 1},
> > +	.caps[1] = {HFI_CAPABILITY_FRAME_HEIGHT, 128, 1080, 1},
> > +	.caps[2] = {HFI_CAPABILITY_MBS_PER_FRAME, 64, 8160, 1},
> > +	.caps[3] = {HFI_CAPABILITY_BITRATE, 1, 60000000, 1 },
> > +	.caps[4] = {HFI_CAPABILITY_MBS_PER_SECOND, 64, 244800, 1},
> > +	.caps[5] = {HFI_CAPABILITY_FRAMERATE, 1, 120, 1},
> > +	.caps[6] = {HFI_CAPABILITY_MAX_VIDEOCORES, 0, 1, 1},
> > +	.num_caps = 7,
> > +	.pl[0] = {HFI_HEVC_PROFILE_MAIN, HFI_HEVC_LEVEL_5 | HFI_HEVC_TIER_MAIN},
> > +	.pl[1] = {HFI_HEVC_PROFILE_MAIN10, HFI_HEVC_LEVEL_5 | HFI_HEVC_TIER_MAIN},
> what is the reference for these values?

same as above.

what internal documents do you typically reference to? Havent seen these
references in previous commits.

could you clarify please?


> > +	.num_pl = 2,
> > +	.fmts[0] = {HFI_BUFFER_OUTPUT, HFI_COLOR_FORMAT_NV12_UBWC},
> > +	.fmts[1] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12_UBWC},
> > +	.fmts[2] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
> > +	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
> > +	.num_fmts = 4,
> > +}, {
> > +	.codec = HFI_VIDEO_CODEC_VP9,
> > +	.domain = VIDC_SESSION_TYPE_DEC,
> > +	.caps[0] = {HFI_CAPABILITY_FRAME_WIDTH, 128, 1920, 1},
> > +	.caps[1] = {HFI_CAPABILITY_FRAME_HEIGHT, 128, 1080, 1},
> > +	.caps[2] = {HFI_CAPABILITY_MBS_PER_FRAME, 64, 8160, 1},
> > +	.caps[3] = {HFI_CAPABILITY_BITRATE, 1, 60000000, 1 },
> > +	.caps[4] = {HFI_CAPABILITY_MBS_PER_SECOND, 64, 244800, 1},
> > +	.caps[5] = {HFI_CAPABILITY_FRAMERATE, 1, 120, 1},
> > +	.caps[6] = {HFI_CAPABILITY_MAX_VIDEOCORES, 0, 1, 1},
> > +	.num_caps = 7,
> > +	.pl[0] = {HFI_VP9_PROFILE_P0, 200},
> > +	.pl[1] = {HFI_VP9_PROFILE_P2_10B, 200},
> > +	.num_pl = 2,
> > +	.fmts[0] = {HFI_BUFFER_OUTPUT, HFI_COLOR_FORMAT_NV12_UBWC},
> > +	.fmts[1] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12_UBWC},
> > +	.fmts[2] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
> > +	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
> > +	.num_fmts = 4,
> > +} };
> > +
> > +static const struct hfi_plat_caps *get_capabilities(unsigned int *entries)
> > +{
> > +	*entries = ARRAY_SIZE(caps);
> > +	return caps;
> > +}
> > +
> > +static void get_codecs(u32 *enc_codecs, u32 *dec_codecs, u32 *count)
> > +{
> > +	*enc_codecs = 0x0;
> > +	*dec_codecs = HFI_VIDEO_CODEC_H264 | HFI_VIDEO_CODEC_HEVC |
> > +		      HFI_VIDEO_CODEC_VP9;
> > +	*count = 3;
> > +}
> > +
> > +static const struct hfi_platform_codec_freq_data codec_freq_data[] = {
> > +	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_DEC, 440, 0, 440 },
> > +	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_DEC, 440, 0, 440 },
> > +	{ V4L2_PIX_FMT_VP9, VIDC_SESSION_TYPE_DEC, 440, 0, 440 },
> > +};
> > +
> > +static const struct hfi_platform_codec_freq_data *
> > +get_codec_freq_data(u32 session_type, u32 pixfmt)
> > +{
> > +	const struct hfi_platform_codec_freq_data *data = codec_freq_data;
> > +	unsigned int i, data_size = ARRAY_SIZE(codec_freq_data);
> > +	const struct hfi_platform_codec_freq_data *found = NULL;
> > +
> > +	for (i = 0; i < data_size; i++) {
> > +		if (data[i].pixfmt == pixfmt &&
> > +		    data[i].session_type == session_type) {
> > +			found = &data[i];
> > +			break;
> > +		}
> > +	}
> > +
> > +	return found;
> > +}
> > +
> > +static unsigned long codec_vpp_freq(u32 session_type, u32 codec)
> > +{
> > +	const struct hfi_platform_codec_freq_data *data;
> > +
> > +	data = get_codec_freq_data(session_type, codec);
> > +	if (data)
> > +		return data->vpp_freq;
> > +
> > +	return 0;
> > +}
> > +
> > +static unsigned long codec_vsp_freq(u32 session_type, u32 codec)
> > +{
> > +	const struct hfi_platform_codec_freq_data *data;
> > +
> > +	data = get_codec_freq_data(session_type, codec);
> > +	if (data)
> > +		return data->vsp_freq;
> > +
> > +	return 0;
> > +}
> > +
> > +static unsigned long codec_lp_freq(u32 session_type, u32 codec)
> > +{
> > +	const struct hfi_platform_codec_freq_data *data;
> > +
> > +	data = get_codec_freq_data(session_type, codec);
> > +	if (data)
> > +		return data->low_power_freq;
> > +
> > +	return 0;
> > +}
> > +
> > +const struct hfi_platform hfi_plat_v6_lite = {
> > +	.codec_vpp_freq = codec_vpp_freq,
> > +	.codec_vsp_freq = codec_vsp_freq,
> > +	.codec_lp_freq = codec_lp_freq,
> > +	.codecs = get_codecs,
> > +	.capabilities = get_capabilities,
> > +	.bufreq = hfi_plat_bufreq_v6,
> buffer requirement should come from firmware, pls drop.

yes, this will be hfi_plat_v4 only

> > +};
> 
> lot of code duplication here, pls see the possibility to commonize the
> > code.

this file is no longer needed

> 
> Thanks,
> Dikshita

