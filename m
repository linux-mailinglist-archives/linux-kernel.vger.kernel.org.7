Return-Path: <linux-kernel+bounces-769458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEBAB26EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80CF1CC519D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A042264C4;
	Thu, 14 Aug 2025 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNWIEHRN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18F1F17E8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196411; cv=none; b=qknuL4xh/CR/su8YNnCwU7C32h61ACiPmFXcQ0SmuOBgt/AoRPywjVzKL+taRC6yRpV98y0XexPt607YFcP1em9xI2d0DdjKjmCxYndw8YtGKB2WU8KbpdSBwO2feTE8F4ZKRH/mumxQH4q0zIl2w6DTaUR6QamI++U4Gp4wRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196411; c=relaxed/simple;
	bh=qByToXO/yO0suZ2Ntz3Z6GPLu9c2NXiYzwZ1jHLixcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+VOd4ZgoNYxJvXcutqDqCtwpT5Tto4buslr2z8aBwNOaG6A2NeAGAY3ioztjNZ/qlhGWjP9RE1+4nMsdMIeSbcDgDfel2oIzIZnoObjaxfqHtfvetRclxza8O8fkolLqilZVKQ7akPBkpQnTPS7RX3IYHnJ+IqKT0PTaKYRi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNWIEHRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B96C4CEED;
	Thu, 14 Aug 2025 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755196410;
	bh=qByToXO/yO0suZ2Ntz3Z6GPLu9c2NXiYzwZ1jHLixcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNWIEHRNmIDO90snEleU3QgJ+Df/sa8M7DMaFXkus7Ik14Y/V7q4EP4QN58haartJ
	 g0W2WPW+2vI6vNk8/QL3tEg1EIFW3HI/yZXvq/fSL0Vmc0dnE82J7rI8UXuk1/RTQO
	 XiyybnEeV0HILqDuQ0upaoCsKXwUohyDftLYu1hvNDCbTll9o5jaXwpfDd4tcPhPPo
	 9QLh29Qod+zCR1M5yUegKOCdhCab14rL3CwiN8gRBIIba6Vf6Yv1soOp34JOYq3zUE
	 /K+4yRq6ZNpoE0xYeOxokDHKV6qSPfSXDgZ9hPIX1YS08DnFJ0ox2+A9dBTWR9c4ko
	 jjIFD6nHMLuKQ==
Date: Thu, 14 Aug 2025 19:33:24 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>
Subject: Re: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NhbFOwRfHNFlxsfT"
Content-Disposition: inline
In-Reply-To: <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
X-Cookie: This sentence no verb.


--NhbFOwRfHNFlxsfT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2025 at 05:03:36PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2025-08-14 at 12:14 +0200, Oleg Nesterov wrote:

> > If a features_enabled(ARCH_SHSTK_SHSTK) userspace thread creates a
> > PF_USER_WORKER thread, shstk_alloc_thread_stack() allocates the shadow
> > stack for no reason, the new (kernel) thread will never return to usermode.

> I agree we don't need to allocate a shadow stack in this case, but I'm not sure
> it is right to fully disable shadow stack in thread.features. First of all,
> disabling it from shstk_alloc_thread_stack() seems weird. It just handles
> allocating shadow stacks.

I agree that it's better to leave userspace shadow stacks enabled, given
that the reason we're not allocating the shadow stack is that we don't
expect to ever return to userspace then it should be fine to leave the
feature turned on for userspace.  If we mess up and do somehow return to
userspace it seems better to have the feature enabled and hopefully give
us some protection against our mistake, and if something causes the
worker thread to start a normal thread then things should work as
expected.

> How about just adding the 'minimal' condition to:
> 	if (clone_flags & CLONE_VFORK) {
> 		shstk->base = 0;
> 		shstk->size = 0;
> 		return 0;
> 	}
> ...then update all the comments where vfork is called out as the only case that
> does this?

Perhaps we should factor the logic for deciding if we need to allocate a
userspace shadow stack out into the arch independent code and do
something like set a flag in kernel_clone_args that the arches can
check?  I think the logic is the same for all arches at the minute and
don't see a reason why it'd diverge.  That'd collide a bit with my
clone3() series, there's some overlap there with that creating another
reason why the decision would change.  Reducing the duplication would be
nice.

--NhbFOwRfHNFlxsfT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmieK/MACgkQJNaLcl1U
h9DcLAf+Pg3iT8Y6D0wMzT8+0gIN2YU+DELWP84RNf3zlw9CIq64rkzTQiFAA9FW
xX2efHYMzV+vLF+wvWOgO4Ai7V16brkB8XHojuwaX4tACvKPLFVNT4zqL146GmE2
mSopvqE6ES9JU/1JdnXqG3MVVf/T9JhLNWwBJphT/EKWlcBDU7pmzjcNyznGvTza
xkTSgrn0POVX5Ll+jSwdulLZ4z7r7hanoMZ/p0d8W6NNg7/5t4LoxDHafzQ6ljiH
sP9XsPPk+6IWvQVGu11zVjr5zwF0eYCVaGIGTYGXiM92HEKxFQyx4GqGffXxvwXq
gVkGJ8r+Z0RcoW9XzmKwUSrLktV7sg==
=atsl
-----END PGP SIGNATURE-----

--NhbFOwRfHNFlxsfT--

