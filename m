Return-Path: <linux-kernel+bounces-725348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4184AFFDED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1F54A335F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555BC29291F;
	Thu, 10 Jul 2025 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v+YMGXPU"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB922330F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139223; cv=none; b=lZRPFecZM9Ou43XrleW+6EI/IUfxSJ0n1HF854z/GELcDK8BituJAbAiBJiM8nVh4phfkwcWzjOKxdHIi8wNrGeZH+hAdDceVtCgHEFyDWqB95DQnjTb8OsXklDVU7wLeiUOtv3TPWIdTe1lw0h9vi1y5XdG8Qb3Mku2qW/9rWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139223; c=relaxed/simple;
	bh=Cya7dvqz1Z8A1Vbg/Zh688QXobU4/mVhyUsz/szzmqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BMAPwp3yGYyrgUFvXWpvgaknneZBS2BJA7iZZAz1JcdQT7GDlLDViRGEmzdBguK78GScNOliYGI+uCCAu9XVOH31mrlbrixNNe/8St6vyWMbri9mLwslZBbTB/jogJq4jW50XYN8BG58b3sFdJBYPwBBRmcSMCCtE86HMMf/vxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v+YMGXPU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ab112dea41so441614f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752139219; x=1752744019; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SUuAt9yoULAsrC8c3pYmkWi5uj4/OLlfz9YbcHuy4x0=;
        b=v+YMGXPUFwTOOyKxVpOnTX1QLRMe4ehGTrL061C9D3aslZMg2G6sI5XSGDICngpeS4
         XerGKLnHsFtUo4YJXjen4CyCWhudyhLXXOtlTcLhJed8IxK3aPR8hWcA7dmoVuMV5//h
         D7CLzG/+7sqSJ99eLpoyBhQfpUqZRhQpn5/badSYx4Cc2kxBfLw7lZKviYcKPT9sv8iw
         QH88QfJ3HzX2ICwapCQLedNC6R7LioOAhuma3fy+4nNf4LnfPkSo3kc4ql7YpzktCBss
         QeLcsskTSW1ft+AZ8afW/EOYFBwxgDo4I1PfeDoH0WTylEHYsrjKeRZgNY1A5X2Go9GZ
         VA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752139219; x=1752744019;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUuAt9yoULAsrC8c3pYmkWi5uj4/OLlfz9YbcHuy4x0=;
        b=iSY6SVkHjiWRtgYTkpuM/6zxQMUmWmcrRwup9q+StF0F18AdA+H9zM7z4TBPsvKNxu
         3CXGSp0af6sZKjhXubPkgBIxzKC0nZ0UgaUQoIp1AMWlD/nf2y5BMAFLhjb1Ce8peXHz
         atdpBuTLqbB1NbcbRxLokE4wKC7J08BedBFQsoT3zLr5IjucDQg7OgRvGOkTNONxAxtZ
         JJwAYrY6Cm/UwLGmPt7bckJlmm3/ZZ1ucH2g+OwccGpTEBuOeRv71yAC34AZOruJ5Rb6
         w4QY1a4iBPPjBNxswbNyRgcGbHT4c+w+b4Us9xpPsyEWsVRqfHg5VXJwoT7TWnJGKWaV
         kP6w==
X-Forwarded-Encrypted: i=1; AJvYcCUC16vu8O6RVXGNvLzdcJM9DE1Q5kHfx406a5shzNRthUNr+UPdmiKMW1cWk+o+QK9ilMFEIxEFMFN/mJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8ERXdQb0q3MTxbFmomJkp8basuvA0pQlCd7RnfmC0ZaOlR+e
	U4MsMsynVHak/2QFeMRxX9Xs6q1Tm+TDQXDCrh0YDOENK0LYBdyB32lXRcnV+nmi0XU=
