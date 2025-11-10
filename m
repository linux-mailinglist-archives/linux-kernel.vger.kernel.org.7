Return-Path: <linux-kernel+bounces-894033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FB0C491ED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7100188C617
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F013332AABD;
	Mon, 10 Nov 2025 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okuif7Mx"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7CE22F16E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803990; cv=none; b=lucBTxf2vEoJVvoQHrX1n8RckXIi3ploxoIXv28u0pf71/cDqFDra/l/hby7MqgEtTWz5Crnso03TNWJP5nNvZ6pEFnsQH0TXScq+eyE6wzkwueOMA+Azuqfb/xRyszlZ22FFmpIe52Jq2fJfyNn/Nbm9AeFNhHirAY1VJElpN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803990; c=relaxed/simple;
	bh=YZGaIzpaEZLGappva0Ug2DJlxNAxd2ApsVVc832oRdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0E7LjYTDRYslh4r7JHPdSOXnuYcRfgqmvgOkeVsWhOcfsJH3zxB7kZAILs6XeVKZPAAi7NcFuRPvQnm35vth1VgignEjCAgtS4d7Xsp2jobhDuQateTJmJaIdKRO/1ZMy6kxs55OTyQlNG2EPQIBJRvCjXkFjw3Pm4Cv1LLMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okuif7Mx; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-559748bcf99so3129686e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762803987; x=1763408787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYTpMH/+7AmKmRXshRvtBV04IdawyBlwk+7ovqC25vc=;
        b=okuif7MxofwRcZacNsKUF79wne34F2KF3wLLAwQgkPeFHXu6pnr7MiWd+v1VmcmzZR
         v5hkV7ErRBK0oWVHoD6xlO033K5wQaqAQJG7kJEa0AxDW3QCxjJRmkREa2FEblrgilB+
         YFZ1Rr4JiPzMntRq7ER8L4WS9XAjc4oF6XNotj6LaIANev/MCfYX1M51Ot+f7W/0pfhM
         fSpGnGmiBp8ctwM1w2SNjdIVCuGsw3TCYDJpBwKa4w9rGDd2v0ZKqsrpMoOrw6soRaiZ
         He+yCfk9Y0s9aAAcecNR7cc17tCvzoTWniAmq7TyVY6/LskWoXOdr/e7juiWcedkHYzq
         zqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762803987; x=1763408787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aYTpMH/+7AmKmRXshRvtBV04IdawyBlwk+7ovqC25vc=;
        b=TPNJhG8GiFshclkGso/cgEM3Cp7Qip12/69nXWQUwvH023uTKkq+4lDLxmZUNrIeig
         /USwf/0UvEka8OqkYd745H71Pfw8Aw1DrmBI11i7q/6HgNMdoQd43N5PT0N8aZrhS5Zj
         nWkH5bM2Koy1dQPszdEEa2k1u6sgpbY05sI+2XwYfslaGT2Fiub9yBvLbfp5lesZC/+H
         bBEdij5pb6OAMRH4CQhim46vkFdFTczx1YZOE4/M/XNTyNCPwNYrGkBU9qXsmLxSB+l4
         fmocBWwAaWWiusziZ1EWCa5qDHjeg/Icniahu5u7Nv6tSxLvpqrV0EyCW9b3TCRmQYps
         hV6A==
X-Forwarded-Encrypted: i=1; AJvYcCXuSEC2nqteOAIs3z6uJhuAJALzIMFP/dczKkUsVkh+HiiuVxoss4iATq2A3toWTfMf/3COPRb9HgqDiOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynlB+OnSo2DZW/4M10SLxRqytj51V/l8pYFeAJ7WCpOZ/qOIFo
	+2knHc7alT9PQhlEBEMd/YQSKXr4ZV78Vob9V4pTr2v/1jTxfqIt+NFBe5onYwKaly7nDPMogV1
	BCqWW6Lg4xR6v+V3MjF9Ny7HBDa4H0FKpKqWBhB9z
