Return-Path: <linux-kernel+bounces-771105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5EFB282EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051DF18981BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721352C3240;
	Fri, 15 Aug 2025 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9EOPn5r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD773226861
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271708; cv=none; b=A5wVrI6HgSeEEmbCvsyM+Z5oVOgThzahoNT/+8FPD0Sf4RmFfJYM6KObH/fBShfyJXXAgXIJW9hln5mlTY3rvvcnZYkwUKDrxs443xRHALfV+oGp0h7bBsX4f4uF0Bqdbd8NQBmx8tN30dIDywYIjBGsJ11KsHjDIr86548ksaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271708; c=relaxed/simple;
	bh=XENG0qp3egjho5dkJN4ARF/gjbt0ZYMN3QuwFeO7LXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X81sByZ2OJF6ZvULOocm6ayUbatTSkOAxd+fjqsZ4rooTCpr/8M7mQO0iAK1wHyqt4ebG21GFQxgSkAUlI2nwF1+PSmPmVF7am2UDQAAmg0w8Lj+FOIyjOwKxTRAKCxiJxrXY1scrbx0XGZ41SQ8QooslTZqHjXWd4tVwvgxq7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9EOPn5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E5AC4CEEB;
	Fri, 15 Aug 2025 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755271708;
	bh=XENG0qp3egjho5dkJN4ARF/gjbt0ZYMN3QuwFeO7LXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9EOPn5rcwZGoyT0jVqqR2QjGFlNNrt/7HDR7oR93KY+JMH6fVfwsy97xYeU3L+Hi
	 YD4pQaROPv3LELUJhu/nGJB8fiZZRQMneQM2yHK/HbfAsCwcpbG3v2YC/UesaDfsXW
	 NPzjHAo+K5O10nUBQdsyEVjNS8TfLIYHnE+0joCZanYzJnq0saPi/m+78qErMtXdOU
	 EL3mAx9r/NkkxlBkjZx9veLZgx3zw9/N1P/8rG9YawqaBMLVSMSOrT756WnIhx8qBS
	 lvH1i8ghTUuK2w+aeOrQkfBOuTE1W7optbkArYc7tQq2fHWeBNxQ08IA0fMsDN4Con
	 nIAhKONqIRirw==
Date: Fri, 15 Aug 2025 16:28:23 +0100
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
Message-ID: <f1a8da89-7522-429e-a4ba-4794222f1541@sirena.org.uk>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
 <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
 <20250815130125.GD11549@redhat.com>
 <20250815130851.GE11549@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VjDnJIQ60pJW10u1"
Content-Disposition: inline
In-Reply-To: <20250815130851.GE11549@redhat.com>
X-Cookie: Tell me what to think!!!


--VjDnJIQ60pJW10u1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 15, 2025 at 03:08:52PM +0200, Oleg Nesterov wrote:
> On 08/15, Oleg Nesterov wrote:
> > On 08/14, Mark Brown wrote:

> > > I agree that it's better to leave userspace shadow stacks enabled, given
> > > that the reason we're not allocating the shadow stack is that we don't
> > > expect to ever return to userspace then it should be fine to leave the
> > > feature turned on for userspace.  If we mess up and do somehow return to
> > > userspace

> > But a PF_USER_WORKER task can never return to userspace. It doesn't differ
> > from PF_KTHREAD in this respect.

> ... of course unless it does exec.

Sure, but OTOH at least for arm64 there's no cost to leaving the feature
enabled unless you actually execute userspace code so if we never return
to userspace writing the code to disable isn't really buying us anything.

--VjDnJIQ60pJW10u1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmifUhYACgkQJNaLcl1U
h9CpTgf/Zyppw3AgkLeNpC7N7/tHw6RMPZY+u2SxbSWkk7IaxRo2i9vtqvT67G+n
wZ+CmdoC7+u9pUXdNAVMZ1/wdVxm8/hqpfyXRC8elH1jGEgJU/qn9SC6Hrs6widD
6k4erZ6hSbPiHnT7yii5Hpwxf0KT/6BBiOjx95md6k2N0YqGmSr/BX898NObTVS6
Xn76Ze5wwf4G/r5vkThjOhTLCdSDJ6jvAe4+KISWwhyZzBfFguVvDi68Ec/DZHwl
ne++1uEJrT6wuWS8xSE5Z3DoBuD2K+fAjHY5U1T2e/OP5NDJVuzBrY80xJIcGp8n
Q3H4861VTP0AZGZ1FrintB9Euhv1aw==
=lieC
-----END PGP SIGNATURE-----

--VjDnJIQ60pJW10u1--

