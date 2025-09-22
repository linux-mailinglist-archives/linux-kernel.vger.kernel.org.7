Return-Path: <linux-kernel+bounces-827299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CD7B91602
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66D84232D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2607E3090E4;
	Mon, 22 Sep 2025 13:21:12 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670230B517
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547271; cv=none; b=L+SFQpUDhlLcPCRFclBex7t9ehLN0p2oVNCQJTfBiJ4BvovwThD3kQbtFYa8cC03pQYBlq8P/YoqWGCr1uVzQm5xRKRWIpVJLfo76Q67U1iAxr01rFZbJLlrEYNKqHJP5TnxFUrDwBAwf2Fbupvq6uM3Z26n2FexIC8BXQrDgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547271; c=relaxed/simple;
	bh=twHi5A9x4cQ/6G+wv9NhTj7Vvql2JLIedMZaL1HDcCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jxf5EwxfugsfghkYYuCYvY5zl6IW9pSnQAczjfifbWuhj4vwedLiMcBHBQ6BWw2ArONGwheqll2Gu/w0jk8+I892CJl3oczum9k73j4ulIfEXbdFYU083BhdViOTeXDR4jQYkM8TQVm06+QEe+i2KUoYod+JkfB5w3aZOQ3sDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54a9482f832so1517322e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758547268; x=1759152068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oT2yfLN/4pYPbEtz7ZQcc5Ja0yXs/qEChj5LREg+X4=;
        b=bdOdyXxJhMCzlQgEq02w+LcR/haMKJYZTYsZ3Bjd6wSoPCc/+ScfmKGMC3NLWfo271
         EkfEUD3HaEjImBc+tqyIk+JWTMvZp8nS/taeiQQYlNWlr1cLOxJCrl8HdtacRuJWk0Pm
         JuPDPSF46jzJcBqqT2HsKjZk+I3y5cWVA1JT0DgxMHLl8azB84VABjysvbGF/X6dAnO9
         jXkh8L02btdxcwNPm0gCD3oQfVdijI1GM5hZ8d+2s6K0HLOvKnkFrjB7mJa78o3WdUHB
         P0PemKlwmeZbGynpKVluncJH+k+j4GtMwUE3eLlESJVyRNXnLde2dbdTCLaWmPyt9Djf
         r3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUo2ndJWZG4JT0kibThqPoVAkcSM3axw+F6egX0Mrc0iILJFTsaum4JpvQW6O3RV0XtP/RU5Fx14ky7XK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy13zbW7xxJeWC9lC4wLvZ/4VHM6tlOxfiiFXaAmQ2QpN9LYA7h
	E+Zj0xgsJRuYcCnYKLky0ioz9fdjKsjpiH5/1Zz0kaB5iPyh5ifwspX1LQ7ULcuD
X-Gm-Gg: ASbGncuscps7LnWumk+YyDOZloPRyBm0KW9FAshA2KR2/uPX+ZXDZ+p8Dlme/i43B+5
	xhc8qyZ12vdwdUFNFQ6IfVMb6iXQp9/tswltqrNthVzXxxMkTJDIaPjZcsiIHojq35f9nCkpNLh
	6waiKago3Ph4zxj3indYkKiQX47K5MwzDPzDrUEv9hwDy0gMkfbxjE5C04kwAdjP4Ku/ZPDQ9lE
	4ftqU1MwJlw3WWQPrae0/R1CMZ2nwNyFKQPLta6yRN/wNi+VboGMDE4EVLj1s6/bugJl1sOtI4l
	xdTtS9IdLFcNj5yXd6B7d75YYE+PY6dkolvKMIIrg7SHLKqFGBFun9xKf3bUAoyfOMxmBuubS6Z
	jKY913D5l9yCLXbQs9GLyY2Ubt4HTuLJG1bSbxaikA1KjCqso52DA7TjsPc59
X-Google-Smtp-Source: AGHT+IG7JZ2eFr4mwhZxFFy4VYxsPdoQgBSJsmPH8UBRqWiSyFWXnIVyJVjnJcpW3d+jHpxCG5aC4A==
X-Received: by 2002:a05:6122:e46:b0:54a:93be:46fc with SMTP id 71dfb90a1353d-54a93be4a66mr1563646e0c.0.1758547268106;
        Mon, 22 Sep 2025 06:21:08 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bbc96ccacsm424907e0c.3.2025.09.22.06.21.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 06:21:07 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8943501ba3dso1994646241.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:21:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWu98dbBUuaIj3f4p+ljCe3glgRAAC1QHTkQsv2OCzKpgurAF5vpr5ILLeqMifaL5vw+XL0RUf5yUmto8=@vger.kernel.org
X-Received: by 2002:a05:6102:d8c:b0:521:ed06:1fc7 with SMTP id
 ada2fe7eead31-588bb9bf4c8mr3821613137.0.1758547267049; Mon, 22 Sep 2025
 06:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921111557.103069-1-biju.das.jz@bp.renesas.com> <20250921111557.103069-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250921111557.103069-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 15:20:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWtpv325awR06pFA+_EHh5GZ90K6OEf5S6Wkg+_89uRBQ@mail.gmail.com>
X-Gm-Features: AS18NWDdF71ys-sJ9xzdE3pXCvKO4zAavWIwsnrvZsEZ2kjh3SpCcOFmdVkNVPA
Message-ID: <CAMuHMdWtpv325awR06pFA+_EHh5GZ90K6OEf5S6Wkg+_89uRBQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pinctrl: renesas: rzg2l: Drop the unnecessary pin configurations
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Sun, 21 Sept 2025 at 13:16, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> There is no need to reconfigure the pin if the pin's configuration values
> are same as the reset values. E.g.: PS0 pin configuration for NMI function
> is PMC = 1 and PFC = 0 and is same as that of reset values. Currently the
> code is first setting it to GPIO HI-Z state and then again reconfiguring
> to NMI function leading to spurious IRQ. Drop the unnecessary pin
> configurations from the driver.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * No change.
> v2->v3:
>  * Dropped extra space before the == operator.
>  * Moved spinlock acquire before reading pfc value.
>  * Make sure it is configured for function in PMC register for
>    skipping GPIO switch.

Thanks for the update!


> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -541,7 +541,11 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
>                                        u8 pin, u8 off, u8 func)
>  {
>         unsigned long flags;
> -       u32 reg;
> +       u32 reg, pfc;
> +
> +       pfc = readl(pctrl->base + PFC(off));
> +       if (((pfc >> (pin * 4)) & PFC_MASK)  == func)
> +               return;
>
>         spin_lock_irqsave(&pctrl->lock, flags);
>

Looks like you accidentally switched back to the code from v2?
Shall I take v3 instead?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

