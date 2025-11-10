Return-Path: <linux-kernel+bounces-893220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C01C46D38
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3900E1882E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655813093D8;
	Mon, 10 Nov 2025 13:18:23 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76E18CBE1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780703; cv=none; b=q+SZH3otByQEcUZSunFU6W2blSQZLY2oCB1MNyDxO7u8WzcPwwkoWROYGnnjnPDYSLEmKhQ1BGwBcjOeI+yUZmK+JpcWfxuKBttkTRBK1TioZUYBgqfNXmHDe7fvJJif2YTZErc441ZfGla3jixroxQXxKlv9NrgGMmzPhLh7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780703; c=relaxed/simple;
	bh=vDBZRrptiL8B1JchW6TdyIwfOCu0iFp0Ce/dGtkhJC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hcwcunra7FFlSnhGrY5KBQ0LDl1POw9DpqacapWcPoUtg904ADVLIBRBdNxClFmSFA2CISA8WQCP0g9SJvJHhCnzmV9b8/a5sYL+sTXPTLGP4xdCM43ma1w/N2Y3GmIGi61Kd5za+n6/k7ECvnEl4dxcmkoDmdlrjgEg5kFP7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-55982d04792so2064201e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780700; x=1763385500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ0ifGUcnHr6Kd16YmJsShuaDbT8XpGIPU3sUDQV+ek=;
        b=dFPRLj6qMrvbiHIy+50+T04MWVTRHPQvAQ2AryXOhUsdE5CIWpMruSfz+K94132tF0
         3+wmu/d3gy4GhZd+OhxGIFq5BpVlXI9pSBtOXUJmQY16tDoZ/1lBhWGlUlm3FL5EvEQK
         XH+dnM4y4m58QYbfkqMiqP4KtKDAADmJEu/Riq5be5+YlbyR+SrurSzoTqD2t3wFE9hR
         l5wQL44D4YPgiieRwySpKWyUcUN7IAQ3lWv2/uHHwItYxLycUFc6jrPBZxwipNajHaBb
         4hv4J7vjZzVeIfjtZyP1tc+jNpHtRp3HBTrpjqPIt9eVZ2Q5p7QE1e6BIDjsSrzV9S0N
         77cA==
X-Forwarded-Encrypted: i=1; AJvYcCUDGZ0GLMvZld5a7oaLN8J8S4QOl/fX0Ot195NfZK59nmdtUirv80sMiGHUZXK9b7pdpQeeBhKgbwPU3U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCdJWndcAJ5ZoTZGDvCAYVVwnrP5+r8Nv4R76oPmRlj1lZ7LA
	fJVGOltwefuxXjE8Qm6WgJb6dWlTjkJMSwV/Lo6lA0y4WEYEdPSC7nauup7Uryrx
X-Gm-Gg: ASbGnctNnbFb9ZISE5moPAojILZBceDxOeaAzOfriZ6/hUW87FGJfn+NLTjD/NaK0ls
	U3om58foYEFqn0RIX8dyZh6ng7suROBV8bVLNzY7qLgWMDE9AhTf/3OP4M1NqWCKPbUnTPY0Xf1
	x3lPNMcnukdIsRTaGO/IFLlW2mq8ok3ZKOgwtD8cw2wRHFbLGvLVfczysJLBw47vUPOQgZCRYr7
	agukDi78z8Tt+1lTrPZCWHMtT0ftqZAy3Zhh+buFyOKBpZbpZFUJQAl5LYDrSMH5jc+ycSStTW5
	X8Hro4SFbp/tjWHxKA7G/0L98y+xtjfwPqswwmlTq56XNK2Z//gHrpvzPEvQJw48vBGeBB5c7Aa
	f4BMO3252zHtFirnC2NIjSnNDFGST6sborLYdaGjw85KFXczTT0VAAn/jk8afb1q4Mxm6XJzF6G
	XAVkVB56eOEsuWVwb3QVvGbzxOQMybQ+yf5d0HL4xL4gNlepD6
X-Google-Smtp-Source: AGHT+IGe5urlw0yQXtwa9hu0WVCdRMMkRsa7FzKiesThnrWc9IrmmT3DRvLhGUixKAG0WCNDY9OrwQ==
X-Received: by 2002:a05:6102:c90:b0:5dd:b317:aa19 with SMTP id ada2fe7eead31-5ddc46ae5d5mr2692103137.13.1762780700202;
        Mon, 10 Nov 2025 05:18:20 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93708522abcsm5850619241.0.2025.11.10.05.18.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:18:19 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93729793469so1098327241.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:18:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3FgJeBaqaZpKUjjKTD01gO95w4dQt8q4IlpOCR6oek/ZmDSWpc0yaqAh39TomPjkbbllT0plcUuLjDFA=@vger.kernel.org
X-Received: by 2002:a05:6102:5492:b0:5d5:f6ae:38ef with SMTP id
 ada2fe7eead31-5ddc481b944mr2851696137.38.1762780697780; Mon, 10 Nov 2025
 05:18:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028165127.991351-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251028165127.991351-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251028165127.991351-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 14:18:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVAyN-XQVoBNncCC5Jka4TMqSeswe8frht9sPOEJB+VLw@mail.gmail.com>
X-Gm-Features: AWmQ_blg0wBfBRVHEE39XqXvRiX15hbIbJMqYeX6Rvu1lD8v_t2OD6KHWJX8VBE
Message-ID: <CAMuHMdVAyN-XQVoBNncCC5Jka4TMqSeswe8frht9sPOEJB+VLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] clk: renesas: r9a09g077: Propagate rate changes to
 parent clocks
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 17:51, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add the CLK_SET_RATE_PARENT flag to divider clock registration so that rate
> changes can propagate to parent clocks when needed. This allows the CPG
> divider clocks to request rate adjustments from their parent, ensuring
> correct frequency scaling and improved flexibility in clock rate selection.
>
> Fixes: 065fe720eec6e ("clk: renesas: Add support for R9A09G077 SoC")
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

