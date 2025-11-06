Return-Path: <linux-kernel+bounces-888070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88990C39C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F773A70E6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD630B519;
	Thu,  6 Nov 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nqQAP4Pt"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32583309DCD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420248; cv=none; b=kC6SfN1lyqvZZjG1qcAXnK10RzUaw1+Xna6JkRYmy9iZZxdN9V1Djz49958qXZEiD9eJErEPr+Vo86aM7OIVZ2UcT0lS2YZ3oRLiR8a/bhZ1g8ApZq4n8vO6+xFS5buu/Lw4LgY0Edh6U2Zqzrn50Q3hB/WaXe7V1C9weWQRS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420248; c=relaxed/simple;
	bh=ufDqBin6YQUpAolWvf0F1j/GJfhAgBMKdGFsmrjtV+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JaZlLsnJFequqjipH196rx9pu1PSAaFEV4ISrke2iTUnWqZui8p3MM9eQoBB9PSXcT4F0axYBA2wtWLleCKmTK8b+UQJpbaIcK7DIUvavoOnazCZWfUWgKE6+UaheaM8IBeY0RKURD8hQn1BfJ3SKXuPuZWMBwNbO5CpKYHZGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nqQAP4Pt; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DEBC6C0FA83;
	Thu,  6 Nov 2025 09:10:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E229C6068C;
	Thu,  6 Nov 2025 09:10:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B6C9102F2506;
	Thu,  6 Nov 2025 10:10:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762420236; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QlKEcZeAc1190MKGLBijNhcT+YDIGjvAChGhzCE/GH8=;
	b=nqQAP4Pt23iUC2IyfmF8qi8PH3UAztMGXpZuWZfM9xhz88G3MTYdxQpuSzyk9Z3D+10Y7s
	R25UD7bGMsTQA9bHF9J86EmMAe0m8gy8AZTBuQC6kTwyjuxgn5Jzi5imq06kWKSbnmVKCf
	Tb0GkBHdD2NoPtVQJ7Mw7pv9+IDpD9/vdzT66nKsm2J8CUK2EtiU49KPf4b97pYihJMQUu
	QcbdoE7chXeMVq4JWxGP0HVWGlhgCyHhBa8YWf7e/+aogV+nnWe96cQ2EDnhyHWp0p1b5r
	Idnb0HwH/4x4/ZzjwSFh1I8MgEH7Y5W1hP6mDxA5HdhEpXm68AW//g4mv6CH9g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: richard@nod.at,  chengzhihao1@huawei.com,  vigneshr@ti.com,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  alvinzhou@mxic.com.tw,  leoyu@mxic.com.tw,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 1/1] mtd: ubi: skip programming unused bits in ubi headers
In-Reply-To: <20251106054940.2728641-2-linchengming884@gmail.com> (Cheng Ming
	Lin's message of "Thu, 6 Nov 2025 13:49:40 +0800")
References: <20251106054940.2728641-1-linchengming884@gmail.com>
	<20251106054940.2728641-2-linchengming884@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 06 Nov 2025 10:10:27 +0100
Message-ID: <87o6pf8r24.fsf@bootlin.com>
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

On 06/11/2025 at 13:49:40 +08, Cheng Ming Lin <linchengming884@gmail.com> w=
rote:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> This patch prevents unnecessary programming of bits in ec_hdr and
> vid_hdr that are not used or read during normal UBI operation. These
> unused bits are typcially already set to 1 in erased flash and do not
> need to be explicitly programmed to 0 if they are not used.
>
> Programming such unused areas offers no functional benefit and may
> result in unnecessary flash wear, reducing the overall lifetime of the
> device. By skipping these writes, we preserve the flash state as much as
> possible and minimize wear caused by redundant operations.
>
> This change ensures that only necessary fields are written when preparing
> UBI headers, improving flash efficiency without affecting functionality.
>
> Additionally, the Kioxia TC58NVG1S3HTA00 datasheet (page 63) also notes
> that continuous program/erase cycling with a high percentage of '0' bits
> in the data pattern can accelerate block endurance degradation.
> This further supports avoiding large 0x00 patterns.
>
> Link: https://europe.kioxia.com/content/dam/kioxia/newidr/productinfo/dat=
asheet/201910/DST_TC58NVG1S3HTA00-TDE_EN_31442.pdf
>
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>

Thanks for this very clear and detailed commit log, as well as for the
well written cover letter. I am personally fine with the overall idea of
clearing these unused bits to 1. Yet, I have one concern regarding the
implementation, please see below.

> ---
>  drivers/mtd/ubi/io.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
> index a4999bce4..c21242a14 100644
> --- a/drivers/mtd/ubi/io.c
> +++ b/drivers/mtd/ubi/io.c
> @@ -868,6 +868,8 @@ int ubi_io_write_ec_hdr(struct ubi_device *ubi, int p=
num,
>  		return -EROFS;
>  	}
>=20=20
> +	memset((char *)ec_hdr + UBI_EC_HDR_SIZE, 0xFF, ubi->ec_hdr_alsize - UBI=
_EC_HDR_SIZE);
> +
>  	err =3D ubi_io_write(ubi, ec_hdr, pnum, 0, ubi->ec_hdr_alsize);
>  	return err;
>  }
> @@ -1150,6 +1152,11 @@ int ubi_io_write_vid_hdr(struct ubi_device *ubi, i=
nt pnum,
>  		return -EROFS;
>  	}
>=20=20
> +	if (ubi->vid_hdr_shift)
> +		memset((char *)p, 0xFF, ubi->vid_hdr_alsize - UBI_VID_HDR_SIZE);
> +	else
> +		memset((char *)p + UBI_VID_HDR_SIZE, 0xFF, ubi->vid_hdr_alsize - UBI_V=
ID_HDR_SIZE);

Here I am reaching the limits of my UBI knowledge, so I would prefer
Richard to (in)validate what I am saying, but AFAIU, the VID header can
be literally anywhere in the page, not just at the start or end of a
subpage, so in the vid_hdr_shift I would expect some extra maths to
happen, no?

Here is an excerpt of the main comment at the top of the io.c file:

    * As it was noted above, the VID header may start at a non-aligned
    * offset. For example, in case of a 2KiB page NAND flash with a 512
    * bytes sub-page, the VID header may reside at offset 1984 which is
    * the last 64 bytes of the * last sub-page (EC header is always at
    * offset zero).

I am not sure this is super common today though.

Thanks,
Miqu=C3=A8l

