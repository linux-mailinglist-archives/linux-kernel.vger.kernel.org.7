Return-Path: <linux-kernel+bounces-832600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9B6B9FDE0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43591883D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A296B2BD5AF;
	Thu, 25 Sep 2025 14:06:07 +0000 (UTC)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA68629D294
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809167; cv=none; b=fnOqMtF8QofZ6RF/i4xsXZBDJrAHOXXNJRhCJ5TNH54pumJL1SPo4NtLkNnuiZzHV3fYC3Fp/Hy9yW3xQ7LDGhu2dtUoJ7Hq1tPbN02sKBxDvR2vmYCTjUFmc9UbDGqaI+087WTmp0ro5NLk8qBZXMqcNs2CRf+cBHksSBbCkjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809167; c=relaxed/simple;
	bh=J7k8E3Wi1IFScxwNyQM5lJzKmLF1V/K7HCgU5OX1KFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmXroZSaVkhFcnkhNB9meVSKImnFwSnJ0ZKs7NfB1DixQoaOBGKe1XJ9phryNxrcwIK/q8jdalm1QD9C+/H/80sa/moKehTHA+rchpTKYVHPhpJhrrf5dYc3JiIAKPX22myZrZumSUwV2I0LSP1CXK3wi/QDeomckbidnSjIJBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-635355713d9so585171d50.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809164; x=1759413964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyBko9NuawFAoJizts1IaQaWq9Mvf+zq3p4god2H9Zk=;
        b=Yd1j/Hkz4AEU39noNUCbzWHEVpJ2Zl8nSIxCYb6nT/DryM2XUOXU28AFUhJgWILY4Y
         iDQmkBoA9GZ18FwOGj/GV3jBn+Sae9ZbQY2266RGcHJ/yRW3kWKF+WQAerFAeEDSl/pr
         FeO1rC6jdKe/ws6vlolhOrZj/4Gp53B6zTjmGgGnJQjc1S9sevZmd/d1UEFCdpuAH86C
         xQB/Ynj9/0V0VntGd7Eo3sIuofAm2O/trrE/ys/NykBR2XFd+/TtAenYtcyXVgon2INx
         s5DOaHrGccDX1wT16FqbIUYRc7fI4G6hPeoZUvO1CSoSksFUtwBOVV+fNIn/54pXZpuo
         Ke+w==
X-Forwarded-Encrypted: i=1; AJvYcCX1IC5bntxs2rZp9zkOD/PN7MALirMMqd7Vdp5oI65fBZ2fS8OqA1n4QXTQUSqQs9+nz6rDmUB6Ua0vGs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRSQzg9RzY2Y3VqWUFkz2PSNF+W/J/vkd7qNUkh1tKfVK3Jbut
	GThr06FgbO/5DQCJCsn93KczZ1+ruttbn/XZftuP3i9Nmw6O6IC4Sb4lLmYjFgxI
X-Gm-Gg: ASbGncu0GZnNFFHbjg8DJrWp/6Mmzh6ZardRNFJh0CdnS5sOJN1AwB3UAcGQmZlMHi6
	cRoQegCGW14Dg61+LqIx23ri3cPe9rjqW5Vx+IUEIbaMVmySpU9Beu/Hq5vF6TmHBZ4Vd/oeLjJ
	VndlwyASB3n6lcWfM0JD7gAQN0CrsdlAy8Sj+qSGXWmmFgfKvhQXclgd2GY/UL1wYIX9Agex8Qc
	JsGY8VG4kDbol+lILx3eGBG4gPd0gLvLt+qDvVo0EVuT6oB2N2tflt9m8tAkL+ib6diTOcnV3uz
	Tze+zLe9PnKosu4vcStjx4OTaEcLOcenSpS53RZgteim0QrlX6ibLGsiVBFZzoKoq70a2AJ+k0B
	igj3Z7a1Sm6doqbuWEQi5uPo4q67RM3Gw2vY9p0AUcLPPkv0Ut6IC29J2ArBz
