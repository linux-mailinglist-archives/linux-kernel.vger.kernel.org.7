Return-Path: <linux-kernel+bounces-781641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FDDB314E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4240717B98D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8C27602E;
	Fri, 22 Aug 2025 10:15:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A411B041A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857736; cv=none; b=WXdKisl3l2cP8oyPdxyTVtxEw/4IEKqkuV8w93tamH0G1stoOOmLYBRWIJPo9k67/MXOjN1DpqbTjgvAvzXL3L83Q7j9H/LxJCBpE21i7DT+zjGRTfH/iZvKMl94ya5mB148ax1wwFc4hSPbyGMGIHol9qh4QARYqcfX+uUTNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857736; c=relaxed/simple;
	bh=EljbnmUNDXNka0Oz5VifHG2IvAOabE3hwKd1cZCxSTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjkwCcwi5nlyfaHVkXIfe/a9yc25ReN59kOpAYDkElKHlvLcGDLT7eH3W2RMRWCTXSn3ZDzuB1v7wWJL0Sgi0d0EU/XiDsiXKaor1/alXgWhGNSidHn0QmutG90U6pogYmdsiRPgbIXGKcaJzhxHC/V1aJXBOpPxMtw1zVCmduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1upOns-0004Vk-Hx; Fri, 22 Aug 2025 12:15:24 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1upOnq-001YrU-0r;
	Fri, 22 Aug 2025 12:15:22 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1upOnq-00A6Ga-0S;
	Fri, 22 Aug 2025 12:15:22 +0200
Date: Fri, 22 Aug 2025 12:15:22 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Matthew Wilcox <willy@infradead.org>, vbabka@suse.cz,
	akpm@linux-foundation.org, kernel@pengutronix.de,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <20250822101522.wlwmdal5f4sqydjq@pengutronix.de>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
 <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
 <CAHUa44FUK_73oKSaqGdiPqB3geZbTNDFsC1Mh=KN3YPWr9=7gQ@mail.gmail.com>
 <Z-TXMIXzaro0w60M@sumit-X1>
 <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
 <20250821174124.b6pco3izkns4qt2r@pengutronix.de>
 <aKgvywfzQsi7b1wW@sumit-X1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKgvywfzQsi7b1wW@sumit-X1>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-08-22, Sumit Garg wrote:
> On Thu, Aug 21, 2025 at 07:41:24PM +0200, Marco Felsch wrote:
> > Hi all,
> > 
> > is this issue fixed with 6.17? I ran:
> > 
> >   git log v6.14...v6.17-rc1 drivers/tee/tee_shm.c
> > 
> > and saw no changes.
> 
> Care to send a proper patch regarding what Matthew proposed in this
> thread?

I'm still not sure if the IOVs can be backed by other allocators too
because the OP-TEE API allows arbitrary sizes. Therefore my hope was
that one of the OP-TEE maintainers is taking care of this problem.

I also wonder why no one spotted/reported this issue too.

Regards,
  Marco


> 
> -Sumit
> 
> > 
> > Regards,
> >   Marco
> > 
> > On 25-04-28, Jens Wiklander wrote:
> > > On Thu, Mar 27, 2025 at 5:42 AM Sumit Garg <sumit.garg@kernel.org> wrote:
> > > >
> > > > On Wed, Mar 26, 2025 at 02:47:46PM +0100, Jens Wiklander wrote:
> > > > > On Wed, Mar 26, 2025 at 12:07 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > > > >
> > > > > > On 25-03-26, Matthew Wilcox wrote:
> > > > > > > On Tue, Mar 25, 2025 at 09:07:39PM +0100, Marco Felsch wrote:
> > > > > > > > Skip manipulating the refcount in case of slab pages according commit
> > > > > > > > b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").
> > > > > > >
> > > > > > > This almost certainly isn't right.  I know nothing about TEE, but that
> > > > > > > you are doing this indicates a problem.  The hack that we put into
> > > > > > > networking should not be blindly replicated.
> > > > > > >
> > > > > > > Why are you taking a reference on the pages to begin with?  Is it copy
> > > > > > > and pasted from somewhere else, or was there actual thought put into it?
> > > > > >
> > > > > > Not sure, this belongs to the TEE maintainers.
> > > > >
> > > > > I don't know. We were getting the user pages first, so I assume we
> > > > > just did the same thing when we added support for kernel pages.
> > > > >
> > > > > >
> > > > > > > If it's "prevent the caller from freeing the allocation", well, it never
> > > > > > > accomplished that with slab allocations.  So for callers that do kmalloc
> > > > > > > (eg setup_mm_hdr()  in drivers/firmware/efi/stmm/tee_stmm_efi.c), you
> > > > > > > have to rely on them not freeing the allocation while the TEE driver
> > > > > > > has it.
> > > >
> > > > It's not just about the TEE driver but rather if the TEE implementation
> > > > (a trusted OS) to whom the page is registered with. We don't want the
> > > > trusted OS to work on registered kernel pages if they gets free somehow
> > > > in the TEE client driver. Having a reference in the TEE subsystem
> > > > assured us that won't happen. But if you say slab allocations are still
> > > > prone the kernel pages getting freed even after refcount then can you
> > > > suggest how should we handle this better?
> > > >
> > > > As otherwise it can cause very hard to debug problems if trusted OS can
> > > > manipulate kernel pages that are no longer available.
> > > 
> > > We must be able to rely on the kernel callers to have the needed
> > > references before calling tee_shm_register_kernel_buf() and to keep
> > > those until after calling tee_shm_free().
> > > 
> > > 
> > > >
> > > > > > >
> > > > > > > And if that's your API contract, then there's no point in taking
> > > > > > > refcounts on other kinds of pages either; it's just unnecessary atomic
> > > > > > > instructions.  So the right patch might be something like this:
> > > > > > >
> > > > > > > +++ b/drivers/tee/tee_shm.c
> > > > > > > @@ -15,29 +15,11 @@
> > > > > > >  #include <linux/highmem.h>
> > > > > > >  #include "tee_private.h"
> > > > > >
> > > > > > I had the same diff but didn't went this way since we can't be sure that
> > > > > > iov's are always slab backed. As far as I understood IOVs. In
> > > > > > 'worst-case' scenario an iov can be backed by different page types too.
> > > > >
> > > > > We're only using kvec's. Briefly, before commit 7bdee4157591 ("tee:
> > > > > Use iov_iter to better support shared buffer registration") we checked
> > > > > with is_vmalloc_addr() || is_kmap_addr(). I like Matthew's suggestion,
> > > > > it's nice to fix problems by deleting code. :-)
> > > > >
> > > > > Sumit, you know the callers better. What do you think?
> > > >
> > > > If we don't have a sane way to refcont registered kernel pages in TEE
> > > > subsystem then yeah we have to solely rely on the client drivers to
> > > > behave properly. Nevertheless, it's still within the kernel boundaries
> > > > which we can rely upon.
> > > 
> > > Yes.
> > > 
> > > Cheers,
> > > Jens

