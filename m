Return-Path: <linux-kernel+bounces-865582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFC7BFD7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A2F3563835
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5B274B55;
	Wed, 22 Oct 2025 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KodlE0R1"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D5625A341
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152702; cv=none; b=RpKNZ1VmanSag0DZnEa2cjmxsf8WahU532r19Sj+dRtMIsbuwK8+pAds03oeLOgvyxyW6xLi5BUyQrXow4PLrlZaQT8yZoeiZNUVOJxIkk6oyK5Bm8uZ+q5+bMyB6Le0+pP29G8/4pIL1rG3lVPWT5ElWYVfqWddW0LWLQwh7MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152702; c=relaxed/simple;
	bh=EgunH31eTnsVb/QLiEMMM1PyLJAVFDnbYWNUJS4Vl30=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nF284N9qY6XUqQWi/d/hBmVT0Z6QaWbCtbm9EpcP0eurzHWftd4LMkpm8mqhHwRHbqAShmtONU4KI5sJ4kWwQA7Y1Yj2ZHy3fmpNmiH0AQptB7J1qs4xdTYvA8QwtNi6Ll9qzEGIxdXf0gUiOdwTnErQvkP1e8kSkBCCeX2Vp3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KodlE0R1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47495477241so20462275e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761152699; x=1761757499; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32wWVCnxfPxXwYEHrPhplOIt/hFbj1bnM86HXOsRbI0=;
        b=KodlE0R1GQA9GEWGXTHyqDj9gLNV4yOVhDFiSFIqRGP61Ly1OBmp6THR4N9DTXfNZb
         0XIrPAaBaYGs1hIS/KF2RiAQ/Pzx/YW4n+bECj2aERB/icOn1HMHpY7mi6XybgwTS2Br
         qUQAgpK7KgkqKi1aojPfd9CuaS376aCNURdbmSU4ysueh37Axjn7wpdUHu4d9r6lbWhn
         qlL8JmRHbDxeAGMBLSJUw/TQtXEpkGMsqVqO2R9jgFAt3Nwa0Y7DORmPao4c5zV7LdL5
         1rKCEV514oz2lVEXb58JWqOQaJaPtY0UuVHSrV+zJz92D2cTHUlrKhVmkqu8XURdxsi9
         BRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152699; x=1761757499;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=32wWVCnxfPxXwYEHrPhplOIt/hFbj1bnM86HXOsRbI0=;
        b=l9PD4AcWZukb4wEr7XrnK02bjiM1wGCmoHfjznMAhpcrK3sAhex4Pr/q37XLl6A/d8
         /v/WvWwz9XZcGmmQ4yEK6J6f7UrsKAI7eNffxvwVeqXJt9SZYsDbuL3kvqtskujTQ9tx
         sAi/oTQLTuarW760KCIzIerlIBYKvQe+3tMD6Jye49lrW1nyN4VT3Sy7zgp22o1fycXT
         ym/k871YLDTLraSwGc69taIs5WpK9mOEP+bS2Pm0ungsIHMICtYwIo1cXJPoqx3pMRMA
         vTLmWLRluU484VXrbsF5Xb9IFlw+YiEPJEsQYiqDVCxgsYW3TM2JOhrpXKs8aJPTq8xF
         tq5w==
X-Forwarded-Encrypted: i=1; AJvYcCVMToiuFATvj1NnSc80iHU6o4MXi1oEVFLKAIfaBfVnuAwxi5pfa3GaCvPd6GKj3FRtIWP1mWsCdcwm4u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyonIbN6d44SNYMAz3gBRNSBST+ojcLcU8nkGI/Cr0n8dfHwcIS
	rZ8mKVlNleMtvYYVPionrESuxgEKhSj+6l67tZH2LSZTxVBJEkSIwYbSr2ndhnvlheE=
X-Gm-Gg: ASbGnctsd7th75LqSQzUvv+KLV2lBV3Vkeb1DFT/Ms3lTQdTtBiUn+YqHpPgb9Ls5BW
	FSZEdZU1QqWmFhQmzrtDOn2zTDbx7suCNJkKzfh0VN6Jq74EKgosBXlIQXbxGMjU4mfFvE51d/0
	/8ESusvFNoSB5nxfWtxgADm1MYUIIDzDQaDS///erO8nHuIRFGMj8SHxbK2IucoZ43fZyGAyLlo
	qgTZxsT6RLkNpqsODXLO8eKfHBg8pPb8+fHtebkAymxFsHJyradbyTIjti6y+Lxk/9CSm6rnir+
	5Pw65+r+wchOX91bI6ML3fDS+ksbgMcgXYC+VrjEb65Hj6CwZEtjxF0G9A/7pFUOsURTt1Pg6bE
	XUdtJQexsCxaSGJcczpqtc9O8adcc6aXfFoXvC3jaj+xK9PccE6z30I2+94muyUKSdc2hkAP8EG
	tOn45e
