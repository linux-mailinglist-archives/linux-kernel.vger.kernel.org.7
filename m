Return-Path: <linux-kernel+bounces-806174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2202B492E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D610D1898A8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFDC30C61A;
	Mon,  8 Sep 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVgwEnnE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8860A2F0C78;
	Mon,  8 Sep 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344757; cv=none; b=nHEklsGfH47bHYdJzFVnPPUUJ1PxL9m7IPuhUjpQ2ihgZ/SsePGhtunmKOnnbN/BAJo12OBkgeOve3XNqr4VWB4GcgBW44hQOB78Irkr+FAXwdH0Ov8zsG4FRQ8HhujsiUVE2Q7jT/DadQU7uJqAXCxcQ+00ML/Q9thLM4k3J6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344757; c=relaxed/simple;
	bh=XnKJGCTgRjqKugj8QJIGjvGazhJ+xKAV/Y1UG3YXywY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu7ogdhDwodOle3lBGV7aVLeoo3DVsip7CQyrQd7XkIrChVn3G3142XY5xrAFPN9sh/mpWmO08fIQUCrHbO1g4Jl+QGoyiQ34rG6KY5aIColMc97ECqG1vP2V80XRrLPQBnFdyuvS+CsgH/1PUcL98SqKMhR/6FkxXAHcEsWkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVgwEnnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BEAC4CEF1;
	Mon,  8 Sep 2025 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757344757;
	bh=XnKJGCTgRjqKugj8QJIGjvGazhJ+xKAV/Y1UG3YXywY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pVgwEnnE7IPnjQ5tXs7ouXkItXhYE0yCRf85WdWkhNSZczWsGZ1Ma1n0TEj7UAQNi
	 NgRGza9vX4fjXZikZYhTJeJpFhiPqWe1i6PFomobQa07WVcp8ayDmGxDig8SpMGyPB
	 5vfu3+VEz0nE/mPOsgBHK1h3kpOX8+M4kSqmxg9gA+TM01Wot64jUVISGVIMAjwn/p
	 AvRLU/LFC2KrSjYuuXHrjhv4SrtNAWJVK4pF0MRzHErLKVd225+PQ3RjRv5AoRm6Dp
	 UZ3aaF4nNRM/eQjWlyOh3uP92WMo3GNtqiPE1qbrz1gCj8lK2vXHtrOXfczXW8n6qO
	 CgHh/Ufa3SjxA==
Date: Mon, 8 Sep 2025 16:19:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 2/2] ASoC: replace use of system_wq with system_percpu_wq
Message-ID: <dd9661e8-1d9a-4681-b78a-1e73e7a49fe7@sirena.org.uk>
References: <20250905091016.109428-1-marco.crivellari@suse.com>
 <20250905091016.109428-3-marco.crivellari@suse.com>
 <54446af3-9ca5-4932-a3fd-e44185751dda@sirena.org.uk>
 <CAAofZF4XEFXWQEqeKJ3aTjPRuu5RgOEYRLX4Aeq=RGh7gnLGTQ@mail.gmail.com>
 <863db036-c077-4b2e-a65e-af80ea3c2d24@sirena.org.uk>
 <CAAofZF7kqQmPAHedq4F-7T5fYH45WbOF=fWwSRbMcc7ZcSNxbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OGFkel8C9FkdmWua"
Content-Disposition: inline
In-Reply-To: <CAAofZF7kqQmPAHedq4F-7T5fYH45WbOF=fWwSRbMcc7ZcSNxbg@mail.gmail.com>
X-Cookie: Air is water with holes in it.


--OGFkel8C9FkdmWua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2025 at 04:52:53PM +0200, Marco Crivellari wrote:
> On Fri, Sep 5, 2025 at 6:05=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:

> > If we're going to convert everything I'd rather we do a sensible
> > conversion now than have multiple rounds of conversions.  I strongly
> > suspect that most if not all of the current users don't know or care
> > that system_wq is percpu.

> Sure, we can do so. I will send the v2 hopefully with 1 patch only
> (meaning that every system_wq can be converted to system_dfl_wq).

Sounds good thanks!

--OGFkel8C9FkdmWua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi+8+8ACgkQJNaLcl1U
h9BXsQf/Z2idZxIsWlsYUDaS6c0vTMtKE4lmKYAj/vLctTArf7S2Hd11urTUdcQ7
9LIgi3rVmjIbxIUAZSWORnGBc4nYFkPFKKsgM1EZO/o0POVcmJ8LMh6/e8vrDQYU
gyKF/PbN2jdkcTVttBPQsec2OiGOL+3R3jdifhlumR9aOkUI97KCXfLl9UhAXyWV
CkOaNJw2HCsmg9xe1WdHmrPR8YwWY/nIycQ+s4Kwtv9YZoCdIK+D9JQ33Y3WfGDy
QUpe+Hrku+qqBUywAX58MSVE2kqTfR9X7JI7lubjmmr7aUjpdkt8f45rKEe/GtB7
uBXBYwpOIaEqk7fBOpm2UvxsAaVUqA==
=SyyA
-----END PGP SIGNATURE-----

--OGFkel8C9FkdmWua--

