Return-Path: <linux-kernel+bounces-844184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D742BC1404
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E867D4E4385
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8E82DAFA3;
	Tue,  7 Oct 2025 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yck95UQq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E82849C;
	Tue,  7 Oct 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837485; cv=none; b=aox4IYTUCyE1Jg9XTSTkXGzljgUJUDpXs+iXRaDqyF8G4BPMqWa7UgpAneBL0aQkYEfFJlwnyglt6vviopxajA0XmQStIRpyjFNckpSKNLomM0/MhC/tvYRm9qTHqBaJ2WycX0OiScg/KSc+9Fb3BCQ0kzI/0Y9CiUN6iZdMhEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837485; c=relaxed/simple;
	bh=vrV7schJKTObuKqHwmDMCSlf4yVFgUpLZABi3XhzC4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq+CGdhg8fSpsNRmRuVJrEOmtAn3CwTjWCRR2CedQjgfYhiS9yJzKDV77cKKr0evlBgG5Galdzzu6JAmM/dQ+W800vgS94MnpUbjMFLtrZq404n3ZS6Wi5y8ZKNTB4/qNKBsNQWdcTVDlXYZNIi3AhcZBphH/7igdnZjQdZY9/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yck95UQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FF2C4CEF1;
	Tue,  7 Oct 2025 11:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759837484;
	bh=vrV7schJKTObuKqHwmDMCSlf4yVFgUpLZABi3XhzC4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yck95UQqs7lxdHT3gw1CoYdiLuW6fJi41XAzOe2lwUIObKt9xMKeWUZi0khyaJnZU
	 zCCAINbTz9Sz+WEVzXYWgGUic4g4A6LsIqvvRH/UgqGFb1NJSZomMats6V6bnoK++W
	 +TAiCYmyEPWaHQ7UZJ1wFUXkVeh4tfXb+oIp7gcuyrxGstpa0UCk3D1roQyMGvK17K
	 n80goA+vqMQYa82mOar8Spmy6NTT5ygXwNBdpvQjJNowSLJM+JhJNI4oyzU/dgbI7r
	 K8/hCtn3TZniPwk5nxn6gh8e/NKCJvs7XhHy7TeFzMQAIyy0MNc/uHDBkxvMf8QRKN
	 kLkjv6xCrHDgQ==
Date: Tue, 7 Oct 2025 12:44:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Brian Sune <briansune@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <5a71fdac-f6cf-4557-9bc8-d416a033263e@sirena.org.uk>
References: <20251003091304.3686-1-briansune@gmail.com>
 <20251007113305.1337-1-briansune@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6vJkhbjWIjk+RIgQ"
Content-Disposition: inline
In-Reply-To: <20251007113305.1337-1-briansune@gmail.com>
X-Cookie: Teachers have class.


--6vJkhbjWIjk+RIgQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2025 at 07:33:05PM +0800, Brian Sune wrote:
> The original WM8978 codec driver did not set the BCLK (bit clock)
> divider, which can cause audio clocks to be incorrect or unstable
> depending on the sample rate and word length.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--6vJkhbjWIjk+RIgQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjk/ScACgkQJNaLcl1U
h9AsBgf/QdqtY86MkHJ98zVSejElWnnIuIDSvbJV+zNp4tg/vkY+2cE1Emym0KOm
LLV8ZxCFQnPuDrstK5PUBnwRoUtkoK6DqN7gKqg9V7xIFcvRYcjA9b7AReky48Lj
gP6+nfSrfUnovRTXw/P3rIMPyW9OGTeU8TR0ohaeAEQfJTF/BEOi6jHvWq7IbzZt
6HxzoFdpCwAAaPdopAJz4RGhr+3HYrl9CMztiPz91QgiWUf48Vzvee12BNqCtBpR
MkhcAeWgne2bEUrPhDEOjk+Ur6edJX9KhzJdKWIjdn4OLU2n167vBCVyqExMFnNI
qYnTQ/qiD+lz4U+DN5qX98WO2aV3jQ==
=G7b3
-----END PGP SIGNATURE-----

--6vJkhbjWIjk+RIgQ--