X-Google-Smtp-Source: AGHT+IFmj2XqRZSV8uq6JK5/wuWcy7s7skNAC2uPqQiciaWffxUPCp6My9UDZBTNxMujaGi4I4wsdg==
X-Received: by 2002:a05:600c:3554:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-4711789e374mr126327145e9.13.1761152698935;
        Wed, 22 Oct 2025 10:04:58 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:11f4:2b3f:7c5a:5c10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-428567cd83csm3271205f8f.14.2025.10.22.10.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 18:04:57 +0100
Message-Id: <DDP0J063IX84.2MC5D16VHRFVR@linaro.org>
Cc: <linux-sound@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sibi Sankar"
 <sibi.sankar@oss.qualcomm.com>
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: x1e80100-dell-xps13-9345: Add
 Left/Right Speakers and Tweeter
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Abel Vesa" <abel.vesa@linaro.org>, "Srinivas Kandagatla"
 <srini@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>
X-Mailer: aerc 0.20.0
References: <20251021-dell-xps13-9345-enable-audio-v1-0-6f3f6bbd977b@linaro.org> <20251021-dell-xps13-9345-enable-audio-v1-3-6f3f6bbd977b@linaro.org>
In-Reply-To: <20251021-dell-xps13-9345-enable-audio-v1-3-6f3f6bbd977b@linaro.org>