X-Gm-Gg: ASbGncvFBqYeTxY3NGDVBJjqvvtPKhld7bQj+KbGMIGMu6UI15SPfQ0FOA19wRZTdE6
	aRGfTcTFoI3sE0tTJ3budBLUJs0YBpJwcOinywwLrf3Uy3erg4kcVQSQ5l+2vfVEyv7bX/l89ig
	NAWxZCG5cEPzpk/QgHxSo17CFOmJlBRi3eGRzVn7W3Ua5PYrFu+0u8KgTx7FSsS3IGbP3oVQOXY
	cVvP+LWfDoWNh7BUdl+kfv93OggI19XLj1nefVxUCVdqzyWJ/nvmAP9L/hAYnNfhUYwdscrrd/H
	GcmweiaqCsv9NgEtHIyolvU3N5T8RDYSAlh5Hffp418vJDKHH0vsdLyNWFuTY3x/Vqc1Vp73
X-Google-Smtp-Source: AGHT+IE16GuOL1cK5fdl7Mr+ZvhesNcygvCIn3ibXh5yxUYyDaGsn57tDGrfSvUMLHrhy1OqBFoJJw==
X-Received: by 2002:a05:6000:25c1:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3b5e453e795mr5404777f8f.53.1752139218654;
        Thu, 10 Jul 2025 02:20:18 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:9fcc:5953:3d1a:6b41])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454d5103082sm51043555e9.29.2025.07.10.02.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 02:20:18 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>,
  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,
  jiebing.chen@amlogic.com,  linux-sound@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org,  jian.xu@amlogic.com,  shuai.li@amlogic.com,
  zhe.wang@amlogic.com
