Return-Path: <linux-kernel+bounces-854638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D799BDEF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF2F189BE90
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4297725BEE7;
	Wed, 15 Oct 2025 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bGlp81zB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE1D3594B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537550; cv=none; b=iNpUbnwRYe042ky38Slg5YTTd3pYrIrfLQNp7qwmHIXDDCCDs+7gf6y/vtjINZ4V8LYOfxWA/IWK324HreD7xd5Lhu6+Q93Z8Y6QbFlMg2D8RwWNt2I11qKDfPcFHbyz9ZzPMtj8uLitHGSITYl3uVWkvgPYDLxrYG5C7D3nZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537550; c=relaxed/simple;
	bh=0/Nkjxawte1xSGWBAeAz4zNlicLOOiHatyq2kN/fkSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clDwW40hHj56HAVXGDUVOkUVcgTHG2VnRqTx4egb7guFs3wBLs1aYkkJiaXhoDx+KTyRWGBxjzsSYT0Mii5uIUuZNj7RoOQbIkDVoHgK8P02ONKoMAHKTOyXug2S5YDWiaAvfDebYt4xlFPIDBjvCK/ZZBhgxTjnx5R3xrUuh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bGlp81zB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAptrG005327
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4wHo8Vra1vzjyqc4KdZsz2I/6mrjzzqutTDTJTdctpY=; b=bGlp81zB3/kC2eot
	K4nsU9MxuIjed8SJ9zqWT6ieOCVdE/XPJQvJJbm40hs2/N53lU5JKl8EWJVBaHc0
	cLz8jE4DFKcrnpKdvIymQz/3pwKl8rkGVMp6SLxlMcxseiiem57JtO+MvG+/sFLd
	l+5x24nBoiamMx6DDqLjUVPzXEf+6vuyZC/QDMvKnWS86tjdMfRG5wKU/Hhqp0XK
	uprIPQYD2wY8gu+BYF/Maskebbc7ImLW0lD15BQ3LXXfrJlFXMWm7HDIjFECxxbk
	Tz9AfW9BesxLbxqyLe13HJkukWjywcTcbn5q3GFtAS+tAGZrkHZ22B9J3KQxcrhb
	m8J4vw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1agy48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:12:28 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78106e63bc9so8800417b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537547; x=1761142347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wHo8Vra1vzjyqc4KdZsz2I/6mrjzzqutTDTJTdctpY=;
        b=eqQmBnTri++3KLdqheVITYLZcvbZGy+TyLE+GVtzwwqWqaNc2SUtZroItpmUIpQ4NS
         bCXOB/sJwg+xkfULKw23zfeLvd8dI7vwftoNpQ5Elh8kyIiDnr2Ytiil88hnq3dGgyez
         0SKjgIG6iqxqeI8f0n971MMupDLUI31xZODdstnh+SeUPkozYjZx8/UVlK1O6PgknC/t
         FKL/FDcG0I3+0r05+7tR7fWN66slD5csro20/5/Md7QY7pMmTcB6hdXvaq2kVoEpeGZt
         N/S+cZIMroj8PKfvAPtkw7An+NEUY0QHBXx+IPEMlWsOJfohBy5mNusZxZVYzNI5dNkX
         /B4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqDi+LQLYm3zQdYLhMR49b3UcFniD9sv9IK6hxEIRAjqQpJarb70ZjpBFwQuwiQe0p2mgCyUdX6XvakqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsK+96tJ/RdzlwmVA3WDJr0tvwkpxLTVCtQnkMFm7G9vCwiDA5
	+qSwLZP75PEX3cfAbaU4FiUsTcdOkKi/Nt9pr6KvWK11o57+D/JdaYFIe8RFNcNuBc7K9gHUrrY
	N6it5joYZPzXrYy1hZzksDum1cJEpJkQyDczGmg0aHrZH1cqyUZjHNU33+GMDTUoCbMM=
X-Gm-Gg: ASbGnctg+aQs2J4yDTqsvAXCudcYkpIilVsQHMOXzRjn9nZb8gvNGVRVt6bBqur84UP
	JNihFeR8lcw87Sl+M5CRqprGxY1ROlXqff6A7/uh6wqQJrLUvdHH73h5LBMfiPiqbaGWQ9Xro8B
	DmoFNYLlBafNA5q06yjZSUHyVsjN9Mv7nGd1c0Tfo3X5+0vsN8GnDnkzDDDMu9/0Vu8GMh4rhMt
	MYQYl9q4JXU+mXPzePWQxdG36xT48MvY/K/xnjwtNEBvQNuKWWMOpw8Krm5EcaLat0uCum/8qm8
	MHtG70dhWLQ02xCzl+1f8MDqaRRDbe2lp95fsuks4jJKfRb/+rq9NaUazTHa/dcsMuubIig=
