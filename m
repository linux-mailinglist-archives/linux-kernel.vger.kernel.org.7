Return-Path: <linux-kernel+bounces-761321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8797AB1F86E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC41F7A477A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 05:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524B1E25EF;
	Sun, 10 Aug 2025 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDAgLSST"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555F1C4A10
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754802859; cv=none; b=bbcnrV3BRdvm0V6s+80MaI3r5KEqn6Bs98fLlAOaBrRQghUNbVMBc3SCq2Y0Nm0Sw+VUYCbLe2wr/tYH1JbFnn01YWOTjEJAoyhzsMXXww4FMFMRZxqI+a+zJoXd6q/NEKNP+tNL9o9eC9IW8iLTQ7nCJjaP/Y2oyhOaGo2/bVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754802859; c=relaxed/simple;
	bh=CsX0+8wPsF+NVaEYBtYgUl5OhjzH9LZHcssQWkW2mKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2pC1p2kswtHlA4lIdWAWgjIcyCXJbn6ObspEalO2wY5X0KrvdqvoBNVnE08eL5i2fJa9dKF77YbJzBSle1oT1d+AtBax8Y3FIg+TWB9qtMzScnGKtrCZmQajGegkzXHFw97OQdNX8YEXoOoP8gGHN6OdR6BtTYXKEsF3ylT8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDAgLSST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1D6C4AF0B
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754802857;
	bh=CsX0+8wPsF+NVaEYBtYgUl5OhjzH9LZHcssQWkW2mKc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VDAgLSST380FoqNiTqfUzCjE+01RJMt/CStnUKgOcI34/24d74D8i6rZL4vyuOkMB
	 9bYVbh1OQ4XENgXaOS7FwxACkgXygu/Ij0eUGT2W/pQpVm5nlZ85us5bLqvvo2kuMx
	 Wx+68IEHmMztUQsf7bS4VHn7zjtL1AdhMzEIt1QN+NlnLlceTRkfFsbfeikVpGjUpo
	 p5F4uMlYeYlalPrOB66R2NSL4XjZVAUKzObIfi+293Uil6GOS3JPZvfpbXopM6+gws
	 fP3E5e9LkymxfJJmGYZziemKjk6HCvuSSWQhD0RKeAN1hzTT0Ni99XO/BZ6+QP5/yi
	 BfKsAq7pZDC8w==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32f1df58f21so33122861fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 22:14:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXc5ABrjECf5S8nnsfi9jvKt4r10nWhXKGOZfKHm41uhGytbORosJZ0rQBDLBk4c3nvlR8mQXLSDdp3Hws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVxRCoHY0tUEOINlR+f8v+pIRn+162lu29Rl88QO49Qdgt2R8i
	m/Fu/1anCEjh8PLM1UPbsH/Vz5lumocoRGD/UwzxbIWLO0sL/cVsJcSmQwrZC+BagQxifKXlM9w
	trX9YE5783W9Tf4LWv/wS/eO95kTUeN8=
X-Google-Smtp-Source: AGHT+IHL5VOMKYC7wfesoWjZEqnCd5gQuxwltrN3JRoIqGTots354Q4H6YVOxkJlFKo25XIJ0ZLg8dQ2+7XSNVjY0Ts=
X-Received: by 2002:a2e:a987:0:b0:330:8d4c:ae6a with SMTP id
 38308e7fff4ca-333a2145753mr23339921fa.6.1754802855620; Sat, 09 Aug 2025
 22:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717085723.1875462-1-mawupeng1@huawei.com>
 <aHjQp9zPVPuPyP3B@kernel.org> <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>
 <aHj8mfecDhJJZW1Y@kernel.org> <8d604308-36d3-4b55-8ddb-b33f8b586c1a@huawei.com>
 <aHzjOxg_oPp06blC@kernel.org> <CAMj1kXGKGXeKGKWT3VzkBtACtjFyz8ntiyoTU26DA4aR6mi88g@mail.gmail.com>
 <aH9JMT93itrztZ+m@kernel.org> <113b914f-1597-41ca-b714-7ea048c3c6df@huawei.com>
 <aJM1RFjpQxQzfASv@kernel.org>
