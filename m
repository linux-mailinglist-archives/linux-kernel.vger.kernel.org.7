Return-Path: <linux-kernel+bounces-751390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03E6B1690E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33BC31AA5A75
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7F9221F24;
	Wed, 30 Jul 2025 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a3V/EC2z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965BD1F2BB5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914792; cv=none; b=KZkuEmUuObHIXsIIpscMMWLyCXEwah0RBYNTLmU3ApBMphFRKxrK6KcUemNHVzzUZl34zjeechmaYSBpHIRTQDumIwGMK1gZ0Pn5jvLTaPwNk30aEXwkmsdwy04QcdX7x4ab2oPhDiNvGUw8uAkOWwKIc28YHLi7cJD7jnDLPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914792; c=relaxed/simple;
	bh=XD8mWT7+uwBdZy8KdwpfcJE94eBSheB6SpO3Eck7/ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9GLogEqMoPXxK1jbmPjvj3/bSToV0vtjBylx/R/nn7yEB7IzO8XjpT9fawqyOPuf4FmGhHKjl9TUaGeCSnPUJRvL8B7gaDuf1lNn1d6qQrzHBioiP9vwdH8sCS66sHdzOi9Y1b6DZdriE3FrbmzFpjfjb+P0hmKd4PP4cC43Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a3V/EC2z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbNjo024876
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KIB9+SMIMAIs+ix0aXzyrQiRdkqV0NUTde9TQd6wMzQ=; b=a3V/EC2z4ipyNlKh
	gqW7ffq3BvDUgYszA1pR7+aguXmkDMKR1xggTDN6Ox9S0p1JpSYg1LR0Y3NQO50F
	cvZY2ft2pW0qFV/IpFJHabsA9Y2WbIzDF19K23efnVSeyXlMD5YVUC9JeCDN3PwC
	ub3AU3ws9uOW7ojAv5hfV4pIT/IWYhi8pHy1RNwuX2RT48anj5+MluXB5u8zsqcF
	ZqjuKBYasKn8Ubwb7ThH8qxGLsrSz85Pc2gukXb3BZxWy24COmDWsIJ6k8sqiBUC
	srB/A4CelybrjPyIHWUucIYUoEIW5ZHfzJR6js8+hCvgVr7bGFT5g+IhjxwlKxjz
	XMhEkA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qwh2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:33:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab3f1d1571so833201cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753914782; x=1754519582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIB9+SMIMAIs+ix0aXzyrQiRdkqV0NUTde9TQd6wMzQ=;
        b=WX4x+dC9hf0UQ3k8hh7MR+RY/L/3zSc/VOyYmwtiTIYRo8KycLyGXpVoWiCLLgr+8i
         ImMc6uX7rupO/4MMc9cVmozJBzObw2Pctzz9rXWFd6yw/pYeaNr5t+Vr3oO3++tudqNB
         aTztCVhFNjHlxfAFm+GXgqJGirp+TBCyAJpLKPP5vFBVVCqrxQZnusB6DVqcyhh3oY4t
         WzCXD6204y+OJoNcDfhkLO6Sj2I85iqGb3H2iP1//GcD02PLKpW2ARK+pk4Us5ql8IBI
         2wyy7DtF/BDsHG0w4nKFB8X19e1aXDRp6WeqK8zptlTIHYhD3ROAb6LWa8x3NU9U2eh/
         X80g==
X-Forwarded-Encrypted: i=1; AJvYcCVRJrVv3XiXy3OTMCQmrxqufV+uOHK/G76Vy+RMHYVZbwhdfAuN8AfVhpbnx9wY7EgPTPOD2MArQP5Qp5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhwHb95yvlnZh741UAujGkPSoupp1Q5hChIKR6mN9BPcndtKy
	RxNTy08oUyY676AdO3JAIRuGN+Ld0IV4JFNo9yWZHmtV2ZGZgM9yg5hIywvpODwrzd07CC4HJId
	kJxzPFVs+gj3Jtaue0cR5wRCVP8jleg7Qg4q92GZzHeQ6cY6J/k6Zxd/P/jQKWwLrFVg=
X-Gm-Gg: ASbGncvl6k7S6ENObcr08q+XS1Hgcb78MNL5YoznvjYJkR3n0SeGSD0bHl1UHXT+QBk
	BwDx+ItIqdjkkLfMbpBNAIF2sZ60DzttyT8AmgUrnp3XaN7fEzybwSn9+kEouhhE7Gi/wg7lf0C
	jMBbgU2kR16nFSxLIBIlG0uk7ZJyM2CL2qs9W6kMF+4vuuSJ8BNE38DyyxD/wpPirIPfRApomY+
	HcKOE0/JWvkY+Kc6EyUgpSQdNJF2/kWLdUxXJo9QF1yWUVxzefEzKS3Rvu2EmsnPUk4yxb70eyA
	8RojRPBLfTvVd8kAqCC0GqnTAKXaSQsJ3idD28KANz2T0G+0p3ms8mnRaR5+wd7T0PVnAqoptw1
	jrFQjBB1VA/oc+J6dMw==
