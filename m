Return-Path: <linux-kernel+bounces-871508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BAEC0D7AA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EC9834D5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CE93009F2;
	Mon, 27 Oct 2025 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mh4W2s9i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E642FABE1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567664; cv=none; b=a6w0CazIoWnb8cPNAeIyzAXuDtyiOBS/v65Lq/9Fk4AO9mjhXSjQ/OILRQ6p6SqK6StzzU0xG8u4vqcfGDpHUkU4WWq/l8yV8f0zOB8mtqPlI0XAvMvYnoQx2FMXUk/pyBo1dRGLTBEwMlEq6cmoSIGpcm8N4f2qr+g46IYmn5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567664; c=relaxed/simple;
	bh=nxPWAEJRSRpuGJj36axWvM+AKJHgISMgHq4fyA83R84=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UgVhny0nzI0qJX6nbcahEW1oRGgrtmHw4gAnjtYiwpsLYfVgVUnLJ1IeWABLTjM3pcMaIsQE2hYYlQeYm7WAhkpNxart68O2himSoRXfIts+U/1+EwX5dVI3k46oREBo8ZwMk41bPIjDVSodXGRyNGqabYIX1Al78kM9VgNspHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mh4W2s9i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R7JtOk2059245
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aP4mxhUOOvb5sFzTA2872hnI8+YOJ+Fa/nda32UGswI=; b=Mh4W2s9iCZTmOG/W
	eiIFJyfeRI84xvhv9CLFGqr7pVww6ukMC+1WntxshoS2QBlBGiyNzZQbab4vU03T
	x2NhEP65/wuehfB0uS64BV2OCCbF+Hp7LTcMjY1KdVxzSDNJkzoKQby8spZ/jNIl
	0Iti/RVC0Af7lX8O450WcUbVPfcXp0OqV9iW4hhffprkXvBlFnmw4nNzinVVT9xf
	AFeisaiUmfGxGbNFKWpgdhJYKxwHABwUXwJ/FAIeXCF3X0DKKJ099YkRBbt10l3C
	LcwEdhew1qtui/XWreVyqvweyydqcBYpFXIzvDDD/zu04WvPLn3k5hY+GrUH5sQl
	Ab9riQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a248p8tkr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:21:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8934ae68aso16913021cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567661; x=1762172461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aP4mxhUOOvb5sFzTA2872hnI8+YOJ+Fa/nda32UGswI=;
        b=w98QyKjB8VuptLBX/nl7myYFezTdi2NDiL9FHXMAJozr0PbhJyGPYl2L9nRplifoWU
         6cadEDD2RQ592/0WpHXjNtHnqpvEku82EjWCNBw3M2wWFyKZZ8UJJ8PKWgEFWLADmmSI
         NYB0QVV3tcI+qD9wwkt4x0D6oHVNMBpPnUANIwIxWBXvlpJKSbfUF7HKaz564uPidnep
         foNsLThZ0VaBEyW5mEQGVvx8hLhyNnjHEVO2BdvKYpwgBsZ62SZwdywSNvycTZXiRdrZ
         F/rz/ul8JgW8EpasIvJAUNdqZqZaDtO82ZShMRJf8EaDEFZNx4+DXCu0Ptpo9qwwVXPz
         cpvA==
X-Forwarded-Encrypted: i=1; AJvYcCUlH3LcU9dWTqqDIx2kd9V08AVmcT03dW1ibW44hwy7ETHttBI/u5Pxn6FL2nCkHKFguctTnxAi1PnK2p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFibUXHZrx1YT7JObxJG9tSzAjGlMM0cgA9JC6tGe+6K8LIzcH
	NouuTy/FciTYlnjww8HsoEuQZ5MIX8RFOPvr0W7OWicZBtGHLJ8J4a1r8XdtigmhMGmoAFliFfp
	ng5blUI3iyXHIjW7q7q8dOrVHu9PEj+XIR00XNAXxsVLa+BacdC64sBhBUdxVBmNkKbA=
