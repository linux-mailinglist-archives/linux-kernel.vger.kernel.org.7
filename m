Return-Path: <linux-kernel+bounces-838832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39252BB03CF
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA1618904A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963122E22BF;
	Wed,  1 Oct 2025 11:49:30 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F12E2299
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319369; cv=none; b=il5Z0j/NSJFwU0dUTFCrOQ4WVNEh6jGND1uFCqeDbjl7EeTKRHB1463373TLfxQ3M7+DJUpGGNO0Xcu2xp7/Pu+WxrJW31IHPrbGAJtPf4SaX0fOseF5ox8S9MgPkHSk8fB/E+GYAAJOkZU0KWuYQbPzBU23u/tEdj+olbFRsRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319369; c=relaxed/simple;
	bh=H8+zS/sRVPe61ZpvXMAM9MYNlz8rpJapyLZg66DsQ70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCYtPTJUCXpeKd5kq7t6XdQVBKMiuRfOwuQWLWy1Pt1OWadWPjfcoQdPzgQBJWdEu5vr5OS/OqOrZhft+FZVXzre3Yw+TjYaK0QGZ8BLY5x28iV2FH7jnLPnI27boAYgMDcy9v6WD2xTX9qpIVG4fK4Ga2B/DwHYFlOWm16anqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-92cbfab6c0dso1611533241.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759319366; x=1759924166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g40kIFvUrvIf0YJRnutJHF4Olw96C3WYwPcLV8XYQ0=;
        b=nAhqlW5NM9rxj3Nf3o7gAaU1I6gE+1ULXJUM6EOO0tM/kXKzqS5tXrmzIh+OPJSOsQ
         gjsM1Qj0WmhTc3ZeuKYSk4GYo076NGsS+6BoxjAsm0GDjRRJ+LBZbWO/9DCF/oXpR6jL
         ncJ5A5BKxReTfsqJTNkNNpjbvXJwUi7nUie1dH8ns4t4cmi6gsegAO7Q458zFko554zq
         s+1UBgHosUo2JaJEFYyNc8Qd8WfCCij6r5CqzG2Jiq/I3o7rjX7yIpP7fh8mI19y39uV
         lbpqID6Siu1YYEX/FhRJaG059ZqcMWrnLJHMRVi8ggj/NfIJqQR9QHmK/wQuoFuDE3c1
         O12Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1Q2b7RHn/ItlI2lGH1pi3WsuAH+ZnL/+pZIiZDQ1u9Bg6w57LG1EfkvuzAX0hHPk7rAu0m2J9HeZe02I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbQUjUV2nSzjGTp76OVHpLtsykf16PqVvtbofrCGE5ySCCaPz
	yP5RP2UF/1zaEVLRKTUwlNQITG1VNddomZjcp35ZVLzI7xhca90q+pMhTygMVTDu
X-Gm-Gg: ASbGnctmSOepdkOcEa/gSj0Kot3Ivk50vRWnDbMenR3VmZmOWN4ngU8pwCcEXWKNQec
	sHhrf1C8Qi2S/nL1fdDKDQbdfAhH/lG1xg77ao8dW+cp9y9X25/P8J4YLRj8ez1AUFtD4u6JHXo
	/DhWFv5QcOim3Jnf7m2G3EX/o8gZH72JeA4JwOYv94TIy2pur5RY6mbS9aNxFN4tSqm6ArYQqyM
	V/VIciDyixOleC7QzVXjRF/qqmBlp1brV6yDHnf2j4I0AXqnwTAtwZ4NDfLUYYEIL20GLo5/6W8
	cEzt9g/Z757SN2M1zq0IwxT5sAZLTkXj+QL2yRhgN9JeO3Y9uL7drLNNy4VaGDDLHGRxymBSlzq
	V6cg3MC1w26d7/BPPJaEJz9/XfPUeoZo0d/0iHxR9I8f+FGGbJp+hj1cJU4oJdDd5oMnL+xjJie
	vK1KkFbpEKRxqtyiXfCdRzLuY=
X-Google-Smtp-Source: AGHT+IG7vTeC3hvcCNbSlk6VOHTWyLxF3U/dXIsRmjo3dMyuZOs39ZODfivWVRNnsnIsXfhw4C60vA==
X-Received: by 2002:a05:6102:3a12:b0:534:cfe0:f85b with SMTP id ada2fe7eead31-5d3fe6b5fe3mr1326295137.20.1759319366106;
        Wed, 01 Oct 2025 04:49:26 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae3b700a82sm5197616137.17.2025.10.01.04.49.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 04:49:25 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54a786ed57cso5314022e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:49:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEs9GIdNJQgG/C5B5t+lhNSyo6Xean65TJZpdhWtqtRPH/sGEB3DXsgEiPOC6Erox4Pc2/P1iAfi7eqTM=@vger.kernel.org
