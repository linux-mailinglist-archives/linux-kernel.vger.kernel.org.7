Return-Path: <linux-kernel+bounces-832396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E75B9F3BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F44F3A9EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4A42FDC44;
	Thu, 25 Sep 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gfp1mM3B"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B72FD7D6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803319; cv=none; b=PNrQJbyub4w2A8PLhGysdwhT3l+cznfROfkQBZIvBPUbJPkOGXwKA+DUtXiIO4jBFoxpFJq6fGIzZTC76g4OKboUBgUS2O2nx0iq/X01i05SbaTzfin82oVAs6BD5wn0iLcQg81g2+dYyxzuFlZmxa2KB8CcQpJCcvV6JF6HfmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803319; c=relaxed/simple;
	bh=xoBcjEOsWzKlUY+RY517e5wLJ9Njlv/IQK7AyZKOOqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SV/hI3fbzeckEsZIy52Kw1aneMu/2OD9c1vKnauAGXTk57nntbXM7vqBmB4KjyULAQygAFHZu64nXUaPj8F8bQkSPakq1BK4QX2dQpZGJo/6SYoJb0mlPzK8cZlJxxqx1IcVEJpyplVBaiSrh+FNeWuE8Xc9RyENGmq1QVVoWlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gfp1mM3B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9jkQj023773
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V0GZRRknW9o7EW1Yvnd92OLQ2hYDNAl+jne1+4CXJp0=; b=gfp1mM3BbTepL/lR
	tqijfC4pqojPJ3Ke757LTAb0z4Kp120gmyEnXBMuqErMpOGjV9EbzTrmsjmKN0HX
	6TEVzfGr4AjR1Hrj14N9vrK+MixEYFm3qQKVVHyjsYmjMrSd1I9cJYoCUTM5fIa7
	64dmiOvx6ZRPMbpStv4mmlGmSB8LToMQe3lvmeezmVVb8DJMuB0MN2sc4dfEK6wg
	JDhmQzX+kwyewJoJoIfye59Qnx+mzcf7/cUoTalpbcofIUI7zRR3slGpUk8iPgfk
	/MWj3h+yy02hoBppVHnIKiOgeFqAegXTr/zvvuR+g+Cm9AuevZvyOcLGLQD2GqtN
	uP4Y1w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0f351-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:28:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8572f379832so29679585a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758803316; x=1759408116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0GZRRknW9o7EW1Yvnd92OLQ2hYDNAl+jne1+4CXJp0=;
        b=U4hB0/z4IhdOTzhngORTq25MAKb/XCJXKfEy6VLannuPoedDY0Pc4FW3sVVMAXDwCI
         Gpjfdn5N9qY59nMGGMdl/DfIQeRfsPFcMcShepEZd1Z8KkaM3mhgZA68CD6LCNMYtMml
         g5fxfHLPzcsVxTaHsk8ZuFAqizpkX/OE5chtQUNie1KNkZBSAeo9O0uYYNFnKuSZq2ja
         FkTIjASPd2V0OXuvOHxlCYhfHZbWDwRpy8PaK24wd7muElRnkfHax9YHInN3GKf/6bYu
         chJcEMU4rp1kS8QIP16J0YVgZpDfPAYeiCK3/w4th7qBpkSOF0U+VWTWPyvpM8uV5jLY
         AbhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtP66vSDVP0fwFci3Cv+p3zkqEHykLpyQfgqBbGhgj8bkfvLSdSdRzuJ0Po9u4Ih0YAyZnpK9g+yIl3p4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4YaHGGfqkJCZUzowxnZmbvg9RGh3xM8ThnN0yxKWctOsy6iOF
	+Rc2LrmevpYmwIfkxsj+ndNwrZ/BWx95ImAGusgOX9JzX3FzY1PEvXAp+sS4FBbg3zlMIpNWQ5m
	TMpFex+N5chI8UJncOSM2Hq8M9AQ4fU5WHyDmLXg8oYTZDN7wPKQCdeCHoEx1BPPiYyU=
