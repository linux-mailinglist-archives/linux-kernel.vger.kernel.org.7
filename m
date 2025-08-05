Return-Path: <linux-kernel+bounces-756316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E482BB1B29A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903FD189D47D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3F92550DD;
	Tue,  5 Aug 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cw2X+wcC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237B21771A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754393261; cv=none; b=IRhWT6fD6toCSbXQUTskf85GSyCSARWPq8cZFXKk3nlLap9DacH9e4uWZIxqeKNU9V3E4D32NthXuENkygjAyNz9Knw5IOVxW/CArqVRMMw7ylnril0HXNuxLr2zGC4k2R3edDMZoyfeLiWJ3ylpW+FDjZLCuJBY2TuLzKr7Wrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754393261; c=relaxed/simple;
	bh=DVXddEgeZPuQcDtEKtxLaY59mZ2sxeocu63HSG0+8+U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vdo1/bWpn0wPdQOu5UTRdoRhojLl//mKdFO6YyKyX5ukoMxuH3wGw1rVOnmqtk3J8Aq6nLJfDD2lAmvivgIqMVI3waMDMbybOnzsu+EK2a3DpnsYRS+AGt9X4v7NYC6yF/bonPWsmVqFhpdFnI9vOQcuGMz1/VWvNrhH7yjOdVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cw2X+wcC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5756Mwwl028463
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 11:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1gPoqe4y4yIUUPTwhZsEUYLD
	5BOfc3h2wVUekz4+9NM=; b=cw2X+wcCKQ8oVP/V6Yb96P3FsimYKqX+BJZA2ybW
	PUhWTy2Mjt7aii6st4/IQjBVuzYWLJyCFLhx4171pfR0t0ILoMZ5EbptKkaeAyu5
	ipemR4L6DyOoEoQSUA9GIWqSqI+1PsmUFKVIbnk3Fh/v+KnbMfmvuzBOfNX6Cr9t
	h/r6os//QcNMA6BSJITOjm2wxM0SIaG02ufHCeb5/qWaYIkszbRLf3sN/EZEl7aM
	zc6tXMHe6XuZMdwfhxYbFqvdnbOJIyDoRkwpJMizbQ5jdKrE9Vkr6tcHaoX1XkIE
	XS1X7Bu318M+ViqEp/Ooi4iEP/U9+Jn7HZWjwlwpHWKRuQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489byc88ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 11:27:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4af2237e4beso39726451cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 04:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754393257; x=1754998057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gPoqe4y4yIUUPTwhZsEUYLD5BOfc3h2wVUekz4+9NM=;
        b=bJP844neVZAipwDQOes8PcOquLY6nH1w6hVzViQTBdGUtpE0INFPKekXzm5OI5xqpF
         VIyk+5lJ+/DdoBQnt6FdZTQwAOiCgyKlfUOoNfuZ+DDOjN4iUAIUJTCbgT+AtQSc5V4B
         HZqkuaelpFZIypftkSqp3+Wy5zHLEdRK1bFgdZo0QdG0Iomez3f9oqgW3fJlNV5/OVEk
         Q0q9A3oSFiUvkJ85c7fkIskMeb5hBpJm0qMMqFkMNogO/4z1EgBlwgSR/JDe1Gj8n0WP
         UeWmbSawnn8q7w0n5YJbSluH06HyRi/q+v+Rdz/XZuX7ATMO5NZ3ECuADcqnZd/D0CMK
         I8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWc7gH8u+JheeIBtHxr7FtlAN0ZYph3rNF1o21OqRYjWqAesSbuv8r2cMFumvwmCEOCdHA3Q2y9SFBy6V0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4k6hSJSYTSGYvSTfL/C/L5BP/RTfkiQkaxfQRYQj++oMIuc4
	k9GoBxhEq7i9bKPImfxPh/NLFjQH6hGwhSyR8GFkoa7gEcTBd/sqTDxo8XU/f5XvrFWgne4fO+y
	B9MXjTa3307/HUzhilWhaGWKPsfzSnvsRS9wQTzrUt3I+WkKktr1teLXLuE5lFNglV6c=
X-Gm-Gg: ASbGncubNlNYgS3QVTdjZIjp4XuNHaqbxc109OG8hkR8nMNXx/hjmwBxsaJmMP8il6s
	zdUiyUTmEOx6kXfyFWnyezs6G2XQuNoDhJKc6JNwp1RkNNCABa68vRLSja0g/J65edt58prM2zd
	oxZSZ0tTvLCaLCClIaM85grvdD/cey/ILHx6g6ZAoNnj3UN4B5nym4cGKGAidQRY3dv5KV5T3ht
	iaqfZGWtAbBxGda69cLHRGeXW6SaGaxQUIKF+xr0R4XksHbhV/frk/8zS9zULbRKcpWPoBZMaVk
	yTvwQjWolzsYhJlrS2oU6jwe8WAIvFmd3iwW/q81CEL34i2w14nzLyhgJXyloGKZkQtFNQ==
X-Received: by 2002:a05:622a:148a:b0:4af:21a0:c65b with SMTP id d75a77b69052e-4b07f8b757cmr45494771cf.13.1754393257266;
        Tue, 05 Aug 2025 04:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0101lXC5zt5OQUJJcCTrjM72+E5bMhWeTi/5/EpeoZ4H4alza+OtyPzFZhjZskEOxR4CjkA==
