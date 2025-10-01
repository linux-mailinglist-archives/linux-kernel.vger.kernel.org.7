Return-Path: <linux-kernel+bounces-838870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62030BB0521
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE870164CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B6D2C11C4;
	Wed,  1 Oct 2025 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOehcEEU"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265228DB49
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321428; cv=none; b=rOllsMSpd2wzJ45yLo17+Bz3OuRRRpij+zkC6+QQoofRmasr5gPFv7kV6yEy9DfgOn0qhZ8UyNHwRUFLLc0M+JIgPbqc9+jRPUA/agHcKNwxD7kYZnl9W4uOMgWn4/cB5AZuNAdjv8azJsYbsHNCWoS+2QoFo/KlXVPgRf+ih68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321428; c=relaxed/simple;
	bh=gBGrabJtd45mAFEOoJqVzc2XuZnoyBrQ0XCWSCj9+dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zop1/cOiNu1Otbokzg6/Ai2nixa4pkD99ITIjb0j3Esd2w98X3NYLOczRAZryMrar5Z/STg6KHxAYvN6x3Ainck0TeZCXvarlLtNgEORVryogwsMxamViwE4D9RQu69jEJ31fPwusLH6OhQWUXFMo+F5gvj3sZS5jVEn+44fbOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOehcEEU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46b303f7469so49430495e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759321425; x=1759926225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBGrabJtd45mAFEOoJqVzc2XuZnoyBrQ0XCWSCj9+dc=;
        b=jOehcEEU5TosO8iUkUmjVQmskcVwSuE5WbvHzJYKgA1Tm3waT4pJmh2CZm5rgCo9X3
         c4xmGlF0pqD6SURSO5LoNoZPYjEAwhTprjRmOkqS8th2EmBBDzIAiQs1oVljSobgKddD
         vQ61D947KC6eup62GgiDprsX9MnqMKJBwwkzpuWc4AQebeGVG6+zcDAPYw9r7O4yEJd0
         75fJcT1g/IExU+LM4i/dG2S8fvHWBnV0Mu2EnIxeL26VYit1nZBzR6u6sHVKi5N6zUsz
         AhxHGvQes3LBXTnVV8Uy2D2bqSKXakToY+GoPFxPc/AcHYkaagoTbFMxTLYb0iiZ2yq4
         5+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759321425; x=1759926225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBGrabJtd45mAFEOoJqVzc2XuZnoyBrQ0XCWSCj9+dc=;
        b=JBG9GQvqAAXPUia2jyO/uWEMYifPNSbZhzMbJeXkCImiyrQejlWv8ON1a9sG8QUi5M
         o+rETgBW+4F5xwHmOG/QAWdi6JWv8m8iJIioPm+uCZ5eyN1ptXHvzGQ85qtmx/ns48HY
         K0TpkiZTdwSQpdJOZLxnjZeYN5vSTgwL8uLVr1BfLk84EGKe51DQihrXsyJooRcLKu0k
         9obpAtrfB8Bu9Vtm3nTZkLnNL5fGi7ExUtuQEQfvA/KJKwpal2PAafMsSP2NP1kJhRmB
         l1ImQE0xjZXKz4oB09e8L5xysVEyI9PDIzCe/hBJpwT12X8AzbFieXho+rTTS7LNfTc/
         X8aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiMAIgByDdsbAIBnBlJWi0VntteL5b5UQlAD1EGjq/rgpkVvPnGgPyjwwpyQQ9eDEiyPMpuzanSi8S23U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/l3lxMkdzM8t/SHgGp4kMajQE0vuLtmjQiwuXe3+Z2daBqSB
	URAGEyBehuaxqdHf7Vgpa06vCEo/5GCF6eEmxIBvWe1I+qGtIjJyID+5s8Dxa8No+ljqzMamCeC
	zRUlxmQjXh0oCzoWj1eqJnbpaHzdMxHA=
X-Gm-Gg: ASbGncvBgiyv+OdU3sXQ2nqulPIId4QY5Omg1a2TmKah1VxnvLLu80Rcv+Koq/Hv+3D
	2p+FHQ0ZVcTa8hnMLjk/hoMoAFYMz6qZC+EjIvd3OBElPhFmb5ORHYePGnXqQCZEGOh6DeG/YCi
	b3HObAMRiMv70YD52y31EDltYFriMxbxkCotHV4ZwmWythvSTWk4SKoHuw/E0JRNmqbtIL3RuJo
	T6GxtFdqiOIayznZk+uMRSLcavWHLTB