X-Google-Smtp-Source: AGHT+IH2cBTejy3WD6NEdlm890m+qUx3/HYyzZ6ZKJRTxEdrOOYsE9NqHihFUYtSYR6qdo8StLQR1Q==
X-Received: by 2002:a05:690e:d51:b0:631:559c:7417 with SMTP id 956f58d0204a3-6361a60433amr2708343d50.0.1758809163753;
        Thu, 25 Sep 2025 07:06:03 -0700 (PDT)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com. [74.125.224.41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765c60b76d2sm5029617b3.48.2025.09.25.07.06.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:06:03 -0700 (PDT)
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6353ff1a78dso507051d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+VyqaUj8lmZMRFnMVKgC6MJvYnYPiWXubLN1jvNNpBQTmRRQU/qzZryB6gGteeuGo308IVkKrVUQoTYo=@vger.kernel.org
X-Received: by 2002:a05:690e:2508:b0:635:4ecd:75a4 with SMTP id
 956f58d0204a3-6361a8ad38amr1661690d50.50.1758809162976; Thu, 25 Sep 2025
 07:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922074101.2067014-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250922074101.2067014-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Sep 2025 16:05:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV62NUeEYyYgf4LJ2JQLwA-fAzYyA-cy9h_nyYKmtB=1g@mail.gmail.com>
X-Gm-Features: AS18NWBJtjZrCNfYPLsxhmfIYghndnkMeon1y_B0eZWh3VVqWEWRBUD8QBWzeB8
Message-ID: <CAMuHMdV62NUeEYyYgf4LJ2JQLwA-fAzYyA-cy9h_nyYKmtB=1g@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: rz-sysc: Populate readable_reg/writeable_reg
 in regmap config
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, john.madieu.xa@bp.renesas.com, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Mon, 22 Sept 2025 at 09:41, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Not all system controller registers are accessible from Linux. Accessing
> such registers generates synchronous external abort. Populate the
> readable_reg and writeable_reg members of the regmap config to inform the
> regmap core which registers can be accessed. The list will need to be
> updated whenever new system controller functionality is exported through
> regmap.
>
> Fixes: 2da2740fb9c8 ("soc: renesas: rz-sysc: Add syscon/regmap support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/soc/renesas/r9a08g045-sysc.c
> +++ b/drivers/soc/renesas/r9a08g045-sysc.c
> @@ -6,10 +6,14 @@
>   */
>
>  #include <linux/bits.h>
> +#include <linux/device.h>
>  #include <linux/init.h>
>
>  #include "rz-sysc.h"
>
> +#define SYS_USB_PWRRDY         0xd70
> +#define SYS_PCIE_RST_RSM_B     0xd74
> +
>  static const struct rz_sysc_soc_id_init_data rzg3s_sysc_soc_id_init_data __initconst = {
>         .family = "RZ/G3S",
>         .id = 0x85e0447,
> @@ -18,7 +22,20 @@ static const struct rz_sysc_soc_id_init_data rzg3s_sysc_soc_id_init_data __initc
>         .specific_id_mask = GENMASK(27, 0),
>  };
>
> +static bool rzg3s_regmap_readable_reg(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case SYS_USB_PWRRDY:
> +       case SYS_PCIE_RST_RSM_B:

Given upstream has already support for RZ/G3S Ethernet, it may be wise
to add the GEther0/1 Config Registers at 0x380/0x390, too.  That way
you avoid a possible future hard dependency and regression when adding
support for configuring that register from the Ethernet driver.
The same is true for RZ/G3E, RZ/V2H, and RZ/V2N.

> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  const struct rz_sysc_init_data rzg3s_sysc_init_data __initconst = {
>         .soc_id_init_data = &rzg3s_sysc_soc_id_init_data,
> +       .readable_reg = rzg3s_regmap_readable_reg,
> +       .writeable_reg = rzg3s_regmap_readable_reg,
>         .max_register = 0xe20,
>  };

> --- a/drivers/soc/renesas/r9a09g056-sys.c
> +++ b/drivers/soc/renesas/r9a09g056-sys.c
> @@ -70,6 +70,13 @@ static const struct rz_sysc_soc_id_init_data rzv2n_sys_soc_id_init_data __initco
>         .print_id = rzv2n_sys_print_id,
>  };
>
> +static bool rzv2n_regmap_readable_reg(struct device *dev, unsigned int reg)
> +{
> +       return false;

I would already add the TRU trimming registers, also for RZ/V2H, as
they can probably just reuse the RZ/G3E TSU driver.

> +}
> +
>  const struct rz_sysc_init_data rzv2n_sys_init_data = {
>         .soc_id_init_data = &rzv2n_sys_soc_id_init_data,
> +       .readable_reg = rzv2n_regmap_readable_reg,
> +       .writeable_reg = rzv2n_regmap_readable_reg,

Oops, this one does not have ".max_register = 0x170c" yet.
Does this cause any ill effects that warrant an urgent fix?

>  };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

