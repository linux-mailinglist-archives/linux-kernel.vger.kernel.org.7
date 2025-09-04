Return-Path: <linux-kernel+bounces-801381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA3BB44467
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01296547C7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2A330F7E4;
	Thu,  4 Sep 2025 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyQqNY4M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB879307AD2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007134; cv=none; b=GeevDIVV/gb20ACPHc683dcNB6BqG1nHhprWHS7W4RDVX5QWaSLR7NovxXiSSceX2dPJPWrM+7W8WwHaNQ/X2+7fIxJfqBxD2lL0NAxxzfLBimW4EF3vMIVO8Bz5b+kkaVyZiwZ/rEPQl5nACSw42W9s4We9jZ+d6zvVdxpIZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007134; c=relaxed/simple;
	bh=S6K7ZuuI9Bt+Smd+P1c+fd+/jUyGt2Lk9wkEvGESl70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXnc3k460ukAHS4s9fCVSs2cVcv7KJxXszy1sG0JyvvWhgYWAj7TLmFbI03zC+UoZzkVkqorCLpV6SWef2/50PGpi3CZI3lWeTpuVnRQcoK5mVmlXZ3mqo16hREn7qTGkC3IZ49oxypSx+pANgoECaxGrnmvtpG5V7Lf51a/G1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SyQqNY4M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584GV2Io018638
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 17:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Da73JYrU/YH6aVt86oA5anWyeFztGpATifsoe84jD5s=; b=SyQqNY4MUimxvb2E
	dphFdMl8HZnvD9gFoeUmBK78RINJHp4EvPzSR/kBUwREEKvdIgZ69XaIXfiAskS0
	kstFiRXXynOQDO/+Bhf7eG3rMYPBQoTBVh/uj8rhfxcQdjKNCaQVP9RAbQizEJOI
	xJ+XeQ1mgH8r2Lr+YpmR65BvGf00qbzFtgrzxAtC86q6uCMA4RYT3/X7XeeqEPc+
	Ueooe7YQhng4pqWkdkYL890YuD5u3eC7RjgTzQEt9DRsi1XSHFTqc61HkL7iMvRT
	BIJbvAEmb04Qebhdh+6JJxPXWDRN7xe39AXYJ6KAOtXHSwsLvA25RqDwWhU3aRz7
	Wn5rfw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebur6qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:32:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b3aac677e1so11892651cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757007130; x=1757611930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Da73JYrU/YH6aVt86oA5anWyeFztGpATifsoe84jD5s=;
        b=pT6o8db77tlbXtBgQi6E6ra+Z/CsInysYKvcQFZKPtpSChuukrT6VkQgk04LSytoBi
         9dEI1nNlSnMbVeAxZamcGf8U2tvXqL4PFW+sXgyEMiulGq9FfqnZcGt0BBGOJOkogU5T
         WOVuN+7yV923T2y2fvJ2E3nyjNruTlf9AFpm9bUlPyKfoV61Hl0WEl8q4qzj7U3pad73
         w3oJO3mr6Yim+7TYaD2asJdk4gGWq2TdPZOOx8soo0MjA59jkzHt9VJoY5Q5Ymc1mOJG
         ykkEiNvHfOMkjtbgjNyoEWuyjfQwpD12Sctxp1GusJ3uFk/Gdra8tYMOmbNzndvYKZVy
         qItA==
X-Forwarded-Encrypted: i=1; AJvYcCUaLgJVNiIX6r227kVqcLCLqQqbY1E7kUNbO/UvpusZwqUJQTq5Ew+xZwodbUUoJWwt7UDV0AhDa1c5chQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLqub3Uq5SPnw7iemnSpHvzU7eX27GDgi/WxRgy0/hKA5Y/gl
	mk6PGGsEcWihMWitg5CdIfir9zmf2Eep0/m6JCGkGZs28KdB5MVbmQwLleUBTzj1MdIyt1fIIBn
	p418ZJ4nMlnDTryERZzI0b+0iqEHGgcpXAOUhbknmlLk1EdcPciN10TXv4c90EwEcl20=
X-Gm-Gg: ASbGncvzVQQAwwBYqZ7rBk9m2pOhlOg8oDjR/YUTIcUjahqAY9g2fbkHPFM7xS4RZnd
	1D4lahZMPhzabBURI+Vw18+FxSPYOrhmA5PnLQn5RRNHgW3L60cwMJ+KIiO9c6j8RXipqveQXaH
	ONrRIzrGnmvAH2YZnTKnOjlIKFSy8TVBzHB0xasvh2XdeegHxddYfmLPU1ocR0RSdJjB89/N5V9
	9EJT0ME+GTzxYSL77JlbwOkUwBwV4ynNYpQRKadga0YOIn9sNb+1EUygL640Pl2TAl+5ewoZwpp
	2YfeyZzoBV5ezPBuShuxsvLB2Tmuk5xrgo0UQORq/Svb6JHIeWAbvnwNS+f1fIHlgElt/b/bE+q
	z5rYaO29I5jlzWUHan4W3WK4V1NgwzaPnd0xNVOrNnaPVa4tgHhor
