Return-Path: <linux-kernel+bounces-899504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B07B6C57F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F2304EC063
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C554298CB2;
	Thu, 13 Nov 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZHIBaLg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9798419CD1B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044070; cv=none; b=YNuxn/KajVjrYG7Her6RYuEdUG8SYdJtZUyar2qB24U01RjcbAqLHCCylesRb8gXmmrHpLTUKGErRUTPNEClK6p5/Vq6b3Sgz2GSxMxCBhT9eLXXFaLdh6tSogg2/JCQ+auV8NQYDsWg7rrJEMAKaAqLFTOsHSJUKkHHAPqZbXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044070; c=relaxed/simple;
	bh=H9Dctcon0GeDioo/wO4MxFv9ndN5YPkBAXdKxma/Z8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGqJDaWmy5rUiGqb6Tec8/RpJNMmxuONFsLVItUsAxBcxCdBCOevauqOzEqZzqTGCTGAcLVGEAuVbi4s4fXAkQNh+errlnAYG2wrgV3u09ORo5nKAk89m+ExfeWHninyKxS0nYE5adRGNVEpHOVsgbgB89OP411Okr3Sc4YcMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZHIBaLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0B6C4CEF8;
	Thu, 13 Nov 2025 14:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763044069;
	bh=H9Dctcon0GeDioo/wO4MxFv9ndN5YPkBAXdKxma/Z8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZHIBaLg96hWiQHDYP3rY6RzNcXK9bFOsExAgzUqbLgmNdwGNn5PhhjYnC2sm5x0v
	 MD5oBI5B1D1nKQWNI55S2AL4tw24avuE+hKCSNRGMnnp48XLjHRN2YaufO+/W0MgUj
	 YKqo0rpcMeFsPA46P2WTS80vpd037UNNO1Y3CnuxC9c4kKg+U+8wKeSHEhfYZgQIPz
	 Lb4ZtTMA8+Nk6bnAUPgf6qAE1xjY3ZuRsmRS/4gaJut2o6Hhu8ci6173bMIk+GgXWq
	 oPmwNs2apBwP9623tbMkhMP0NtaymtQPO8a4+smXa8yZB2I/mh7rPja9Xr62z3w2ab
	 VL/oNbeSEvb1Q==
Date: Thu, 13 Nov 2025 14:27:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: jassisinghbrar@gmail.com, conor.dooley@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mailbox: mchp-ipc-sbi: fix out-of-bounds access in
 mchp_ipc_get_cluster_aggr_irq()
Message-ID: <20251113-unsealed-tightness-71a6826c63a1@spud>
References: <20251113134922.2546283-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VqIVOqsEvqxGCXpM"
Content-Disposition: inline
In-Reply-To: <20251113134922.2546283-1-valentina.fernandezalanis@microchip.com>


--VqIVOqsEvqxGCXpM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 01:49:22PM +0000, Valentina Fernandez wrote:
> The cluster_cfg array is dynamically allocated to hold per-CPU
> configuration structures, with its size based on the number of online
> CPUs. Previously, this array was indexed using hartid, which may be
> non-contiguous or exceed the bounds of the array, leading to
> out-of-bounds access.
> Switch to using cpuid as the index, as it is guaranteed to be within
> the valid range provided by for_each_online_cpu().
>=20
> Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.c=
om>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--VqIVOqsEvqxGCXpM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRXq3gAKCRB4tDGHoIJi
0kO6AP9NINPqQrNrJKA0gAmtK0J3BvuKh0PAcMnjTgiLNL/deQEA02cBb8YBW3ue
WLQe0WjvGIs+LM6cHusjoclPfqHe/gQ=
=Qsyh
-----END PGP SIGNATURE-----

--VqIVOqsEvqxGCXpM--

