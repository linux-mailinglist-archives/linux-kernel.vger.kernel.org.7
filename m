Return-Path: <linux-kernel+bounces-847102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3555BC9DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D891E1A625C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647B0224B12;
	Thu,  9 Oct 2025 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjPt1Ayx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917C15B971;
	Thu,  9 Oct 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024996; cv=none; b=ReRn9bafzJrw6p1gIqwa1BD7nlzJ6iJMiTaGYwHp9sgfb6BJqD1UjyreENd9z6OPDXU2qJi6VcrX33LNHd3NffVmM9zBhTvQg/PGiKiQ75HKGgUOr2i84ykQtxl28pWq4Zo2obX5FWxTmNCZlcIGakjYBspK4UEvnRJeYypkADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024996; c=relaxed/simple;
	bh=a6BFVVimoJuA29nhvAAAgickwQE80IxB2EecGi69jbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5pv3XK/LhBFsNRACGyL/viBPnFi2YA/mpPtU6On1f4/fIaRMu7fC1D5hJ7119PQeM1mhRJ4lRyd3jKUCR7QTUHyrT7cQqgKacA78ORvuLP3WOKsOBDErFW2IDiQgKAeHK0dCYaP9L4mdQM3lzPshuYBKyRHLYki24Waqr69qMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjPt1Ayx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50103C4CEE7;
	Thu,  9 Oct 2025 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760024996;
	bh=a6BFVVimoJuA29nhvAAAgickwQE80IxB2EecGi69jbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjPt1Ayx4NdYvKTYBoagPChAQ4lpmsX8xtOxafLhr3zS15UJaIqMOhgJEpKAA3QOk
	 EWE/pJGBVXbsWXCVUz+HGZirMrn1wibCaRe4FU7bxNWQduRT9wf+nfS8lSJCT1I55x
	 whCsVJPqNEJCT2xUrwxt6G7yFNY+nOZh3ELYOn0YwPB/+/3RbST1lV7s4q4ybHnL0g
	 EfY9W5Aif7p+Tc7lAbuT1UY/kEod7vlEEhmSbWaXj2scv3JRSawAq0EDZ2jdFoBRYk
	 p76Y9F1Xv8giY0z1gCl7FA6pTtCQwa0mqmnSrDcKHcAGQoxetBPD4hB54HzqXXaUjM
	 EXZaR97S0J99g==
Date: Thu, 9 Oct 2025 16:49:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Sune Brian <briansune@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <0167554b-c3b9-4cc6-9382-d378e5b1227f@sirena.org.uk>
References: <20251008205207.1781-1-briansune@gmail.com>
 <aOd9yUj9H4L4fbtc@opensource.cirrus.com>
 <CAN7C2SBd8tDXG8OkjRt0sDw1OmtrLgtuStEfr=f=JHZMRvjq9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ehGXLPJ7VRwH7+r2"
Content-Disposition: inline
In-Reply-To: <CAN7C2SBd8tDXG8OkjRt0sDw1OmtrLgtuStEfr=f=JHZMRvjq9w@mail.gmail.com>
X-Cookie: Today is what happened to yesterday.


--ehGXLPJ7VRwH7+r2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 09, 2025 at 11:02:57PM +0800, Sune Brian wrote:

> Any documentations are required?
> i.e. .rst file or similar?

No.

--ehGXLPJ7VRwH7+r2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjn2Z8ACgkQJNaLcl1U
h9D3JAf/QlYqzmsptTJXa9BmFt5m871ccEyAuEJK/92oh9t64gptJdjXDNoY+uHE
VxXmSGFJK7GLnpJLNsF/RizQdR4jZtzXptLkspMBc6JECtkGSyfrIvzBRd/Y+zjr
Ubv9u8KWnuP+SHDaPdExhx5/u5zl+wWd5KUQMFqU2XpJlA/eOEe18ZvzO10Mgm0S
3QR+OgUufWwV5PgYm1IHWQh9xYWk0yduieGn6LJTYHFZ/FTrZbMXlH4YgV43xXK2
feufOc3cBl7X5/HYfcPgteTgimnXhSFepiL3paBUAUbYTIao3HQ4eG9x7Te0HLtc
w5h3FOZilglje0RdJFtN6JRLnwifkw==
=z3nb
-----END PGP SIGNATURE-----

--ehGXLPJ7VRwH7+r2--

