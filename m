Return-Path: <linux-kernel+bounces-880626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DF8C262DC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6018618923CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6239A2F49F0;
	Fri, 31 Oct 2025 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="hwCBhYZJ"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881572F3615
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928725; cv=none; b=GC7OM16EXXUBlwbpbDnWOC1eZMw7o7PZjJ1WH1JFNw3F5rp5652UVknsgvaUernf/nzaUWg21IyyDm/Gsrja87yXXAvqbobHXTNhHgAGrdI6ktlIsLtpMfHAbc3yMAXNDJs9qBA47LIlvpX0xfpVU8zEPjXl1iTWjq6OX3wTW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928725; c=relaxed/simple;
	bh=NNluwfpdsA26+gPsB5/AnOEGDLqICL27K25ESYNJAnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIlF3g9k4DtyQ4VGyley1jlwHICwuokDl9Vw72i0m0/vmqcSI1JMRT1SnIGyd1g8PDSRSGs2ZD3DuFZhXYMNrIEM0C9pzrHMXwGHG9H4tN4TFvz/jGVW8DylwfCutP85HQgm9hKvUoiKpd373G2Q83O1ZvSVbNiV4eX4QZGMK8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=hwCBhYZJ; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 86EF8C61CC
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:38:36 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id CAAC5C6032
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:38:35 +0200 (EET)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id BBFB3201B6F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:38:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761928715;
	bh=vYurqirQve9/a5aO1JzYrhU8itgV0sUSBiyRfLUlTA4=;
	h=Received:From:Subject:To;
	b=hwCBhYZJfYckf6kyZRda93k6mfX4BqPzmGHMfnjoD1fZ0FW8hBWHba6YvNC1kODwF
	 XDO+SV9YGVvaDBLVOcROYBzeX3/uQGW7C8zOY5bPoeHPtNGs+f/7tp2UkTx/CUiuc9
	 uE7fuuYUmqBupDKPmTfPfVGj9EslTFabqhNd1LE7tJ8WWkY9ngFVkdo/PJG7/E8sz5
	 jMqnuWhPTcvyerhLrJEEDmyFvXmhGiWL5PDWZh9kAr9KHM7YHnrF2jvChU/eWWcx6z
	 0XJUYgyKVD7zGJY9KsF5u0tTgja2MYM/Xkosl9uOmksQIxvSPetutEdq9fVnGQcs0F
	 Q5ieufm2TPhYQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f180.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-362e291924aso21485221fa.1
        for <linux-kernel@vger.kernel.org>;
 Fri, 31 Oct 2025 09:38:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YwWnpTFuHDiCviernAQV4ODuzzE5S7IRTC1KBwZ8ucWoisyttQO
	SwjJTl7BfD5+v1Ex5s9umZIqfGOxwisdQ0aO05dBsqErPN2ALY/gqfvc9fqOo6OC8NX//HUXfVG
	l3Rj5Khlg0qcC0OoOme6PvSyJzRVdtDM=
X-Google-Smtp-Source: 
 AGHT+IFfCsCUm1dDa21cbpuFbjCe1k1ojogD+tE28Iv1A5p0JPMdEYf4rV/aPw9ZlxpB7cs3YdzdBVQZxVyb6hRNJro=
X-Received: by 2002:a05:651c:b2a:b0:36a:6540:3bf7 with SMTP id
 38308e7fff4ca-37a18d9b0d2mr16432791fa.18.1761928714107; Fri, 31 Oct 2025
 09:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031163651.1465981-1-lkml@antheas.dev>
In-Reply-To: <20251031163651.1465981-1-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 31 Oct 2025 17:38:22 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHk_wrS8zVRb9-QKpY5TrV1pkksxG5uO9-Db36N7RDo6A@mail.gmail.com>
X-Gm-Features: AWmQ_blnBmAcgxio7jFrhdMKYsqJ1-YkjaR-opcyMQwFHUHh8QiAmlMVUhDRquk
Message-ID: 
 <CAGwozwHk_wrS8zVRb9-QKpY5TrV1pkksxG5uO9-Db36N7RDo6A@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176192871533.3955770.8447345483872397982@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 31 Oct 2025 at 17:36, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> This series introduces a platform driver for Ayaneo devices, ayaneo-ec.
> This driver provides hwmon support, power management, and module management
> (for the new Ayaneo 3 device). Module management is done through the new
> firmware attributes sysfs interface.

I resent this as V3 didnt I. Mmmm

>
> Luckily, all Ayaneo devices with an ACPI mapped EC use the same registers.
> Older devices also use a memory mapped region for RGB[1], but that is
> replaced by HID in the new Ayaneo 3. Therefore, this allows for a simple
> driver design that provides robust future support. The memory mapped region
> can be upstreamed as a different RGB driver in the future or remain
> out-of-tree[1].
>
> This change also allows cleaning up the oxpec driver, by removing Ayaneo
> devices from it. In parallel, charge limiting is added for these devices.
>
> [1] https://github.com/ShadowBlip/ayaneo-platform
>
> ---
>
> V3: https://lore.kernel.org/all/20251015084414.1391595-1-lkml@antheas.dev/
> V2: https://lore.kernel.org/all/20251015084414.1391595-1-lkml@antheas.dev/
> V1: https://lore.kernel.org/all/20250820160628.99678-1-lkml@antheas.dev/
>
> Changes since V3:
>   - Fix various non-functional nits
>   - On hibernation restore, use restore instead of thaw, switch to bools,
>     and restore fan pwm mode, but only after the first pwm write after
>     hibernation. Also, release pwm when entering hibernation.
>
> Changes since V2:
>   - Remove i counter from suspend hook by hardcoding the index
>     (we already allocate the maximum size for the cache anyway)
>   - Rename quirks to end in quirks
>   - Add missing includes to controller sysfs patch, use switch statement
>
> Changes since V1:
>   - Use plain sysfs attrs for magic module attributes
>   - Combine quirk for power and modules, so attribute tree is simpler
>   - Use switch statement in hwmon
>   - Add hibernation hook for charge bypass in last patch
>     - Restoring fan speed is a liability so it is omitted, see patch notes
>       Note that for EC managed fan curves, it would be acceptable
>     - Regmap comment: Using regmap is unprecedented for ACPI mapped ECs
>       and overkill for one value (> 100 LOC)
>   - fixp_linear_interpolate() comment: it requires importing an extra header,
>     is not used for static parameters in other modules, and expands to the
>     same equation for parameters used, so it is omitted
>
> Antheas Kapenekakis (6):
>   platform/x86: ayaneo-ec: Add Ayaneo Embedded Controller platform
>     driver
>   platform/x86: ayaneo-ec: Add hwmon support
>   platform/x86: ayaneo-ec: Add charge control support
>   platform/x86: ayaneo-ec: Add controller power and modules attributes
>   platform/x86: ayaneo-ec: Move Ayaneo devices from oxpec to ayaneo-ec
>   platform/x86: ayaneo-ec: Add suspend hook
>
>  .../ABI/testing/sysfs-platform-ayaneo-ec      |  19 +
>  MAINTAINERS                                   |   7 +
>  drivers/platform/x86/Kconfig                  |  16 +-
>  drivers/platform/x86/Makefile                 |   3 +
>  drivers/platform/x86/ayaneo-ec.c              | 582 ++++++++++++++++++
>  drivers/platform/x86/oxpec.c                  | 115 +---
>  6 files changed, 625 insertions(+), 117 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo-ec
>  create mode 100644 drivers/platform/x86/ayaneo-ec.c
>
>
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> --
> 2.51.1
>
>


