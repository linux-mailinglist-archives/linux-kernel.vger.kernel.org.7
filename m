Return-Path: <linux-kernel+bounces-892990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5C0C4647E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA933AD750
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC2230C639;
	Mon, 10 Nov 2025 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="EUwo0W1d"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1130BB94
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774299; cv=none; b=tT8Myu+43qgVKm2pCQ1MwuH+FsDGoYXX9HBrayuakZyQfaOKZF4DjdutHfhp4s9/6IhzflZeRw4cNd/ZyWC5U/6WnAOX80w8vE1F5/BgHSXyBn8oFfTi5wU/M2k02OmmwmJx485JYNdncsK7tV3gojnRNYGwXA3yo3421fHJDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774299; c=relaxed/simple;
	bh=KtbcQuiFp8d7IkC2vqgRHkSHD/7Ct0/C86WkZt3s+bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVB5cwIy1JKRhIbeN6nmHyVy2P5sKJmfxDxcOHzA1BGkc381poFaPLo8wjjoh9vJ8JiXkK20ebefZUmljLUj4RoaA5TRdVAiT2cSGpoMLX/bgWbVGERAg7uuK6oxF40v8fPxHVsIeuetGv6Zw0LWePoQb/gJT5Hz18xvEZckFWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=EUwo0W1d; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id DDFC93F3A9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:31:28 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 39C663F4DD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:31:28 +0200 (EET)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 588EF200B90
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:31:27 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1762774287;
	bh=IeSnBNotDjw3R7VnmJhVdPttuuVGctIrZk+RSexiM1c=;
	h=Received:From:Subject:To;
	b=EUwo0W1davKQUnJVUZ6s6IsF/6WdRmV9osG8CYsgyfwd4durzcqTnnRAETaljswiK
	 AMmb88gyfyXqJ9NSKG+Dwcb3NCNb+7LDTiYGb5HZd/hY3PCovzu6ZU1ETYd7KiLYM1
	 j3oAItn5IlkXV2U33R+XSG1lI+8MH9aVIPi2ShO1rHvY+BFMIhBV8FWQLpXAvrAcKv
	 hBPv3jEMi5LeDUNGevzgvbvwR54po2Q00dBxMivhhdcURsUzFVTBX5E22O2CJg06bY
	 JudSuSV/ekBPlhm1YUBf6imUsmryOuVhLVfEi28sPS27lwd8OC85tq2yEUA8GZVoNb
	 RRR0NSp9g2Q8w==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-37775ed97daso23659971fa.0
        for <linux-kernel@vger.kernel.org>;
 Mon, 10 Nov 2025 03:31:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUe/w8Z04Z9PdR76lgsKZUN2gWNQpzeRJJtq1q+3aek6i6fvuQcHRk9H4+kH2f07Omdonxb/7steSolLME=@vger.kernel.org
X-Gm-Message-State: AOJu0YybUAci/aqT5wd9LCuw6OYt/SVh6E5qXG/9jyTeKJoyjHUMj9R1
	ZmuS3/ThCduA7rVguE9PWoBa5u7Y2Ihu92ywwqGOIOkJHGwE+1PjeZkCe1YPWTj6XSC+Y3mcy4U
	5TLKd33Sd21Tme2wZXVcAgujr1d4r98A=
X-Google-Smtp-Source: 
 AGHT+IHwlop8iQyLf816B5t3NJ+WnCUY4vjIic/wmY4CcU7fAIzaPagQklkeFNoOWwBy7j0dz/kU76Es7zzx4EJY/P0=
X-Received: by 2002:a05:651c:1307:b0:37a:421c:cc4f with SMTP id
 38308e7fff4ca-37a7b24a069mr13366291fa.16.1762774286862; Mon, 10 Nov 2025
 03:31:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110111253.16204-1-W_Armin@gmx.de>
In-Reply-To: <20251110111253.16204-1-W_Armin@gmx.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 10 Nov 2025 12:31:15 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEfSVYVWU86ibQB3Ea3sZT9HagZzhFnfkF5kEmwz1cz3A@mail.gmail.com>
X-Gm-Features: AWmQ_bkyaZ6Slz3nV5eHZccE7lAPxm6A9KqGQn76MiECU2M-muGX1JVUobXSJxI
Message-ID: 
 <CAGwozwEfSVYVWU86ibQB3Ea3sZT9HagZzhFnfkF5kEmwz1cz3A@mail.gmail.com>
Subject: Re: [PATCH 0/2] platform/x86: msi-wmi-platform: Fix autoloading
To: Armin Wolf <W_Armin@gmx.de>
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176277428779.2201203.719403608977557455@linux3247.grserver.gr>
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

Can you add a closes with a link to that discussion and a reported by?

> Additionally i noticed that said GUID was copied from the Windows
> driver samples, meaning that it might be shared across different
> vendors. Because of this we have to prevent this driver from loading
> on non-MSI devices.
>
> Compile-tested only.

I will try to test this in one to two days and will add a tested by.

Thanks,
Antheas

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


