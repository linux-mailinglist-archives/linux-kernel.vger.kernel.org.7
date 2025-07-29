Return-Path: <linux-kernel+bounces-748947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9082B147ED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E5917B482
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C58524728D;
	Tue, 29 Jul 2025 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fwlFMAv8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44E8F6E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753768330; cv=none; b=URY3xDlqvXo+H1Yl03531G1Htmi8nclOr0qFOGgBQWAv2sCxWEmQLsTOqT/TV5RoHbjyCSuCv0JlivLjd0WrojGU14Z3aTuwhnGJIM6VnWA/SQq3fLFimuy5hguYN8MV39G5ZeGakUveqP96rqTfb/rIH2sY1kJfA8FqLX0hV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753768330; c=relaxed/simple;
	bh=4ZxBf02jRmiL1Rd7Qls57EgWT4R/d68ArMg6QgOXQ5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmI91K1KPeP7n66KqJsqWysj5uM9BRH6Gscz3iNpTMgyeptuKFaS1Htdu5V9VZAHxgLRuEGej2LeyeZOa34LKUw+1pcIRndPoINcoHcEDBCb1nlIvoUy+gDHG44x2BtvXf8Bjlyis4jUy0cbH9xzeeo4K4WDppKXyHovzsiS8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fwlFMAv8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SM5Ya6018302
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FTsbmHnB6Ndltr17HtPX185uJevkNqqXkyjv1rhV1rM=; b=fwlFMAv8zPLBLjt+
	CHrrBVgT4gsD+SJJbHBt5byIoNnxlJya6MRlyvCTlL/E8ykSyJdTKjsJiKeX+HI1
	8+bEMKMIVEelX8zTQ18VrXSkBuVsHDNIWxrQ8mXi3xZvopmNSVET8T1XR7rKSBNT
	ie4SMBGvdaxlilL+U2jroh8/bRUYH9tRv9oChDvlw9NZaJva2hIj0yb1fd0ytL7F
	eNVabCy3oAovFfQLrIc3RZwrjH17u8tke1gxo/UpjTCxTHGDGqv26zIrzwS20vk1
	tuvkwiG/LOS2EG57dOIz7ceMf8sNqMjnbGnLRIyT5AqkPgGEeM9GbxHGOCusIwiM
	sXCljw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbkxvnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:52:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31c38d4063so3936866a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753768325; x=1754373125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTsbmHnB6Ndltr17HtPX185uJevkNqqXkyjv1rhV1rM=;
        b=QUB4gn+Tv2ad0+jozYE8h+0YyMR/9ZhBBFdx0D4YZb0pr6FmNRdoC11h5e1Mh55EV0
         J+OQFer8eE9/z4CCWcMePSLC7XvXHodjL3stBFgPc8fsgeqJt2hkPO3Gyc6DfWXAIXU0
         CKj5/FRcXBcM7+Nh0I5yhwcobMN9dylr01jQkXs089wW0zJdKFVEyraRrS7dP/xUa1p8
         mySDdltF7LIgl3bfe3ve/74RY9QoAe0zpqMsEA2geJvVcd9ZGEWxAInOAjeYjfvPjz7F
         Dd61y5QEEzKEQcrrHTyKtRF+4pwoSmcnjSRo7UKe9VEwWcArzQ4MAb5Q3jfd/4TjSDqr
         k2gg==
X-Forwarded-Encrypted: i=1; AJvYcCWfCMfyHMgRIPGC64TOXTFc9dpbGQrkX4rgh2GxXG+KQUfL2xpRrRsoKQgzDfwyMdfsN+AWvX3ikswHzP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmazA5FiWEPpuD1qq6X5U4nBHzRHRhVuxXmhDzxf5nx1hkuCxM
	s45yvwjZh17aha467xXL/oisuz0xdh18CNdDeDSe3gd4A6B2qD8mu8yeDA7qx+Gd0glM2ZFFjDx
	SKEQ4QWptXpbTdKByX4a40iDFqW+sRwTIFyI6pbDGZFFsJiLF9SsgFE6GReK6HRoR1Es=
