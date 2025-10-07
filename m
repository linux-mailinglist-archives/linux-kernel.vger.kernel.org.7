Return-Path: <linux-kernel+bounces-843675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2638CBBFF80
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC9754E4A00
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177ED82866;
	Tue,  7 Oct 2025 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzcTr2ud"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6FC1CCEE0
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800944; cv=none; b=bP/D6octLOM4Z+Y246DcxND27TvTS8D/0JHmag0xQlbcTOuppwtibZ1LSfT6Qi0iMbiX76mGcmfAjtUjwPyhGrusNrImdgwJOCh6k8f61svNA11GT/+1AUv32YsQxUWNT/8oNIG5Q8BGbLwMC8H3vujbkTLRBbSuzsJ2Rn9j3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800944; c=relaxed/simple;
	bh=dSFf1E/J7CDTNdjk+dI/Pn6eRQ1aAq+eFCYCegQhb+0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sZxOJllzf4KDZA1uCZ1j9tg6r3d5ZEPlt03SSho2/uoz5r29C52OHOKakD8tkdjtiZ5lnuCO7CV+AcSJ2uT3VetrJ6wGD3f5EOMSQoMU4zOqOhje2X1RbJCf5z+MkKqDEGO+th+oPlhuJT9ywqqRtQTcUjIx8wVXFByGkpG0GZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VzcTr2ud; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so61447695e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 18:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759800941; x=1760405741; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji+JD5QBQH6eDTa+kxfbkvWxEhikk+fAOwvZw23zzwY=;
        b=VzcTr2udTjA3MDdRH+KJrmifXi4DBDEqU3uQoIzZ9b0yX/+8GSbuOtiORwWHrYXRHM
         XZcZvbnXy/22Y4MKQ6Kw2fluzLqM0hBXpTvjTBmslNa/h4UEb9sw/jddKdhmFiceuPRM
         bVRx73bHpWJmltQ2jTU1mwqHxZ0sB1AjbHRbTSLMCqzeJCLQxY8qt/G2k6y0nOp2aUTJ
         3i9CVwbp55vsRVViHMYGRcesI4Ypa7tfu9KIsVCdpwC9Fag84TMLjZS25UJThDX8GD4k
         Dbw0+QyBbbNVUJywR0R4HLjxaD7aa6HpVBJrQbELiFozIN0mjujYF9d2ETa4RvrImji9
         C3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759800941; x=1760405741;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ji+JD5QBQH6eDTa+kxfbkvWxEhikk+fAOwvZw23zzwY=;
        b=jlefCHzKBnSboDn9u3zUJBu7Mb3jy/jO5FTGNxq+OWFnCqBbanfzKbD4s6raDWNsvn
         lhWkb8Y+1BtAj0O6+kgIOo7hkZl3d3ZEX107t2c86er0UucG+hkHWaIslgLxXxPLNEio
         fXP+WHdIJfGgyVJSAGb3sUca6lsGiMGHW9APXUThlR/fqiGqGVkzkRLdypkD4JcRNYAb
         EGXK2e2+5r4wfewJJ/cVMD+92ZLV8JYy3CbuU5OkOn84HYx59fDHmDRJQAIox2EyAcF8
         1+1BBpoG0J3JYogoKgZQ4oLc9OXUo4jqdLLgOdpn8COVs1LFboo0tu2/TMOw694nrSzo
         uGeg==
X-Forwarded-Encrypted: i=1; AJvYcCXzZ2BwK1QIYHQ23pckbdnHY6qcFSN9gyn3wp1ad30VHCFME9+yOvG+yjJwwZKK0SSpbWzWGtl6xCOGeJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsTnGp+voork0XBcbvn5ZdHmdkMMGgSKfgduhKrDavroXlxsAi
	wS/DCppDIoECB0Wlio3dIsrid0GrgmQRr04ki2Z9Cxg/ZA2KWxOMddyQBvN01Nrc5jc=
