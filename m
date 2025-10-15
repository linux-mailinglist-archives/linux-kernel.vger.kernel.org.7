Return-Path: <linux-kernel+bounces-855222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BBDBE08DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EE23A91C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E158620E00B;
	Wed, 15 Oct 2025 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nVZYanpF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95F29D279
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558045; cv=none; b=Dv+mheRIHcDLw0RN7wDw3wWvvIWoXheFqdMs4pogsDdukuumtgyPxjS98JGutxVa1SDV4AOu6soWUdx4cbOBvmics84gf2+cZ18PMXAaXnq+hfBcob3x/WUg2oxZ6VAn9uTgzNVyr+Oj1xCy5F+nRLbunrUKCSl06vx21N5UJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558045; c=relaxed/simple;
	bh=E1mSK4DtRW376aeS4DLRibG/tHG9H4wmvFypBSpxzc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usOkft28IxvOuXjYq8DFYhO+Lcfmhnp9k8zw4tdXtwJcjuQCmmV1I9AEEuk0XAuaI8BKYdzqz+eyCAqmDrnqJ2MhQePS2Z8Dvmemp1qDBwWA+IqIMRpmTDax1PFTltswhQlfZbgPwxd43OSHhvRAhK3yWccKhg1C6nMd2JIUwTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nVZYanpF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJRh1v016046
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TX48lldHpN6bC+BPsWUhDcw+
	OVmNzRgnU/ggfqvvlng=; b=nVZYanpFHB5dOiVP1dsdCSjjhIlOC0kEUr97Jx7C
	/WcKvaPOf64FyR0e6cP8bPTq1KSwNxBz4wmI1HxXL2duvnxsfxidpqJVz+jGV/eK
	3JJ8t6FoQTH0tMiWbC9ScHo5ZXqW4OEFhnWvdtL7SFEIOrSfjC3cIq0n5SwV+BD4
	adUsCGmBZjzb77LGrYxE73acB/LG3SP3RA2g6W8JjBzcFG66db4Q2XwU/aI3gCpS
	3EyAeacqhnXb/o5E2Q62vpAE1+HW4jOvqb8BDrp+0tGxqo8bALR/3GwLPA0Ck46i
	mqCKL80mjxSjdxLIm44c36eDcRKsw1cNwscz93G1u8THyw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5nvkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:54:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2697410e7f9so244684335ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760558041; x=1761162841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TX48lldHpN6bC+BPsWUhDcw+OVmNzRgnU/ggfqvvlng=;
        b=LN8RG0BFHNMFmFCcnoN/SoJLJWm3kxRDNshJhHAqfv4Tg7r/nQWU1YJ4ASNpu4Fm5v
         fVIdlfXcI3gVKueXnQpfFJkmfohdwLKE2APjaWbElnpcGKrARsHkcNNTHlTfgC06hlta
         IZsITnWJ+M93+x2CKxq95ejNpLAD8+yQhKFyS2iwLL3i5kV+tMm2KNIKfBdOHtB+XTG0
         +cOuTuy/WLmPjQJVU0fYNCo107lnoestwryrOP6Dsymmd0BvCGGLtPjDqT4SgCQoJA1y
         7tEarAnqXT5mxr9Sqve/RiwO39baSe0bVSF5PQ4Kz8faZJTwVcQPbkeX/BU3YDg8yFpI
         TbTg==
X-Forwarded-Encrypted: i=1; AJvYcCUQlAGtPNKF9LonjLiD0ICiIXnG5uYT2HekJ4ZeC2+Lnxj91f6juBVcArgfjDGmKXZFXUcYh+2Eogz7k2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJ97dbVtNwSe7UQkPNMCZF4IWDY448Cp07kOJQ943FimujTka
	ueLnMlzFCePmTzJIzZxADWKOMTV6KuRezVq9pIt0CtdR5njJG0t1LiOT0QAb6PCHbjTmnQcytin
	NZ3226GMOj45lPRv8Dj91DE4gdyM3DxyTQQZgTnJX+r8n6haXXbHOddPMpeECMz0gB3qzq0A/XD
	OXw7IbE99SH7BggPuHy7uw2Wygyxmw7wQwCiuFPIL+GPYekhfYIA==
X-Gm-Gg: ASbGncugQwDLi5wUFrRmWQWwXTfRrM3iNBiwNhaEpJ/x7nj2PNxqsxZITSIux5cAMQQ
	P47Zp6mTX1kAuPUB97y6HMiBMz12B9MzRbz6fFpShhEPu0Pv+TqDjZjODOT0fSJHXexLH0+ccCx
	EKAzCT1TRCqkn2sVjpfgUVsRKOXWBivWoSwpSBHEUounlM8Uw3dywLVTkucsECSaENdfh/Gs342
	MBHGnHkw/OAc7A=
X-Received: by 2002:a17:902:d481:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-2902723d3e5mr422269195ad.18.1760558040728;
        Wed, 15 Oct 2025 12:54:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5z2DxBR/Z5Mpt5OTV9XjMmY6/lFsbRWdHvRg5cMZlYIBEwXcQoXzMYM+A2htVGGIaWs3BTv95RvDnImPGt6A=
