Return-Path: <linux-kernel+bounces-770835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E50B27F76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB0A622119
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E692F2882A1;
	Fri, 15 Aug 2025 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSLqYkzB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBD6226D1B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258260; cv=none; b=O85F0/mFJv5SeXyvEuaAC3k+jNhEjIAFFpvei6RwhMgDru5i1Zyj3HztCk2e+GtHirC8UX8SPmhx65NAbSrlHbbd7+gWsBvcRj9FPIUr892cH4BxB2O6BDWAX+bjLj/Q2bEn5iUlxB7FznwSQRVzUGLjzIR9I+kRdxN0oySABc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258260; c=relaxed/simple;
	bh=w59mJ6B7WckgiftUA88D8QerNPfvLhIekK/6CJewm2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMc9QbZqr6Qtg7au+dcv/xoSZ1597M/4wu0VoOJR2r3Nc4sgHSFL5yOq2YFySTFK0K0BpMMbqIax0O0MJKPK+zmDbmxQpsbAeg8Os0L5hUIUSvJItMvFppapG2WauIb4NSO2JQe//yOP7c/l3k/x2T7df6E1Bhb9DXDK5uYDZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSLqYkzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373E9C4CEEB;
	Fri, 15 Aug 2025 11:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755258259;
	bh=w59mJ6B7WckgiftUA88D8QerNPfvLhIekK/6CJewm2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSLqYkzBsKDXKPgyQT5tdy25hyrQYWXpuHJkg5gCqgH2hLcpwSlPNqd8lWUerG3pQ
	 RCHjgTPgZSwIGxzWX0AWsibeOUKeY4mmWRNy6c8KxOZcr0YksuLnL3KxlQ72XHoc2V
	 DHO0Adthh88Ulba0ctU1GCOMYmjFxM6FXChpU0m/bnHCWWg3+QZ7xifw6RLJg2zK+X
	 9Dfkqx6SxY94Hria7eWW4aX5cgRKdzHRZKoeaPHbr7cLDZ1KTcgxv+iAZ8mNvZ2FkX
	 jvRCcfQ6HEtcdtVBaq+rHrY2DqClS9Mo8dbYFYq00D4Rr5eSLfLuAitrvRhs6PtbZG
	 m0/bE0WBuV1qg==
Date: Fri, 15 Aug 2025 12:44:14 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "debug@rivosinc.com" <debug@rivosinc.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <6abf383f-2756-4de6-a951-6121f51263e2@sirena.org.uk>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
 <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
 <78b04d05b94b605f287b9a594cd2aa9f1cda10df.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BQ7yUjIAMsKx+Dve"
Content-Disposition: inline
In-Reply-To: <78b04d05b94b605f287b9a594cd2aa9f1cda10df.camel@intel.com>
X-Cookie: Tell me what to think!!!


--BQ7yUjIAMsKx+Dve
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 10:43:45PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2025-08-14 at 19:33 +0100, Mark Brown wrote:

> > Perhaps we should factor the logic for deciding if we need to allocate a
> > userspace shadow stack out into the arch independent code and do
> > something like set a flag in kernel_clone_args that the arches can
> > check?=A0 I think the logic is the same for all arches at the minute and
> > don't see a reason why it'd diverge.

> Sounds good. Like a little start to this:
> https://lore.kernel.org/lkml/20241010-shstk_converge-v1-0-631beca676e7@ri=
vosinc.com/

Yes, exactly.

> > =A0 That'd collide a bit with my
> > clone3() series, there's some overlap there with that creating another
> > reason why the decision would change.=A0 Reducing the duplication would=
 be
> > nice.

> Argh, I need to test the latest of that still.

Yury pointed me at some newer x86 systems I was able to get access to so
I was finally able to test that one myself before sending it out,
confirmation would be good but hopefully it's fine.  I've been holding
back on sending a rebased version out since Deepak was going to help me
get set up to test it on RISC-V.  Though I see now that the RISC-V code
has vanished from -next (I guess due to fallout from the issues with the
merge to Linus, it looks like there's almost nothing in the branch
currently), not sure what the plan is there?

Perhaps I should just send it out, but given the difficulty getting
anyone to pay attention I was trying to avoid issues with missing
updates for newly added RISC-V shadow stacks.

--BQ7yUjIAMsKx+Dve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmifHY0ACgkQJNaLcl1U
h9B7Fgf9GoV8jK2DImTOHAAe8FZPqUayD2/i++GIjDTQpPJvZTDLiLfYPMZBrWr1
enl42UHraNeoscQgXa0tORlr37nkgQCdDt+aAz18LFi7+GbC3JdR//6N3mx/H2Hr
lgzLXQSQvp+uu11NAltdfUQ7dczXKipNic4a6+3zDgw57oExWz9QrSx013eI3chl
FW0VjEENyZo707w3/6mXXtqDsU1iuSn2tP2fAqxHp3PCGg3FD3MEbOHBrL2AS3id
3iOTU1CYH+rXJxlE/2/l8qPYzHXTiDFdWbQkXZXy1iW5eJsKAF9FDdNX1HNaRZWY
46zplRrD40Xg8CNF5WxHWJLFdoetgg==
=DHtU
-----END PGP SIGNATURE-----

--BQ7yUjIAMsKx+Dve--

