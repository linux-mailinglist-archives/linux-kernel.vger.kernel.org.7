Return-Path: <linux-kernel+bounces-893283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA493C46FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D50D84EBFB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CE1309EF6;
	Mon, 10 Nov 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbc7vYrC"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492C61DED7B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782089; cv=none; b=VtI9p5rv0EUim9SrEnwO3O3LQ8NeVuUH28VnbGYwQzpIRkGlfha3dQXgxBZYPdzVIUeHzWZEkfa9DVD2Uxqa7XOi+3vL0f7fO8Uyxy5ECCyAVcZYKPgNORgblpT26N0QfsZ0wOQ8q4qolHU5f4gumHFaaTkrHLe4GKTShmSUpIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782089; c=relaxed/simple;
	bh=KN0w6qAe1O5qDfYrH8AatfJd0V7Fi4K8T0H7k/dpmFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcSz0Eb+yrVRv0vpKMcrdaERe1MF2WZPeyN2136kw0ArGnaXHawWUZYk4LAVoUnFK6A5rCL6y8pfYzVmFk8sWC5aMBtYS+mGnuMb/dfdt/gcK4xkDZMLtXHuHVSCmDvFzuN59aWJ5kZF/6z7eW3q7xxxGdJq0nlH8m2hxnYQsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pbc7vYrC; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso772974f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762782084; x=1763386884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z8vx2FUknmzQrwBbS9dXJNGrhupJ+dgMCFmrh9YnAA=;
        b=pbc7vYrCAjZSR4EwQO642ibKThe7vnJWylQzVu6ScWbxHZgRXx61Gsa7WXDTfTYFjU
         o+Fk0th0ZhrVFTDCSIHHdGsKDrnN6r94K1KXy0ORW6ztJkBWs5RQC/T4ZQVvt4qUt9rH
         pGr6pjpx+1gwXwwZp2Zicth61lLae9S2iQ6lMfsjX+1MwxUjFwPkCYwQJU/3tYpIVNuQ
         hga+qIxHJczsFmGngWXOI825HNreq6iihkIUtGeu+NtNSccwO1bcla/w9vENYDL3HNBx
         hxh9+mMdS382cBVu34i9nGhAzxEQgod6kdNYpAHGuY2dFsJ5LR0wpKmnU8W/UEXxM+16
         IVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762782084; x=1763386884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Z8vx2FUknmzQrwBbS9dXJNGrhupJ+dgMCFmrh9YnAA=;
        b=haAOwTMbspNBdZ+DXbzAGCxeRDFF92ZZfaz3g+HOrG365bctFqOHs425RT/9iBB4eg
         rqhUx0kpwC2YOKXu84zrD0Qdn78JHo4N0c3Cb85Y2K2OljT61o3k8qijCkgSx2BYmUnI
         P2KV2MJO3z7+4i4sJkBqk5S0oPQrJxKWUPtnpILC+86WhJ5Pe7L5GFkNdvh8D9vduoKc
         B97eoKCZOefJT9ggz5xobxDPsY8oX28d4eMY0Dz54FMO+EChGAgWkQeiGoyKhXx/DbmZ
         ukOLLYSrzOnd7+lkncYaSezJMIzlR4VMVvPcvdgL3SHIAqk9bu5Q4SQ1hQlx4Eixro+h
         pzUw==
X-Forwarded-Encrypted: i=1; AJvYcCXt7AZOGXDkbC1wRpa9Xtv94C3eEbiXpMAMWNNy6dGPvd7cI/ksOL7RKDxekFANfH9cUqfKVIkDueopIFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/nE8iZgeeuozM+zaDx8E3Cdgms1YMmT3gVLZYw5z1usIPvjoN
	WaEOgZp62nUJqak+KKgZAUn1vUdL9Jl2kuWiyi09nWK8IYk+QYUnJwA2Y46bdRgHK98=
