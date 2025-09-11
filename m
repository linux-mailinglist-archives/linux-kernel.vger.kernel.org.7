Return-Path: <linux-kernel+bounces-811856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E299FB52EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8B316B2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A9E258CD9;
	Thu, 11 Sep 2025 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tj3JYN6Y"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516AC266EF1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586914; cv=none; b=Xl4hVNbfxra0KaUKkGvBU0deVV0rs/EWR41i9/ZLrBMaijde5Rhcny6/A4UJ2s5JeKY2/y5IBdBYEcPWVE9KX2LFPDJhbXUiUHvtBtsmHWsRWLL179IsRmxi0AogvZOLlJ8aH6tAlsXFCf1gL11RQdopyqQogqWoI5DIonddkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586914; c=relaxed/simple;
	bh=hvOZY8Zm8Xu9d/QPkVVnky/0m0Z0DyGiA59b6hOBpMo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tt+2vfa0kXhLJUtKRkh7SqqHO8/IHrgR75uHR5m/hg7Z9P9/i0ZuD/ZEJSuKHaZsv9Cw5iJpA4UkokTGVBJdto9qB4G1W1fVFYnZqf6Ic7bV1VDla7Bh8TofFIf7CiwRYJryh+I5BegEy2oQR5wlqlYeV8Ai/zbCLDahQLI1YOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tj3JYN6Y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hvOZY8Zm8Xu9d/QPkVVnky/0m0Z0DyGiA59b6hOBpMo=;
	t=1757586912; x=1758796512; b=tj3JYN6YHRH0MymbPL4Tz6dJN5222c4AsV4I9Zj6CPVZ14w
	lmj2Dvx9Bm+FvuMAN9Z6jhImzxIfCGhf3fo+NqR6eG5KFjKfjh9Ebe6K7u9VFNojRvrzLs43y7h/n
	tNazFQGZcZzllBNfjg5dD6ImbQizyHjZVA7O1HTvvdXMfsWGcKlDHTYQ7QOklLT3ui+nBUw7/leMD
	DXA8THqViGl7eRh4VvDPh+b/b3f22bFKYc4sinGCSz6WqXy+pbxbuva6C4aSzbISQ18rrZVo+O5xm
	Nck5eg/KpO/9U5bnVPKvCf3o2F81KMqg+fK/8Q5tEx0QkSVTpp3u1SWLefviNANA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uwedr-0000000F6oE-1dg4;
	Thu, 11 Sep 2025 12:35:03 +0200
Message-ID: <263b95a673f92d1436ece3913b134f81eef3355d.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, Tiwei Bie
 <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 12:35:02 +0200
In-Reply-To: <b1a57068ec7578d20dcb3b28234e4ce7ec216657.camel@sipsolutions.net> (sfid-20250911_114423_984872_A9251D1F)
References: 
	<f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
			 <20250911043434.2897892-1-tiwei.bie@linux.dev>
		 <3c4bc989c4f10609eab699b26e8331bc878c2a0a.camel@sipsolutions.net>
	 <b1a57068ec7578d20dcb3b28234e4ce7ec216657.camel@sipsolutions.net>
	 (sfid-20250911_114423_984872_A9251D1F)
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

On Thu, 2025-09-11 at 11:44 +0200, Johannes Berg wrote:
> On Thu, 2025-09-11 at 09:37 +0200, Benjamin Berg wrote:
> > Hi,
> >=20
> > On Thu, 2025-09-11 at 12:34 +0800, Tiwei Bie wrote:
> > > On Wed, 10 Sep 2025 14:15:28 +0200, Johannes Berg wrote:
> > > > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > > >=20
> > > > > Turn signals_enabled, signals_pending and signals_active into
> > > > > thread-local variables. This enables us to control and track
> > > > > signals independently on each CPU thread. This is a preparation
> > > > > for adding SMP support.
> > > >=20
> > > > [...]
> > > >=20
> > > > > +static __thread int signals_enabled;
> > > >=20
> > > > How much glibc infrastructure does __thread rely on? More
> > > > specifically:
> > > > Some time ago we had a discussion about building UML as a nolibc
> > > > binary,
> > > > what would that mean for the __thread usage here?
> > >=20
> > > We would need to parse TLS data (PT_TLS) from the ELF file ourselves
> > > and properly set up TLS when creating threads using clone().
> >=20
> > I guess right now we cannot use PER_CPU variables in these files.
>=20
> Maybe? The only thing would be to know which "CPU" we're executing on?
> getpid() is async signal safe (i.e. you can call it), but there could be
> better ways of doing this such as setting different signal handler
> functions in different CPUs.

There are a number of ways to solve that problem.

One way would be to use a signal stack and calculating it from the
stack pointer. Though I am still considering that we should use the
tasks stack as the signal stack, in which case we may need to track the
CPU that a task is executing on.

On 64bit, one could also use the FS/GS registers for per-CPU data. I
believe the libc uses FS only on 64bit, so we could probably already
use the GS register to for per-CPU data.

So, I am not really worried about this, we probably need a nice
solution for per-CPU data anyway.

Benjamin