X-Received: by 2002:a05:622a:148a:b0:4af:21a0:c65b with SMTP id d75a77b69052e-4b07f8b757cmr45494321cf.13.1754393256695;
        Tue, 05 Aug 2025 04:27:36 -0700 (PDT)
Received: from trex (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469582sm18593886f8f.52.2025.08.05.04.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 04:27:36 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 5 Aug 2025 13:27:34 +0200
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        bryan.odonoghue@linaro.org, quic_dikshita@quicinc.com,
        quic_vgarodia@quicinc.com, konradybcio@kernel.org, krzk+dt@kernel.org,
        mchehab@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] media: venus: core: Add qcm2290 DT compatible and
 resource data
Message-ID: <aJHqpiqvulGY2BYH@trex>
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
 <20250805064430.782201-6-jorge.ramirez@oss.qualcomm.com>
 <4chbcvub4scnv4jxjaagbswl74tz4ygovn3vhktfodakysbgy3@kukktkwd2zsr>
 <aJHgh8mon9auOHzi@trex>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJHgh8mon9auOHzi@trex>
X-Proofpoint-ORIG-GUID: ZHCRplYINpTFDp52VUX6NpS6EoPHhn0B
X-Authority-Analysis: v=2.4 cv=Y6D4sgeN c=1 sm=1 tr=0 ts=6891eaaa cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=uolHg1VUeg_AKm6FvgQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ZHCRplYINpTFDp52VUX6NpS6EoPHhn0B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA4MyBTYWx0ZWRfX1cm1beL8pGt7
 BcuH5qyD/827PKW/pXVb2vpZ4FYXZwD3VSHt7HE77c0JSD5tv9zhjOc4gutBlCFtF/FwNaJ2so4
 nmLlrnk1aUYl8EDh0jfLLXnq2lbvGNQEROmANPJxxpiXbTliX4siduT79PBxmliARBx8P42TNc6
 3iXBPOZpcHCQswszS+MbbYGG6Ke32HQHChhm2l9Zu6kUM1WkMxWEAX9do4m9DYywyJLEqFVstK1
 Keq2oopMU1sWnD4Gkzz0JU2aWrqhUsT+1MtXDO0XHnCj1pIJYtUv1dnWidIlvpiLeYoEcKwIj94
 wLomivbcsNBpMzPMU8gmC966xxkosEWvjLQ4IyVQBr33RO9PK3BGK8mIudqOoOXWGm4t7uNNx15
 jo/BPDQ/IqBvpkpggQMBrjRNwv3oAiWiaxiQ/ZfBvclifq6Y2ae5crNj6RMHw+4wqPTpUeym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050083

On 05/08/25 12:44:23, Jorge Ramirez wrote:
> On 05/08/25 13:04:50, Dmitry Baryshkov wrote:
> > On Tue, Aug 05, 2025 at 08:44:28AM +0200, Jorge Ramirez-Ortiz wrote:
> > > Add a qcm2290 compatible binding to the Cenus core.
> > > 
> > > The maximum concurrency is video decode at 1920x1080 (FullHD) with video
> > > encode at 1280x720 (HD).
> > > 
> > > The driver is not available to firmware versions below 6.0.55 due to an
> > > internal requirement for secure buffers.
> > > 
> > > The bandwidth tables incorporate a conservative safety margin to ensure
> > > stability under peak DDR and interconnect load conditions.
> > > 
> > > Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > > Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > > Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > ---
> > >  drivers/media/platform/qcom/venus/core.c | 50 ++++++++++++++++++++++++
> > >  1 file changed, 50 insertions(+)
> > > 
> > > diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> > > index adc38fbc9d79..753a16f53622 100644
> > > --- a/drivers/media/platform/qcom/venus/core.c
> > > +++ b/drivers/media/platform/qcom/venus/core.c
> > > @@ -1070,6 +1070,55 @@ static const struct venus_resources sc7280_res = {
> > >  	.enc_nodename = "video-encoder",
> > >  };
> > >  
> > > +static const struct bw_tbl qcm2290_bw_table_dec[] = {
> > > +	{ 352800, 597000, 0, 746000, 0 }, /* 1080p@30 + 720p@30 */
> > > +	{ 244800, 413000, 0, 516000, 0 }, /* 1080p@30 */
> > > +	{ 216000, 364000, 0, 454000, 0 }, /* 720p@60  */
> > > +	{ 108000, 182000, 0, 227000, 0 }, /* 720p@30  */
> > > +};
> > > +
> > > +static const struct bw_tbl qcm2290_bw_table_enc[] = {
> > > +	{ 352800, 396000, 0, 0, 0 }, /* 1080p@30 + 720p@30 */
> > > +	{ 244800, 275000, 0, 0, 0 }, /* 1080p@30 */
> > > +	{ 216000, 242000, 0, 0, 0 }, /* 720p@60  */
> > > +	{ 108000, 121000, 0, 0, 0 }, /* 720p@30  */
> > > +};
> > > +
> > > +static const struct firmware_version min_fw = {
> > > +	.major = 6, .minor = 0, .rev = 55,
> > > +};
> > 
> > This will make venus driver error out with the firmware which is
> > available in Debian trixie (and possibly other distributions). If I
> > remember correctly, the driver can work with that firmware with the
> > limited functionality. Can we please support that instead of erroring
> > out completely?
> 
> yes, in V7 I did implement this functionality plus a fix for EOS
> handling (broken in pre 6.0.55 firmwares).

just re-reading your note, in case this was not clear, the _current_
driver upstream will never work with the current firmware if that is
what you were thinking (it would need v7 of this series to enable video
decoding).


