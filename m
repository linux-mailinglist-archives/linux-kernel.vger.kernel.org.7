Return-Path: <linux-kernel+bounces-741957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1507BB0EB35
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365A7176FA7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2330C26C3B0;
	Wed, 23 Jul 2025 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UiipYy67"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFBD42A8C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254201; cv=none; b=sPivmrYZXwFKWKipPcCxHN5Pp849e94ykvvI5cc0/sfjSacOZs4ixwzW3orm1A1VkFGOmklOu2HnNnRY+5B9OuaswI1GoqqZofXIWaK/14Z/O6LoT/JEKqT7Yg/4riHDylYCQf/T1R+TuWgQyzfnrmPYscbKNmHZp/dqjoyVIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254201; c=relaxed/simple;
	bh=HQ/VzO55hzw8ZKGaXble4MZ5AW+QZvBkOBgx65ykmDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fyhqi45nHqPOY9rQoPnc76p0bne+stmd74qvzEMyJNLL4bP1dCvsdCHaHIbag0GixoTHS/1k1N3LD5Tq5bimWy8PMyPBz/Pxkisdbvx21XxCPZGhxw0M7l8eTBq1U+UMf/RlB8QGDbuu3iUBvWlE1G+wnK6QColF6mD2TS7tXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UiipYy67; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMOCmK013775
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tgHrH8DxZbmAx2+kVkpI2EajPPpLEzEmxq3USz/0Qyo=; b=UiipYy67x6eYlWKy
	b+osKG5CE9EnGL/uFkn9n6zZiPLGsAA+JZpI2iv2KKA1OTDUVg+0AFYgt+ouo53z
	het1o+oOnfn9Fb13xnRUbkMcPvC6X01YEtMXkdClZCoanXoAqFnmeiAvtjmUNVgr
	HVA5KPy0c3XiXLmDEgXE3+rQFCSTfM8UY9pvTsy0Yj70zVFbZwZSwMGZtUD++/Ak
	n+ufoI9ixoxtroWDp9+6HF9n+bEpikG/LzO69Tq+dF2RJ/+DFqWx5xCD8cfiPUB5
	wMODRuCPPSWrYYMY+gXlwk9DlgF5IzhudB99BRCUdOSRm/Q/m6lTKG8oKCEcFjIu
	tYMlsA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048vag6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:03:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b38fc4d8dbaso7165404a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 00:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753254198; x=1753858998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgHrH8DxZbmAx2+kVkpI2EajPPpLEzEmxq3USz/0Qyo=;
        b=HIyzUdFSDntzuo3ZQ8LmWNa7ktQdJBMjVpPdlZVbE7h9W5//PDtnIiO4Jn1FaJFx0n
         SZeaLwe2nuuIc87CEUPFfoTpVIKqcywRP2J113MtLEb4wNYLr6HnTPSdZdYSNjYakwEr
         JWF6TDKQNoHBIUT5ltW9+JoOyrWdeV17x3K//kV7IpTVqvDvLnnpxWUcblGuXco9vFRd
         CEwtM5bFG00UdML5/GMauJsNxZ2okO859QkZi57PtIiEBGEUj4jMgBmwWak1XRDFLDU4
         Nd0OBycl3HDbIpW4QW2R7q5ip9AITeHRa3YGlZzVWR2283a1lajzuqVQc55sKucL7ORe
         jwUA==
X-Forwarded-Encrypted: i=1; AJvYcCUdRRWlYf7K7EZ1c54qC5Nf9DyjpaZ9CLeW5x+dg85uwQlwgvv8D02uEOTbKf3DrjFjYtMwNVEfwUoWiSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAveXMSPvq29KxSHs8CHTcQ4Q1lD7FHtsoXgpzgyPNBfH+Tv/j
	EThECwr7huNoYp9G1p8O1W1mFW38QI0SI3+0hF0q77JnM4xZAGy+lHrjODRzAELVOoExDEDWyEF
	ypSx0FbqBtESBvHgabyFz14MIk2edQMsWuYRztFMtt0NrlnRKIXI9MSDRtcC7Lbnu5FY=
X-Gm-Gg: ASbGncven497wuyF+PK9pzIijgzVuj/80wXZWQ98vLq1gWo85FpgnOGHdRdLz9/2RGn
	QLoVjSq8voL5n6Jv71/OmgYuCLOnkj0h9OtO3Be98B9QgGV4HbZLnjYkFrzT9fLgJloH+UPHFQ8
	lyIonYTfgS5loF+yJ2a1PFiLjbumWXjRDwow67JSvBre6kmuxOgJ9y6yDVnkEAqOV38TRvf0HDx
	YSnpRCHVc/tsUrpM9cVntVxBaai2ku8DpvOzzaXoulWqm0mvTPSpnv+FBPI2DIoXUIDcpcH8CYo
	PH52N2r46l41ppVP4/PavY9GHKliueDsC/EIK10WY/nFcm6yv0Z6OaTNULZr+3QE0L0jIKhdIQ7
	nZwhr5qmB
