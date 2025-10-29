Return-Path: <linux-kernel+bounces-876665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD0BC1C19B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 262B9588DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE0734A76D;
	Wed, 29 Oct 2025 16:08:23 +0000 (UTC)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393433375C3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754103; cv=none; b=ithNrnvdg9EwBK9lN8EtIqT/7AjXmMNLTwwvhMxLaihKXEB7k0O5mGKBYIEInzm1iWXnBpA/OQhwzU7HZ194XeYpfXttZxaDrOAKMsiTRuTBsBbOmh+iYWa1DPtq/K4It5mroX03rPk53DJFFB00rO5sqL+wDvw+ThAMxLArKsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754103; c=relaxed/simple;
	bh=x7hF+/Cp6WC101sN6xlMTM+BgF2Pmoe9fIFD9LQyyDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJ8Pu6cAGREBo1MXCuS2o5nBhcOnvBIr5cb+k9hWoGEzcj/EUvV1hxEzZjWYF/UseSxuQBwkspxFWLf7lw4eCDKG19OqaOXXO+4RzwMAKTdL+FvjKdwLJFYVwWlj7avyP1/2kt4JAtrulRYzfSUmABIHwqNPUuauARLyINgs4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-932e6d498b2so17053241.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761754100; x=1762358900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/ipYGthC0MioeorbLHvDmgjrqF5uNCNGBSSRMGKMZ4=;
        b=EWsgBmnbNVIhXdRbgyAzZg+GiliNgd2+1UxdApVqZIkqLbEfXHUFFpopr31giY3q4d
         Tnvbjey/F94NKtoaBKerYhibzJSh6EYhGbWN5qLCdnnvLz0vR47q6LDLgibZSLKgd8Kr
         pueF1EVWMvz4kPtYRUSMOEV+iDkQyvvrqw6Yfd1t6rQAYuE6gEaMAH+Fz9WI246vEBlJ
         HkgBkYJDVrRPw2TfYJWcV7lLBfWLLd6GOSDq00jJoAjFZM9Tho1kWOWP6tLGY1mHfNwL
         35i3hWa7w6GqYo0eYEKvg5RG156PD62oMa/oXncJAi7mo+johYBJPAVm745jVz1gDqpd
         +qIw==
X-Forwarded-Encrypted: i=1; AJvYcCXr61arKzH1qBSfxIo1KkYQuGer1cqLYmxnLhl3qyGAZY3Mfx8KtLdFSw9NeRTOWd+iuvyTV3fk3XDks7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJ6zEBlopRZ0wNzOxstl6UPaCx5UEIxKAyq4USJrIj4V2K72q
	KHZZq9fueYiZKdxBGr9JS7IybFctm98MVt3YRZt3uWggD+DB+NsHyTlcH6SBryNS
X-Gm-Gg: ASbGncv7nDbJnxM8WAqibh5MH3/+Vhs8EehtX26yul+RJekuE/tuAFIf4aV079fWaM2
	VgtgCLw9Dr3Ec/ZG4quX8dvV9YAggMh96xHX+WCgXjDGX6Fzu81nIWw/uk4yGR8xw2bQP+CbBES
	lcIwxv/kITr7pJOSBLwLjFMqlTshHRg14PBGskIBRuMdrUpYIC5S2othA0pI4dRwGscmYAQgofy
	T+hNfK491Pn+kBumOsI7fxgjyAGVSc5xsI7RbIk/Z7YbBm3R1qoLG89riuuti5hiPC4dHvSSIMs
	YldiLnmRVQRCt5s7hGByLZCJdE5sAr4mhSG5niYcDQRqFlXgHfMtMQRehkCR+G+T+7ip5m8PDuS
	cgixruBr1ELUsLyPA/SwYaYDq/Adrf/B6f3Veyp1teP7Z6FnKJjtnKRoOPAZEdh51vk4GlZPW5U
	2bUqX8s9YvpKve1SvwkoHtlrp7w29+py5kwShkB25ZFA==
X-Google-Smtp-Source: AGHT+IHPCMFQHp+1a4YBpnT+qYh4Q1NRi+td/1NNIy8w/84dHSKD1WfD+W8YnSWHchQbWBcHnSw/5g==
X-Received: by 2002:a05:6102:508a:b0:5d5:f40d:28cc with SMTP id ada2fe7eead31-5db906b7df3mr1443029137.34.1761754099752;
        Wed, 29 Oct 2025 09:08:19 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5db4e570631sm5108771137.11.2025.10.29.09.08.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 09:08:18 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-932c42aaf14so8409241.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:08:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXvbPxnDSPUUZcbTQE0fWoOhxQ1VG5f5zRB54T/IPeXPb3KdO4rsiNO4ua5zdj+gWWenlystXB1z1bUPI=@vger.kernel.org
