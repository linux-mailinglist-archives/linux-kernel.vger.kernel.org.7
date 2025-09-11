Return-Path: <linux-kernel+bounces-811577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D23B52B14
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9FB3A7EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC5D2D249D;
	Thu, 11 Sep 2025 08:02:04 +0000 (UTC)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C62D238B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577724; cv=none; b=UgGvwUZv/0IuSXsML/taA2zu/NB5h/Faq3YmE2AW9e1sHf1tlam73EOgL+SH9n0LFI6DvFFyL1txeja+X3NRs1iCaemdeF57cgGRDAAgL8teCXxouo7gqPl5s/gsiMHeksz3VMMkS4IJ+REihGqU0p01ehoFbX0p/L/GlT0irq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577724; c=relaxed/simple;
	bh=kBy/AvedJIkQJvHWwCiRjKInRbQkdpYRIGxLrxF5G2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktEpMp01lbsgaDc74u1e4mFx7txXle0eSeZMDmK4VlDskDAzLCcledDq0t/dADzIXibIhOm4ztNaX2HyFcKhL4U/5IrNQ1SXREqiPy61WLMd889U5S+BXXSLr7j3wRzm2ESsZiHhYWIqv8j0aMobALXU6nFssJwfRT1+q2iasyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5448c576e3bso130457e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577721; x=1758182521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KANTy1QlCUJPXGuCgOYVp+dSgXgnl1vGnGT6cRevzw=;
        b=p17DrVvgC5SMrdaz72q6zbADJRfWnih3cqPQeks3FfoY97StNmHk5KuurMOmJbrpV3
         mMJsnqWcYwdnoMv+POrr08p1975/1zQe7Ep/PKKJqkw6g1Bum54PLbMk6dJlFqDX66mK
         A5ufJ2uAXQceGhUHuKa52kwsNL8Phpb1GHeaoXB6DNf4fbduGmO9uamEy4G7n9pe0zD+
         sVElTxdqPSYRjrmNVqrLmjbuH9IjpQzE8LQm07rI4mGR7x7W/AFRwSgsAhe1DEBxx4B1
         uaIDU7BcprDRrRePU4YTe+8tIWttqWJbHNix1/ghb4bIhEsA4wVmGB+8S+KxDcKJ1cwM
         cN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMQYVbFumQd3vk9HVsJ36ZGuBqg2c3SUdrdqB4SF4BnVBPOyDz05fAgjJrMpYX1W6yvEojeSWy8y1cGLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVKkys12h+wisglsK5sT6NGTOgwZNiE4T0A4GBKOUU2+W5omtW
	GQLk6YUYwHlf3oqh8PBDFM64DzisstPrYH9Be9oC3ur5Wku74bNlpmvu4/VAU0Jl
X-Gm-Gg: ASbGncu1sSV16WMKupeyzAjVde2WRWAsZx7W+a+KHIVpmBtpDZk+WIcz4HJ1I2A0w7m
	jmu9kZ9dQKSV6dcwDh5bFVBL1V6ZC05NEPnTkIV4aPMZ9cg5pxJCswyJVe4GAzuGEysl5apCaZ7
	CdOynSQUGevtVAtbJz7y3rNM94kcWsJ25HY4zTMgqyOBlf0qKzDFKSPzWnMbzqYwJpMYfrg8s6+
	2XC6jDarUK/lIxreSpbBrtBn0fQkxsVvgqHb01LZjO4qlYP9FKoUm+fz2t41cft0kbwLWbrlj4L
	SfF0t3imEOMHZ0HBppMPVXEvkzBzOCciuIqG5V9bZaGuYbqkCxG1A5tgKtcISJSz/Uk4P/AqUXs
	Bg3mbA88csX/m17vOWxK6f6UViOScbtHMzCeOhU7LnaqLHzlLdbdPfY2kPwyO
X-Google-Smtp-Source: AGHT+IGO7vNHdUDrWYJSMo8dwc0fuNdSJkDfCuL5Y54Dy9XToFOWG/fbHKkxHU+BwK6PeGNy0Dw3Iw==
X-Received: by 2002:a05:6102:1623:b0:524:b3f6:fe7d with SMTP id ada2fe7eead31-53d160d3ee0mr5994429137.32.1757577721121;
        Thu, 11 Sep 2025 01:02:01 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8ccca9847aesm138966241.8.2025.09.11.01.02.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 01:02:00 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-89e5b87f406so133781241.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:02:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnxhyoKjMheydkzb32Nw307Vu6MC1NP54aCpTcu9iuvb6xax/ZnfFDugSW9AIxRCYEnZ3LKnRO4ayXkbQ=@vger.kernel.org
X-Received: by 2002:a05:6102:441f:b0:4fc:817:dca8 with SMTP id
 ada2fe7eead31-53d1376b72amr5773636137.16.1757577720535; Thu, 11 Sep 2025
 01:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910175415.8698-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20250910175415.8698-1-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 10:01:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6NiCfL80onTxm=6jX7mntouJr6UbcjsW1fsVxNVGJPg@mail.gmail.com>
X-Gm-Features: AS18NWAxsOtpNgwtCNv-gmTlbVlF3VKPt5-yYPVxyi6HT2e8ZKzjCX6D1hFl-2A
Message-ID: <CAMuHMdW6NiCfL80onTxm=6jX7mntouJr6UbcjsW1fsVxNVGJPg@mail.gmail.com>
Subject: Re: [PATCH] nvmem: rcar-efuse: add missing MODULE_DEVICE_TABLE
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 19:55, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The nvmem-rcar-efuse driver can be compiled as a module. Add missing
> MODULE_DEVICE_TABLE so it can be matched by modalias and automatically
> loaded by udev.
>
> Fixes: 1530b923a514 ("nvmem: Add R-Car E-FUSE driver")
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

