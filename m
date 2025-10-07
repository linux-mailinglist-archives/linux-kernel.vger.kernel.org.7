Return-Path: <linux-kernel+bounces-844282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A289BC172D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D2134F19D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ED72D6636;
	Tue,  7 Oct 2025 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXe+CRfu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A01DF982
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842912; cv=none; b=UDtSmWaxnkBMNtrrbScSJUvklS9scMUuCkCEeWNzIosRT8gxLvMTBf5iul+KlddxG5dPEcOIHRTiK+QqZnMX2XH0QjEsMtX5MHCMlb7MDmwjQF0+Yt1dX8dmpXrHwWV0uK+6BQH4w6Cc/TQHRUxqpVcbaz5OjCmaGnMlUQCbsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842912; c=relaxed/simple;
	bh=EqKw66Y+OkmjBtMmmweWlpeBccSxmjMZ3RwUW5S5fbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FPUzj/mbua0N6OYFzLf95vRtu2xjqO8gJ0J8+knynUVbqDVCIVgGvqmFI6/zut5ZW4hiYwy1h/whPPM2VSUCeaDBgC1N+aws9dLpQL9QafW6B26MpGGJ1U7KSUUm84NToLQSda6niGI2KemJyti44nKkISIzhWZz7hocm9G2tQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXe+CRfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C175BC4CEF1;
	Tue,  7 Oct 2025 13:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759842912;
	bh=EqKw66Y+OkmjBtMmmweWlpeBccSxmjMZ3RwUW5S5fbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nXe+CRfutLD+QDcbN8smikpxLCcGjxIp65qqxNzbOJ4agn93Ry+CFbBLjI/JOsTzl
	 ZFBgOroqW0LfnFeKMOQXsFSqcC4DWGfCLN3i12ZizuhWxnE+8Uy0KA/0l2I/YOmEUu
	 rT3N+VWoNPR+aVkNoV5lrOCEi6K/uu1LRx+RZKx1Eiw7snQvdVnmuXLg+fxguRJUX2
	 jnNHRT/BH2notgREqt7XteEuYBYMJlJ+mHQpgYxuyV6SD23lVPdgSBOvXcPfuLsf59
	 RkNyc/lpRGu13hAVgHxitDGN67mPhYpTjruFilzPnNiDmsvIgVDd3Do37dScBX1wo0
	 zZxRKucoSibfQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-mtd@lists.infradead.org,  Richard Weinberger <richard@nod.at>,
  linux-kernel@vger.kernel.org,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
In-Reply-To: <20251006223409.3475001-1-sean.anderson@linux.dev> (Sean
	Anderson's message of "Mon, 6 Oct 2025 18:34:09 -0400")
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
Date: Tue, 07 Oct 2025 15:15:09 +0200
Message-ID: <mafs0ecreontu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 06 2025, Sean Anderson wrote:

> The datasheet for n25q00a shows that the status register has the same
> layout as for n25q00, so use the same flags to enable locking support.
> These flags should have been added back in commit 150ccc181588 ("mtd:
> spi-nor: Enable locking for n25q128a11"), but they were removed by the
> maintainer...

This makes it sound like the maintainer did something wrong, which is
not true. Tudor had a good reason for removing them. Jungseung did not
have the flash at hand and Tudor didn't want to apply patches that
weren't tested. Both were in agreement for removing the n25q00a changes.

If you are going to mention that commit, then mention the full context,
and then also mention what has changed since that makes it possible to
add those changes back in. Having tested them on the real hardware for
example.

>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> Tested with a mt25qu01gbbb, which shares the same flash ID.

Ughh, is this another case of flash ID reuse? Do mt25qu and n25q00a
flashes behave exactly the same and only have two names? If not, then
how do you know if n25q00a will also work with these changes?

>
>  drivers/mtd/spi-nor/micron-st.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index 187239ccd549..17c7d6322508 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -486,6 +486,8 @@ static const struct flash_info st_nor_parts[] = {
>  		.id = SNOR_ID(0x20, 0xbb, 0x21),
>  		.name = "n25q00a",
>  		.size = SZ_128M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
> +			 SPI_NOR_BP3_SR_BIT6,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
>  		.mfr_flags = USE_FSR,
>  		.fixups = &n25q00_fixups,

-- 
Regards,
Pratyush Yadav