X-Received: by 2002:a05:6102:4a89:b0:5d6:1564:d7f1 with SMTP id
 ada2fe7eead31-5db906b8f37mr1467931137.36.1761754098557; Wed, 29 Oct 2025
 09:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004816.562965-1-den@valinux.co.jp>
In-Reply-To: <20251027004816.562965-1-den@valinux.co.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 17:08:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVtR_8OZG2XrD5PHY+ybaH4dudya4VXNXD3iHktdDyF8w@mail.gmail.com>
X-Gm-Features: AWmQ_blrV7P_F3R16HOIrRem1UqE4h3nEa2JhxUtyuN9Q8vEJnpLXJhqDTLYNJo
Message-ID: <CAMuHMdVtR_8OZG2XrD5PHY+ybaH4dudya4VXNXD3iHktdDyF8w@mail.gmail.com>
Subject: Re: [PATCH] iommu: ipmmu-vmsa: Add DMA controllers to devices_allowlist
To: Koichiro Den <den@valinux.co.jp>
Cc: iommu@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi Den-san,

On Mon, 27 Oct 2025 at 02:26, Koichiro Den <den@valinux.co.jp> wrote:
> Add Renesas DMA controller devices to the devices_allowlist to enable
> their use with the IPMMU. This allows DMA channels to operate through
> the IOMMU when enabled.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Thanks for your patch!

> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -741,7 +741,9 @@ static const char * const devices_allowlist[] = {
>         "ee100000.mmc",
>         "ee120000.mmc",
>         "ee140000.mmc",
> -       "ee160000.mmc"
> +       "ee160000.mmc",
> +       "e7350000.dma-controller",
> +       "e7351000.dma-controller"

While your change looks correct to me, it causes DMA mapping failures on
Gray Hawk Single and Sparrow Hawk when IPMMU support is enabled
(on renesas-drivers-2025-10-28-v6.18-rc3 with renesas_defconfig
+ CONFIG_IPMMU_VMSA=y):

    rcar-dmac e7351000.dma-controller: chan1: failed to map 1@0x00000000e656000c
    sh-sci e6560000.serial: Failed preparing Tx DMA descriptor

0xe656000c = HSCIF2 Transmit FIFO data register.

With "#define DEBUG" added to drivers/dma/sh/rcar-dmac.c:

    rcar-dmac e7351000.dma-controller: chan1: failed to map 1@0x00000000e656000c
    sh-sci e6560000.serial: Failed preparing Tx DMA descriptor
    rcar-dmac e7351000.dma-controller: chan2: map 1@0x00000000e6560014
to 0x00000000fff82014 dir: DMA_TO_DEVICE
    rcar-dmac e7351000.dma-controller: chan2: chunk
00000000e5110c20/000000005e0ede90 sgl 0@000000000d8c5440, 256/256
0x00000000fff82014 -> 0x00000000ffed6000
    rcar-dmac e7351000.dma-controller: chan2: submit #2@000000005e0ede90
    rcar-dmac e7351000.dma-controller: chan2: chunk
0000000025f2f66c/00000000e5f0dd15 sgl 0@0000000064f1067f, 256/256
0x00000000fff82014 -> 0x00000000ffed6100
    rcar-dmac e7351000.dma-controller: chan2: submit #3@00000000e5f0dd15
    rcar-dmac e7351000.dma-controller: chan2: queue chunk
00000000e5110c20: 256@0x00000000fff82014 -> 0x00000000ffed6000

0xe6560014 = HSCIF2 Receive FIFO data register

Comparing to the CONFIG_IPMMU_VMSA=n case:

    rcar-dmac e7351000.dma-controller: chan1: map 1@0x00000000e656000c
to 0x00000000e656000c dir: DMA_FROM_DEVICE
    rcar-dmac e7351000.dma-controller: chan1: chunk
0000000096396eb4/00000000f35357b6 sgl 0@0000000013546bf6, 74/74
0x0000000489ab5000 -> 0x00000000e656000c
    rcar-dmac e7351000.dma-controller: chan1: submit #2@00000000f35357b6
    rcar-dmac e7351000.dma-controller: chan1: queue chunk
0000000096396eb4: 74@0x0000000489ab5000 -> 0x00000000e656000c

This confuses me even more: why no DMA_TO_DEVICE mapping in the
latter case?

>  };
>
>  static bool ipmmu_device_is_allowed(struct device *dev)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

