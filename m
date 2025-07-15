Return-Path: <linux-kernel+bounces-731795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B98B059A2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2981A67AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2982DCF5D;
	Tue, 15 Jul 2025 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5E23Pc1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F1533D6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581518; cv=none; b=N30x8el5I0LTNkaPpwv7HeRW4KKM9geBE8duplUXtajSr7VuJa4d8IJGCFumt28YKhTcOr0PP3MGDzg3nZFYzTox4IXQGBi700mMwZfntLpxU7mIY0MqBBgbJnS3y+KhSTQUAYcnncfGM4nxeAiYw4I/pCPGBrOClgri2gqST7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581518; c=relaxed/simple;
	bh=8A3Z06bzdJ1QUZSUox017B2z1rKnOf9ByaOXjY061V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCnOE6LQc0zGX5x5JwYrzDF1qEjJOt6nrCo3vCbiH0MMSYPlnopuTxElIYqHR5MZ7oSSaOPAo2qFdQazzmfqiKdUu21kE//im4v+we1tlXcLBnUJl6x+SDHGgl/XtXlxy27dQ29XvlTKUpFyP0XPNX0nlws9zF2jpsYcug2qi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B5E23Pc1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FBJT7e005134
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NIGACv/TQ7bqRyy/PxlnetvI
	UcYh9t4jJhtdvHTuDJE=; b=B5E23Pc1HCFS3LLj6OvBQSBZUOR4c6EY32SQlq3j
	MfFZd2iPNzvNtr5UWDWfDwIkHh2R+GjaWOa7Ht05lGxT26d8ATyYVP5kauOEajiC
	IuNOlHzt0uysHQYxLSKRFpfoaDYuSjL4BAV23GqruAUsQEATDdgOjFRPlyYGAj8e
	en2yTB2i0T0e/nuTG0ZnnX/+kyO4OnrNYLb+TctSXdG6MzWDHYECxI/XCQCnJCup
	81Iw0sVu0DX7pvCSVIp+p5HskR0kLIbS3lNjee7PguS7jZUGG0Rm7DgM5dB8Y/mf
	M5c54JeRLifbZimgU2nsKaM3XsM2j/GOHx4bUXtvqLQEkA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca1d33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:11:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c790dc38b4so871701885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752581515; x=1753186315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIGACv/TQ7bqRyy/PxlnetvIUcYh9t4jJhtdvHTuDJE=;
        b=Nw7+gCrlqncy1Whs7r28ZZ4jXrmZAoGCvtjPydgDGDrW9ynYYLYuTl7PuIEKlxnxP0
         gWal6fWbapjQ/X5OlK08eFf8Ps6UoUourRHKnRScZZxnTtU7ykj02uTrXb66vsd8QTd/
         gtRzS41TUzOWjunCY8BKhVDtef0rqnPwBe9i7ziVrFzS6XvOFAGsRVFYv/p/8EBlVI+T
         Ty1fTYeJU/Er21genT5nRSgIZWqpIdrHAJebJUSmTJOqpT2TNayG22dusLHDyllNzqXg
         Uhmr/ok0ZuMSa/vgDZAdKV4n9O77mE7VAr4rF83WXod+LOIiNgsD0bnZ/DdA6+yWahfK
         r6TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxsaFWcBHf81EyuMeFtuR/o/E3tbFwpbXMx8R19ct4J2GhRYUfLjC+eTnE/xc3XVzQtKoR83FEhRJsErU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycoRvypN6FOKFQS1qtM6wiePOqI2runY9lXu2Fxm++zv6EzRmr
	Zy4F8OY0fbK4Klywu160OibigVbQKcRXqfVy5xK1d0/Aih0011vx0BzWDtfpbj2qBNKav0ue8Rf
	AKypOJnuyIY+OB3WNj0N2l3MhRr9eRk0IXkgL4Z3BtTkyXRCbqKdKvvJScEz6eNfh53s=
