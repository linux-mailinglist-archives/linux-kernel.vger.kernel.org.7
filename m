Return-Path: <linux-kernel+bounces-868612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF85C059E5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D258319A5AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A2D3101A6;
	Fri, 24 Oct 2025 10:38:25 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551DC3101B1
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302305; cv=none; b=kNzTwTnZrDsW+yVItRDDqkLDOocesJ7c4RCxHunGhknl/GSpkIpXHZ2+GDNFNfqzQKok+W6MqeK6XLEYM4yfb7nPGpQwI5l1yAYVTH3jt3K0zbbUxMYb81PyZfE5k/KEIVcz7t6dHNv9eBJQCReHKGq1cMDU6th1buCSYqypB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302305; c=relaxed/simple;
	bh=WB5fApO8+rYBQab5f2Nym5kT+Se3DnyCljE8OKwhP3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfBKJc5bAxpquXu/90L6Jl6we6NM54PUTTdQPmVFW3nCFqkS6PUrHfHyG+WFcymNWzChCjQtz0SijuXTUQzpERIeqHfLuNIeS2+4Ypn6LFMU3lbXXsoAlZovldV42HNZUj2NFb1LK2USNUeb0Dhqj5g6n4tCaA5gooetzroyNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5db2486c870so910497137.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302302; x=1761907102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpq8mZd6yHaCnXYSdFvmX21GokIxR+DEgALaIuhYRgQ=;
        b=QZq7xibnZlwB+e5p9Z7kacPuPxOMMrdTjIlt9MVHHTCtrQ+jTcViYhKd6YfJ2NGhZc
         iN1D4Zb0fsSzmKvL2VkLsqNzqG52BJApxIdbCOLt9lnxhCDD0Pi/la7a/Z0W5aaCB3WN
         WNZAx7KvAs0koPUJ3ti/IuqUMseTbQsCHfpunEWfqBYTPVopC7dMLEb5CY93ai7HI0cb
         Nv6kpm/oTarOHsZbe1sVsknE60aQOIqMejiEVz32/anrAUxfXl0sVahvDBDqT2bpCNRu
         t/Z+Pn+cGtUvcatBeVq7LRcjuiLJMOcVaRGZ9nOd6nmIi9pgpf81wYAEmxLS2mmlNhCd
         Nt2g==
X-Forwarded-Encrypted: i=1; AJvYcCVF4Le6CTzFXN1nmSx43DIT5kpFMEqM9WowUyXCfjjIgWzam9f1AzI2ymtiHE1sSCOPVbAuer/DLPmq0F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXvKm7syelfcBrDo7jmTCplQxFHhvav/UxhmZH2+eVOACfQeOO
	A6U8tVRIg1ygqPkEcO2AM1xiyc/kxp05kw2zWz21DMjJVjOmZL0YFZd4N3/iVwyO
X-Gm-Gg: ASbGncvwVizA73/gZJ/68+aTro16X7RtxUa9qSuyJM12UrC1U7rcj78Rw2oFZVIR/5R
	YNavCE8IIGQHZtDmrded+edioGexS6j2VOcGARYPGpO93JPCkNCPHxUB1bo0lUwHe+WC63nDhjC
	aw9RcvkNQy2JQ2B5r3PCKGo1Z84D/h5onDWHgTfhtZGfflOFBT+pSAn9FoP1TaGM/tyWuILnYKw
	do0ewzS8qFvsjAp6ejwruXwkKmGyY62ioh0nnmh7X+JDE0+sDGU2B4PLFnYiweag/nA9xE0yDYy
	g/yZBDl0A44GY1W9/5yt3BF6Yps4xVKsy+7VqLeODXqd/V2S5X+gR/zCjhSiWDDTgy4jTzUBWAY
	JWa0NSTWRgX59AF87OjwHh8HbMWzmzTehXDPgDbGgWuGEoGtUDZ+3tzyO+PFRsj5Ds4LhI9x7D3
	bI4ykb+BoIjh4JlQemgXtk2zZ4sQnZvFYaLvVzV/W1e9xk2oVe
X-Google-Smtp-Source: AGHT+IG7M+lsPcFKlDnY5KnyChqkexQ35SAITcD/84YRPxEG3lj8r7CZQOh7hGdxM4CC5uVzJPBwzw==
X-Received: by 2002:a05:6102:2ad0:b0:522:255d:4d2f with SMTP id ada2fe7eead31-5db2e446e8dmr1835351137.2.1761302301970;
        Fri, 24 Oct 2025 03:38:21 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5db2c7c995asm2022156137.5.2025.10.24.03.38.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 03:38:21 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-59a8c1eb90cso1165696137.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:38:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwCac5eZ+yEXD6LkpQsFmCjJ5lU6dhhLCgd1rVyxVSVTM32OwzXGfCs1f/rEG1tTR3NYarz9Uz5O50UWA=@vger.kernel.org
X-Received: by 2002:a05:6102:1497:b0:521:b9f2:a5ca with SMTP id
 ada2fe7eead31-5db2e4786abmr1811923137.13.1761302300586; Fri, 24 Oct 2025
 03:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023210724.666476-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251023210724.666476-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251023210724.666476-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2025 12:38:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXesP=oUwtH+mc8G+5b11hBz7VUdEKrFvAC59F6fRHLWQ@mail.gmail.com>
X-Gm-Features: AS18NWCQuTkOQsnhJUgy2vY_-eHhdBBMmfSA920Vmg-OjJTPAXTEY344anEjiXY
Message-ID: <CAMuHMdXesP=oUwtH+mc8G+5b11hBz7VUdEKrFvAC59F6fRHLWQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: renesas: r9a09g056: Add clocks and resets for
 DSI and LCDC modules
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 23:07, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add clock and reset definitions required to support the DSI and LCDC
> hardware blocks on the RZ/V2N SoC. This includes new core clocks, clock
> dividers, module clocks, and reset entries, as well as PLL and divider
> configurations specific to these peripherals.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

