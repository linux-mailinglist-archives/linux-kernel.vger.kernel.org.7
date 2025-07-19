Return-Path: <linux-kernel+bounces-737688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBF8B0AF65
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849071AA4F6C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECD52116E0;
	Sat, 19 Jul 2025 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hsd8+FBb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC61E47B3
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752922256; cv=none; b=tsJcez7QX+yVwF8DihDgecei5cXu3eGGv1CJUoDgpleG26IPdEG4dXg0KuivPGv68s/rHNE3Awgx343Q/2bNIPcJtlkG6Mq6oU7QosJVrgRR9o6rrVZZ786abT8T+c1cCiHTB8VbkkBbatGTz+XNlPJNyHgbqSuMt+BnzdKYOzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752922256; c=relaxed/simple;
	bh=3nDMgq++85b2HkdS2v588umIwlgG3C8XygjJWNrepKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oO1Ls4KK8LoTuuXosCCIUrvmLWJoWvd9xxVaiPVavK5M0V2RiaLGkqq83gLQlVohj5qqSQewSw8ZbXg3f+2kOSP0D9PxevsvZCcqhA1NPQBI2y1kftHL7spfYkOlv//YhP4hCvllBvDsgI13AggN6K+F3Yhj5ktsRmbqPottQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hsd8+FBb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J4LSRn027225
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8bWRC+nyUTbnELtrQkJApxVg
	RlBOEUvNmWuQElnY2wg=; b=hsd8+FBb47O/w+UmniIXkxeCpDvF7pKn7BFkHm0L
	jSVY0uFMYAc9Xe/AAubuo3x0atiOU+pLs8QeEiZGzvEXwsIQW9M5EzcKnIaB4z4o
	1HsAr+yidzY+1GC1JLLzuCnzHHsom3mjKXg0qNbpkJlKUH3m00jcqJC6ZxkB07/h
	rHjwaeWUnyIGfYrpGucBQue26DNN2osr01O7Juwq44hcqphZoqTR5Z38D8PlsMsz
	TPxIA4MmGX/xg8sr40c3K72dOxJ6F53bdUxnp1zv0drjwrIy5guTYqdHp3xxm3NE
	lWvWWkqx6cpbR3r1bdRMD8NXV+dHHvmtjLdJ3mWu+pjjjA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048rrh38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:50:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab401e333bso70504061cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752922252; x=1753527052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bWRC+nyUTbnELtrQkJApxVgRlBOEUvNmWuQElnY2wg=;
        b=HVFuI2QSDvCXVOxymX2dUQ/aR+eqvUYgZDI9EdB2FQnUwXTJJarcgru2WapyZDuzum
         oaDCaX27oXiZaVQKRY0LgYDhQx1gX6XTgoYkeqc04JSeoutGS4qSM3Kz/ws1yf/s3sw2
         5nIZp2E3PyVSuo6kl68TJDSUn3xRthMD5SjuA0ISjBJMtvCfl8fxcC888L+9+k5AACzK
         yTPcao8uZsgnMkRBkBcY8K8e92nAdLSAoHBtaxEFZpd7w0DZzGdDY/ULBDqhbQUQj9zU
         8fawxMwJUPUFLJZK3Bz5tpAJGSY95dka0cNPophBQO2NU9idIxFwh2G9NX5N7OgjHb+z
         c2oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVgkpwBkKX37qZTCOE8xvWfBN+VzjwCFagjWPFr4OMADGUF55c7ugjUXqbelL0AUajcdgltSYb7snn37o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGGPArC1BG4KpuJKDM279rgeAgJOH+2+wPyB679oi2JytYJZOR
	Kqew/rE1R+hS1gWaY26b1sGlBc0VkN1dTLKlyI8b9PJ4MKvPoeS3nBcx6W4n/2ucB9NU7PCU89z
	MYOtZZ6tXviwvW2fYhCCT+eCTLJstvbIT/zMPi/rDc2xK/Bd715BGP8GmjqTMyJUe1Qs=
X-Gm-Gg: ASbGncs7FqGjPabyayIwVE+Do0k2fW4wYcgEDEkW9amtWHuPusqAa8kFxFZkRXDkVfB
	uYNcW/vAzFP4Y8N+itaiJcby1nH8hRN7gjIcyjrDuAphfOC93RSfa/tsyKJMx73kBcOmQqwBJbo
	kYnFTI4xgchP1mcNHentndN8SyZY/2R2F4IfbPGc7pdVBA3I7pu5hU0fp5Q/BAuTFyGhW/XgTY+
	uQ3+U/viJlEKe05mea0WUyRt/X1ExlGQWsvCkPUmi7m6vPqFuSOh7Y8cOetyXJSsXjhwTLnGIh3
	Qr0jaAFxSeeEkk/uEqQE8ZlS+cq00wERZVaEIO1FGZE83J1B70rD1Jd5QjVF768nhBAXuMkYHXr
	4FMN2K6QxwyZTpUCOhR2o1iWB3/y3WgJSfyosDzX1VO611+NQ22SO
X-Received: by 2002:a05:622a:4898:b0:4ab:622b:fffb with SMTP id d75a77b69052e-4abb078731emr123876241cf.5.1752922251461;
        Sat, 19 Jul 2025 03:50:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELvC0t2DoePnMMUcCjwnNp/NwYyNzJMw/LSjDMY6XQx3gX8ifMzX4kwnCHJthxZrRbYsOq9A==
