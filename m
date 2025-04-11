Return-Path: <linux-kernel+bounces-599688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9CAA856DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 10:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5926E1BA05A2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 08:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EC529616A;
	Fri, 11 Apr 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s25WrjgD"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA7293B77
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361016; cv=none; b=E5EkZCrotzJvBHWU9C8LV9y3pQdKEyZVgCtQafILR9U+GqCiJvnvyL71i4n1BYdONpr2osGG8fCfNCYpgQqFhu65tRL4LuX5H1KcXb93G1nUKaAX36pU6fnw/rifbEgKVqPsCVVxna/jhFWI7t6V8oFWMOGwWdYjYR9Xv04OooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361016; c=relaxed/simple;
	bh=ieQM3Fa2DG+TOL3wCqRWS+Fh9+UNPjyV4AvtFmtTjZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZkNPgO1TSbc10gvHQNipRicG6uMANyNxSGE4dEVNTa34tfFdUd0NrPWCkzJEL3Up5BEiymPGhgTMG5nKAvTZXwX/+XP3gxJp2dKlyZMRQKEasByeRjlDHNLiyJGsXybrEmH1SacwDJ847YDwTUhZdk5+ecl1OjiWLykqckhooM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s25WrjgD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso2107442a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 01:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744361012; x=1744965812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=167NBAxwapel9/w4hU5o76Q6vm0N2JeJ45n3Xz0bAG0=;
        b=s25WrjgDZGZBRpOYqx5dbNkiNui1iCBq23+08qrze40laHYkGRPxp/cIaSUe9hP3f+
         9hX0vnqUqPPdjqZyFBZzQvmUbj2PoUxKJEJQhdM3fEkZ0QlAWTUidnWr6cOY1oVeqI/Q
         hPkJfegl1gmE1xj8T5QlspyXZXapX4AHtOMQhse71hXVACPa/cmJMLe2tdCvJhhY/+Uq
         D6VsWkSroH+4hs1shfMNaS1qSzNLBj3eaQWBJQUpNAfB6lI6TdBh6CcGVI8leKM+2ieL
         UPir3mssE1ipXFiOeaPolfCFs+6+GNHridDNnyz1oydqi893tR+1NWkYWwiljPLmSqee
         l0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744361012; x=1744965812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=167NBAxwapel9/w4hU5o76Q6vm0N2JeJ45n3Xz0bAG0=;
        b=JvoGpaC1nZuMw7e3eqcRCSS7uNRaaiAZLvnsJDQsHs2Tvlj8TA82SjRy7sVGYGaUFc
         95GqXneWn/Yz6IIBDWpyhRVUaJVZZ9wksE+AQNkIe0yGsQTGASx3+niPZ3/8FvnitJYh
         zjnu6p0XmQL8kJtBfOBKpZGG/B4ZHq6j5Fcu9foKA0XsIQ3GuNHqnoxvJwG5t8hUJaV3
         dhOt7iIsTmD39ESVaPr80chz4NyKsS8G8oMeJEfXIRgIBxhGz8NqL6UQMKH7D2NwNrGA
         SDrv8TynetG/v8gLwzx5QDVBfR7Y52ADlEAEyy85ZgQSJkVk5/LDFBs1Xx/VO/xltG5U
         CiFw==
X-Forwarded-Encrypted: i=1; AJvYcCUwl4xWgePPeZRtlWH6+EWmf7miqCPz9yjIR432aXkc6SFdIOqjoDkh9TCA058BK9MmLuTUU5n159vWl88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsN2QZNnwJJ7QkK8MzQ+E0L2Lmhr7JX7eVCQF16fGb5uv4oUEF
	HxHt0WqauDc/0CRW0W2Rd5SD37/QqcFpITqSorTfpLYMiSNswbfEFJB3xDQVDRc=
