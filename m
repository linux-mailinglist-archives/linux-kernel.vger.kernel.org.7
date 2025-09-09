Return-Path: <linux-kernel+bounces-808614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94883B5024E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEDA1793FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1DD3451D3;
	Tue,  9 Sep 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSjRAU1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8B33A01A;
	Tue,  9 Sep 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434652; cv=none; b=LzShaQoP3cAGRdUKK4PVT/6TVmttXU7eLhehpBsP0KHMbhbCN9jho6IBJs+i33eF5GcuPtncbX2lrqZwrDSPd2IA4nZfygFntCdge33gNhGEK1r6oaxNGmTulRRZifimHBy0vXLFlknidecgAYAOmto+mFJyEi5BQ2OrFJ9YY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434652; c=relaxed/simple;
	bh=9iRPIdUoPjoatPi4Xe6uZdHFuIhT7MvEN+QkDCA9UGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4JQS8m83C3/kB82VB2QRqmAJjuKU0qfTB1vB/3nktxp5wF6MJwbkVETeyIOnUs7Zu1Ieweleo3DZhvx3e5XanBOS/+QQ1+AZuBJKholOv4KBFP4Oh7nRcP+hQPkbhUzFB+R9jeOwo2wXbvoPx3Mokz/PRkNk9NH7J0GYItIpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSjRAU1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C275FC4CEF4;
	Tue,  9 Sep 2025 16:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757434651;
	bh=9iRPIdUoPjoatPi4Xe6uZdHFuIhT7MvEN+QkDCA9UGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSjRAU1HhQNKNoCbdZLgltua2W1qQ6ILn7w26GT2mT1NAgdlaA6v6wqIBlVpOtgqf
	 caWc+rGFZcQBGeHfyM3544yG9j0RjqP+wgMYkCkJ6sWL92W8b2/czZ1PYOPlCp6Mdr
	 73/iutkicp+rgHf/Az6FIGgnqFbVdiXlb4a7O5Nh2I7v7Ghsa0eCYFZXcGl1Pj+I00
	 k5UcRFyH2rzQMvo06JwUUe2QlupXoYVaDfCNfznF+u5uChXIHC6MrEtXL1U1AldouO
	 zOkuyG4s4WVuTMqSP7fOBZEcGAZwuXNFqMobGbb+x7UWbLxOSsxZ9zQifRyMGt7+ky
	 kgh0Lf+iWGICA==
Date: Tue, 9 Sep 2025 17:17:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
Message-ID: <d59eae86-9b8b-4d4d-9a1c-b76ff0f42704@sirena.org.uk>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local>
 <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
 <aMBJ805QjQcPdRol@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7kkJeFDQaAa0cDiu"
Content-Disposition: inline
In-Reply-To: <aMBJ805QjQcPdRol@tardis-2.local>
X-Cookie: Ma Bell is a mean mother!


--7kkJeFDQaAa0cDiu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2025 at 08:38:27AM -0700, Boqun Feng wrote:

> Well, then the question is why we want to compiler regulator.rs if
> CONFIG_REGULATOR=n? Shouldn't we do:

> #[cfg(CONFIG_REGULATOR)]
> pub mod regulator

> in rust/kernel/lib.rs?

If we do that then every single user needs to also add ifdefs for the
regulator API which is not exactly wonderful usability.

--7kkJeFDQaAa0cDiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjAUxUACgkQJNaLcl1U
h9Bzdwf9G+zeu/edlgsTuq4C3Il+IAuAy4IcESiP1ZYfFsxqpa4JgDjksxt9Gf9J
yo0D1+N16NVYTsiLA6YBDozxP2mLyGuclrHYYhmp9irnwzgBj88wj9sHjjcRXJaS
qOpK03YvdEZCLL+UsLdahfAa0tauzDD+3JmgU2LWg+pXM20TNZTiYZPCHLSIWr1v
fSs+4zIP1ob76sM3D/guPki8pZa63qR1UMtHrOT/iL+oRI7lUST6W+4GoSPs/ogy
89cT/DbdwpbhCD0AZ5PASb6Uh9lcGkY1Fy+eAsv5qRSkICtewpz8JU8QluO6FYmY
mfTWTw1XHWDT/haruIgO61sc91L5iA==
=CU+q
-----END PGP SIGNATURE-----

--7kkJeFDQaAa0cDiu--