X-Received: by 2002:a05:622a:4898:b0:4ab:622b:fffb with SMTP id d75a77b69052e-4abb078731emr123875991cf.5.1752922250968;
        Sat, 19 Jul 2025 03:50:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d9122fsm667474e87.152.2025.07.19.03.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 03:50:50 -0700 (PDT)
Date: Sat, 19 Jul 2025 13:50:48 +0300
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
Subject: Re: [PATCH v2 5/5] arm64: dts: rockchip: rk3399-evb-ind: Add support
 for DisplayPort
Message-ID: <skvceiwrg77ysx74bmywp6buk6yp6dlllrwpkfea4brposrveh@2rqtawpiaikk>
References: <20250718062619.99-1-kernel@airkyi.com>
 <20250718062619.99-6-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718062619.99-6-kernel@airkyi.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDEwNyBTYWx0ZWRfX6uoHzLfC9l/6
 OdHWXoyw5VSmRQny7PKXrljCK29X0FKvABW29pXjx5o2Px+NtA3zQRku31wYeIBNimQBujOLlHu
 cKG1rVC8BwF+ZpiP7u376aEO3nCRRJ00JSrTEJ+3ajX42aoOav8n9b4qrisRsXEt8axkbHguje4
 ZBq0DSI7LKz/EyVePqtZfwFeSDpifg3RQcBhVmD6MvpbJp1S+mwCxSz856rXSvMXvhSmfT3p0ok
 vedd1VNJK8JKVCTp8fBauRRIfA+FFn6E6nx9nSGlwI+saPHqFgboK7Os7ZhIeiJ71wq6i2FlJaq
 Rctf2k3rXshIeIZnpjp21fV1PT5lGa/Zwf5qyBhyIJrhbVL1b0zDtDHKs167YlpoGwopuTBK2cR
 kR1e3rNZaiRU10pQl3YK/lXCRMJMmrg3x34gUpZXDIISGmqXzaMcR9Lsf2dFqoVFJfFWsgpL
X-Proofpoint-ORIG-GUID: 9WkPg5nsW9jnLDUeaNkm5U5ZKegSAQhx
X-Proofpoint-GUID: 9WkPg5nsW9jnLDUeaNkm5U5ZKegSAQhx
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687b788c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=ikJCsuYIIW8Wf-eC7T4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507190107

On Fri, Jul 18, 2025 at 02:26:19PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The RK3399 EVB IND board has a Type-C interface DisplayPort.
> It use fusb302 chip as Type-C controller.
> 
> fusb302 chip ---> USB/DP PHY0 <----> CDN-DP controller
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
> 
> Changes in v2:
> - Add endpoint to link DP PHY and DP controller.
> - Fix devicetree coding style.
> 
>  .../boot/dts/rockchip/rk3399-evb-ind.dts      | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts
> index 70aee1ab904c..997b822a57ff 100644
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
> @@ -19,6 +20,21 @@ chosen {
>  		stdout-path = "serial2:1500000n8";
>  	};
>  
> +	sound: sound {
> +		compatible = "rockchip,rk3399-gru-sound";
> +		rockchip,cpu = <&i2s0 &spdif>;
> +	};
> +
> +	vbus_typec: regulator-vbus-typec {
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
> @@ -31,6 +47,11 @@ vcc5v0_sys: regulator-vcc5v0-sys {
>  	};
>  };
>  
> +&cdn_dp {
> +	phys = <&tcphy0_dp>;
> +	status = "okay";
> +};
> +
>  &cpu_b0 {
>  	cpu-supply = <&vdd_cpu_b>;
>  };
> @@ -55,6 +76,12 @@ &cpu_l3 {
>  	cpu-supply = <&vdd_cpu_l>;
>  };
>  
> +&dp_out {
> +	dp_controller_output: endpoint {
> +		remote-endpoint = <&dp_phy_in>;
> +	};
> +};
> +
>  &emmc_phy {
>  	status = "okay";
>  };
> @@ -341,6 +368,63 @@ regulator-state-mem {
>  	};
>  };
>  
> +&i2c4 {
> +	i2c-scl-rising-time-ns = <475>;
> +	i2c-scl-falling-time-ns = <26>;
> +	status = "okay";
> +
> +	usbc0: typec-portc@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbc0_int>;
> +		vbus-supply = <&vbus_typec>;
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
> +			altmodes {
> +				displayport {
> +					svid = /bits/ 16 <0xff01>;
> +					vdo = <0xffffffff>;

I don't think that this VDO is correct. Please adjust it according to
the spec.

> +				};
> +			};
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
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
> @@ -354,6 +438,16 @@ &io_domains {
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
> @@ -400,10 +494,48 @@ &sdmmc {
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
>  	status = "okay";
>  };
>  
> +&tcphy0_dp {
> +	mode-switch;

But not an orientation-switch? Shouldn't it also note the SBU pins
orientation? Or DP lanes orientation?

> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		tcphy_dp_altmode_switch: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&dp_mode_sw>;
> +		};
> +
> +		dp_phy_in: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&dp_controller_output>;
> +		};
> +	};
> +};
> +
> +&tcphy0_usb3 {
> +	orientation-switch;


Hmmm.

> +
> +	port {
> +		tcphy0_orientation_switch: endpoint {
> +			remote-endpoint = <&usbc0_orien_sw>;
> +		};
> +	};
> +};
> +
>  &tcphy1 {
>  	status = "okay";
>  };
> @@ -461,6 +593,7 @@ &usb_host1_ohci {
>  };
>  
>  &usbdrd_dwc3_0 {
> +	usb-role-switch;

This is an SoC-level property.

>  	status = "okay";
>  };
>  
> -- 
> 2.49.0
> 
> 

-- 
With best wishes
Dmitry