X-Gm-Gg: ASbGncuVr6VVGfeXxauo7YMCLc/xJEPJhxm0aeHqh8EAamhwDA2NBY7YqExPcp3xqyg
	p6rX7ICzThNilgm1QBuggMsz3ltCLK264eDeTFS2jrm8GGDRraK3IhqUuFYA7V9Z86SELgWYD/c
	66BT1+BZB4xVZ+utEZkVGyVMnz2DR6cr4YopTxymxFX6Jqtb37n7L5o2gdvISUDzZJyG0uKhuDP
	AHXJjTgSHW/LJdYwahC7hf2mq+x1giFKHfAzHfoJNfScq7cigAEcCJPNR8zW2cinxmqO6L1JvDU
	REpeVfA1i0CGKk38Uj1yrBPkJ46pkGuWxvLRSxBcdvsFSPdkpo/oKDDRYQ+NHSOX71KnQsCcShG
	PJ0Ku6hDxi+/aoRzKWeo764X9st6H+9TzkuMd0zpeYuygpTziRT4n
X-Received: by 2002:a05:620a:4e9a:b0:7d3:a4fa:ee06 with SMTP id af79cd13be357-7e337b853a9mr367285685a.29.1752581514276;
        Tue, 15 Jul 2025 05:11:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmF+y4l+jOb95aKZxJ7DfbPfnTn84DO87g2W9GzSKv0rFVZnPjZcECn3fW8CZwMFIojixCWQ==
X-Received: by 2002:a05:620a:4e9a:b0:7d3:a4fa:ee06 with SMTP id af79cd13be357-7e337b853a9mr367279885a.29.1752581513627;
        Tue, 15 Jul 2025 05:11:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b736d5sm2263762e87.213.2025.07.15.05.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 05:11:52 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:11:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Yubing Zhang <yubing.zhang@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Amit Sunil Dhamne <amitsd@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaoyi Chen <chaoyi.chen@rock-chips.com>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 5/5] arm64: dts: rockchip: rk3399-evb-ind: Add support
 for DisplayPort
Message-ID: <2bfaqx6unfejlqg53jaw47s6qzymdcvyiy6wuqgua43mnitzbt@5wfqp6ucxcsx>
References: <20250715112456.101-1-kernel@airkyi.com>
 <20250715112456.101-6-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715112456.101-6-kernel@airkyi.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExMSBTYWx0ZWRfX9VIbPzGMmv9d
 2tHT+4m7zz+Ez1CJxQA3BiSqNs2KifZ4Xhm9LZ1/hSj8C5qZ/UtsNbYHv/l9XKrmyTW4w7HJQdv
 G0MegOUT1bBOCZYhOh9gITXox936O3oDTRHipgY7hqRqZuvXZR/Lu5jCrITBX9SZc2vkMx8UNvV
 4sR8/5wdkkuEDym22eSBmJZFl9mblrS6snCL4T1NGlfjhHANgg0423aMD2JXgqLmBSYLEP3O7m0
 s/w3T1Pt25254gzGZgS3qXxq+1JDp9IER2e/qh9I6cX0WnYJpvrfScJRb0rp9PplpxOd2nqbWJI
 4knAYkZzXApd8t3TeAWudur1qO/5AAS27XYX+rqIz7h4vuX0HMrsRYOPLez5QGVBVH1B3VRocDz
 qd2RRSmb1XuHeIrbbwPuhVX88RisZVZy4NloIKj+C+MisQaIFcnSiFerTWkO6ruOjZgWv5nd
X-Proofpoint-GUID: EgswK6fyRREJZruhzGtKD0r5HJ0oSPS9
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=6876458b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=ikJCsuYIIW8Wf-eC7T4A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: EgswK6fyRREJZruhzGtKD0r5HJ0oSPS9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150111

