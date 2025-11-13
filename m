Return-Path: <linux-kernel+bounces-898951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67009C56695
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 754B634BD04
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF76331220;
	Thu, 13 Nov 2025 08:51:18 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3614AD20
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023877; cv=none; b=VQxpNy5Tv40Jt2tQMXxh3BOibmSk7PQ1gPDBQZSL9Jl0CZSFYW8nwFMpKtdjSS4mKt41dX9mh7rBrMPdmwsHjZRq4lRK3PFWwgwtgrySNI1kR8VRrfUOdyIQ7mGM2vgZN2PNxlZgdBpN0iwcZFMOBfVs5NfslCYXTzMaQqw4xIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023877; c=relaxed/simple;
	bh=Y3cJxBYr0FtmmjeUHDLAuwvYPIolcl+a0e64J8Sa72s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksUVxSmrVeNGK48JEhxXIYV1JkXc77dmycVYaTRRYDSyRCjLExifjs5kqcBJNgxVBYBdB4AqrzJG/axmQbJje/48Ra3nhzDRFZuTbEtroa+KyTSKdW58CfzyoBYyyoga6OOK/VpAKTtqfnACApr4xr+ibwmUXqtBXJ/WN6YHd0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5d967b67003so420393137.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763023874; x=1763628674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jppCAljRnFmNoD8IBybx1rRIy6Hth1Yqeh1nYPEFHA=;
        b=XUuKYkkFx0vFbl8YZNWQ43KrwSofLeGc9yc59UmRQR4WN3xo0cA1FbBhTROtgcY0Gj
         f+KyZFN8frPAy5UWUXvC3lCyZMT9bhiWQBA3xTOFzrphrHjlhoaCAT/0F+OtBd+mse/l
         4aHQAPk6akajfN73dlUHvhAGG6nOUlMErF94EWECDHFEUdA60jZZt576jiibmTJQJmny
         0plPpPF3wbcm4gyTEuiI+Q75Avl3YgaL+ipFVK6XBACKeDkmLVXNaeBYBXaChcAv11Nd
         jSGUzs3IRoladJC70zcxxdtUg7kknOLNKlqvP3oo76eBvpfNHl+e+kIL3Fejh0b+wG1y
         l+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWKOFZL22D4fOn2SA32NjYyBY/NkUUtW51eetOmZcSHS1tHsd5i+dwyMRHMuFtbHqVy1ykloolAnPQJ2og=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRESNbxb5Svh+F5mz/uthbwzGUwyOg5AsExWqdnhy9vszUj/Xm
	na2pvzrWbeCYZD8k3Ts6Eo1FaJsixL/fA8mZT9XFlZMXq8qAe10NCgKf9JgYe/f9/fE=
X-Gm-Gg: ASbGncuYIStSAwDbkU+txisKyuLGqFEu7lzdAm0WUniw3Voo74nJeKyNPif/CS3KBy1
	zVIWEJH11TeD+A+8xNnVsEkV5LonhId6T6EK/ajizWk8hZ59B9atuDQ6UOpEn0DSNrTV4GD0r8E
	BN0yxOdIqmCpfk4m2lf4Ae7wj9UXuIFMbs04n6LJAZWBMAXvEEnyrwTXHjD6G0Q2ajb36lJYD4n
	ohFi02uoSoO2wGgb7pAd38fPzkkqO2anUkIqWl/UsbXRXLfmeYqydjmGZpLghDO/jCHHcoWobVr
	3gKSa62IP89ROQm1SujLfRXJ1gbAJ7SfVju42Fi4ogxQEgEcnKnMYe/xCOARsvNuI2U2qPVdfUP
	TUyKvqcLUAj7J8tvV3xLb2ZpU4wCRVXsDZh21uPdn/ywG1Q4fKbpV4kX09RK1IzLxmqaj8UuxmU
	4mLiSUjp9sBxrbAcRZVyfH9Cz/wpUTsVAtqYAhpTDhMg==
X-Google-Smtp-Source: AGHT+IF0Yo8X6GPzwisSVdGVupucH2Ve52NquMhMi/jYdVTeq1rQ7DM3paMKLgCTd8VaH+a12s9rxg==
X-Received: by 2002:a05:6102:8384:10b0:5de:e881:1a8d with SMTP id ada2fe7eead31-5dee881230cmr1300693137.45.1763023873937;
        Thu, 13 Nov 2025 00:51:13 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f46319dsm490470e0c.17.2025.11.13.00.51.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 00:51:13 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-559748bcf99so464150e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:51:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXdLjOe8aENrKiYS7WE57rpt+wztZQdboFZROuGc1HObFg5Slctk1nV737+Itiy9mqNox7n7W1PfRHfrM=@vger.kernel.org
X-Received: by 2002:a05:6102:2b92:b0:5df:b1f4:77d9 with SMTP id
 ada2fe7eead31-5dfb1f4937fmr1427327137.17.1763023873293; Thu, 13 Nov 2025
 00:51:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113082551.99595-1-biju.das.jz@bp.renesas.com> <20251113082551.99595-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251113082551.99595-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 09:51:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUdiczsrB8H57VjPbcaWWS22HmUvc_iU3rs84qHAsfB6A@mail.gmail.com>
X-Gm-Features: AWmQ_blLiZfPk5wgCv0WpvOv1cvXZLyFXHVM_u5r95hEUYF3wWO-Xhplpf5nrtE
Message-ID: <CAMuHMdUdiczsrB8H57VjPbcaWWS22HmUvc_iU3rs84qHAsfB6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: renesas: rz-ssi: Fix channel swap issue in
 full duplex mode
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, stable@kernel.org, 
	Tony Tang <tony.tang.ks@renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 13 Nov 2025 at 09:25, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The full duplex audio starts with half duplex mode and then switch to
> full duplex mode (another FIFO reset) when both playback/capture
> streams available leading to random audio left/right channel swap
> issue. Fix this channel swap issue by detecting the full duplex
> condition by populating struct dup variable in startup() callback
> and synchronize starting both the play and capture at the same time
> in rz_ssi_start().
>
> Cc: stable@kernel.org
> Fixes: 4f8cd05a4305 ("ASoC: sh: rz-ssi: Add full duplex support")
> Co-developed-by: Tony Tang <tony.tang.ks@renesas.com>
> Signed-off-by: Tony Tang <tony.tang.ks@renesas.com>
> Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/sound/soc/renesas/rz-ssi.c
> +++ b/sound/soc/renesas/rz-ssi.c
> @@ -374,12 +379,18 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
>                               SSISR_RUIRQ), 0);
>
>         strm->running = 1;
> -       if (is_full_duplex)
> -               ssicr |= SSICR_TEN | SSICR_REN;
> -       else
> +       if (is_full_duplex) {
> +               if (ssi->dup.one_stream_triggered) {
> +                       ssicr |= SSICR_TEN | SSICR_REN;
> +                       rz_ssi_reg_writel(ssi, SSICR, ssicr);
> +                       ssi->dup.one_stream_triggered = false;
> +               } else {
> +                       ssi->dup.one_stream_triggered = true;
> +               }
> +       } else {
>                 ssicr |= is_play ? SSICR_TEN : SSICR_REN;
> -
> -       rz_ssi_reg_writel(ssi, SSICR, ssicr);
> +               rz_ssi_reg_writel(ssi, SSICR, ssicr);
> +       }

You can reduce indentation by restructuring the tests:

    if (!is_full_duplex) {
            ...
    } else if (ssi->dup.one_stream_triggered) {
            ...
    } else {
            ...
   }

>
>         return 0;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