X-Received: by 2002:a05:6a20:72a1:b0:220:7e77:f4f7 with SMTP id adf61e73a8af0-23d4911f9e1mr2982068637.25.1753254197887;
        Wed, 23 Jul 2025 00:03:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOdoj/Z0jEqXcV2S8L/uQoTbevs9LrXwjf85fcxGIO0OJDtv0iwbEYch0xtIVtUG3ntXRiWw==
X-Received: by 2002:a05:6a20:72a1:b0:220:7e77:f4f7 with SMTP id adf61e73a8af0-23d4911f9e1mr2982034637.25.1753254197437;
        Wed, 23 Jul 2025 00:03:17 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe69c80sm8194616a12.12.2025.07.23.00.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 00:03:16 -0700 (PDT)
Message-ID: <8bea2f87-35fa-4411-acb3-951889b92713@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:33:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: ipq5424: Describe the 4-wire UART SE
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250630-ipq5424_hsuart-v3-1-fa0866b12cbc@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20250630-ipq5424_hsuart-v3-1-fa0866b12cbc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 60W1BrnjiYa2152cAObXmQvZQHF_7Ioa
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=68808936 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=LH_GineItQtitB-Bug8A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA1OCBTYWx0ZWRfX+z70hhXtkrYS
 ufB1Zgyvg/Am7h8f6dMMzv5jHJuQslm6kpkDbS44ykm3+TbxhI6h67qaDFN11stef3AhFidNOZf
 0YZkHBT6wo/X3zoV3GLQ2Qi0VdyxtjOKQ7/Sq5oPokf4d2rWKkDOWhHV2JO4w8lmhO1VIfSG+fL
 wJFn7a+n5WIvMQes6j4pYK9d1vP5ot9tuzesZ6HmZnvosKXfaL8uwslb5V37Q2fSCBcNJGHdj9K
 pUQ/jFCA3nFylq7Qs10/ueosTJMPfuX5e8EBOUY94zs4oVQrCAVRLsvaaANyJX09Ek8PlN6Y76N
 WysxoRbMuWXTznElGVezw2ralvkcamUSu1YqMiDZbPUaWSg9daOwRdwlLcNB2VYES+mq6T4GIDi
 wr8K5nd6POQ3dEDb2lYVO4GR6xWCN2BHthzLp9d6jalNeRg64wh5UhfqSWzhQcarKEIDxo99
X-Proofpoint-ORIG-GUID: 60W1BrnjiYa2152cAObXmQvZQHF_7Ioa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230058


On 6/30/2025 2:20 PM, Kathiravan Thirumoorthy wrote:
> QUPv3 in IPQ5424 consists of six Serial Engines (SEs). Describe the
> first SE, which supports a 4-wire UART configuration suitable for
> applications such as HS-UART.
>
> Note that the required initialization for this SE is not handled by the
> bootloader. Therefore, add the SE node in the device tree but keep it
> disabled. Enable it once Linux gains support for configuring the SE,
> allowing to use in relevant RDPs.
>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>


Gentle Reminder...


> ---
> Changes in v3:
> - Add the pinctrl configuration for the SE (Konrad)
> - Link to v2:
>    https://lore.kernel.org/linux-arm-msm/20250624-ipq5424_hsuart-v2-1-6566dabfe4a6@oss.qualcomm.com/
> Changes in v2:
> - Correct the interrupt number
> - Link to v1:
>    https://lore.kernel.org/r/20250624-ipq5424_hsuart-v1-1-a4e71d00fc05@oss.qualcomm.com
> ---
>   arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 12 ++++++++++++
>   arch/arm64/boot/dts/qcom/ipq5424.dtsi       |  9 +++++++++
>   2 files changed, 21 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> index 1f89530cb0353898e0ac83e67dfd32721ede88f8..8dee436464cb588fdde707b06bd93302b2499454 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> @@ -224,6 +224,13 @@ data-pins {
>   		};
>   	};
>   
> +	uart0_pins: uart0-default-state {
> +		pins = "gpio10", "gpio11", "gpio12", "gpio13";
> +		function = "uart0";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +	};
> +
>   	pcie2_default_state: pcie2-default-state {
>   		pins = "gpio31";
>   		function = "gpio";
> @@ -239,6 +246,11 @@ pcie3_default_state: pcie3-default-state {
>   	};
>   };
>   
> +&uart0 {
> +	pinctrl-0 = <&uart0_pins>;
> +	pinctrl-names = "default";
> +};
> +
>   &uart1 {
>   	pinctrl-0 = <&uart1_pins>;
>   	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> index 66bd2261eb25d79051adddef604c55f5b01e6e8b..2b8499422a8a9a2f63e1af9ae8c189bafe690514 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> @@ -417,6 +417,15 @@ qupv3: geniqup@1ac0000 {
>   			#address-cells = <2>;
>   			#size-cells = <2>;
>   
> +			uart0: serial@1a80000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0 0x01a80000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_UART0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
>   			uart1: serial@1a84000 {
>   				compatible = "qcom,geni-debug-uart";
>   				reg = <0 0x01a84000 0 0x4000>;
>
> ---
> base-commit: 1343433ed38923a21425c602e92120a1f1db5f7a
> change-id: 20250630-ipq5424_hsuart-0cf24b443abb
>
> Best regards,

