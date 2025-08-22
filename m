Return-Path: <linux-kernel+bounces-781431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1ABB3124F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8DF1CE5E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998BC2EBDFF;
	Fri, 22 Aug 2025 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAGnySQ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC552EBDE3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852764; cv=none; b=N2nzH2A/K9387ffDMS/Gas7XdCk2+eWrcTl2lC1QhYTF07izMzF/exXeQ1PL5vqjdwl8yeuT4U8Npq/kOisJKJZhch7Tv0PXqlA5iKGAZ0J/sB6gTk/68VOFczwCNQrcpWxyDZ7f2tln4yrEjz9Z7vTsF8dOMQ85V3VI5csr7bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852764; c=relaxed/simple;
	bh=3jx+mcX+m+7XdDw9j1KCm1DfU1GXzaRIrU87PKiRUzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ/hE6qwJo4awVAA229+itd83/orK2wHlSE+8T9PqNMigdHvue4+0YMljHzlbUNnjYACbKX8oVu7aMqIQPDMhv5sjUKCL3lHX6oqL/WL5zMn2FJ6v+/R42q3aGD77ElzXDDbPMCADuYyRyprly4jxhSHevtP6sRa2y0FeZnHQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAGnySQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DA8C4CEF1;
	Fri, 22 Aug 2025 08:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755852764;
	bh=3jx+mcX+m+7XdDw9j1KCm1DfU1GXzaRIrU87PKiRUzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAGnySQ7M3XLL8PtyxO+OaqEEdWTRQgqDiSrl+QXcspMKh/fsD8G6c0njDV7J0Azn
	 BFkHXpRDvr/Fbr/eGk+SvzZYmGvPHMOdzVjj9N4PBAZFKEVUGBCVoc7zKjQfXbElcH
	 u6WGaXpePSiNYN9/yAesrlaVHM42Rb9og/Ppjxuo9XEX8Yn9B5xLzV3qSgXB4ycxrq
	 7VmIyifCOFmLTn/5vH+Zu1wt1+5bVHUTE0LZdIXyDNNHZL4UO88X2NytulMKDQM4cA
	 UoV9NDMbTBIRgSaVpCgs3OO033m2n8REvE0C0bUiPGNHn9AQ2RQAjrT1ffofKVdPlH
	 GsXTiChAAKXug==
Date: Fri, 22 Aug 2025 14:22:27 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Matthew Wilcox <willy@infradead.org>, vbabka@suse.cz,
	akpm@linux-foundation.org, kernel@pengutronix.de,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <aKgvywfzQsi7b1wW@sumit-X1>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
 <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
 <CAHUa44FUK_73oKSaqGdiPqB3geZbTNDFsC1Mh=KN3YPWr9=7gQ@mail.gmail.com>
 <Z-TXMIXzaro0w60M@sumit-X1>
 <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
 <20250821174124.b6pco3izkns4qt2r@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821174124.b6pco3izkns4qt2r@pengutronix.de>

On Thu, Aug 21, 2025 at 07:41:24PM +0200, Marco Felsch wrote:
> Hi all,
> 
> is this issue fixed with 6.17? I ran:
> 
>   git log v6.14...v6.17-rc1 drivers/tee/tee_shm.c
> 
> and saw no changes.

Care to send a proper patch regarding what Matthew proposed in this
thread?

-Sumit

> 
> Regards,
>   Marco
> 
> On 25-04-28, Jens Wiklander wrote:
> > On Thu, Mar 27, 2025 at 5:42 AM Sumit Garg <sumit.garg@kernel.org> wrote:
> > >
> > > On Wed, Mar 26, 2025 at 02:47:46PM +0100, Jens Wiklander wrote:
> > > > On Wed, Mar 26, 2025 at 12:07 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > > >
> > > > > On 25-03-26, Matthew Wilcox wrote:
> > > > > > On Tue, Mar 25, 2025 at 09:07:39PM +0100, Marco Felsch wrote:
> > > > > > > Skip manipulating the refcount in case of slab pages according commit
> > > > > > > b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").
> > > > > >
> > > > > > This almost certainly isn't right.  I know nothing about TEE, but that
> > > > > > you are doing this indicates a problem.  The hack that we put into
> > > > > > networking should not be blindly replicated.
> > > > > >
> > > > > > Why are you taking a reference on the pages to begin with?  Is it copy
> > > > > > and pasted from somewhere else, or was there actual thought put into it?
> > > > >
> > > > > Not sure, this belongs to the TEE maintainers.
> > > >
> > > > I don't know. We were getting the user pages first, so I assume we
> > > > just did the same thing when we added support for kernel pages.
> > > >
> > > > >
> > > > > > If it's "prevent the caller from freeing the allocation", well, it never
> > > > > > accomplished that with slab allocations.  So for callers that do kmalloc
> > > > > > (eg setup_mm_hdr()  in drivers/firmware/efi/stmm/tee_stmm_efi.c), you
> > > > > > have to rely on them not freeing the allocation while the TEE driver
> > > > > > has it.
> > >
> > > It's not just about the TEE driver but rather if the TEE implementation
> > > (a trusted OS) to whom the page is registered with. We don't want the
> > > trusted OS to work on registered kernel pages if they gets free somehow
> > > in the TEE client driver. Having a reference in the TEE subsystem
> > > assured us that won't happen. But if you say slab allocations are still
> > > prone the kernel pages getting freed even after refcount then can you
> > > suggest how should we handle this better?
> > >
> > > As otherwise it can cause very hard to debug problems if trusted OS can
> > > manipulate kernel pages that are no longer available.
> > 
> > We must be able to rely on the kernel callers to have the needed
> > references before calling tee_shm_register_kernel_buf() and to keep
> > those until after calling tee_shm_free().
> > 
> > 
> > >
> > > > > >
> > > > > > And if that's your API contract, then there's no point in taking
> > > > > > refcounts on other kinds of pages either; it's just unnecessary atomic
> > > > > > instructions.  So the right patch might be something like this:
> > > > > >
> > > > > > +++ b/drivers/tee/tee_shm.c
> > > > > > @@ -15,29 +15,11 @@
> > > > > >  #include <linux/highmem.h>
> > > > > >  #include "tee_private.h"
> > > > >
> > > > > I had the same diff but didn't went this way since we can't be sure that
> > > > > iov's are always slab backed. As far as I understood IOVs. In
> > > > > 'worst-case' scenario an iov can be backed by different page types too.
> > > >
> > > > We're only using kvec's. Briefly, before commit 7bdee4157591 ("tee:
> > > > Use iov_iter to better support shared buffer registration") we checked
> > > > with is_vmalloc_addr() || is_kmap_addr(). I like Matthew's suggestion,
> > > > it's nice to fix problems by deleting code. :-)
> > > >
> > > > Sumit, you know the callers better. What do you think?
> > >
> > > If we don't have a sane way to refcont registered kernel pages in TEE
> > > subsystem then yeah we have to solely rely on the client drivers to
> > > behave properly. Nevertheless, it's still within the kernel boundaries
> > > which we can rely upon.
> > 
> > Yes.
> > 
> > Cheers,
> > Jens

