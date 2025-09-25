Return-Path: <linux-kernel+bounces-833181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC28BA15D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F6C5605CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27C42750F3;
	Thu, 25 Sep 2025 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrTb4NOs"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E1EAE7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832444; cv=none; b=rwni0byE4ySWrlAAohHiW/3ev4dQac4P8l2Q/xDCivNkKABWajqWxGTALoQU2ynkPHUsd+jML/4iV/vRBYifCv1y/IOC7CsV/XS2NKma2i8FXF+F9uk6yHmi/Xe3DveKoWcsCDCnjZEUvLohp1ALCc7EbWA6S4v8E66Rrvu315U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832444; c=relaxed/simple;
	bh=eov/iSCa/iK2TYkvuk854T7RC9SZGSAIHojdpHSrRi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ukk3l9A1nzBWhd2eZJFGJix1M2RKC8g77WRNIP71rvwk+Fg8jCPRQy0UOUTRann8wTPpPEWjzwWIQlL6W9e2X+hOoVDKUJuq8ExlpqXxWqMFyiGcnZ6XgbzK6dlLvm2pT4Houb4iihBZEZ/1H1J3VSJMT8j2xQPOx0JOxga1iQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrTb4NOs; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5515eaefceso1348259a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758832440; x=1759437240; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JW9g8okKhyLoNQQNfrYpiUBtj6qzvQlSdy6yvpo/hSQ=;
        b=DrTb4NOsPJWhc9owWdECbj+8tGiQ5pphsyXaA6hl0YJtojjqZYe4xH1kQhcFIU87mS
         UalTg9PCqs0uAkU/b0uA0JTDlvl9RhLCPWW6GuPURvP1meM+sZVu8yx2tfpmQOdBc699
         zfYG4K2c3Ty50RSr4PYn2Vrc97PVk/G1A4tt95KmXzZv+u3NG/9Rt4ukP9V5TKTrBLBh
         oRgg4ONERl9cvdy3YoqXvaVBtk/ilhbVnVyFArIXMjRzVe3KQsyuyBy3L5UfuA4fbuud
         S7CEE4vucoXczkzeYzGFKzCSPiVRdzdgpMPj7yrxqOF+ZtCZ1jPZl962Iw+mzWGdw7PO
         o5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758832440; x=1759437240;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JW9g8okKhyLoNQQNfrYpiUBtj6qzvQlSdy6yvpo/hSQ=;
        b=DixkvWd2CGi6NXle6wELiph+7RUI/D3sF28zMMvjmxpSjw6aRfs274VAmwYTfgWQ27
         oifxS4AsIl05Mi+eYhBFonpHolkUjmifcmWo0npSQW9ROmYd4B9wLLcgO/TtXthv4Ac6
         JFKxQ4/oxHgqkVAFuw4S/pm39pXaRkkgOdTObrcVR5drUaieOD0dDxg/KVKr/uBRDJ2e
         DJJ5sfG3fk3GVIuSAQW6HSWkzaG0oFBGXWL3ZioypGQ6kiyfv212Xr/3Hz/R4+H49J/w
         yCMihL0V6yoB384nzGgvOHMLEJT+MmrXg0FnrxTOjS3vvitPdYecaqYyrbxD0Vbqeeg/
         TdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3s0MGo6HzpJl72LDWksngN1wdD4flFnHs+rfQRkBLSdR03mtOo4krovVWSEyKHo9PHDfm5xQfvmbQweU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycgYpbbDG+zf6SrUVwxGmL4NwK9/WYl1t5qFbwFAfvPFrIes62
	KBgd5M+ByIBVcItmlXhOlvITiCgoGXmdyJmqJPDrXUZSe2hUm4u+Lv5L
X-Gm-Gg: ASbGncuGfvkPq63H93x65eFl+6hPeZS9pjlbqYXLSZD3ikob5M7JFA8KiHevDBhc8GA
	m0iOscG7KCDQfXg/H0ZqG0s2lGaFMms/+QsNNiXVeiHEwPgV9LgHLp6wFjD3ryBBF9MrEXUkuct
	kh2A9shEvOv4jcLY1Af2uJKsYINGhOeoR6hp7rkn47nBhjV43eLmwuMZdH0FoyTVxKZ4CklqoRJ
	WvCXX6kdx9oBCflYl+jWyjVUR3Ew9BjeXAsWnhtyATyyEmUdReVUED01b0U63us9OKUwYv6kaqd
	muboHwfSNdPE5CfsQRedBNuObMXz5lvSOPPChAChQX+4CxN2Wj9/tqG09k8p5hgUFC5sllksa2m
	7VjiCvtWICI2Ulp6xwAr+kX+sfQvQBoY7bA8=