X-Received: by 2002:a05:622a:5809:b0:4b2:ed1b:c4ef with SMTP id d75a77b69052e-4b31dce5334mr232514681cf.82.1757007128145;
        Thu, 04 Sep 2025 10:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzY46Xf0yuYtNJopahgPntF+57SdK24XGBjq5que+6q55hgL1+myrBZjHkcDslthTY8AGG6A==
X-Received: by 2002:a05:622a:5809:b0:4b2:ed1b:c4ef with SMTP id d75a77b69052e-4b31dce5334mr232514251cf.82.1757007127542;
        Thu, 04 Sep 2025 10:32:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace9fd1sm1316585e87.83.2025.09.04.10.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 10:32:06 -0700 (PDT)
Date: Thu, 4 Sep 2025 20:32:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and
 SDC pin configuration
Message-ID: <zofmya5h3yrz7wfcl4gozsmfjdeaixoir3zrk5kqpymbz5mkha@qxhj26jow5eh>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
 <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
 <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
 <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
X-Proofpoint-GUID: VKUEmLdQcxoQjx8YqP3gyAvZnIahshzN
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68b9cd1a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=7jlciowUQMUDIi_Z8n8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfXy18A6s7kTcpz
 IS7f2DUF+oLo9Tany+BrFl36m59ltaF2mx9oWIGLFGoyMI5uGso+Q5bLM/SGXLUKTjQtvYSRMVP
 YoJEAvS8k6hUV4v/q7qHoAFQ1lRGfOE4ptKSzGT/VmDb+gyTEFBY3lgwEBEKsryFBdYw+TP6iUI
 mMnlNZvTPsys2Y75+i5Sp57TF12Bd4hCRiewKs+oFRlJ/pPgyVj+jtN/Bq+sDF9LvVjDKGlsjfE
 x1h01AdCAYPaU/BqxRhA5NiZlVGfBV9kJMHU0vtCRhOUUzQjYp1DPUKMTuumoaKBqQMvJMhA0LF
 zJBTftHQ0UNOck6CYNAPTuSjBizC2eNsHn74RP5ynXapzqzQQPGSTSVRU9WthNkexbRjSIp+wsB
 bE5MPIBC
X-Proofpoint-ORIG-GUID: VKUEmLdQcxoQjx8YqP3gyAvZnIahshzN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

On Thu, Sep 04, 2025 at 04:34:05PM +0200, Konrad Dybcio wrote:
> On 9/4/25 3:35 PM, Dmitry Baryshkov wrote:
> > On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
> >> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
> >>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
> >>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
> >>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>>
> >>>>> Introduce the SDHC v5 controller node for the Lemans platform.
> >>>>> This controller supports either eMMC or SD-card, but only one
> >>>>> can be active at a time. SD-card is the preferred configuration
> >>>>> on Lemans targets, so describe this controller.
> >>>>>
> >>>>> Define the SDC interface pins including clk, cmd, and data lines
> >>>>> to enable proper communication with the SDHC controller.
> >>>>>
> >>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>>>> ---
> >>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
> >>>>>  1 file changed, 70 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>> index 99a566b42ef2..a5a3cdba47f3 100644
> >>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
> >>>>>  			};
> >>>>>  		};
> >>>>>  
> >>>>> +		sdhc: mmc@87c4000 {
> >>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> >>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
> >>>>> +
> >>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> >>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> >>>>> +			interrupt-names = "hc_irq", "pwr_irq";
> >>>>> +
> >>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> >>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> >>>>> +			clock-names = "iface", "core";
> >>>>> +
> >>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> >>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> >>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> >>>>> +
> >>>>> +			iommus = <&apps_smmu 0x0 0x0>;
> >>>>> +			dma-coherent;
> >>>>> +
> >>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
> >>>>> +
> >>>>> +			no-sdio;
> >>>>> +			no-mmc;
> >>>>> +			bus-width = <4>;
> >>>>
> >>>> This is the board configuration, it should be defined in the EVK DTS.
> >>>
> >>> Unless the controller is actually incapable of doing non-SDCards
> >>>
> >>> But from the limited information I can find, this one should be able
> >>> to do both
> >>>
> >>
> >> It’s doable, but the bus width differs when this controller is used for
> >> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
> >> only what’s needed for each specific usecase on the board.
> > 
> > `git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
> > properties inside the board DT. I don't see a reason to deviate.
> 
> Just to make sure we're clear
> 
> I want the author to keep bus-width in SoC dt and move the other
> properties to the board dt

I think bus-width is also a property of the board. In the end, it's a
question of schematics whether we route 1 wire or all 4 wires. git-log
shows that bus-width is being sent in both files (and probalby we should
sort that out).

> 
> Konrad

-- 
With best wishes
Dmitry

