Return-Path: <linux-kernel+bounces-826562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC6B8ECED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728D97AB20C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D498922F757;
	Mon, 22 Sep 2025 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="GkIVyXN3"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2258B1805E;
	Mon, 22 Sep 2025 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758508836; cv=none; b=gUWjGFPC/gsQW1S7Nn6Gbo576BMRMeCulnX74KeEECieJilPIwRc1QEBxIaBwoBtNjGqLZHYu8VlhQesBQZSm/3k3uXUE8ZT6tIoDROYJNmVfRRIPLDy6S2LpBOUr0KAgC01jeWJBUF5ASefAdRHvcwXOYeRIRK0sW936XfYNZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758508836; c=relaxed/simple;
	bh=oRwhNNcJ4UuJqK2uvE74sNP2bcTWym5M48wax+q4hFg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dLwkce+LDwspp5CLnMByDfJNfq/hN5xzWiCS56gB1aWC957GTvQ9gnaQuIrDMYkd5CUwGGcxiL79gq1BW8J9z1GISiPGplx1U5Z9S7TjU+v8RCJibpBme04v9zxpEedWUuWEd31kNEw8XW6ZuDPWFqR1XKSDshtwwk/B3m2k0Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=GkIVyXN3; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758508823;
	bh=sbMTFBkaNempQ9R89eRUdq5Tnnibi7nvv+qJWfTi2ys=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=GkIVyXN3hTKABUPSJs3w6GjAn44kF9bvQknDdWFdldCOnDKkSNfoDnN1uylHmcHD5
	 tvO4lPlxKNJLrZjgvqLxgjxv7nOdwyVqOJO9ta8+M/EQ73dCxpXBptqdTm0wUmSmfX
	 SGuVqkXmK0Yorlsugi587z7v95484+DTFgx25q3w8lJDwFRWtWBfoGexDbaMBtE334
	 MVZ34FU0g9+PdEvqSfuRanyzXxW5cGO/j2EkZ93AOID2fiec5rMi+WhzQBXL+gYEeO
	 A1F5BfbwyH6j3zQRAvBV6KsRe63IrO8nyCIWSjl/LHXSqt/ggdrUQ+lXWfLuDmlUwH
	 dGitfe2CtzYLA==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E29CF64755;
	Mon, 22 Sep 2025 10:40:20 +0800 (AWST)
Message-ID: <dd660ce0388afb61e476f164335600f3fc2b1fb6.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/2] Add device tree for ASRock Rack ALTRAD8 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rebecca Cran <rebecca@bsdio.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 22 Sep 2025 12:10:19 +0930
In-Reply-To: <20250917180428.810751-1-rebecca@bsdio.com>
References: <20250917180428.810751-1-rebecca@bsdio.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rebecca,

On Wed, 2025-09-17 at 12:04 -0600, Rebecca Cran wrote:
> The ASRock Rack ALTRAD8 BMC is an Aspeed AST2500-based BMC for the
> ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards with an Ampere Altra
> processor. The BMC runs OpenBMC.
>=20
> These patches add a device tree and binding for the BMC.
>=20
> **Changes between v1 and v2**
>=20
> - Reordered nodes to be in alphabetical order.
> - Removed status lines.
> - Fixed naming.
>=20
> There are still several warnings from
> make CHECK_DTBS=3Dy ARCH=3Darm W=3D1 aspeed/aspeed-bmc-asrock-altrad8.dtb

Thanks for checking!

> I believe the only one which is reporting an issue in my dts file (as opp=
osed
> to included files) is the first, and that's because the code partition co=
ntains
> the TF-A and UEFI areas. I couldn't see a way to suppress it.
>=20
> aspeed-bmc-asrock-altrad8.dts:578.16-581.6: Warning (unique_unit_address_=
if_enabled): /ahb/spi@1e630000/flash@0/partitions/code@400000: duplicate un=
it-address (also used in node /ahb/spi@1e630000/flash@0/partitions/tfa@4000=
00)

It seems odd that the partitions intersect. Are the offsets correct? If
they are, can you add comments to the DTS discussing what's going on
there?

> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/memory-controller@1e6e0000: faile=
d to match any schema with compatible: ['aspeed,ast2500-sdram-edac']

*snip*

> aspeed-bmc-asrock-altrad8.dtb: gpio@1c (nxp,pca9557): '#address-cells', '=
#size-cells', 'gpio@0', 'gpio@1', 'gpio@2', 'gpio@3', 'gpio@4', 'gpio@5', '=
gpio@6', 'gpio@7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0=
-9]+)?)$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#

This one needs fixing.

Cheers,

Andrew

