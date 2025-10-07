Return-Path: <linux-kernel+bounces-844006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6020EBC0D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB5C434B94C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4CD2D6E51;
	Tue,  7 Oct 2025 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yVbJ5/nL"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B12C3258
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828202; cv=none; b=lmD1Nb1UKCEogqkKYNJxDbKBCiJJLtAtjdAv2uvbFqp34M29DN8aWBOUFJtZ8K+8rrJZ5gK3UgHrkB22RDrD4x4RbLFIBUF2qR3cmSacYkQbSBpd8r7vQdS6PTo65cIGNPJZPpTUP0AIy4kqAC+14aCG1URQGYaUfhUGFG02MK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828202; c=relaxed/simple;
	bh=HUwN6R/4tVh/ExqTefIAfV1dIeuXHTwkllgb8kq8E9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pYLaW9WJLXnPBwChsZ+b6eAyLz6+ifBVtnMS8Y/Agqpt/C351ehWyGvSh317j6LTu+QpmlI+e1BG4gAachD0hOZCnDWV46Ce/lLqesz2V7bPVFFgfb6uDHIeKYf3Tyzt0D8rnPeALXPb3oKIi98W5XMl43BgLmI8zmXFZr1O6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yVbJ5/nL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso4723079f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759828199; x=1760432999; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aX/zzAIxKfdHs3b6O5o4Lrj7f6DfCZwLY5Z3Ozvbs3M=;
        b=yVbJ5/nLDGDGB0gHUZX6JErE+oFibZ1DRbAU5cZ4Ge4DS+ZE6IabjnOre0qc7LCKU4
         P8qHWW8lqpeu11cyaU5LztBA6SjQG9UfMXj50WIIZ53G2i9znIANs6zoqZJ3Rgaqgqs2
         mckBF4Fejz1DLrLTnnImiPwTg6Z9wK5FSoXcRmXI7jf3Rj/XSgXcwizKGz3wpbht2rfE
         s44JAjEND8FOOsfDWYsXwn0toD1u9PvO0FYS2gj25L09vWHS/G0Vlcs+F/LLLeUnRt19
         xuPoRfMdrcJ9S+JP1VeQcepJnC2bCJenMKzQX6wAUqd5HENItOFQa8F9dX2ZttrJtLhi
         no3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759828199; x=1760432999;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX/zzAIxKfdHs3b6O5o4Lrj7f6DfCZwLY5Z3Ozvbs3M=;
        b=kpvVUMfMtjJ4ybf23kEhZM2fI8j/DCJJZ6Ts4rLRL989PFTX7KSGH5RAKpNq2upMMX
         W8/9J8czyMFE0F6AWcebaf92Yrd5duD47gUzUkfYDgomXFGNkABgWjmpxhBVRxQCLZ1s
         TQrxdvHr9g3yWYIaw9Nm+7+6/ZuPRECRJspK3Q4D+QOwhYpXPyyMb1u3MOIFwgYjKti7
         ZyrMUqAGz+yCS71+wHLOUg+GYBX3yjFaXNWn8YccLJTm78U+lRbMflCmfRE/o14lUXvF
         X9FdEhcuhAoUzJNhv7mfSxdxBvHzhuCPDC1DpJWHmkwTppUxsp6DVFWMJ38PEkPMEdIH
         tn4g==
X-Forwarded-Encrypted: i=1; AJvYcCWtfRMwHJAS4yged8n7W2P7mrIwB8EBcndXptJEXpaYjaWLu9ayxFZDpCw0bka7mwV4B7lbaLM9kvaQdLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKZ4dTNCOMad0mJctSO06DVy7BrEm8qdcZHGHIdElWPGBvMjq
	hgKEDKi6KIFfh73EMdr6nOaTpIA+se1TCYOg7MY/u0kVbH8eDTRAQNB3GrSQodafk58=