X-Received: by 2002:a05:6102:4421:b0:530:f657:c25 with SMTP id
 ada2fe7eead31-5d3fe4f9f2dmr1325072137.5.1759319364716; Wed, 01 Oct 2025
 04:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
 <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com> <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com>
 <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com>
In-Reply-To: <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Oct 2025 13:49:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com>
X-Gm-Features: AS18NWBKGt9F5KUksrguQremVOx7wE8zhiLZILP_32pEjHukGAyY-11nzHTkZUs
Message-ID: <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com>
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

On Tue, 30 Sept 2025 at 18:32, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > On Fri, 26 Sept 2025 at 04:40, Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > PNP resources are checked for conflicts with the other resource in th=
e
> > > system by quirk_system_pci_resources() that walks through all PCI
> > > resources. quirk_system_pci_resources() correctly filters out resourc=
e
> > > with IORESOURCE_UNSET.
> > >
> > > Resources that do not reside within their bridge window, however, are
> > > not properly initialized with IORESOURCE_UNSET resulting in bogus
> > > conflicts detected in quirk_system_pci_resources():
> > >
> > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
> > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: co=
ntains BAR 2 for 7 VFs
> > > ...
> > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff 64bit pref]
> > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff 64bit pref]: =
contains BAR 2 for 31 VFs
> > > ...
> > > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because it overlaps =
0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overlaps =
0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> > > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] because it overlaps =
0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] because it overlaps =
0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] because it overlaps =
0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disabled] because it =
overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] because it overlaps =
0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] because it overlaps =
0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] because it overlaps =
0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] because it overlaps =
0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > >
> > > Mark resources that are not contained within their bridge window with
> > > IORESOURCE_UNSET in __pci_read_base() which resolves the false
> > > positives for the overlap check in quirk_system_pci_resources().
> > >
> > > Fixes: f7834c092c42 ("PNP: Don't check for overlaps with unassigned P=
CI BARs")
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >
> > Thanks for your patch, which is now commit 06b77d5647a4d6a7 ("PCI:
> > Mark resources IORESOURCE_UNSET when outside bridge windows") in
> > linux-next/master next-20250929 pci/next

> > This replaces the actual resources by their sizes in the boot log on
> > e.g. on R-Car M2-W:
> >
> >      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
> >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff ->=
 0x00ee080000
> >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> >      pci_bus 0000:00: root bus resource [bus 00]
> >      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
> >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional =
PCI endpoint
> >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
>
> What is going to be the parent of these resources? They don't seem to fal=
l
> under the root bus resource above in which case the output change is
> intentional so they don't appear as if address range would be "okay".

From /proc/iomem:

    ee080000-ee08ffff : pci@ee090000
      ee080000-ee080fff : 0000:00:01.0
        ee080000-ee080fff : ohci_hcd
      ee081000-ee0810ff : 0000:00:02.0
        ee081000-ee0810ff : ehci_hcd
    ee090000-ee090bff : ee090000.pci pci@ee090000
    ee0c0000-ee0cffff : pci@ee0d0000
      ee0c0000-ee0c0fff : 0001:01:01.0
        ee0c0000-ee0c0fff : ohci_hcd
      ee0c1000-ee0c10ff : 0001:01:02.0
        ee0c1000-ee0c10ff : ehci_hcd

> When IORESOURCE_UNSET is set in a resource, %pR does not print the start
> and end addresses.

Yeah, that's how I found this commit, without bisecting ;-)

> >     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> >     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional =
PCI endpoint
> >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
> >     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
>
> For this resource, it's very much intentional. It's a zero-based BAR whic=
h
> was left without IORESOURCE_UNSET prior to my patch leading to others par=
t
> of the kernel to think that resource range valid and in use (in your
> case it's so small it wouldn't collide with anything but it wasn't
> properly set up resource, nonetheless).
>
> >      pci 0000:00:01.0: supports D1 D2
> >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional =
PCI endpoint
> >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
> >     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
>
> And this as well is very much intentional.
>
> >      pci 0000:00:02.0: supports D1 D2
> >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> >      PCI: bus0: Fast back to back transfers disabled
> >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
> >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
> >      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
> >
> > Is that intentional?
>
> There's also that pci_dbg() in the patch which would show the original
> addresses (print the resource before setting IORESOURCE_UNSET) but to see
> it one would need to enable it with dyndbg=3D... Bjorn was thinking of
> making that pci_info() though so it would appear always.
>
> Was this the entire PCI related diff? I don't see those 0000:00:00.0 BARs
> getting assigned anywhere.

The above log is almost complete (lacked enabling the device afterwards).

AFAIU, the BARs come from the reg and ranges properties in the
PCI controller nodes;
https://elixir.bootlin.com/linux/v6.17/source/arch/arm/boot/dts/renesas/r8a=
7791.dtsi#L1562

The full related log for this device, for both instances, with the pci_dbg(=
)
changes to pci_info():

     pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
     pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff
-> 0x00ee080000
     pci-rcar-gen2 ee090000.pci: PCI: revision 11
     pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
     pci_bus 0000:00: root bus resource [bus 00]
     pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
     pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
PCI endpoint
    -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
    -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
    +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial
claim (no window)
    +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
    +pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
initial claim (no window)
    +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
     pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
PCI endpoint
    -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
    +pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
claim (no window)
    +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
     pci 0000:00:01.0: supports D1 D2
     pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
     pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
PCI endpoint
    -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
    +pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
claim (no window)
    +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
     pci 0000:00:02.0: supports D1 D2
     pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
     PCI: bus0: Fast back to back transfers disabled
     pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
     pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
     pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
     pci 0000:00:01.0: enabling device (0140 -> 0142)
     pci 0000:00:02.0: enabling device (0140 -> 0142)
     pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 ranges:
     pci-rcar-gen2 ee0d0000.pci:      MEM 0x00ee0c0000..0x00ee0cffff
-> 0x00ee0c0000
     pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
     pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
     pci_bus 0001:01: root bus resource [bus 01]
     pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cffff]
     pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conventional
PCI endpoint
    -pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
    -pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
    +pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]: no initial