X-Received: by 2002:ac8:5709:0:b0:4a9:a320:f528 with SMTP id d75a77b69052e-4aedb93aec3mr46217131cf.3.1753914782164;
        Wed, 30 Jul 2025 15:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzJ1DWPgTqRJxs6el7saUaAs1Unr4la0oOLT0iT+JU7OrzOzfJloiF82fDLMEGg79NNIYk0w==
X-Received: by 2002:ac8:5709:0:b0:4a9:a320:f528 with SMTP id d75a77b69052e-4aedb93aec3mr46216811cf.3.1753914781653;
        Wed, 30 Jul 2025 15:33:01 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82b0sm8695266b.87.2025.07.30.15.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 15:33:00 -0700 (PDT)
Message-ID: <36f3ef2d-fd46-492a-87e6-3eb70467859d@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 00:32:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sc8280xp: Describe GPI DMA
 controller nodes
To: Pengyu Luo <mitltlatltl@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250617090032.1487382-1-mitltlatltl@gmail.com>
 <20250617090032.1487382-3-mitltlatltl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250617090032.1487382-3-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE2NiBTYWx0ZWRfX9d0gBMLdf/X6
 fCqbcpg9Y20Ld7kvTBbJce6chDnpNSu5a5/mSG0UUbZO+ZC+50oRmc20Na+X0FpfpWyXKslbwZK
 f0R/+U/TqjOJCR/Joi5WZ4i+vp/lZzmCM3MEzogGS5dWUqH2N7tHhxuni8bBWtfreHsxRFIUiL9
 X77SrSjIOKUq2LlMJEjnXdJ+8tEMfH6ecfKSdKbsV3ea/KPzsotqt2rmsQPaM9QsMQ/7P3jOegm
 sPwyP9DneM4MdfB1Fiahti1tm4F4rzmeBhYk5BQsAmINsZy5uAihatTi5ZvtH4/o9bFrlZII4EL
 GTFO1+W31Zh3OzP6wwAy+AA3U/jmhATY5VtUJ0fou7gym23lPpOU1u5zU6WLxhYiJQljcz8fAYB
 a91/+u7TSVtmqRFmumjch3WjhxasOsvjh2llLKOmfy1LL6n0NUhafgW6mvvQRscc1rPm3gl6
X-Proofpoint-ORIG-GUID: VfAy8WDLLu_1ju1RfhiVbXhkKJvPwSfZ
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=688a9d9f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=3m9cAMs9dPIHispIsJUA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: VfAy8WDLLu_1ju1RfhiVbXhkKJvPwSfZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_06,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300166

On 6/17/25 11:00 AM, Pengyu Luo wrote:
> SPI on SC8280XP requires DMA (GSI) mode to function properly. Without
> it, SPI controllers fall back to FIFO mode, which causes:
> 
> [    0.901296] geni_spi 898000.spi: error -ENODEV: Failed to get tx DMA ch
> [    0.901305] geni_spi 898000.spi: FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode
> ...
> [   45.605974] goodix-spi-hid spi0.0: SPI transfer timed out
> [   45.605988] geni_spi 898000.spi: Can't set CS when prev xfer running
> [   46.621555] spi_master spi0: failed to transfer one message from queue
> [   46.621568] spi_master spi0: noqueue transfer failed
> [   46.621577] goodix-spi-hid spi0.0: spi transfer error: -110
> [   46.621585] goodix-spi-hid spi0.0: probe with driver goodix-spi-hid failed with error -110
> 
> Therefore, describe GPI DMA controller nodes for qup{0,1,2}, and
> describe DMA channels for SPI and I2C, UART is excluded for now, as
> it does not yet support this mode.
> 
> Note that, since there is no public schematic, this is derived from
> Windows drivers. The drivers do not expose any DMA channel mask
> information, so all available channels are enabled.
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---

[...]

> +		gpi_dma0: dma-controller@900000  {

Double space before '{'

> +			compatible = "qcom,sc8280xp-gpi-dma", "qcom,sm6350-gpi-dma";
> +			reg = <0 0x00900000 0 0x60000>;
> +
> +			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;

The last entry is incorrect and superfluous, please remove

You can also enable the gpi_dma nodes by default

lgtm otherwise

Konrad

