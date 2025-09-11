Return-Path: <linux-kernel+bounces-811588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7694BB52B30
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8AB7B8248
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5B22D248D;
	Thu, 11 Sep 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AB5AWiWW"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6F22D3EFD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578022; cv=none; b=SmNXRf7xnZ3Wb+hmNj9Z3Gbdh5fMh/TVj1wAYHQjobFZBMUlQUDQch7qp0YiSMu2xjCXkfN7IMIsUlrH6TvAo11VnLv9k2kEfl2jb/JCsl7Bzudm2d0wMBEASvbu/GbbLslkICWIaCj9oSsjW4nMXKrP9QP+eAgFq8npPObtjmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578022; c=relaxed/simple;
	bh=SdyRmw9p5x1dwU7eSbbWZaY8BxsvaFQgaS8zXojilmg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PINRDh3cBeeLGahMf1v7N7EqdE0Bcr42m4OB5yQta9+ZaqdtUh9m2mZ3XaF8GJETcY4+Z0QLpT3w82+s44Lax+O/OByO2B7WcxrX6OX0EwP3GnthmM7sizhsFu7AbKwEhxz1A9HrVwuq+MgsM5eomQUUq7BXzYnh21sn2855jqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AB5AWiWW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SdyRmw9p5x1dwU7eSbbWZaY8BxsvaFQgaS8zXojilmg=;
	t=1757578021; x=1758787621; b=AB5AWiWW6zp7wsEry6xp7/rYGGdSoTpsxmBXWIVMpG7yC/y
	dXuh5Y9kLXorgWC6+leeTAmmnhanDCNObOeuTNsWUBarzZhHtOR6+afkNwP0G2igOtxubp4qbYqwn
	OsJiNNJCHFCtWcYcRlEb2k7Ji7jVY5pa95VF1jRL4tWsmWr3kDKJIkM2GDqmIQVdnaMx508R4+7TU
	+GraBYWaGGYWJwQv9tlAUczVGd/+oDuC7Gnajo2TOfqFhGQpW0A7ix5kD8/KDecK7DRMYJXHq2Mid
	+q2iNKpZuCqJ08NcD8VztLUJkl43h3YpNSflhOmGPabbP9yRoSJ3G6a0cMes8icQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uwcKU-0000000Etn4-280i;
	Thu, 11 Sep 2025 10:06:54 +0200
Message-ID: <75ba2109fcdfb8a1629fdf5f6b4e58694b975c9f.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, johannes@sipsolutions.net
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 10:06:53 +0200
In-Reply-To: <3c4bc989c4f10609eab699b26e8331bc878c2a0a.camel@sipsolutions.net>
References: 
	<f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
		 <20250911043434.2897892-1-tiwei.bie@linux.dev>
	 <3c4bc989c4f10609eab699b26e8331bc878c2a0a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

On Thu, 2025-09-11 at 09:37 +0200, Benjamin Berg wrote:
> Hi,
>=20
> On Thu, 2025-09-11 at 12:34 +0800, Tiwei Bie wrote:
> > On Wed, 10 Sep 2025 14:15:28 +0200, Johannes Berg wrote:
> > > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > >=20
> > > > Turn signals_enabled, signals_pending and signals_active into
> > > > thread-local variables. This enables us to control and track
> > > > signals independently on each CPU thread. This is a preparation
> > > > for adding SMP support.
> > >=20
> > > [...]
> > >=20
> > > > +static __thread int signals_enabled;
> > >=20
> > > How much glibc infrastructure does __thread rely on? More
> > > specifically:
> > > Some time ago we had a discussion about building UML as a nolibc
> > > binary,
> > > what would that mean for the __thread usage here?
> >=20
> > We would need to parse TLS data (PT_TLS) from the ELF file
> > ourselves
> > and properly set up TLS when creating threads using clone().
>=20
> I guess right now we cannot use PER_CPU variables in these files.
> However, my expectation that this is possible when using nolibc, and
> then it should be simple enough to replace the __thread.

That said, I do believe that the allocations from the libc itself are
problematic. A lot of the mappings from UML are there already (i.e. the
physical memory is mapped). However, I believe the vmalloc area for
example is not guarded.

So when pthread allocates the thread specific memory (stack, TLS, ...),
we really do not know where this will be mapped into the address space.
If it happens to be in an area that UML wants to use later, then UML
could map e.g. vmalloc data over it.

Now, it could be that (currently) the addresses picked by pthread (or
the host kernel) do not actually clash with anything. However, I do not
think there is any guarantee for that.

Benjamin

