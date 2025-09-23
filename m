Return-Path: <linux-kernel+bounces-828749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C70B955AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3963AC92A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B50320CB9;
	Tue, 23 Sep 2025 09:59:45 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7330F959
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621585; cv=none; b=ad11VhEtBpVM1LE1cc9621ylQhQiedRtSDPFWP97O8vgpgJO1eKPiUfn9hXLI4PQgehcGJqLbZnTrkKqKLe6/B+F1AG2HvDjFuf7O1Dzx49i0YjbqG7gDortIM9I56BJdwtCeTdalyhbrsv1CLRmF2RpbiKJ4PTAzVYHktE/zJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621585; c=relaxed/simple;
	bh=UngJ0Rhljc1gSU7wLJptkJ9TDFmikWFZOGAOtnzQ0Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlqkcHX/zQPKNY31BQXvYGapDaU0QgA5X1YN2dBEvapoQvVTLudHuGc78zIJHvPLrspjZbQaPIwLgQoWbht0+bV+51uXfrqB0ooGxMatfhFk499ibrBMR+zmNsXIlX6iHsemWOQWRLdMgGpvy5Py/MwiVdBkV2PtO5rQQVeZkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8e8163d94bbso3401788241.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621582; x=1759226382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnoTjylvxrxdgkjV6WJ+aZ2BUNyHdjRUjdJqPB2kS9E=;
        b=NNf9w9m97acg77fp9ph82IkpNYsGH9PqN9TJAo+OpU3bkqOAYXeOd999uYglhxLG7W
         MwUiFjoQrDFv0okfFIm5LkifFMXRgpxALtr8QAK9T2oXS6wbixcxrXO6g56iETolhaiw
         GnDhjbBx9Ts2uGicP0G8xixiQBCWzS6R4Bg2YbQtHFgord+Fvi98rOquax6jUJKKL8BV
         UghpufZmr3GDGboT6BDxnVHMROxyPjz43+NiWUsqz2OZL8MWP8avkvVEFDIFBxE3IVBk
         rU3jcT2msZL9a1Ran6EKTjzOnpllHiacOHVHVsoVMmMAUPh73oMN4HmLD5jkDDQ1L8gR
         iccg==
X-Forwarded-Encrypted: i=1; AJvYcCXtnWdsIeZHA21sPwnqkw6n1m6zhD1rup0P9Me5aoKK5lVPnOf6XjhaRWnkNd8I//KsU8GipUHgfSpOnpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxorQfOcotFgs1pRXX9eGTt6qSqzdJk6rd1JbNtMpovxArcPnLa
	xdm11m3gDr8NJyd28Wz6maqdQqDSwBO6y5yTjF0vQ/UYDUI9f/n2Zte0Ng5WYyrb
X-Gm-Gg: ASbGncskXLUFY9xlk5utaH/7su/yWqe0Y62eQ4xwsKPWGsU2b2mO9GtIeaB5TdYs3tP
	0JsdR28EdAVDWdaW8Pv7yAyEYObcmqygHi9+0KINMe/TsOawl7ifr1nNLZLO6K3X1ymEkobO+dH
	rTibIXM5Ws6dLdWO0NApNpygisGrcm4+xdTM7itBGIG++CFKkGUdgQ3MEU4Po8AXM2xUObRZnj2
	d1QewTyG6Kp4vWCWU5kOlcyR5ZKenJaPcEXe4FULZxPa4RPGmn2xQEfspIvVfL6hw9VYAJL6YCC
	8LDGN4eO5FCAZZ1tP9+k44FeLXWlJ2W9E/fcAt1cfeYo4NWZHDdmwHFKZ+FWgHO5rx3Nc9ccOcT
	x6TQ5msfFz5yMNBABGAXmDCrFH5RKhF/uUbTu0xMxWnSTYxq1CKO2NoxK0lzd
X-Google-Smtp-Source: AGHT+IHcWxx12Dvz+Z1NXDZArTkvCJoinQgSnF2SYQsWiQNvC4k6ZG6JhWnhJz6X5eadgvvFibkwng==
X-Received: by 2002:a05:6102:32c1:b0:5a3:eb34:6105 with SMTP id ada2fe7eead31-5a57b993f3fmr706393137.26.1758621582341;
        Tue, 23 Sep 2025 02:59:42 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5a3d7d08f7esm848470137.17.2025.09.23.02.59.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:59:41 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-557a2ba1e65so4794130137.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:59:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPX6uNgy/PH8mwdY5JD0+JIzWBdwtIivA5oSAjyzp7WGys0orOYH3DojpH0VCq2ox8bbQIs9Yq4gprWlY=@vger.kernel.org
X-Received: by 2002:a05:6102:a4a:b0:59d:6be4:5b97 with SMTP id
 ada2fe7eead31-5a577be934amr649174137.5.1758621580798; Tue, 23 Sep 2025
 02:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923092846.74517-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <2025092311-espresso-collector-5f4d@gregkh>
In-Reply-To: <2025092311-espresso-collector-5f4d@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Sep 2025 11:59:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_UXyAaeriz8R0MO5SpWE_z4s8Ci6CEMFgVJr_XxDZzA@mail.gmail.com>
X-Gm-Features: AS18NWAf5t3cNSnr0jhWdIdKjaw8kVZxFdQZxsA5_eTxyzisEh79rb7MSnHdO50
Message-ID: <CAMuHMdU_UXyAaeriz8R0MO5SpWE_z4s8Ci6CEMFgVJr_XxDZzA@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Add missing header guard
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Prabhakar <prabhakar.csengg@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

On Tue, 23 Sept 2025 at 11:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Sep 23, 2025 at 10:28:46AM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add header guard to sh-sci.h to prevent multiple inclusions of the
> > header file.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/tty/serial/sh-sci.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
> > index 951681aba586..22f877e2a17e 100644
> > --- a/drivers/tty/serial/sh-sci.h
>
> Why is this a .h file at all?  It's so small, why not just put it all in
> the .c file and then there's no need for it anymore.

Until commit e76fe57447e88916 ("sh: Remove old early serial console code
V2") in v2.6.33, it was also included by arch/sh/kernel/early_printk.c.
Those days are long gone, so the time has come for assimilation...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

