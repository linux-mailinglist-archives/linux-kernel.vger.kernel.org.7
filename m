Return-Path: <linux-kernel+bounces-824738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEDBB8A0CA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE090583C38
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92813313298;
	Fri, 19 Sep 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2c2P1XX"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713E22A4D8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293011; cv=none; b=idqhyaw2a9GCBPlDcRiCFZeJGrp3bhhXE+5hdl0ZSCiZkONVeVaW92r59vPICzkw/PlbIKPi0R81k4ql/S99nOririJIKKaEvUZtCBVNR7uqaE2J3ivGVzWkVOnU5P8EnGBSvE1T5qAZHS+WeoUA9H7KpnPVg/lo9ZEU2qXLmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293011; c=relaxed/simple;
	bh=SH7yxLu4/6TLsOZ88TaRyqPYYv3Btz3WCab4neycCqo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mIk1Ji7vh0NgsJeJikDYJMlUnBEoAfoZwwP5AFpMNcvmNrjy1fRFxBPoUJ7u3sAxoCysoT3CFxqH7Tn+W0QEXNe8f73Wgbve/S2GVgU896oSaHJHCtNacirLNXe/23TwuA9eIUhvJ/2jd3MPDPEHF7YSqwysGiOF6/UOc2KoOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q2c2P1XX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so17066405e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758293008; x=1758897808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWUtL1UQ6+yUSLVklwzlRQU7PKxN439/50grQVTKRY0=;
        b=q2c2P1XX2DGyCS8vDQ2lvN7Mz+mseGcX666UNnmmxMO7j1xv4LcS1RUhgZNgBf5vl9
         YA48HNAUcBMXL+yD2LuIxrzw/N62BxwrTmupl91Vp8q6hHNzqP/gUeT2TY/7Q98zycIh
         Vc/aswOJrMNq1cRKY4HlYkMQ9XYJnPU9eAeVBEFeSP7QsgwMOJ3FLehq3h9istTHpARi
         GgI3sS63ggISKpkfn4X0h4RUQIAXm4bhTWkzrClinscB3K+Ik+Y9p/OFjL8RdnIqkcbs
         HoZ5vaZXsB7OP9CViV1Es0NylvoQM3ghyEwADsHdDfnkvmsvS15Ffejz5pTsglgcgRBm
         qQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293008; x=1758897808;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SWUtL1UQ6+yUSLVklwzlRQU7PKxN439/50grQVTKRY0=;
        b=NdTrDczqemXsGv2hbQMWjw95YPiUsMwIkgZBSkr0+j4pspSDF5wdjZLqRJzcu4I64w
         u9Xfo8v/fTKQ5uAbj5U6fEbkWxGShGQzPdBDf6Mc6DyMfXX3+cugq5DEhZeHaZoxUi2z
         rtkBziit1Vwek4Bh15jJYxr7rW1TcAKtrsK802Lrs8pQhEVzfgYVP7mgh7WOIXNH84B2
         ZFfDchlzwKyZqL/Rh4c+RTYQjaj3VmFXN3sNSQikfkRt8++y58b85tx7RImy/9EuJDnK
         ATUVYBYSYWr2FR+2Eg/lwIyHwoc6/tbouuSxI8L0h/JzhT16aArZxB8O5WfJUqVkuNjk
         6Yfg==
X-Forwarded-Encrypted: i=1; AJvYcCWRJ3tgFJZYouHpNLF+qcvSpXM4bvg6LpFPk00E8nouH94gTqZxm/tVt8j8PjyrekgxI1hyaMTLQShxTdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDKc2cBcyMVlCosIh8VBev9AGndBNQrF5hJfGgjxepllMCKYM7
	PNL1m1FemzUkGLf6uTyRr5T8nIZcC0+yvhvpgxyReFgBErXR9+n5hXEcRIK+2kBzwFc=
