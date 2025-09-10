Return-Path: <linux-kernel+bounces-810136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46556B5167E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15E116C542
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A47C28C5A3;
	Wed, 10 Sep 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NKoHYBcu"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633825CC74
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757505909; cv=none; b=Iv5GixkCCU0gRbGyIdRlbVsjwPFliwiGGLi3mJgpJ3A6n9HlyQ5/CbdbEyFOCw+i3c2yP09nGuEdUJylu5XFM9qdnbYmmSIXwr9R9aZ/pk9iLy+wzEQOK1uhLKIXFwj6TiUyD8x2aANMhW1rCFRo3oZHVT6ayh3j80/rCXgGH5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757505909; c=relaxed/simple;
	bh=K+7VjAiCqGRfN2/ptv/mHD4py3t1A/J5bmcblZnzG2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rsYMjWURI2sMWRCEKSvba/rRjmZH3qxzS0Qo/v1pi5vFdzXR11FbM6BsqRuyRpw8fYAwjhtEgyVGPpTeH/vUhUd0dx69BU4FOAhE009UEeizHOYxIhWWT7GyHq17nA2RxXIT28WypJ3+ZVrUT7O/I+xGzm42nJOTM1YPgi+DBbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NKoHYBcu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 90C0E1A0C09;
	Wed, 10 Sep 2025 12:04:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E796606D4;
	Wed, 10 Sep 2025 12:04:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89A77102F1D2E;
	Wed, 10 Sep 2025 14:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757505898; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Vr3VOmJC4zjZiu2C++UnVxjvsT2gKvQRcPB5UoP5VE4=;
	b=NKoHYBcuU/K81A8A13HgHCF31h7U5qObQ6OkcEbpyPVf5BZvbieoFv80xh1L2g8VyWBA8v
	KCRMssYqtL5J7/7IttbgPBsAmeJ31LcWfmSyj1YmovDAhg/41GVr1J+I/QlgSRXr1iEG/R
	AklLcdIEbBY30fCkrYuuoOxs4JYyB3hW/rnlzDAt8i16/Ym+vqEym3+sbO4nxlL7W8qEtc
	sG2XaKiYNKqs35tYYb2tZgHxHYz9JjiOAHKrwA2aR6quJtC0NyzHhvP3MB2hCgdUcmbjHj
	bHoaI7gB9eFUhvSLQccmQk6EfEIJlW1rX+7FDH9QsebpkKdd9IHMx2ddAwKkGA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jakub Czapiga <czapiga@google.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,  Konrad
 Adamczyk <konrada@google.com>,  Adeel Arshad <adeel.arshad@intel.com>,
  Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] mtd: spi-nor: core: Check read CR support
In-Reply-To: <20250910103355.629421-1-czapiga@google.com> (Jakub Czapiga's
	message of "Wed, 10 Sep 2025 10:33:55 +0000")
References: <20250910103355.629421-1-czapiga@google.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 10 Sep 2025 14:04:42 +0200
Message-ID: <87frcucy3p.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ac4b960101cc..79deee3a50d3 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2608,6 +2608,10 @@ static int spi_nor_setup(struct spi_nor *nor,
>  		}
>  	}
>=20=20
> +	/* Some SPI controllers might not support CR read opcode. */
> +	if (spi_nor_read_cr(nor, nor->bouncebuf) =3D=3D -EOPNOTSUPP)

There is a spi_nor_spimem_check_op() helper which might be better suited
for this purpose?

Thanks,
Miqu=C3=A8l

