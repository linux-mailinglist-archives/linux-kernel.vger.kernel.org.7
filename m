Return-Path: <linux-kernel+bounces-862342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF62BF50BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09F03A1C30
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3D3287505;
	Tue, 21 Oct 2025 07:44:47 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815427FD4A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032687; cv=none; b=Ffc1dNW3T0/huryMHOtpQzmLt+qkOiOlfbxMLdaieB0EjTCT3Dcn/upDx02U6LF0ykZobOU8DHwArb/rpYD0ZapyzkGhtrDH0h4/XS/PgsalDCLonxWqOryAA6StpwprnLfpPIt4byystLakUn8cPrbEkfmSXSmfwtBkLLXZV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032687; c=relaxed/simple;
	bh=IG7tayKRQ/yarsAOMuot2dwGDZWhIk36rza1ofFk6j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rvr3HPZuRISpW947T8PNgLVOK16EVwsQEDWYG7mhByvYFr5ZfLQiRNTtXZPRlMXqEJ1k8lPttWpM9dOlWJS1DSZM+rRQvXI9WIt01UsytDBhaZjxi80T9OUHC/1N9l77WWVZWF9AXeKuVTY93Io60fmt30lHlzGRX4B7H9VzyGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5563c36f5dfso2033194e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032684; x=1761637484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUqrwvpQXr6guDNLgU9SzLdOYzQwJ1tizkmuIUMCSQg=;
        b=hz3gQXibWtyo89H0CMRknOt/Bz235WtevwxDeqKkWBUNyhAKytaB6LDFwcAcNLX7Ho
         jbbZV6W6AEsL6hv+dd+jMaZ/1li8fYAtRYmFqE1VOHcaofQHjjXUyWEkWr18Lq0pr1Zd
         PSgywZUfNGeJuxYOwZYVs+BJf4SvBUJTfSkZ+eZzObM/tsCVE5WDAzlChPp7MnknhHH9
         98A8vdZ1ku6RPEIaWtXudu6Ohj9ggxlCyJoo6QJRtVSjy+0GC6ODU1maLMzAch3cS08s
         UpDtBtARUJtq504Mf6XyRESZEybVx66acygTOXvMfEXkW0ZRUAlaOBZsnOabdCnJSrps
         UR+A==
X-Forwarded-Encrypted: i=1; AJvYcCV2rt/V4sayRZjr2QPD1d5QeeFPUkzmE4qJ4D1SOdrmJx01KOKqJbJEmwBFN+DGvXl9plDCJkW8nKIS1bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMxxhcJhU2/3u0EW2dFWG1gBazXCWqhtVYeEDO+ZjLstnXpafn
	EOpoXkbNd2iwztK98/sclRRrd1JhrQfV0rfpLA834tUD4YG6ljb6deddM1N5Sfd8
X-Gm-Gg: ASbGncvVXrp83jv/1BNbGh8EwSwJmvxbzaMhJPaG45NJ4DWY3RM3iV1RmZDmjp/mK9h
	u6rWPSlQhA1S1GYc43d4Fs86Lnyw7NfnvFwR+E0h9it5bWvPDUoVnH/T0FBYszU1JSHKZq73MR3
	Qg94ZX+IqcTx75Ho6J7LBYVZHxhJTdzfe883JO208VtjPobTOkncRhXA0wf7Sqf28Jr1FYK8EdE
	G00t3Y+5EeP2dEaPmoY/Hj5NBD5GeEb7Fud8E4h3tzxjeWIXEajQXBZPF7Pbgm9pWwepfSAMkx4
	t9nZd+LVnX+g9V7wR7EUBcUlhiakIMhnyYjzIC/NxUtGFaPPBw2CyJP67Hh7Onm8TK6ZJA8brtZ
	rfx7SI7FgSPhfVh/zRl7T6tQMrdH04/DcP5l+dHdR3IlYSH8mGYjKpFIHJJnGw1vmIj78ACZEXh
	DiI2NkjxVPu0jaqGc4iOSgzYI4fft3fGKhGcb7ce8eohcj4o2f
