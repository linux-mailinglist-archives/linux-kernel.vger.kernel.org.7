Return-Path: <linux-kernel+bounces-893742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68557C483A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BEA3B1CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D56328D829;
	Mon, 10 Nov 2025 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="TRx1f+E3"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A528314E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794191; cv=none; b=EhJzPE+MdWiahLet4/r+5zNVHzBwC4D/IpH+smc4kxUfMxSrhiSWQUhQOAwzGp9z2OCNm7MM2lILHTN5WtO1mfKCsBjhLTx474RjpctcQ4gbXFUyD4HBI3w7BCbE23V4CF+BTJrl0yQpdPNLzqSSWt9A9wZCyV/0Mqurk+f3XU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794191; c=relaxed/simple;
	bh=bpUc5IRSgpzDLBnY52fogL2+1joCffP321S3rG3MNoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXnH6Vl+NQo3PFILKee97ShcC04tHgngHIhTZyx9VTndHZTOjYmZPZhySmyI/aQ28pnzD3ZseITMvLIrCvdpuA/bPJAptdCimV7uokBsdxrGppGV+W7c0zLkkgQGjyAJsElokVstJ0u8UfFYkqJaWRGXZ8Ea6R0KztqNEbXujPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=TRx1f+E3; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id CD3ABBD71C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:02:59 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 27267BDA11
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:02:59 +0200 (EET)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 8BE4D201925
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:02:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1762794178;
	bh=12XFEHPdLRiFYWyYcTFu5vWOUn+IAVgXsvoL0hxtf+Y=;
	h=Received:From:Subject:To;
	b=TRx1f+E3ytZsiuswShU4SIa84qNdweQh/KtS7uVRnay0bugj/3DjknobdCmh2ebhv
	 dMfth0ZG623rU0H8MJpBJiq9f4gFdnRLa4MIBpKHPf0XKf1I7Aqq5YMb0inmZHeQg0
	 I/4XFsHRVeqaHmviwyZDrPvuEOzHO88nhe6VWRB3M0PyGuuOK07/bxbAG4WvIGqzid
	 3Tj9G6sqmjLzsPULTDUWeOw1fbidYZMBipDUE2T11YqoKrJNayVm0xVQKVBYHD5zhw
	 hYEYycoJVI1sDBNWPOOP/gsfXO3asdX1Jq+eWqZ5Yq147ASWlgUKyWk2I9On+TEzKr
	 SD13wM7RgAQPw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.174) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f174.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-37775ed97daso26647861fa.0
        for <linux-kernel@vger.kernel.org>;
 Mon, 10 Nov 2025 09:02:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVZvBb0XuV9ARtwQtzDrQeeB8ZASRl6Ho1JcfDXzvJOb8DCmxYs+690aCUM2vwcIgje7zlMG2lphlZk3Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbMQg92gQbyAsXgBJF314Kh2bROu9Fs7NG+dNYf+a7YhbPsiMr
	EvxGrKDIVABhgKdO+2bOCp3XtGJgfmuWbParA+zkn2deJn1D9U0hF9ikPdefqVxGKRTKBDcHyUv
	0hpyjNF4GcACgq8w5bL2uZYG8mZ70HqQ=
X-Google-Smtp-Source: 
 AGHT+IHX191KArmmK3K6jhrf4BcpXpAv4RRw2PR1iGD5WvVgGw4SVp+bxRT0HjwyDMvzvvmV9meSD6pod4PARGoCw7s=
X-Received: by 2002:a2e:8509:0:b0:37a:d20:3215 with SMTP id
 38308e7fff4ca-37a953238bdmr144571fa.6.1762794177957; Mon, 10 Nov 2025
 09:02:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110111253.16204-1-W_Armin@gmx.de>
In-Reply-To: <20251110111253.16204-1-W_Armin@gmx.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 10 Nov 2025 18:02:46 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHq45Bj4FgRyrmd4dvLkR_hUGB7wVDUdtttR13sJGHHyw@mail.gmail.com>
X-Gm-Features: AWmQ_bkFjkYivZ-3eYLTyeuQ68uQc5hNIm8qIROiP39Yc_Q9aTdgLJ_pjUHntFo
Message-ID: 
 <CAGwozwHq45Bj4FgRyrmd4dvLkR_hUGB7wVDUdtttR13sJGHHyw@mail.gmail.com>
Subject: Re: [PATCH 0/2] platform/x86: msi-wmi-platform: Fix autoloading
To: Armin Wolf <W_Armin@gmx.de>
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176279417884.3435279.14917555721555669297@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 10 Nov 2025 at 12:13, Armin Wolf <W_Armin@gmx.de> wrote:
>
> As already noted by Antheas Kapenekakis back in May, the
> msi-wmi-platform driver fails to automatically load on MSI Claw
> devices. Back then i suspected an issue with the device firmware,
> however i just found out that i made a silly mistake when specifying
> the GUID string of the driver, preventing the WMI driver core from
> matching it to its WMI device.
> Additionally i noticed that said GUID was copied from the Windows
> driver samples, meaning that it might be shared across different
> vendors. Because of this we have to prevent this driver from loading
> on non-MSI devices.
>
> Compile-tested only.

Works great. Module loads normally without intervention from userspace.

I could not find an online reference for our discussion so I omit the close tag.

Replying to the cover applies to all patches if my understanding is correct.

Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
Tested-by: Antheas Kapenekakis <lkml@antheas.dev>

> Armin Wolf (2):
>   platform/x86: msi-wmi-platform: Only load on MSI devices
>   platform/x86: msi-wmi-platform: Fix typo in WMI GUID
>
>  .../wmi/driver-development-guide.rst          |  1 +
>  drivers/platform/x86/Kconfig                  |  1 +
>  drivers/platform/x86/msi-wmi-platform.c       | 43 ++++++++++++++++++-
>  3 files changed, 43 insertions(+), 2 deletions(-)
>
> --
> 2.39.5
>
>


