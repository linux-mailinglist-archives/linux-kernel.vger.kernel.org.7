Return-Path: <linux-kernel+bounces-798306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4D8B41C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8E21B27C23
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD02F2911;
	Wed,  3 Sep 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJW8bpRz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8C2F28FB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896168; cv=none; b=fxQIes8FVdFqO5SbAht1omIrUwSfS544fRPaPAn0Fu9gVGGdQDituuhAHF+KbBBkgiglWDLdaEHNBcHXZ+TcMjBPWjOQdvKR88CgIo6rNY6CcNqxnl3wHNNsdBhe63N5ENmWfZFlqHWR82gDVSzyunLaq8AhJd4dReuj/pcgv90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896168; c=relaxed/simple;
	bh=6iAiHuDb4uJBKU0Hn1aR76kePafhf0bAF3FlgAjugEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3fuV9RrmDKnbrKNsKyRfWxxSVxvKZThbBqu6MUT2PyjWK7mpwKmiieKSJ4HAFMXpTpWjq9hr/UEttLbLpHXzTvLq5+OCBk/Ai/Oz9URDkf6RT3MeNwgQeMrGCFF8zpwgZWsHJqw+N0cda1qrTs8dYdjOEBOL4HNM/1WjaED2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJW8bpRz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583AVjaO004244
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 10:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AGfr4+Tq+pRH0dbxPVgty5UEqTX1thn/IcBnYM4r6iU=; b=cJW8bpRzr2Y7+x01
	iNMS27+r+sqcTDXL+XrKxJT3cQXqjvJMKjKzKxU+fBiOdnfs9fWUIf8ldx/1Kr4b
	y+LYgraHG7K320Iz8zsbrd7cyvQtUJPThi7U+sl8opq0KnGdH6NMCunDXifjHEdR
	6Dneq6ckqntEsWEnbmRsKz9w7ZZjugn2uZXipDArTh9qlNlmZfNhAhOEGpZXNgrm
	tr9/1jvcF9dDpl69xhqnx0r71dmFsA0DJaOSY09AaIY4V/xBAt0TucHfVgh5ci7C
	Bo5wc9B/G6qdPXgHPo0e4bBwp72j18xXWzPMnm+T2WFrquZhQ3B5Q16Gu/qjApDC
	Fqo2hg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjk98m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:42:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b32216a52cso11163801cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756896165; x=1757500965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGfr4+Tq+pRH0dbxPVgty5UEqTX1thn/IcBnYM4r6iU=;
        b=ZA5+zFu8TmqnA6euV++PffbjJWAfEKUbbDRrk9OJTvltsRzryvrZnL6GpoQJ650tHw
         ku7gdPg9cSpKZee1TogjlUKtZDpK8bWewAj5SMC0gJpd48Q0+EqaIhyrZ1VsupqcnwWf
         4oO1OWaOOba2+TkR7X2CcK0RxvfPMVC0e6AuwkSgpTaaHHfTJ4J2dSpBadJLU62apwDi
         9JdAt91OuKTQMb7qS2bQZxaFykOoh8+G1tDXrSxkGcPICb6QOwG+kPyDBcDI1BgNGhBF
         WW8Avl7d0bjRQABvPiHuwQ9Hpivcm1SLP1A1YmcZ7jAcJ+ZdAOJV2n5Yy0PLhgLc1Qs4
         APNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzaNKzS+2kZzOAijUN7f7VrGPCWJOGQRF1wUCQbHC9BVeEvdQegP8Lz7+r1JJYjkqNp2AIk1lTlTbpsmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7V1DvYpGa6Ur5fXcPHSlU7e0ZhnrXf9rpvxiTJB83R304c/ym
	tuxhzzkC2CcQ0UMaMiRL3uesaYP3CpJNdrsPIf1DqeO8Qz1q6uFIN7bE+RKc8PdzwxUcvKgyTFy
	kWomx/3naX9V+zmgD4b9w9iT/su+RkmZxUacA2t0AuqQKw+mN943+FWy8HKLoFYFz2EY=