On Tue, Jul 15, 2025 at 07:24:56PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The RK3399 EVB IND board has a Type-C interface DisplayPort.
> It use fusb302 chip as Type-C controller.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>  .../boot/dts/rockchip/rk3399-evb-ind.dts      | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts
> index 70aee1ab904c..9ceda32456a0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts
> @@ -4,6 +4,7 @@
>   */
>  
>  /dts-v1/;
> +#include <dt-bindings/usb/pd.h>
>  #include "rk3399.dtsi"
>  
>  / {
> @@ -19,6 +20,16 @@ chosen {
>  		stdout-path = "serial2:1500000n8";
>  	};
>  
> +	vbus_typec: vbus-typec-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_typec0_en>;
> +		regulator-name = "vbus_typec";
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
>  	vcc5v0_sys: regulator-vcc5v0-sys {
>  		compatible = "regulator-fixed";
>  		enable-active-high;
> @@ -29,6 +40,16 @@ vcc5v0_sys: regulator-vcc5v0-sys {
>  		regulator-max-microvolt = <5000000>;
>  		regulator-min-microvolt = <5000000>;
>  	};
> +
> +	sound: sound {
> +		compatible = "rockchip,rk3399-gru-sound";
> +		rockchip,cpu = <&i2s0 &spdif>;
> +	};
> +};
> +
> +&cdn_dp {
> +	status = "okay";
> +	phys = <&tcphy0_dp>;
>  };
>  
>  &cpu_b0 {
> @@ -341,6 +362,66 @@ regulator-state-mem {
>  	};
>  };
>  
> +&i2c4 {
> +	i2c-scl-rising-time-ns = <475>;
> +	i2c-scl-falling-time-ns = <26>;
> +	status = "okay";
> +
> +	usbc0: fusb302@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbc0_int>;
> +		vbus-supply = <&vbus_typec>;
> +		status = "okay";
> +
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			data-role = "dual";
> +			power-role = "dual";
> +			try-power-role = "sink";
> +			op-sink-microwatt = <1000000>;
> +			sink-pdos =
> +				<PDO_FIXED(5000, 2500, PDO_FIXED_USB_COMM)>;
> +			source-pdos =
> +				<PDO_FIXED(5000, 1500, PDO_FIXED_USB_COMM)>;
> +
> +			displayport = <&cdn_dp>;
> +
> +			altmodes {
> +				displayport {
> +					svid = /bits/ 16 <0xff01>;
> +					vdo = <0xffffffff>;
> +				};
> +			};
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {

Which signals are described by these ports? port@0 should be used for
USB HS lines.

> +					reg = <0>;
> +
> +					usbc0_orien_sw: endpoint {
> +						remote-endpoint = <&tcphy0_orientation_switch>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					dp_mode_sw: endpoint {
> +						remote-endpoint = <&tcphy_dp_altmode_switch>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
>  &i2s2 {
>  	status = "okay";
>  };
> @@ -354,6 +435,16 @@ &io_domains {
>  };
>  
>  &pinctrl {
> +	usb-typec {
> +		usbc0_int: usbc0-int {
> +			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		vcc5v0_typec0_en: vcc5v0-typec0-en {
> +			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
>  	pmic {
>  		pmic_int_l: pmic-int-l {
>  			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> @@ -400,8 +491,35 @@ &sdmmc {
>  	status = "okay";
>  };
>  
> +&sound {
> +	rockchip,codec = <&cdn_dp>;
> +	status = "okay";
> +};
> +
> +&spdif {
> +	status = "okay";
> +};
> +
>  &tcphy0 {
> +	mode-switch;
> +	orientation-switch;
>  	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		tcphy0_orientation_switch: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&usbc0_orien_sw>;
> +		};
> +
> +		tcphy_dp_altmode_switch: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&dp_mode_sw>;
> +		};
> +	};
> +
>  };
>  
>  &tcphy1 {
> @@ -461,6 +579,7 @@ &usb_host1_ohci {
>  };
>  
>  &usbdrd_dwc3_0 {
> +	usb-role-switch;
>  	status = "okay";
>  };
>  
> -- 
> 2.49.0
> 

-- 
With best wishes
Dmitry

