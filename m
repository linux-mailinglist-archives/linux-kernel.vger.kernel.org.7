Return-Path: <linux-kernel+bounces-861029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD86BF199D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E3542357E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA34432ABC4;
	Mon, 20 Oct 2025 13:42:47 +0000 (UTC)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2019932AACD
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967767; cv=none; b=ko9pnKmtKZClZGaYhTELTlFW+xT39Vo1VEPwvJ+HFiLI3w153NJVHSj4bmjem1BX6L3V4zb2tAha7K7uIygUV55PA+0pJYuBV9mUDtP/nxG7cks5M+Gf9XLJ3LELyunqiasLFsk9I7sXtQ3zIzRaR3JGAERtm0dlo9rwh6QL99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967767; c=relaxed/simple;
	bh=OBcex5OTPX795T0RzQ28tSO2c+mInHsmWctTSaRbFL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pt3HA3PtOWOAjkOP4z/YRuP/GmBORWb2JWzCnU+pYKtmoJ75BCkB/syTsxZIvWbSehz/vk92LmTWUOfUR3e//vl58ugBEaAC/zzRb2OqpQ8CTKxdHg4B+6egNJMi6aHZPjCKxVuoy4D+UbV2Q5D+Z+JqOkHg3I9iVDNFsiYi5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8fb58f2b820so2470547241.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760967764; x=1761572564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaoJvkckgwvI7BiUEGUU/6/pih+zeGwr4mjBxmqvp+k=;
        b=ku7IlSIBfA5F3PEY+TWO/3UVRemFoVpZ7p0wn+NKh/XOgzb9o8AxzdnC5KMQfe3P+4
         Vj0OYGNq8K4yhfLzq7d/W7PPcqmDzQHnn9XiUbIpAkqPnX3SRxYyILurYzru4hJsMGe2
         puLaisLyePhb0rl6JVoCgsu/2PaViubtjcqAYj8/DRMo9YmdPcaMVvEfrAtuWR5vZCHM
         6H9jl+S5ywlodtagGFUfMoH1iUig1K6tIVBiG9x4k5fab9aeZ9ciran6K4KTocvk2rDS
         nhe1i6gQYq/ouMliT7gofWkOBBIfXJHBhikPnFB29j5A9aTlt31StgNPAvsGxGxh8M2z
         COxA==
X-Forwarded-Encrypted: i=1; AJvYcCVUDq2gJEwS7jkLVORo6R/Act02V2l/g+iiyz88I2IXugBeDwp4po55sGnjn4HgrJew1i8DRzMGfYJDamA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuNu8DBjlpQ/268VW4zf9bJfVNQT1ymAhqQC0jb1Qu5JoJ1VPc
	Ap4zGvL9yFHu+FZ71jo7YQ+XRBZQ6LbebPKT6IjHx0iLNIxpsu4JyKjlhsL+gJVy
X-Gm-Gg: ASbGncuCh30WcSk1CWZTsMq5R7HvdMrKGDOYj+u5meattSSP8P9MTd9fk5C8jJyF3rE
	Geiyel/g7vqpGJHZCHPpnd6f1+EVugwjUwjVg+KKyyf4H5YhBfSAG/Qrb1U1tARhe9l0TOnrayS
	KZumIaTS9tqwsgmntLXaz53A93KLFH2250Oo2b8/xtxj1vflA/dlR46EjDAh5zUW5pI5Swe+FIP
	hDUS6OdO/NtYL7ke5L57zbqDFGUcGiFBaSSMg+XNxpce8JKrhke+NPofouSSbqoioHugU0CbXm6
	eywyNgcxfZLcztjEv1vGHSxwZCxnlS6ltLbHm8fF+X75ytLnvIdJ1RYSYx9Fpbnl//2voJpV6T5
	zm7Z5Wm6NnGX5W90ItVu/XWhp8QO3hfvkSjLoi7PadROOfptWfQfgCz4JhvsoZDy/6P4qMBndHy
	S8r5C3CTP4FiTJToyA4HH+2kXBgYtx40gIP/nRzA==