X-Gm-Gg: ASbGnctkq9FNgQZD9nlwETnOEUnwjHR5Yln0sRY94oKM3NYogrSbgAT4aRBlUmcT6T9
	WNzDVqIqtMeeHTRRvyjmBkcUBP+fx6gLE9DOiitfhZQ/VJymZ8TF6mpeXbLQacGMGfg5LPs0uhd
	vIM/a3mYRFzQn2AOaJ0bJWVbrw17asnAHAeT9yamDmE3Q1ssI6jqgIj/I7yinJXiOb4vbs9MLqY
	ood1dpmuTRWeL7Oi7h0saexD60FgBPs3F86jSr/YV4qRL9ejdBPV+1ZeqYxBuPM6PKfzBRzJEmI
	+yi0D+7G+qTyRSe0DoLV86fvuOATZiLK5RKWWvDqPlvgYCRfv0DsGZbT08laI3r6EA6J/W31Xmq
	QkXjLH09YkN3jI0VQAGAWOwMhWtyH3Eijy97VlheF97fzhA==
X-Google-Smtp-Source: AGHT+IF130TGahKPPoII82+V1/81eeS1iNZCVCSTkdS9QhSxObU5gtpJPCiviLrBgBxmw1J7M2QzJw==
X-Received: by 2002:a05:6000:26d1:b0:3ec:db87:ff53 with SMTP id ffacd0b85a97d-425829bf154mr1925989f8f.12.1759828198634;
        Tue, 07 Oct 2025 02:09:58 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:513d:7ba9:7d81:1c37])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8f01absm24412592f8f.44.2025.10.07.02.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:09:58 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Valerio Setti via B4 Relay <devnull+vsetti.baylibre.com@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>,
  Jaroslav Kysela <perex@perex.cz>,  Takashi Iwai <tiwai@suse.com>,  Neil
 Armstrong <neil.armstrong@linaro.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  vsetti@baylibre.com,
  linux-sound@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: meson: aiu-encoder-i2s: fix bit clock polarity
In-Reply-To: <20251007-fix-i2s-polarity-v1-1-86704d9cda10@baylibre.com>
	(Valerio Setti via's message of "Tue, 07 Oct 2025 00:12:19 +0200")
References: <20251007-fix-i2s-polarity-v1-1-86704d9cda10@baylibre.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 07 Oct 2025 11:09:57 +0200
Message-ID: <1jplaz3wnu.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 07 Oct 2025 at 00:12, Valerio Setti via B4 Relay <devnull+vsetti.baylibre.com@kernel.org> wrote:

> From: Valerio Setti <vsetti@baylibre.com>
>
> According to I2S specs audio data is sampled on the rising edge of the
> clock and it can change on the falling one. When operating in normal mode
> this SoC behaves the opposite so a clock polarity inversion is required
> in this case.
>
> This was tested on an OdroidC2 (Amlogic S905 SoC) board.
>
> Signed-off-by: Valerio Setti <vsetti@baylibre.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

Tested on the libretech cc s905x (GXL)

Tested-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  sound/soc/meson/aiu-encoder-i2s.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/meson/aiu-encoder-i2s.c b/sound/soc/meson/aiu-encoder-i2s.c
> index a0dd914c8ed13616fbcbc0828e36418cfd255391..3b4061508c18047fe8d6f3f98061720f8ce238f2 100644
> --- a/sound/soc/meson/aiu-encoder-i2s.c
> +++ b/sound/soc/meson/aiu-encoder-i2s.c
> @@ -236,8 +236,12 @@ static int aiu_encoder_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  	    inv == SND_SOC_DAIFMT_IB_IF)
>  		val |= AIU_CLK_CTRL_LRCLK_INVERT;
>  
> -	if (inv == SND_SOC_DAIFMT_IB_NF ||
> -	    inv == SND_SOC_DAIFMT_IB_IF)
> +	/*
> +	 * The SoC changes data on the rising edge of the bitclock
> +	 * so an inversion of the bitclock is required in normal mode
> +	 */
> +	if (inv == SND_SOC_DAIFMT_NB_NF ||
> +	    inv == SND_SOC_DAIFMT_NB_IF)
>  		val |= AIU_CLK_CTRL_AOCLK_INVERT;
>  
>  	/* Signal skew */
> @@ -328,4 +332,3 @@ const struct snd_soc_dai_ops aiu_encoder_i2s_dai_ops = {
>  	.startup	= aiu_encoder_i2s_startup,
>  	.shutdown	= aiu_encoder_i2s_shutdown,
>  };
> -
>
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20251006-fix-i2s-polarity-d744338fa223
>
> Best regards,

-- 
Jerome