X-Received: by 2002:a17:902:d481:b0:24c:7bc6:7ac7 with SMTP id
 d9443c01a7336-2902723d3e5mr422268855ad.18.1760558040268; Wed, 15 Oct 2025
 12:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-4-24b601bbecc0@oss.qualcomm.com>
 <8828946b-3979-4e7b-a11c-740d8a6253ce@oss.qualcomm.com> <235cf6b7-e758-4d16-b5a1-182cc869b2e4@oss.qualcomm.com>
 <bngdsqmcxtlolmwr4it3wy7rldikzffgwwuyj443dc3v3ilaju@eiveujsf4up4> <6b6a6cd1-faf7-4ef5-ab24-171a59c99085@oss.qualcomm.com>
In-Reply-To: <6b6a6cd1-faf7-4ef5-ab24-171a59c99085@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 22:53:49 +0300
X-Gm-Features: AS18NWAmm9hGxMXkOPorFbS6ZmuVvAN5j6Z8_fAoHeMhwo7GGfmhMgwew6Gfwwo
Message-ID: <CAO9ioeVdFU_+yt1KuF87c9S7Tt9Q8goZGnrGaz7NohKRPjp3NA@mail.gmail.com>
Subject: Re: [PATCH 04/24] arm64: dts: qcom: glymur: Add QUPv3 configuration
 for serial engines
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: EGDUMCayS-UN3yR42yXEtpBEiOnHyO7G
X-Proofpoint-ORIG-GUID: EGDUMCayS-UN3yR42yXEtpBEiOnHyO7G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX9EGH3LHao0lY
 FTz1CiEomseq2zoYjvjWkYMrr2VX+rzWRjAu0BPsYp/R18qFEO+PYtNoFhQWZ5Oz8qcUVHJyimZ
 m2qiAO1l9qE5jAv3gdR+/p0Q0oo+Zy+xI9qZUm5VyGY45AOtE85ipIbXd7heVGavMY93UbkHCe9
 C/O5S4ftBjiO8NRdKwjGKnTdYVA/eKOpfJubaY6k5ssXU/0KyyXRh6y/DX+hMo2oXPLtv4VIF8V
 nOjKefTuTYBfqLEAwUInn17GKk5YJz6eb6t2MoPe4qV8v2BXZHIi6SotWYF4M2em3mmhn9+UN/g
 0fdVLRNBPo3qiONjTIVyOP72NqzGidNs5vjOqyE6vMaLAnM1vAb0qunVxyVyLSdaoO3Yn84l5sz
 CDbj092VP6wt1IzCXhTYdZI6sXwL0A==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68effbda cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=eaa-GZcDK8UfARH1VbwA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

On Wed, 15 Oct 2025 at 17:12, Jyothi Kumar Seerapu
<jyothi.seerapu@oss.qualcomm.com> wrote:
>
>
>
> On 10/15/2025 7:03 PM, Dmitry Baryshkov wrote:
> > On Wed, Oct 15, 2025 at 03:58:31PM +0530, Jyothi Kumar Seerapu wrote:
> >>
> >>
> >> On 9/25/2025 3:48 PM, Konrad Dybcio wrote:
> >>> On 9/25/25 8:32 AM, Pankaj Patil wrote:
> >>>> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> >>>>
> >>>> Add device tree support for QUPv3 serial engine protocols on Glymur.
> >>>> Glymur has 24 QUP serial engines across 3 QUP wrappers, each with
> >>>> support of GPI DMA engines.
> >>>>
> >>>> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> >>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> >>>> ---
> >>>
> >>> [...]
> >>>
> >>>> +          gpi_dma2: dma-controller@800000 {
> >>>> +                  compatible = "qcom,glymur-gpi-dma", "qcom,sm6350-gpi-dma";
> >>>> +                  reg = <0 0x00800000 0 0x60000>;
> >>>> +                  interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_SPI 599 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_ESPI 129 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_ESPI 130 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_ESPI 131 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                               <GIC_ESPI 132 IRQ_TYPE_LEVEL_HIGH>;
> >>>> +                  dma-channels = <16>;
> >>>> +                  dma-channel-mask = <0x3f>;
> >>>> +                  #dma-cells = <3>;
> >>>> +                  iommus = <&apps_smmu 0xd76 0x0>;
> >>>> +                  status = "ok";
> >>>
> >>> this is implied by default, drop
> >>
> >> Hi Konard,
> >>
> >> Do you mean we should remove the status property for all QUPs and GPI_DMAs
> >> from the common device tree (SOC) and enable them only in the board-specific
> >> device tree files?
> >
> > Could you please check how it is done for all other platforms?
> In other platforms, the status is set to 'disabled' in the SoC device
> tree file and enabled in the board-specific device tree files.
> I believe it's fine to make the same change here.

Before implementing something, please, always check how others did it
before you and ask if you really need to deviate from the existing
solutions.
-- 
With best wishes
Dmitry

