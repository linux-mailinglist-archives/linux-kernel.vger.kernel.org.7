Return-Path: <linux-kernel+bounces-728582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F7EB02A46
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393A3A4324C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 09:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55390A59;
	Sat, 12 Jul 2025 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OEEpMXPk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FDD21A452
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752312802; cv=none; b=BJ7JoRBfgkLDqjN/ytJkILoR3KOBvAxDASpreOQcdoY24q6T3+6h7N8s+LDegGvZf9huXpVqGGpnUZPWTnvTYjVOG8GLH+HrcCe8jZsPECpGi7wYdQye3wYOMEriU/oyHLo1OYV+uK/RKQMbx2e5+aURVxuhOSVfmoYBNE9B2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752312802; c=relaxed/simple;
	bh=5UdXn8k+oY3qC22jobCZHJUHpLut88yQEeaHyPm54ns=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNC5sgNYE6+jzzKF0wyHkqe4yP6C/SgPxV6mCRwhp1beloS0juMc/MwsfKQLH8ER0cgjQ58eSpGyEgkMhraDgoaLDy5EdlZ5nKJGvWTSb+hxSviFmkBXpKakbroNQ9oD3YdT2s4ngYccpdB/qAQXTutpRWvPC1f+iwnxLO+71ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OEEpMXPk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C9QGDP019897
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 09:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9eJIKAYvQhbBKdExfKxSSqD3
	SqghwuUjx6hXINkrmmU=; b=OEEpMXPkgsWc7EusiVf2vKXwyDVxPbkgfBHddHPd
	YSrXBj+eHiHKDwhLCtRBj8zw8opmeiOa+HmL5ab3jd8YZcJqasJe+qdbceCwZTL9
	h0dHqveieblqsOVAOGfGc4ycNJVxGZsZEChr6vqDqniGfmSaIaSosSRfyBMic1Ox
	p9CjRTgaxIuL8mMqja5CE4NOjq6xeu5HI6wEGsj/WZoJSLjGfbH8Uw4IjqSj57oi
	Y/E0Q/GHbnkCMVr4gyuScizo7/l0izbv4TR2lgCvgmQlKYITlBk7nND0EEG0KCUI
	DQN/qdaY/5QSw83vGaVWuaBH2CGfz/P+TH/ceBvjKp0ZTw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu80dca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 09:33:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a42d650185so35291921cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 02:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752312792; x=1752917592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eJIKAYvQhbBKdExfKxSSqD3SqghwuUjx6hXINkrmmU=;
        b=ejJPs6P0CMvMiRJAAIaoMj5jv4kAFLSC9ud4nCND+m/77S14ZGPj8KVxGsdk39tToQ
         hv9upzKC4SDjYrQD6JHJxCaZFsXnbvCoauoJgudonwX+UrsMh3b/U+bmTUzRNcKJ3ou9
         jrLOpdMy5eSkY5oDkrN/Tqnzg2pGs8cr1ZoOvumuYsfrBWR/zFKRssxEOV+Dj4Llaw7k
         ENM/aSdvC9EOGf0yyDPqyyvn0ceZoxKc7ChIaewf/+vR4hg9oFtA/Ufjh8mG8eHJq+Qz
         PlDGweLNvYTZt6gPeou2ZCijkIZSRidQA2BScjofsUpY3XkILN8dVkQLzcCvJbgFvB64
         0XGA==
X-Forwarded-Encrypted: i=1; AJvYcCXVE4Ds3jCI71rN/K4uhIUhjSe/Gnppt0TLJDN04peTggXRV7kC+UBErgTpTDq01GfpHUNwuP3b02MHKbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypLP6MMQsM3nz84HcR+hNLv6+pQ1b5rISUfE60Zx1mqZxqXMbB
	Iu6s0lteEGGi4BNPj4h67iln8ntcPxnRC4IMAFiWC+S6rIEFAEOykdSFhwNcZNQ4oNirzsS0Vw5
	/srCEGj+qM1fgYPZ7a56ouqb90NzygrLpoiIpZUXvkjHhifWjHy1DniRTOcSQ3suOrrA=
