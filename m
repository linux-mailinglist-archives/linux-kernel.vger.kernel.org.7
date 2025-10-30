Return-Path: <linux-kernel+bounces-878887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFE1C21A92
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033193A5EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0801629617D;
	Thu, 30 Oct 2025 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzUWPoR8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562D225761
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847544; cv=none; b=cQls/0Qj1Td9xpqa6NEAIbkouRM6A+YZoo8MgiwS1cGftujWtzE0MmfeUqPQkN2MRCeIsJ6Q/60NB0gPCPasCbeH3BXyX28p+hfjJD6xIi/7ZEcdA2xLaCmYp/gWazuhHeRKaBtFYy2SyEEnkSbHW1fMoNBn+JTksNF4513qeQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847544; c=relaxed/simple;
	bh=QXQd/V/Vlbw0idVzBVo7q09TXOAULlsIy2rv//pAqu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMooIcifLj+T+nNy52Rh21LxlLQtxZS4TSUkitnEiv79UzodRmzpRJZovLCU19LShY6Tgv6kSG9E/kHHSgNO4HQGj9tOZ3GmOW6rS7WC2DxqEe8XDSDbMhPUTopkUvBwHczwbaBtElvmh1fEXdBHEjud/EvyUm6bZ67trdvG08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzUWPoR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AB2C4CEF1;
	Thu, 30 Oct 2025 18:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761847544;
	bh=QXQd/V/Vlbw0idVzBVo7q09TXOAULlsIy2rv//pAqu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzUWPoR8TtRwYmmgmFqSRVqVdiHdm+FBha7lhR7Z0EHN7xXw0mSRaOdr2oqzDhutb
	 GTJ9SdWrl4WbCk7pI/s8o0iWos/c9GAuErkc1/QnJ7AKMia3f8YMxcY29I2LUJsypT
	 agQg2TWkW9XILI9TZll9iExvzs/kM80sGrV/yeI2yy0RdG4R6n+vQkhIq0pnULBLuf
	 jzY3hmYluw64l+7bHNDITZj5UFKARpjjmaWwK96cOmfGCEimBO7zQWQQft5qrCaCQN
	 1t2qzwJlpjkG3XuHQS7vT0Hf8plmEJb7+rUtQtHKgsQ2vnJe/WJnr1kLX0pUlsFBot
	 ogbMT5B+hHtPA==
Date: Thu, 30 Oct 2025 18:05:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 2/5] regcache: rbtree: Split ->populate() from ->init()
Message-ID: <16d462b1-3ea5-40a3-99a9-ef3c2f5015cb@sirena.org.uk>
References: <20251030173915.3886882-1-andriy.shevchenko@linux.intel.com>
 <20251030173915.3886882-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8vGnX+o7LSlrFAUU"
Content-Disposition: inline
In-Reply-To: <20251030173915.3886882-3-andriy.shevchenko@linux.intel.com>
X-Cookie: !07/11 PDP a ni deppart m'I  !pleH


--8vGnX+o7LSlrFAUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2025 at 06:37:02PM +0100, Andy Shevchenko wrote:

> +	.populate= regcache_rbtree_populate,

Missing space.

--8vGnX+o7LSlrFAUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkDqPMACgkQJNaLcl1U
h9BiUwf/cnexQLqFmKAoaZB5I9DNKbjt7XeX1wUejxMBUhy6Nw8lKsKcuoBesWhC
aXpVgMhNP7st3Rli8q7Yfmx5pjJ8zBRt/sY0EpAXudFafVOCxQH1eDKU0M4gN4X+
5kp0Ut/9u6nrBiwCDrOiC9rbFaabWOoSg9vsf1pEbS2ESjTsT5AKfruTtj2DpE9s
iLNSB8ADocHzA5/Y9PZ7w0R44txME+beSOvDcVET/UEdJyySezmfm52eDRbuVBfE
ZoCvYoY28TsVhyNa1SdFOyIVlf5tOs494ds4jJB0qmKW9uTFqvYrTFz2k6ssDSVj
L3qCmzJM0ppXal8+vr+W2bXjK+N/5A==
=1rgy
-----END PGP SIGNATURE-----

--8vGnX+o7LSlrFAUU--

