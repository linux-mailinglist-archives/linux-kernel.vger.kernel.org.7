Return-Path: <linux-kernel+bounces-764619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F9B22535
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E39503540
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71D82EBB8E;
	Tue, 12 Aug 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ataNcfpo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C822B590;
	Tue, 12 Aug 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996651; cv=none; b=Pa7Jpq0WyVmej8SDy6NQvbSZmwSPrm9tSK0w0AzuCVNxkBfmuq7q3vQWEzy6r9Zl2D2liGaXSU3+MKQfSbR0ZGAwvBm6GSyju8kep1ljgWTAYRoGxBc8vx80LZYb4HZL3Y/ubuVC/Co4DzZQl2tZo/b/3aW3QJc0fxoa4r5bmYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996651; c=relaxed/simple;
	bh=B+PEgTbf6nrhb/pTGdfvLO5lzTBBQrybiZaSI3MT0Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5gLuSXEP5ljlgsZgSPeo6utrOh9nbssjgLf+5KvSVmTqlwwsk2cnITXRHFx4eMAAOSVRjitUz1Jz5UU9reX4hWMc2eFdOY5fXnfHZDI5+OshsLmBXuspEL3FQeTm4kGEOi9fxa3iptdFQz6Gl6zVwZwdDo6I2Ike7xaFaS/IH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ataNcfpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3316BC4CEF0;
	Tue, 12 Aug 2025 11:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996649;
	bh=B+PEgTbf6nrhb/pTGdfvLO5lzTBBQrybiZaSI3MT0Ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ataNcfpoXpirEm7xwJlmEpcq4x8xZ2BB+TgjMheJOrtKYvO1w/i211qXrlLbenNNF
	 fcWLhvUWILk0qLFvraxEw0clxYSqEkdYOz2dDwAjh1xbwgjB+aeGF3dyUGsrtUUOiq
	 dZDf2zJyBdDBrr8rpcjMnnDzx5cvnIARDvz6OKH857UMKOxWxbg4XoeGEuOJdacT1P
	 THhevSNdL+OXxaiQIlPslnERdx1fRpJwFX+qz8k+033GQbO4SUYqdLmMoC8OdyLXXl
	 dSBAtxkHGXH0ykufdf8qCsCFIbE9YPc6eK+Q6Qu73kQMpJKLVb6cvuFeQb3hnirmvi
	 baIJ2y2aCuqeA==
Date: Tue, 12 Aug 2025 12:04:05 +0100
From: Mark Brown <broonie@kernel.org>
To: jeff_chang@richtek.com
Cc: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/2] regulator: rt5133: Add RT5133 PMIC regulator
 Support
Message-ID: <cce96a11-6bd2-4a95-8012-74fc9bbc76cd@sirena.org.uk>
References: <20250812031541.2966667-1-jeff_chang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eVWQQKUyROMXhXEq"
Content-Disposition: inline
In-Reply-To: <20250812031541.2966667-1-jeff_chang@richtek.com>
X-Cookie: For internal use only.


--eVWQQKUyROMXhXEq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 11:14:56AM +0800, jeff_chang@richtek.com wrote:
> From: Jeff Chang <jeff_chang@richtek.com>
>=20
> RT5133 is a highly-integrated chip. It includes 8 LDOs and 3 GPOs that can
> be used to drive output high/low purpose. The dependency of the GPO block=
 is
> internally LDO1 Voltage.

You're missing patch 1 here with the DT bindings.

--eVWQQKUyROMXhXEq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmibH6QACgkQJNaLcl1U
h9Dopgf+JTqvi5jADxtTd+tqB0k4PtcNioCPW3RRBgZ1f4l+iubDJZGasBJ+/Tqo
LwTAV8jDRmHJ9j3owAqo3X4dud5bOWJegkNxO56SVXv1rRt+/f07HO+UiIJ/6Ovu
rUmPulogC3wmMUzc9fWTyknyJrfXlwzIo3cPE6d4nnIdTpV9Jdvu669m3nZmUzhi
SBg0bjuOqBgHsZANrtEhJXrvn67IjQbcxoxAssq3dwOhT7zSfZlloqAk6s57aO98
0HsplP1qKtUIWkeA39JkGkyJ8iRDt8IclE3ZmX/Xb48btRpRefR+005eDuPnE52g
9kGfbNv2tMlXo1MpWd80jdKWW6unSw==
=2GXV
-----END PGP SIGNATURE-----

--eVWQQKUyROMXhXEq--

