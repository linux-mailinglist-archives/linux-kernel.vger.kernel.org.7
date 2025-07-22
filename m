Return-Path: <linux-kernel+bounces-740490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1596B0D4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F41AA034E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F46A2D63FA;
	Tue, 22 Jul 2025 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpF7Ac+N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2C2D3EFF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173820; cv=none; b=Vxr5V1GJqYG77BhoaHIEhbOubXDby5xn67z9UgSrLdS8HCg+irvzX7xS45d6rQp7UuOzb6G7v9CCG8xCJ/BV2lBgRzjCslRZa0AcCgs5Q+RG/hbYv1XhZahYU0qCPJ/Et9nhFKbbVZldCjcfpesp3lFWLIGC81Em5xmb6B8/Sto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173820; c=relaxed/simple;
	bh=q4R786VWDMTYlJcgS8N5GDJSAYM0n7uM2RZhr8sh6bU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NhuJjcxFk55tF1zdd1P0nCRKJB97vIq8F8zma4eid2ckTVFX5+Gsd2csudExKBcMeHj3dw3IUYAU/0DrQwZH4CjlPX0pDRQyYSWpc8YSvXaxHxkw+q9NcZMIyK7ucewdJugz2ThKuJIm5Gi+WeylUmU/9pPnK0VLELPdv33WApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpF7Ac+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0E0C4CEEB;
	Tue, 22 Jul 2025 08:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753173820;
	bh=q4R786VWDMTYlJcgS8N5GDJSAYM0n7uM2RZhr8sh6bU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KpF7Ac+Nwiv6J883iTqJgCLDIPoUS1/atUgs1ArBBDjtfiaOoJ9w8BHxZkqSHiGmz
	 WULdkT/1XLV657JH68Cjunhz6iYWjNlt6OKpAtDyxmpfuy3bB5vObpJxH5n08yMWCI
	 Y78ljZbQ4hZ4/KmMF6shKxE8IUu+YiSCl/SGwrBce2uaqwsAUAyhL4kNswGCtxxUX/
	 rDveTzxGBLwGZ37SYVK96JYvVjSycuNLdZqCWa0yErilVciYnc5bTk19y5sl52uj4n
	 aD1isib+eUYzINs0qHCKLtxtgQv6IdQoDz5z0E3Szra1VYyXIDWLNpJMz+6f+sz0Kz
	 ncaATxNqBOQ0w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Jul 2025 10:43:36 +0200
From: Michael Walle <mwalle@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-mtd@lists.infradead.org, Miquel Raynal
 <miquel.raynal@bootlin.com>, Pratyush Yadav <pratyush@kernel.org>, Richard
 Weinberger <richard@nod.at>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: Add support for W77Q51NW
In-Reply-To: <20250721202257.83936-1-marek.vasut+renesas@mailbox.org>
References: <20250721202257.83936-1-marek.vasut+renesas@mailbox.org>
Message-ID: <9eabfe619554cbdd493086dcffef8f44@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Marek,

> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -343,6 +343,10 @@ static const struct flash_info winbond_nor_parts[] 
> = {
>  		.id = SNOR_ID(0xef, 0x80, 0x20),
>  		.name = "w25q512nwm",
>  		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
> +	}, {
> +		/* W77Q51NW */
> +		.id = SNOR_ID(0xef, 0x8a, 0x1a),
> +		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),

Did you also test the OTP read and write? I'd guess so, because 
otherwise
you wouldn't need that entry at all, right? Or is it because of the
winbond_nor_late_init() which will be called as a manufacturer fixup?
In that case we could do the same as in commit afe1ea1344bb ("mtd: 
spi-nor:
add support for Macronix Octal flash").

-michael

