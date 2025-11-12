Return-Path: <linux-kernel+bounces-896778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6643BC51345
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E3EE4F7C03
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993D2FF672;
	Wed, 12 Nov 2025 08:49:43 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD72FCC12
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937383; cv=none; b=QmzYjMoYSSOd+Ss3MCLPA3pCWZxvPjYUZscIosIlK1iTRBYN/Cll0Tb98HWhFfMoj4qexIALgI2/ADyZVhrysP+k80k6JQYL6oRLg4oTxbx7rmZsTrcHB3rH2C4MMr9kg/CP/o7cV2w+81WS8aSdAoFRCDYZx+x7gSdoWge1q7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937383; c=relaxed/simple;
	bh=GEPcxScTlNQXWLN1NkRTChaD1+/VaqI0xZxACdHRNZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mszJxgVrKxOt9nxTFRpqeiGoXrUTKdqfObvA/eb7kI988UPKaj03qjjEJziyd++lNgb2QxJP23JoF0ijIS8LHA7IkxFwMJ/AJfTb3nv5/2WlxhjPXJ+ZcmZxLPmiX+NkpdJshEPLl288NWeEP6FVLQ4dDbd3ZgXhj7b1Wec80gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5db469a92f7so191478137.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937380; x=1763542180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRuYUt97/AAYUOVBqnw5NKTwDWHex1IdJ959zTzv1gA=;
        b=kGO/umZPLkYiqtfSgsdd+hr3SwQtzQf7Dwhi4FjNiKlu7rYOhvZBmuhDJJqunlZDe7
         Xef1HGvAuZZgHBxtp8g0L1qyCTgyoaz1wwbvwev48r7/Z6PEk+L6uftIgOxAsv5Xjlo0
         VqlGoKNl/kSDYfizfXSFDmZlZB61bzjlmF+lyiU65yPYDQU+cu+KBVK71j2OQ5QHuAOe
         ozGkUgm/JyMPxkLQQ4uqLNvmFKMZfziGHZpzTy3NRdrux1PD9gyu6RfG+S+2Xt48KKsN
         pmyTIF9sD0hKj/m5wkuf5IvzGLlKffZIvrTE4DLjqe0XuaOxU6ZOSGxp0j8/VLHgPoQ9
         Y+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWxDo+Hiug47XIV7Yb+gb45DNhIbZG8r3sNGXsmjevuvW/jhZuz/IPFUqBoGq6RWT9l+eq6KJ85a7ArQ9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0ptt4a/EkzqBNEIz8Jt8pxhyv1gRf9ooxVEJsowDpLCfY/3b
	1bzcHWIHpl5MjnzSoxwu5SDm0QDwH0w9zk9sVSz8RMHF2UQDetltjOOKlDegQjS8
X-Gm-Gg: ASbGnctwxZHw7suZ9a0zWur1+I5HESiBLALZtWMQvGh00/qYZShdt59pxZYrgzbkJts
	ZVJtcYlDP9kHYcvKarItqP/alW0fqmNmnYV9ZyW2ompKVN7oXYlYXGkHyU7qHwV9Sy+x9wRACaN
	wudRV6C/qw0O5MzH5oTYp7Q+4HjJDd+cthHcPHW6ePP2H/B+5F2ZEUVzvXbgHhh5HZW9rPC/eg9
	7DPRf2vY4Q0Pwy2xlygRiWZA4ZCEYi0Jb6AY72gN5dsCRiLSRXXBQDBfGbvLZmKI42M4gD0vux6
	TVspsDry09llzoofDns65bfzAZoHJv8wV+gvfTVZzvo4/K9Ey54x5QdaYbFxELm6Pv2FNvwdxXo
	BaEA2gMM7P8eK1263DrIgcyYyEaWiA55y8YARr2UUwepYsT+Pf+BSUkVEp05blisZ+BVRKDAUHo
	inGcLP+3KLTVeLPy8eOPGcFcmurVI3U9JO6n3A3g==
X-Google-Smtp-Source: AGHT+IF2cGoGjwM3kVQZPOTSfPFjb8Y3hLM4/1HjiHcFll1MJ8HzdSKxnQYcue1ZWaTPiw4+0Y18vA==
X-Received: by 2002:a05:6102:5092:b0:5dd:c59d:ea2c with SMTP id ada2fe7eead31-5de07eb9265mr520294137.36.1762937380131;
        Wed, 12 Nov 2025 00:49:40 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dda1d29399sm7615863137.4.2025.11.12.00.49.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 00:49:39 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dd6fbe5091so272276137.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:49:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDhPPWC4yKoTWVUm3Ljq/GikaiE0JCanVPGNrt0t28nn4yHtvBfkzwy82WR0jaziy5SPWOLEgo2rkXgzQ=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0a:b0:5d7:bb3c:d5dc with SMTP id
 ada2fe7eead31-5de07f16d04mr501696137.41.1762937378500; Wed, 12 Nov 2025
 00:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251111091047.831005-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251111091047.831005-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2025 09:49:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUv7tOc-QC8N_ie7739t07Y5A_6HQPMVR9fxW-jo_d9Ng@mail.gmail.com>
X-Gm-Features: AWmQ_bnWiYGIV8O5vMXPYGxK5G9F49mp_eGvUmhrBRrD8EAR2kAYVwJHFvxANG8
Message-ID: <CAMuHMdUv7tOc-QC8N_ie7739t07Y5A_6HQPMVR9fxW-jo_d9Ng@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: phy: mscc: Consolidate probe
 functions into a common helper
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Tue, 11 Nov 2025 at 10:11, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Unify the probe implementations of the VSC85xx PHY family into a single
> vsc85xx_probe_common() helper. The existing probe functions for the
> vsc85xx, vsc8514, vsc8574, and vsc8584 variants contained almost
> identical initialization logic, differing only in configuration
> parameters such as the number of LEDs, supported LED modes, hardware
> statistics, and PTP support.
>
> Introduce a vsc85xx_probe_config structure to describe the per-variant
> parameters, and move all common setup code into the shared helper. Each
> variant's probe function now defines a constant configuration instance
> and calls vsc85xx_probe_common().
>
> Also mark the default LED mode array parameter as const to match its
> usage.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3:
> - Grouped check_rate_magic check

Thanks for your patch!

> --- a/drivers/net/phy/mscc/mscc_main.c
> +++ b/drivers/net/phy/mscc/mscc_main.c
> @@ -22,6 +22,24 @@
>  #include "mscc_serdes.h"
>  #include "mscc.h"
>
> +struct vsc85xx_probe_config {
> +       const struct vsc85xx_hw_stat *hw_stats;
> +       u8 nleds;
> +       u16 supp_led_modes;
> +       size_t nstats;
> +       bool use_package;
> +       size_t shared_size;
> +       bool has_ptp;
> +       bool check_rate_magic;
> +};

Please sort by decreasing size, to reduce holes:
  1. pointer and size_t,
  2. u16,
  3. u8 and bool.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

