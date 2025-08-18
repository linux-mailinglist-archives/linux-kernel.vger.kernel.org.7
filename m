Return-Path: <linux-kernel+bounces-774170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBE8B2AF66
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A0B580C37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562223469FF;
	Mon, 18 Aug 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUrapL9r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53D732C309
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538029; cv=none; b=c5420B0Nzmu9/YNpz+tPdHcZK27SdHoSNaA8Tdqzil88qiob4I2F6jDvLiUxGncx6s893JV0Dhk+RYcNPW6cdVGdXG6IqiUAHf+GefQqRd2ulgIBLDTU9gBCyjxAlirKP0CD2i/3TgpcMSl1sq/j0AVvMd0TeE8Z4HpN8PpTTJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538029; c=relaxed/simple;
	bh=6ru6SnJxy2vWv3nYop8/A/iknBfQTAtLHXAmsB0U57c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK9gJgBDiLNwFSfA9EBVwK0ZzpT1zMkLUh5DuXvU4zFCRpB1hRIvcPgkHMojAH5ZePnGfrbjtHKi3wbjqM5hRGayPvv2Ye3j8g+i7CenjNn/LjIOciJQCM7nyhxfbZ0JPgLEKfSXn5Pai3FNy0/M/2Rcflnm17UrBZlIheMWEGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUrapL9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26846C4CEF1;
	Mon, 18 Aug 2025 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755538029;
	bh=6ru6SnJxy2vWv3nYop8/A/iknBfQTAtLHXAmsB0U57c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUrapL9r0J0NbV8uqJJlVZy6lHUh5XZaW0NXj67sVZWkKJJmNhai/wnlkW2EU+lwu
	 bYSZCBdFD36VDkkjqhtCoSMy6EjkjDjP2lrsVPL8thRPAir4uZ8BKiAZA2XDPMp0CN
	 ZCHlHR0XmaUBH5kjdw0tLkC0XBJ12cgq4vif/xZClSqkwv61/idrFRZhRJcJuXR+sW
	 Kylv9xJdraVPxCWJuPIDsoYcvNocliSo3mBj3DAc8XScYXtTiYeyZOnAALMALnNXv0
	 tQzUFmHd6hG177XBOlX9AQubiQ09PBxn70VJ4EVKgaf7+fsM1ZEKwo5TaJ0glHRCbp
	 Kp2JvvIRYp3sA==
Date: Mon, 18 Aug 2025 18:27:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
Message-ID: <2b1a11ea-7b1a-4d96-bf72-0e55227f7d21@sirena.org.uk>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
 <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
 <78b04d05b94b605f287b9a594cd2aa9f1cda10df.camel@intel.com>
 <6abf383f-2756-4de6-a951-6121f51263e2@sirena.org.uk>
 <aJ-Gc0X0J2GzgmnX@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ykowkHRetX2//xbQ"
Content-Disposition: inline
In-Reply-To: <aJ-Gc0X0J2GzgmnX@debug.ba.rivosinc.com>
X-Cookie: No guts, no glory.


--ykowkHRetX2//xbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 15, 2025 at 12:11:47PM -0700, Deepak Gupta wrote:
> On Fri, Aug 15, 2025 at 12:44:14PM +0100, Mark Brown wrote:

> > confirmation would be good but hopefully it's fine.  I've been holding
> > back on sending a rebased version out since Deepak was going to help me
> > get set up to test it on RISC-V.  Though I see now that the RISC-V code
> > has vanished from -next (I guess due to fallout from the issues with the
> > merge to Linus, it looks like there's almost nothing in the branch
> > currently), not sure what the plan is there?

> > Perhaps I should just send it out, but given the difficulty getting
> > anyone to pay attention I was trying to avoid issues with missing
> > updates for newly added RISC-V shadow stacks.

> Yes I was trying to get that sorted as well. Because now I'll have to
> rebase my changes to 6.17. So I wanted to make sure that it applies
> cleanly. I suggest that you send it out because risc-v was left out
> anyways. I'll apply your patch series on my risc-v shadow stack changes
> (on top of 6.17) and will report back. It might be easier that way.

> How does that sound?

Sounds good.

My main concern is that I don't want to end up needlessly holding off
either series due to dependencies/cross tree issues - I remain
(endlessly!) hopeful that the everyone's happy with the clone3() work at
this point and it could get merged, but if RISC-V support is going in
then it should support the new interface too.  Hopefully we can do
something like apply this on a branch and then merge that into the
RISC-V tree?

--ykowkHRetX2//xbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmijYmUACgkQJNaLcl1U
h9BiqAf/Qi42Pwj85zk44jEL0UWCuislFIhiLmVUMs8EguOk24skBPdgNWlsUCfd
U6GWum2e6C98xaPApMvBOWnLO/W+TxjCN2uREo5ULr+mCQ96Xl3ZkmbbsBLJLU+V
dWLRQpG0KNBZWtQvNXpLntgdPI5KcDKLcoq2bMP746VZpV7AMLb6XVdfaSQxctvO
OCg9+mlmTVz6oLOLcnmUPUm27YMo/EszCUWyscG79UD6UTEJgpJupyngtgFI4Clr
N1ReV/pWjNCnFlzLeztBd4AYcFBizwcs7bGcPR9mNNPxdkAWx4vJlZ16/2mtZ8Gt
ZgCTuLCsQ4GyqNE1D30Oc9f21Dh9yQ==
=F4xk
-----END PGP SIGNATURE-----

--ykowkHRetX2//xbQ--