X-Gm-Gg: ASbGncvqaItgvLOVDutT/1aY03V6JIzgk5Ig16wTFNYt6mAFXqPhO90CyoYBVW/psnh
	P4ucHISR0OVqCI4qMoyxJt15Cj9Lc6jsReXD79rL0vrHXX0zImo90hu3zRj3nKl1zR+21MFrUIz
	a2in1E65FSlTRQOzuB4o0eTrwTFMpQcGdE00acLRVoix0U17f7u5VQ+ZC7kFw+6d6KwuQPELsiX
	bwnb1zAMfa+ekQeBiDeJ69kCpqG9N7GcIHazF7z3S9oxY4Jn5uwEJhfAl4rQqeg4rBZmetyC3RX
	L0zon7d/Gd49bat7BVAcVL99PePXm5+WPYDFBC21aYY42JsETYaSx03kBTmRwnBp2WNdp7muG13
	J5ga/HkQLHetLs80tr4ZOxu2o5aQaQAj4NTGg4Vg/83SzNmdtcMBiO8ND
X-Received: by 2002:a05:622a:289:b0:4ec:ed46:ab6d with SMTP id d75a77b69052e-4eced46b36dmr54348741cf.9.1761567660973;
        Mon, 27 Oct 2025 05:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Ymwp4j4U76wtRZGQW8EHbN2uGqMPPJ/w80E3/mCrIAWR0RdpJNVmK9Zxy1Lr+Yj9F1bPnQ==
X-Received: by 2002:a05:622a:289:b0:4ec:ed46:ab6d with SMTP id d75a77b69052e-4eced46b36dmr54348351cf.9.1761567660538;
        Mon, 27 Oct 2025 05:21:00 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853f9a0fsm746527466b.50.2025.10.27.05.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 05:21:00 -0700 (PDT)
Message-ID: <51da0617-db4f-4c6f-9f46-0492e49c9a2f@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 13:20:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e78100-t14s: Add audio playback
 over DisplayPort
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021111050.28554-3-krzysztof.kozlowski@linaro.org>
 <20251021111050.28554-4-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251021111050.28554-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zvzg6t7G c=1 sm=1 tr=0 ts=68ff63ae cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=PIn3yDVZNjJHwrb619wA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExNCBTYWx0ZWRfXyqbEXU+vgYa/
 ODiwS1SQc9VC85GjKW8sgvfSh03KKWahAV9Ks7QThgbxhuN5DFD6zUUMiNa2irov+xE+XY/FvYg
 czO/hOkm9I7qsrTRmwg4bHWd/pB7FQE8N0T8oFnrDcTf1SK04g+slvpSaA4zFPiJPtQiGiEfDS/
 rJRE9agleQVIV3dBtjN4+b65didSMD6BpfOmgE7woxtT5WVrmTow8s1zqG1SzFlTJTYUbWBVBcM
 giOPGe1aenZDKdHIu3AVlF4nx3e9WglhvD4m6Tp9kWbBR09Q68VE75GNmM2zMRDXSdf/fyQI/PP
 0R64q+EwlhO8CMfY5FAz2JNXRqMrjMfrgbk60guaGPK12kqfLUMR5DOUOqCe7Nu0E7bXnCrvjM7
 nZ1CHxWLusnUHaPUpjwtwiJ3WKsBpg==
X-Proofpoint-ORIG-GUID: h4-SWVPYpGhUyysEErwEIAM14MgEACpn
X-Proofpoint-GUID: h4-SWVPYpGhUyysEErwEIAM14MgEACpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270114

On 10/21/25 1:10 PM, Krzysztof Kozlowski wrote:
> Add necessary DAI links and DAI name prefixes to enable audio playback
> over USB/DisplayPort and HDMI.  The HDMI port is not yet enabled, but it
> should carry respective DAI name prefix regardless.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> ALSA UCM and audioreach topology will follow up as well.
> ---

[...]

>  &mdss_dp0 {
> +	sound-name-prefix = "DisplayPort0";

We should probably push this into SoC dtsi since #sound-dai-cells
is there

Konrad

