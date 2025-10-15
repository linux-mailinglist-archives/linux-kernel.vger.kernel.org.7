Return-Path: <linux-kernel+bounces-854098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B9EBDD895
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1525019C2B14
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A6C31A81C;
	Wed, 15 Oct 2025 08:51:47 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3F3176EA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518298; cv=none; b=A3xTDvvj+0CeMvuobUCE0f1LleXxuRqnWy23GxpJEmLsVCAFfmzXtUVE3GECtfPMlPTKJM/UMmeYpfZ5h9+0div5aUlq/9hMzL3WNQt2/TkrNG8vayMMq1QgfeoRLWvta7sGwvauolw+bd6GadeGgdr+nkvd6sl4Ha1rSbQNbfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518298; c=relaxed/simple;
	bh=Xe6Y50t/1UHK03lauiiO1RqhnypsAyHrTe2pPSI8Vmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIXKFXN4Wz5jf7olIEE/TFhqHoAzaW4rIRNJ6JNtoA8PWDvcOpqsvSa7fCcSfEFtF6KOqo3K+lkRVS0evD/1u17GS0a/5QK+Tt5F33217CBpbcoMgLBlmmZGJg3YoF1vPN+W4LxXf8T7+gFZ7mjw59I5aDmW7kD3VSMFu3vBqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54a8514f300so3108649e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760518286; x=1761123086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cc23OylIA7nwIKH5grl86j81RiWu7A7C8vOJ884eZmU=;
        b=Eu819Rw61oGtx9TwDUpr+reyiBJSKMLNZ//vplNWyWzBzpiwyBNtENnRAkXSJI9Zqf
         nzAzOQhF7hBiIr2JYM7l2NeXJCAzkDmVHZlCYl/hG3xmWyeRlxQt+g3TBYJyCFiumWuk
         l6gIqRDSZ4+35AdJmCmZy72D7/jeFY8ZkTxuHbJ1qa8bWAXUqhM5t2DFI3qh4iB4CoZd
         MsVOQqPPt+9SOjN3hglGgEjMSqrFXyYPxQQo76KE9snWyiUx44zIX3GBEa2xhdds5b4F
         tbIZHO45PzRPWLKYzWkXK14ql9qppWlq0+fns3EkHzXNYVe1R1/PrlFYfIIRlsuSbKQb
         /JtA==
X-Forwarded-Encrypted: i=1; AJvYcCVjYbjgtzmzdT7k9HmvEhyCrTOXBmJOgkGQocuZqFt8LhjaxrFcnb72cZ28oFvnPMW4xXuQHMjOqdFZToI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLADGXA0rmogJvCVyeai1zFQOkS0gxiF8mo5ILy+unJ7cEW1P
	k3AsKjbpYV08c93ffDVsYdaHoD39XkFT+b1/TEM0rpIy682RXUxGw5K8yloN7lVL
X-Gm-Gg: ASbGncvLuJP6hdEmIzZQaYcfv9ukt0IdAJ65HXKz87RurodDRsh+mtOY3oqrjLeE1sl
	V4WvHmyQW0m2hf2pMR+drdRQhPLRs+zHk0kjQWSx/f08w6m+cegTIgk+1jFYmFokBy12cjKapGd
	yBxUSTyP/DVQTozm5A/tjxi5e0E4NJP2Y/wIqYJhq/jrTg//pQNyVutFbgJk6Fxj1tc4RhipwmJ
	/bnSOlqJ3sJGKjUIKA4h6EgT8NneMwVLyO5Y1QCAg7EiVON0LRns1Yc9wkFsjRQSkGFIl9KYNSK
	CmzGExDsw9Yy79zbif55Wvwm0Iosh/QQtc/uydfe/95Sr5GHBdTI3qzBj7Vhd7gQj5dtWHdzL+E
	9MEsA0VNj4oo39yH79nk8kLay3nIZOn9J/+ztQPaJUX+kl4P5grvw58YUn1ZsIYeN/mWgdqqiSX
	2UzzO5OrUYFoiPCA==
