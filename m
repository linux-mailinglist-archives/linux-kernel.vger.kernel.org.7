Return-Path: <linux-kernel+bounces-799107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DAFB4270F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E01BC30A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9356E3002CD;
	Wed,  3 Sep 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhFjD55p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CDE29827E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917598; cv=none; b=UKSdb32EacWYW0c+J88ZwT35JTcSg6J42YykT6BpJKADU4jvBzYzf4CuJZ8X9r35WzvGSJmF0g5FyUYxy6cBSKkzUckm19NhLTtjo/gYQn3L7dCMzvMtVqbcmrOozgCQGE0xxGbSOv+EnHeA/zTM8pBUifmNsgbLj2B9IEa/IMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917598; c=relaxed/simple;
	bh=lltJqbtL8jGglMu52dmSTJ1f+RVzv6gY6yZe66gWM+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDD0Yyyv6gJShvJiEfnu7saYGMb9VwQnNFpL5Nf5rdynWRMS1+3Ji5WDKkeXVsCIj3Lz92IHM+uq4SJMqjCOXyij9HdsBe3bmTRlwszs39MYF7Ayw8mMm7p/xQsP1fpPfAzaL1QXXJ3jDHvb0z7kjPvQggQCv3Pqfrm/UP1IN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhFjD55p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74E3C4CEE7;
	Wed,  3 Sep 2025 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756917597;
	bh=lltJqbtL8jGglMu52dmSTJ1f+RVzv6gY6yZe66gWM+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uhFjD55pmV2AVHygQMu3ZNpb29R5A2gRetup3aFXxYWROnlwxSkMmjBHaG27maBMv
	 eQvgHYQmS20yrYKRXz3vBtYLjlTbOZoYzx80tlcnAGMBqPAImcEq2FvsmkLqSVuMUm
	 2Tt0YcGwEQk2eqeElamo3sFGiZI7R5D3hjwJc9J2Kv8imFinTkQcQutetNVRPqUE+T
	 HDn1TnPKcdXKImIAXMiDD9FFqVRdhDGw9ly1JbUaNZZN+O86chBcEXaAypsfMetxkA
	 XX/EVF3mLg/8wIdksEDp4VRa5gzHhxi6uapudq7Xeq2k5xBC57ccPyIr5lC/N+X3Bv
	 gNYnCyOzHzUkg==
Date: Wed, 3 Sep 2025 17:39:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Deepak Gupta <debug@rivosinc.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 1/1] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <f071255b-b62b-43c9-b374-d213017dffd5@sirena.org.uk>
References: <20250903134126.GA27641@redhat.com>
 <20250903134203.GA27651@redhat.com>
 <b91c72b6-cbe0-4767-8d65-05f804733a55@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="riwJw+X1Dgcp1K63"
Content-Disposition: inline
In-Reply-To: <b91c72b6-cbe0-4767-8d65-05f804733a55@intel.com>
X-Cookie: You were s'posed to laugh!


--riwJw+X1Dgcp1K63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2025 at 09:14:30AM -0700, Dave Hansen wrote:
> On 9/3/25 06:42, Oleg Nesterov wrote:

> >  arch/x86/include/asm/shstk.h | 4 ++--
> >  arch/x86/kernel/process.c    | 2 +-
> >  arch/x86/kernel/shstk.c      | 9 +++++++--
> >  3 files changed, 10 insertions(+), 5 deletions(-)

> That's not a great diffstat for a "cleanup". It's also not fixing any
> end-user-visible issues as far as I can tell.

...

> This doesn't clean things up or clarify the situation enough to make me
> want to apply it immediately.

I think the suggestion from one of the earlier discussions that if we
want to do this we roll it into a more general pulling out of shared
shadow stack code into the core makes sense here.  There's clearly a lot
of overlap between the three shadow stack implementations we have, and
an optimisation like this really shouldn't be arch specific.  I do
intend to poke at this whenever my clone3() series goes in.

--riwJw+X1Dgcp1K63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi4b1cACgkQJNaLcl1U
h9DJHAf8Civo7DP8dKs7EER6k6qMWgmna0rERb9A32P7WYU+8NONAvhkcTs+jNNe
8g6fs8cJY+fyp66sSjHWyr7wk41JWL4u1qCt9Fcd5HBGfptPBKzeRfVV/aycQamj
g7e9wcmi4b3Fc6EllpjeOf/KprZCVqN+Z8rTiEDN68eiUHpnh5b80BALQ22gucC1
kERMCa37FnXkOSql4f63ecyqtoQcY8Uo+4JYk85eUUtCOSS0JRiYnZdDlA2QuCPe
wUAL0ViagYpTfkk8ck4cqfoclvkvQyJT42ZJx3mfD5EQUZbxas4sr5q+mo5RfBjF
CLpvFzP58oZLe2CeNPdoDpX2Quanmw==
=Uj6T
-----END PGP SIGNATURE-----

--riwJw+X1Dgcp1K63--

