Return-Path: <linux-kernel+bounces-757638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F50B1C494
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E229F18C13D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F0528AB11;
	Wed,  6 Aug 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk+8h164"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413023C8AE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754477899; cv=none; b=itGkMbDjMQn1lEyOTxBUsq1OB4mmGN/L3qUzdPEXV9JvOgL84qtUA7DoebRvT0OiMO3SH9lUpg6bpC9fXQ+W/qt1Og5t3ivMO4p/T3OUBw5KD2QFjWidtQ7rYznFR8iJUamYynZJmb+gYBMNyqlIfSmsKmWOa/upqLmJ8O5nd6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754477899; c=relaxed/simple;
	bh=9vV6D9rZRafX6ErINmAAiDv16ZiuY96suxd9anC9tBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayT8h4RIgWd0V/R5iT4XVOEQyEd29DtNH/ZBdTUwdiabVz77hwgx6ACIL82+LgSVyKd0BVrwzw1mNjRaFadEgyhhWsCUqV5aisz+sTufxt5ztgM+nvv03TUedWRFSuZ1sHl9H97FCS4ERSYUYkSEme8VAZbKt/XEiz0EOfSK4gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk+8h164; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F20C4CEE7;
	Wed,  6 Aug 2025 10:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754477898;
	bh=9vV6D9rZRafX6ErINmAAiDv16ZiuY96suxd9anC9tBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fk+8h164x2QfKL8pa/aGXhnMZKIXXQ4Lb9ckBtxZNIqewwf9BEdIC4CLImZlBTqWl
	 XuIxFHV4Q6jBI+7MqUL3SmY42VUCcF2b9NxuiOVuygrM/qcVfdVbxv+f9qf3qXASo+
	 kZO7voTduRFa+6rfVotePbUG6lzOS5DFD+gg1M8OCTXdvkU+J23t9sunL0i6mBS+Hj
	 U+L11I0/CMWAdwFN/vLSceqIXuTjt0ZiWL+ptJwuftj0FZs3/fvSLm8UeQA9vdTzaf
	 7v8jldJ4g/5jwrqgzhbowcTn/F5ucIoQZ5u1JxL2c6aLsj7U4P1eDjIzLeWUArCrQM
	 r5OADw0rWBXmg==
Date: Wed, 6 Aug 2025 13:58:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: mawupeng <mawupeng1@huawei.com>
Cc: ardb@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: ignore nomap memory during mirror init
Message-ID: <aJM1RFjpQxQzfASv@kernel.org>
References: <20250717085723.1875462-1-mawupeng1@huawei.com>
 <aHjQp9zPVPuPyP3B@kernel.org>
 <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>
 <aHj8mfecDhJJZW1Y@kernel.org>
 <8d604308-36d3-4b55-8ddb-b33f8b586c1a@huawei.com>
 <aHzjOxg_oPp06blC@kernel.org>
 <CAMj1kXGKGXeKGKWT3VzkBtACtjFyz8ntiyoTU26DA4aR6mi88g@mail.gmail.com>
 <aH9JMT93itrztZ+m@kernel.org>
 <113b914f-1597-41ca-b714-7ea048c3c6df@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <113b914f-1597-41ca-b714-7ea048c3c6df@huawei.com>

On Tue, Aug 05, 2025 at 04:47:31PM +0800, mawupeng wrote:
> 
> On 2025/7/22 16:17, Mike Rapoport wrote:
> > Hi Ard,
> > 
> > On Mon, Jul 21, 2025 at 03:08:48PM +1000, Ard Biesheuvel wrote:
> >> On Sun, 20 Jul 2025 at 22:38, Mike Rapoport <rppt@kernel.org> wrote:
> >>>
> >> ...
> >>>
> >>>> w/o this patch
> >>>> [root@localhost ~]# lsmem --output-all
> >>>> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> >>>> 0x0000084000000000-0x00000847ffffffff   32G online       yes   67584-67839    0 Movable
> >>>> 0x0000085000000000-0x0000085fffffffff   64G online       yes   68096-68607    0 Movable
> >>>>
> >>>> w/ this patch
> >>>> [root@localhost ~]# lsmem --output-all
> >>>> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> >>>> 0x0000084000000000-0x00000847ffffffff   32G online       yes   8448-8479    0  Normal
> >>>> 0x0000085000000000-0x0000085fffffffff   64G online       yes   8512-8575    0 Movable
> >>>
> >>> As I see the problem, you have a problematic firmware that fails to report
> >>> memory as mirrored because it reserved for firmware own use. This causes
> >>> for non-mirrored memory to appear before mirrored memory. And this breaks
> >>> an assumption in find_zone_movable_pfns_for_nodes() that mirrored memory
> >>> always has lower addresses than non-mirrored memory and you end up wiht
> >>> having all the memory in movable zone.
> >>>
> >>
> >> That assumption seems highly problematic to me on non-x86
> >> architectures: why should mirrored (or 'more reliable' in EFI speak)
> >> memory always appear before ordinary memory in the physical memory
> >> map?
> > 
> > It's not really x86, although historically it probably comes from there.
> > ZONE_NORMAL is always before ZONE_MOVABLE, so in order to have ZONE_NORMAL
> > with mirrored (more reliable) memory, the mirrored memory should be before
> > non-mirrored.
> >  
> >>> So to workaround this firmware issue you propose a hack that would skip
> >>> NOMAP regions while calculating zone_movable_pfn because your particular
> >>> firmware reports the reserved mirrored memory as NOMAP.
> >>>
> >>
> >> NOMAP is a Linux construct - the particular firmware reports a
> >> 'reserved' memory region, but other more widely used memory types such
> >> as EfiRuntimeServicesCode or *Data would result in an omitted region
> >> as well, and can appear anywhere in the physical memory map. There is
> >> no requirement for the firmware to do anything here wrt the
> >> MORE_RELIABLE attribute even though such regions may be carved out of
> >> a block of memory that is reported as such to the OS.
> >>
> >> So I agree with Wupeng Ma that there is an issue here: reporting it as
> >> mirrored even though it is reserved should not be needed to prevent
> >> the kernel from mishandling it.
> > 
> > But a check for NOMAP won't actually fix it in the general case, especially
> > if it can appear anywhere in the physical memory map. E.g. if there's an MR
> > region followed by two reserved regions and one of these regions is not
> > NOMAP and then MR region again, ZONE_NORMAL will only include the first MR
> > region.
> 
> What kind of memory is reserved and is not nomap.

EFI_ACPI_RECLAIM_MEMORY is surely reserved and it won't be nomap if it can
be mapped WB. I believe other types may be treated the same, I don't
familiar with efi code enough to tell.

> > We may want to consider scanning the entire memblock.memory to find all
> > mirrored regions in a and than make a decision where to cut ZONE_NORMAL
> > based on that.
> 
> AFICT, mirrored memory should always locate at the top of numa memory
> region due the linux's zone management. there maybe no good decision
> based on memblock.memory rather that use the the first non-mirror
> usable memory pfn to cut.

Thinking out loud, if nomap is not usable to Linux why would efi add it to
memblock.memory at all? 

-- 
Sincerely yours,
Mike.

