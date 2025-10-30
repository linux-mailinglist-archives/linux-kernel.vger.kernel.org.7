Return-Path: <linux-kernel+bounces-878053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A610C1FAB5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B6464EA0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7F8354713;
	Thu, 30 Oct 2025 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="opbndffT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NyOmSFYA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752F2351FB5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821791; cv=none; b=OB79l0nw3y4nQnHob3DX5aCT56t5iyFsdE960BCRJCVwL7+SQO1wOftc6AxXKURfehRwpORb6bBaKud82faktY9HF6mC6EbFxZOLHGl0Ibj1bDnh5kpsKyIBPdBH1f1B2Y94C2tzUNOworY13zw8OD7Pzz/4THME2IUJLxTdJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821791; c=relaxed/simple;
	bh=ChtEYnzjuKaC4SDWmheNdDU3f/VplhQ3Ufhx1G6GkS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSDPbG3xax5jknEm/THR56dTQaJh5WG8q2Qpc/M2UkQcXGk9oLyiJH3EwCcDCzZHyGpJLqxmtTsgvMithRK5xQps8oT5ojVMidl33zeaEc3KCCLR16+hRM/5f1zENBvJLlJF0rnz9rirYlxykc/t1z8F5hFYAVRJoIyy4tw55Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=opbndffT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NyOmSFYA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7Yj5i1598878
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T/TCXmsRvRDA7nNRz1j5erhF8Ni7prlvwsDHy+DOMaY=; b=opbndffTVV6Nwej0
	99YHvMFEg56ivyyDJ9SzZKao7p641f79F0PPYFGUCpWq4xQlUVkxO+/1Tc5HswW+
	eZJbj3W206FUMQE1cXhTL4Eo/Qm8ziSsH875iIOGuK7BQ918ZZ9iJYsj2E2m94c7
	Sf/I1vIu2qQEyDdVM/BsdH+6klxD4SgvF/Vp7lLCQI0zztIjyz8rujg4oDyIoM38
	wsEZecOMxuUgE00WJzCjewaHW3h1u8tjVnCeUbdFmU+5KUK8LpNceCBibs+Gf1s7
	W69a0FH8SzLRZbAhrWphwBnLFiQ70giSEb46WBGm2J6j9lQM9213K3oLS2WOvgJv
	/lBtRA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ta7t64c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:56:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c0e043c87so2959146d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761821787; x=1762426587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/TCXmsRvRDA7nNRz1j5erhF8Ni7prlvwsDHy+DOMaY=;
        b=NyOmSFYATSX/JBc0YzNbrzXGEnmPkbaDoSMeCionXaTQw1Emo7zg9cHj7ZzLo2+iW5
         +YgCqoPeW/TDth4LSXdgCsVWezcbXvGoGAbBV1Dm/mZOPjzvhWVkzngCyyHQ1OR/bqji
         ahmtZlt3wXg0a4Xcyfw1zwx84JEr6icSaDhgVijgSk5wIubLaZebexCKJI+93TE2zpUJ
         5LZuyDbTY65ppl5XFacjNsNQP4h3nP+37xdNV+iuOpNCVEdN3Sn3Ks7ng8kwLJj21VhM
         rsWCb5KIenXmyLUp0QH+////ZW8BaonnEk+6iS1Q1nhNOq8GprcFgTm+EPvu8fujFhMX
         vUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821788; x=1762426588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/TCXmsRvRDA7nNRz1j5erhF8Ni7prlvwsDHy+DOMaY=;
        b=tU7lHlDTZEG+68KLBHc1OnP0X7k1d5yq5k7Av6Jno/oTN/2eUM8EHmNBEBp7z9Ddkp
         iCthCEe7yo9Zhw/Dw/xKdvzuiv6T8MY4xp9pb+4VZi6Na/xlD13hwU4ztUqlnEJI1piy
         4SOphkr+7akli+EJ1pJupz7i34+6IhlbD7V0lKWpYhkbGuyEmuwJqH9YYrzNQ9xsRkFC
         mB7VRksB5r8grZuZB9IVxEY382F0J5tcbaaRb/5f71LmZNJrIlV5YdSQmyIcUCUF5MPW
         kq9le0ePvJmGkk0IyLmPvkudx2zk3NazG+rCaE2dvXz9+E4/ztlYr2Uin5vKhS8CTEfZ
         MAMA==
X-Forwarded-Encrypted: i=1; AJvYcCWJxO2jLwcMpw2oWGvS9q9Fzn8E2nbvgLqRFyKvGxUOhRwj2tHk/otwLsuBCDnctouTPYfMA0AYfj0cabE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5HRLqivT1aWhYKE2jZSvFWGVCaaOyeaXOHfnQdLYz3Mis+R59
	g291yVM1kFJ6CiMSVPmJ4k+Xjskwmcpem0GBT9TwcS1DAbKWuxtEvmiAFK7EfQ38XosVGPgSMmi
	9wetKlA2T1OBuRCfLHsPgIp52/dWKhL21K0NgOkgo+YM9LXudZqWCAu0bMcf9OlAi/o4=