X-Gm-Gg: ASbGncvw+G6wQUx1rW9qEhbVOJNfFGqJJck9XqcjNMlrgZAZ1OX7nD9p4W7htNFsQDh
	N7CYgEueGgK+GaVU3M7tvvOdsrSDeVrmJr0kQf9GelmyvzRTKKzlmmKBmSzAj53txYEqN7KhOEE
	6/OrmYTEbuHfTCXD55U+RnRtahkZWMdPb7qKAkqNU/gD6ZCNxm6szXBBEnOucSLJwlhkOfpLDrO
	PalBVNt2CY0BLYee/QN/qaX6D95vSEywXzfem20gpID0TN6e2b1so8yzRbBabqnI3mY6wv38uzn
	GCa1vMWyQu2fXLW3ZrYrlivr7zDFbz5jZuGE+esHRO6zZLAnA2+Mcl38dKtwXuH1EezOKCHzfE2
	3+jj+prFxkakc1caujqfxVlzQgqVmstFAsU6IrbLf2f9TJQKhP5pegQl4EafQoRDOJoa1dAqW6u
	dgL2LTJrQSQ+Q=
X-Google-Smtp-Source: AGHT+IEW9Js0mnXx/rOq3W/yNiXQ1UEN+TONe9DJgelI9gDGHI0fV/F2A2Mdg0LAb9R9hkSCrd5i2g==
X-Received: by 2002:a5d:5f42:0:b0:429:bca4:6b44 with SMTP id ffacd0b85a97d-42b2dc1f4e9mr7119563f8f.13.1762782084288;
        Mon, 10 Nov 2025 05:41:24 -0800 (PST)