X-Gm-Gg: ASbGncswxzGrHAMPIBpGOSJZQtUOrhLCgfrEu1NG3ORKNwMgk+Zs7UyUmvyG90+eRWo
	tG4JtAUkdbrn/+DmrR+KzMk8Ci8Vsqdnlx2VPK4KCZtcx+xuCkTrsfR7SVhulGLf0QVaFDfjuX2
	OO6Od5x0YCEposS87wlHsvBsZEN7XOoErkdrn2xueUZvF4YSwTPlT1SJPYR9f5v7LQNX+/ij1rv
	m+qwk1k5Bl2dYZpgJ5GK1vs45cPhpRVaPkynqZV3sCSVKvIzAQrtLSIzMMvKdaU3vBCR+am/78Z
	GwwuiN26X2D35Lrvwj5ojaOBr7FHqXX+zuetrctGwrayDaqNzg1h5BF8/jxziQ8WeNHeyIErIXI
	A7YYKsny6/GS4VLRKnXZheE09ruDVKVGTUISCFFD2GVbhtJxBeUHNxBiKz58BlOezOw==
X-Google-Smtp-Source: AGHT+IGxegk5zS/vcDYXOHgkLn6TGJ/oSEBKxXzqmzD05DR2WTUPLYfCcOojl3EbamxexC7GUdL3oA==
X-Received: by 2002:a05:600c:8b6e:b0:46e:4499:ba30 with SMTP id 5b1f17b1804b1-46e71153ad0mr112226515e9.30.1759800940679;
        Mon, 06 Oct 2025 18:35:40 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:22ae:baa0:7d1a:8c1f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa2d5bd52sm7679105e9.2.2025.10.06.18.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 18:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Oct 2025 02:35:38 +0100
Message-Id: <DDBPDACTUFEW.1VVHN1P0PC6YO@linaro.org>
Cc: "Srinivas Kandagatla" <srini@kernel.org>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Jaroslav Kysela"
 <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, <linux-sound@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC 3/6] ASoC: soc: qcom: sc8280xp: add support for I2S
 clocks
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Neil Armstrong" <neil.armstrong@linaro.org>
X-Mailer: aerc 0.20.0
References: <20251006-topic-sm8x50-next-hdk-i2s-v1-0-184b15a87e0a@linaro.org> <20251006-topic-sm8x50-next-hdk-i2s-v1-3-184b15a87e0a@linaro.org>
In-Reply-To: <20251006-topic-sm8x50-next-hdk-i2s-v1-3-184b15a87e0a@linaro.org>

On Mon Oct 6, 2025 at 7:37 PM BST, Neil Armstrong wrote:
> Add support for getting the I2S clocks used for the MI2S
> interfaces, and enable/disable the clocks on the PCM
> startup and shutdown card callbacks.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  sound/soc/qcom/sc8280xp.c | 104 ++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 103 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index 78e327bc2f07767b1032f09af7f45b947e7eb67a..ad4ee5c6fab8994f18de57284=
2f3dab6f4f5397e 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -4,6 +4,8 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/of_clk.h>

^^

[..]

>  static const struct snd_soc_ops sc8280xp_be_ops =3D {
> -	.startup =3D qcom_snd_sdw_startup,
> +	.startup =3D sc8280xp_snd_startup,
>  	.shutdown =3D sc8280xp_snd_shutdown,
>  	.hw_params =3D sc8280xp_snd_hw_params,
>  	.hw_free =3D sc8280xp_snd_hw_free,
> @@ -162,6 +222,44 @@ static void sc8280xp_add_be_ops(struct snd_soc_card =
*card)
>  	}
>  }
> =20
> +static const char * const i2s_bus_names[I2S_MAX_CLKS] =3D {
> +	"primary",
> +	"secondary",
> +	"tertiary",
> +	"quaternary",
> +	"quinary",
> +};
> +
> +static int sc8280xp_get_i2c_clocks(struct platform_device *pdev,
> +				   struct sc8280xp_snd_data *data)
> +{

Could you please confirm that this should be _i2c_ clocks?

[..]

Best regards,
Alexey