X-Gm-Gg: ASbGncu3Um5devMD8Ibt6fIaOScxVn5O9OJzDnUz1cohUqXlfZn/8Kidt9uTBuCKN4c
	pirGW+9MTxu79jRbeIfmn+CfjtQVU3AkbnUoyXAufKyNjZMbZP+4bhW1I/GDYhmu/jtw6S79NwF
	oHf7c+jtPcr4HmgZubEO+le897aQWrJAlfDz5QXqKMbQbSB8RVUdpQyq4ICZIUjJfAGeM3pFPmj
	krMexla4QO6iRt3eJtkaMrT9GkDgJ2LZH4DtF/KN2mAdu0mQHxscvUGGYkIlq4dJiSG/Omg9Heo
	crmoAYjllwEVwJU+YTUHuW24z74uSxG5SiElodrO7nmdFZ4WvLNLgSO0898LrR8i4m0oYs0l9sL
	SkXBqrAhNW+TYdthVcz16Paa1hbuShd7763dXc6VDRuTbqiLoLS6OmLUj7mK1y9/7istZTqkR
X-Google-Smtp-Source: AGHT+IHCWl7rYd87fEkv3gPY4LPDSQXSViH2/pCqHBtI1svI/kh5EQAbPk2h8jWXnmgX+A4zRGpPIw==
X-Received: by 2002:a05:600c:8b4b:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-467e7f7d89dmr29564495e9.13.1758293007734;
        Fri, 19 Sep 2025 07:43:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:77b3:66a:b2a0:c20f? ([2a01:e0a:3d9:2080:77b3:66a:b2a0:c20f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d42bee6sm131246365e9.15.2025.09.19.07.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 07:43:27 -0700 (PDT)
Message-ID: <36345378-6fd5-4a48-b5ea-0fcb6abda7ba@linaro.org>
Date: Fri, 19 Sep 2025 16:43:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND] dts: arm64: amlogic: Add ISP related nodes for C3
To: keke.li@amlogic.com, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250918-b4-c3isp-v1-1-5f48db6516c9@amlogic.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250918-b4-c3isp-v1-1-5f48db6516c9@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/09/2025 10:35, Keke Li via B4 Relay wrote:
> From: Keke Li <keke.li@amlogic.com>
> 
> Add the IMX290 sensor node description to the device tree file,
> which will be controlled via I2C bus with image data transmission
> through MIPI CSI-2 interface.
> 
> Add CSI-2, adapter and ISP nodes for C3 family.
> 
> Signed-off-by: Keke Li <keke.li@amlogic.com>
> ---
> The C3 ISP driver and device-tree bindings have been
> submitted. To facilitate using the C3 ISP driver, the
> related device nodes need to be added.

No need to resend until the bindings are merged.

Neil

> ---
>   .../boot/dts/amlogic/amlogic-c3-c308l-aw419.dts    | 84 +++++++++++++++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        | 88 ++++++++++++++++++++++
>   2 files changed, 172 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts
> index 45f8631f9feb..e026604c55e6 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts
> @@ -17,6 +17,7 @@ / {
>   	aliases {
>   		serial0 = &uart_b;
>   		spi0 = &spifc;
> +		i2c2 = &i2c2;
>   	};
>   
>   	memory@0 {
> @@ -146,6 +147,36 @@ sdcard: regulator-sdcard {
>   		regulator-boot-on;
>   		regulator-always-on;
>   	};
> +
> +	camera_vdddo_1v8: regulator-camera-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "CAMERA_VDDDO";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_3v3>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	camera_vdda_2v9: regulator-camera-2v9 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "CAMERA_VDDA";
> +		regulator-min-microvolt = <2900000>;
> +		regulator-max-microvolt = <2900000>;
> +		vin-supply = <&vcc_5v>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	camera_vddd_1v2: regulator-camera-1v2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "CAMERA_VDDD";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		vin-supply = <&vcc_3v3>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
>   };
>   
>   &uart_b {
> @@ -258,3 +289,56 @@ &sd {
>   	vmmc-supply = <&sdcard>;
>   	vqmmc-supply = <&sdcard>;
>   };
> +
> +&i2c2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins1>;
> +	clock-frequency = <100000>; /* default 100k */
> +
> +	imx290: sensor0@1a {
> +		compatible = "sony,imx290";
> +		reg = <0x1a>;
> +		clocks = <&clkc_pll CLKID_MCLK0>;
> +		clock-names = "xclk";
> +		clock-frequency = <37125000>;
> +		assigned-clocks = <&clkc_pll CLKID_MCLK_PLL>,
> +				  <&clkc_pll CLKID_MCLK0>;
> +		assigned-clock-rates = <74250000>, <37125000>;
> +
> +		vdddo-supply = <&camera_vdddo_1v8>;
> +		vdda-supply = <&camera_vdda_2v9>;
> +		vddd-supply = <&camera_vddd_1v2>;
> +
> +		reset-gpios = <&gpio GPIOE_4 GPIO_ACTIVE_LOW>;
> +
> +		port {
> +			imx290_out: endpoint {
> +				data-lanes = <1 2 3 4>;
> +				link-frequencies = /bits/ 64 <222750000 148500000>;
> +				remote-endpoint = <&c3_mipi_csi_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&csi2 {
> +	status = "okay";
> +
> +	ports {
> +		port@0 {
> +			c3_mipi_csi_in: endpoint {
> +				remote-endpoint = <&imx290_out>;
> +				data-lanes = <1 2 3 4>;
> +			};
> +		};
> +	};
> +};
> +
> +&adap {
> +	status = "okay";
> +};
> +
> +&isp {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> index cb9ea3ca6ee0..a62fd8534209 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> @@ -992,5 +992,93 @@ mdio0: mdio {
>   				#size-cells = <0>;
>   			};
>   		};
> +
> +		csi2: csi2@ff018000 {
> +			compatible = "amlogic,c3-mipi-csi2";
> +			reg = <0x0 0xff018000 0x0 0x100>,
> +			      <0x0 0xff019000 0x0 0x300>,
> +			      <0x0 0xff01a000 0x0 0x100>;
> +			reg-names = "aphy", "dphy", "host";
> +			power-domains = <&pwrc PWRC_C3_MIPI_ISP_WRAP_ID>;
> +			clocks = <&clkc_periphs CLKID_VAPB>,
> +				 <&clkc_periphs CLKID_CSI_PHY0>;
> +			clock-names = "vapb", "phy0";
> +			assigned-clocks = <&clkc_periphs CLKID_VAPB>,
> +					  <&clkc_periphs CLKID_CSI_PHY0>;
> +			assigned-clock-rates = <0>, <200000000>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					c3_mipi_csi_out: endpoint {
> +						remote-endpoint = <&c3_adap_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		adap: adap@ff010000 {
> +			compatible = "amlogic,c3-mipi-adapter";
> +			reg = <0x0 0xff010000 0x0 0x100>,
> +			      <0x0 0xff01b000 0x0 0x100>,
> +			      <0x0 0xff01d000 0x0 0x200>;
> +			reg-names = "top", "fd", "rd";
> +			power-domains = <&pwrc PWRC_C3_ISP_TOP_ID>;
> +			clocks = <&clkc_periphs CLKID_VAPB>,
> +				 <&clkc_periphs CLKID_ISP0>;
> +			clock-names = "vapb", "isp0";
> +			assigned-clocks = <&clkc_periphs CLKID_VAPB>,
> +					  <&clkc_periphs CLKID_ISP0>;
> +			assigned-clock-rates = <0>, <400000000>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					c3_adap_in: endpoint {
> +						remote-endpoint = <&c3_mipi_csi_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					c3_adap_out: endpoint {
> +						remote-endpoint = <&c3_isp_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		isp: isp@ff000000 {
> +			compatible = "amlogic,c3-isp";
> +			reg = <0x0 0xff000000 0x0 0xf000>;
> +			reg-names = "isp";
> +			power-domains = <&pwrc PWRC_C3_ISP_TOP_ID>;
> +			clocks = <&clkc_periphs CLKID_VAPB>,
> +				 <&clkc_periphs CLKID_ISP0>;
> +			clock-names = "vapb", "isp0";
> +			assigned-clocks = <&clkc_periphs CLKID_VAPB>,
> +					  <&clkc_periphs CLKID_ISP0>;
> +			assigned-clock-rates = <0>, <400000000>;
> +			interrupts = <GIC_SPI 145 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +
> +			port {
> +				c3_isp_in: endpoint {
> +					remote-endpoint = <&c3_adap_out>;
> +				};
> +			};
> +		};
>   	};
>   };
> 
> ---
> base-commit: 84b92a499e7eca54ba1df6f6c6e01766025943f1
> change-id: 20250731-b4-c3isp-16531391a1cb
> 
> Best regards,