X-Gm-Gg: ASbGncueSOfwkbPEHBqNM75b16vPWa48Ikul1oAwZZA8jtPLnfxTbMERVigyhmN3fpQ
	LccYdUbyXITkz9ziyMlp04a1vX5yg5YrkIb0MCuHmwmi7P1WmLQahE0h6Z1y0yQhcKFtBAkuV/F
	3zjUkTB6fDEPMpd7QfeYDzWQDsxNYynPG5AAKzl7DjofIpdbGvReQW5Zy9zAXsuTOvvKwNPsl/w
	CUTvOyfrkG1SpBAME6/ScQdEUmGT4ljTcCq3QrLJIA6d/JC479G1x98a+wAU7V8BknqziIAjwFl
	5+zK8jAs/Fr00idxJ/YE6ZHEBjqYUj+U8xZ9EwObDxr97g1u/vBLteTOn2MCahUoU1qyV/TVuko
	=
X-Received: by 2002:a05:620a:472c:b0:7d3:c67f:7532 with SMTP id af79cd13be357-7de0709c6dbmr1023862385a.40.1752312792328;
        Sat, 12 Jul 2025 02:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPMIYlDxJXmo/JxnHC46PqfmGQlInNLhjU3or7FBq0Bji8zzXiaTA2X7k32WJ7OoyNKLpBxA==
X-Received: by 2002:a05:620a:472c:b0:7d3:c67f:7532 with SMTP id af79cd13be357-7de0709c6dbmr1023859185a.40.1752312791822;
        Sat, 12 Jul 2025 02:33:11 -0700 (PDT)
