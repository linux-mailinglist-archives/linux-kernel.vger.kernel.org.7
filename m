Return-Path: <linux-kernel+bounces-839019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C756BB0A69
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E6E1884F15
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4603019B7;
	Wed,  1 Oct 2025 14:08:57 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8160E2EAB8E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327736; cv=none; b=qRa4Zu0sRczpLengtPLS+8+PdJzq6fMuJ8LKQuq8bZgHFrImVsh5/EhBRdYxVChg9T8EYE5VAg4XuOw0DOW2dGoumLa1qxZVjBHIYAdcXqPv29r1V3AfDixmUkIPyZFvnMv/+H3Bw98iW+L8sqgCpDLM0VPLd+721xcGzoNKtlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327736; c=relaxed/simple;
	bh=aVjm7nsSk3MpK0Ybz2S8XwhrZGlGiGMKP0ozCtx1Fug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHZlZu+ISLT3Cd+26YnpXC52dUIOukXNIw5cIsY13LzM06zi5uuJRLybKz+9aaRTB7uBVdnn4VIQVuN74TEqdxhqjjgh1cj/D6xLXY15reDXWKLMSniC1OEOToYN2IpXQnUVje/4Ef3+dxzb/vd7JhLLOi7X8fTLB2W7SIz1E3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5b62ab6687dso5697302137.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327733; x=1759932533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xz5PdUboJ1NmOVuSbpHG255Mw2uRB3+8MjK6aZSUD/Q=;
        b=McKXP+xUZG8Wkcmbj7lVsa5kzv4/2NwXY2vvJxuagS16fvWotw+lirsYttsbWYgylK
         wrFwYDMS50qwJzNjoZRpzwr4Uk6TVUyCxJdTbIpmiKQ3Io0gWCzQ3Iu4eYNmYmVk4pMl
         bf8XR/GVlZpVM0DCMm1bADjYDoji1YvI7Kx8ENNc0CK6BfNSDhW0U91ewyHKqEKmm/Vk
         ra8i29qOES+a363zW4pgNAxV/kATZ/DoTjL7qKFLqXfmvWUxOwyoiy23TmcQgxQFER+J
         b6mUYJ7JtKjurBO0gAYDUty2rfwuC8YRK7Lc+vYyGQRmYzpvyA29JznuM/ujcbuXGojT
         xxZw==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZHE665dW6Aq8yHe8TNqqm6/V7wVUp52Dc9UGVfB6ulUytleRr77PJJU2A1MhMyafpL3QuUCXZO38kw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdkYYAEA329c0UI2Ng6AHD4AhYaw7e5DoP+H3EPRanBVItcxR4
	GEBFZdZ0N/jCtpDntnOFZkHtQbVX8S/hKS7HzJDycJAuCnLb4c+G3ibxdhp6BQ5r
X-Gm-Gg: ASbGncsnHV1P4He5k+zFHbMfjy38lJGNfaE04OXY1HEHLr7vi2UEN7zpn0DsPJsK1sO
	OBaptlHuRVwTnbc/XlpJ8sbETd3PcDA0glYnsNx/1vcrrrf22wRUN2tDGMWQqnxEbb0ziosoGZq
	H1mO2bSGPg+zJRnbStQ6v5Vs+RHKMOs+1e0qWds+vnS750/64AD8No67wrWCkemXPIkvG6aOh8W
	JE26CrDdKYGG7ImB/a1jASM0q/w6DjWCwn4YGRH52qtxMtNJ2/qHNKlge3kQB/HTeLxR5N7qG/q
	PfTxoY8tGLRsYULvkgW1838N2+JJqIHWdzfqzd0/ruzVVTlOA/UVQ4dkPus6mM5it42Knq/9g7I
	lVeCp5DO0L3Qp0o31wWcjiC5ndrW3Pgj3Qos3s01PefKDddci0h+j8oehWPWbItG96fB6UjShsD
	o2f70+y9ja
X-Google-Smtp-Source: AGHT+IGU7yLis6RbhTZZx2TjiAo8Rm1SLPKOs5j8u5XOhCzAlQdfeMm3EoF5HWCvJ0ja5d+ao8M1Vg==
X-Received: by 2002:a05:6102:c51:b0:527:8b63:790c with SMTP id ada2fe7eead31-5d3fe4e4cd7mr1632737137.7.1759327732979;
        Wed, 01 Oct 2025 07:08:52 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916d1518f84sm3665755241.6.2025.10.01.07.08.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 07:08:52 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ce093debf6so2794587137.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:08:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEkQuBsfHo2dsMx7LCnF372JduTwVgp+A6NmNuVh+FwnFYCpWeceUNjw68Z+NRCXreqxLSTT+I5Q+2xt4=@vger.kernel.org
X-Received: by 2002:a05:6102:1629:b0:520:dbc0:6ac4 with SMTP id
 ada2fe7eead31-5d3fe4e4d01mr1726266137.2.1759327732025; Wed, 01 Oct 2025
 07:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
 <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com> <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com>
 <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com> <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com>
 <c17c5ec1-132d-3588-2a4d-a0e6639cf748@linux.intel.com>
