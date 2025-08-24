Return-Path: <linux-kernel+bounces-783689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C5CB33146
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F5C3AE01B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12B2187332;
	Sun, 24 Aug 2025 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FM4FZwWC"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DB393DC5
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756050395; cv=none; b=XvvAn13k7WmgsBgnZLZlUvdn2B9C2f8UakZu9Fl+zIfuhSQZ+cdSmqE3224cUDn1qEXV1NuJnrQoF+HztMWhQbE4pQHDsfJQaxVn5lYKD8dAK3fXToM2avtYpdOcVQfoSnzHiNiW12BZVum68O2wmMn3jR9ZQZXbSxQmVKTY9XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756050395; c=relaxed/simple;
	bh=e1/p1t7s4A+oiPs4SJnuICv4dnmGNpDfmgZga16zUCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BZgjzm7zOvZ8n3xnfRNfMp5w3RCrdo2X3uRmk7AfG9ToArYrYpVP1NCYieLEkPoaiPn1LYH/qMpmcpM2TT6fzJOqjlvRw79DV2k7flfsKzsEG7SDOt9U6wREx3kSivMzorrk8VTZ8Ni6L4wtBmN9mWqPD2jo7FTyWmuRZ3JztwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FM4FZwWC; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5357A4E40C1D;
	Sun, 24 Aug 2025 15:46:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1702C605F1;
	Sun, 24 Aug 2025 15:46:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 887CB1C22D3DD;
	Sun, 24 Aug 2025 17:46:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756050389; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=w+MfyVmxQJvp2V9muLXwNpG8LH7o2E766a2xaru6xZY=;
	b=FM4FZwWCIPKCigLET/chS3RubLIDbVL5zYyYeiw5wmuiMDMaplt86JyDbEAu8TewJPy7Sr
	gYKI7TKjy0WZCccQz3QjwrngwzxvauAGLNwGcsC14VR2g3jMAw1jFhUorNkSnPvV7remSQ
	0SEAG6zpCNifRUYXlfuA7CFH1A/uKfTeSM3xmRHlCPazOdD8IE7r68AZPfL+cxbevUbJEa
	R3k7fG9eanpcpXs2kxnrTSekaHzp4E+wcwE2Vp/OktQ6oDnOt1np69Og1gAcCwEPXaz7vt
	p7dxLhqi75SAWJs6AEd7nEJBVRfCJJ6NmKCmUmp/jsjCJjelb8IVv6jU2rBkew==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tianling Shen <cnsztl@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Tudor Ambarus <tudor.ambarus@linaro.org>,  Mark Brown
 <broonie@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: spinand: add support for FudanMicro FM25S01A
In-Reply-To: <20250810133852.52389-1-cnsztl@gmail.com> (Tianling Shen's
	message of "Sun, 10 Aug 2025 21:38:52 +0800")
References: <20250810133852.52389-1-cnsztl@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 24 Aug 2025 17:46:18 +0200
Message-ID: <87wm6sk9it.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Tianling,

On 10/08/2025 at 21:38:52 +08, Tianling Shen <cnsztl@gmail.com> wrote:

> Add support for FudanMicro FM25S01A SPI NAND.
> Datasheet: http://eng.fmsh.com/nvm/FM25S01A_ds_eng.pdf
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  drivers/mtd/nand/spi/Makefile |  2 +-
>  drivers/mtd/nand/spi/core.c   |  1 +
>  drivers/mtd/nand/spi/fmsh.c   | 74 +++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h   |  1 +
>  4 files changed, 77 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/fmsh.c
>
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 258da42451a4..e288742ea8f0 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -spinand-objs :=3D core.o otp.o
> +spinand-objs :=3D core.o fmsh.o otp.o

You're adding a manufacturer driver in the middle of the core files. For
now we kind of inforce an alphabetical order, so please move it below.

>  spinand-objs +=3D alliancememory.o ato.o esmt.o foresee.o gigadevice.o
>  macronix.o

                                                ^
Here

>  spinand-objs +=3D micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index b0898990b2a5..ea47028d021a 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1184,6 +1184,7 @@ static const struct spinand_manufacturer *spinand_m=
anufacturers[] =3D {
>  	&alliancememory_spinand_manufacturer,
>  	&ato_spinand_manufacturer,
>  	&esmt_c8_spinand_manufacturer,
> +	&fmsh_spinand_manufacturer,
>  	&foresee_spinand_manufacturer,
>  	&gigadevice_spinand_manufacturer,
>  	&macronix_spinand_manufacturer,
> diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
> new file mode 100644
> index 000000000000..8b2097bfc771
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/fmsh.c

Otherise the driver is simple enough, so v2 should make it :)

Thanks,
Miqu=C3=A8l