In-Reply-To: <aJM1RFjpQxQzfASv@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 10 Aug 2025 15:14:03 +1000
X-Gmail-Original-Message-ID: <CAMj1kXHg-xB8KxkgL1FYu8PpBVqXUsR7wMxUXwfUXm=BfuUHGg@mail.gmail.com>
X-Gm-Features: Ac12FXzf35_uvtEOeRokVqVCBseAN6ZGkichFEJ0PZx8nn7rv48lzsCRiSNtW0w
Message-ID: <CAMj1kXHg-xB8KxkgL1FYu8PpBVqXUsR7wMxUXwfUXm=BfuUHGg@mail.gmail.com>
Subject: Re: [PATCH] mm: ignore nomap memory during mirror init
To: Mike Rapoport <rppt@kernel.org>
Cc: mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 20:58, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Tue, Aug 05, 2025 at 04:47:31PM +0800, mawupeng wrote:
> >
> > On 2025/7/22 16:17, Mike Rapoport wrote:
> > > Hi Ard,
> > >
> > > On Mon, Jul 21, 2025 at 03:08:48PM +1000, Ard Biesheuvel wrote:
> > >> On Sun, 20 Jul 2025 at 22:38, Mike Rapoport <rppt@kernel.org> wrote:
> > >>>
> > >> ...
> > >>>
> > >>>> w/o this patch
> > >>>> [root@localhost ~]# lsmem --output-all
> > >>>> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> > >>>> 0x0000084000000000-0x00000847ffffffff   32G online       yes   67584-67839    0 Movable
> > >>>> 0x0000085000000000-0x0000085fffffffff   64G online       yes   68096-68607    0 Movable
> > >>>>
> > >>>> w/ this patch
> > >>>> [root@localhost ~]# lsmem --output-all
> > >>>> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> > >>>> 0x0000084000000000-0x00000847ffffffff   32G online       yes   8448-8479    0  Normal
> > >>>> 0x0000085000000000-0x0000085fffffffff   64G online       yes   8512-8575    0 Movable
> > >>>
> > >>> As I see the problem, you have a problematic firmware that fails to report
> > >>> memory as mirrored because it reserved for firmware own use. This causes
> > >>> for non-mirrored memory to appear before mirrored memory. And this breaks
> > >>> an assumption in find_zone_movable_pfns_for_nodes() that mirrored memory
> > >>> always has lower addresses than non-mirrored memory and you end up wiht
> > >>> having all the memory in movable zone.
> > >>>
> > >>
> > >> That assumption seems highly problematic to me on non-x86
> > >> architectures: why should mirrored (or 'more reliable' in EFI speak)
> > >> memory always appear before ordinary memory in the physical memory
> > >> map?
> > >
> > > It's not really x86, although historically it probably comes from there.
> > > ZONE_NORMAL is always before ZONE_MOVABLE, so in order to have ZONE_NORMAL
> > > with mirrored (more reliable) memory, the mirrored memory should be before
> > > non-mirrored.
> > >
> > >>> So to workaround this firmware issue you propose a hack that would skip
> > >>> NOMAP regions while calculating zone_movable_pfn because your particular
> > >>> firmware reports the reserved mirrored memory as NOMAP.
> > >>>
> > >>
> > >> NOMAP is a Linux construct - the particular firmware reports a
> > >> 'reserved' memory region, but other more widely used memory types such
> > >> as EfiRuntimeServicesCode or *Data would result in an omitted region
> > >> as well, and can appear anywhere in the physical memory map. There is
> > >> no requirement for the firmware to do anything here wrt the
> > >> MORE_RELIABLE attribute even though such regions may be carved out of
> > >> a block of memory that is reported as such to the OS.
> > >>
> > >> So I agree with Wupeng Ma that there is an issue here: reporting it as
> > >> mirrored even though it is reserved should not be needed to prevent
> > >> the kernel from mishandling it.
> > >
> > > But a check for NOMAP won't actually fix it in the general case, especially
> > > if it can appear anywhere in the physical memory map. E.g. if there's an MR
> > > region followed by two reserved regions and one of these regions is not
> > > NOMAP and then MR region again, ZONE_NORMAL will only include the first MR
> > > region.
> >
> > What kind of memory is reserved and is not nomap.
>
> EFI_ACPI_RECLAIM_MEMORY is surely reserved and it won't be nomap if it can
> be mapped WB. I believe other types may be treated the same, I don't
> familiar with efi code enough to tell.
>
> > > We may want to consider scanning the entire memblock.memory to find all
> > > mirrored regions in a and than make a decision where to cut ZONE_NORMAL
> > > based on that.
> >
> > AFICT, mirrored memory should always locate at the top of numa memory
> > region due the linux's zone management. there maybe no good decision
> > based on memblock.memory rather that use the the first non-mirror
> > usable memory pfn to cut.
>
> Thinking out loud, if nomap is not usable to Linux why would efi add it to
> memblock.memory at all?
>

Because the region has RAM semantics and not MMIO semantics. This is
important on architectures such as arm64, where mapping RAM with
device attributes breaks cache coherency.

