Return-Path: <linux-kernel+bounces-821565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5C5B81A48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3F7163A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925F62F361D;
	Wed, 17 Sep 2025 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwLK2Obo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1234BA5B;
	Wed, 17 Sep 2025 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137519; cv=none; b=b8BpyTcBmLHihuyp1lIXEoAsLJTP2TjQRk9Uij0z67b4i9F+lXJLcree1xLbJMQEIoaF6tWNzjN/1x2buxJV188YweDhbkbG1C23oPnUsSoGMRMcrONPc/hcKWv9VDz0sXQC8la8a+oovAzPJBimp7jSXmoDxoVLrfoOQ8j4WGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137519; c=relaxed/simple;
	bh=WUFOFnUVv9N92t+5xEmPWp7XyvUW3ydifXMJo5NR5M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nv1ZnTTomF3vqPQ5A/EMxdG8a54+b/unZ9e9Q+XBMfPGgulOpL5JDR6iKUBZFuFugJNJWIxdnhUUlKLIJx/0eCKtYwYb0sTJwlLhRpA23a1KEQ7CFY0S3X918cQ8kMtQ4IiPhEGDznW8ryT9LLNCXWaRNupC7nd+GHpIE8DB/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwLK2Obo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A54C4CEE7;
	Wed, 17 Sep 2025 19:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758137518;
	bh=WUFOFnUVv9N92t+5xEmPWp7XyvUW3ydifXMJo5NR5M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwLK2OboNRlZBlnQjxi6UFTeVdz6cnoT9b9CqRlF5ByMoO+s3C0MgUeZDjrETyB/m
	 jBj1wsT88+9QPF2ZZcIqPV/f6IjbfyHH+dpbDPb7puFtPo2OfrvoGudGnAkZYHdF0C
	 8Zbzo0pUnam0ehLCXmxon/cAfJfnFmiT2pIcU2T04GAo//uwiEi8rTrv5+74dyGCRd
	 dMyPeTAlOzkID8Cq8iBj05dUd/IPK/fx2gEWKU9lx+ymiAzFn/j3dHX9aczr/bwPOR
	 9tlWknf4mahBqybmQanuxSbe+hpGTtAFCuVg7M6GBx85Z46itgYicrDLfpPYRhP44E
	 cs9LVbQs0hhyQ==
Date: Wed, 17 Sep 2025 20:31:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troymitchell988@gmail.com>,
	Alex Elder <elder@riscstar.com>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: spacemit: extend and validate all
 properties
Message-ID: <20250917-irritant-smitten-fa1e05dd713d@spud>
References: <20250917-01-k1-i2c-schema-v1-1-bd276b366d9c@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yHs0dDgU61VAAlXJ"
Content-Disposition: inline
In-Reply-To: <20250917-01-k1-i2c-schema-v1-1-bd276b366d9c@gentoo.org>


--yHs0dDgU61VAAlXJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--yHs0dDgU61VAAlXJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMsMqQAKCRB4tDGHoIJi
0pu8AP9ltcftudLjoNZ/qKl0lqLRaZWaisXFk99pUfyogbPICgEAr/LT3xU5a2mf
ICBPeS4zVVPH57BRN9hBd8yiGFeeWgY=
=tIiq
-----END PGP SIGNATURE-----

--yHs0dDgU61VAAlXJ--

