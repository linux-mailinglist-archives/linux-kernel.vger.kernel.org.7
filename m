Return-Path: <linux-kernel+bounces-899846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA90C58E98
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96534A047A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4171936A024;
	Thu, 13 Nov 2025 16:38:47 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9E336A00B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051926; cv=none; b=fowOASQn8kfLX18z9GoR2KRQwGQIngg6JV9M470UJ3I4Z3GBFP74f5xToeSHQk/wyEjDu4Qiq7f7Ac50uL6n/tts1QXey6uEp6w7LFk2mO3lhjf46cDVcxKMIErqHrEOX/FXwz7y3hEkVREls3FO8i2RWhWwcAtZGBBObQsvAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051926; c=relaxed/simple;
	bh=6POMRmRsIFBjMD+KOp5/v8EgPR8+GZSyR+y+p1dAs5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVNmkU7RR8hg2AEkuNH4alosWhCM9l6dmTZkynHO7GG+zbXHeEv6+4MRJnZVRS0RXY3tLDSGZpQJXXx60JB7DUhpzexoGuU1We5Yc5Vlaet6VZMZHPZu3hNTRlOe/2PN7spnXtztSt5epX3sDFIBEgyRT+pQrhvAfP5SUnimVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-55982d04792so656012e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051924; x=1763656724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=958YNef+Bt2Q0WGZYn2Q5QLvs3OwYQ/fTXGUrCIU6wE=;
        b=EZ/B6NIehgePSsIG42UnOi8vc6PIReOScdU79xApQZdNa5/7qqBeiMsxwf0alHidFr
         +YuLMOf5cZ9UUGjBVnWNpb55dxb9Mssp9HPHuS/TqtJwWl1nygSBJTOvNPWbwe+exJI7
         Fug3X/eW5SeUhhuNrwQufUjnbXSOzIHoIksAnwn4N0YPLEJubxBw1stQSgVV0ripC3V3
         C3ktY3nzRCaNsIs9eP7Bb6H1Nx+SjZwMaR1eO+GwCXZccEDRmo20cbzwVuwA4WQUocIz
         VbLwOyZrXo3mOTrY0iOBHAjC1I7iPbu+OdmLNx5YOTcK7Eq+lA70D5XGp6ReKNVjVcn+
         4PCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdjn1+wPPs3TZGZ1BcCZw2P9bnLzx6EZJERaCpmNGoR6/SoFXtbgx3KqJ3k4uNMrj0rrfacFXOargQCGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRUg3KlJTNsJebTBUE2RDn1XRh0NQOUnEi93YPIETqcV088GL
	DDg+llKAHfZX7pxeEvhKgXRb8ETdQ89O9jdzAD6vln51rRE0/Y07d5n/JMwJ/WtoIO0=
X-Gm-Gg: ASbGnctWpUGwFPkl7En/pJT2ZlnvzWvbdSX9hdpxPjPZw2KkkGtwJ8F704QwhI0X1tK
	hOeaCyGG8Tfy9Td9rVGpJhxcvLAReeQtDNER0sceeFUIBbYzfAdQkDR389Q08nPIlwHbecT+a9b
	4IUxi9PcsLCULV87bG2ZJxIGIgvX5rKXYK0VJtVWEw74R7aZ5wMPZ2SKSpZmg3h10VnQWP1DQ+D
	nGDzm+4LppgkGmolOer+ULiGjWMbRPGGSHq2mV9/5d8PRvUtrPV4YwcP4quLVW+ZbQB4E3DAA4U
	ww8z5fcEDw0+OCvAZMCOcNlBkvM17pTl3roMYBrNE86Q/8W+uApGJ2jdZsnoY4Muhmn+xpxljYP
	Xx9BG8B2h6jTyYVx7ax7U9v1rQ7zsxvg2ijdIfxvyIhH8gSIMwgIXPsIsCNoVEyOT0KAHSFLOev
	D2zwDxN8I8HCS87yZHCiTUrTPFlchPrD3p1gwGjA==
X-Google-Smtp-Source: AGHT+IF8bpisYP0I6NufBaNELxxZtrsNhZZXeO+q+olo4DbllEzNEAY2guiPRDhXRIp2hymfUgHlxw==
X-Received: by 2002:a05:6122:83d2:b0:559:79d8:27a5 with SMTP id 71dfb90a1353d-55b1bb60637mr226917e0c.0.1763051923613;
        Thu, 13 Nov 2025 08:38:43 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f35a6d9sm832051e0c.7.2025.11.13.08.38.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 08:38:43 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dd8a02e808so793435137.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:38:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZth+4TDKFzilM+TAl9Pamcq1d0EZDsV3/HUBzRaVoxtCsndGnuBtD8w70bvzmuTFPqfBWLw6L9Jpc2wE=@vger.kernel.org
X-Received: by 2002:a05:6102:4422:b0:5db:ca9e:b57d with SMTP id
 ada2fe7eead31-5dfc561815cmr167985137.19.1763051922603; Thu, 13 Nov 2025
 08:38:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106080758.36645-1-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20251106080758.36645-1-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 17:38:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWmzY24PwTg0=oFU3ZN1wrgDpKvnQJ7=zDZvxpx5y5K5Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkzY_8MEzmaJCoKDY8pOB5ThYiIkB4YoEC3TzmpiYwCpzmuuMs1N6fl8Y8
Message-ID: <CAMuHMdWmzY24PwTg0=oFU3ZN1wrgDpKvnQJ7=zDZvxpx5y5K5Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Refactor OEN register PWPR handling
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: linus.walleij@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pavel Machek <pavel@denx.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 09:08, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> Extract the OEN register write with PWPR protection logic into a helper
> function to eliminate code duplication between rzg2l_write_oen() and
> rzg2l_pinctrl_resume_noirq().
>
> Introduce rzg2l_oen_write_with_pwpr() helper that encapsulates the
> PWPR unlock, OEN register write, and PWPR lock sequence. This helper
> must be called with pctrl->lock already held by the caller.
>
> Reported-by: Pavel Machek <pavel@denx.de>
> Closes: https://lore.kernel.org/cip-dev/OS9PR01MB16368C765305362F5F4132759FFC4A@OS9PR01MB16368.jpnprd01.prod.outlook.com/T/#u
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

