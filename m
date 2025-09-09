Return-Path: <linux-kernel+bounces-808346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91CAB4FE97
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8E05E2713
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8DB230BE9;
	Tue,  9 Sep 2025 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VPx1l0T9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306321ABC9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426574; cv=none; b=NePiFC3zYndQtBDqzJCI7thpFTGrHfZyAGNA6A6hNHniYp924zJupZlo8cdKi27Iy5TXOW8BrmBJNJIMQr3t8jR8oLGREBMrWfIXYiGPJhzMeiGIAvveyfbkMyzghv4yKXMTDwIfnDaVLpd3A/ggrMduyvCyWRHmZDHb57GUMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426574; c=relaxed/simple;
	bh=bJDPOaYhrJgnzTxZIu8POOipEZb0RjnC1CgvuoSxu2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfL6LlVqIWoWAFWR004+exvlw7r2IL4jOGe+JF01rx7S7KnvNxjdjcRrVbNB5m/2p15zKrGrrWfDiQtYTTWa1fol4LmhvVg4sHg0KksKT3XrngWbJ7V4m5Uu6E0rTUX7wLv6OWrcoTHhoO3Rn3g/5sN0h2CvR+KRLMbRaSvcDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VPx1l0T9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LmNG011213
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JOw1z5sVNtTfRj+xa1tk7uDf
	0N4y0ILLz8O38jaB7uA=; b=VPx1l0T9twFG4Y6p7RRugzzpYWBNQvZ6uEzklj0o
	1uXohYCkqo6UcclKrJUJGfsFq7n9Cd4ILY2cA5oxMAJS6jka1WvZG7qJ8tSJUsIH
	V/uV1ctoA1tsXSOcpbBR4UFVqQTGiOjz5e7MLdcLILHDwOt6VVVmOLUS5v4TL/Lc
	xAvwNKuHN1kRr/wvoTvJYSZGf2n1Q/9kmCmWxnfC1bzsZwbBYopIFJwyQyclsGg9
	OheTG48O8tJircTj2wlOSz40jrdtHfp0Gga9YauaFjQ/+dcQ0tA6x3/YrDQxsHS7
	/hFS5kWPhfMbjidsN1yDsceOiRd67eIsUm6fvhw0f7MTpA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0reb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:02:51 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-8a088e84577so6128528241.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426571; x=1758031371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOw1z5sVNtTfRj+xa1tk7uDf0N4y0ILLz8O38jaB7uA=;
        b=YRKcVtawHBAHqn4CidX/94xaf3P+K/2WHDjNFo+YITWGB8WvedPWG+MhinWfELc7xX
         fgI+iUcMiSrsOBgUXJuYs6TdWhMmRC3uCk2y7zsYjC/fBlCLo2jCdIHljxXe2uLYanMd
         Z4U+HvUEI5ElI7HxSZH57jUplvcY2GV/EU6fe9CB4tI7McIP7eMcbomsqWsruKLWl8AG
         aXpS4MMhCjI19DpDnrWdEtHukkXJLrBJUvhbxazwu1LZjuvj602/nCkhHkKoWrmc5Pid
         N3V6pRrymO5MPJ+oPpZB8oLs8Gs/bf+lgusIzSnLKc9+q5lNjqwfhnkf9x+skxk6TAjl
         Z0ig==
X-Forwarded-Encrypted: i=1; AJvYcCXYzvsMvn76oU395VY+j7z0LhB0QfjQxIxEQb8Sipg6PEbfOJmkq3j2Z2fwKJDCMIisXpjyFgI1iVP5BLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzik55LoKNsDXKxCoyeDjmT2nOvOvV2ZUlTM066padMcNHbkjc0
	nvh1HHDNxz/3JZ4RlNMvtwKvaDUsWBYU95UK3wHWmlReGvhglPtzhon0UPK4+8C9StBHSkiBgEV
	887OLAnvp4o7HzKFnTWaGkziqwa2CpHHVWJ5ZhWZlfojELjMQHBOGgnfanFP/eKqbqpg=
X-Gm-Gg: ASbGncunz/c1Fmsr98jW3s3pncszzR47qaeJd8h/3s+BnFn5Xy6LBcu9f1eXltodm+n
	dTuQI6RMOdMX8VqAIGqNDqC8869UlpGvMZJ/VjMo0JDr2ssrXNXS704WmQp0BwSK7lGSOdbFR6q
	5rAEMo+DT7sYdiPdyYtuCfckVoM0jJbL8nxvInK6/Tkz5HHjkVP4fW8BWVbR6ux+WvQ/1kurALQ
	ZkwF5Un2z1+IOn0+XegpSpWioih4WTjFBzrc13I/FjHW4XFFMwWNRSWTlI0mwlRK+E9Kp1q4r1u
	bli6zL3d9BP/DMp8MNGkuQb+bXHzdrWfNPCtqTXYESbgGEeuGIFQOCG0mwZxmvWvgK7exlYiG/r
	lXDyTLVSbxMPdCXogswDFMYYE7V53vj0IkoKlSrUeKC/XBLXW2J4m