X-Gm-Gg: ASbGncsMGF18ifbml0aBDj0DCjCJcFi0QOpV0lAcFe/oRsy6/RX+oOMBbHpIdKDlb5l
	mWzhOoFxR8BLTqNyjrHNHHLioyY3sp5ZrMO1MCNWsrz9FMXsFIjRvcvXiq8mDDyxLk+iDKtUcFM
	4ulNPqg3YyqilIgQrucwLtt9QDLQ9oeZsOzi3UKtGJqpzMvrCqipQz0mVrEEehQ8J2vA0ZQ0Nn2
	0fgatlhmAsjxt/DJpHZpkA+ouwFSpEXSeO915z4k2lPS2p5hnpWXT5mF0I/jT40w8KQu+Fim1LT
	RfCFbtnWwz/ClAdwf7IxXXvov3APxMK6Nj/hjHihPrto6d5uKvGQgmgGA4z1ZP+CCfMzXaFp1vQ
	9+rxldkpEQlVSPL6+cbIXeQ==
X-Received: by 2002:a05:620a:460d:b0:82a:21ce:47e1 with SMTP id af79cd13be357-85adf2f359dmr312957585a.3.1758803315276;
        Thu, 25 Sep 2025 05:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM6c2h1CrqV8ug5St6KIgjLq4LwvQ1d2xsdc29T9g57ZuIMtMPgBqdlsWzhMkQSR6YAu8poQ==
X-Received: by 2002:a05:620a:460d:b0:82a:21ce:47e1 with SMTP id af79cd13be357-85adf2f359dmr312954385a.3.1758803314834;
        Thu, 25 Sep 2025 05:28:34 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f79a7sm158384566b.62.2025.09.25.05.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:28:34 -0700 (PDT)
Message-ID: <9685e29d-bff3-4188-b878-230d0f161ce3@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 14:28:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] arm64: dts: qcom: kaanapali: Add QUPv3
 configuration for serial engines
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-13-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-13-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d53574 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=pIWn_-EevS54mbaqKt4A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: NgM5XGM8gVz6hMiyNnwyD_QVyEUVCA9K
X-Proofpoint-ORIG-GUID: NgM5XGM8gVz6hMiyNnwyD_QVyEUVCA9K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX/Tsxx/OuIaMx
 xWXQ67d8N07H/7R/bWUAtFZj/FH96A9569qWgYJlWM2LAQ8XfkrBVwldoqFsH2wnJz7StF2Nk4o
 MT0HhDx1ktuEV5vKoaMp+EehZZDTfh5LXSnjZjJr6dfG3eEp+evHv/D0eqES0F+EguNN31VDA/d
 rDTXxUJk3Zw/Jrj0DX/JigDQq1Y/5nQ3rBuhYYVo178bxzt3IyYnFPSYY/HSC4UBiIVSU40twPZ
 GTEEZXUFC/SHKQzpiK7xuvhVt0BRWtu/Jo1etUkMt95MNseAmc1F5Lg/dzakSDYbx/OTX4DW96x
 qwmhvBehd9/wSKmJmElodrNRJ2p272aQ2R/vO+hsmoQAJ6H4ZvvWO0UWWhoJIJcFZx4PdcLBBPz
 o0mC6vfy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

On 9/25/25 2:17 AM, Jingyi Wang wrote:
> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> 
> Add device tree support for QUPv3 serial engine protocols on Kaanapali.
> Kaanapali has 24 QUP serial engines across 4 QUP wrappers, each with
> support of GPI DMA engines, and it also includes 5 I2C hubs.
> 
> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

[...]

> +		gpi_dma2: dma-controller@800000 {
> +			compatible = "qcom,kaanapali-gpi-dma", "qcom,sm6350-gpi-dma";
> +			reg = <0x0 0x00800000 0x0 0x60000>;
> +
> +			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 851 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 852 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 853 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 854 IRQ_TYPE_LEVEL_HIGH>;

odd indentation (on almost all gpi_dma instances)

[...]

> -		remoteproc_soccp: remoteproc-soccp@d00000 {
> -			compatible = "qcom,kaanapali-soccp-pas";
> -			reg = <0x0 0x00d00000 0x0 0x200000>;
> +			i2c22: i2c@1a8c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x0 0x01a8c000 0x0 0x4000>;
>  
> -			interrupts-extended = <&intc GIC_SPI 167 IRQ_TYPE_EDGE_RISING>,
> -					      <&soccp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> -					      <&soccp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> -					      <&soccp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> -					      <&soccp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
> -					      <&soccp_smp2p_in 9 IRQ_TYPE_EDGE_RISING>,
> -					      <&soccp_smp2p_in 10 IRQ_TYPE_EDGE_RISING>;
> -			interrupt-names = "wdog",
> -					  "fatal",
> -					  "ready",
> -					  "handover",
> -					  "stop-ack",
> -					  "pong",
> -					  "wake-ack";

Please try to use git format-patch --patience

Konrad

