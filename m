Return-Path: <linux-kernel+bounces-788499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D08B38566
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A11189E7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEAD21C16D;
	Wed, 27 Aug 2025 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSj49iSl"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820092144D7;
	Wed, 27 Aug 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306098; cv=none; b=hf2DJGdZqxQXUMXgOmYGmBNfdogYO4v1JuyAi7xE0aCPoX2Y9/4BEWwiunP3XgCxqcdBMjOiarRqGMqo83MAM2uQjQByNw6bFOHHYaPQxqCQ0RyrFWRGkav1z+umzV69kg2LVd1XdQhBJTOaIQhQKgDW/whunYDf2wXUh/yHyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306098; c=relaxed/simple;
	bh=cxL8Kw9Y2T87TIHR3kRZhZ68/wSIuum9+NC62d1gru0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=klJA3ZPn13bAewxzrKYxK3GwcYfUJkph/jKO4fWX+MZfngc5hlb4T2c0bvRvf3Rq/yOjKo/WGCQtXD1TCI9nDnMPNng9AjIzF+S92HG2d5Eh8XPFt+SJX5vrsSsZ2bbjG9PaQO2+TXQRdxe4zF7eF1zr4HkJeiuRzJpppTac/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSj49iSl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so14149265a12.3;
        Wed, 27 Aug 2025 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756306095; x=1756910895; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8Q+4WGdnzVSInxrR9e7vImmCQtyEK2zoJrrwmy0Jcg=;
        b=OSj49iSluiYxeqcTE/u0z71Z58dl3zQs/v7FVKNGRMMwY9BlcwL8AeF6YgFhQgQZIZ
         C3ErJVr3h7qFLsJjuw0i55KKGu9Lg7Kr+1I3OCMkvJ37eaMS9cvobi5+or3Yr2Ws7FmS
         IJWyXjypO5bEF8sgUEMsc7Bu/OfK+URyTsabAJ3MQ8mnEgFKvPejzbe6IdlE/fSBDDFe
         wxQQZCGQm6eYYP8qvZosNqWof3vHLY1iBhE2/6SxvcZyw5ZzCpyCgIGydiupO1HAWrWd
         FT0aijSgPW7ETR/mGJR229rV9pPnVbMBYPhTtGglDPeUP5ZpoO1WLMhhRByUguFL/W4e
         nOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756306095; x=1756910895;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8Q+4WGdnzVSInxrR9e7vImmCQtyEK2zoJrrwmy0Jcg=;
        b=onAKEFzAi2NVRSiwQMIKVjPIP8ZlNHssZgm2Oo6E1jRk27xEX5NQ71scGN95B1LwbL
         YpqwSaKaIB//rN+8C9yR9pQFz40O128MPq9ST9Etemb2weiKi/JVVS76Pz6TAaQ4voyo
         YaicCbnQPrKoiDqG+u1XERqGXzKH77uvO7AGzfx8NQTWbOKelIA2kC0TQkWmrTo6U8Y7
         3syRGpBSo6+Qd41KtqvxDKGiiJtUoVp9QJXHtNEy+RSAoHCW+gKo11aOtcDKXL3cVE3v
         n3RlQNqq+nsi8y4dku5W8rAtDgFHmXxtv9Cls5NmeY9JzNC+f+wk5J2bYqBb4THohizi
         Z7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMbNDYDVHtHcu2dYq0AmK5imJs1Amzi7d6rUci3RSr/mBsdhUBbjM0LcQ3GPv6I4zhaG9wXe4pd4xu@vger.kernel.org, AJvYcCX3aXtsv/Tpuj2HdsiUO6JfKoLGpBHmffvXnjkeGzRvMBRaxp69hTzVK2uZHqotr8cl06Iui9hj+mBE6GNr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3RfDbfFMi1tKz/wvSofrjX1qnl5FP4G66pi9EX63sZ7UwOJcP
	ChURzbdRDe+253NXF7VrFNCI82cLyDtaqBgMQad7hUsunZU3SWf65onQMKydJo78UCPbTy3ySn0
	q2OEFsAlNyBuADntri/UjAbdniZ74fQhTwYDH
X-Gm-Gg: ASbGncuC7qXdXBmG3XSVJfWdHeBlPR+mp77+FYoWF28TJfLZJrtKVUBFX1I5i9ldJV8
	ONyYNALgIWy6K54ChXow5yka/QObg9YqxYyaKwu/LMMScm2eVBuRZGsZWVLkFtP2gkDTJnz0wyt
	uXfPT7vs8QcFToIt2HAidWAkZY7rDdHI54ZlY1JAE4hafO0A0zkFQEZYKIlZdfQb5hVvWp3vDk0
	GUVJZCAprsks+J28ZSqXih3tTLLjCJY944mVFX6qGhDyw==
X-Google-Smtp-Source: AGHT+IGSFBtc8BrDM7VUweQwXXMCtFRHX+kesW91DLtCc0fhgEwBQiuZn738srV9V3e9Izk4q+U6vcOlHWCa6GnVdTs=
X-Received: by 2002:a05:6402:35d1:b0:61c:74fc:3291 with SMTP id
 4fb4d7f45d1cf-61c74fc4143mr8418400a12.16.1756306094655; Wed, 27 Aug 2025
 07:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827142705.1644267-1-pbrobinson@gmail.com>
In-Reply-To: <20250827142705.1644267-1-pbrobinson@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 27 Aug 2025 15:48:02 +0100
X-Gm-Features: Ac12FXxM_9DtiKI9RRGn4o5JIdHybIk7XVWMWvt3g-3GgEvDpXvoAId_5kV4DWY
Message-ID: <CALeDE9PY9+oAa=tv_D4ordJCaOE6b8+_eBAzeq7xwDZ9Gx6szg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add vcc-supply to SPI flash on
 Pinebook Pro
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Apologies, I believe I've already sent this and it's been applied.

On Wed, 27 Aug 2025 at 15:27, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> As described in the pinebookpro_v2.1_mainboard_schematic.pdf page 10,
> he SPI Flash's VCC connector is connected to VCC_3V0 power source.
>
> This fixes the following warning:
>
>   spi-nor spi1.0: supply vcc not found, using dummy regulator
>
> Fixes: 5a65505a69884 ("arm64: dts: rockchip: Add initial support for Pinebook Pro")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> index 5a8551d9ffe47..b33a1509a8e93 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> @@ -959,6 +959,7 @@ spiflash: flash@0 {
>                 reg = <0>;
>                 m25p,fast-read;
>                 spi-max-frequency = <10000000>;
> +               vcc-supply = <&vcc_3v0>;
>         };
>  };
>
> --
> 2.51.0
>