X-Google-Smtp-Source: AGHT+IHJjeUHe+y3cdDXppzNQH/d8YntYysdJruBdJqWpvgQMvFNNyTHt1K4F98Fbk5TZ/GwfL0vrg==
X-Received: by 2002:a05:6122:885:b0:54c:6e3:88 with SMTP id 71dfb90a1353d-554b8aaa083mr11549732e0c.4.1760518286501;
        Wed, 15 Oct 2025 01:51:26 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80aab53sm4883427e0c.15.2025.10.15.01.51.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 01:51:26 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5a7b2a6b13bso4861091137.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:51:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWay+4iEDkgA4MB43w/dAU7LL5nVy80budOTGIuDBk+htiUWzHE1h6pRW2pUhonYMaoh0PMSVrjmCIw+8g=@vger.kernel.org
X-Received: by 2002:a05:6102:6219:10b0:5d5:f40d:28cc with SMTP id
 ada2fe7eead31-5d5f40d28d5mr7213275137.34.1760518286251; Wed, 15 Oct 2025
 01:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925100302.3508038-1-claudiu.beznea.uj@bp.renesas.com>
 <20250925100302.3508038-5-claudiu.beznea.uj@bp.renesas.com>
 <c7fc31f1247332196516394a22f6feef9733a0b4.camel@pengutronix.de>
 <66d85e70-efb8-4a45-9164-55b123691b70@tuxon.dev> <bcf6113b0025777db1cb2ace1618fed8fac2dfc6.camel@pengutronix.de>
 <cca1061e-df67-4b5b-99bd-9721c72a0f88@tuxon.dev> <6d4bc69c-1571-4d98-b0d4-214c68be118e@tuxon.dev>
 <c1099a8e422abbc5d12bf3f325cb9f2140c8c006.camel@pengutronix.de>
 <77678dd6-071b-4911-a5c5-f1519c92e91a@tuxon.dev> <6ba1fd1f07753c9b98a57c87bffbbee16971da7a.camel@pengutronix.de>
In-Reply-To: <6ba1fd1f07753c9b98a57c87bffbbee16971da7a.camel@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Oct 2025 10:51:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVQ_Eabhz0=FRB28BqdidQDpjdBOGq6+9yR6pioNfA_Lg@mail.gmail.com>
X-Gm-Features: AS18NWCfZCQ0twtFVwNHBIGpA19Nn65er5LxlXMaub9DnCgxRsRqvVPljtERNfU
Message-ID: <CAMuHMdVQ_Eabhz0=FRB28BqdidQDpjdBOGq6+9yR6pioNfA_Lg@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] reset: rzg2l-usbphy-ctrl: Add support for USB PWRRDY
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com, 
	biju.das.jz@bp.renesas.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Philipp,

On Tue, 14 Oct 2025 at 18:42, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Di, 2025-10-14 at 11:36 +0300, Claudiu Beznea wrote:
> > On 10/13/25 17:57, Philipp Zabel wrote:
> > > Is the issue that you need the PWRRDY signal to be (de)asserted
> > > independently from the CPG power domain enable/disable?
> >
> > Yes. I need to de-assert it before clocks, MSTOP on probe/resume and assert
> > it back after clocks, MSTOP, on remove/suspend.
> >
> > > (Why?)
> >
> > Due to hardware constraints. This is how Renesas HW team recommended.
>
> I still haven't understood this part. Isn't CPG the power domain
> enabled "before clocks, MSTOP on probe resume" and disabled "after
> clocks, MSTOP, on remove/suspend"? So PWRRDY could be toggled from
> genpd notifications. If it needs to be (de)asserted independently,
> wouldn't that mean the genpd notifier approach can not be used?
> The notifiers are called from genpd_power_on/off(), after all.

Please let me chime in to clarify...

The CPG is not a power domain in the sense of a power area that can
be powered on or off.
The CPG is a clock domain in the Linux PM Domain abstraction, more
specifically an always-on power domain that contains devices that are
all power-managed similarly, through their module clock(s).
Hence the CPG PM Domain itself cannot be powered on or off (through
the generic_pm_domain.power_o{ff,n}() callbacks), but the individual
devices that are part of it can be started/stopped (through the
generic_pm_domain.dev_ops.{start,stop}() callbacks).

I hope this helps.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

