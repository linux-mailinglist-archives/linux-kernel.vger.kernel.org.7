Return-Path: <linux-kernel+bounces-771250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB7B284AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68EC8B65D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7B7304BB4;
	Fri, 15 Aug 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd4q/7KQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC3304BA8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277696; cv=none; b=koj9qGoBh4j+CLKx6vA7kr4XsnYTi7FomC4jP4dQzpF+XZXfxXL9iRvzL7lULFzY7h6B2jCMkOHv+CcbUleORZuGzxLzEOcF8M4gEYZOuM/l846qw79AiPyoAOCMP0plETMy1HATYJakkDxte4zTD0YcEcA2kijJ7uohk7dSIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277696; c=relaxed/simple;
	bh=VjuGchGOGeouZBhWWbsfEKnerA6cB2X7SkmWdg3VPPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNX+HjZcuGeympXe+c76WPxHVBKeLGFeTvuPcsH0Mp90ct02mJNowED2mWgWafcvXCjF5gRjDWe7lK2PsqU3a6NYHQPnhczpW0JNbuV804b4gH3AUxWpycFlSIb1gffqmC/l3BhUmBec2r5uwatfvrHVRpsypzpCZ6QHyHpF9BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd4q/7KQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78087C4CEEB;
	Fri, 15 Aug 2025 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755277696;
	bh=VjuGchGOGeouZBhWWbsfEKnerA6cB2X7SkmWdg3VPPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xd4q/7KQjTj/Tzt/MpdC3nhKv3RUMrPlWeqVX4hw/a6QcJiAOSfSEuiigsw30KGZw
	 gnMbKRrsfQig20FQlXakwnjZK+ruTaHNX91P8/F06STVRPo8dczbu+3P2dJ2K3heBq
	 BBfZbdBj2hXHtP6CaxBEZg0DbpPtbcwJ1NLCmmEqKp9HVNKLvg3Lg58/KXQvUFxIE9
	 MFqVuaLFtu+4MlLWuEeJ3+0nT3IoG9n2ugKdvX7JsW/r8aYwJDAE8CuU+pAOwP5RkK
	 bsFXCkuGyVJru/VtV1xq5uXx0XO/tuP+SCubB0F6XZuigH9VTMzKQGDWU6x9Bb1b42
	 CW9WiYt/Kn2ig==
Date: Fri, 15 Aug 2025 18:08:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>
Subject: Re: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <c66150c2-a745-48b1-8d80-1984bfa265fc@sirena.org.uk>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
 <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
 <20250815130125.GD11549@redhat.com>
 <20250815130851.GE11549@redhat.com>
 <f1a8da89-7522-429e-a4ba-4794222f1541@sirena.org.uk>
 <20250815154311.GG11549@redhat.com>
 <dfdf2af0-7154-415e-96f4-3e4fefbe96dc@sirena.org.uk>
 <20250815160023.GH11549@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+b6RNlXlFYONC14K"
Content-Disposition: inline
In-Reply-To: <20250815160023.GH11549@redhat.com>
X-Cookie: Tell me what to think!!!


--+b6RNlXlFYONC14K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 15, 2025 at 06:00:23PM +0200, Oleg Nesterov wrote:
> On 08/15, Mark Brown wrote:

> > OK, that's entirely x86 specific - there's no reason we'd want to do
> > that for arm64.

> Since I know nothing about arm64. Any reason we do want to have the unnecessary
> ARCH_SHSTK_SHSTK/shstk on arm64?

If you mean allocating the userspace shadow stack for threads that never
go to userspace then no, it's not needed.

> And... do you agree that shstk_alloc_thread_stack() without update_fpu_shstk()
> in copy_thread() path doesn't look right? Even if nothing really bad can happen.

Honestly the update_fpu_ stuff is sufficently x86 specific that it
doesn't really register as something I'd expect to see in that path.

--+b6RNlXlFYONC14K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmifaXoACgkQJNaLcl1U
h9A51Qf/ahL0rQDYH04kFA3M+FUhUN18pwwAjtUhkHk40v3OoNY7g7Uf9CYfO1tq
lkgYve0cGo4xH6YvHoSpRMbjcWr9uwV5yr+XLEhMdWGfUI60LBmAjbWKCtSdtBwr
fjbAXH77k2HnBj03A8p76OIoELji+LGcznJLaSVgHgjMWpBbQWB2NHAVh7MJ2mKW
3gMpgiUtmeqdGM2+gSadU3RcuflR49xo3Qh6+eqA5wZjz2iJRJ1fHYmqw/oPe2JR
Dsm0jZEO46pWxJUHqmDcM3kkvQVNN0cVbMZv0bpnry/wOod9z1vLdCidhMzS/OK6
pgcnIvQwpC6nNWjGFAq7KVqcFhzRpw==
=OloB
-----END PGP SIGNATURE-----

--+b6RNlXlFYONC14K--