Subject: Re: [PATCH v5 6/6] arm64: dts: amlogic: Add Amlogic S4 Audio
In-Reply-To: <20250710-audio_drvier-v5-6-d4155f1e7464@amlogic.com> (jiebing
	chen via's message of "Thu, 10 Jul 2025 11:35:42 +0800")
References: <20250710-audio_drvier-v5-0-d4155f1e7464@amlogic.com>
	<20250710-audio_drvier-v5-6-d4155f1e7464@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 10 Jul 2025 11:20:17 +0200
Message-ID: <1jzfdcpfla.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 10 Jul 2025 at 11:35, jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org> wrote:

> From: jiebing chen <jiebing.chen@amlogic.com>
>
> Add basic audio driver support for the Amlogic S4 based
> Amlogic AQ222 board.
>
> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
> ---
>  .../boot/dts/amlogic/meson-s4-s805x2-aq222.dts     | 218 ++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi          | 387 +++++++++++++++++++++
>  2 files changed, 605 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> index 6730c44642d2910d42ec0c4adf49fefc3514dbec..47c6b8d63fdfca01281f0935f3dc419af6d86a25 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> @@ -75,6 +75,19 @@ vddio_ao1v8: regulator-vddio-ao1v8 {
>  	       regulator-always-on;
>  	};
>  
> +	vcc5v_reg: regulator-vcc-5v {
> +		compatible = "regulator-fixed";
> +		vin-supply = <&main_12v>;
> +		regulator-name = "VCC5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio GPIOH_7 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <7000>;
> +		enable-active-high;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>  	/* SY8120B1ABC DC/DC Regulator. */
>  	vddcpu: regulator-vddcpu {
>  		compatible = "pwm-regulator";
> @@ -129,6 +142,211 @@ vddcpu: regulator-vddcpu {
>  				<699000 98>,
>  				<689000 100>;
>  	};
> +	dmics: audio-codec-1 {
> +		compatible = "dmic-codec";
> +		#sound-dai-cells = <0>;
> +		num-channels = <2>;
> +		wakeup-delay-ms = <50>;
> +		sound-name-prefix = "MIC";
> +	};
> +
> +	dioo2133: audio-amplifier-0 {
> +		compatible = "simple-audio-amplifier";
> +		enable-gpios = <&gpio GPIOH_8 GPIO_ACTIVE_HIGH>;
> +		VCC-supply = <&vcc5v_reg>;
> +		sound-name-prefix = "10U2";
> +	};
> +
> +	spdif_dir: audio-spdif-in {
> +		compatible = "linux,spdif-dir";
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "DIR";
> +	};
> +
> +	spdif_dit: audio-spdif-out {
> +		compatible = "linux,spdif-dit";
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "DIT";
> +	};
> +
> +	sound {
> +		compatible = "amlogic,axg-sound-card";
> +		model = "aq222";
> +		audio-widgets = "Line", "Lineout";
> +		audio-aux-devs = <&tdmout_a>, <&tdmout_b>, <&tdmout_c>,
> +				 <&tdmin_a>, <&tdmin_b>, <&tdmin_c>,
> +				 <&tdmin_lb>, <&dioo2133>;
> +		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
> +				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
> +				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
> +				"TDM_A Playback", "TDMOUT_A OUT",
> +				"TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> +				"TDM_B Playback", "TDMOUT_B OUT",
> +				"TDMOUT_C IN 0", "FRDDR_A OUT 2",
> +				"TDMOUT_C IN 1", "FRDDR_B OUT 2",
> +				"TDMOUT_C IN 2", "FRDDR_C OUT 2",
> +				"TDM_C Playback", "TDMOUT_C OUT",
> +				"SPDIFOUT_A IN 0", "FRDDR_A OUT 3",
> +				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
> +				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3",
> +				"SPDIFOUT_B IN 0", "FRDDR_A OUT 4",
> +				"SPDIFOUT_B IN 1", "FRDDR_B OUT 4",
> +				"SPDIFOUT_B IN 2", "FRDDR_C OUT 4",
> +				"TDMIN_A IN 0", "TDM_A Capture",
> +				"TDMIN_A IN 1", "TDM_B Capture",
> +				"TDMIN_A IN 2", "TDM_C Capture",
> +				"TDMIN_A IN 3", "TDM_A Loopback",
> +				"TDMIN_A IN 4", "TDM_B Loopback",
> +				"TDMIN_A IN 5", "TDM_C Loopback",
> +				"TDMIN_B IN 0", "TDM_A Capture",
> +				"TDMIN_B IN 1", "TDM_B Capture",
> +				"TDMIN_B IN 2", "TDM_C Capture",
> +				"TDMIN_B IN 3", "TDM_A Loopback",
> +				"TDMIN_B IN 4", "TDM_B Loopback",
> +				"TDMIN_B IN 5", "TDM_C Loopback",
> +				"TDMIN_C IN 0", "TDM_A Capture",
> +				"TDMIN_C IN 1", "TDM_B Capture",
> +				"TDMIN_C IN 2", "TDM_C Capture",
> +				"TDMIN_C IN 3", "TDM_A Loopback",
> +				"TDMIN_C IN 4", "TDM_B Loopback",
> +				"TDMIN_C IN 5", "TDM_C Loopback",
> +				"TDMIN_LB IN 3", "TDM_A Capture",
> +				"TDMIN_LB IN 4", "TDM_B Capture",
> +				"TDMIN_LB IN 5", "TDM_C Capture",
> +				"TDMIN_LB IN 0", "TDM_A Loopback",
> +				"TDMIN_LB IN 1", "TDM_B Loopback",
> +				"TDMIN_LB IN 2", "TDM_C Loopback",
> +				"TODDR_A IN 0", "TDMIN_A OUT",
> +				"TODDR_B IN 0", "TDMIN_A OUT",
> +				"TODDR_C IN 0", "TDMIN_A OUT",
> +				"TODDR_A IN 1", "TDMIN_B OUT",
> +				"TODDR_B IN 1", "TDMIN_B OUT",
> +				"TODDR_C IN 1", "TDMIN_B OUT",
> +				"TODDR_A IN 2", "TDMIN_C OUT",
> +				"TODDR_B IN 2", "TDMIN_C OUT",
> +				"TODDR_C IN 2", "TDMIN_C OUT",
> +				"TODDR_A IN 3", "SPDIFIN Capture",
> +				"TODDR_B IN 3", "SPDIFIN Capture",
> +				"TODDR_C IN 3", "SPDIFIN Capture",
> +				"TODDR_A IN 6", "TDMIN_LB OUT",
> +				"TODDR_B IN 6", "TDMIN_LB OUT",
> +				"TODDR_C IN 6", "TDMIN_LB OUT",
> +				"10U2 INL", "ACODEC LOLP",
> +				"10U2 INR", "ACODEC LORP",
> +				"Lineout", "10U2 OUTL",
> +				"Lineout", "10U2 OUTR";
> +		assigned-clocks = <&clkc_pll CLKID_HIFI_PLL>,
> +				  <&clkc_pll CLKID_MPLL0>,
> +				  <&clkc_pll CLKID_MPLL1>;
> +		assigned-clock-rates = <1179648000>,
> +				       <270950400>,
> +				       <338688000>;
> +
> +		dai-link-0 {
> +			sound-dai = <&frddr_a>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&frddr_b>;
> +		};
> +
> +		dai-link-2 {
> +			sound-dai = <&frddr_c>;
> +		};
> +
> +		dai-link-3 {
> +			sound-dai = <&toddr_a>;
> +		};
> +
> +		dai-link-4 {
> +			sound-dai = <&toddr_b>;
> +		};
> +
> +		dai-link-5 {
> +			sound-dai = <&toddr_c>;
> +		};
> +
> +		dai-link-6 {
> +			sound-dai = <&tdmif_a>;
> +			dai-format = "i2s";
> +			dai-tdm-slot-tx-mask-0 = <1 1>;
> +			mclk-fs = <256>;
> +			codec-0 {
> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
> +			};
> +			codec-1 {
> +				sound-dai = <&toacodec TOACODEC_IN_A>;
> +			};
> +		};
> +
> +		dai-link-7 {
> +			sound-dai = <&tdmif_b>;
> +			dai-format = "i2s";
> +			dai-tdm-slot-tx-mask-0 = <1 1>;
> +			mclk-fs = <256>;
> +			codec-0 {
> +				sound-dai = <&toacodec TOACODEC_IN_B>;
> +			};
> +			codec-1 {
> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
> +			};
> +		};
> +
> +		/* 8ch HDMI interface */
> +		dai-link-8 {
> +			sound-dai = <&tdmif_c>;
> +			dai-format = "i2s";
> +			dai-tdm-slot-tx-mask-0 = <1 1>;
> +			dai-tdm-slot-tx-mask-1 = <1 1>;
> +			dai-tdm-slot-tx-mask-2 = <1 1>;
> +			dai-tdm-slot-tx-mask-3 = <1 1>;
> +			mclk-fs = <256>;
> +			codec-0 {
> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_C>;
> +			};
> +		};
> +
> +		/* spdif hdmi and coax output */
> +		dai-link-9 {
> +			sound-dai = <&spdifout_a>;
> +
> +			codec-0 {
> +				sound-dai = <&spdif_dit>;
> +			};
> +
> +			codec-1 {
> +				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_A>;
> +			};
> +		};
> +
> +		/* spdif hdmi interface */
> +		dai-link-10 {
> +			sound-dai = <&spdifout_b>;
> +
> +			codec {
> +				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_B>;
> +			};
> +		};
> +
> +		/* spdif coax input */
> +		dai-link-11 {
> +			sound-dai = <&spdifin>;
> +
> +			codec {
> +				sound-dai = <&spdif_dir>;
> +			};
> +		};
> +
> +		dai-link-12 {
> +			sound-dai = <&toacodec TOACODEC_OUT>;
> +
> +			codec {
> +				sound-dai = <&acodec>;
> +			};
> +		};
> +	};
>  };
>  
>  &pwm_ef {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index 957577d986c0675a503115e1ccbc4387c2051620..3af2fb333cf7b1ca35f1ff7ad8479bcd859e608a 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -11,6 +11,11 @@
>  #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>  #include <dt-bindings/power/meson-s4-power.h>
>  #include <dt-bindings/reset/amlogic,meson-s4-reset.h>
> +#include <dt-bindings/clock/axg-audio-clkc.h>
> +#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
> +#include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
> +#include <dt-bindings/sound/meson-g12a-toacodec.h>
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>  
>  / {
>  	cpus {
> @@ -849,4 +854,386 @@ emmc: mmc@fe08c000 {
>  			status = "disabled";
>  		};
>  	};
> +
> +	tdmif_a: audio-controller-0 {
> +		compatible = "amlogic,axg-tdm-iface";
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "TDM_A";
> +		clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
> +			 <&clkc_audio AUD_CLKID_MST_A_LRCLK>,
> +			 <&clkc_audio AUD_CLKID_MST_A_MCLK>;
> +		clock-names = "sclk", "lrclk","mclk";
> +	};
> +
> +	tdmif_b: audio-controller-1 {
> +		compatible = "amlogic,axg-tdm-iface";
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "TDM_B";
> +		clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
> +			 <&clkc_audio AUD_CLKID_MST_B_LRCLK>,
> +			 <&clkc_audio AUD_CLKID_MST_B_MCLK>;
> +		clock-names = "sclk", "lrclk","mclk";
> +	};
> +
> +	tdmif_c: audio-controller-2 {
> +		compatible = "amlogic,axg-tdm-iface";
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "TDM_C";
> +		clocks = <&clkc_audio AUD_CLKID_MST_C_SCLK>,
> +			 <&clkc_audio AUD_CLKID_MST_C_LRCLK>,
> +			 <&clkc_audio AUD_CLKID_MST_C_MCLK>;
> +		clock-names = "sclk", "lrclk","mclk";
> +	};
> +};
> +
> +&apb4 {
> +	acodec: audio-controller@1a000 {
> +		compatible = "amlogic,t9015";
> +		reg = <0x0 0x1A000 0x0 0x14>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "ACODEC";
> +		clocks = <&clkc_periphs CLKID_ACODEC>;
> +		clock-names = "pclk";
> +		resets = <&reset RESET_ACODEC>;
> +		AVDD-supply = <&vddio_ao1v8>;
> +	};
> +
> +	clkc_audio: clock-controller@330000 {
> +		compatible = "amlogic,s4-audio-clkc";
> +		reg = <0x0 0x330000 0x0 0xd8>,
> +			  <0x0 0x330e80 0x0 0x10>;
> +		#clock-cells = <1>;
> +		#reset-cells = <1>;
> +		power-domains = <&pwrc PWRC_S4_AUDIO_ID>;
> +		clocks = <&clkc_periphs CLKID_AUDIO>,
> +			 <&clkc_pll CLKID_MPLL0>,
> +			 <&clkc_pll CLKID_MPLL1>,
> +			 <&clkc_pll CLKID_MPLL2>,
> +			 <&clkc_pll CLKID_MPLL3>,
> +			 <&clkc_pll CLKID_HIFI_PLL>,
> +			 <&clkc_pll CLKID_FCLK_DIV3>,
> +			 <&clkc_pll CLKID_FCLK_DIV4>,
> +			 <&clkc_pll CLKID_FCLK_DIV5>;
> +		clock-names = "pclk",
> +				  "mst_in0",
> +				  "mst_in1",
> +				  "mst_in2",
> +				  "mst_in3",
> +				  "mst_in4",
> +				  "mst_in5",
> +				  "mst_in6",
> +				  "mst_in7";
> +
> +		resets = <&reset RESET_AUDIO>;
> +	};
> +
> +	clock-controller@330e80 {
> +		compatible = "amlogic,clock-pads-clkc";
> +		reg = <0x0 0x330e80 0x0 0x10>;
> +		#clock-cells = <1>;
> +		power-domains = <&pwrc PWRC_S4_AUDIO_ID>;
> +		clocks = <&clkc_periphs CLKID_AUDIO>,
> +			 <&clkc_pll CLKID_MPLL0>,
> +			 <&clkc_pll CLKID_MPLL1>,
> +			 <&clkc_pll CLKID_MPLL2>,
> +			 <&clkc_pll CLKID_MPLL3>,
> +			 <&clkc_pll CLKID_HIFI_PLL>,
> +			 <&clkc_pll CLKID_FCLK_DIV3>,
> +			 <&clkc_pll CLKID_FCLK_DIV4>,
> +			 <&clkc_pll CLKID_FCLK_DIV5>;
> +		clock-names = "pclk",
> +				  "mst_in0",
> +				  "mst_in1",
> +				  "mst_in2",
> +				  "mst_in3",
> +				  "mst_in4",
> +				  "mst_in5",
> +				  "mst_in6",
> +				  "mst_in7";

Assuming I understood where you are tyring to go with this, those are
not the input in of this clock controller. The only reason *may* have
worked is because you referenced the clock by names instead of fwname

> +	};
> +
> +	toddr_a: audio-controller@330100 {
> +		compatible = "amlogic,sm1-toddr",
> +				 "amlogic,axg-toddr";
> +		reg = <0x0 0x330100 0x0 0x2c>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "TODDR_A";
> +		interrupts = <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkc_audio AUD_CLKID_TODDR_A>;
> +		resets = <&arb AXG_ARB_TODDR_A>,
> +			 <&clkc_audio AUD_RESET_TODDR_A>;
> +		reset-names = "arb", "rst";
> +		amlogic,fifo-depth = <8192>;
> +	};
> +
> +	toddr_b: audio-controller@330140 {
> +		compatible = "amlogic,sm1-toddr",
> +				 "amlogic,axg-toddr";
> +		reg = <0x0 0x330140 0x0 0x2c>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "TODDR_B";
> +		interrupts = <GIC_SPI 33 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkc_audio AUD_CLKID_TODDR_B>;
> +		resets = <&arb AXG_ARB_TODDR_B>,
> +			 <&clkc_audio AUD_RESET_TODDR_B>;
> +		reset-names = "arb", "rst";
> +		amlogic,fifo-depth = <256>;
> +	};
> +
> +	toddr_c: audio-controller@330180 {
> +		compatible = "amlogic,sm1-toddr",
> +				 "amlogic,axg-toddr";
> +		reg = <0x0 0x330180 0x0 0x2c>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "TODDR_C";
> +		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkc_audio AUD_CLKID_TODDR_C>;
> +		resets = <&arb AXG_ARB_TODDR_C>,
> +			 <&clkc_audio AUD_RESET_TODDR_C>;
> +		reset-names = "arb", "rst";
> +		amlogic,fifo-depth = <256>;
> +	};
> +
> +	frddr_a: audio-controller@3301c0 {
> +		compatible = "amlogic,sm1-frddr",
> +				 "amlogic,axg-frddr";
> +		reg = <0x0 0x3301c0 0x0 0x2c>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "FRDDR_A";
> +		interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
> +		resets = <&arb AXG_ARB_FRDDR_A>,
> +			 <&clkc_audio AUD_RESET_FRDDR_A>;
> +		reset-names = "arb", "rst";
> +		amlogic,fifo-depth = <512>;
> +	};
> +
> +	frddr_b: audio-controller@330200 {
> +		compatible = "amlogic,sm1-frddr",
> +				 "amlogic,axg-frddr";
> +		reg = <0x0 0x330200 0x0 0x2c>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "FRDDR_B";
> +		interrupts = <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkc_audio AUD_CLKID_FRDDR_B>;
> +		resets = <&arb AXG_ARB_FRDDR_B>,
> +			 <&clkc_audio AUD_RESET_FRDDR_B>;
> +		reset-names = "arb", "rst";
> +		amlogic,fifo-depth = <256>;
> +	};
> +
> +	frddr_c: audio-controller@330240 {
> +		compatible = "amlogic,sm1-frddr",
> +				 "amlogic,axg-frddr";
> +		reg = <0x0 0x330240 0x0 0x2c>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "FRDDR_C";
> +		interrupts = <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkc_audio AUD_CLKID_FRDDR_C>;
> +		resets = <&arb AXG_ARB_FRDDR_C>,
> +			 <&clkc_audio AUD_RESET_FRDDR_C>;
> +		reset-names = "arb", "rst";
> +		amlogic,fifo-depth = <256>;
> +	};
> +
> +	arb: reset-controller@330280 {
> +		compatible = "amlogic,meson-sm1-audio-arb";
> +		reg = <0x0 0x330280 0x0 0x4>;
> +		#reset-cells = <1>;
> +		clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
> +	};
> +
> +	tdmin_a: audio-controller@330300 {
> +		compatible = "amlogic,sm1-tdmin";
> +		reg = <0x0 0x330300 0x0 0x40>;
> +		sound-name-prefix = "TDMIN_A";
> +		resets = <&clkc_audio AUD_RESET_TDMIN_A>;
> +		clocks = <&clkc_audio AUD_CLKID_TDMIN_A>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK_SEL>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>;
> +		clock-names = "pclk", "sclk", "sclk_sel",
> +				  "lrclk", "lrclk_sel";
> +	};
> +
> +	tdmin_b: audio-controller@330340 {
> +		compatible = "amlogic,sm1-tdmin";
> +		reg = <0x0 0x330340 0x0 0x40>;
> +		sound-name-prefix = "TDMIN_B";
> +		resets = <&clkc_audio AUD_RESET_TDMIN_B>;
> +		clocks = <&clkc_audio AUD_CLKID_TDMIN_B>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK_SEL>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>;
> +		clock-names = "pclk", "sclk", "sclk_sel",
> +				  "lrclk", "lrclk_sel";
> +	};
> +
> +	tdmin_c: audio-controller@330380 {
> +		compatible = "amlogic,sm1-tdmin";
> +		reg = <0x0 0x330380 0x0 0x40>;
> +		sound-name-prefix = "TDMIN_C";
> +		resets = <&clkc_audio AUD_RESET_TDMIN_C>;
> +		clocks = <&clkc_audio AUD_CLKID_TDMIN_C>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK_SEL>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>;
> +		clock-names = "pclk", "sclk", "sclk_sel",
> +				  "lrclk", "lrclk_sel";
> +	};
> +
> +	tdmin_lb: audio-controller@3303c0 {
> +		compatible = "amlogic,sm1-tdmin";
> +		reg = <0x0 0x3303c0 0x0 0x40>;
> +		sound-name-prefix = "TDMIN_LB";
> +		resets = <&clkc_audio AUD_RESET_TDMIN_LB>;
> +		clocks = <&clkc_audio AUD_CLKID_TDMIN_LB>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK_SEL>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>;
> +		clock-names = "pclk", "sclk", "sclk_sel",
> +				  "lrclk", "lrclk_sel";
> +	};
> +
> +	spdifin: audio-controller@330400 {
> +		compatible = "amlogic,g12a-spdifin",
> +				 "amlogic,axg-spdifin";
> +		reg = <0x0 0x330400 0x0 0x30>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "SPDIFIN";
> +		interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
> +		<&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
> +		clock-names = "pclk", "refclk";
> +		resets = <&clkc_audio AUD_RESET_SPDIFIN>;
> +	};
> +
> +	spdifout_a: audio-controller@330480 {
> +		compatible = "amlogic,g12a-spdifout",
> +				 "amlogic,axg-spdifout";
> +		reg = <0x0 0x330480 0x0 0x50>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "SPDIFOUT_A";
> +		clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
> +		<&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
> +		clock-names = "pclk", "mclk";
> +		resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
> +	};
> +
> +	tdmout_a: audio-controller@330500 {
> +		compatible = "amlogic,sm1-tdmout";
> +		reg = <0x0 0x330500 0x0 0x40>;
> +		sound-name-prefix = "TDMOUT_A";
> +		resets = <&clkc_audio AUD_RESET_TDMOUT_A>;
> +		clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
> +			 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
> +			 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
> +		clock-names = "pclk", "sclk", "sclk_sel",
> +				  "lrclk", "lrclk_sel";
> +	};
> +
> +	tdmout_b: audio-controller@330540 {
> +		compatible = "amlogic,sm1-tdmout";
> +		reg = <0x0 0x330540 0x0 0x40>;
> +		sound-name-prefix = "TDMOUT_B";
> +		resets = <&clkc_audio AUD_RESET_TDMOUT_B>;
> +		clocks = <&clkc_audio AUD_CLKID_TDMOUT_B>,
> +			 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK_SEL>,
> +			 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>;
> +		clock-names = "pclk", "sclk", "sclk_sel",
> +				  "lrclk", "lrclk_sel";
> +	};
> +
> +	tdmout_c: audio-controller@330580 {
> +		compatible = "amlogic,sm1-tdmout";
> +		reg = <0x0 0x330580 0x0 0x40>;
> +		sound-name-prefix = "TDMOUT_C";
> +		resets = <&clkc_audio AUD_RESET_TDMOUT_C>;
> +		clocks = <&clkc_audio AUD_CLKID_TDMOUT_C>,
> +			 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK_SEL>,
> +			 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>,
> +			 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>;
> +		clock-names = "pclk", "sclk", "sclk_sel",
> +				  "lrclk", "lrclk_sel";
> +	};
> +
> +	spdifout_b: audio-controller@330680 {
> +		compatible = "amlogic,g12a-spdifout",
> +				 "amlogic,axg-spdifout";
> +		reg = <0x0 0x330680 0x0 0x50>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "SPDIFOUT_B";
> +		clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
> +			 <&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
> +		clock-names = "pclk", "mclk";
> +		resets = <&clkc_audio AUD_RESET_SPDIFOUT_B>;
> +	};
> +
> +	toacodec: audio-controller@330740 {
> +		compatible = "amlogic,s4-toacodec",
> +				 "amlogic,g12a-toacodec";
> +		reg = <0x0 0x330740 0x0 0x4>;
> +		sound-name-prefix = "TOACODEC";
> +		#sound-dai-cells = <1>;
> +		resets = <&clkc_audio AUD_RESET_TOACODEC>;
> +	};
> +
> +	tohdmitx: audio-controller@330744 {
> +		compatible = "amlogic,sm1-tohdmitx",
> +				 "amlogic,g12a-tohdmitx";
> +		reg = <0x0 0x330744 0x0 0x4>;
> +		#sound-dai-cells = <1>;
> +		sound-name-prefix = "TOHDMITX";
> +		resets = <&clkc_audio AUD_RESET_TOHDMITX>;
> +	};
> +
> +	toddr_d: audio-controller@330840 {
> +		compatible = "amlogic,sm1-toddr",
> +				 "amlogic,axg-toddr";
> +		reg = <0x0 0x330840 0x0 0x2c>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "TODDR_D";
> +		interrupts = <GIC_SPI 45 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkc_audio AUD_CLKID_TODDR_D>;
> +		resets = <&arb AXG_ARB_TODDR_D>,
> +			 <&clkc_audio AUD_RESET_TODDR_D>;
> +		reset-names = "arb", "rst";
> +		amlogic,fifo-depth = <256>;
> +	};
> +
> +	frddr_d: audio-controller@330880 {
> +		 compatible = "amlogic,sm1-frddr",
> +				  "amlogic,axg-frddr";
> +		reg = <0x0 0x330880 0x0 0x2c>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "FRDDR_D";
> +		interrupts = <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkc_audio AUD_CLKID_FRDDR_D>;
> +		resets = <&arb AXG_ARB_FRDDR_D>,
> +			 <&clkc_audio AUD_RESET_FRDDR_D>;
> +		reset-names = "arb", "rst";
> +		amlogic,fifo-depth = <256>;
> +	};
> +
> +	pdm: audio-controller@331000 {
> +		compatible = "amlogic,sm1-pdm",
> +			     "amlogic,axg-pdm";
> +		reg = <0x0 0x331000 0x0 0x34>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "PDM";
> +		clocks = <&clkc_audio AUD_CLKID_PDM>,
> +			 <&clkc_audio AUD_CLKID_PDM_DCLK>,
> +			 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
> +		clock-names = "pclk", "dclk", "sysclk";
> +		resets = <&clkc_audio AUD_RESET_PDM>;
> +	};
>  };

-- 
Jerome