Received: from linaro.org ([2a00:fbc:eb43:2253:ad6a:84ac:23bf:2782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b29e4b9bdsm18489964f8f.32.2025.11.10.05.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:41:23 -0800 (PST)
Date: Mon, 10 Nov 2025 14:41:15 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ettore Chimenti <ettore.chimenti@linaro.org>,
	Srinivas Kandagatla <srini@kernel.org>, stefan.schmidt@linaro.org,
	wse@tuxedocomputers.com, cs@tuxedo.de
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: Add device tree for TUXEDO
 Elite 14 Gen1
Message-ID: <aRHre28Nbyv6ShbU@linaro.org>
References: <20251105154107.148187-1-ggo@tuxedocomputers.com>
 <20251105154107.148187-7-ggo@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105154107.148187-7-ggo@tuxedocomputers.com>

On Wed, Nov 05, 2025 at 04:41:06PM +0100, Georg Gottleuber wrote:
> Initial support for TUXEDO Elite 14 Gen1 based on Qualcomm Snapdragon X
> Elite SoC (X1E78100).
> 
> Working:
> * Touchpad
> * Keyboard
> * eDP (no brightness control yet)
> * NVMe
> * USB Type-C port
> * USB-C DP altmode
> * HDMI-A port
> * WiFi (WiFi 7 untested)
> * Bluetooth
> * GPU
> * Video decoding
> * USB Type-A
> * Audio, speakers, microphones
> 	- 4x speakers.
> 	- 4x dmic
> 	- headset
> * Camera
> * Fingerprint reader
> 
> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |    2 +
>  .../qcom/x1e80100-tuxedo-elite-14-gen1.dts    | 1486 +++++++++++++++++
>  2 files changed, 1488 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 296688f7cb26..598bf4c6e84a 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -350,3 +350,5 @@ x1p42100-hp-omnibook-x14-el2-dtbs := x1p42100-hp-omnibook-x14.dtb x1-el2.dtbo
>  dtb-$(CONFIG_ARCH_QCOM)	+= x1p42100-hp-omnibook-x14.dtb x1p42100-hp-omnibook-x14-el2.dtb
>  x1p42100-lenovo-thinkbook-16-el2-dtbs	:= x1p42100-lenovo-thinkbook-16.dtb x1-el2.dtbo
>  dtb-$(CONFIG_ARCH_QCOM)	+= x1p42100-lenovo-thinkbook-16.dtb x1p42100-lenovo-thinkbook-16-el2.dtb
> +x1e80100-tuxedo-elite-14-gen1-el2-dtbs	:=  x1e80100-tuxedo-elite-14-gen1.dtb x1-el2.dtbo
> +dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-tuxedo-elite-14-gen1.dtb

Please also add x1e80100-tuxedo-elite-14-gen1-el2.dtb here (similar to
the other lines), so that the EL2/KVM-specific DTB is automatically
built and included in the installed DTBs.

> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts b/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
> new file mode 100644
> index 000000000000..0bfe5931434e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
> @@ -0,0 +1,1486 @@
> [...]
> +	vreg_edp_3p3: regulator-edp-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_EDP_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 54 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&edp_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-always-on;

Does this need to be always on? It should be possible to enable/disable
this supply together with the panel (and it is already set as
power-supply for the panel).

> +		regulator-boot-on;
> +	};
> +
> [...]
> +	sound {
> +		compatible = "qcom,x1e80100-sndcard";
> +		model = "X1E80100-TUXEDO-Elite-14";
> +		audio-routing = "WooferLeft IN", "WSA WSA_SPK1 OUT",
> +				"TweeterLeft IN", "WSA WSA_SPK2 OUT",
> +				"WooferRight IN", "WSA2 WSA_SPK2 OUT",
> +				"TweeterRight IN", "WSA2 WSA_SPK2 OUT",
> +				"IN1_HPHL", "HPHL_OUT",
> +				"IN2_HPHR", "HPHR_OUT",
> +				"AMIC2", "MIC BIAS2",
> +				"VA DMIC0", "MIC BIAS1",
> +				"VA DMIC1", "MIC BIAS1",
> +				"VA DMIC0", "VA MIC BIAS1",
> +				"VA DMIC1", "VA MIC BIAS1",

Please drop the two "VA MIC BIAS" lines, see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b49e37de8e70bc433b526a9f4382f72b7ac6492e

> +				"TX SWR_INPUT1", "ADC2_OUTPUT";
> +
> +		wcd-playback-dai-link {
> +			link-name = "WCD Playback";
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
> +			};
> +
> +			codec {
> +				sound-dai = <&wcd938x 0>, <&swr1 0>, <&lpass_rxmacro 0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +
> +		wcd-capture-dai-link {
> +			link-name = "WCD Capture";
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
> +			};
> +
> +			codec {
> +				sound-dai = <&wcd938x 1>, <&swr2 1>, <&lpass_txmacro 0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +
> +		wsa-dai-link {
> +			link-name = "WSA Playback";
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
> +			};
> +
> +			codec {
> +				sound-dai = <&left_woofer>, <&left_tweeter>,
> +					    <&swr0 0>, <&lpass_wsamacro 0>,
> +					    <&right_woofer>, <&right_tweeter>,
> +					    <&swr3 0>, <&lpass_wsa2macro 0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +
> +		va-dai-link {
> +			link-name = "VA Capture";
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
> +			};
> +
> +			codec {
> +				sound-dai = <&lpass_vamacro 0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +	};
> [...]
> +&remoteproc_adsp {
> +	firmware-name = "qcom/x1e80100/adsp.mbn",
> +			"qcom/x1e80100/adsp_dtb.mbn";

We need a custom ADSP firmware for the TUXEDO, so this needs to be a
device-specific path (so that you can upload the correct firmware to
linux-firmware). e.g. "qcom/x1e80100/TUXEDO/adsp.mbn"

> +
> +	status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/x1e80100/cdsp.mbn",
> +			"qcom/x1e80100/cdsp_dtb.mbn";

If you expect that production versions of this device will have the
(firmware) secure boot enabled, this path should also be
device-specific. If retail versions will allow loading arbitrary
firmware this can stay as-is. 

Same for all other "firmware-name"s.

> +
> +	status = "okay";
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

You have just a single USB-C port, so I would expect that there is also
only a single SMB2360 instance (for charging). Perhaps you can just drop
this node?

Thanks,
Stephan