X-Google-Smtp-Source: AGHT+IGOzXeGuJWjhfr6wsN4vVKbeearL3L+k5Vqqr/BSyngxdl0pBIdDURfF0MwD6iZBLJBvRz0eQ==
X-Received: by 2002:a05:6122:a1e:b0:54a:23dd:5a9e with SMTP id 71dfb90a1353d-5564ee42c88mr3817462e0c.3.1761032684275;
        Tue, 21 Oct 2025 00:44:44 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55661f6f10bsm3097855e0c.5.2025.10.21.00.44.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:44:43 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-59dff155dc6so2656548137.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:44:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdn2eLK+ylwRX4oHI3Ecu8W02tJTNVqoTRhMvr0m89NV2Sc/m9v2iT2zLPIaGs+HKKs1qHFyK4cVnPs1s=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0c:b0:5d5:f6ae:38c8 with SMTP id
 ada2fe7eead31-5d7dd6f48c9mr4413144137.39.1761032683037; Tue, 21 Oct 2025
 00:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
 <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com> <89a20c14-dd0f-22ae-d998-da511a94664a@linux.intel.com>
In-Reply-To: <89a20c14-dd0f-22ae-d998-da511a94664a@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 09:44:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUbseFEY8AGOxm2T8W-64qT9OSvfmvu+hyTJUT+WE2cVw@mail.gmail.com>
X-Gm-Features: AS18NWDBDpeYkZ3rgn5Tqmr6-1KFQr01Xx8X4chOVFcJI4f9-bqI7eigteiWqww
Message-ID: <CAMuHMdUbseFEY8AGOxm2T8W-64qT9OSvfmvu+hyTJUT+WE2cVw@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows safer
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Mon, 20 Oct 2025 at 18:20, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Mon, 20 Oct 2025, Geert Uytterhoeven wrote:
> > On Fri, 10 Oct 2025 at 16:42, Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > Here's a series for Geert to test if this fixes the improper coalesci=
ng
> > > of resources as was experienced with the pci_add_resource() change (I
> > > know the breaking change was pulled before 6.18 main PR but I'd want =
to
> > > retry it later once the known issues have been addressed). The expect=
ed
> > > result is there'll be two adjacent host bridge resources in the
> > > resource tree as the different name should disallow coalescing them
> > > together, and therefore BAR0 has a window into which it belongs to.
> > >
> > > Generic info for the series:
> > >
> > > PCI host bridge windows were coalesced in place into one of the struc=
ts
> > > on the resources list. The host bridge window coalescing code does no=
t
> > > know who holds references and still needs the struct resource it's
> > > coalescing from/to so it is safer to perform coalescing into entirely
> > > a new struct resource instead and leave the old resource addresses as
> > > they were.
> > >
> > > The checks when coalescing is allowed are also made stricter so that
> > > only resources that have identical the metadata can be coalesced.
> > >
> > > As a bonus, there's also a bit of framework to easily create kunit
> > > tests for resource tree functions (beyond just resource_coalesce()).
> > >
> > > Ilpo J=C3=A4rvinen (3):
> > >   PCI: Refactor host bridge window coalescing loop to use prev
> > >   PCI: Do not coalesce host bridge resource structs in place
> > >   resource, kunit: add test case for resource_coalesce()
> >
> > Thanks for your series!
> >
> > I have applied this on top of commit 06b77d5647a4d6a7 ("PCI:
> > Mark resources IORESOURCE_UNSET when outside bridge windows"), and
> > gave it a a try on Koelsch (R-Car M2-W).
>
> So the pci_bus_add_resource() patch to rcar_pci_probe() was not included?
> No coalescing would be attempted without that change.

Sorry, I didn't realize you wanted that (and anything else) to be
included, too.  Please tell me the exact base I should use for testing,
and I will give it another run.
Thanks!

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

