Return-Path: <linux-kernel+bounces-832797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9247BA0622
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED381C251F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F062FBDE0;
	Thu, 25 Sep 2025 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doWKcJd1"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281FE2EBDD3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814416; cv=none; b=FL5Ls1QZ5lDdUCoLrIUSdBFyKGFobmlIU5QrNOy0DARv484WXRduEdUrNoashcmUzr1a7oqwutIe3UQoMfvMG0p7e0hVzYh1jJIP3UE7pHDxwTa7z+3z7yHL98V5UxiKYwHqnqmVa8+/YNzLmN3NASfkUN0QVMSFR/XgF63JcQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814416; c=relaxed/simple;
	bh=y2f0xu7wv3XLv8dKgE4HDyUHFQ5s5JkkjhxH7P7EpY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF3v8o6qx/t4wZ1N//e4HE8aduWo432DeypdQQpekXS1rQ40V7m5g2KN23Dy/qYAYOD5hvHtVS6YmgUiUON0ZdYsUhZ0DaVFk9SH/5NxbmKr9TJMDxp952h5rWK+k3CzVd3ql+o8MlOVjvNdFY7ei5wIbmEA+P1dkej98LUbd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doWKcJd1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so1588504b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758814414; x=1759419214; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xf9bl4gXuz6FgQKlCMIiNMUUiPGI8bVvlKEA/vte7D8=;
        b=doWKcJd1ylcX08xi5HlT4/6sXr+K4/e4N+hSbGQJThcS+IF45Ozpfq0dOUf3joXnC5
         kMBRSmtJPNglWy5LE902oE0XMsLxYM8Tjagw0zv7mvaJYQMziDy6Y9Jx6kMXejTgp0ex
         pmsKVMLhZVRqeciZg+alQmKdpstVWBuU9uS+UL+bzaXFVIRVvfZ2C5simUy2l9+U9lWd
         CzViNLeT6bMpvyNq5FJxQTosU7MbukY3bfJvluMe53eJQasoVd0GwrEO9szwOUiK/QDC
         qagrP0LcxKkzRaosDBP1VF/aXiObtyI1TFoIbkrXdBjGE5SCRkQg8AQd9VODSRJG+hyo
         cF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758814414; x=1759419214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf9bl4gXuz6FgQKlCMIiNMUUiPGI8bVvlKEA/vte7D8=;
        b=TLoYvu1tfA+K3ZSGGTI2U+Zu+6yxMsMI+zQccJmM3owpRnx4GdIwVjeqOhmHGO6yuN
         iv2Sq/ghpcJv2qMcc7W1b8B+Wx5DUMDOObFOIXQc/HNxs5vK7BL93CrVOT1HxrtIbRO5
         LbCDw3eIM78wfre0rsvO76kgDmqhDB7QfDknLHDYlo2K7/VJ91e8TM7D8INTQxQUNlcX
         dwT96/wdKXUELpmifq6O4n77rGLB4lb9iDBVQBGNRmSyDI43olSLUoQE0nTKCiG+U9ls
         BmzOp8Lz+AZahocjLTI9oV2SXHL5BBDDImzNHRu40Gb7mqxUiI35W2wgviM2F4my8d8x
         qC5A==
X-Forwarded-Encrypted: i=1; AJvYcCWAYqG/LvJnRthI7kuoKbNSsnkljIUOUzTsqsao6aXDaI7gjL7H+wXsrUKU0guPpV0tx1BU11dv5e8SHv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygXF7g1YgaDZMvnj4eM4/ogdY7tcSe457HX/FL9a/qJbZDdHwi
	hWuDZ9vhcDruVDcVTp2SJGHtt8+zdbitiHUzMy0AI89uq7DyAUNaHWh6oVU0+4PT
X-Gm-Gg: ASbGnctacsmXunE3aupci2svec9GXs5twGhPdrr700MIjKiNHzemv8CBJtMW2MP9q6E
	Og7hqZ38Jj5EZtQlfRy0rvHj8oVmgq1FvFV7xmGtRaymHp3KupfGwyxjqwn57w9wNr1SKJXl5lP
	HGfPKJJLrMs2X3gUIrtf7/kwUFYVhn1XY/YNr0lbvDyUDyHZwQRhQqIiKbexybfxg65p6VxxtU1
	/2sQQ7zeCwLGZthOiGnReBnEanfwuhOZHlmHSnVhTPXAHOTsrc6iy+20Kl43lx0hhnYvCp/6a2G
	/XUddzRBmiTux0zgwhOjJBF+Rgj0c60/SNTok5l5S5za5yhvUBLh3Iz+iAdLo96lCHRbs7IMCIN
	yojO99cPN4cKSXwnMNf9MfO4u3q0j5FX/R1k=
