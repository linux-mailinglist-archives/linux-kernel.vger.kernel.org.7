Return-Path: <linux-kernel+bounces-792181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 993DBB3C122
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25951CC10AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094263314B7;
	Fri, 29 Aug 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bkk6YWkn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A52C2EF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486066; cv=none; b=pE7lg0u/ehn7oBGBDSILdRr+QMp3dYH6grFTWqHxOKkk8OGXN7b+NHRFcTN4XvwMbmM/dayErXCwLa0tVGA+YV1c+ZOmerno4QURlihaWNL9lBcoOeh/hfE8YSx/lpShqgY3Kki4x9TpvxFI1SuMttrPpGl4Rzive/BGx3bRZ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486066; c=relaxed/simple;
	bh=/ErPdPQMUXalSGRsJ1vF5o9PFjc8+ivNlMW27OZppT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKMT8J8KFNoTWtfEMqkjpkj/11BZn2LrsqgWe7Exw5PcVnyQ/oBXs6d0grdav4qEXsE6ZMmIhQTRDwTMfcXUHJdXmHKpcb+SZPf0hUYZjnXXPB/F8zvpLIo+NyApikR3Uf82x/2JKuygaKI2gYVY5QGFedcKFsojUpmBaA/HJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bkk6YWkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E23C4CEF8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756486065;
	bh=/ErPdPQMUXalSGRsJ1vF5o9PFjc8+ivNlMW27OZppT8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bkk6YWkn9UXXxa8HtRSbDmkIsNKwiMIAc3Udd/5wPHThVt4ln2rlZUl6YsjvKh7AG
	 tzf8A/ZmhOUk6bzK3uklWuyw+Hy1z6QhGX7JIOZwMygHduHc2L4bH/nYLMblIf7P/d
	 X1xHBSKVUm6VGekabHreN1J+ghmZpONh58QQyAYwHyVRgXqO3IhpoTegvMuhyUOgxX
	 OpD6Vjnq39EMGluH1/RSaErLD2BMjsNh34CcT7PfsMdhCZuGYdYFKdzpYSg7ddEMTc
	 BpE1UrOI4DDeXWywBEWUVqRsqtiux5z+OcMa1ci3lcUPE7WVdB1uT2iW+l83CCmLe5
	 K/CvEJWxoixPg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f4bcceed0so2528502e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:47:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZ7lSkdDD1flKQKhk37CT7/y2+Yw+9xfI54r3/uqdA3SfHFNmA0GaC6CYuinSbvFmjZCjSdxZ6kIHCL38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXtUoC/3gQbY8FtK8fdUiIIyjWKlDSO27HQcDGKK2IE07UUQKu
	umxojQ6ML74aTfU+cEckUMlLO/aE8jDC9RroVyz/7Fp/zAlCsBWtjNk1OTj+IDS1NaDWom70pUs
	KE6tN3srC1zjCHTWIpC0wJ8ckv5YjTJw=
X-Google-Smtp-Source: AGHT+IE6Uzzl3OEENhASA0nafKketLOkVpHtLFm6KiMYKZAQYq2n8hu2c3SbfjMq+tSNCTm54kTMyuKLI4TyjxZfl6s=
X-Received: by 2002:a05:6512:1091:b0:55f:6ddb:25 with SMTP id
 2adb3069b0e04-55f6ddb036fmr227107e87.3.1756486064192; Fri, 29 Aug 2025
 09:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aHjQp9zPVPuPyP3B@kernel.org> <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>
 <aHj8mfecDhJJZW1Y@kernel.org> <8d604308-36d3-4b55-8ddb-b33f8b586c1a@huawei.com>
 <aHzjOxg_oPp06blC@kernel.org> <CAMj1kXGKGXeKGKWT3VzkBtACtjFyz8ntiyoTU26DA4aR6mi88g@mail.gmail.com>
 <aH9JMT93itrztZ+m@kernel.org> <113b914f-1597-41ca-b714-7ea048c3c6df@huawei.com>
 <aJM1RFjpQxQzfASv@kernel.org> <CAMj1kXHg-xB8KxkgL1FYu8PpBVqXUsR7wMxUXwfUXm=BfuUHGg@mail.gmail.com>
 <aJhU_a6NeUKeu4rY@kernel.org>