X-Google-Smtp-Source: AGHT+IFKV7F2em86yIFci+Ya3pm6AvUQm7/TupYdxSszwmUF+V7eMxc2dtI+OgZyupwiTVIhj+jk+g==
X-Received: by 2002:a17:902:e84e:b0:269:9719:fffd with SMTP id d9443c01a7336-27ed49b8623mr63633365ad.1.1758832440373;
        Thu, 25 Sep 2025 13:34:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed67076ffsm33224175ad.39.2025.09.25.13.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:33:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 25 Sep 2025 13:33:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Robert Marko <robert.marko@sartura.hr>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com, luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com
Subject: Re: [PATCH] hwmon: sparx5: make it selectable for ARCH_MICROCHIP
Message-ID: <4824134d-0286-4f9c-9b62-2f969e3245d8@roeck-us.net>
References: <20250924213027.1887516-1-robert.marko@sartura.hr>
 <f019dcef-afdd-4d18-b28c-b214fa14f1c8@roeck-us.net>
 <CA+HBbNFe+7XT3bSUEagsXiug-bmh=fBfLAW0d7WR73Di8-ozTA@mail.gmail.com>
 <357f9a92-df60-4e6c-9019-40a4adbf0702@roeck-us.net>
 <CA+HBbNHcO=NintKBz8CmYRruiuHM8EFU+wQjw0-JbGKMK2xv2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNHcO=NintKBz8CmYRruiuHM8EFU+wQjw0-JbGKMK2xv2g@mail.gmail.com>

On Thu, Sep 25, 2025 at 10:12:48PM +0200, Robert Marko wrote:
> On Thu, Sep 25, 2025 at 5:33 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Thu, Sep 25, 2025 at 11:15:52AM +0200, Robert Marko wrote:
> > > On Thu, Sep 25, 2025 at 12:07 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > On 9/24/25 14:30, Robert Marko wrote:
> > > > > LAN969x uses the same sensor and driver, so make it selectable for
> > > > > ARCH_MICROCHIP.
> > > > >
> > > > LAN969x _is_ the Ethernet switch driver for Sparx5, so this description does
> > > > not really make sense. Same as what ? Itself ?
> > > >
> > > > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > > > ---
> > > > >   drivers/hwmon/Kconfig | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > > > > index 840d998f850a..ba2b7b2f6c44 100644
> > > > > --- a/drivers/hwmon/Kconfig
> > > > > +++ b/drivers/hwmon/Kconfig
> > > > > @@ -632,7 +632,7 @@ config SENSORS_I5K_AMB
> > > > >
> > > > >   config SENSORS_SPARX5
> > > > >       tristate "Sparx5 SoC temperature sensor"
> > > > > -     depends on ARCH_SPARX5 || COMPILE_TEST
> > > > > +     depends on ARCH_MICROCHIP || COMPILE_TEST
> > > >
> > > > ... and silently disable it for ARCH_SPARX5 at the same time ? That is not what
> > > > the description says, and is completely unacceptable unless explained.
> > > >
> > > > >       help
> > > > >         If you say yes here you get support for temperature monitoring
> > > > >         with the Microchip Sparx5 SoC.
> > > >
> > > > ... and, on top of all that, still claim to support Sparx5 even that is
> > > > no longer the case.
> > > >
> > > > Ah, I see, this patch depends on patches in linux-next. You might want to say that.
> > > > Also, there is context missing: If the sensor is _only_ supported on Sparx5
> > > > (which everything but the dependency suggests), it does not make sense to extend
> > > > the dependencies. Why make the sensor configurable for _all_ microchip architectures
> > > > if it is only supported on Sparx5 ? Maybe there is some other series explaining
> > > > this, but this patch is all I got and it does not explain anything. It is only
> > > > confusing and does not make sense on its own.
> > >
> > > Hi Guenter,
> > > I should have extended the description a bit.
> > >
> > > LAN969x uses the same sensor as SparX-5, and they both select ARCH_MICROCHIP so
> > > SparX-5 only configs can still select this driver.
> >
> > You mean ARCH_LAN969X (in contrast to ARCH_SPARX5 and LAN969X_SWITCH) ?
> 
> Both ARCH_LAN969X (Which is now in linux-next) and ARCH_SPARX5 select
> ARCH_MICROCHIP
> which was introduced to avoid the need to keep adding new ARCH symbols
> to individual drivers.
> 
> LAN969X_SWITCH is just the switchdev driver for ARCH_LAN969X.
> 
> > That makes sense, but it really needs to be explained in the patch
> > description. Also, since ARCH_MICROCHIP does not exist for arm64 in the
> > upstream kernel, a note that this depends on other patches in linux-next
> > would have been helpful. You may know that, and others may know that, but
> > I don't, and digging through that cost me at least an hour of time which
> > I don't have.
> 
> Yes, I should have pointed out that this depends on linux-next since
> the prerequisite
> Kconfig.platforms change for ARM64 is in linux-next, but it should
> land in the regular ARM tree
> if its not already there.
> 
> If there is need for a v2, I will make sure to expand the description.

Please do.

Guenter