X-Google-Smtp-Source: AGHT+IG6w9L1LgThnpefnQm9I8OUIomLSyIMrWw3z8rhw6qFvyxmd8vXZTGsJ+SjoSiCjhbCQK0VPlSPMN9tMkkTwbU=
X-Received: by 2002:a05:600c:820c:b0:45b:9afe:ad48 with SMTP id
 5b1f17b1804b1-46e6127a4bemr35253245e9.16.1759321424233; Wed, 01 Oct 2025
 05:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903161718.180488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20250903161718.180488-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <db2fc907-218c-4688-aebf-4a929f21b074@ideasonboard.com> <CA+V-a8vghwkHKWoqU8NQ3O9ZdHxB+cEvMv7Z9LQOMsZcx9vjPA@mail.gmail.com>
 <f1e671a3-77af-4ae2-aa6e-bde93aaa54b7@ideasonboard.com>
In-Reply-To: <f1e671a3-77af-4ae2-aa6e-bde93aaa54b7@ideasonboard.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 1 Oct 2025 13:23:17 +0100
X-Gm-Features: AS18NWAI4MLtfZreV3_pLNGPAC-_jcQVSy6mD_NW1R1LCvbGTlMIsTFaxBIK_zI
Message-ID: <CA+V-a8tosiUkhaWGoZ9yTBe1Kyy0DLUGreqReH2NOWmVeS5_pw@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] clk: renesas: rzv2h-cpg: Add support for DSI clocks
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tomi,

On Thu, Sep 11, 2025 at 3:26=E2=80=AFPM Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
>
> Hi,
>
> On 11/09/2025 11:14, Lad, Prabhakar wrote:
> > Hi Tomi,
> >
> > On Wed, Sep 10, 2025 at 1:30=E2=80=AFPM Tomi Valkeinen
> > <tomi.valkeinen+renesas@ideasonboard.com> wrote:
> >>
> >> Hi,
> >>
> >> On 03/09/2025 19:17, Prabhakar wrote:
> >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>
> >>> Add support for PLLDSI and PLLDSI divider clocks.
> >>>
> >>> Introduce the `renesas-rzv2h-cpg-pll.h` header to centralize and shar=
e
> >>> PLLDSI related data structures, limits, and algorithms between the
> >>> RZ/V2H(P) CPG and DSI drivers.
> >>>
> >>> The DSI PLL is functionally similar to the CPG's PLLDSI, but has slig=
htly
> >>> different parameter limits and omits the programmable divider present=
 in
> >>> CPG. To ensure precise frequency calculations, especially for milliHz=
-level
> >>> accuracy needed by the DSI driver, the shared algorithm allows both d=
rivers
> >>> to compute PLL parameters consistently using the same logic and input
> >>> clock.
> >>
> >> Can you elaborate a bit more why a new clock APIs are needed for the D=
SI
> >> PLL? This is the first time I have heard a DSI TX (well, any IP) requi=
re
> >> more precision than Hz. Is that really the case? Are there other reaso=
ns?
> >>
> > Im pasting the same reply from Fab
> > (https://lore.kernel.org/all/TYCPR01MB12093A7D99392BC3D6B5E5864C2BC2@TY=
CPR01MB12093.jpnprd01.prod.outlook.com/#t)
> > for the similar concern.
> >
> > The PLL found inside the DSI IP is very similar to the PLLDSI found in
> > the CPG IP block, although the limits for some of the parameters are
>
> Thanks. As discussed on chat, this confused me: There's a PLLDSI on CPG,
> which doesn't provide a DSI clock, but a pixel clock. And then there's a
> PLL in the DSI D-PHY which provides the DSI clock.
>
> A few comments overall some for this driver but also the dsi driver:
>
> This hardcodes the refclk rate to 24 MHz with RZ_V2H_OSC_CLK_IN_MEGA in
> the header file. That doesn't feel right, shouldn't the refclk rate come
> from the clock framework with clk_get_rate()?
>
From the CPG perspective we could get the info with clk_get_rate() but
from the DSI part we can't. So to keep it consistent I will keep this
macro as is.

> While not v2h related, I think it would be good to have a comment in the
> dsi driver about how the g2l hs clock rate is derived directly from the
> pixel clock.
>
> I still don't see why all the code here has to be in a header file.
> Usually headers contain only a few lines of inline code. Is there a
> reason why it's not in a .c file?
>
Ok, I will move the functions to rzv2h-cpg.c and export the symbols
and have the declarations in include/linux/clk/renesas.h.

Geert are you OK with the above?

> And last, we discussed the milliHz a bit on chat, you said you'll come
> back to that. I don't think it's a blocker, but I'm very curious why
> exactly it is needed in the DSI. +/- 12 Hz with, say 3.6GHz clock does
> not sound very much to me, and there should be enough time every line
> during blanking period to empty any fifos and "catch up".
>
> In fact, if the DSI is so picky about the rate, I find the HW design
> odd: in g2l the pixel clock and the DSI clock come from a single source,
> which keeps them neatly in sync. If that is required, why change the
> design here so that the DSI PLL is independent of the pixel clock, yet
> still the DSI PLL must be programmed to be exactly matched to the pixel
> clock.
>
As discussed on irc we have to live with mHz solution as the HW is picky.

Cheers,
Prabhakar

