Return-Path: <linux-kernel+bounces-854576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C7EBDEC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D06C4246BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE418224234;
	Wed, 15 Oct 2025 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYOpVt6x"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4849223DDA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535201; cv=none; b=BvlPN3N2KFbpNyvD0baUt80bq+Nghsq66ClFfaafa4JURM+imnNq27y4IO6btUT6XH83voftsyOMbktg+a4WyiZpUuHplT9nbFOYkWG/yXVqTACVAqfXZiST8BN5YjFhjA+Kb4e4/Vunt+YSe/qM4HEybUztZINOn7GulqR9Lfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535201; c=relaxed/simple;
	bh=+le6pQnpYIqyDX1Vhk9z2PgAhYcQ3IwXzX0Pr+ydPoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcQcfGJSWl5dzS58GkQzOebb1OkkVY5IRCLzLa9qFRWhdf9PvePsl3NTuCMHYHQhQudC5eDUpYCkIgDbXBsrO3mFRfLRjaa4CfTJ1Z9N0Oj7TPSRpsoXpEybzzFM0hwaecCXtUUPlGpEo01py1dxH9IJvhGCOcw1FanxcrsyDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kYOpVt6x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAoUKY004011
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AYsgOVBA7Z39yU4sRJaVGAv+
	du8177HkKLbBm/7CRRU=; b=kYOpVt6x7ZrOFlbBHQ7rq5QqkzFg9vxir8jxA/3j
	dfVRZe3HyGY9c+8AMXWKl749dfFUo09RFWkSow3UBoebWZMqNT+2UVfoJzfkvg4H
	gGME8YL1ShXwQ6xoYazFHE8WB03Gk+JlyqGPEasX7Qr7QqTEZb326bb9A0XIDtEU
	IQ75x3RzFKA9KwEnrq07lX/DW6DtSOVzQ5FgiZ22/bACCRFzBTzSnHx/eDE0ztcx
	hbpZCfx1Pnjg4YyionXHxTawWcqdASk8edNuJ+64zaRU6Lnob+p0PXIOgRCfCTYL
	3iiKBT71tH8fflUuve+f1a5GCG47IO+P7CBy/3Wq8U1Ajw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg4dm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:33:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-88e35354330so324674285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760535197; x=1761139997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYsgOVBA7Z39yU4sRJaVGAv+du8177HkKLbBm/7CRRU=;
        b=JgwWyo3GkTEs6XF2y6Dh45BocNlnnka9+8nEmkvjcu1YYRUGQH4V4JnLDLmaKSn521
         QG6Y0T+IT7HBlz876wLDZwOhv/xDxT9NuuGU+LQ+Wg1SSKFMMVYSuuYImBtfeJdvFtW8
         qkwHLA9FMWcFYdhehqA4Vg8tyhiucEjfT3TcIu6OdK9FDfTkDhy5rNUqIgRf1w5UQv38
         BECTW9iujsUNqUa7eJhoXAgUFHIBzclG6eRquDD1bhQ8QPGI14lN1QLbN+qmXfVg1A4r
         OiKdsasjJETKKW/q66h/k8Zd049Dzc1IxkghK0BYZF/LcEyAez5v1++VE14iweho0SNW
         AjSw==
X-Forwarded-Encrypted: i=1; AJvYcCWTptlAShaBmuiXIKvLvNxwra2QkPwEUK1WsKGu1yZdck6QZRj9a9fQYJpYOdx/h6I755Icw3tnfRmY1OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvhWnbRrCGmVMyOdduhpPGXl37j1n978I+SwZVjITQGGfh7WWA
	h0W/rVdOHzRQEQxL22mVBtcxQKr3jK3TIEfuNfbtDj8rpTqiQCn4aDSoRKuuPO8ZsO9BY4PtQsS
	GwDZntunIAbi6bQrvvKQwRgn0/wvhtiJyLKgjqXlNyQCbH/UHHuq+4Sjq+TVeX0C3Xyo=
X-Gm-Gg: ASbGncvwox1Vv8wg+RtwI9BoJKXgVDj7FmAIKXXu0/oRkKaIyDjh5RTQVPMfFooMdxE
	eesqg67XnOcxb5/vZf0vBG0yTgNPdyxNZPFpowYBq8aP4H2OjqQItw5vpBQ2frfZTzoxBVZd4zD
	MgPp91Un/DgzpcC9eLJFudWUmU5U+Pmvm0ghS9imlwUE1UYtq4d9lwAXv/3eA/72/lNyGywnYao
	h5hlT6ABW60l/ArahR0KWSt7OX+xjcM6D8DuyWbtkbyhYsbwOKBPeVK14IC7Ejseco6cT2I+d59
	NPXfHl1Gnlvnb1kBfU6/sNLayr3X/rOgD3DYaiX/Ac1PSKvOxtUNBULrVFjh72IS5IrLHkVT9SS
	txD7/k10b1kz0O/gUy2YDV5NOz5ZKFubj7Zh81NTYLL+6GsjsbOXz
