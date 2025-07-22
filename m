Return-Path: <linux-kernel+bounces-740451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5609B0D448
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D01D6C4A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A63A2D6619;
	Tue, 22 Jul 2025 08:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i58t+eQw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0667D28937F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172279; cv=none; b=AzNfh/tEaNLnFTUWfO2F4d7T02Bu63+9lbjs5kvtlDPhzw5k+9P8OUImLLPGeSiHIBnusi+Nn2IWyxE7qSKzPfM0yzCnhc9N8L+SGbfhFIP+NJMUov61HhTSMWR2Qaf4Slypdjv3X9l4n/suF89WkKK3UQ5MLItYAC4M6hozgEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172279; c=relaxed/simple;
	bh=lfgObfb20Wc460ieZjhQIAnsDK6FQlGKlIQgSrIUAtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG2lYz+OWGNQghfDGxzEMDbAMmE03CGQRH38piQybP14Z5D6QdUnY1oWV3GS4PjfOj69vmjinRGTyG+2IHJgT1z4vj40wBDbkFao+oxG8oDmtHEBhVFhy9rITFJFxrUy/fEdtkoRyCn+uTVVP97psr5R8okXTRsh6KW5DFtdcxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i58t+eQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C13C4CEF8;
	Tue, 22 Jul 2025 08:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753172278;
	bh=lfgObfb20Wc460ieZjhQIAnsDK6FQlGKlIQgSrIUAtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i58t+eQwe+lMzgAnNqCtjoeHeWNNYK1TDBIZCsfo0Yz/j7CG23IVQcgutqX1Pnupy
	 Wq3egSBJcyRzYw2sRXbGhNwIQedoE+BJoLHKHnGYn+31qRNPCFAm/UJM4vu06425LO
	 XNcar6OSHZwYjxdgxL7j6+FPPdUp5XCKDrs0zg25d0pZI6LUk0ipKyhN/p8X5daGPR
	 INgyKM7V3AwBExeva8MU0cj/vb/kWo770CKmQh8fiUpktfacfJnkwhTJhQ8ZKYyqNg
	 H0bI11lgVOkc0HP/5RF/Auei1FxFfE3ZdY4D4HAQJalxJBwmP0jlV6dHJI16csrGLX
	 SGblJAo7yJECg==
Date: Tue, 22 Jul 2025 11:17:53 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: ignore nomap memory during mirror init
Message-ID: <aH9JMT93itrztZ+m@kernel.org>
References: <20250717085723.1875462-1-mawupeng1@huawei.com>
 <aHjQp9zPVPuPyP3B@kernel.org>
 <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>
 <aHj8mfecDhJJZW1Y@kernel.org>
 <8d604308-36d3-4b55-8ddb-b33f8b586c1a@huawei.com>
 <aHzjOxg_oPp06blC@kernel.org>
 <CAMj1kXGKGXeKGKWT3VzkBtACtjFyz8ntiyoTU26DA4aR6mi88g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGKGXeKGKWT3VzkBtACtjFyz8ntiyoTU26DA4aR6mi88g@mail.gmail.com>

Hi Ard,

On Mon, Jul 21, 2025 at 03:08:48PM +1000, Ard Biesheuvel wrote:
> On Sun, 20 Jul 2025 at 22:38, Mike Rapoport <rppt@kernel.org> wrote:
> >
> ...
> >
> > > w/o this patch
> > > [root@localhost ~]# lsmem --output-all
> > > RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> > > 0x0000084000000000-0x00000847ffffffff   32G online       yes   67584-67839    0 Movable
> > > 0x0000085000000000-0x0000085fffffffff   64G online       yes   68096-68607    0 Movable
> > >
> > > w/ this patch
> > > [root@localhost ~]# lsmem --output-all
> > > RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> > > 0x0000084000000000-0x00000847ffffffff   32G online       yes   8448-8479    0  Normal
> > > 0x0000085000000000-0x0000085fffffffff   64G online       yes   8512-8575    0 Movable
> >
> > As I see the problem, you have a problematic firmware that fails to report
> > memory as mirrored because it reserved for firmware own use. This causes
> > for non-mirrored memory to appear before mirrored memory. And this breaks
> > an assumption in find_zone_movable_pfns_for_nodes() that mirrored memory
> > always has lower addresses than non-mirrored memory and you end up wiht
> > having all the memory in movable zone.
> >
> 
> That assumption seems highly problematic to me on non-x86
> architectures: why should mirrored (or 'more reliable' in EFI speak)
> memory always appear before ordinary memory in the physical memory
> map?

It's not really x86, although historically it probably comes from there.
ZONE_NORMAL is always before ZONE_MOVABLE, so in order to have ZONE_NORMAL
with mirrored (more reliable) memory, the mirrored memory should be before
non-mirrored.
 
> > So to workaround this firmware issue you propose a hack that would skip
> > NOMAP regions while calculating zone_movable_pfn because your particular
> > firmware reports the reserved mirrored memory as NOMAP.
> >
> 
> NOMAP is a Linux construct - the particular firmware reports a
> 'reserved' memory region, but other more widely used memory types such
> as EfiRuntimeServicesCode or *Data would result in an omitted region
> as well, and can appear anywhere in the physical memory map. There is
> no requirement for the firmware to do anything here wrt the
> MORE_RELIABLE attribute even though such regions may be carved out of
> a block of memory that is reported as such to the OS.
> 
> So I agree with Wupeng Ma that there is an issue here: reporting it as
> mirrored even though it is reserved should not be needed to prevent
> the kernel from mishandling it.

But a check for NOMAP won't actually fix it in the general case, especially
if it can appear anywhere in the physical memory map. E.g. if there's an MR
region followed by two reserved regions and one of these regions is not
NOMAP and then MR region again, ZONE_NORMAL will only include the first MR
region.

We may want to consider scanning the entire memblock.memory to find all
mirrored regions in a and than make a decision where to cut ZONE_NORMAL
based on that.

-- 
Sincerely yours,
Mike.