In-Reply-To: <aJhU_a6NeUKeu4rY@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 29 Aug 2025 18:47:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGXYTdrJMdUVB1Mc-uF3Vk5r+P-Sq+GGoBA3S5H3NkeUQ@mail.gmail.com>
X-Gm-Features: Ac12FXywTQo1B_0JCcEOdtCveAknCs6YbWQKzsYVFfhVgOtOSY0DSPQNBXTA8io
Message-ID: <CAMj1kXGXYTdrJMdUVB1Mc-uF3Vk5r+P-Sq+GGoBA3S5H3NkeUQ@mail.gmail.com>
Subject: Re: [PATCH] mm: ignore nomap memory during mirror init
To: Mike Rapoport <rppt@kernel.org>
Cc: mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Aug 2025 at 10:15, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Sun, Aug 10, 2025 at 03:14:03PM +1000, Ard Biesheuvel wrote:
> > On Wed, 6 Aug 2025 at 20:58, Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > On Tue, Aug 05, 2025 at 04:47:31PM +0800, mawupeng wrote:
> > > >
> > > > On 2025/7/22 16:17, Mike Rapoport wrote:
> > > > > Hi Ard,
> > > > >
> > > > > On Mon, Jul 21, 2025 at 03:08:48PM +1000, Ard Biesheuvel wrote:
> > > > >> On Sun, 20 Jul 2025 at 22:38, Mike Rapoport <rppt@kernel.org> wrote:
> > > > >>>
> > > > >> ...
> > > > >>>
> > > > >>>> w/o this patch
> > > > >>>> [root@localhost ~]# lsmem --output-all
> > > > >>>> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> > > > >>>> 0x0000084000000000-0x00000847ffffffff   32G online       yes   67584-67839    0 Movable
> > > > >>>> 0x0000085000000000-0x0000085fffffffff   64G online       yes   68096-68607    0 Movable
> > > > >>>>
> > > > >>>> w/ this patch
> > > > >>>> [root@localhost ~]# lsmem --output-all
> > > > >>>> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> > > > >>>> 0x0000084000000000-0x00000847ffffffff   32G online       yes   8448-8479    0  Normal
> > > > >>>> 0x0000085000000000-0x0000085fffffffff   64G online       yes   8512-8575    0 Movable
> > > > >>>
> > > > >>> As I see the problem, you have a problematic firmware that fails to report
> > > > >>> memory as mirrored because it reserved for firmware own use. This causes
> > > > >>> for non-mirrored memory to appear before mirrored memory. And this breaks
> > > > >>> an assumption in find_zone_movable_pfns_for_nodes() that mirrored memory
> > > > >>> always has lower addresses than non-mirrored memory and you end up wiht
> > > > >>> having all the memory in movable zone.
> > > > >>>
> > > > >>
> > > > >> That assumption seems highly problematic to me on non-x86
> > > > >> architectures: why should mirrored (or 'more reliable' in EFI speak)
> > > > >> memory always appear before ordinary memory in the physical memory
> > > > >> map?
> > > > >
> > > > > It's not really x86, although historically it probably comes from there.
> > > > > ZONE_NORMAL is always before ZONE_MOVABLE, so in order to have ZONE_NORMAL
> > > > > with mirrored (more reliable) memory, the mirrored memory should be before
> > > > > non-mirrored.
> > > > >
> > > > >>> So to workaround this firmware issue you propose a hack that would skip
> > > > >>> NOMAP regions while calculating zone_movable_pfn because your particular
> > > > >>> firmware reports the reserved mirrored memory as NOMAP.
> > > > >>>
> > > > >>
> > > > >> NOMAP is a Linux construct - the particular firmware reports a
> > > > >> 'reserved' memory region, but other more widely used memory types such
> > > > >> as EfiRuntimeServicesCode or *Data would result in an omitted region
> > > > >> as well, and can appear anywhere in the physical memory map. There is
> > > > >> no requirement for the firmware to do anything here wrt the
> > > > >> MORE_RELIABLE attribute even though such regions may be carved out of
> > > > >> a block of memory that is reported as such to the OS.
> > > > >>
> > > > >> So I agree with Wupeng Ma that there is an issue here: reporting it as
> > > > >> mirrored even though it is reserved should not be needed to prevent
> > > > >> the kernel from mishandling it.
> > > > >
> > > > > But a check for NOMAP won't actually fix it in the general case, especially
> > > > > if it can appear anywhere in the physical memory map. E.g. if there's an MR
> > > > > region followed by two reserved regions and one of these regions is not
> > > > > NOMAP and then MR region again, ZONE_NORMAL will only include the first MR
> > > > > region.
> > > >
> > > > What kind of memory is reserved and is not nomap.
> > >
> > > EFI_ACPI_RECLAIM_MEMORY is surely reserved and it won't be nomap if it can
> > > be mapped WB. I believe other types may be treated the same, I don't
> > > familiar with efi code enough to tell.
> > >
> > > > > We may want to consider scanning the entire memblock.memory to find all
> > > > > mirrored regions in a and than make a decision where to cut ZONE_NORMAL
> > > > > based on that.
> > > >
> > > > AFICT, mirrored memory should always locate at the top of numa memory
> > > > region due the linux's zone management. there maybe no good decision
> > > > based on memblock.memory rather that use the the first non-mirror
> > > > usable memory pfn to cut.
> > >
> > > Thinking out loud, if nomap is not usable to Linux why would efi add it to
> > > memblock.memory at all?
> > >
> >
> > Because the region has RAM semantics and not MMIO semantics. This is
> > important on architectures such as arm64, where mapping RAM with
> > device attributes breaks cache coherency.
>
> Right, such regions should not be mapped. But this can be achieved with not
> memblock_add'ing them at the first place, like e820 does for example.
>

How do we distinguish RAM from MMIO in that case, if neither can be
found in the memblock list?