X-Gm-Gg: ASbGncv1MgjbRVozNCX0mavOiwKro2cH0cVNPd4ngQZGze1jBiKtxotAMKKNCauIW0g
	Cowo8G5Db07lZqgMbzYOkXHagIXPIDeMb8B6MRo8gdFCagxWCB5rxF739HrTZ8b+xgkAr7PUfTe
	HcY7QlfOQQUhBQLDKReRY7N1j9WVl9Fo5en+NAxarT9yejF3HHLXQgUbxPSw014qVa5qTh3amm3
	g/EtxFKOuBxjDWX/0GiRFhNk+drGXrPeIEVyZEDJX5cuWFvtOQcnKxLaA/AE/SHf4i2uTqEZ3KN
	wqDYag==
X-Google-Smtp-Source: AGHT+IFrPIDtYP60imdNibriTTZFyFrg+kjwiw3cwvkj6Zc23sMdHolxpslhziSXkbR/ghaQ1HgKcIIE93DXZLTrHBI=
X-Received: by 2002:a05:6102:26c6:b0:5db:cc92:26f9 with SMTP id
 ada2fe7eead31-5ddc47df8damr3248309137.39.1762803986990; Mon, 10 Nov 2025
 11:46:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107222058.2009244-1-dmatlack@google.com> <aQ6MFM1NX8WsDIdX@devgpu015.cco6.facebook.com>
 <aQ+l5IRtFaE24v0g@devgpu015.cco6.facebook.com> <20251108143710.318702ec.alex@shazbot.org>
 <aQ/sShi4MWr6+f5l@devgpu015.cco6.facebook.com> <20251110081709.53b70993.alex@shazbot.org>
 <aRIXboz5X4KKq/8R@devgpu015.cco6.facebook.com> <aRIoKJk0uwLD-yGr@google.com> <20251110113757.22b320b8.alex@shazbot.org>
In-Reply-To: <20251110113757.22b320b8.alex@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Mon, 10 Nov 2025 11:45:58 -0800
X-Gm-Features: AWmQ_bk67Z3e_yqE6nHsy2EDKFAt5tOOA0GQBcdd5DTPf5JePRQJHPfsb4jsmaM
Message-ID: <CALzav=d2w1Q4_P2AjfM0aantjtdKW_1jRUMprRQiC2SCk77ewg@mail.gmail.com>
Subject: Re: [PATCH] vfio: selftests: Skip vfio_dma_map_limit_test if mapping
 returns -EINVAL
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:38=E2=80=AFAM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> On Mon, 10 Nov 2025 18:00:08 +0000
> David Matlack <dmatlack@google.com> wrote:
>
> > On 2025-11-10 08:48 AM, Alex Mastro wrote:
> > > On Mon, Nov 10, 2025 at 08:17:09AM -0700, Alex Williamson wrote:
> > > > On Sat, 8 Nov 2025 17:20:10 -0800
> > > > Alex Mastro <amastro@fb.com> wrote:
> > > >
> > > > > On Sat, Nov 08, 2025 at 02:37:10PM -0700, Alex Williamson wrote:
> > > > > > On Sat, 8 Nov 2025 12:19:48 -0800
> > > > > > Alex Mastro <amastro@fb.com> wrote:
> > > > > > > Here's my attempt at adding some machinery to query iova rang=
es, with
> > > > > > > normalization to iommufd's struct. I kept the vfio capability=
 chain stuff
> > > > > > > relatively generic so we can use it for other things in the f=
uture if needed.
> > > > > >
> > > > > > Seems we were both hacking on this, I hadn't seen you posted th=
is
> > > > > > before sending:
> > > > > >
> > > > > > https://lore.kernel.org/kvm/20251108212954.26477-1-alex@shazbot=
.org/T/#u
> > > > > >
> > > > > > Maybe we can combine the best merits of each.  Thanks,
> > > > >
> > > > > Yes! I have been thinking along the following lines
> > > > > - Your idea to change the end of address space test to allocate a=
t the end of
> > > > >   the supported range is better and more general than my idea of =
skipping the
> > > > >   test if ~(iova_t)0 is out of bounds. We should do that.
> > > > > - Introducing the concept iova allocator makes sense.
> > > > > - I think it's worthwhile to keep common test concepts like vfio_=
pci_device
> > > > >   less opinionated/stateful so as not to close the door on certai=
n categories of
> > > > >   testing in the future. For example, if we ever wanted to test I=
OVA range
> > > > >   contraction after binding additional devices to an IOAS or vfio=
 container.
