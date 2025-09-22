Return-Path: <linux-kernel+bounces-827664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DDDB92594
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB21F16A05D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078943128C0;
	Mon, 22 Sep 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qIyOb7nY"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77CE2D780A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560862; cv=none; b=YvW5NRDhuTE/7MZm7IiO04r4knw6bpMmwuxIIHvpLbK4M/W4Q4LZPKngQISGDBHRufzq08oyEhFW2VWk+8KR7XdBol6+rvwZ/nvYawV27LX504ILv+RzBRH1vGP3o+9zP1gWGSHv27CeHUaVLHNGmXUQk5jEvS1dkx0CcU8eYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560862; c=relaxed/simple;
	bh=oW2Z7Oee1Y9cSqTEm5oMUUXJ2TPcwlolNY+tvCTo7eU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TGoVDBibpujijKxT/W9qS3v4EDH7Hx7k4BtaKQ7JRJr+S3DReCwL6PInArM1t/yM3P+jpH8YFh8TnbDhjczoX/34n13sI6pSXfhCrgeUUYkgwKyOc1BU5RAAFA5qciDaHTFdPvMMe/ccdEFq8HF525vtusEtFjxmm6SN7yxChpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qIyOb7nY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JqGwuLdtfhO757m4LeuXnKCWOoq71+1IP2gYTz8bM8s=;
	t=1758560861; x=1759770461; b=qIyOb7nYYb3wybufTliF6GVOUCFSpIMRHjUmzjltOVfEkYI
	owIk345h9du9BLJjopeO9EfuUXah5akmzgXrc7zhR/3aimNXc9kajQvujFr8Nr8NLGScAZx63rzT9
	SX62Gmy6UYWiCq0UcGKgBmzUVdVdDWXU53bQjUczJznH5TQdeP4h55CTpz2alo9chYEktSU9bfWUb
	vpwmcsXri7vxfa40eRPPSgwBZuJ1a8p31nLGlRKlsNhI8sYjkkreAazuW75tGKzgmJQdY7DNqdx1w
	5a8OBy2YkX33xB/ax+xLZJ3kqJEdx4Z6ndMRVoqbNMWr4ccn6VAXmx7vU35mjwuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0k0e-00000004sVf-2Dfv;
	Mon, 22 Sep 2025 19:07:28 +0200
Message-ID: <96ae8e726480a36a37d472106b761a141394e845.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Mon, 22 Sep 2025 19:07:27 +0200
In-Reply-To: <61ae09df-d65b-4c9d-a0c1-7de915246590@t-8ch.de> (sfid-20250922_180452_263852_EC16D5FF)
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
	 <20250922045020.48158-1-tiwei.bie@linux.dev>
	 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
	 <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
	 <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de>
	 <366bb558c3fd23b9a80008d923f29ed0234e17b9.camel@sipsolutions.net>
	 <61ae09df-d65b-4c9d-a0c1-7de915246590@t-8ch.de>
	 (sfid-20250922_180452_263852_EC16D5FF)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-09-22 at 18:04 +0200, Thomas Wei=C3=9Fschuh wrote:

> > I don't know if I'd say "just overhead" - depends on which path is more
> > optimised in a typical libc implementation? I'd basically think it's
> > identical, no? You either link to the vDSO, or a __weak same function i=
n
> > the libc?
>=20
> The code also needs to be built and maintained.

Yeah, fair, though the vDSO doesn't really do anything, and if we do
want to use it then having a working version beats having to re-do it
from scratch, which=20

>  AFAIK __weak is only for
> the compile-time linker. The vDSO call will be an indirect call.

yeah, I looked at the links you'd sent earlier only later ...

> > > > I mean ... on the one hand, sure, it doesn't really do much after t=
his,
> > > > but OTOH it lets userspace actually use that path? So might be usef=
ul.
> > >=20
> > > What advantage does userspace have from it?
> >=20
> > Right now, none? But it's easier to play with if you have the
> > infrastructure, and I'm not convinced there's a _disadvantage_?
>=20
> So far that hasn't happened. The disadvantages are the ones from above,
> nothing critical. But of course it is your subsystem and your call to mak=
e.

Yeah, kind of agree, though I'd like to actually use it - especially in
time-travel mode - but haven't really gotten time to add it. Having it
maintained in-tree is a bit nicer in case of global updates, but yeah,
ultimately it's not really all that important either way.

I guess we could get getrandom() pretty easily by taking the x86 one.

I actually have half a patch somewhere that rejiggers the UM vDSO to be
more like normal architectures, using lib/vdso/gettimeofday.c and making
the build more regular etc. Maybe I should dig that up and try to make
it work entirely - it was part of a previous attempt of adding the time-
travel thing I mentioned.

> > Huh, hm, yeah I forgot about that ... 32-bit. Yeah, agree we should jus=
t
> > kill that. I'm not even sure it works with the host kernel trapping
> > there? Oh well.
>=20
> Ack, do you want me to send a patch? This was my real gripe with the UM
> vDSO. I want to enable time namespaces for all architectures but these
> need to be handled in the vDSO properly. For the 64-bit stub vDSO it's
> not a problem as the syscalls will work correctly.
> But the interaction with the weird 32-bit logic on the other hand...

I guess? But I'm confused by what you say about it being related to time
namespaces, the vsyscall stuff doesn't really _do_ anything, assuming it
works at all? It's not like the host actually could be doing anything
other than syscalls there, which are intercepted? If it were doing
anything else, it wouldn't work in UML in the first place?

johannes