X-Gm-Gg: ASbGncs94p5Op7SynUBH/Y8ZV5DcSXkWGws7G/CzC0MOZRiDlYQFZFfYxWmN9F6eW/p
	H8XSiTNB91bxt047If2AG1GSk0htddLEtUgE5KtnaulFVZ1Fd15tHPhF+w3XHLDO6DcQ03ovPcH
	fDpR9l+VxaXYvHQy1/Q0XMN6DV5nV+qwYCmFR1gld1qLfX0FSD9663/bHDokZ/JRsnwOc5VJGvL
	m5i/tOOhzzZA7pMFBOozpva6rohGW5S3EVo67j8RHSaq46w3GIURrJiV0ID2V2WZGG8fpQ2toPy
	FbHGfmamhn58OVBjYtfZHo+JAuj/PEE9B2CNpHAzM9Lp5gr9iPSc3+T12Px7orYKHkIVVKVpLKC
	/WgyM0a+iQ6jKEn3WyGWFEYp6JrNsIfjAM3Hig1/ho00BAiPkgXFNDbQs
X-Received: by 2002:ad4:4eeb:0:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-88009c1dcc8mr51764026d6.8.1761821787432;
        Thu, 30 Oct 2025 03:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG+/yzl3davDjwv6/DM9zcJ4xPDF3vhfNj0ICvz/YR1vfHlrpaf9O6QpYRS2pKAA00OSQcHQ==
X-Received: by 2002:ad4:4eeb:0:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-88009c1dcc8mr51763736d6.8.1761821786757;
        Thu, 30 Oct 2025 03:56:26 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85413b88sm1692077866b.55.2025.10.30.03.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:56:26 -0700 (PDT)
Message-ID: <625c1a6f-3449-48e4-b217-725bc2bda6e4@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 11:56:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] arm64: dts: qcom: glymur: Add QUPv3 configuration
 for serial engines
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-4-24b601bbecc0@oss.qualcomm.com>
 <8828946b-3979-4e7b-a11c-740d8a6253ce@oss.qualcomm.com>
 <5931e2eb-5f2d-49bb-8b9c-b49f77d7fcbf@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5931e2eb-5f2d-49bb-8b9c-b49f77d7fcbf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aaVsXBot c=1 sm=1 tr=0 ts=6903445c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=EyQ-x-pg-_UwrLxwVegA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: F5vT-Ba5un5ebItW8uY-4U9PjNDUsbxV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA4OSBTYWx0ZWRfXypai96WUFSd/
 wxajBQ1S465/IPGEmFtYzvLhjZG1X9eaMfHaXafIPCNdwe0Wy7hKyz9gXHdO8XKoiDJQbxAdL5J
 Gh93H6RWkoCK0A11yJ7Mf3VY/bOinj0dZtNFZ1XHIimQaVHaBjk4Ux5q3KoSsh8DF1lpbhTM9gY
 NLW8GH1KVyoGz0uoR4qHNMvP2Vz+jgQG/ryNUijViNKl1l83HhuqArmdh+7wTnc7aGfGx9zqZgT
 44DcU0S0HLQ2VlWOQZzeVM/xvsHgiVsPBu9zDTtLwNS/nEoblGnm9OHYpz7M8CF5EUQ3/qhjhTM
 AIfLgTwa4tBM7aQgSkoj3Q5LefEVaJSRXOxNSu45/5HVOqPsKLU0zzr8RGCPDDRw9S9wYcE72Mw
 Jd/QV1DaHaMjgG/60AY+R1wf2QQN8A==
X-Proofpoint-GUID: F5vT-Ba5un5ebItW8uY-4U9PjNDUsbxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300089

On 10/15/25 12:24 PM, Jyothi Kumar Seerapu wrote:
> 
> On 9/25/2025 3:48 PM, Konrad Dybcio wrote:
>> On 9/25/25 8:32 AM, Pankaj Patil wrote:
>>> From: Jyothi Kumar Seerapu<jyothi.seerapu@oss.qualcomm.com>
>>>
>>> Add device tree support for QUPv3 serial engine protocols on Glymur.
>>> Glymur has 24 QUP serial engines across 3 QUP wrappers, each with
>>> support of GPI DMA engines.
>>>
>>> Signed-off-by: Jyothi Kumar Seerapu<jyothi.seerapu@oss.qualcomm.com>
>>> Signed-off-by: Pankaj Patil<pankaj.patil@oss.qualcomm.com>
>>> ---
>> [...]
>>
>>> +        gpi_dma2: dma-controller@800000 {
>>> +            compatible = "qcom,glymur-gpi-dma", "qcom,sm6350-gpi-dma";
>>> +            reg = <0 0x00800000 0 0x60000>;
>>> +            interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 599 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_ESPI 129 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_ESPI 130 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_ESPI 131 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_ESPI 132 IRQ_TYPE_LEVEL_HIGH>;
>>> +            dma-channels = <16>;
>>> +            dma-channel-mask = <0x3f>;
>>> +            #dma-cells = <3>;
>>> +            iommus = <&apps_smmu 0xd76 0x0>;
>>> +            status = "ok";
>> this is implied by default, drop
> 
> Hi Konard,
> 
> Do you mean we should remove the |status| property for all QUPs and GPI_DMAs from the common device tree (SOC) and enable them only in the board-specific device tree files?

Generally you don't need to specify status = "okay" at all (unless someone
set the status to "disabled"/"reserved" before, such as the initial
definition in the included DTSI)

But I believe you should be able to keep these enabled everywhere, as
the secure configuration which (dis)allows this is SoC-bound 99.9% of
the time

Konrad