> > > >
> > > > Yes, fetching the IOVA ranges should really occur after all the dev=
ices
> > > > are attached to the container/ioas rather than in device init.  We =
need
> > > > another layer of abstraction for the shared IOMMU state.  We can
> > > > probably work on that incrementally.
> >
> > I am working on pulling the iommu state out of struct vfio_pci_device
> > here:
> >
> >   https://lore.kernel.org/kvm/20251008232531.1152035-5-dmatlack@google.=
com/
> >
> > But if we keep the iova allocator a separate object, then we can
> > introduce it mosty indepently from this series. I imagine the only thin=
g
> > that will change is passing a struct iommu * instead of a struct
> > vfio_pci_device * when initializing the allocator.
> >
> > > >
> > > > I certainly like the idea of testing range contraction, but I don't
> > > > know where we can reliably see that behavior.
> > >
> > > I'm not sure about the exact testing strategy for that yet either act=
ually.
> > >
> > > > > - What do you think about making the concept of an IOVA allocator=
 something
> > > > >   standalone for which tests that need it can create one? I think=
 it would
> > > > >   compose pretty cleanly on top of my vfio_pci_iova_ranges().
> > > >
> > > > Yep, that sounds good.  Obviously what's there is just the simplest
> > > > possible linear, aligned allocator with no attempt to fill gaps or
> > > > track allocations for freeing.  We're not likely to exhaust the add=
ress
> > > > space in an individual unit test, I just wanted to relieve the test
> > > > from the burden of coming up with a valid IOVA, while leaving some
> > > > degree of geometry info for exploring the boundaries.
> > >
> > > Keeping the simple linear allocator makes sense to me.
> > >
> > > > Are you interested in generating a combined v2?
> > >
> > > Sure -- I can put up a v2 series which stages like so
> > > - adds stateless low level iova ranges queries
> > > - adds iova allocator utility object
> > > - fixes end of ranges tests, uses iova allocator instead of iova=3Dva=
ddr
> >
> > +1 to getting rid of iova=3Dvaddr.
> >
> > But note that the HugeTLB tests in vfio_dma_mapping_test.c have
> > alignment requirements to pass on Intel (since it validates the pages
> > are mapped at the right level in the I/O page tables using the Intel
> > debugfs interface).
> >
> > > > TBH I'm not sure that just marking a test as skipped based on the D=
MA
> > > > mapping return is worthwhile with a couple proposals to add IOVA ra=
nge
> > > > support already on the table.  Thanks,
> > >
> > > I'll put up the new series rooted on linux-vfio/next soon.
> >
> > I think we should try to get vfio_dma_mapping_test back to passing in
> > time for Linux 6.18, since the newly failing test was added in 6.18.
> >
> > The sequence I was imagining was:
> >
> >  1. Merge the quick fix to skip the test into 6.18.
>
> We'd still have the iova=3Dvaddr failure on some platforms, but could
> hack around that by hard coding some "well supporteD" IOVA like 0 or
> 4GB.

Good point. We tried using IOVA=3D0 internally for a while but hit
issues on ARM platforms that have a reserved region at [0x8000000,
0x8100000). So I think iova=3D4GB would be better.

>
> >  2. Split struct iommu from struct vfio_pci_device.
> >  3. Add iova allocator.
> >
> > AlexW, how much time do we have to get AlexM's series ready? I am fine
> > with doing (3), then (2), and dropping (1) if there's enough time.
>
> I'll certainly agree that it'd be a much better precedent if the self
> test were initially working, but also we should not increase the scope
> beyond what we need to make it work for v6.18.  If we can get that done
> in the next day or two, add it to linux-next mid-week, and get Linus to
> pull for rc6, I think that'd be reasonable.  Thanks,

Ack. I'll send a small series with this patch plus a patch to replace
iova=3Dvaddr with iova=3D4G, and we can use that as a back-up plan if
AlexM's iova allocator isn't ready in time for 6.18.

