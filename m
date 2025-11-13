Return-Path: <linux-kernel+bounces-899486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF07CC57E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 382914E94BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC28283FE2;
	Thu, 13 Nov 2025 14:18:53 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC223D288
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043533; cv=none; b=YFrOEBfgRjUpEF0TzMsM4FmgUJbuI73yfUEnKQ7y4gaISwg/VEBHdcRegj/y50Ssry6Itpqa/IJwoQcP9LlRunLWGwse3iPxGp8rXmHs/tm81itVzM3DiF/3e2tCyrjkhbUje0WJN6bLx95LdQL2P3S7NDDIrJsfAU4SPvnmLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043533; c=relaxed/simple;
	bh=SglwgdJjdXgtbcGuhBd+z1SY8I+c9+nx3fEEJ4chWEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zk4zJCgUgjFDdFWgzleHCMLVsVBdPEGmcoW0Q5OjBx4LYxGz5Mk9TogS3M+wM89Xd/63rsqg9SIClvRf3XxJ2kwdM0fvwlkQGBVtL0xzQ1Te4LgoFeJEGN+0VyL/v4wHYk0YkSKamkhfFLE26iYo/TmuE2DQeKXGKfI4X1Ravbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5dbde7f4341so1501397137.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763043531; x=1763648331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lsBSIAEUPRTn5OJ+c8R/u4+S4nJOhGwxwcKm3MB6tI=;
        b=tAhspPjbqnJt9LdPG81qhvOpTJSP42hadBsTc7D3EK3Wht+MEBHXC5ZTA/GWZKF5nN
         JkzOG+C1W0g6UeYXjvrcjzYGwav0LTb9l0W5ROjw8rjo1v7dUB8E/724KXfOof6Ht0TF
         3jOUbK2Jn4Aru5+nb3Czp+Kb/ZtCXyp3WUnr7Sdh5fHhCdgzVt7JRBxhFw4dgl9Yyk1G
         wgULvlVQNVQXGDQzoBpZ4WJbVgTy2VZPyJeaQTZXj8iibKZ1hXa9glzmWNZniZifLIuQ
         8nC5IO1y8+7jwz/XHPPU5Nr0nHrI3RzD8ekkcztMJL2EezoarwUZ3PiJA727U8XlGEvu
         H/2g==
X-Forwarded-Encrypted: i=1; AJvYcCVE6bEs+Tv8qHcHfFmw3WSvOqpRw2W1l+nd85nEXn9nIUWLOBsCDNPDSEGRk1qkX4o9tcntNHBrMueDOFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUcklpB9stZdQkn13AxlJkf4MHqhIpsdSo3HWZ0kNzrDSrb6x
	crhMUTYRwuiPqZVXyhzLDWysfDuhvUFqqTDc4eZaRg8J6Uykbd94yfL/bkCvOgku33s=
X-Gm-Gg: ASbGncvK4LLFhpMMr/eKRJdiI+UX5kLgaouRc8e01HoCzs/k5neKmhiG7tHuxXpU7kT
	aVHo4kGLwkVMFirrzpG+KjL6ey7yO/3ynoZlBhze1CoRJJLSZf1jSf57ICm0C4vcIprl8zfeDu2
	ERPYj460JMMO+8f6+1gswi3JwYi08a8tFhqL5OPc1eLencmD47hn3RR25I4KiwW2ZIHBTGeJVAl
	o2zMF75f+AdPPVGvRtzsyTpL+MvluDQTW/lL5S7YSyw2UAH4BmD94+RKuNTaZxtgKo2dTIOEmkR
	pJ4P9afp2C0SmDqkpnQsZrYh5sxRNR3S2G1hKv/EjBaduqk7pIpMPdUhx6dCoNqotj3lVuONbiE
	b/U/e/uWauATZa2FA6DrWhBW41cHCvKnTEDG4AuDZYDasG4PSZb8N6xHf987DnADC/tWY4jEyvR
	aYcxa/syNmU9UXdWVXec6pvQfrxhfnjQPZKGMcmA==
X-Google-Smtp-Source: AGHT+IE5Tc0LqA73lGckOlLaqs5fZARLeOjc3JTZKy1vUnRFtDSc53ZWJourejkbDoo9Jd72R0yJfQ==
X-Received: by 2002:a05:6102:3310:b0:5dd:a0bf:8c89 with SMTP id ada2fe7eead31-5dfb40abcbbmr1150118137.7.1763043530698;
        Thu, 13 Nov 2025 06:18:50 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f49865fsm702922e0c.22.2025.11.13.06.18.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:18:50 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5deb0b2f685so1099703137.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:18:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1QlgycaEFI7ZVUWQ0gDxgFzAdCMkb4ZKXKfUh9suVS/zkh/pGRBJwpIe4S9EjBPoh5ZvZnEnOW0cpVls=@vger.kernel.org
X-Received: by 2002:a05:6102:b0b:b0:5db:dad4:840 with SMTP id
 ada2fe7eead31-5dfb41e3b61mr1262190137.12.1763043529716; Thu, 13 Nov 2025
 06:18:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210706.45044-1-ovidiu.panait.rb@renesas.com> <20251107210706.45044-4-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251107210706.45044-4-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 15:18:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXr+pdZuYM0b1p+hZAjFMR25t3FV8cGWSbqRnTk118TPw@mail.gmail.com>
X-Gm-Features: AWmQ_blZmrYQK7IiX68T9lKCtdQnRgn565V-vW-eTn9Sd-DrKbAs0Z8Z3RjSLgE
Message-ID: <CAMuHMdXr+pdZuYM0b1p+hZAjFMR25t3FV8cGWSbqRnTk118TPw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: renesas: r9a09g057: Add RTC node
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, alexandre.belloni@bootlin.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-rtc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Nov 2025 at 22:07, Ovidiu Panait <ovidiu.panait.rb@renesas.com> wrote:
> Add RTC node to Renesas RZ/V2H ("R9A09G057") SoC DTSI.
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