X-Received: by 2002:a05:6a00:3e27:b0:77f:2899:d443 with SMTP id d2e1a72fcca58-79385ce7d1emr33730442b3a.10.1760537547289;
        Wed, 15 Oct 2025 07:12:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9O/0dJRMlLmSW2AYZVzbX7T6xJcZVwENkY02XFT5vDOdiAN4Kwxk2zeM2DZtd/QPojIZL9Q==
X-Received: by 2002:a05:6a00:3e27:b0:77f:2899:d443 with SMTP id d2e1a72fcca58-79385ce7d1emr33730391b3a.10.1760537546628;
        Wed, 15 Oct 2025 07:12:26 -0700 (PDT)
Received: from [10.218.44.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09f407sm19119352b3a.43.2025.10.15.07.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 07:12:26 -0700 (PDT)
Message-ID: <6b6a6cd1-faf7-4ef5-ab24-171a59c99085@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 19:42:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] arm64: dts: qcom: glymur: Add QUPv3 configuration
 for serial engines
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-4-24b601bbecc0@oss.qualcomm.com>
 <8828946b-3979-4e7b-a11c-740d8a6253ce@oss.qualcomm.com>
 <235cf6b7-e758-4d16-b5a1-182cc869b2e4@oss.qualcomm.com>
 <bngdsqmcxtlolmwr4it3wy7rldikzffgwwuyj443dc3v3ilaju@eiveujsf4up4>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <bngdsqmcxtlolmwr4it3wy7rldikzffgwwuyj443dc3v3ilaju@eiveujsf4up4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68efabcc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=b3unEIaTcIFgp9XBJ8sA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: lPGUDsTezn56z1BhUbKnNhsfQn3hBRgA
X-Proofpoint-ORIG-GUID: lPGUDsTezn56z1BhUbKnNhsfQn3hBRgA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX/bZEYRm9hbFz
 2v6HPUq4B6fqFHgdj4Fzbt4lRXqjdPK0UEdXzixC0DK2x+vIaXmvUp4fOzPJr++m8GbuTxsrNPm
 P15pwJ+4ax03e2wqm9/SPRYjafIvBkpXYRcqkkdA6kbFKcHcr8g1+iHIDywpSH1WLl9Cz7U5p6l
 ZG5lQivLoVpL23PqmKTrjZTfsI80updHrRorlMrHSjFSCH7lG1uPNP56DUexog0bjyYdrrHa3nf
 1DvmCmQzOaaaT++qdCw+Eax7DnItMCnwRudGrB+4KDHskEmd6ANRpRU3rNDmJmeojrvb4pSz//z
 mlljUY5gXD/bZliqdvxgZ151r3B0uqIO3S6jMUwNHNzpPQ02c6DMe7GZUKUULQJvwzBA0Q/6WwX
 Hqx61JOE0vEZLJELSrpRzL+P/y8ksg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035



On 10/15/2025 7:03 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 15, 2025 at 03:58:31PM +0530, Jyothi Kumar Seerapu wrote:
>>
>>
>> On 9/25/2025 3:48 PM, Konrad Dybcio wrote:
>>> On 9/25/25 8:32 AM, Pankaj Patil wrote:
>>>> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>>>>
>>>> Add device tree support for QUPv3 serial engine protocols on Glymur.
>>>> Glymur has 24 QUP serial engines across 3 QUP wrappers, each with
>>>> support of GPI DMA engines.
>>>>
>>>> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>>> ---
>>>
>>> [...]
>>>
>>>> +		gpi_dma2: dma-controller@800000 {
>>>> +			compatible = "qcom,glymur-gpi-dma", "qcom,sm6350-gpi-dma";
>>>> +			reg = <0 0x00800000 0 0x60000>;
>>>> +			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 599 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_ESPI 129 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_ESPI 130 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_ESPI 131 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_ESPI 132 IRQ_TYPE_LEVEL_HIGH>;
>>>> +			dma-channels = <16>;
>>>> +			dma-channel-mask = <0x3f>;
>>>> +			#dma-cells = <3>;
>>>> +			iommus = <&apps_smmu 0xd76 0x0>;
>>>> +			status = "ok";
>>>
>>> this is implied by default, drop
>>
>> Hi Konard,
>>
>> Do you mean we should remove the status property for all QUPs and GPI_DMAs
>> from the common device tree (SOC) and enable them only in the board-specific
>> device tree files?
> 
> Could you please check how it is done for all other platforms?
In other platforms, the status is set to 'disabled' in the SoC device 
tree file and enabled in the board-specific device tree files.
I believe it's fine to make the same change here.
> 
> 