X-Gm-Gg: ASbGncs1V6QNQ32MM5fyC9DX8IRZvkLIxmzqOczxiS4+gOS0ME34AHsTrNj6FjyR1Sw
	pYfiZ0rA3SdLpQXLZyrK4v5Hw5yUyGOyAQtNgmYF7iC1wh+RTq7o4NgIGO7NZfQBJuyaVdunU+4
	lsK1kgNdGvUb6tdYN8Pu+WGBpZtU0PNdSKE2XytHaKl5IvzaFhXLYTbbpQ8E4jqzXuJKMGp5AAh
	heW/E/dnQFTqabM7IR0BNFE1/ZJjFFcVYclLvLcaA31Z+2btT+micwyu34mzyJ4BcYSDiSv2igl
	5K0bbEOXqEiMPkSlcN3jPSN0Ul8NS1oBjoTRmMCY3wtI98TKM7lgdCCIz60RLhk=
X-Google-Smtp-Source: AGHT+IFn6T/u+03XqCaTEMib8NLieFyPrI8ch7ele4xHb+XEXz8Ti8RBMogOoj3tdmlCFeXtc3lXig==
X-Received: by 2002:a05:6402:42d5:b0:5ed:1400:f879 with SMTP id 4fb4d7f45d1cf-5f37012b286mr1299928a12.32.1744361012123;
        Fri, 11 Apr 2025 01:43:32 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:9d85:9567:3e11:a24d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f52a4aasm633539a12.78.2025.04.11.01.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 01:43:30 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:43:26 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>,
	Alexey Klimov <alexey.klimov@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: Remove unnecessary MM_[UD]L audio
 routes
Message-ID: <Z_jWLq6qJuGH3sNx@linaro.org>
References: <20250411-cleanup-mm-routes-v1-1-ba98f653aa69@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-cleanup-mm-routes-v1-1-ba98f653aa69@fairphone.com>

+Cc Srini, Alexey: FYI

