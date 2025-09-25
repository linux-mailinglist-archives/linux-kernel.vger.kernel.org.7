Return-Path: <linux-kernel+bounces-832190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE9DB9E99B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F753AD3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25F32EA468;
	Thu, 25 Sep 2025 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SBZpuvDI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C858A279907
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795517; cv=none; b=gyxKMyTdPV8lY5HsWO6EzxYVm7ErTr2WPshlTapn6hHqIzBEW3uaap8kFGmVfjz5UmAZ9IiA4hDL16D1LXk2Hfx+n566ea46te6ccloB7XmopfP4UUT3+4pTjws1ms/dSWjq378Z6gSnJLvQDVC+cP3YhzGBM/YGlufJ0SHJHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795517; c=relaxed/simple;
	bh=IZgNx1W1QZTrD1Ehfq9YiwjcIhPzLhkZmIWo+Abt0ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYtmKX8TL8TBMQSv7s03nIHTrIKOMzx3KqeYG88QNnYA/ksYOLu57nLMZMPmFJZ5PQX+78p2PmT3062jwkfQxsZ3vnTyM0YGW7m/XdKJh1mwGMFaOa2sKckxSmpOf19dT6P+wfhbY/mGedC/AHwdirfbkzIzT6SxtulFIVlMCfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SBZpuvDI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4bJQk029400
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IWYVZENZspv4P6/8uM0cY4lKTEnxMEa9Cl47tXv/oVM=; b=SBZpuvDIQjx/DYIO
	+aZAzpqamVnTWwTz0XfPbjx9Aqq2JMIKcCCh825o/FaOPFbVirg9ZpNqLbSSEXoa
	VrYDT9Z3SJYypBndqdsJzAJdCYswDrnVsrkp/ptSXaShDLKQzaD0ADbcmtGULcNp
	uKKpHHje2Bpd+rEIojAWfjlfwfwOb9gedz4BKXq6SBm8jtAqma0ZWFNJaKKtwq+3
	cCW1ye66rIvAXA6okzdkbFH//5LW19o2iTz2cD1MuTteanXofmlQUpS0zXl+ij7h
	qmuT+Xjn8DuxzT8qLaObzmJ5rQcUsegDqd/b+qc48QZ5nqrwNd3+nRa5afFh821h
	5HA++g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup0xdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:18:34 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7f4bca2f925so1929936d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795513; x=1759400313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWYVZENZspv4P6/8uM0cY4lKTEnxMEa9Cl47tXv/oVM=;
        b=Kmd76jSQQSuy5A1Xni22g+M3ia9XabuXdou+F3I/Ul5cm6qnnMiWBxdSQpnb/qeMkU
         S4mH++Yc8ASs1fkpT794E/2BJ987FAfNnEF+ak5MyXCh8ZpneUQiPITM72p7fluY8ph+
         i1cl74F1IwKHzEzXHl8jYn7P13xFsRYdXFmSL9W6ZfkNJPHEROdpPxc9cdNiKI+R8GPm
         TxQD1CuzhhrserTLGyOWdzEFlVgCH35b6TrQsBauYd3bB7DiBAJ8zfIsYh5r7WtPwc4f
         8har35irHJ1IGS5NvkiJh/RgsPj2ay4kn8+UnMuWc1S0VDHVQTc7klUot7hDtxUyOIoa
         G1UA==
X-Forwarded-Encrypted: i=1; AJvYcCXCtg+qVRqIvnek+SlyO/NzBD+vssPAYnogvH7d01XUDhENKwGHKTWQ99eugHqa/RzMEp4Dv5wIV4VmpRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPZrekqCF7e4YTkY+8ySvqDvuljgPnuymORZdKXaL0i5OnOZw
	LCuoAKdEJDHLT2cJEGW60Mr9UeLahoE9EfRsulHAVfzXgjNjYtTZAUAtZRoQVm7l94FBqaJfvS6
	WOMcuiNGYfUQNVfStcdwyMFoL9sTrlGON4nGHJAkBSbo9G4J8x1MvwEdGIAq/wfXyRPSUnELRES
	w=
X-Gm-Gg: ASbGnct6Oa3Ju2wTS4+jcn0z7eqOBc6pt+SYzj9TXSUA2u8uvfe3jSadVVGLu/IH1bH
	CsBa0Urv9pz2CezdX00NrwW00oxROE6OhZZqObvwbxZgoLZOUQy+HHcIuI2A5eS9hxYipI+ixjh
	m2/qSEL8GRCXxH6MIJ4qwFfbeKwZnxvSyIBcflVoGghX8AkrMu9NRQ7f2X8DewrdDJjPvfUeKg4
	uuGhSD3aHLtrTRMypQFxWrezuIqXficFANvdwOIpK5ACTnZe3USQV8r1fsPqzAD+whNr4h0HVoK
	FUxiYo7+7upEaJHQsdIHDZOTxpEu3POYrSLiDG/+hphPcGRim2QE1sK79ujyJHDgWQ+nGL1c6as
	gVuFrNnY3gw2LVpbqzaCKcQ==