In-Reply-To: <c17c5ec1-132d-3588-2a4d-a0e6639cf748@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Oct 2025 16:08:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVbyKdzbptA10F82Oj=6ktxnGAk4fz7dBLVdxALb8-WWg@mail.gmail.com>
X-Gm-Features: AS18NWDSe69_JEeKgA8QttkxMcLIXMbSn-oNZuqPwYgxLktm1Z3rr1fy86KWDUc
Message-ID: <CAMuHMdVbyKdzbptA10F82Oj=6ktxnGAk4fz7dBLVdxALb8-WWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set IORESOURCE_UNSET
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Wed, 1 Oct 2025 at 15:06, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > On Tue, 30 Sept 2025 at 18:32, Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > > On Fri, 26 Sept 2025 at 04:40, Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > PNP resources are checked for conflicts with the other resource i=
n the
> > > > > system by quirk_system_pci_resources() that walks through all PCI
> > > > > resources. quirk_system_pci_resources() correctly filters out res=
ource
> > > > > with IORESOURCE_UNSET.
> > > > >
> > > > > Resources that do not reside within their bridge window, however,=
 are
> > > > > not properly initialized with IORESOURCE_UNSET resulting in bogus
> > > > > conflicts detected in quirk_system_pci_resources():
> > > > >
> > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
> > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]=
: contains BAR 2 for 7 VFs
> > > > > ...
> > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff 64bit pref=
]
> > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff 64bit pre=
f]: contains BAR 2 for 31 VFs
> > > > > ...
> > > > > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overl=
aps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disabled] because=
 it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > >
> > > > > Mark resources that are not contained within their bridge window =
with
> > > > > IORESOURCE_UNSET in __pci_read_base() which resolves the false
> > > > > positives for the overlap check in quirk_system_pci_resources().
> > > > >
> > > > > Fixes: f7834c092c42 ("PNP: Don't check for overlaps with unassign=
ed PCI BARs")
> > > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > >
> > > > Thanks for your patch, which is now commit 06b77d5647a4d6a7 ("PCI:
> > > > Mark resources IORESOURCE_UNSET when outside bridge windows") in
> > > > linux-next/master next-20250929 pci/next
> >
> > > > This replaces the actual resources by their sizes in the boot log o=
n
> > > > e.g. on R-Car M2-W:
> > > >
> > > >      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 rang=
es:
> > > >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08fff=
f -> 0x00ee080000
> > > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> > > >      pci_bus 0000:00: root bus resource [bus 00]
> > > >      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
> > > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventio=
nal PCI endpoint
> > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
> > >
> > > What is going to be the parent of these resources? They don't seem to=
 fall
> > > under the root bus resource above in which case the output change is
> > > intentional so they don't appear as if address range would be "okay".
> >
> > >From /proc/iomem:
> >
> >     ee080000-ee08ffff : pci@ee090000
> >       ee080000-ee080fff : 0000:00:01.0
> >         ee080000-ee080fff : ohci_hcd
> >       ee081000-ee0810ff : 0000:00:02.0
> >         ee081000-ee0810ff : ehci_hcd
> >     ee090000-ee090bff : ee090000.pci pci@ee090000
>
> Okay, so this seem to appear in the resource tree but not among the root
> bus resources.
>
> >     ee0c0000-ee0cffff : pci@ee0d0000
> >       ee0c0000-ee0c0fff : 0001:01:01.0
> >         ee0c0000-ee0c0fff : ohci_hcd
> >       ee0c1000-ee0c10ff : 0001:01:02.0
> >         ee0c1000-ee0c10ff : ehci_hcd
> >
> > > When IORESOURCE_UNSET is set in a resource, %pR does not print the st=
art
> > > and end addresses.
> >
> > Yeah, that's how I found this commit, without bisecting ;-)
> >
> > > >     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > > >     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> > > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventio=
nal PCI endpoint
> > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
> > > >     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> > >
> > > For this resource, it's very much intentional. It's a zero-based BAR =
which
> > > was left without IORESOURCE_UNSET prior to my patch leading to others=
 part
> > > of the kernel to think that resource range valid and in use (in your
> > > case it's so small it wouldn't collide with anything but it wasn't
> > > properly set up resource, nonetheless).
> > >
> > > >      pci 0000:00:01.0: supports D1 D2
> > > >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> > > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventio=
nal PCI endpoint
> > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
> > > >     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> > >
> > > And this as well is very much intentional.
> > >
> > > >      pci 0000:00:02.0: supports D1 D2
> > > >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> > > >      PCI: bus0: Fast back to back transfers disabled
> > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
> > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
> > > >      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
> > > >
> > > > Is that intentional?
> > >
> > > There's also that pci_dbg() in the patch which would show the origina=
l
> > > addresses (print the resource before setting IORESOURCE_UNSET) but to=
 see
> > > it one would need to enable it with dyndbg=3D... Bjorn was thinking o=
f
> > > making that pci_info() though so it would appear always.
> > >
> > > Was this the entire PCI related diff? I don't see those 0000:00:00.0 =
BARs
> > > getting assigned anywhere.
> >
> > The above log is almost complete (lacked enabling the device afterwards=
).
> >
> > AFAIU, the BARs come from the reg and ranges properties in the
> > PCI controller nodes;
> > https://elixir.bootlin.com/linux/v6.17/source/arch/arm/boot/dts/renesas=
/r8a7791.dtsi#L1562
>
> Thanks, although I had already found this line by grep. I was just
> expecting the address appear among root bus resources too.
>
> Curiously enough, pci_register_host_bridge() seems to try to add some
> resource from that list into bus and it's what prints those "root bus
> resource" lines and ee090000 is not among the printed lines despite
> appearing in /proc/iomem. As is, the resource tree and PCI bus view on th=
e
> resources seems to be in disagreement and I'm not sure what to make of it=
.
>
> But before considering going into that direction or figuring out why this
> ee090000 resource does not appear among root bus resources, could you
> check if the attached patch changes behavior for the resource which are
> non-zero based?

This patch has no impact on dmesg, lspci output, or /proc/iomem
for pci-rcar-gen2.

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