claim (no window)
    +pci 0001:01:00.0: BAR 0 [mem size 0x00000400]
    +pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
initial claim (no window)
    +pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
     pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310 conventional
PCI endpoint
    -pci 0001:01:01.0: BAR 0 [mem 0x00000000-0x00000fff]
    +pci 0001:01:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
claim (no window)
    +pci 0001:01:01.0: BAR 0 [mem size 0x00001000]
     pci 0001:01:01.0: supports D1 D2
     pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
     pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
PCI endpoint
    -pci 0001:01:02.0: BAR 0 [mem 0x00000000-0x000000ff]
    +pci 0001:01:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
claim (no window)
    +pci 0001:01:02.0: BAR 0 [mem size 0x00000100]
     pci 0001:01:02.0: supports D1 D2
     pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
     PCI: bus1: Fast back to back transfers disabled
     pci 0001:01:01.0: BAR 0 [mem 0xee0c0000-0xee0c0fff]: assigned
     pci 0001:01:02.0: BAR 0 [mem 0xee0c1000-0xee0c10ff]: assigned
     pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0cffff]
     pci 0001:01:01.0: enabling device (0140 -> 0142)
     pci 0001:01:02.0: enabling device (0140 -> 0142)

> You didn't report any issues beyond textual changes in the log, I suppose
> there were none beyond the log differences?

Sorry, I should have done a little bit more testing.  This is the funny
on-chip Renesas R-Car Gen2 PCI host controller with integrated OHCI/EHCI
PCI devices.  I don't have any USB devices connected, but "lspci -v"
output is the same before/after, and the OHCI/EHCI drivers probe fine.

BTW, I am seeing similar changes on rts7751r2d (qemu SuperH target r2d):

     PCI host bridge to bus 0000:00
     pci_bus 0000:00: root bus resource [io  0x1000-0x3fffff]
     pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfdffffff]
     pci_bus 0000:00: No busn resource found for root bus, will use [bus 00=
-ff]
     pci 0000:00:00.0: [1054:350e] type 00 class 0x060000 conventional
PCI endpoint
     pci 0000:00:00.0: [Firmware Bug]: BAR 0: invalid; can't size
     pci 0000:00:00.0: [Firmware Bug]: BAR 1: invalid; can't size
     pci 0000:00:00.0: [Firmware Bug]: BAR 2: invalid; can't size
     pci 0000:00:02.0: [10ec:8139] type 00 class 0x020000 conventional
PCI endpoint
    -pci 0000:00:02.0: BAR 0 [io  0x0000-0x00ff]
    -pci 0000:00:02.0: BAR 1 [mem 0x00000000-0x000000ff]
    -pci 0000:00:02.0: ROM [mem 0x00000000-0x0007ffff pref]
    +pci 0000:00:02.0: BAR 0 [io  0x0000-0x00ff]: no initial claim (no wind=
ow)
    +pci 0000:00:02.0: BAR 0 [io  size 0x0100]
    +pci 0000:00:02.0: BAR 1 [mem 0x00000000-0x000000ff]: no initial
claim (no window)
    +pci 0000:00:02.0: BAR 1 [mem size 0x00000100]
    +pci 0000:00:02.0: ROM [mem 0x00000000-0x0007ffff pref]: no
initial claim (no window)
    +pci 0000:00:02.0: ROM [mem size 0x00080000 pref]
     pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
     pci 0000:00:02.0: ROM [mem 0xfd000000-0xfd07ffff pref]: assigned
     pci 0000:00:02.0: BAR 0 [io  0x1000-0x10ff]: assigned
     pci 0000:00:02.0: BAR 1 [mem 0xfd080000-0xfd0800ff]: assigned

All of these look legitimate to me, as they all start at zero.

Thanks!


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

