Return-Path: <linux-kernel+bounces-853327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74948BDB4CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECE618A374A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCD7306B3F;
	Tue, 14 Oct 2025 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGI9Dp2l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F102FFDDC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474690; cv=none; b=Mji4gtNNCT74MDsz17uMOnT/BfD7qOAAl4kA6uKyyy8CsvdHCpJKz3vct+FXzhHeIfqX6ia1j6tekAoiA204vIxt9bTUEaO4/87oif2XDCk1CMzyMj/Sc+THSAe3ocLgDBEuHKk8oajA8vlpEMereBOBoI9tTdbnMUOMDjBr/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474690; c=relaxed/simple;
	bh=sk3w75RtyWNWUZvXt6JftS1Ei1J9D/GDQ/pCitVq9j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmRUFfPiWoZAStmd6jk401PbtVIwM2zflU55VKq58tZqEfidDv9oV5yzizJQZPkq1XaL8jpw/s3B9ieUn4Hcqu1258BjtuMNfsKBCV/m4zM2lJC4pgkxQnEVFrFF6xEXSM+NnCTJeYkeUUQpYloeMgz4al1C3swVdUwlsjqFZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGI9Dp2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D531C4CEE7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760474690;
	bh=sk3w75RtyWNWUZvXt6JftS1Ei1J9D/GDQ/pCitVq9j8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iGI9Dp2lbMZSic7V9v9QaCCtcdhjrfbDhG6SsXEIClDNoHJyGQd92miF4ttS7CMNK
	 G9gOmnLUg67QfgF32p8UfcztW3j2IQAnx/d6LbpCrm1UNBw2H7ODtlHcFZwGwZdlmw
	 nJYk523/Aqxbh8xiDJ68Nbqz73+WN1xnvQ6qx/8Ffhv7ZDUBIc7yG/ts/BUPFCLHyU
	 T4KgAT9uwGvid5+t/aFqArr+piYX2AIVnqXfRDiusp3Jhv8u6Iqlo6aFk9aJhI9Tlt
	 uIVjE+Eo/SFliRKl5nilVVwigDb1CRNmxpSCszoqPJbyGxl6q+QVhz1hN9PM1r6zS6
	 v+pmIvHot0tqQ==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-77fac63ba26so57839287b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:44:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWu+ClfWKQlVcpXj3JWWvh/O9NuyEkzRjodzgDapm0viPSVDv/Kt8IgtqXoxp+srgAa3vmo29kzI9kz12w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2YgtujjcBdjO0Loaxv0tYc5YSV844zPDqwawb++16PSpXwE28
	DcqLqr7TF7yVXvv++kQ8Q4VEBclm3V6WD+/cbPpGsIwBbXY0X3SQpY4yZQumnzB9AJSy/bQYWEU
	Tt6aDKmY3nZZFMA2HnCxMEwaVOXfqFZbW5D7pN6NfDA==
X-Google-Smtp-Source: AGHT+IFJE1plANafJtInJCscm+heLOGPK8H3e3UnKYtheN5mGgUTBn2x78JByU4wjUGojfILO7wb17BQyddrhRF9+MA=
X-Received: by 2002:a53:b4c4:0:b0:63c:f5a7:408 with SMTP id
 956f58d0204a3-63cf5a709c9mr8433411d50.60.1760474689167; Tue, 14 Oct 2025
 13:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
 <20250929150425.GA111624@bhelgaas> <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
 <CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com>
 <mafs0a51zmzjp.fsf@kernel.org> <CACePvbW9eSBY7qRz4o6Wqh0Ji0qECrFP+RDxa+nn4aHRTt1zkQ@mail.gmail.com>
 <CAHN2nPK34YfrysN+sraiFVjU_9Lw7E-yFVF-9x+nt1OUppZX8Q@mail.gmail.com> <mafs01pn6nbse.fsf@kernel.org>
In-Reply-To: <mafs01pn6nbse.fsf@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 14 Oct 2025 13:44:37 -0700
X-Gmail-Original-Message-ID: <CACePvbWw9zWE7drUnaxfGk971Hv3o8WhLyYF74d4hDundhQ4jw@mail.gmail.com>
X-Gm-Features: AS18NWCZdqV7l4n0ncE9tVNVDPwqC_rRLuITbh1FV52A2zBupxn8n08DI-DoFKE
Message-ID: <CACePvbWw9zWE7drUnaxfGk971Hv3o8WhLyYF74d4hDundhQ4jw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Jason Miu <jasonmiu@google.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 6:58=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Fri, Oct 10 2025, Jason Miu wrote:
>
> > On Thu, Oct 9, 2025 at 9:19=E2=80=AFPM Chris Li <chrisl@kernel.org> wro=
te:
> >>
> >> On Thu, Oct 9, 2025 at 4:21=E2=80=AFPM Pratyush Yadav <pratyush@kernel=
.org> wrote:
> >> >
> >> > On Tue, Oct 07 2025, Chris Li wrote:
> >> >
> >> > [...]
> >> > > That will keep me busy for a while waiting for the VFIO series.
> >> >
> >> > I recall we talked in one of the biweekly meetings about some sanity
> >> > checking of folios right before reboot (make sure they are right ord=
er,
> >> > etc.) under a KEXEC_HANDOVER_DEBUG option. If you have some spare ti=
me
> >> > on your hands, would be cool to see some patches for that as well :-=
)
> >>
> >> Sure, I will add that to my "nice to have" list. No promised I got
> >> time to get to it with the PCI. It belong to the KHO series not PCI
> >> though.
> >>
>
> Right. It is only a "nice to have", and not a requirement. And certainly
> not for the PCI series.

Ack.


> >
> > For the folio sanity check with KEXEC_HANDOVER_DEBUG, I can follow
> > that up. Would you tell me what we like to check before reboot, I may
> > have missed some context. Thanks!
>
> The idea is to sanity-check the preserved folios in the kexec-reboot
> flow somewhere. The main check discussed was to make sure the folios are
> of the same order as they were preserved with. This will help catch bugs
> where folios might split after being preserved.

Yes, the idea is that, for all folio that has been preserved, remember
the folio order at the time of pserver_folio. Right before kexec
reboot, maybe after the freeze() call, the KHO can go though the
internal list of the preserved folio and verify the folio starting at
that physical address still has the same order compare to the
preservation time. In other words, the folio order hasn't change since
the between preserve_folio() and kexec reboot, for the folio that has
been preserved.

> Maybe we can add some more checks too? Like making sure the folios
> aren't freed after they were preserved. But that condition is a bit
> trickier to catch. But at least the former should be simple enough to
> do as a start.

Agree, we can have more check there. We can also add those additional
check as follow up patches in the same series or later series. They
don't have to be done in one go.

Chris

