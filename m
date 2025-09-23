Return-Path: <linux-kernel+bounces-829122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56F3B96558
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD66918884D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6D8946A;
	Tue, 23 Sep 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbbifZ/2"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA356157A6B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638266; cv=none; b=mqxEmc0FOf7skImHlZaqPaJheZP8x746/8ZWJSq18/XgTMTLD08CrQN5EQN3h8TaY2vKMgusqC2D//TDmN6TLemjOyNw9I9wSyiCNkb43GQh13A7o+rDpdYuCupRmxdcEUYqxm7LmaOfmrmXq3xtqIWI4ZQ87F0xdHJHOrQ0g80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638266; c=relaxed/simple;
	bh=UcZep7l4gtYTIQyVGonuLQCx5rE2XP5lhttbFIWJNmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jy8p7hl2vOiomC55+4JPIhjk4eCI1iXnc5zc1FgImAR2YUm5pet50xAZh17qLxkijEawajvjxt8+6S/yLiHz3VtujmdOoFc11FrDvtdTbVC72gWtzhlw7/Q/L9oXcT5cYCUTPygNmBqMEMVzlzrZNqtwOzvMMDe98fOTFy9GZOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbbifZ/2; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-eb36a143370so609769276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758638264; x=1759243064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oglCBmL4B4WbAybvmqD8cJJViYSD9fzgh1Gue4gY1UE=;
        b=JbbifZ/2B5kh540y4ADqATKaX+xr2CitB/nPPXKxjCTyHS6M6pCn5GqUhRocs5KW7o
         LyX1JTqQMa/rcZVXpjWiQrYjOoCxjxlSMiK6iOKFyBb6YXu6WTLt78pdVsYPb6lLIlAN
         opUwBUSRF4mIKLdcmhqbBzY2h1k+JYf6OcdTW1vBJg9snbPlb4Id3meu8uXdrZP9bKYV
         m7XtS5PkRAk98xKxzhBcDt87CUdcvNstgOb3Ht6K0nKqw2rCL1QoMMAnRj8pPA6e6g26
         3JGY1r2VS1ATYJpLW3/M2fQL2T7KeDGgj3XzBoTYAHiEZyerSj95LyhkzsvZtG9gh4RC
         lDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638264; x=1759243064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oglCBmL4B4WbAybvmqD8cJJViYSD9fzgh1Gue4gY1UE=;
        b=XvLtjPfjl4rmMTj2eplxAPeaiI/JWzXHs9mAxI6QlpKt95AZYl7fBH+N+gWB9cS3yn
         IPjVZagVKyLoLaHw9Y4rqxu/1uF16K/WlTgasEeV4IkDWKhuDijB7WLxWe8lAgVbILLv
         IkAsBcKDJEOLI65sVTmgoNqUOdT/PfeK2gLCk8p1zFIX1ziTi9Ue+xhqREyLx9HGHPvo
         CRDORRSdkWALgHvP8z6MUHU+ez9OieMI+Py+TXPZY71GRHAhqS2f11WbU6Sf8K6/t1YL
         iGOaPgZjAlOogblPetFx7ApTQhwBUvgXxK1mW7/tS4dY5OSZE8uIqlvOYm44guPS5kH5
         ua9g==
X-Forwarded-Encrypted: i=1; AJvYcCULU3ALAxbrzkSan0++67+Vk3JXe9vmaGe6ALNmij2UJvxvvWoAnfYF8EcYtzHa7kGu75MGLfRFklzb4mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQAyywNk+DFFDZgBXpruQfaYtQcJJ4TVviQF1CxodGFGlEP/WU
	Gce+AurdOrC4pqc3kUci4hcDh/i1vXet73O3rNZ/mdEup+IxmhCa8aJSgLm4t1fC+7Ld/75Mfp5
	5SN3yFGfxExj8+uCm6NEGkm2AvEUVByoLU7IDsYVPIQ==
X-Gm-Gg: ASbGncuAMwD+O2h2Kmt35cE37WLAN8b+BBJMSsTik42zHtj5m2FoQdmi+y81+W/QDjw
	WKSS6C6ktSYYONFqmtd0cvGBPYycWokxt7Q19aAm1c6WaLs9xMG/qm3xOgKUgwSImlH9VQMVBPr
	RB2wDWU7mwizQBwak/8ESyygyRqFZzmgqM6moPysS6lm10GlUJFeP7hY0OImINboJqtI1Omcqd5
	dcB+fglhmhR
X-Google-Smtp-Source: AGHT+IEXKuzIArBc91/KA3f/YzDK175N+zTx0haFXxYxlTGRRGGJLMlWHDTe/A1+uBFUxsZwnePdVwoGLZBFbpfcE78=
X-Received: by 2002:a05:690e:42d3:b0:635:35a0:c5a0 with SMTP id
 956f58d0204a3-636045219e6mr1586791d50.0.1758638263271; Tue, 23 Sep 2025
 07:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-mt8195-pmdomain-audio-fix-v1-1-782190385f46@collabora.com>
In-Reply-To: <20250923-mt8195-pmdomain-audio-fix-v1-1-782190385f46@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Sep 2025 16:37:07 +0200
X-Gm-Features: AS18NWDFuHpbFMIzRsDGrqDtLAtiZBYWyMCQ67uXlma11BT4iPN9Gof36Ta3gH0
Message-ID: <CAPDyKFrpwZ+7202Zzs=Hh3=AYqAOPpr98CubYw8dRp5Y+ScxpA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: set default off flag for MT8195 AUDIO
 power domain
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, kernel@collabora.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 10:52, Louis-Alexis Eyraud
<louisalexis.eyraud@collabora.com> wrote:
>
> In MT8195 power domain data array, set the KEEP_DEFAULT_OFF and
> ACTIVE_WAKEUP flags for the AUDIO power domain entry to avoid
> having this domain being on during boot sequence when unneeded.
>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Patch tested on Mediatek Genio 1200-EVK board (based on MT8395 SoC)
> with a kernel based on linux-next (tag: next-20250922).
> ---
>  drivers/pmdomain/mediatek/mt8195-pm-domains.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/mediatek/mt8195-pm-domains.h b/drivers/pmdomain/mediatek/mt8195-pm-domains.h
> index 9405e8f62eaf07112d52a28e6545d26a4342c7c6..1d3ca195ac75806c458db71db4538940f37128a8 100644
> --- a/drivers/pmdomain/mediatek/mt8195-pm-domains.h
> +++ b/drivers/pmdomain/mediatek/mt8195-pm-domains.h
> @@ -126,6 +126,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
>                                     MT8195_TOP_AXI_PROT_EN_2_CLR,
>                                     MT8195_TOP_AXI_PROT_EN_2_STA1),
>                 },
> +               .caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT8195_POWER_DOMAIN_MFG0] = {
>                 .name = "mfg0",
>
> ---
> base-commit: fba389ea7aa6401d3539456123cbadfa1a87231e
> change-id: 20250922-mt8195-pmdomain-audio-fix-f7ebf2afb15f
>
> Best regards,
> --
> Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
>

