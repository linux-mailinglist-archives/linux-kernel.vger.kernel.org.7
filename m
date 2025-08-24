Return-Path: <linux-kernel+bounces-783701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C378B3316C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115AE1B603F0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0BE2D9ECC;
	Sun, 24 Aug 2025 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CBgYKyU5"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE61F461A
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756052661; cv=none; b=G99FGvPgcknMYnVAFFMUfun4kPlT6mRGe5MZ/ZbtJjimg5JyiIEPeX02S+rXfzsNbLYch3GcMYsDuB92QspqQbOvnuANzUFS9DhI9zaD0xvIirIndbsqCHoyi91FbsRfiEVO6X0qJFF52AOY9nsWXUPzi/ZQ0m/Uepe/9qE7t60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756052661; c=relaxed/simple;
	bh=GFcPMW9aJ7yiofKfrxE0FJA4McnVC+S5TnkpA+IDCpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=izqu2uIeURlyblzDxnx4TbFqvI6r02xzyS4MRxVKS+/FdHnjMZA0OCOFm20juTlyMC8csZldJQT+vf1tBi8q+b7NKgeTNutWvpqb5syQ00EB87DeCXsy87epvY1x6FWwv9gURqClgsAv2oldH4QiER0o2H97xSPh8ms266CHaFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CBgYKyU5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 861454E40C0F;
	Sun, 24 Aug 2025 16:24:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D297605F1;
	Sun, 24 Aug 2025 16:24:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D30CE1C22C3C6;
	Sun, 24 Aug 2025 18:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756052653; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=otXLfQ4Ld1gJ6Ja2C1Do6+eyluqz7SEV1+z0JoqPOKE=;
	b=CBgYKyU5xO4Q7dyEnj4UeX+5RLiyVyeT1VBugpwBueExjDf+RLz2u6YJ9J+rMFkQfgfeYq
	/Dye1S9nPJUP6usEdV/ECJEm2mVH0MIlglCWLlphUpO3U1HCi53aBcQHfhff5gxh3br72X
	2zjhlU1zCh1FXvVXZ4ef4wr/sNasqmGDw3WCxIjJBKeq9Ak1FVLYLMPp0XM0KqXnOsqgZp
	I4Ft3aotmL3KDm3lHBA6Po9+6CzLeH9UeAgARo2cnsqVDD9gtloDAtEBQYWdiNTaUwoZGs
	DxoFDr+J33qZGojumRoDZzDU3ml3ceiwFHpc+sLRH+bigGg/ovvSCalZ6pkfyA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Lorenzo Bianconi <lorenzo@kernel.org>,  Ray Liu
 <ray.liu@airoha.com>,  Mark Brown <broonie@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Martin Kurbanov
 <mmkurbanov@salutedevices.com>,  Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-spi@vger.kernel.org
Subject: Re: [PATCH RESEND v2 3/4] mtd: spinand: repeat reading in regular
 mode if continuous reading fails
In-Reply-To: <20250814065423.3980305-4-mikhail.kshevetskiy@iopsys.eu> (Mikhail
	Kshevetskiy's message of "Thu, 14 Aug 2025 09:54:22 +0300")
References: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
	<20250814065423.3980305-4-mikhail.kshevetskiy@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 24 Aug 2025 18:24:00 +0200
Message-ID: <87plckit7j.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

> +		if (controller_is_buggy) {
> +			/*
> +			 * Some spi controllers may not support reading up to
> +			 * erase block size. They will read less data than
> +			 * expected. If this happen disable continuous mode
> +			 * and repeat reading in normal mode.
> +			 */
> +			spinand->cont_read_possible =3D false;

I am fine with the idea, but could we avoid this little dance and drop
the extra controller_is_buggy boolean, and just let
spinand_mtd_continuous_page_read() do the fixup and return -EAGAIN?

> +			ret =3D spinand_mtd_regular_page_read(mtd, from, ops,
> +							    &max_bitflips);
> +		}
> +	} else {
> +		ret =3D spinand_mtd_regular_page_read(mtd, from, ops,
> +						    &max_bitflips);
> +	}
>=20=20
>  	if (ops->stats) {
>  		ops->stats->uncorrectable_errors +=3D

Thanks,
Miqu=C3=A8l

