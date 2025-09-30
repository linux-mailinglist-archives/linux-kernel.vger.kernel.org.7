Return-Path: <linux-kernel+bounces-837502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C7FBAC73A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81BB1895076
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0013C2F99A4;
	Tue, 30 Sep 2025 10:21:13 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC752F9D86
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227673; cv=none; b=a+kXfUl4htqsdmg7wRqpChHJ1dLRs9nKxk6+p7eKvqlJdru3kxMulIW85UTYbjN4HQxvBrgV7FrsQFZl5882RbtQ8IzNV16WTv/SgEUmxA2thTsRUP63TD71tzx9EczibT33KUmGKeu2ge1z+dbFPm9K++UAbZ5faksiYVtC+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227673; c=relaxed/simple;
	bh=WQLYqqeVFTfkVzqoUMVRfNAxbGpfZXqrGeHdXR29J2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0wPaDfiruoOpaMJB5WAj9SvR9zv8KCuiCyHCG+y0vMqE3WO48bFfC4elO4NtbXg9W/G6xBqMEbwFNIDPg/YYMSAZQE4McA/cJ9PcTeTacWYyYeiyBRiP3FXrYWtPVwz0IcltsTRjHVkZuzU0wtih4Hm4uf2xBFEspcNBv87DM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54a786ed57cso4380490e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759227670; x=1759832470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auZnMEhGQ1qbaDugOLJ3H3dc2TwXmOwQEh+fyQy4fvU=;
        b=f2Xrk8P/NukMeHIgeFky2So9tYxkCFz7M2HqMW/+kJzm4D1dibPS1/p04qMu12ZweI
         hoNcsBD6OCCWW7GoRKXuS0BdF99ctvMEHxVgtwQBfOhdSyhelRhq2Vb/m18J4Zh0RFKR
         iAztCeSJMJgMD3wsqRWc+2Wf1G5kbMK3iYybw9gTKI+4EHq4CJiHgQfo3rYtMaOoCTW7
         lFGheGgn22GnmQ/5E4QoEmWrBi47ZaCDvqLmQ44QDOkHf1mCEYBr4ZSKgrToVrNcvM+K
         FB8dm7qynKSAOWrF7Z9kSs4Gswd5XRkSc4GX1ehdJz1BaDf7GDFGRq7MYLNrLiDi4xor
         xkNg==
X-Forwarded-Encrypted: i=1; AJvYcCWpXewEKoNVOvQv9bfiM3JwHx/SVmuai6As4P6GP1rBO6WY2eQRlp2L2gl3aEf0BOB3O4hRy04GzSWgX0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyewszz6WqefmeAghL7yngmJOt4I5ujWbBvGxRPV6d9aoSXq8nH
	2msnFaAJ0iochroajWH1Yt742SjpNZttLBAlukgk9yiC9Q5jhdSDyvbgjD59HsUQ
X-Gm-Gg: ASbGnct0nL7Z1n19ESYO7i0zu/N2r5488Hizs7zQsd6odF7jfHqHc0/nSwfPUoOeaTD
	aWPN7+LCLN5mbTh6CGbJFDPr00APxhqIjRXm+Mz2VRk5xzLRT8PW1M1uD2cjsRuIS9dt48LFC55
	HVWl3gGm4Wp2zfeK3UQs2R/FGRLTD0rvLB987V1fdtUBUNm5m833mg9Ayr7c/PcFnVhlMcYjZHB
	0nALPaVnTFgR39eDBXaCHL9QeI27+xWkYsjEesue6Oq2i4BtAWGINy/d8bCeJRV3y9ywagCt88y
	odo8K16/0FiaSBIlHld29hzPGWqSzmb7UJe4t27erszcR3Sfd+u63E8vpo33SM4gIwsHKyeypuW
	f98JeqS5K8b4SNM3rmCLLsm4wcE5ES7hg75c3Vx8pQiMRFOVYbeh37kaIY6zaVV89FmnVXWdg6o
	6iMFKXN6JzDAHR5dxjmpc=
X-Google-Smtp-Source: AGHT+IGLdnav6BX6dLYHEWqvqAH9XOiXuWJrZyeffpuAE8q1FjTSzjS9uy03OI4Le1XQjuIHBY8f9g==
X-Received: by 2002:a05:6122:7cf:b0:54b:bc2a:f58d with SMTP id 71dfb90a1353d-54bea1b541bmr7687212e0c.3.1759227670266;
        Tue, 30 Sep 2025 03:21:10 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bed8a1775sm2822889e0c.8.2025.09.30.03.21.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 03:21:09 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-58d377d786bso3951376137.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:21:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVV4Vb6+AR7ZAoxngqOVSaVf7cuQfNYj+BwAPChscZ5Fa96g1BQO/UnwB36kUkk0OckxNjEt5ypScV2KWY=@vger.kernel.org
X-Received: by 2002:a05:6102:a4e:b0:520:ec03:32e9 with SMTP id
 ada2fe7eead31-5accb9fe470mr8731133137.3.1759227669064; Tue, 30 Sep 2025
 03:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912095308.3603704-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXv1-w0SE7FZy5k3jg2FO-a-RB2w1WB=VM_UFEA9zjWDw@mail.gmail.com>
 <ef82c610-0571-4665-a5d1-07a9ed9fb8d3@tuxon.dev> <2bd09757-cd66-4a2a-8801-0f62dc99b9c8@tuxon.dev>
In-Reply-To: <2bd09757-cd66-4a2a-8801-0f62dc99b9c8@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Sep 2025 12:20:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6TQFZJ_r+XZOuh7yTUKwZxQRCr4Ps-xZ8U702xMd1=w@mail.gmail.com>
X-Gm-Features: AS18NWCkJPBMZWKc2yUGwPw-vQOHjjVBBvrCu5QO61We_9-kmpWet2XbZ5yLDKI
Message-ID: <CAMuHMdW6TQFZJ_r+XZOuh7yTUKwZxQRCr4Ps-xZ8U702xMd1=w@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: renesas: rzg2l: Fix ISEL restore on resume
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linus.walleij@linaro.org, biju.das.jz@bp.renesas.com, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Tue, 30 Sept 2025 at 07:33, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> On 9/29/25 15:10, Claudiu Beznea wrote:
> >> This conflicts with commit d57183d06851bae4 ("pinctrl: renesas: rzg2l:
> >> Drop unnecessary pin configurations"), which I have already queued
> >> in renesas-drivers/renesas-pinctrl-for-v6.19.  Hence I am replacing
> >> the above hunk by:
> >>
> >>             /* Switching to GPIO is not required if reset value is
> >> same as func */
> >>             reg = readb(pctrl->base + PMC(off));
> >>     -       spin_lock_irqsave(&pctrl->lock, flags);
> >>     +       raw_spin_lock_irqsave(&pctrl->lock, flags);
> >>             pfc = readl(pctrl->base + PFC(off));
> >>             if ((reg & BIT(pin)) && (((pfc >> (pin * 4)) & PFC_MASK) == func)) {
> >>     -               spin_unlock_irqrestore(&pctrl->lock, flags);
> >>     +               raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> >>                     return;
> >>             }
> >>
> >> while applying.
> > This is right. Thank you! I'm going to give it also a try (on actual HW) a
> > bit later. I'll let you know.
>
> Sorry for the delay, all looks good to me (checked on RZ/G3S).

Given this is a fix which will be backported, I will reshuffle both
commits, so your fix is first, and the above no longer applies (here).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

