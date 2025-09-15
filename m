Return-Path: <linux-kernel+bounces-816181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4936B570A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3393B5C03
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE42C028A;
	Mon, 15 Sep 2025 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qfazw34I"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A115214236
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919124; cv=none; b=P3/ZCQTwKB+JteiLMErUwAconT8WTps+knVUXBWKIMWFKCS+tFjenioQ2iYxHmkbDodPlCbo2hi/r8uz5b1WDF7+ZmJ2RJcTcBzJ+c9CjoDMHmBGMFblCJHMe33qKfnMZwUKCxpoDdbSSa2wfNRAz7k+MoNwdVuDFzxhDlBiclI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919124; c=relaxed/simple;
	bh=rMLX8k7AOC0+a9svea/LNCNr26oM79ixyxHQZQEL+as=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=So02CMAsWM5iIfiVY9lK6Wt2fTvbkJBz0pM8ZdMmyceXeLGg4v4cvOAaF+oqCS0HPvW4zTDgfzGVUqzt+eKlVC9XZd0jdlAGqxZKfFGaOFMhZipDREoLr3Fv23JNL/3OS/SJPgHhfi4oyXGyiu6cu7E2BzhzeEr6rpORslm5aHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qfazw34I; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so26926225e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757919120; x=1758523920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVrOrvJNJR/3wd4S2m5mm9h3s7cmXqmF9awofiLZTBQ=;
        b=qfazw34IwrDWQNIMGxRAFicWKIhoXoUoxz2wfJpGTThounvSyJ7GaV0cwOiPNjRBUO
         bB0SuXt8wjPttK8RhW4E/74gFoq2pxU1ExtG/aoWW5PdNI03dHJ33uxywUyua9vcEHXr
         lPZHbIH70zbpQwU4+9XrjB62MqjCAP3DUM7quc13wHvbJqK8/22JoXPj8RHNB0SOCwgc
         lwdOSFEIrELlSn5B+Z+ia2J/liq5Wi2oORAkoo8ROc7W1MOOGswCUHhYuEsIpyJZPxI0
         daGBSs3sXBtfyJ82YeRGIJp1I/23fxWiw/gJty+p2iOYP6oR557/CTD7D6QFNOznS7R3
         JI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757919120; x=1758523920;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sVrOrvJNJR/3wd4S2m5mm9h3s7cmXqmF9awofiLZTBQ=;
        b=sdQa+YpL2CPTRjk4ysO/wo2X56OmXGTh6TlkmipD6UQLRQXZfL+jpg8e2pqGNTfynK
         R721iVUUHj/m7k52rB1exKOPdTV33xgRzs11UfyEHfEtu8xlzLGl3yRqfMXCZxAPx3Pg
         7bmN0HnNJsFkv7yQuBQapupDGGGCyzj2ZXgiUZ66gTbB0qB/4Qpm8iWcVhvVcMwDPDZu
         WrCUPZTDjIT4uHKHJrhR9Mcm/MMgPtgr/nVWa56S3r1Y8CFN+dxZ8hjpWlCrG0GAaVD5
         u3oewzF/JvhO3F+m2nlB9RXYRUsY1PnHEPiHNH0OliAlIJpNP+D1WNgcFuk+FlxkAcnu
         jLaA==
X-Forwarded-Encrypted: i=1; AJvYcCXseFjcwWpULsHjoqF3+Zf0U/PIOdyfhx3TtXVlF9yi4EzZYMyrs5KpjHEqaXpc56u1PEAnpgt0T2YHICM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVKU0dUbJsD576EEjBqYXNqly+M/VCBeeJMJVLjzFW4PpSCFH3
	aNq/U09cMRA/f1v2iXba8MkACNr4IxqioGnKhaiLpdazOaotPRYajvFWiBfdvaPxhY2xXWdq8au
	Tne5OOvA=
