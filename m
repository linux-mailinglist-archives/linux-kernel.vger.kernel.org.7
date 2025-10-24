Return-Path: <linux-kernel+bounces-868575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B58C058AA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8483AF1F1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ECC30F807;
	Fri, 24 Oct 2025 10:16:56 +0000 (UTC)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4630F7EF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301015; cv=none; b=biDvgRICtBZcCRB/x0123mMZnR3MLxxMJjYmRXw6ekI8hB0OwQwB9mPsuIP4iDrk2O6sT0SXhNLT7Cd29FqIx+4Yapn1bPnyKk99aAuC2fvTPZVjQEx/3A5+NF5/Hhcj8ewJStLBpJpz8Miis09Szj0bDx1Mn/FyuDmwQ9F3CQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301015; c=relaxed/simple;
	bh=AqiWd9FcEXBjGqvYmjKezWFbcC8LX/8ccSI0CzYf7rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6D/nyaHxmDNIx4TzEzurONdaMwTF7CrPKcwrPZBNvvCsHHrYdqdtaL81xYy2Zmib0o/I7jUipok45S0EvaKvcnIXtJHnbRimK/zNJVx9YlW5chu6wcJwDQ6pp4Xg2ZbizM6AyYx5B8aBtMSA9F+J/hdaCuW22M5fLKYhnm9tuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-89019079fbeso716478241.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761301013; x=1761905813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSTLk7b49rZYTSOotXXLR+fnDfbehF6NQgF/VSyM9XA=;
        b=dfo8LpqPIOhBn/ZuIGUURdoAqFjqwWATsw59l+5kqJ8T9A1fP7cdoxXdELNolGZZsq
         bXB25qEkG1fhaZAq5aFyAdK1waM8cS5WwqJf+rbMZDtpDNnrbw1wDSA5P07iRNaI3zrk
         vNWLRIYbalUuUAIrwBhz51hRItYweff2xXfRBLrU8XdglRq+vwuZZh0keGVw6JlBn3hm
         DdnqQliWekx/ivEOOfnMMzzTrTW/EoBff2h+xCjM5PKctX8uOgBFGCqWs7cUP244Q6FJ
         tgmk4DJHB6zFXg53S7YecsTxncv3tfO2z5XX11KRWeNrdlQxY3YiT70u4zScg3+ESP5s
         f61Q==
X-Forwarded-Encrypted: i=1; AJvYcCXf5o4oLvWZ/3Q3oXPyH0G7NX0y/aXKZWbx5pHMQB/gB9UAgNtq+iCcud68x3Rdm1y76/Ptt/6D526eWo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBbcRVszaaqHVPijlzMD9cOjbwkhNaw68RpkTD7MBVHuXPhfLs
	xL99bWCNr08K7l7m3iXw8vUBFRhpCCCISNUbu4o378tTiqmsND6FHm2sPddWTuM9
X-Gm-Gg: ASbGncvXzrfQXGNvg8IS81FvbF40p7IupYvuT/XqCgAY2xozzeZZo85Kl+h4PmdUanI
	Z2xxFoddqDhnDGTjEOIvC2NS/8e9cxeZXDaE5ZEa9Wl2pa8xsoaJa1UIXvrX+6nYKNTuBdhwZC1
	q9IqrbKLQufV5ZH+KfqacllKcGozsQ0XPdqZfoqZybYbhcfWs9Mqym5yYl3pISoB4LfcFXp3ESH
	aeAWuL+3gx9M9QgyEeUHwiBj1D5YqE607GoTFAxpSVuGZ876Wr21ritkZwLMo2PDQwbX61is568
	yLmW4mInX1lnVqaJIgknAJTu9DeJN+TShAcaZ6VnrgkRbXdksc3aIOTjC7JUXV9WqJAsqj4l4fC
	Zv6A/7Zm9BVmJrgFU6X+e+Eqaj+YV0q8Gw3jVE4wcM+IKCfmoxdpjMdxhzLvtc2QIZ+R7WhFiQE
	m5pmu8djnDVnThu7a6fSsHye0TQ3CkHGCmEgbJXe+X1IELuyGV
X-Google-Smtp-Source: AGHT+IFkER7+fDobdobTCeaMXYLEringRo9WwEHiWfizyFibxNtoSGYPw+IZEdTRdGWs3hTz4SQfPA==
X-Received: by 2002:a05:6122:8289:b0:53c:6d68:1cdc with SMTP id 71dfb90a1353d-5564efa986bmr7985679e0c.14.1761301012874;
        Fri, 24 Oct 2025 03:16:52 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bd89f41csm1843933e0c.1.2025.10.24.03.16.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 03:16:51 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5d5f8e95d5eso1184548137.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:16:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUtl47jvjHovnp0WKgcc55pfgaNrSGTFRnZNsD8Z1xxf1xOQ0zULGt/2CaaVFMfW5IMbYYpSVqS4ha+xE=@vger.kernel.org
X-Received: by 2002:a05:6102:5111:b0:4f7:d553:3cfa with SMTP id
 ada2fe7eead31-5d7dd53dda7mr7539658137.12.1761301010775; Fri, 24 Oct 2025
 03:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251023081925.2412325-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251023081925.2412325-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2025 12:16:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU9jkZ16rw90qY-y1JwReVuh9GcoU9590Qj+fnAOBKcEA@mail.gmail.com>
X-Gm-Features: AS18NWAl-mnooV2yE2ZHT2YePMkrfHPFCcWPI_7IIu3f_WOQ-qTqZQdZwGQjyhs
Message-ID: <CAMuHMdU9jkZ16rw90qY-y1JwReVuh9GcoU9590Qj+fnAOBKcEA@mail.gmail.com>
Subject: Re: [PATCH 01/10] clk: renesas: r9a09g077: add TSU module clock
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 10:20, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a TSU
> peripheral with controlled by a module clock.
>
> The TSU module clock is enabled in register MSTPCRG (0x30c), at bit 7,
> resulting in a (0x30c - 0x300) / 4 * 100 + 7 = 307 index.
>
> Add it to the list of module clocks.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

