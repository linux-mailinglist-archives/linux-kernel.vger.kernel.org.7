Return-Path: <linux-kernel+bounces-771132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AC3B2833B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136E75C2EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E522308F2D;
	Fri, 15 Aug 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyxV2RAB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFFD308F1F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272925; cv=none; b=QWcPkdvY0moQsflwusJx3EBEa24amB5ne0zGP54Rbdhto4VS6RF35s73U0r6cVClBQDn7td+NUHg/nZiH5kCJ+NQp1+VesaFentmZJZQ7vSy4YmcS2K/pRJ65uKZ88nOHf/+ptr0RMMrmvWUlhXuc2bZGsO0GMq9xI08t5yQtqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272925; c=relaxed/simple;
	bh=W1xnZTsdTQGF1SvJSgpleG18XvKB7/YohJwt3/DLakU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyGvTeSmSkLynSmA3r/wqaOUKhfK9RCezoLsfTqn57iI4Li7sN/KIjQ7dk4D3vl7tT8gECvH9Rl/3/TqQl+5KAlQ0kIagiGfmsoSdihdatIl3VsaF9yRx7MkQBzSgkaHENPBV+91fmHTHoUIhyxXxaGlJySkmxWyluaO1l4ppos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyxV2RAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737D6C4CEEB;
	Fri, 15 Aug 2025 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755272925;
	bh=W1xnZTsdTQGF1SvJSgpleG18XvKB7/YohJwt3/DLakU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyxV2RABpiAMRi+jRu0QCaobO1B9JuFokJ9s4UOKJVX5IFX+15PbBmA0ZJbYgOyt0
	 /e3P5XbiTxlenFxZq4e701AG1Lg9Fsa/xP7re6ngydrb5mgqSH3nigWKeZ0tHquF0Y
	 gHRCkR8L0h+g3dbYy73vX7kAXR/v3OtubaR3vgi+NSeCGMxiI718omBe2VOsXM+UCw
	 gEuonts36gTEnKAjoNTHr7MpZQh/cn/PgJ/12sdCPKb9YiP3D/Gi7k2FJEZO7f/g5U
	 Gfp7sQ/MBaN3rLcwTJ9rYU9MxI9WDOdHsvdG1sz0bkv2qNafIere48b0wMKQAVfE6I
	 yLb4enwD3un8g==
Date: Fri, 15 Aug 2025 16:48:39 +0100
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
Message-ID: <dfdf2af0-7154-415e-96f4-3e4fefbe96dc@sirena.org.uk>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
 <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
 <20250815130125.GD11549@redhat.com>
 <20250815130851.GE11549@redhat.com>
 <f1a8da89-7522-429e-a4ba-4794222f1541@sirena.org.uk>
 <20250815154311.GG11549@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F79/VnOKrnE7IlBl"
Content-Disposition: inline
In-Reply-To: <20250815154311.GG11549@redhat.com>
X-Cookie: Tell me what to think!!!


--F79/VnOKrnE7IlBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 15, 2025 at 05:43:11PM +0200, Oleg Nesterov wrote:
> On 08/15, Mark Brown wrote:

> > Sure, but OTOH at least for arm64 there's no cost to leaving the feature
> > enabled unless you actually execute userspace code so if we never return
> > to userspace writing the code to disable isn't really buying us anything.

> The fact that a kernel thread can have the pointless ARCH_SHSTK_SHSTK is
> the only reason I know why x86_task_fpu(PF_USER_WORKER) has to work.

> I'd like to make this logic consistent with PF_KTHREAD, and in the longer
> term change the x86 FPU code so that the kernel threads can run without
> without "struct fpu" attached to task_struct.

OK, that's entirely x86 specific - there's no reason we'd want to do
that for arm64.

--F79/VnOKrnE7IlBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmifVtYACgkQJNaLcl1U
h9CpXQf/TFMXBdcEn9rMj7U9jz4af9K/kLd8hj/tSPP//UGU+ljgQqxYhWuvCCXs
e3YSi/zXsRNLeI1MVe2TwjVB7nPQBcm0Y/xztgwFTfdZOYaEedlYkOlkyhpgziNS
MZb5T8vZBfoLa8HJTSJ5QCgI0zFxS0bbOvbomDGeJ4mWjeXZuzKppjYk14fZpJUF
xcI0GogKgkII0/W0r7fMfV7IDQKbbHrg/4zOpNVadPM2A7tUYfkl810z93f4HKWb
ZAiA0ihCdrxV3TXstn31saz/1qmuW9QaUief81g2tp+i4G74Ewy7WeV7PMSju8X/
5fxnSJs+gV5LG3w1WDcCg/Bbo4+H1g==
=plvr
-----END PGP SIGNATURE-----

--F79/VnOKrnE7IlBl--