X-Received: by 2002:a05:620a:a51c:b0:883:8f41:95d3 with SMTP id af79cd13be357-8838f419a66mr3240540685a.76.1760535196673;
        Wed, 15 Oct 2025 06:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNhZXXtF4s4gCOlTvurv+JfitR5jS6lu2tOYKVCcP5qacETjxNcMJzQs0EpP3eSrAc22cHlQ==
X-Received: by 2002:a05:620a:a51c:b0:883:8f41:95d3 with SMTP id af79cd13be357-8838f419a66mr3240535885a.76.1760535196129;
        Wed, 15 Oct 2025 06:33:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea11ed5sm47346521fa.35.2025.10.15.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:33:15 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:33:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/24] arm64: dts: qcom: glymur: Add QUPv3 configuration
 for serial engines
Message-ID: <bngdsqmcxtlolmwr4it3wy7rldikzffgwwuyj443dc3v3ilaju@eiveujsf4up4>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-4-24b601bbecc0@oss.qualcomm.com>
 <8828946b-3979-4e7b-a11c-740d8a6253ce@oss.qualcomm.com>
 <235cf6b7-e758-4d16-b5a1-182cc869b2e4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <235cf6b7-e758-4d16-b5a1-182cc869b2e4@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX8EPCZ+LFVGWg
 9jApKtJCgYgDx/OqoMsyu/3TkX5Ex4Q9oVP5I8tBAcacxY/98WCOineUCCZq7zvhLK6FbRzVukk
 vbPAelSAI0+1BBrH0XXLp91tAHOxAFfzAmqeHTRWFazymaPLtAQkSlEm/9cON6t3RaBhA26pe5C
 ECsg6GzzHsao8Kh/Uor/O49T5VeQpTKVXhi6FMswsYEEns2jIAfTaxMNkCXG2INPZrxzL9hmRQW
 WYXIZtHavbZCtT4ESr80zqhTULoIjx8BTNBu2aqVLzt82pjLoI+ChBcpHIwD9AdMwNreAQIewlX
 sB8CZ+WBKCcBULZUO/TH5r8VEdHETM71u1UCYLSt9VlPkM3ibdxmlHJO1coAp2eIsT8x94uxfJj
 m3xpEQS5agJuKuIx9pUrpA6qku0QeQ==
X-Proofpoint-GUID: SlGYqoH4Ys-wWd6nK5pZoiQtxbxnKz6_
X-Proofpoint-ORIG-GUID: SlGYqoH4Ys-wWd6nK5pZoiQtxbxnKz6_
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68efa29e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=tzzdwlp8NxVFzfzF-0wA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

On Wed, Oct 15, 2025 at 03:58:31PM +0530, Jyothi Kumar Seerapu wrote:
> 
> 
> On 9/25/2025 3:48 PM, Konrad Dybcio wrote:
> > On 9/25/25 8:32 AM, Pankaj Patil wrote:
> > > From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> > > 
> > > Add device tree support for QUPv3 serial engine protocols on Glymur.
> > > Glymur has 24 QUP serial engines across 3 QUP wrappers, each with
> > > support of GPI DMA engines.
> > > 
> > > Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> > > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > > ---
> > 
> > [...]
> > 
> > > +		gpi_dma2: dma-controller@800000 {
> > > +			compatible = "qcom,glymur-gpi-dma", "qcom,sm6350-gpi-dma";
> > > +			reg = <0 0x00800000 0 0x60000>;
> > > +			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 599 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_ESPI 129 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_ESPI 130 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_ESPI 131 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_ESPI 132 IRQ_TYPE_LEVEL_HIGH>;
> > > +			dma-channels = <16>;
> > > +			dma-channel-mask = <0x3f>;
> > > +			#dma-cells = <3>;
> > > +			iommus = <&apps_smmu 0xd76 0x0>;
> > > +			status = "ok";
> > 
> > this is implied by default, drop
> 
> Hi Konard,
> 
> Do you mean we should remove the status property for all QUPs and GPI_DMAs
> from the common device tree (SOC) and enable them only in the board-specific
> device tree files?

Could you please check how it is done for all other platforms?


-- 
With best wishes
Dmitry