Received: from trex (153.red-79-144-197.dynamicip.rima-tde.net. [79.144.197.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560db56529sm5995025e9.26.2025.07.12.02.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 02:33:11 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Sat, 12 Jul 2025 11:33:09 +0200
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        bryan.odonoghue@linaro.org, quic_vgarodia@quicinc.com,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        robh@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        amit.kucheria@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] media: venus: hfi_plat_v4: Add capabilities for
 the 4XX lite core
Message-ID: <aHIr1fPSTv0nGSQc@trex>
References: <20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com>
 <20250708180530.1384330-5-jorge.ramirez@oss.qualcomm.com>
 <7d50318e-1189-15aa-8c26-9c522c3194c4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d50318e-1189-15aa-8c26-9c522c3194c4@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDA3NCBTYWx0ZWRfX07LS4nTgOkKw
 TWd/aLhsFG84fclNFx0cSlGQexhCXrXtSdD/sn4utXdfsfmsbXk4dDTuIH3TwL2B8D0hjpnSzWZ
 J1SE0p3I86IBNF3vTnzQB3cMreJrSRizg51ZxdhQBwirJW7x9Z2lvre4R619OIu4+989RwrBem3
 uko7QUPPc4KIsMG8EEXppwfFAXclRIPmTqN1bBrMoz1u0xeT4JrNM072exiALxdh0QfIcTQQv+N
 c+wKzItanpk5enGkMZjpFVq5vfQ94hOnU0JHKucAE+MBHVSz6jIQvGrEWU2Tqpk1iml6FJDdffY
 szSpOsSCBvdql4jkSbOEkx8JGc55FSFJB1JQQmsYs9z8OWFZ+A9bJ0d7p2BUW52uZI768GR1Ztr
 HrAiEVe5GKYIGjfgo42IS9Jddr5/rqHUN19pU+uzNGY+PkGPdegJ5E8HCUF5JIo73/22vdOq
X-Proofpoint-ORIG-GUID: Kv6XFvPdcQqCvyIGviEPgT_-I4BpPT7a
X-Proofpoint-GUID: Kv6XFvPdcQqCvyIGviEPgT_-I4BpPT7a
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=68722bd9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=Ki5fnJvzvo7yLsyA0quaxQ==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=RK2QijgDkECOggW0PlwA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120074

On 10/07/25 14:51:08, Dikshita Agarwal wrote:
> 
> 
> On 7/8/2025 11:35 PM, Jorge Ramirez-Ortiz wrote:
> > Populate the HFI v4 lite capability set used by the AR50_LITE video
> > core.
> > 
> > These capabilities define the supported codec formats and operational
> > limits specific to this streamlined VPU variant.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > ---
> >  .../platform/qcom/venus/hfi_platform_v4.c     | 165 +++++++++++++++---
> >  1 file changed, 145 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/venus/hfi_platform_v4.c b/drivers/media/platform/qcom/venus/hfi_platform_v4.c
> > index c8e0f8040649..4b7271468ec4 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_platform_v4.c
> > +++ b/drivers/media/platform/qcom/venus/hfi_platform_v4.c
> > @@ -245,25 +245,149 @@ static const struct hfi_plat_caps caps[] = {
> >  	.num_fmts = 4,
> >  } };
> >  
> > +static const struct hfi_plat_caps caps_lite[] = {
> > +{
> > +	.codec = HFI_VIDEO_CODEC_H264,
> > +	.domain = VIDC_SESSION_TYPE_DEC,
> > +	.caps[0] = {HFI_CAPABILITY_FRAME_WIDTH, 128, 1920, 1},
> > +	.caps[1] = {HFI_CAPABILITY_FRAME_HEIGHT, 128, 1920, 1},
> > +	.caps[2] = {HFI_CAPABILITY_MBS_PER_FRAME, 64, 8160, 1},
> > +	.caps[3] = {HFI_CAPABILITY_BITRATE, 1, 60000000, 1 },
> > +	.caps[4] = {HFI_CAPABILITY_MBS_PER_SECOND, 64, 244800, 1},
> > +	.caps[5] = {HFI_CAPABILITY_FRAMERATE, 1, 120, 1},
> > +	.caps[6] = {HFI_CAPABILITY_MAX_VIDEOCORES, 0, 1, 1},
> > +	.num_caps = 7,
> > +	.pl[0] = { HFI_H264_PROFILE_BASELINE, HFI_H264_LEVEL_5},
> > +	.pl[1] = {HFI_H264_PROFILE_MAIN, HFI_H264_LEVEL_5},
> > +	.pl[2] = {HFI_H264_PROFILE_HIGH, HFI_H264_LEVEL_5},
> > +	.pl[3] = {HFI_H264_PROFILE_CONSTRAINED_BASE, HFI_H264_LEVEL_5},
> > +	.pl[4] = {HFI_H264_PROFILE_CONSTRAINED_HIGH, HFI_H264_LEVEL_5},
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
> > +	.caps[1] = {HFI_CAPABILITY_FRAME_HEIGHT, 128, 1920, 1},
> > +	.caps[2] = {HFI_CAPABILITY_MBS_PER_FRAME, 64, 8160, 1},
> > +	.caps[3] = {HFI_CAPABILITY_BITRATE, 1, 60000000, 1 },
> > +	.caps[4] = {HFI_CAPABILITY_MBS_PER_SECOND, 64, 244800, 1},
> > +	.caps[5] = {HFI_CAPABILITY_FRAMERATE, 1, 120, 1},
> > +	.caps[6] = {HFI_CAPABILITY_MAX_VIDEOCORES, 0, 1, 1},
> > +	.num_caps = 7,
> > +	.pl[0] = {HFI_HEVC_PROFILE_MAIN, HFI_HEVC_LEVEL_5 | HFI_HEVC_TIER_HIGH0 << 28 },
> > +	.pl[1] = {HFI_HEVC_PROFILE_MAIN10, HFI_HEVC_LEVEL_5 | HFI_HEVC_TIER_HIGH0 << 28 },
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
> > +	.caps[1] = {HFI_CAPABILITY_FRAME_HEIGHT, 128, 1920, 1},
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
> > +}, {
> > +	.codec = HFI_VIDEO_CODEC_H264,
> > +	.domain = VIDC_SESSION_TYPE_ENC,
> > +	.caps[0] = {HFI_CAPABILITY_FRAME_WIDTH, 128, 1920, 1},
> > +	.caps[1] = {HFI_CAPABILITY_FRAME_HEIGHT, 128, 1920, 1},
> > +	.caps[2] = {HFI_CAPABILITY_MBS_PER_FRAME, 64, 8160, 1},
> > +	.caps[3] = {HFI_CAPABILITY_BITRATE, 1, 60000000, 1 },
> > +	.caps[4] = {HFI_CAPABILITY_MBS_PER_SECOND, 64, 244800, 1},
> > +	.caps[5] = {HFI_CAPABILITY_FRAMERATE, 1, 120, 1},
> > +	.caps[6] = {HFI_CAPABILITY_MAX_VIDEOCORES, 0, 1, 1},
> > +	.caps[7] = {HFI_CAPABILITY_HIER_P_NUM_ENH_LAYERS, 0, 6, 1},
> > +	.caps[8] = {HFI_CAPABILITY_ENC_LTR_COUNT, 0, 4, 1},
> > +	.caps[9] = {HFI_CAPABILITY_MBS_PER_SECOND_POWERSAVE, 0, 244800, 1},
> > +	.caps[10] = {HFI_CAPABILITY_I_FRAME_QP, 0, 51, 1},
> > +	.caps[11] = {HFI_CAPABILITY_P_FRAME_QP, 0, 51, 1},
> > +	.caps[12] = {HFI_CAPABILITY_B_FRAME_QP, 0, 51, 1},
> > +	.caps[13] = {HFI_CAPABILITY_SLICE_BYTE, 1, 10, 1},
> > +	.caps[14] = {HFI_CAPABILITY_SLICE_MB, 1, 10, 1},
> > +	.num_caps = 15,
> > +	.pl[0] = {HFI_H264_PROFILE_BASELINE, HFI_H264_LEVEL_5},
> > +	.pl[1] = {HFI_H264_PROFILE_MAIN, HFI_H264_LEVEL_5},
> > +	.pl[2] = {HFI_H264_PROFILE_HIGH, HFI_H264_LEVEL_5},
> > +	.pl[3] = {HFI_H264_PROFILE_CONSTRAINED_BASE, HFI_H264_LEVEL_5},
> > +	.pl[4] = {HFI_H264_PROFILE_CONSTRAINED_HIGH, HFI_H264_LEVEL_5},
> > +	.num_pl = 5,
> > +	.fmts[0] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_NV12},
> > +	.fmts[1] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_NV12_UBWC},
> > +	.fmts[2] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_YUV420_TP10_UBWC},
> > +	.fmts[3] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_P010},
> 10 bit encoder is not supported on AR50 LITE.
> > +	.num_fmts = 4,
> > +}, {
> > +	.codec = HFI_VIDEO_CODEC_HEVC,
> > +	.domain = VIDC_SESSION_TYPE_ENC,
> > +	.caps[0] = {HFI_CAPABILITY_FRAME_WIDTH, 128, 1920, 1},
> > +	.caps[1] = {HFI_CAPABILITY_FRAME_HEIGHT, 128, 1920, 1},
> > +	.caps[2] = {HFI_CAPABILITY_MBS_PER_FRAME, 64, 8160, 1},
> > +	.caps[3] = {HFI_CAPABILITY_BITRATE, 1, 60000000, 1 },
> > +	.caps[4] = {HFI_CAPABILITY_MBS_PER_SECOND, 64, 244800, 1},
> > +	.caps[5] = {HFI_CAPABILITY_FRAMERATE, 1, 120, 1},
> > +	.caps[6] = {HFI_CAPABILITY_MAX_VIDEOCORES, 0, 1, 1},
> > +	.caps[7] = {HFI_CAPABILITY_HIER_P_NUM_ENH_LAYERS, 0, 6, 1},
> > +	.caps[8] = {HFI_CAPABILITY_ENC_LTR_COUNT, 0, 4, 1},
> > +	.caps[9] = {HFI_CAPABILITY_MBS_PER_SECOND_POWERSAVE, 0, 244800, 1},
> > +	.caps[10] = {HFI_CAPABILITY_I_FRAME_QP, 0, 51, 1},
> > +	.caps[11] = {HFI_CAPABILITY_P_FRAME_QP, 0, 51, 1},
> > +	.caps[12] = {HFI_CAPABILITY_B_FRAME_QP, 0, 51, 1},
> > +	.caps[13] = {HFI_CAPABILITY_SLICE_BYTE, 1, 10, 1},
> > +	.caps[14] = {HFI_CAPABILITY_SLICE_MB, 1, 10, 1},
> > +	.num_caps = 15,
> > +	.pl[0] = {HFI_HEVC_PROFILE_MAIN, HFI_HEVC_LEVEL_5 | HFI_HEVC_TIER_HIGH0},
> > +	.pl[1] = {HFI_HEVC_PROFILE_MAIN10, HFI_HEVC_LEVEL_5 | HFI_HEVC_TIER_HIGH0},
> > +	.num_pl = 2,
> > +	.fmts[0] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_NV12},
> > +	.fmts[1] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_NV12_UBWC},
> > +	.fmts[2] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_YUV420_TP10_UBWC},
> > +	.fmts[3] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_P010},
> 10 bit encoder is not supported on AR50 LITE.
> 
> Thanks,
> Dikshita
> > +	.num_fmts = 4,
> > +} };
> > +
> >  static const struct hfi_plat_caps *get_capabilities(unsigned int *entries,
> >  						    bool lite)
> >  {
> > -	WARN_ON(lite);
> > +	*entries = lite ? ARRAY_SIZE(caps_lite) : ARRAY_SIZE(caps);
> >  
> > -	*entries = ARRAY_SIZE(caps);
> > -	return caps;
> > +	return lite ? caps_lite : caps;
> >  }
> >  
> >  static void get_codecs(u32 *enc_codecs, u32 *dec_codecs, u32 *count, bool lite)
> >  {
> > -	WARN_ON(lite);
> > -
> > -	*enc_codecs = HFI_VIDEO_CODEC_H264 | HFI_VIDEO_CODEC_HEVC |
> > -		      HFI_VIDEO_CODEC_VP8;
> > -	*dec_codecs = HFI_VIDEO_CODEC_H264 | HFI_VIDEO_CODEC_HEVC |
> > -		      HFI_VIDEO_CODEC_VP8 | HFI_VIDEO_CODEC_VP9 |
> > -		      HFI_VIDEO_CODEC_MPEG2;
> > -	*count = 8;
> > +	if (lite) {
> > +		*enc_codecs = HFI_VIDEO_CODEC_H264 | HFI_VIDEO_CODEC_HEVC;
> > +		*dec_codecs = HFI_VIDEO_CODEC_H264 | HFI_VIDEO_CODEC_HEVC |
> > +			      HFI_VIDEO_CODEC_VP9;
> > +		*count = 5;
> > +	} else {
> > +		*enc_codecs = HFI_VIDEO_CODEC_H264 | HFI_VIDEO_CODEC_HEVC |
> > +			      HFI_VIDEO_CODEC_VP8;
> > +		*dec_codecs = HFI_VIDEO_CODEC_H264 | HFI_VIDEO_CODEC_HEVC |
> > +			      HFI_VIDEO_CODEC_VP8 | HFI_VIDEO_CODEC_VP9 |
> > +			      HFI_VIDEO_CODEC_MPEG2;
> > +		*count = 8;
> > +	}
> >  }
> >  
> >  static const struct hfi_platform_codec_freq_data codec_freq_data[] =  {
> > @@ -277,14 +401,21 @@ static const struct hfi_platform_codec_freq_data codec_freq_data[] =  {
> >  	{ V4L2_PIX_FMT_VP9, VIDC_SESSION_TYPE_DEC, 200, 10, 200 },
> >  };
> >  
> > +static const struct hfi_platform_codec_freq_data codec_freq_data_lite[] = {
> > +	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_DEC, 440, 0, 440 },
> > +	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_DEC, 440, 0, 440 },
> > +	{ V4L2_PIX_FMT_VP9, VIDC_SESSION_TYPE_DEC, 440, 0, 440 },
> > +	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_ENC, 675, 0, 675 },
> > +	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_ENC, 675, 0, 675 },
> > +};
> > +
> >  static const struct hfi_platform_codec_freq_data *
> >  get_codec_freq_data(u32 session_type, u32 pixfmt, bool lite)
> >  {
> >  	unsigned int i, data_size = ARRAY_SIZE(codec_freq_data);
> >  	const struct hfi_platform_codec_freq_data *found = NULL;
> > -	const struct hfi_platform_codec_freq_data *data = codec_freq_data;
> > -
> > -	WARN_ON(lite);
> > +	const struct hfi_platform_codec_freq_data *data = lite ?
> > +					codec_freq_data_lite : codec_freq_data;

fixing data_size here (different array length)

