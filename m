Return-Path: <linux-kernel+bounces-761378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ECEB1F956
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 10:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DE97A9CB7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47988238D49;
	Sun, 10 Aug 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW+c4kfO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF101EA7E1
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754813699; cv=none; b=VwwepJh7vJ7A1UmxWxi4MiKZbWDFzutW2X5Cip1yRCKfnbt0kIHvsTFc5fYzQLQCrAfP0jy+KNx535dUTGT61p/h/M9BsrjiWVJeC8HB3VAc8hV7CKihuQGkkzVOJ9NuDp1Un54UCIVtuEQcfqEbHz2j1tg1JsCBPUAgbC7An58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754813699; c=relaxed/simple;
	bh=fGW6aFRPqxEB+wkPVbwUTC0fZF4Hi16hQUbYb1/bkBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsKTeeI71H/izLL9PD4ui4l4KVK+M6qhoTjWePQKb8Y/zW7Jn1IixDSw+1JAPqXw0OFNtgepSfzFidn2rDQ2O90OATBWkRmmh33AG+OabuIZWHjAT9uiKlMRfoNk3Om1djwRX8nTZ3NLg9HAJR1d5sXUuG4f1d8gSzppuNE0cjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW+c4kfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2309FC4CEEB;
	Sun, 10 Aug 2025 08:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754813699;
	bh=fGW6aFRPqxEB+wkPVbwUTC0fZF4Hi16hQUbYb1/bkBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YW+c4kfO6iVUIhxBhnUx9AMimsxobF81pwBpnyQ0SE5E7ELvWmZdkfeto7vwKO9jq
	 6pfvL+Cjs/zRk8dKyK8FH3SBte060/4efJu+6WPW5gqUVS7doAeda5u4823Pi023DS
	 xSZ4J/a/A52yUL+0jAMbSqNBdb5bPoPsJslMJWDztDUguK7z0qX4D48MemjMXuhf85
	 AABeg3ebvYkxWOGU/om+RSgSI+PV5rsz5/PN3cvtuA/LRwgy8Q3wEZG1Uma+J0C0Hx
	 mwu9p4LHmHq3C+bZ43Yg2AFe8sDP+W4iDit7LlDX3xtJVyjUr+tLkWXA78uG7Q9Isw
	 7bMMhv3lMwXSg==
Date: Sun, 10 Aug 2025 11:14:53 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: ignore nomap memory during mirror init
Message-ID: <aJhU_a6NeUKeu4rY@kernel.org>
References: <aHjQp9zPVPuPyP3B@kernel.org>
 <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>
 <aHj8mfecDhJJZW1Y@kernel.org>
 <8d604308-36d3-4b55-8ddb-b33f8b586c1a@huawei.com>
 <aHzjOxg_oPp06blC@kernel.org>
 <CAMj1kXGKGXeKGKWT3VzkBtACtjFyz8ntiyoTU26DA4aR6mi88g@mail.gmail.com>
 <aH9JMT93itrztZ+m@kernel.org>
 <113b914f-1597-41ca-b714-7ea048c3c6df@huawei.com>
 <aJM1RFjpQxQzfASv@kernel.org>
 <CAMj1kXHg-xB8KxkgL1FYu8PpBVqXUsR7wMxUXwfUXm=BfuUHGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHg-xB8KxkgL1FYu8PpBVqXUsR7wMxUXwfUXm=BfuUHGg@mail.gmail.com>