X-Received: by 2002:a05:6102:1449:10b0:535:2921:ff3c with SMTP id ada2fe7eead31-538eeea6e2emr5482422137.17.1757426565690;
        Tue, 09 Sep 2025 07:02:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTiBB9xu/gj4kgce3Wxm4mFaVVVWJ31EwOjxvkEQXaamlM/G2KCDUh9c7HFp4BRfs2Sui4Rw==
X-Received: by 2002:a05:6102:1449:10b0:535:2921:ff3c with SMTP id ada2fe7eead31-538eeea6e2emr5482310137.17.1757426564621;
        Tue, 09 Sep 2025 07:02:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681795d63esm546273e87.66.2025.09.09.07.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:02:42 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:02:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sudarshan Shetty <tessolveupstream@gmail.com>
Cc: konradybcio@kernel.org, andersson@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingweiz@qti.qualcomm.com
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add support for QCS615 talos evk
 board
Message-ID: <5oytapnerwmttc62q7s2vxlrtmcfg3bhiycpw4enak6zyaioyh@s4drz5x7hoi4>
References: <20250909125255.1124824-1-tessolveupstream@gmail.com>
 <20250909125255.1124824-2-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909125255.1124824-2-tessolveupstream@gmail.com>
X-Proofpoint-ORIG-GUID: aPiWMSkgWs4YrgA0l_4WTUv6T7R4bmjc
X-Proofpoint-GUID: aPiWMSkgWs4YrgA0l_4WTUv6T7R4bmjc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX21vucCk1lBT3
 8ZdgrKk5GVVV3X4E0oea7ulGr55oh6i1j8wwwiTc4v5AzKffO2Y+6ld9409O6/oXSdrCEvaOhj8
 vtYr93MqVeSRoztMX3/qt16gcGc7L8v9roDR0WapalP+jvi1LoZVMKSXzdfnfoXuIEYrqYIxSUr
 /PAByt7ZwT7npBLeuwYSf7r/q5QUtjILXv5l9PpWYUigfMyIbfVPfn3bwzkpa6YPEWMXRVPVWzA
 nNadPi7tUIpNnQ840sMoY1DMNRsEUe581cpxQ7NlJnzfXi7hd910DaCWy+y6p8eBVk0p4/By7a7
 dEC8C6zqMvS7bgzUuOOM2gJx6j3KtOL6itB/1yW+diPsYOL2da8+XSYXAXSONq4XFUyeTXAi6w9
 I3Onm/5Q
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c0338b cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=kIIBkZXHDdBR5UhwVmkA:9 a=CjuIK1q_8ugA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Tue, Sep 09, 2025 at 06:22:55PM +0530, Sudarshan Shetty wrote:
> Introduce the device tree support for the QCS615-based talos-evk
> platform, which follows the SMARC (Smart Mobility ARChitecture)
> standard. The platform is composed of two main hardware
> components: the IQ-QCS615-SOM and the talos-evk carrier board.
> 
> The IQ-QCS615-SOM is a compact System on Module that integrates the
> QCS615 SoC, PMIC, and essential GPIO connectivity. It follows the
> SMARC standard, which defines a modular form factor allowing the SoM
> to be paired with different carrier boards for varied applications.
> 
> The talos-evk is one such carrier board, designed for evaluation
> and development purposes. It provides additional peripherals
> such as UART, USB, and other interfaces to enable rapid
> prototyping and hardware bring-up.
> 
> This initial device tree provides the basic configuration needed
> to boot the platform to a UART shell. Further patches will extend
> support for additional peripherals and subsystems.
> 
> The initial device tree includes basic support for:
> 
> - CPU and memory
> 
> - UART
> 
> - GPIOs
> 
> - Regulators
> 
> - PMIC
> 
> - Early console
> 
> - AT24MAC602 EEPROM
> 
> - MCP2515 SPI to CAN
> 
> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> ---
> 
> This series depend on the below patch changes
> https://lore.kernel.org/linux-arm-msm/20250625063213.1416442-1-quic_ziyuzhan@quicinc.com/T/#t
> https://lore.kernel.org/all/20241224-fix-board-clocks-v3-0-e9b08fbeadd3@linaro.org/
> https://lore.kernel.org/linux-arm-msm/20250604-qcs615-sm6150-v1-0-2f01fd46c365@oss.qualcomm.com/T/#t
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>  arch/arm64/boot/dts/qcom/qcs615-som.dtsi | 414 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/talos-evk.dts   |  42 +++
>  3 files changed, 457 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs615-som.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 4bfa926b6a08..588dc55995c5 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -117,6 +117,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-shift-otter.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs615-ride.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb

BTW, 'talos' > 'qsc6490'. I think the list is expected to be sorted.

-- 
With best wishes
Dmitry

