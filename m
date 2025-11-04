Return-Path: <linux-kernel+bounces-884416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C44C3024B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E859A4623B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9A729BDBF;
	Tue,  4 Nov 2025 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JqkqNBwR"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F437261B78
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246546; cv=none; b=H68a7+MQ9BmvUU+TLC60COBT6qjAf6nEyb7K6ldasqq4o+9m6BuCqJa7ejO/bXabTaB072dsixd+eQFmr9mAvQFiEe6oPCFq3hghzBNj9jAC6+HzWNraVgIstOyXbmIZtw86UJ9SwXpb+LZMDW03NlMAbZLL9XPJ3E3/40R41tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246546; c=relaxed/simple;
	bh=DOR2k952VQ268ktzwHKaR7wZRCTvVmU6hXgXAGL288A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e7i1y7+73cJ3jF/LazOMzU18r3Qg/gz21zuUHXdJizJDD8wXdyTWbNlO5Cxtf76V3+whQAgOFr3mnUHLhsnwT2RZl0lfuepsxFTaWbEFF3Hhwd/AW8WuTeBzCHrnRrVnJ7pCn3yn4gruUmvPxAIh5JzhyuWafbZ+VZurFeU4NYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JqkqNBwR; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F078AC0E605;
	Tue,  4 Nov 2025 08:55:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C5D55606EF;
	Tue,  4 Nov 2025 08:55:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A65510B500FA;
	Tue,  4 Nov 2025 09:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762246541; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mlAWkou6qZ3iOsHzXkX7xAGUG1QWZHnc2ewaAAkiHd4=;
	b=JqkqNBwRvXd/ssVGhp0S30K9fd4c6b+SIUnBcnbJ+229G0I00kLcS98UsyPT70CvczET+t
	fQ9I/rc8rCXAPvQ9A/6O82gimsSd4v0jJPO+UdBiYWQW16c/CWiwo8w9zSXZDdjenRRSaM
	yBHBmdcjVPHvWYEEicvsojfJeJo5z3q8czHQjJRV+kOjCNQmsqNLdftJ31Y+zDIM9F8Ae2
	Z1fhue6QSkHmpipjZC6gRNbm4zHC5kpSI74ZX2s5BDDGZLMMHGEcJ0z2gQTF809QdnmkPj
	7imYvsHSiu/thPGFQFS6fZX2dT4Ac5ewpOC5he4Ke1k4OLKy1l2z2sT768PFYQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: richard@nod.at,  vigneshr@ti.com,  vz@mleia.com,
  piotr.wojtaszczyk@timesys.com,  linux-mtd@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: lpc32xx_slc: fix GPIO descriptor leak
In-Reply-To: <20251104014042.1389-1-vulab@iscas.ac.cn> (Haotian Zhang's
	message of "Tue, 4 Nov 2025 09:40:42 +0800")
References: <20251028094747.1089-1-vulab@iscas.ac.cn>
	<20251104014042.1389-1-vulab@iscas.ac.cn>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 04 Nov 2025 09:55:37 +0100
Message-ID: <87v7jq9nxy.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

> diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lp=
c32xx_slc.c
> index b54d76547ffb..3ca30e7dce33 100644
> --- a/drivers/mtd/nand/raw/lpc32xx_slc.c
> +++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
> @@ -854,7 +854,7 @@ static int lpc32xx_nand_probe(struct platform_device =
*pdev)
>  	}
>=20=20
>  	/* Start with WP disabled, if available */
> -	host->wp_gpio =3D gpiod_get_optional(&pdev->dev, NULL, GPIOD_OUT_LOW);
> +	host->wp_gpio =3D devm_gpiod_get_optional(&pdev->dev, NULL,
>  	GPIOD_OUT_LOW);

Please send an update on top the previous patch which I already applied.

Thanks,
Miqu=C3=A8l

