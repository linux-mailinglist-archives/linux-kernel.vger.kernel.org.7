Return-Path: <linux-kernel+bounces-899527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 576EDC58147
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CA13A2571
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD8327FD40;
	Thu, 13 Nov 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm8aVoA7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E227F00A;
	Thu, 13 Nov 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045233; cv=none; b=COBVY4iOkzcdE3E8F+3H+0W+NzSA/HyOpeYQNwn5CUfGnidbXH2U+2T0FPItOWgXOzqhQwuk/lNk+7MI3hu0X32L5bizZk47W7EEz2R1vx71mwkx4XIJmoQGwA60Q+kOZTaDlH81dMMrXn6m6rTc/vHoYivzZlV9h35EdPRNS1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045233; c=relaxed/simple;
	bh=TCbkId1rthq/rBe3fuZKHCEYKZLoEFVLkV3ScozLW+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YpzhiRHY27aB+6Idkk4nnoowgzcRUqVy2+a1ap53n8GpfOvZF3fiFmgs+4jotEN9scGKAKl4AVJmnmHynRx+JdO4cfxF9xMzIdB7VyAVohHdX9Ze22ZM2QSLOWiqU4BkSeaew9PRuDLySx9Av6tOWb/RqkvHOtqpEhSm14F9tJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm8aVoA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3EBC4CEF8;
	Thu, 13 Nov 2025 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763045232;
	bh=TCbkId1rthq/rBe3fuZKHCEYKZLoEFVLkV3ScozLW+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Fm8aVoA7pxSX7/RLgq4DBx3II2EEz/eVo8/vsaJRykNL2VHG97A5qFG9fiqzU9Hq3
	 OCKduCgQp0YgRhWrYYr00jczK5puFJ59yeo5CkQ22PobGN4JebFOVbj2ROmfZRjViP
	 xoqbWbidvYED6kqvuQkvp46Rx/ZkDSZ/o3ByjMqVpfjD13JXjAuMtq5SJwphwnVBKB
	 iLDq4hCEEoA2c2AmBAkVa9DloK/JHAHSOeX3gkVlDEBAhL2ER+nGvX6Hd4FHNgGm9X
	 VpPZKnrsl+rYTbUuarZWwGL/uE2/zh3jIJeg4/khQ4JvF+Ftuz3PcDLKUVmcGnrnJi
	 9e7E7J5zIs9/Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  imx@lists.linux.dev
Subject: Re: [PATCH v4 5/5] mtd: spi-nor: micron-st: add comment for
 mt35xu02gcba
In-Reply-To: <20251112-nor-v4-5-e4637be82a0a@nxp.com> (Haibo Chen's message of
	"Wed, 12 Nov 2025 19:05:13 +0800")
References: <20251112-nor-v4-0-e4637be82a0a@nxp.com>
	<20251112-nor-v4-5-e4637be82a0a@nxp.com>
Date: Thu, 13 Nov 2025 15:47:09 +0100
Message-ID: <mafs08qga9ehe.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 12 2025, Haibo Chen wrote:

> The MT35XU02GCBA flash device does not support chip erase,
> according to its datasheet. It supports die erase, which
> means the current driver implementation will likely need
> to be converted to use die erase.
>
> Furthermore, similar to the MT35XU01GBBA, the
> SPI_NOR_IO_MODE_EN_VOLATILE flag probably needs to be enabled.
>
> Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index c89c06b1fc61a581fea2e18732be2501a15715f9..f94e9d2d17bf4aa7c36ba3aa37d34f767a9f93ac 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -204,6 +204,16 @@ static const struct flash_info micron_nor_parts[] = {
>  		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
>  		.fixups = &mt35xu01gbba_fixups,
>  	}, {
> +		/*
> +		 * The MT35XU02GCBA flash device does not support
> +		 * chip erase, according to its datasheet.
> +		 * It supports die erase, which means the current
> +		 * driver implementation will likely need to be
> +		 * converted to use die erase.
> +		 * Furthermore, similar to the MT35XU01GBBA, the
> +		 * SPI_NOR_IO_MODE_EN_VOLATILE flag probably needs
> +		 * to be enabled.
> +		 */

Maybe I am missing some context from previous patches, but why are we
adding this comment here instead of fixing the support for this flash?
What does "the driver will likely need to be converted to use die erase"
mean? If it doesn't support chip erase, then it _does_ need to be fixed
by using die erase.

Also, why does the flash "probably" need SPI_NOR_IO_MODE_EN_VOLATILE?
Are you guessing based on datasheet and do not have the hardware at
hand?

The changelog should also explain _why_ this comment is added here, and
not just repeat the text.

>  		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
>  		.name = "mt35xu02g",
>  		.sector_size = SZ_128K,

-- 
Regards,
Pratyush Yadav

