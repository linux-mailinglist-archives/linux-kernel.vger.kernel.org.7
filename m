Return-Path: <linux-kernel+bounces-750640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B74A2B15F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 525037A117F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8283D28726C;
	Wed, 30 Jul 2025 11:08:26 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128424DD13
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873706; cv=none; b=a6a6N0Irb/XYn6AeZJFVIS9FPAVknHhtcfEemEiQKJ1xHOuQQRkFKfTMeZ22YoybgqyZVQAVC2oXYoloGJv0ACjwLMYkrj1iyN8PMYVH81DFQTVvNU5cUONcbII2kBHpJ+pY/9UIBUob++xKVmLkiXm7DIbOY9TDCyOObacFq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873706; c=relaxed/simple;
	bh=5afOcZkkPBR+ktNfxGbTSl9VvY/xoMfMaa8tBiAFR48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ickgTKf87HJnoLXqLAtMVwsQvtvqRLi/mMoj+R6xqgn7PZJ5IvA+tXKWjCiUV0OgXbenxPII6Tg60bsFJaGcLH8CDaxsli96LYwhenRCz2X48LDHMINC2LWRXJ1194gIOz8nQBJYocp4DrfmtE0Bg7ES2ftMpPPVVjbGCfSWqUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-53927febb37so121432e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753873702; x=1754478502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahUCMop3bpKiOm+Wykn3VajG+gXKSw9MPNL+inB7AHI=;
        b=CyCFHttOv631m3gO/f9/1cy1j4ViVbeMhAl7UqfDW4fUCq0kMFe+J8LgKds7UMRQkn
         q1Vja9uEQOBrW/nbUuS4hhPWYFvFel4oWhappUKxamDLlqcO/diYwE81EbyKqvFiEvyP
         PWWe/oV429zjlXnFfLEvNofFoaJHlJYAGRvH5ESpedF8vN85Sd+RkGLzVmLe7wIeDM6A
         ECLsKGBNK/IkZxjkowp31SLIQJlmxkU1IvXFukwCYN2Dt71ZkT+1inV+kt7TsBOXkEUY
         embDdVkTcVEeFHPfQG+haIQ3ufrHdMllXYscDpPPlNUM3/Zgej8uwsvHcLjrxPkmPLIM
         L/uA==
X-Forwarded-Encrypted: i=1; AJvYcCXr+K2ngHirYvl8cvpz4Cn26g2+F+Ns6rAD9DbRmtTOPD1X3a6B02nlaDG/sGLhI6yOIME0F0B/btxK1fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKdYL8HaqEpQVxI3G0W+adkfMDWvFT79Ffk9HFgKccI6b4TeTf
	vwmFcyiR2BGGV4/6nAvArHYkiBSVq1mEb/3DXrIXAl1PuxtwvsnXgSLYNjSeglOJ
X-Gm-Gg: ASbGncvcJ4fgCXQIe+4ub1CVF3VNX+f3otPaEQOtRdgU6+FKbbpBPhwXUhJGxjSr0Kn
	1+URP9M853TTR2whi0qQ/N9LsYkYadpQTIewAxubcHUJQPIpl2KovgconebNCbX6fXQwJYmLXIy
	XZYjg9xSFcbVlvSSawP18ztsVaR54gW7sSogjmYE7ey1kZGEkKPrrGHpfubgImzTAgWJNV8m61F
	1hSf3Fi33405Zmo2n5yaMdML1Tib1OywhB+kOWUlybA1+OGl+h0ZaZe3/Z5B+1TYph1ZzSPj7sd
	0O9b4YRb0glhuTIMkUUfl68VEBF4dnIa/i8BBSH9jpcxOsb3r2GsBiLRcLh7qsua1D6GAEtoI/4
	oBaBu/cB4/FGO/3iZrpqcoa8o7jdxQO5TXTfErvlvaSPbTEd4pMsYcPuf3MNi
X-Google-Smtp-Source: AGHT+IGyYrhUgbTGOt5elaQ0kOfO2rW9EfUmokVxyPEXqU7wPB8XYRIAnOPa7Ly60E7RvCqCVujVWQ==
X-Received: by 2002:a05:6122:178d:b0:520:6773:e5ea with SMTP id 71dfb90a1353d-5391d01e0ecmr1490162e0c.7.1753873702491;
        Wed, 30 Jul 2025 04:08:22 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88bbb862751sm1090499241.14.2025.07.30.04.08.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 04:08:21 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4fbf83972d4so118606137.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:08:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJ2++OrFRnkCWxALZRewJ7H5MBzakk2zVdawN7OYylCAvTa/dzOSxxFt90d8ekhpgHot79DS8Gu7l3Rro=@vger.kernel.org
X-Received: by 2002:a05:6102:3c89:b0:4e9:92d3:d20 with SMTP id
 ada2fe7eead31-4fbe7f213d2mr1535475137.4.1753873700890; Wed, 30 Jul 2025
 04:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <07f67ab8ee78f6bf2559131e193381aafff7479a.1753870424.git.geert+renesas@glider.be>
 <d947168fd02d6f820159b456099e6aa8f465b633@intel.com>
In-Reply-To: <d947168fd02d6f820159b456099e6aa8f465b633@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Jul 2025 13:08:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUJF6V4v1+zbKKG1A_UvHUXU-ySXe7Xj_ryZtRnk2B2nQ@mail.gmail.com>
X-Gm-Features: Ac12FXxXSRSoyCnpPN-TGOuCCRieREZmYvROY3pFS74W6252E9pQuxR7Z8LUGgU
Message-ID: <CAMuHMdUJF6V4v1+zbKKG1A_UvHUXU-ySXe7Xj_ryZtRnk2B2nQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: MTD_INTEL_DG should depend on DRM_I915 or DRM_XE
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tomas Winkler <tomasw@gmail.com>, Alexander Usyskin <alexander.usyskin@intel.com>, 
	Raag Jadav <raag.jadav@intel.com>, linux-mtd@lists.infradead.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jani,

On Wed, 30 Jul 2025 at 12:32, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Wed, 30 Jul 2025, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > Intel Discrete Graphics non-volatile memory is onlt present on intel
> > discrete graphics devices, and its auxiliary device is instantiated by
> > the Intel i915 and Xe2 DRM drivers.  Hence add dependencies on DRM_I915
> > and DRM_XE, to prevent asking the user about this driver when
> > configuring a kernel without Intel graphics support.
> >
> > Fixes: ceb5ab3cb6463795 ("mtd: add driver for intel graphics non-volatile memory device")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/mtd/devices/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
> > index 46cebde79f34b0b7..f0ab74d695347117 100644
> > --- a/drivers/mtd/devices/Kconfig
> > +++ b/drivers/mtd/devices/Kconfig
> > @@ -185,8 +185,8 @@ config MTD_POWERNV_FLASH
> >
> >  config MTD_INTEL_DG
> >       tristate "Intel Discrete Graphics non-volatile memory driver"
> > -     depends on AUXILIARY_BUS
> > -     depends on MTD
> > +     depends on AUXILIARY_BUS && MTD
> > +     depends on DRM_I915 || DRM_XE || COMPILE_TEST
>
> I understand the intent, but IIUC auxiliary bus usage should not require
> a "depends on" relationship. Couldn't you have MTD_INTEL_DG=y and
> DRM_I915=m just fine?

That is indeed a good point!

What about

    depends on DRM_I915!=n || DRM_XE!=n || COMPILE_TEST

instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

