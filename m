Return-Path: <linux-kernel+bounces-867003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518E3C01509
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00091A06FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61262314B9D;
	Thu, 23 Oct 2025 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx0IKunl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26928E00
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225456; cv=none; b=o9yD7r0SzvjBXoAGHCboq0JPwDAm0HCZJ8ColeEdcfhHjoZvlJGt27l/WsrRFz4/IowCF2eDyp2CIHPwhh82/SWa1TLZqqoQTdKtPl5DjJZ1EwpyMrzNecwj79TV8VgD/MywAvaF6ZPG+23D0UvFScw8vohJbeeScFcvL6jkiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225456; c=relaxed/simple;
	bh=RKDweGLvqfNY3ugGztsTew2UH4CACr/j5VHxsIaDmQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCxHJ6ECjaggRCPLZ21cAWk4XcJnnTuddolU4kIE/AflCMbBebmXHLz5tBpM8CgaCV3NwQV5MF76rWOg8E7BuhLRLKXT7p5H2uPGLzBa90kcZeLJDFwwiChi7v8aekNiPevMtekpw5iRzvqaEBF0E0aXkD6WPmKO3/OEgVfz0Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx0IKunl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4638FC4CEFB;
	Thu, 23 Oct 2025 13:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761225456;
	bh=RKDweGLvqfNY3ugGztsTew2UH4CACr/j5VHxsIaDmQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jx0IKunlacJajPWzQZxTq2v4kXmFBc8gah7CVEsj+OZR9mNwMFz2whXsB3558z8Yy
	 ZzI3yxzmTXFVRaOIXvcSasYFApp3DpDoJlEYkM//ocf9vJFZF38j/x1S2OiRoXECLa
	 nMU6rRoI8aAkHkAXNcrvMdKL3qPyki9C7fK6MXXCYDPlsLCpxaCSehg2TQVKeknInn
	 /wIOYTqZ1h+Pp+Ta2Pnli12o5zXKSbUrCWE+39vhxXZVPBXdienudKVsSz0jwhEdBr
	 FB+CVS+w8Cfd2Nm5BBOmmGpF8izHFN/D3rIE4Gm83xOW/4NnspKtox8QRKK6IShUxl
	 33s2Ajr6pGDqA==
Date: Thu, 23 Oct 2025 14:17:32 +0100
From: Lee Jones <lee@kernel.org>
To: Eric =?iso-8859-1?Q?Gon=E7alves?= <ghatto404@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: max77705: support revision 0x2
Message-ID: <20251023131732.GN475031@google.com>
References: <20251014043255.176499-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014043255.176499-1-ghatto404@gmail.com>

On Tue, 14 Oct 2025, Eric Gonçalves wrote:

> Revision 0x2 has been tested on the r0q (Galaxy S22) board.
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---
>  drivers/mfd/max77705.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
> index e1a9bfd65856..5201a4c9c3f5 100644
> --- a/drivers/mfd/max77705.c
> +++ b/drivers/mfd/max77705.c
> @@ -105,8 +105,8 @@ static int max77705_i2c_probe(struct i2c_client *i2c)
>  		return -ENODEV;
>  
>  	pmic_rev = pmic_rev_value & MAX77705_REVISION_MASK;
> -	if (pmic_rev != MAX77705_PASS3)
> -		return dev_err_probe(dev, -ENODEV, "Rev.0x%x is not tested\n", pmic_rev);
> +	if (pmic_rev == MAX77705_PASS1)
> +		return dev_err_probe(dev, -ENODEV, "Rev.0x1 is not tested\n");

What happens when PASS4 is released but not tested?

What about changing only the first line to:

  if (pmic_rev < MAX77705_PASS2 || pmic_rev > MAX77705_PASS3)

>  	/* Active Discharge Enable */
>  	regmap_update_bits(max77705->regmap, MAX77705_PMIC_REG_MAINCTRL1, 1, 1);
> -- 
> 2.51.0
> 

-- 
Lee Jones [李琼斯]