X-Gm-Gg: ASbGncsQKrTl9envrjimMfFdXfFH+mQN5HRXbe5ziM0sSoXHikgS0ywMOYP6/fCKtI5
	YJE/oCGiFYDFOV/cczue+vZ6XVw2L8+lvqES9vrbxoVsBqJGIlBegeld/grk8VzorMG1CHTTz4L
	Ny0Q2ea3DYTHFv7csePOj6/2ZYB2EQVylil5Xd0rQP81yPWAMb+InOa8u4WhE0ch2PwYKIlETo8
	teexGIe7iPIchXn1f7y1f/IRTKLvGQyNe9gS4sp+X/t66lfx5tBfF+IHlOLlgbCFnR2/AcGeUxH
	V41AIPYe9XLdUDT04peEr6s2mwFfJ6hbDbK8qP2SsGps720FGbDFHS214spxqLwQ5SWfW0ZJ4y3
	xLmDIWQP4cZPPNAjHzcLE7Q==
X-Received: by 2002:a05:622a:1895:b0:4ae:b029:cd7a with SMTP id d75a77b69052e-4b30e98a602mr156109131cf.9.1756896164595;
        Wed, 03 Sep 2025 03:42:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVffWGT/P4HQ1hOU4OQt/ExG64VXiLoPZAGAGCtyi6SsM4nP3uvC3ksMYhqBwvHlyRLWq2nA==
X-Received: by 2002:a05:622a:1895:b0:4ae:b029:cd7a with SMTP id d75a77b69052e-4b30e98a602mr156108941cf.9.1756896164049;
        Wed, 03 Sep 2025 03:42:44 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046e6c630fsm78582266b.55.2025.09.03.03.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 03:42:43 -0700 (PDT)
Message-ID: <67aa2a1a-3adf-4c97-a7b8-865b5ca3b17e@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 12:42:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] arm64: dts: qcom: Add initial support for MSM8937
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Rob Clark
 <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, iommu@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org, Dang Huynh <danct12@riseup.net>
References: <20250831-msm8937-v8-0-b7dcd63caaac@mainlining.org>
 <20250831-msm8937-v8-5-b7dcd63caaac@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250831-msm8937-v8-5-b7dcd63caaac@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b81ba5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=bBqXziUQAAAA:8 a=OuZLqq7tAAAA:8
 a=sAN_IsTCchqKF9ABz68A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=BjKv_IHbNJvPKzgot4uq:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: ztpMSk5TCoOADDmVP2vbAo2kJsOXppWl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX02nQxAiJ5EB1
 NkgvBVthWBCpeG6Qw72CEKLHl6NkIXvnN4Uzi+xTNtj6AbWjbvdhblCmNI0wxLbrVtg3Vg2cbHG
 CVXghMokR3+8hOprnDByHhIaWcwJTh2l10SGN4LAuZxqOLbuziIF+64S1RVlT7dvJxwNOb6Tv4q
 GlsyExj1h0E0/t+zj3aYH87UmMk6QL0y1hJeP1VZs7Y7/w0ZK4KfFBfqO944rlJCFiC8hIjv3Ne
 Cdnr5qi3EJFIz2uNqifw6apM7AmaKTSDuHsljFY3FGhNfGZ+0vw7f9V6enx38Jrixqowrnj5dwo
 t7gObWC9FA3ad+NkYF2i+R6OeO2dJXmyr8nxxvBa9X/u+EUo2FT0DpUolA80Ljz39x1/JNEikfP
 Bo2Pw9DQ
X-Proofpoint-ORIG-GUID: ztpMSk5TCoOADDmVP2vbAo2kJsOXppWl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On 8/31/25 2:29 PM, Barnabás Czémán wrote:
> From: Dang Huynh <danct12@riseup.net>
> 
> Add initial support for MSM8937 SoC.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> Co-developed-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

[...]

> +		qfprom: qfprom@a4000 {
> +			compatible = "qcom,msm8937-qfprom", "qcom,qfprom";
> +			reg = <0x000a4000 0x1000>;

here you reserve 0x1000 for the qfprom

[...]

> +			gpu_speed_bin: gpu-speed-bin@601b {
> +				reg = <0x601b 0x1>;

and here you make way for OOB accesses

Make qfprom length 0x3000 with the current base and the gpu
speed bin should be at base+0x201b, I *think* (the docs aren't
super clear on that)

[...]

> +		mdss: display-subsystem@1a00000 {
> +			compatible = "qcom,mdss";
> +			reg = <0x01a00000 0x1000>,
> +			      <0x01ab0000 0x1040>;

In v5, I pointed out the size of vbif should be 0x3000.. and the random
newline below wcss-wlan2-pins {} is still there too

Konrad