X-Gm-Gg: ASbGncuo5eODp9577eUGQfipLu9+GLVho5MYQSUMBsGFwD/gB+QGzeW6AGCSw5WM36S
	CKQCbR50dSbN8wkwjbsEgYR7+S5guWnEV4O3XKA4hUAD6lhTUbB35hxKQBOgK6oknYHcVICcLwy
	f2ATl8xgoGaYnkPP/YNexd73y5SutZbLk/Emi0VVrSTXhBqGYzCzy64gAmMm5TAknaWa/TimJ9j
	3pjF5JYjzsMZyMP5L7jMa6mVkQ4H96Qqf2JiI/ef7ZaWJyxGNS+gKC9tsBH5r/NyL8HrivYXHJj
	792O4/LGbqUjvBviTN3RhmhLMNHprXsMa1XRFJl/MmiylEVLMYnaDbD65xlaMc+Y9DCv/OtWEDK
	af5699MNWT22bBHX3k4gSYFjn3iL6
X-Received: by 2002:a05:6a20:6a21:b0:239:2bcd:a08c with SMTP id adf61e73a8af0-23d701706bbmr25088469637.28.1753768324816;
        Mon, 28 Jul 2025 22:52:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQj4fdxmWaDW8npfgoOtFvTYJr0VB0grceoYIItPUpeoINC3U7/BONysN899AfJbmXjtUumw==
X-Received: by 2002:a05:6a20:6a21:b0:239:2bcd:a08c with SMTP id adf61e73a8af0-23d701706bbmr25088421637.28.1753768324343;
        Mon, 28 Jul 2025 22:52:04 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f07a2f86esm2842883a91.2.2025.07.28.22.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 22:52:04 -0700 (PDT)
Message-ID: <a6456802-3d19-4da5-a995-c8f00553c7fa@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 13:51:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
 <20250729-hamoa_initial-v3-4-806e092789dc@oss.qualcomm.com>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <20250729-hamoa_initial-v3-4-806e092789dc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=68886186 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ozt4DjDmHokV6crStI8A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA0MSBTYWx0ZWRfX+cc8wTG6ejyO
 gitvZJ+0PqQZttWcTeRDYjO0gUK2qi9EOxaTzMYzNdGyA8xEUb5IyU6J1dtkTR3Wy6WLVRpfkkx
 QyvOGFLqxGpLNg3VpjNOheWSC5g9jJvZhzS4MFavLdk/MR8sYRc87+YSVBitTVbx1BX0ClvELlr
 w401HxivFXa4/mp7XQPECkp0SgkiwQCQ1rrUjC2sN180XuF1ysUAV7Z41+jOtZSJkIPNruSpx/l
 NauwNaj9qUjTLM20p5RSLXeBnpvlzLonu+Pu4e+BGGn0Ob+Nom5D5Ql9kk8Ihu7foTRTwXVvGUV
 ODUDMHbmh+GYZ/Z0YAoCCiFHfZEFJgT82fJkfDLUvCsV1eh1wyqdR2KeSUJ4a5OGJ71YE9a7NSO
 hoCI8lA3ilEbs28+zfv/duUQbV83d4lVxX2/0lzMkEPbKTKHJhRq7HUHVZUGHSptfN9lT/MH
X-Proofpoint-ORIG-GUID: 0idED6Se_BmC98a-fsUqh6qRsAV_-VmD
X-Proofpoint-GUID: 0idED6Se_BmC98a-fsUqh6qRsAV_-VmD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290041