X-Google-Smtp-Source: AGHT+IHueQ5EwcgB7ykT7do2ipeVpALEK/2VdRb/5C0SGUSwtjUhr3wKi5API/uav1K3AF6ZVnpvuw==
X-Received: by 2002:a05:6a00:3d0f:b0:77f:29e0:c807 with SMTP id d2e1a72fcca58-780fcea2e20mr3963061b3a.16.1758814414297;
        Thu, 25 Sep 2025 08:33:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06e67sm2212018b3a.91.2025.09.25.08.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:33:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 25 Sep 2025 08:33:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Robert Marko <robert.marko@sartura.hr>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com, luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com
Subject: Re: [PATCH] hwmon: sparx5: make it selectable for ARCH_MICROCHIP
Message-ID: <357f9a92-df60-4e6c-9019-40a4adbf0702@roeck-us.net>
References: <20250924213027.1887516-1-robert.marko@sartura.hr>
 <f019dcef-afdd-4d18-b28c-b214fa14f1c8@roeck-us.net>
 <CA+HBbNFe+7XT3bSUEagsXiug-bmh=fBfLAW0d7WR73Di8-ozTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNFe+7XT3bSUEagsXiug-bmh=fBfLAW0d7WR73Di8-ozTA@mail.gmail.com>

On Thu, Sep 25, 2025 at 11:15:52AM +0200, Robert Marko wrote:
> On Thu, Sep 25, 2025 at 12:07 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 9/24/25 14:30, Robert Marko wrote:
> > > LAN969x uses the same sensor and driver, so make it selectable for
> > > ARCH_MICROCHIP.
> > >
> > LAN969x _is_ the Ethernet switch driver for Sparx5, so this description does
> > not really make sense. Same as what ? Itself ?
> >
> > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > ---
> > >   drivers/hwmon/Kconfig | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > > index 840d998f850a..ba2b7b2f6c44 100644
> > > --- a/drivers/hwmon/Kconfig
> > > +++ b/drivers/hwmon/Kconfig
> > > @@ -632,7 +632,7 @@ config SENSORS_I5K_AMB
> > >
> > >   config SENSORS_SPARX5
> > >       tristate "Sparx5 SoC temperature sensor"
> > > -     depends on ARCH_SPARX5 || COMPILE_TEST
> > > +     depends on ARCH_MICROCHIP || COMPILE_TEST
> >
> > ... and silently disable it for ARCH_SPARX5 at the same time ? That is not what
> > the description says, and is completely unacceptable unless explained.
> >
> > >       help
> > >         If you say yes here you get support for temperature monitoring
> > >         with the Microchip Sparx5 SoC.
> >
> > ... and, on top of all that, still claim to support Sparx5 even that is
> > no longer the case.
> >
> > Ah, I see, this patch depends on patches in linux-next. You might want to say that.
> > Also, there is context missing: If the sensor is _only_ supported on Sparx5
> > (which everything but the dependency suggests), it does not make sense to extend
> > the dependencies. Why make the sensor configurable for _all_ microchip architectures
> > if it is only supported on Sparx5 ? Maybe there is some other series explaining
> > this, but this patch is all I got and it does not explain anything. It is only
> > confusing and does not make sense on its own.
> 
> Hi Guenter,
> I should have extended the description a bit.
> 
> LAN969x uses the same sensor as SparX-5, and they both select ARCH_MICROCHIP so
> SparX-5 only configs can still select this driver.

You mean ARCH_LAN969X (in contrast to ARCH_SPARX5 and LAN969X_SWITCH) ?
That makes sense, but it really needs to be explained in the patch
description. Also, since ARCH_MICROCHIP does not exist for arm64 in the
upstream kernel, a note that this depends on other patches in linux-next
would have been helpful. You may know that, and others may know that, but
I don't, and digging through that cost me at least an hour of time which
I don't have.

Guenter