On Sun, Aug 10, 2025 at 03:14:03PM +1000, Ard Biesheuvel wrote:
> On Wed, 6 Aug 2025 at 20:58, Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Tue, Aug 05, 2025 at 04:47:31PM +0800, mawupeng wrote:
> > >
> > > On 2025/7/22 16:17, Mike Rapoport wrote:
> > > > Hi Ard,
> > > >
> > > > On Mon, Jul 21, 2025 at 03:08:48PM +1000, Ard Biesheuvel wrote:
> > > >> On Sun, 20 Jul 2025 at 22:38, Mike Rapoport <rppt@kernel.org> wrote:
> > > >>>
> > > >> ...
> > > >>>
> > > >>>> w/o this patch
> > > >>>> [root@localhost ~]# lsmem --output-all
> > > >>>> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> > > >>>> 0x0000084000000000-0x00000847ffffffff   32G online       yes   67584-67839    0 Movable
> > > >>>> 0x0000085000000000-0x0000085fffffffff   64G online       yes   68096-68607    0 Movable
> > > >>>>
> > > >>>> w/ this patch
> > > >>>> [root@localhost ~]# lsmem --output-all
> > > >>>> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> > > >>>> 0x0000084000000000-0x00000847ffffffff   32G online       yes   8448-8479    0  Normal
> > > >>>> 0x0000085000000000-0x0000085fffffffff   64G online       yes   8512-8575    0 Movable
> > > >>>
> > > >>> As I see the problem, you have a problematic firmware that fails to report
> > > >>> memory as mirrored because it reserved for firmware own use. This causes
> > > >>> for non-mirrored memory to appear before mirrored memory. And this breaks
> > > >>> an assumption in find_zone_movable_pfns_for_nodes() that mirrored memory
> > > >>> always has lower addresses than non-mirrored memory and you end up wiht
> > > >>> having all the memory in movable zone.
> > > >>>
> > > >>
> > > >> That assumption seems highly problematic to me on non-x86
> > > >> architectures: why should mirrored (or 'more reliable' in EFI speak)
> > > >> memory always appear before ordinary memory in the physical memory
> > > >> map?
> > > >
> > > > It's not really x86, although historically it probably comes from there.
> > > > ZONE_NORMAL is always before ZONE_MOVABLE, so in order to have ZONE_NORMAL
> > > > with mirrored (more reliable) memory, the mirrored memory should be before
> > > > non-mirrored.
> > > >
> > > >>> So to workaround this firmware issue you propose a hack that would skip
> > > >>> NOMAP regions while calculating zone_movable_pfn because your particular
> > > >>> firmware reports the reserved mirrored memory as NOMAP.
> > > >>>
> > > >>
> > > >> NOMAP is a Linux construct - the particular firmware reports a
> > > >> 'reserved' memory region, but other more widely used memory types such
> > > >> as EfiRuntimeServicesCode or *Data would result in an omitted region
> > > >> as well, and can appear anywhere in the physical memory map. There is
> > > >> no requirement for the firmware to do anything here wrt the
> > > >> MORE_RELIABLE attribute even though such regions may be carved out of
> > > >> a block of memory that is reported as such to the OS.
> > > >>
> > > >> So I agree with Wupeng Ma that there is an issue here: reporting it as
> > > >> mirrored even though it is reserved should not be needed to prevent
> > > >> the kernel from mishandling it.
> > > >
> > > > But a check for NOMAP won't actually fix it in the general case, especially
> > > > if it can appear anywhere in the physical memory map. E.g. if there's an MR
> > > > region followed by two reserved regions and one of these regions is not
> > > > NOMAP and then MR region again, ZONE_NORMAL will only include the first MR
> > > > region.
> > >
> > > What kind of memory is reserved and is not nomap.
> >
> > EFI_ACPI_RECLAIM_MEMORY is surely reserved and it won't be nomap if it can
> > be mapped WB. I believe other types may be treated the same, I don't
> > familiar with efi code enough to tell.
> >
> > > > We may want to consider scanning the entire memblock.memory to find all
> > > > mirrored regions in a and than make a decision where to cut ZONE_NORMAL
> > > > based on that.
> > >
> > > AFICT, mirrored memory should always locate at the top of numa memory
> > > region due the linux's zone management. there maybe no good decision
> > > based on memblock.memory rather that use the the first non-mirror
> > > usable memory pfn to cut.
> >
> > Thinking out loud, if nomap is not usable to Linux why would efi add it to
> > memblock.memory at all?
> >
> 
> Because the region has RAM semantics and not MMIO semantics. This is
> important on architectures such as arm64, where mapping RAM with
> device attributes breaks cache coherency.

Right, such regions should not be mapped. But this can be achieved with not
memblock_add'ing them at the first place, like e820 does for example.

-- 
Sincerely yours,
Mike.