On Tue Oct 21, 2025 at 2:50 PM BST, Abel Vesa wrote:
> From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>
> Enable left and right speakers/tweeters on the X1E80100 Dell XPS13 9345.
>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     | 139 +++++++++++++++=
++++++
>  1 file changed, 139 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch=
/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> index 58f8caaa7258077d2c267048ca048279109ddb71..a05dfe2c51364b3ec04963590=
d9b02b9fda9f336 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> @@ -151,6 +151,50 @@ linux,cma {
>  		};
>  	};
> =20
> +	sound {
> +		compatible =3D "dell,xps13-9345-sndcard";
> +		model =3D "X1E80100-Dell-XPS-13-9345";
> +		audio-routing =3D "WooferLeft IN", "WSA WSA_SPK1 OUT",
> +				"TweeterLeft IN", "WSA WSA_SPK2 OUT",
> +				"WooferRight IN", "WSA2 WSA_SPK1 OUT",
> +				"TweeterRight IN", "WSA2 WSA_SPK2 OUT";
> +
> +		wsa-dai-link {
> +			link-name =3D "WSA Playback";
> +
> +			cpu {
> +				sound-dai =3D <&q6apmbedai WSA_CODEC_DMA_RX_0>;
> +			};
> +
> +			codec {
> +				sound-dai =3D <&left_woofer>, <&left_tweeter>,
> +					    <&swr0 0>, <&lpass_wsamacro 0>,
> +					    <&right_woofer>, <&right_tweeter>,
> +					    <&swr3 0>, <&lpass_wsa2macro 0>;
> +			};
> +
> +			platform {
> +				sound-dai =3D <&q6apm>;
> +			};
> +		};
> +
> +		va-dai-link {
> +			link-name =3D "VA Capture";
> +
> +			cpu {
> +				sound-dai =3D <&q6apmbedai VA_CODEC_DMA_TX_0>;
> +			};
> +
> +			codec {
> +				sound-dai =3D <&lpass_vamacro 0>;
> +			};
> +
> +			platform {
> +				sound-dai =3D <&q6apm>;
> +			};
> +		};
> +	};
> +
>  	vreg_edp_3p3: regulator-edp-3p3 {
>  		compatible =3D "regulator-fixed";
> =20
> @@ -415,6 +459,13 @@ vreg_bob2: bob2 {
>  			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>  		};
> =20
> +		vreg_l1b_1p8: ldo1 {
> +			regulator-name =3D "vreg_l1b_1p8";
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <1800000>;
> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>  		vreg_l2b_3p0: ldo2 {
>  			regulator-name =3D "vreg_l2b_3p0";
>  			regulator-min-microvolt =3D <3072000>;
> @@ -880,6 +931,32 @@ &iris {
>  	status =3D "okay";
>  };
> =20
> +&lpass_tlmm {
> +	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
> +		pins =3D "gpio12";
> +		function =3D "gpio";
> +		drive-strength =3D <16>;
> +		bias-disable;
> +		output-low;
> +	};
> +
> +	spkr_23_sd_n_active: spkr-23-sd-n-active-state {
> +		pins =3D "gpio13";
> +		function =3D "gpio";
> +		drive-strength =3D <16>;
> +		bias-disable;
> +		output-low;
> +	};
> +};

Recently it was adviced to remove output properties for gpio and
non-gpio functions.
For instance here: https://lore.kernel.org/linux-arm-msm/39ebaf4e-e91f-4568=
-8de6-9fc1f805a1e4@oss.qualcomm.com/

These output-low should be removed.

After that:

Reviewed-by: Alexey Klimov <alexey.klimov@linaro.org>


> +&lpass_vamacro {
> +	pinctrl-0 =3D <&dmic01_default>, <&dmic23_default>;
> +	pinctrl-names =3D "default";
> +
> +	vdd-micb-supply =3D <&vreg_l1b_1p8>;
> +	qcom,dmic-sample-rate =3D <4800000>;
> +};
> +
>  &mdss {
>  	status =3D "okay";
>  };
> @@ -1067,6 +1144,68 @@ &smb2360_1_eusb2_repeater {
>  	vdd3-supply =3D <&vreg_l14b_3p0>;
>  };
> =20
> +&swr0 {
> +	status =3D "okay";
> +
> +	pinctrl-0 =3D <&wsa_swr_active>, <&spkr_01_sd_n_active>;
> +	pinctrl-names =3D "default";
> +
> +	/* WSA8845, Left Woofer */
> +	left_woofer: speaker@0,0 {
> +		compatible =3D "sdw20217020400";
> +		reg =3D <0 0>;
> +		reset-gpios =3D <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
> +		#sound-dai-cells =3D <0>;
> +		sound-name-prefix =3D "WooferLeft";
> +		vdd-1p8-supply =3D <&vreg_l15b_1p8>;
> +		vdd-io-supply =3D <&vreg_l12b_1p2>;
> +		qcom,port-mapping =3D <1 2 3 7 10 13>;
> +	};
> +
> +	/* WSA8845, Left Tweeter */
> +	left_tweeter: speaker@0,1 {
> +		compatible =3D "sdw20217020400";
> +		reg =3D <0 1>;
> +		reset-gpios =3D <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
> +		#sound-dai-cells =3D <0>;
> +		sound-name-prefix =3D "TweeterLeft";
> +		vdd-1p8-supply =3D <&vreg_l15b_1p8>;
> +		vdd-io-supply =3D <&vreg_l12b_1p2>;
> +		qcom,port-mapping =3D <4 5 6 7 11 13>;
> +	};
> +};
> +
> +&swr3 {
> +	status =3D "okay";
> +
> +	pinctrl-0 =3D <&wsa2_swr_active>, <&spkr_23_sd_n_active>;
> +	pinctrl-names =3D "default";
> +
> +	/* WSA8845, Right Woofer */
> +	right_woofer: speaker@0,0 {
> +		compatible =3D "sdw20217020400";
> +		reg =3D <0 0>;
> +		reset-gpios =3D <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
> +		#sound-dai-cells =3D <0>;
> +		sound-name-prefix =3D "WooferRight";
> +		vdd-1p8-supply =3D <&vreg_l15b_1p8>;
> +		vdd-io-supply =3D <&vreg_l12b_1p2>;
> +		qcom,port-mapping =3D <1 2 3 7 10 13>;
> +	};
> +
> +	/* WSA8845, Right Tweeter */
> +	right_tweeter: speaker@0,1 {
> +		compatible =3D "sdw20217020400";
> +		reg =3D <0 1>;
> +		reset-gpios =3D <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
> +		#sound-dai-cells =3D <0>;
> +		sound-name-prefix =3D "TweeterRight";
> +		vdd-1p8-supply =3D <&vreg_l15b_1p8>;
> +		vdd-io-supply =3D <&vreg_l12b_1p2>;
> +		qcom,port-mapping =3D <4 5 6 7 11 13>;
> +	};
> +};
> +
>  &tlmm {
>  	gpio-reserved-ranges =3D <44 4>,  /* SPI11 (TPM) */
>  			       <76 4>,  /* SPI19 (TZ Protected) */