On 2025-07-29 09:32, Yijie Yang wrote:
> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
> the Hamoa IoT SoM and a carrier board. Together, they form a complete
> embedded system capable of booting to UART.
> 
> This change enables and overlays the following peripherals on the carrier
> board:
> - UART
> - On-board regulators
> - USB Type-C mux
> - Pinctrl
> - Embedded USB (EUSB) repeaters
> - NVMe
> - pmic-glink
> - USB DisplayPorts
> 
> Written with contributions from Shuai Zhang (added Bluetooth) and Yongxing
> Mou (added USB DisplayPorts).
> 
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile          |   1 +
>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 992 +++++++++++++++++++++++++++++
>   2 files changed, 993 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 4bfa926b6a0850c3c459bcba28129c559d50a7cf..c5994b75d3e56e74ffb64b2389ee1bcc086f3065 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= hamoa-iot-evk.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-tplink-archer-ax55-v1.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp441.dtb
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..02daec04f933c0b3ab9bd329f56ac1ba0401ddef
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -0,0 +1,992 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/dts-v1/;
> +
> +#include "hamoa-iot-som.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. Hamoa IoT EVK";
> +	compatible = "qcom,hamoa-iot-evk", "qcom,hamoa-iot-som", "qcom,x1e80100";
> +	chassis-type = "embedded";
> +
> +	aliases {
> +		serial0 = &uart21;
> +		serial1 = &uart14;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	pmic-glink {
> +		compatible = "qcom,x1e80100-pmic-glink",
> +			     "qcom,sm8550-pmic-glink",
> +			     "qcom,pmic-glink";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		orientation-gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>,
> +				    <&tlmm 123 GPIO_ACTIVE_HIGH>,
> +				    <&tlmm 125 GPIO_ACTIVE_HIGH>;
> +
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_ss0_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_ss0_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss0_ss_in: endpoint {
> +						remote-endpoint = <&usb_1_ss0_qmpphy_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_ss0_sbu: endpoint {
> +						remote-endpoint = <&usb_1_ss0_sbu_mux>;
> +					};
> +				};
> +			};
> +		};
> +
> +		connector@1 {
> +			compatible = "usb-c-connector";
> +			reg = <1>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_ss1_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_ss1_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss1_ss_in: endpoint {
> +						remote-endpoint = <&retimer_ss1_ss_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_ss1_con_sbu_in: endpoint {
> +						remote-endpoint = <&retimer_ss1_con_sbu_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		connector@2 {
> +			compatible = "usb-c-connector";
> +			reg = <2>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_ss2_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_ss2_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss2_ss_in: endpoint {
> +						remote-endpoint = <&retimer_ss2_ss_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_ss2_con_sbu_in: endpoint {
> +						remote-endpoint = <&retimer_ss2_con_sbu_out>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	vph_pwr: regulator-vph-pwr {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vreg_edp_3p3: regulator-edp-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_EDP_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 70 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&edp_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vreg_nvme: regulator-nvme {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_NVME_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 18 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&nvme_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr0_1p15: regulator-rtmr0-1p15 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR0_1P15";
> +		regulator-min-microvolt = <1150000>;
> +		regulator-max-microvolt = <1150000>;
> +
> +		gpio = <&pmc8380_5_gpios 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb0_pwr_1p15_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr0_1p8: regulator-rtmr0-1p8 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR0_1P8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&pm8550ve_9_gpios 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb0_1p8_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr0_3p3: regulator-rtmr0-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR0_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pm8550_gpios 11 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb0_3p3_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr1_1p15: regulator-rtmr1-1p15 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR1_1P15";
> +		regulator-min-microvolt = <1150000>;
> +		regulator-max-microvolt = <1150000>;
> +
> +		gpio = <&tlmm 188 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb1_pwr_1p15_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr1_1p8: regulator-rtmr1-1p8 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR1_1P8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&tlmm 175 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb1_pwr_1p8_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr1_3p3: regulator-rtmr1-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR1_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 186 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb1_pwr_3p3_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr2_1p15: regulator-rtmr2-1p15 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR2_1P15";
> +		regulator-min-microvolt = <1150000>;
> +		regulator-max-microvolt = <1150000>;
> +
> +		gpio = <&tlmm 189 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb2_pwr_1p15_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr2_1p8: regulator-rtmr2-1p8 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR2_1P8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&tlmm 126 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb2_pwr_1p8_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr2_3p3: regulator-rtmr2-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR2_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 187 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb2_pwr_3p3_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	usb-1-ss0-sbu-mux {
> +		compatible = "onnn,fsusb42", "gpio-sbu-mux";
> +
> +		enable-gpios = <&tlmm 168 GPIO_ACTIVE_LOW>;
> +		select-gpios = <&tlmm 167 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-0 = <&usb_1_ss0_sbu_default>;
> +		pinctrl-names = "default";
> +
> +		mode-switch;
> +		orientation-switch;
> +
> +		port {
> +			usb_1_ss0_sbu_mux: endpoint {
> +				remote-endpoint = <&pmic_glink_ss0_sbu>;
> +			};
> +		};
> +	};
> +
> +	vreg_wcn_3p3: regulator-wcn-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_WCN_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 214 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&wcn_sw_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;

It should be set to 'regulator-always-on'.

> +	};
> +
> +	/*
> +	 * TODO: These two regulators are actually part of the removable M.2
> +	 * card and not the CRD mainboard. Need to describe this differently.
> +	 * Functionally it works correctly, because all we need to do is to
> +	 * turn on the actual 3.3V supply above.
> +	 */
> +	vreg_wcn_0p95: regulator-wcn-0p95 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_WCN_0P95";
> +		regulator-min-microvolt = <950000>;
> +		regulator-max-microvolt = <950000>;
> +
> +		vin-supply = <&vreg_wcn_3p3>;
> +	};
> +
> +	vreg_wcn_1p9: regulator-wcn-1p9 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_WCN_1P9";
> +		regulator-min-microvolt = <1900000>;
> +		regulator-max-microvolt = <1900000>;
> +
> +		vin-supply = <&vreg_wcn_3p3>;
> +	};
> +
> +	vreg_wwan: regulator-wwan {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "SDX_VPH_PWR";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 221 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&wwan_sw_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	wcn7850-pmu {
> +		compatible = "qcom,wcn7850-pmu";
> +
> +		vdd-supply = <&vreg_wcn_0p95>;
> +		vddio-supply = <&vreg_l15b_1p8>;
> +		vddaon-supply = <&vreg_wcn_0p95>;
> +		vdddig-supply = <&vreg_wcn_0p95>;
> +		vddrfa1p2-supply = <&vreg_wcn_1p9>;
> +		vddrfa1p8-supply = <&vreg_wcn_1p9>;
> +
> +		bt-enable-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-0 = <&wcn_bt_en>;
> +		pinctrl-names = "default";
> +
> +		regulators {
> +			vreg_pmu_rfa_cmn: ldo0 {
> +				regulator-name = "vreg_pmu_rfa_cmn";
> +			};
> +
> +			vreg_pmu_aon_0p59: ldo1 {
> +				regulator-name = "vreg_pmu_aon_0p59";
> +			};
> +
> +			vreg_pmu_wlcx_0p8: ldo2 {
> +				regulator-name = "vreg_pmu_wlcx_0p8";
> +			};
> +
> +			vreg_pmu_wlmx_0p85: ldo3 {
> +				regulator-name = "vreg_pmu_wlmx_0p85";
> +			};
> +
> +			vreg_pmu_btcmx_0p85: ldo4 {
> +				regulator-name = "vreg_pmu_btcmx_0p85";
> +			};
> +
> +			vreg_pmu_rfa_0p8: ldo5 {
> +				regulator-name = "vreg_pmu_rfa_0p8";
> +			};
> +
> +			vreg_pmu_rfa_1p2: ldo6 {
> +				regulator-name = "vreg_pmu_rfa_1p2";
> +			};
> +
> +			vreg_pmu_rfa_1p8: ldo7 {
> +				regulator-name = "vreg_pmu_rfa_1p8";
> +			};
> +
> +			vreg_pmu_pcie_0p9: ldo8 {
> +				regulator-name = "vreg_pmu_pcie_0p9";
> +			};
> +
> +			vreg_pmu_pcie_1p8: ldo9 {
> +				regulator-name = "vreg_pmu_pcie_1p8";
> +			};
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	typec-mux@8 {
> +		compatible = "parade,ps8830";
> +		reg = <0x08>;
> +
> +		clocks = <&rpmhcc RPMH_RF_CLK5>;
> +
> +		vdd-supply = <&vreg_rtmr2_1p15>;
> +		vdd33-supply = <&vreg_rtmr2_3p3>;
> +		vdd33-cap-supply = <&vreg_rtmr2_3p3>;
> +		vddar-supply = <&vreg_rtmr2_1p15>;
> +		vddat-supply = <&vreg_rtmr2_1p15>;
> +		vddio-supply = <&vreg_rtmr2_1p8>;
> +
> +		reset-gpios = <&tlmm 185 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-0 = <&rtmr2_default>;
> +		pinctrl-names = "default";
> +
> +		orientation-switch;
> +		retimer-switch;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				retimer_ss2_ss_out: endpoint {
> +					remote-endpoint = <&pmic_glink_ss2_ss_in>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				retimer_ss2_ss_in: endpoint {
> +					remote-endpoint = <&usb_1_ss2_qmpphy_out>;
> +				};
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +
> +				retimer_ss2_con_sbu_out: endpoint {
> +					remote-endpoint = <&pmic_glink_ss2_con_sbu_in>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c5 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	eusb3_repeater: redriver@47 {
> +		compatible = "nxp,ptn3222";
> +		reg = <0x47>;
> +		#phy-cells = <0>;
> +
> +		vdd3v3-supply = <&vreg_l13b_3p0>;
> +		vdd1v8-supply = <&vreg_l4b_1p8>;
> +
> +		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-0 = <&eusb3_reset_n>;
> +		pinctrl-names = "default";
> +	};
> +
> +	eusb5_repeater: redriver@43 {
> +		compatible = "nxp,ptn3222";
> +		reg = <0x43>;
> +		#phy-cells = <0>;
> +
> +		vdd3v3-supply = <&vreg_l13b_3p0>;
> +		vdd1v8-supply = <&vreg_l4b_1p8>;
> +
> +		reset-gpios = <&tlmm 7 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-0 = <&eusb5_reset_n>;
> +		pinctrl-names = "default";
> +	};
> +
> +	eusb6_repeater: redriver@4f {
> +		compatible = "nxp,ptn3222";
> +		reg = <0x4f>;
> +		#phy-cells = <0>;
> +
> +		vdd3v3-supply = <&vreg_l13b_3p0>;
> +		vdd1v8-supply = <&vreg_l4b_1p8>;
> +
> +		reset-gpios = <&tlmm 184 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-0 = <&eusb6_reset_n>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
> +&i2c7 {
> +	clock-frequency = <400000>;
> +
> +	status = "okay";
> +
> +	typec-mux@8 {
> +		compatible = "parade,ps8830";
> +		reg = <0x8>;
> +
> +		clocks = <&rpmhcc RPMH_RF_CLK4>;
> +
> +		vdd-supply = <&vreg_rtmr1_1p15>;
> +		vdd33-supply = <&vreg_rtmr1_3p3>;
> +		vdd33-cap-supply = <&vreg_rtmr1_3p3>;
> +		vddar-supply = <&vreg_rtmr1_1p15>;
> +		vddat-supply = <&vreg_rtmr1_1p15>;
> +		vddio-supply = <&vreg_rtmr1_1p8>;
> +
> +		reset-gpios = <&tlmm 176 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-0 = <&rtmr1_default>;
> +		pinctrl-names = "default";
> +
> +		retimer-switch;
> +		orientation-switch;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				retimer_ss1_ss_out: endpoint {
> +					remote-endpoint = <&pmic_glink_ss1_ss_in>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				retimer_ss1_ss_in: endpoint {
> +					remote-endpoint = <&usb_1_ss1_qmpphy_out>;
> +				};
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +
> +				retimer_ss1_con_sbu_out: endpoint {
> +					remote-endpoint = <&pmic_glink_ss1_con_sbu_in>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dp0 {
> +	status = "okay";
> +};
> +
> +&mdss_dp0_out {
> +	data-lanes = <0 1>;
> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +};
> +
> +&mdss_dp1 {
> +	status = "okay";
> +};
> +
> +&mdss_dp1_out {
> +	data-lanes = <0 1>;
> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +};
> +
> +&mdss_dp2 {
> +	status = "okay";
> +};
> +
> +&mdss_dp2_out {
> +	data-lanes = <0 1>;
> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +};
> +
> +&mdss_dp3 {
> +	/delete-property/ #sound-dai-cells;
> +
> +	status = "okay";
> +
> +	aux-bus {
> +		panel {
> +			compatible = "edp-panel";
> +			power-supply = <&vreg_edp_3p3>;
> +
> +			port {
> +				edp_panel_in: endpoint {
> +					remote-endpoint = <&mdss_dp3_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +
> +			mdss_dp3_out: endpoint {
> +				data-lanes = <0 1 2 3>;
> +				link-frequencies = /bits/ 64 <1620000000 2700000000
> +							      5400000000 8100000000>;
> +
> +				remote-endpoint = <&edp_panel_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss_dp3_phy {
> +	vdda-phy-supply = <&vreg_l3j_0p8>;
> +	vdda-pll-supply = <&vreg_l2j_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&pcie6a {
> +	vddpe-3v3-supply = <&vreg_nvme>;
> +};
> +
> +&pm8550_gpios {
> +	rtmr0_default: rtmr0-reset-n-active-state {
> +		pins = "gpio10";
> +		function = "normal";
> +		power-source = <1>; /* 1.8V */
> +		bias-disable;
> +		input-disable;
> +		output-enable;
> +	};
> +
> +	usb0_3p3_reg_en: usb0-3p3-reg-en-state {
> +		pins = "gpio11";
> +		function = "normal";
> +		power-source = <1>; /* 1.8V */
> +		bias-disable;
> +		input-disable;
> +		output-enable;
> +	};
> +};
> +
> +&pm8550ve_9_gpios {
> +	usb0_1p8_reg_en: usb0-1p8-reg-en-state {
> +		pins = "gpio8";
> +		function = "normal";
> +		power-source = <1>; /* 1.8V */
> +		bias-disable;
> +		input-disable;
> +		output-enable;
> +	};
> +};
> +
> +&pmc8380_5_gpios {
> +	usb0_pwr_1p15_reg_en: usb0-pwr-1p15-reg-en-state {
> +		pins = "gpio8";
> +		function = "normal";
> +		power-source = <1>; /* 1.8V */
> +		bias-disable;
> +		input-disable;
> +		output-enable;
> +	};
> +};
> +
> +&smb2360_0 {
> +	status = "okay";
> +};
> +
> +&smb2360_0_eusb2_repeater {
> +	vdd18-supply = <&vreg_l3d_1p8>;
> +	vdd3-supply = <&vreg_l2b_3p0>;
> +};
> +
> +&smb2360_1 {
> +	status = "okay";
> +};
> +
> +&smb2360_1_eusb2_repeater {
> +	vdd18-supply = <&vreg_l3d_1p8>;
> +	vdd3-supply = <&vreg_l14b_3p0>;
> +};
> +
> +&smb2360_2 {
> +	status = "okay";
> +};
> +
> +&smb2360_2_eusb2_repeater {
> +	vdd18-supply = <&vreg_l3d_1p8>;
> +	vdd3-supply = <&vreg_l8b_3p0>;
> +};
> +
> +&tlmm {
> +	edp_reg_en: edp-reg-en-state {
> +		pins = "gpio70";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	eusb3_reset_n: eusb3-reset-n-state {
> +		pins = "gpio6";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;
> +	};
> +
> +	eusb5_reset_n: eusb5-reset-n-state {
> +		pins = "gpio7";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +		output-low;
> +	};
> +
> +	eusb6_reset_n: eusb6-reset-n-state {
> +		pins = "gpio184";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +		output-low;
> +	};
> +
> +	nvme_reg_en: nvme-reg-en-state {
> +		pins = "gpio18";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	rtmr1_default: rtmr1-reset-n-active-state {
> +		pins = "gpio176";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	rtmr2_default: rtmr2-reset-n-active-state {
> +		pins = "gpio185";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	usb1_pwr_1p15_reg_en: usb1-pwr-1p15-reg-en-state {
> +		pins = "gpio188";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	usb1_pwr_1p8_reg_en: usb1-pwr-1p8-reg-en-state {
> +		pins = "gpio175";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	usb1_pwr_3p3_reg_en: usb1-pwr-3p3-reg-en-state {
> +		pins = "gpio186";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	usb2_pwr_1p15_reg_en: usb2-pwr-1p15-reg-en-state {
> +		pins = "gpio189";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	usb2_pwr_1p8_reg_en: usb2-pwr-1p8-reg-en-state {
> +		pins = "gpio126";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	usb2_pwr_3p3_reg_en: usb2-pwr-3p3-reg-en-state {
> +		pins = "gpio187";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	usb_1_ss0_sbu_default: usb-1-ss0-sbu-state {
> +		mode-pins {
> +			pins = "gpio166";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strength = <2>;
> +			output-high;
> +		};
> +
> +		oe-n-pins {
> +			pins = "gpio168";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strength = <2>;
> +		};
> +
> +		sel-pins {
> +			pins = "gpio167";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strength = <2>;
> +		};
> +	};
> +
> +	wcn_bt_en: wcn-bt-en-state {
> +		pins = "gpio116";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	wwan_sw_en: wwan-sw-en-state {
> +		pins = "gpio221";
> +		function = "gpio";
> +		drive-strength = <4>;
> +		bias-disable;
> +	};
> +
> +	wcn_sw_en: wcn-sw-en-state {
> +		pins = "gpio214";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	wcn_usb_sw_n: wcn-usb-sw-n-state {
> +		pins = "gpio225";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-high;
> +	};
> +};
> +
> +&uart14 {
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "qcom,wcn7850-bt";
> +		max-speed = <3200000>;
> +
> +		vddaon-supply = <&vreg_pmu_aon_0p59>;
> +		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> +		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> +		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> +		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> +		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> +		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
> +	};
> +};
> +
> +&uart21 {
> +	compatible = "qcom,geni-debug-uart";
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss0_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_ss0_hs_in>;
> +};
> +
> +&usb_1_ss0_hsphy {
> +	phys = <&smb2360_0_eusb2_repeater>;
> +};
> +
> +&usb_1_ss0_qmpphy_out {
> +	remote-endpoint = <&pmic_glink_ss0_ss_in>;
> +};
> +
> +&usb_1_ss1_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_ss1_hs_in>;
> +};
> +
> +&usb_1_ss1_hsphy {
> +	phys = <&smb2360_1_eusb2_repeater>;
> +};
> +
> +&usb_1_ss1_qmpphy_out {
> +	remote-endpoint = <&retimer_ss1_ss_in>;
> +};
> +
> +&usb_1_ss2_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_ss2_hs_in>;
> +};
> +
> +&usb_1_ss2_hsphy {
> +	phys = <&smb2360_2_eusb2_repeater>;
> +};
> +
> +&usb_1_ss2_qmpphy_out {
> +	remote-endpoint = <&retimer_ss2_ss_in>;
> +};
> +
> +&usb_2_hsphy {
> +	phys = <&eusb5_repeater>;
> +
> +	pinctrl-0 = <&wcn_usb_sw_n>;
> +	pinctrl-names = "default";
> +};
> +
> +&usb_mp_hsphy0 {
> +	phys = <&eusb6_repeater>;
> +};
> +
> +&usb_mp_hsphy1 {
> +	phys = <&eusb3_repeater>;
> +};
> 

-- 
Best Regards,
Yijie