X-Google-Smtp-Source: AGHT+IGzzmlyvEQwBP2TCQ20lmB+GukdVU3ycYzDzr3e+CvhXPhpq/tqbOSscOij1andzfmKL12RMw==
X-Received: by 2002:a05:6102:38d3:b0:56c:eed1:276d with SMTP id ada2fe7eead31-5d7dd5b951cmr4392967137.18.1760967763681;
        Mon, 20 Oct 2025 06:42:43 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c25dd20sm2513576137.11.2025.10.20.06.42.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 06:42:43 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-932bb8636f8so1828171241.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:42:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGtxU8IS7k5fdbTfZALzCj/JIgT7vpvLQT8Gv0fnr0lp/CEjVWevZQk5QBmb40S37qmbqFAf4PKtefk9E=@vger.kernel.org
X-Received: by 2002:a05:6102:30dc:10b0:5d7:e095:9398 with SMTP id
 ada2fe7eead31-5d7e095983dmr2892907137.30.1760967763055; Mon, 20 Oct 2025
 06:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Oct 2025 15:42:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com>
X-Gm-Features: AS18NWAs9KN2FaEXaNCdOiFdwPBQPDTNxUr11vq1wTHrkD5pV6effUucshx_MRw
Message-ID: <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows safer
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.or>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Fri, 10 Oct 2025 at 16:42, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> Here's a series for Geert to test if this fixes the improper coalescing
> of resources as was experienced with the pci_add_resource() change (I
> know the breaking change was pulled before 6.18 main PR but I'd want to
> retry it later once the known issues have been addressed). The expected
> result is there'll be two adjacent host bridge resources in the
> resource tree as the different name should disallow coalescing them
> together, and therefore BAR0 has a window into which it belongs to.
>
> Generic info for the series:
>
> PCI host bridge windows were coalesced in place into one of the structs
> on the resources list. The host bridge window coalescing code does not
> know who holds references and still needs the struct resource it's
> coalescing from/to so it is safer to perform coalescing into entirely
> a new struct resource instead and leave the old resource addresses as
> they were.
>
> The checks when coalescing is allowed are also made stricter so that
> only resources that have identical the metadata can be coalesced.
>
> As a bonus, there's also a bit of framework to easily create kunit
> tests for resource tree functions (beyond just resource_coalesce()).
>
> Ilpo J=C3=A4rvinen (3):
>   PCI: Refactor host bridge window coalescing loop to use prev
>   PCI: Do not coalesce host bridge resource structs in place
>   resource, kunit: add test case for resource_coalesce()

Thanks for your series!

I have applied this on top of commit 06b77d5647a4d6a7 ("PCI:
Mark resources IORESOURCE_UNSET when outside bridge windows"), and
gave it a a try on Koelsch (R-Car M2-W).

Impact on dmesg (for the first PCI/USB) instance:

     pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
     pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff
-> 0x00ee080000
     pci-rcar-gen2 ee090000.pci: PCI: revision 11
     pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
     pci_bus 0000:00: root bus resource [bus 00]
     pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
     pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
PCI endpoint
    -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial
claim (no window)
     pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
    -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
initial claim (no window)
     pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
     pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
PCI endpoint
    -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
claim (no window)
     pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
     pci 0000:00:01.0: supports D1 D2
     pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
     pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
PCI endpoint
    -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
claim (no window)
     pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
     pci 0000:00:02.0: supports D1 D2
     pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
     PCI: bus0: Fast back to back transfers disabled
     pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
     pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
     pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
     pci 0000:00:01.0: enabling device (0140 -> 0142)
     pci 0000:00:02.0: enabling device (0140 -> 0142)

I.e. the "no initial claim (no window)" messages introduced by commit
06b77d5647a4d6a7 are no longer seen.
The BARs still show "mem size <n>" instead of the "mem <start>-<end>"
before commit 06b77d5647a4d6a7, though.

This series has not impact on /proc/iomem, or on the output of
"lspci -v" (commit 06b77d5647a4d6a7 also had no impact here).
I.e. the part of /proc/iomem related to the first PCI/USB instance
still looks like:

    ee080000-ee08ffff : pci@ee090000
      ee080000-ee080fff : 0000:00:01.0
        ee080000-ee080fff : ohci_hcd
      ee081000-ee0810ff : 0000:00:02.0
        ee081000-ee0810ff : ehci_hcd
    ee090000-ee090bff : ee090000.pci pci@ee090000

I hope this matches your expectation.s

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

