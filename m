Return-Path: <linux-kernel+bounces-803317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D473B45D6F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2CF917DA4F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D532FB0A1;
	Fri,  5 Sep 2025 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2GsODhf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8102FB0AB;
	Fri,  5 Sep 2025 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088340; cv=none; b=K7xDEgoifWDyX+ClIxQrEW5pixdAWu7fT9+8qS+dfVp2odGVgAfj31YtuSKa8EOeozRuNQ1o86TQI3uWoeLz1PpTkBf2H/tvpP1gYbpElNWHiFXQUTthWshb7RjNapyWZWUeIcLzsDHVQ4GOk1ZjAVe361Hwqu0nbWeal6xYApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088340; c=relaxed/simple;
	bh=WY9uPoit+9vyKamvBO5CsdFz7fEWkgvMzYuJQ9aSltc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMGLnjNXj0ex9Xwj8F8ZZVaEImX/9w9DPhUQZE3KxelLnVdF0ds4HLuQaIZpbcF6Yl4BeeBScOgDMLkDkU9U1dE2syVzjO5PX47xxjKdAosqrVqXF+IjK1jRE8F4G2/n/uUKGmrj3stRK4gE8NXvECHZ7E7Vq0Mb3UY7IAsemvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2GsODhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277FDC4CEF1;
	Fri,  5 Sep 2025 16:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088340;
	bh=WY9uPoit+9vyKamvBO5CsdFz7fEWkgvMzYuJQ9aSltc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2GsODhf+HTEp+qy6qh0i4S69rxMO3HqI/euKgyg3v5X0gDuGduAuKy7i6e+YhRX6
	 ytDXaaj/3OBQf+oC3bdZukCyUgev8s/ljfodT0o6sufQ/aWaIMzRLrZ9JptJ0iZiLQ
	 PwA+8o2FVoZxpPG8i7mo5ClUwQ6JzU5SLhPQA6C/kbNovKzkJKJ4eHTkHbhdivv4iC
	 /EOtd+jvkwXxbLaU85UYrALlMyl0hRqVqQxAeYUk8YrVwBL2Lu8Dt6UqNnlsVaEpEc
	 VqARdNHQpxyOE64o9HVf0kBTT+ctPKxJibPBgwFl/SstDTGmg674KT7EAhuTt/7nLV
	 nleVaR8Vapsgw==
Date: Fri, 5 Sep 2025 17:05:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 2/2] ASoC: replace use of system_wq with system_percpu_wq
Message-ID: <863db036-c077-4b2e-a65e-af80ea3c2d24@sirena.org.uk>
References: <20250905091016.109428-1-marco.crivellari@suse.com>
 <20250905091016.109428-3-marco.crivellari@suse.com>
 <54446af3-9ca5-4932-a3fd-e44185751dda@sirena.org.uk>
 <CAAofZF4XEFXWQEqeKJ3aTjPRuu5RgOEYRLX4Aeq=RGh7gnLGTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TZJB7M0He8WfHZUz"
Content-Disposition: inline
In-Reply-To: <CAAofZF4XEFXWQEqeKJ3aTjPRuu5RgOEYRLX4Aeq=RGh7gnLGTQ@mail.gmail.com>
X-Cookie: He who laughs, lasts.


--TZJB7M0He8WfHZUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 05, 2025 at 06:00:04PM +0200, Marco Crivellari wrote:

> Hello Mark,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> The above change is just a 1:1 conversion.
> system_wq is a per-cpu wq, so we only converted the name with the new one.
> system_wq is still present in the code, for a few release cycles.

> If the users don't care to be per-cpu, system_dfl_wq (the new unbound
> wq) can be used instead.

> This is just the first step of the conversion.

If we're going to convert everything I'd rather we do a sensible
conversion now than have multiple rounds of conversions.  I strongly
suspect that most if not all of the current users don't know or care
that system_wq is percpu.

--TZJB7M0He8WfHZUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi7Ck4ACgkQJNaLcl1U
h9Aj9Af/YJc6AWVbE9l3dA0oqDFn+guuL1UcZAO7yijQCCsB8FUa5hL/FPXlDQ01
reepQOnC3IuACNQHDCsKEIlZvz0j1VMV1M8H5qg2yEpiCnQbzBaJtpiP6AKOQqa/
B9CH4lqjS7IHh9EohAwlFIaHnaG6EFxOtkeXngID0r1ofYaeL7kfe4wlUBxD6ZNR
qARiZyRgDmhjsCR3CqupKa0TKx36IB5LIWxCS3RcHq0yrOr4LNSbvY7Ta1guJA9v
D8p+hiMUFxWirhh+xKrVP4hQKnvANW7a76YCZFpk9GEVYNLP5VfFq6gQCG8RTgr5
Tp6lEdQjK6OhGfgdIHByM/+GblY3qQ==
=MF44
-----END PGP SIGNATURE-----

--TZJB7M0He8WfHZUz--

