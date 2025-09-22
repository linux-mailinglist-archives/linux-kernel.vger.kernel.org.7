Return-Path: <linux-kernel+bounces-827277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB74B91580
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5015B17D298
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8475230C621;
	Mon, 22 Sep 2025 13:13:27 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4076D30F555
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546807; cv=none; b=CRvXcjKRMXGidQiDzSBDAi0CW4C37QItiKkHUeauNAGBPp3D1NXV0mXl5KAp6Z4XgjoZQJyAmx6h8pJwWkRqOoBSLfg+wwnfhiW8Xw9Ubx/9oy4vaOOrU6fWDsrokv7ZtmqQes5ounpbN/Nq8gYjIVlIuTp9ryRF4+gUQkWhYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546807; c=relaxed/simple;
	bh=S/6XpFBr1IRtyZO8OA/cwmZ4o5NgtKwVhHfKm6CI0Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lij43oxNK0Fs2xtJlK5aeZVbBI8vPVOjeXoeGCC8cITikTm+POpSs6RLN8KY6wPdhhAjpHMjnJ5H6CKUOXmw05CnOlQFn2UNvbeJzfxwDWRngfAZNzKvHUQnbVejsj8pvJ1goNUj/zZkWPlxtzF5Y2evsXXlEYiULWWU82PzYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54a80b26f88so1360078e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546804; x=1759151604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nutag0WU4swh2Ttkj8YGMxVYoDLOFgxz3Bs9L8eyAiI=;
        b=i+og1BU4ylpNrg2JL1Ef8ayqr34sD9I5Ckk2HhExvyoAwjhURE71kVaEuWxopEHWT1
         4k7yYzMZcQonlu3teqzVmTU1kWJyhPEfP82cgkGt/L5r1SVyGIxUklzaNkswnD1xi8im
         85XIkNcmwCp7+CXhss1/5PPQOic4Fkxbx+E/SHeh6iYWH4m662vLtJiAv7DgKSNYZD/Y
         Wkf5p4yEqzGgqJ/jy7oqqNF1hD3bR8RyuV4ymTfsqLI7fByxWb4iqbZLV5kybFw7FgkT
         86EWIOZtXx9jiO5PpzU54OLiQ6IhCsyOx4wabQ7U22jPEG6acNAgDMbPdv13ETz+sjue
         R4Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUZx3t4ddEqLRS+kv87X1zvk/wlRNVI7P4jSF424AqIBvLFosM0eC50Kc60bUnoKntkmQ6Q+woHWU8e24I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxplgfiUchTcCjwrmXUf884gQ0i+LvQ4W+GKKNFz9mlwLltadcd
	dkGYYJU4HPQvZZmOeY6GcC3yOFIil//uOpqRj2FHP4xO9ApZzUO9hGh8o9MzSeaP
X-Gm-Gg: ASbGncsPxMZCfAC2OeiDKRKqSSIs8Moey2gXLKv+MNoH2NDR7cCp9Lcer+nSWUMs6U0
	lBbVSySJ2IR6+Id5dgbbFyhTjlbpTHXwFH4hZGDVHTjvarLMoGnv2d8YeRe80AFkBVZW30VSOzf
	NnXbDqXle2X8aW5JtKO2aiiiEGdmC1hUoXv97TxCcWQhJCxCinkfJkqX9IvBbRCDaje1TzmMSJE
	vXKTMVyvQSISawq+0Gknb6xk1INNc65WcO/hx7vcdtnLLh/H6+TVpt5/JBSR7puUn3nvgTcNkF9
	ayLiXaI1+z3ibz9a10qvg7uOndHvgbBRi0G94eUlaQUamjwTanmKvT4XSZqYyXwd1zZON7B62PY
	jGY8oZiuAk+pjn0TpGhO+9IprKhRhq9FJZW8v5t6U8E0Mv1lYN+5guNji1LwmClVx
X-Google-Smtp-Source: AGHT+IESZ28hl/d5syj4rZRK6/DgaAddkIo6LUCHF8M6Y6yi4mHtPnLibcBA1zhKqMl4+yQKyuarGA==
X-Received: by 2002:a05:6122:3c91:b0:530:7bd4:1761 with SMTP id 71dfb90a1353d-54a8387befbmr3700492e0c.11.1758546803897;
        Mon, 22 Sep 2025 06:13:23 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a72974c93sm2626934e0c.15.2025.09.22.06.13.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 06:13:23 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54bc2d1feb2so113815e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:13:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSmhWOTwI7JnxAWuq/MVSNn/nH5CXPtVT3hTxIgUhmhjr5N0Gqqqdqos6LF6/5TnMN0IVnjooyhtT11J8=@vger.kernel.org
X-Received: by 2002:a05:6102:6a85:b0:519:534a:6c22 with SMTP id
 ada2fe7eead31-588f802c452mr2930268137.32.1758546803126; Mon, 22 Sep 2025
 06:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921111557.103069-1-biju.das.jz@bp.renesas.com> <20250921111557.103069-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250921111557.103069-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 15:13:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVCMPkh+D9G1rNJmhnyqOV3Ya5jb_VKjZEdVjysEqFVUw@mail.gmail.com>
X-Gm-Features: AS18NWAuG6KhnMhrzu9_2fL0vDBhmEtSyA2voBsifQw3rX27cbvUkygACfbs8sY
Message-ID: <CAMuHMdVCMPkh+D9G1rNJmhnyqOV3Ya5jb_VKjZEdVjysEqFVUw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] pinctrl: renesas: rzg2l: Fix PMC restore
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

Thanks for your patch!

On Sun, 21 Sept 2025 at 13:16, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The PMC restore needs unlocking the register using PWPR register.
>
> Fixes: 14c32dc1f63d ("pinctrl: renesas: rzg2l: Add function pointer for PFC register locking")

I would rather say:

    Fixes: ede014cd1ea6422d ("pinctrl: renesas: rzg2l: Add function
pointer for PMC register write")

as that is the (later) commit that should have converted the direct
write to an indirect call.  However, both commits prepare for the
advent of RZ/V2H support, and the actual issue cannot be experienced
before commit 9bd95ac86e700ab8 ("pinctrl: renesas: rzg2l: Add support
for RZ/V2H SoC").

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