On Fri, Apr 11, 2025 at 10:33:29AM +0200, Luca Weiss wrote:
> Since commit 6fd8d2d275f7 ("ASoC: qcom: qdsp6: Move frontend AIFs to
> q6asm-dai") from over 4 years ago the audio routes beween MM_DL* +
> MultiMedia* Playback and MultiMedia* Capture + MM_UL* are not necessary
> anymore and can be removed from the dts files. It also helps to stop
> anyone copying these into new dts files.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Thanks, I always forgot/postponed making this cleanup. :-)

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dts          | 5 +----
>  arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts   | 5 +----
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts             | 2 --
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts             | 6 +-----
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts           | 6 +-----
>  arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 5 +----
>  arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts     | 5 +----
>  7 files changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> index e8148b3d6c50c670d6bc8045e42074162dc1c6d9..1089964e6c0d819e166fd5a959f7f1e6fe688d65 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> @@ -1012,10 +1012,7 @@ wcd9335: codec@1,0 {
>  &sound {
>  	compatible = "qcom,apq8096-sndcard";
>  	model = "DB820c";
> -	audio-routing = "RX_BIAS", "MCLK",
> -		"MM_DL1",  "MultiMedia1 Playback",
> -		"MM_DL2",  "MultiMedia2 Playback",
> -		"MultiMedia3 Capture", "MM_UL3";
> +	audio-routing = "RX_BIAS", "MCLK";
>  
>  	mm1-dai-link {
>  		link-name = "MultiMedia1";
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> index dbad8f57f2fa34575440caa7f0a19d5893efcfbb..d7fa56808747ae1290b884430d5fa5443bdd9be1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> @@ -156,10 +156,7 @@ &slpi_pil {
>  &sound {
>  	compatible = "qcom,apq8096-sndcard";
>  	model = "gemini";
> -	audio-routing = "RX_BIAS", "MCLK",
> -		"MM_DL1",  "MultiMedia1 Playback",
> -		"MM_DL2",  "MultiMedia2 Playback",
> -		"MultiMedia3 Capture", "MM_UL3";
> +	audio-routing = "RX_BIAS", "MCLK";
>  
>  	mm1-dai-link {
>  		link-name = "MultiMedia1";
> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> index d485249bcda44055689b5556eec9dd057b92d0ae..a37860175d2733214f1b257e84d5cb4821033242 100644
> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> @@ -110,8 +110,6 @@ sound {
>  		pinctrl-0 = <&lpi_i2s2_active>;
>  		pinctrl-names = "default";
>  		model = "Qualcomm-RB2-WSA8815-Speakers-DMIC0";
> -		audio-routing = "MM_DL1", "MultiMedia1 Playback",
> -				"MM_DL2", "MultiMedia2 Playback";
>  
>  		mm1-dai-link {
>  			link-name = "MultiMedia1";
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index 4cc14ab1b9ea0f92a12a12ef4df1cdc37bf5591c..dcb998b8b05498d8f9a82ff9a984c1e237a61308 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -1053,11 +1053,7 @@ &sound {
>  		"SpkrLeft IN", "WSA_SPK1 OUT",
>  		"SpkrRight IN", "WSA_SPK2 OUT",
>  		"VA DMIC0", "vdd-micb",
> -		"VA DMIC1", "vdd-micb",
> -		"MM_DL1",  "MultiMedia1 Playback",
> -		"MM_DL2",  "MultiMedia2 Playback",
> -		"MultiMedia3 Capture", "MM_UL3",
> -		"MM_DL4", "MultiMedia4 Playback";
> +		"VA DMIC1", "vdd-micb";
>  
>  	mm1-dai-link {
>  		link-name = "MultiMedia1";
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 2b2ef4dbad2fc55b27fd176baf1b4205802e1c42..adfd916270055df0a957c573868302e0d77c614d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -777,11 +777,7 @@ &quat_mi2s_sd2_active
>  		"DMIC2", "MIC BIAS3",
>  		"DMIC3", "MIC BIAS3",
>  		"SpkrLeft IN", "SPK1 OUT",
> -		"SpkrRight IN", "SPK2 OUT",
> -		"MM_DL1",  "MultiMedia1 Playback",
> -		"MM_DL2",  "MultiMedia2 Playback",
> -		"MM_DL4",  "MultiMedia4 Playback",
> -		"MultiMedia3 Capture", "MM_UL3";
> +		"SpkrRight IN", "SPK2 OUT";
>  
>  	mm1-dai-link {
>  		link-name = "MultiMedia1";
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index e8012205954e76627febda14ee51ecff9d29e4fb..7677acd08e2d176be932d3f726fe5602cf8d50d1 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -632,10 +632,7 @@ &sound {
>  		"RX_BIAS", "MCLK",
>  		"AMIC2", "MIC BIAS2",
>  		"SpkrLeft IN", "SPK1 OUT",
> -		"SpkrRight IN", "SPK2 OUT",
> -		"MM_DL1",  "MultiMedia1 Playback",
> -		"MM_DL3",  "MultiMedia3 Playback",
> -		"MultiMedia2 Capture", "MM_UL2";
> +		"SpkrRight IN", "SPK2 OUT";
>  
>  	mm1-dai-link {
>  		link-name = "MultiMedia1";
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> index 26217836c2707ba2f7b0030c9801d7de3a797315..d6d4e7184c5603864668057de79c7497ad361ab3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> @@ -445,10 +445,7 @@ &sound {
>  		"RX_BIAS", "MCLK",
>  		"AMIC2", "MIC BIAS2",
>  		"SpkrLeft IN", "SPK1 OUT",
> -		"SpkrRight IN", "SPK2 OUT",
> -		"MM_DL1",  "MultiMedia1 Playback",
> -		"MM_DL3",  "MultiMedia3 Playback",
> -		"MultiMedia2 Capture", "MM_UL2";
> +		"SpkrRight IN", "SPK2 OUT";
>  
>  	mm1-dai-link {
>  		link-name = "MultiMedia1";
> 
> ---
> base-commit: 01c6df60d5d4ae00cd5c1648818744838bba7763
> change-id: 20250411-cleanup-mm-routes-7b9e92962553
> 
> Best regards,
> -- 
> Luca Weiss <luca.weiss@fairphone.com>
> 