X-Gm-Gg: ASbGncv6aRjfCB6z6Z/aZklSCQxVXv5FIiyJRJZKzPzKTp/XnCTiJbfTq2PEBfdrJ6r
	4wWOj5PxDVKTCSbYPdgJr8N60773xB7g5KuPiF7qjcc9QkPchNPKUKU/Y3MXv1/9O/7m6ZQMn6v
	HHAY7SKwet8WKCyVpP533x0PFlOJIHzFB6xZZT0YJl1AIeraxJSk2g/ic5KQZ4pgu3OzwPxWR1T
	2M+DWxSfuaciNIbf/b+OspdYJdfzLvWbw3LRnrh4P9RAwRVki+qshD7k6bsoGRYu7v0Q9Nt0p0J
	M89aLU5bXB/6q4eXaHZP91z0x4/eGBE6yrwkaHZWKkck6zG6PO2R7E3tHqWSDAxxSm0HwWZlmn7
	RRKpUbN5q+/fVpMSe+gVP+Xs6G4HJLjt4QKSkjumZo6KBL026d4uixrTuBxBO7FrW6PR2aewr
X-Google-Smtp-Source: AGHT+IHFe5+roXCW2XOUA/D2mZRx5HTeW/CLYBEWcLgJjUgqOm/UB63H0rBZQ/h2HiEj8N8gRZ1Pjw==
X-Received: by 2002:a05:600c:2249:b0:45d:e54b:fa0c with SMTP id 5b1f17b1804b1-45f2121431amr91326595e9.17.1757919120381;
        Sun, 14 Sep 2025 23:52:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:600a:60f:7208:24ed? ([2a01:e0a:3d9:2080:600a:60f:7208:24ed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f2acbeee0sm58227275e9.0.2025.09.14.23.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 23:52:00 -0700 (PDT)
Message-ID: <3d9ce086-dbcb-4e55-850e-89977cb88978@linaro.org>
Date: Mon, 15 Sep 2025 08:51:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH DNM v2 5/5] arm64: dts: qcom: qcs6490-radxa-dragon-q6a:
 Enable USB 3.0 and HDMI ports
To: Xilin Wu <sophon@radxa.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
 Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
References: <20250914-radxa-dragon-q6a-v2-0-045f7e92b3bb@radxa.com>
 <20250914-radxa-dragon-q6a-v2-5-045f7e92b3bb@radxa.com>
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
In-Reply-To: <20250914-radxa-dragon-q6a-v2-5-045f7e92b3bb@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/09/2025 17:57, Xilin Wu wrote:
> This board doesn't feature a regular Type-C port. The usb_1_qmpphy's
> RX1/TX1 pair is statically connected to the USB-A port, while its RX0/TX0
> pair is connected to the RA620 DP-to-HDMI bridge.
> 
> Add and enable the nodes for the features to work.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> 
> ---
> 
> This change depends on the following patch series:
> https://lore.kernel.org/all/20250908-topic-x1e80100-hdmi-v3-4-c53b0f2bc2fb@linaro.org/
> ---
>   .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 152 +++++++++++++++++++++
>   1 file changed, 152 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> index 3bf85d68c97891db1f1f0b84fb5649803948e06f..12bc9a0fcfbfeaabf6ede351f96c61193a8261c0 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> @@ -78,6 +78,71 @@ chosen {
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> +	usb3_con: connector {
> +		compatible = "usb-a-connector";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				usb3_con_hs_in: endpoint {
> +					remote-endpoint = <&usb_1_dwc3_hs>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				usb3_con_ss_in: endpoint {
> +					remote-endpoint = <&usb_dp_qmpphy_out_usb>;
> +				};
> +			};
> +		};
> +	};
> +
> +	hdmi-bridge {
> +		compatible = "radxa,ra620";
> +
> +		pinctrl-0 = <&dp_hot_plug_det>;
> +		pinctrl-names = "default";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				hdmi_bridge_in: endpoint {
> +					remote-endpoint = <&usb_dp_qmpphy_out_dp>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				hdmi_bridge_out: endpoint {
> +					remote-endpoint = <&hdmi_connector_in>;
> +				};
> +			};
> +		};
> +	};
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_bridge_out>;
> +			};
> +		};
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   
> @@ -504,6 +569,21 @@ &lpass_va_macro {
>   	status = "okay";
>   };
>   
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dp {
> +	sound-name-prefix = "Display Port0";
> +
> +	status = "okay";
> +};
> +
> +&mdss_dp_out {
> +	data-lanes = <0 1>;
> +	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
> +};
> +
>   &pcie0 {
>   	perst-gpios = <&tlmm 87 GPIO_ACTIVE_LOW>;
>   	wake-gpios = <&tlmm 89 GPIO_ACTIVE_HIGH>;
> @@ -753,6 +833,22 @@ platform {
>   			sound-dai = <&q6apm>;
>   		};
>   	};
> +
> +	dp0-dai-link {
> +		link-name = "DP0 Playback";
> +
> +		codec {
> +			sound-dai = <&mdss_dp>;
> +		};
> +
> +		cpu {
> +			sound-dai = <&q6apmbedai DISPLAY_PORT_RX_0>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6apm>;
> +		};
> +	};
>   };
>   
>   /* Pin 11, 29, 31, 32 in GPIO header */
> @@ -967,6 +1063,58 @@ &ufs_mem_phy {
>   	status = "okay";
>   };
>   
> +&usb_1 {
> +	dr_mode = "host";
> +
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3_hs {
> +	remote-endpoint = <&usb3_con_hs_in>;
> +};
> +
> +&usb_1_hsphy {
> +	vdda-pll-supply = <&vreg_l10c_0p88>;
> +	vdda33-supply = <&vreg_l2b_3p072>;
> +	vdda18-supply = <&vreg_l1c_1p8>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_qmpphy {
> +	vdda-phy-supply = <&vreg_l6b_1p2>;
> +	vdda-pll-supply = <&vreg_l1b_0p912>;
> +
> +	/delete-property/ orientation-switch;
> +
> +	status = "okay";
> +
> +	ports {
> +		port@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/delete-node/ endpoint;
> +
> +			/* RX1/TX1 is statically connected to USB-A port */
> +			usb_dp_qmpphy_out_usb: endpoint@0 {
> +				reg = <0>;
> +
> +				data-lanes = <2 3>;
> +				remote-endpoint = <&usb3_con_ss_in>;
> +			};
> +
> +			/* RX0/TX0 is statically connected to RA620 bridge */
> +			usb_dp_qmpphy_out_dp: endpoint@1 {
> +				reg = <1>;
> +
> +				data-lanes = <3 2>;
> +				remote-endpoint = <&hdmi_bridge_in>;
> +			};

In this WiP patchset endpoint@0 is suposed to be DisplayPort, and endpoint@1 for USB3 lanes.

And you must not have colliding data-lanes, so it should be something like:

			/* DP0/DP1 is statically connected to a RA620 bridge*/
			usb_dp_qmpphy_out_dp: endpoint@0 {
				reg = <0>;

				data-lanes = <0 1>;
				remote-endpoint = <&hdmi_bridge_in>;
			};

			/* RX0/TX0 is statically connected to an USB-A Connector */
			usb_dp_qmpphy_out_usb: endpoint@1 {
				reg = <1>;

				data-lanes = <2 3>;
				remote-endpoint = <&usb3_con_ss_in>;
			};

But I just found out while reviewed my patchset is wrong... it should be:

+          endpoint@0:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            description: Display Port Output lanes of the PHY when used with static mapping
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                minItems: 2
+                maxItems: 4
+                oneOf:
+                  - items: # DisplayPort 2 lanes, normal orientation
+                      - const: 3
+                      - const: 2
+                  - items: # DisplayPort 2 lanes, flipped orientation
+                      - const: 0
+                      - const: 1
+                  - items: # DisplayPort 4 lanes, normal orientation
+                      - const: 0
+                      - const: 1
+                      - const: 2
+                      - const: 3
+                  - items: # DisplayPort 4 lanes, flipped orientation
+                      - const: 3
+                      - const: 2
+                      - const: 1
+                      - const: 0

and in driver:
+static const u32 dp_2_data_lanes_mapping[][2] = {
+	[TYPEC_ORIENTATION_NORMAL] = { 3, 2 },
+	[TYPEC_ORIENTATION_REVERSE] = { 0, 1 },

Neil

  +		};
> +	};
> +};
> +
>   &usb_2 {
>   	dr_mode = "host";
>   
> @@ -986,6 +1134,10 @@ &venus {
>   };
>   
>   /* PINCTRL - additions to nodes defined in sc7280.dtsi */
> +&dp_hot_plug_det {
> +	bias-disable;
> +};
> +
>   &pcie0_clkreq_n {
>   	bias-pull-up;
>   	drive-strength = <2>;
> 