X-Received: by 2002:a05:622a:14f:b0:4b5:e76b:d621 with SMTP id d75a77b69052e-4da4bfba467mr20495791cf.11.1758795513122;
        Thu, 25 Sep 2025 03:18:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeYn583fkq20lV7VuagbZHBYgru0v4T7NMmM2UU22IGNtqwrtQzNW3vAC1VInKdbhbl5CJdQ==
X-Received: by 2002:a05:622a:14f:b0:4b5:e76b:d621 with SMTP id d75a77b69052e-4da4bfba467mr20495641cf.11.1758795512683;
        Thu, 25 Sep 2025 03:18:32 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f753csm134383366b.55.2025.09.25.03.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:18:32 -0700 (PDT)
Message-ID: <8828946b-3979-4e7b-a11c-740d8a6253ce@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:18:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] arm64: dts: qcom: glymur: Add QUPv3 configuration
 for serial engines
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-4-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-4-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d516fa cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=PXVopu1NAIokzL3Bk5wA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfX5YrG5xZJAfIf
 9OCHVeI02SlBoCRy8jEsO+pqw9xZVc+/JBf+xpVxMtnnYmxxPpf2WD+xrXMVHH9HRAHu+kT1BTS
 tu2f6aJQ8ykfm0zqkgGwDdSkJsnHcNSjjhT2lk74XYF/HG8BgDXeOD5zZdhC3wb207vg5TVFTqU
 JE8nCt4Z7ZoDL5ji/U9EvRC86hFdUt2ovUlT/kdp6d7pBvqWzkO6QfklOJnzLnH/tbXsUr0Va1F
 NlWc8z7NP7quiIipipnIf7Ao9MSnPpwlgAVG1iW5j2Ps5mwTGow64ocfztHo3/Wg+NxhVo9MI6F
 r0ul5VWxy0NBI35wUTdYI6xjthyHkrrOTqahvaSi1w9JF1TuQvsfRaE2xUAJNq2XhqGmRbEp3KV
 L7Lf4bWf
X-Proofpoint-GUID: Bg-zn9Kr3c6NnPnj9-DmXOM4yLSTc40D
X-Proofpoint-ORIG-GUID: Bg-zn9Kr3c6NnPnj9-DmXOM4yLSTc40D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> 
> Add device tree support for QUPv3 serial engine protocols on Glymur.
> Glymur has 24 QUP serial engines across 3 QUP wrappers, each with
> support of GPI DMA engines.
> 
> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---

[...]

> +		gpi_dma2: dma-controller@800000 {
> +			compatible = "qcom,glymur-gpi-dma", "qcom,sm6350-gpi-dma";
> +			reg = <0 0x00800000 0 0x60000>;
> +			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 599 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_ESPI 129 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_ESPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_ESPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_ESPI 132 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-channels = <16>;
> +			dma-channel-mask = <0x3f>;
> +			#dma-cells = <3>;
> +			iommus = <&apps_smmu 0xd76 0x0>;
> +			status = "ok";

this is implied by default, drop

> +		};
> +
>  		qupv3_2: geniqup@8c0000 {
>  			compatible = "qcom,geni-se-qup";
>  			reg = <0x0 0x008c0000 0x0 0x3000>;
> @@ -718,6 +744,339 @@ qupv3_2: geniqup@8c0000 {
>  			#address-cells = <2>;
>  			#size-cells = <2>;
>  			ranges;
> +			status = "ok";

ditto

(please resolve all occurences)

[...]

> +		cnoc_main: interconnect@1500000 {
> +			compatible = "qcom,glymur-cnoc-main";
> +			reg = <0x0 0x01500000 0x0 0x17080>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +			#interconnect-cells = <2>;
> +		};
> +
> +		config_noc: interconnect@1600000 {
> +			compatible = "qcom,glymur-cnoc-cfg";
> +			reg = <0x0 0x01600000 0x0 0x6600>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +			#interconnect-cells = <2>;
> +		};
> +
> +		system_noc: interconnect@1680000 {
> +			compatible = "qcom,glymur-system-noc";
> +			reg = <0x0 0x01680000 0x0 0x1c080>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +			#interconnect-cells = <2>;
> +		};

This diff becomes unreadable really fast.. please play with git
format-patch's --patience option

Konrad

