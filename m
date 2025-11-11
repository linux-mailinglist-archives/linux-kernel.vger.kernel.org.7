Return-Path: <linux-kernel+bounces-895709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A45BC4EC0D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975EC3A3C76
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBAF35F8AA;
	Tue, 11 Nov 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK88oE4e"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6E35BDDB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873898; cv=none; b=IdHPMd+xquc1rcZhbCocBwNksSzU8rPp3TQyVkb+bFObAi4EVLBrb3vayInRGQE4GZClvF/y917QoWEHWHZPecG83HX5/LlsDb2l/UnYyrC6WM4TywKnKyzTEJnCT/mI7oKxEpgOr8DFHwjZ051YODIQcIYsyQ4bOZE+t0Tc1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873898; c=relaxed/simple;
	bh=cBvHiE3MTqLVsG6y+J/uHOAvi+GgMGuElM6WaC2JkxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tyk+idk5B+7wx2lsKORqgXttmQ7CmdI7xWB/+OD8PgiPizCUX4ACQsm/lEwMxzdBj6hRK+dcvMvmhgLRCS/vjTBmJyPueN84lYOhMPotQz35FY6+c4SbfunOjs5zBEGQqFpFUAgJH0pyRE0jeVls7qp5AJm5T2JxD9Vb+Y+nTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK88oE4e; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29844c68068so5436035ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762873896; x=1763478696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7eTYb2wlhJyNuQSOocKUpulhkuV3RsO5wtmlgEoTf8=;
        b=lK88oE4e9KtrSLYgwxqDlzjZODXegI6NHGChKNCfa90JZvP42NNDACmB+/B8Kl193C
         q2s92M23fvvTfrtao9V94GwwHE/b5iecgc6KxCj6VJhMhP6AQ9l1UycOJ8bpu1LUaZLi
         owOgyqsnSNlzIDeRmblI/ldTk1kgvt6v4HDLpLpamOoXZIu+J6QATBY4ORoj7B8LSli1
         sh6MbQDHNu+f20ANL3hWsaukkiDVUYjSDIyitp5S6q5dpuvD+uOkUaBot05k8zoHaTtJ
         L+dwoctgp3KVMxtguFgfU8cXfQ0VGe9jiSn0C1m2OlhQbf1fSIiAM9N8nBUHK4B9t0UE
         gsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873896; x=1763478696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7eTYb2wlhJyNuQSOocKUpulhkuV3RsO5wtmlgEoTf8=;
        b=oA1ITlCN1gOdGFWnXCOHC1S4oEYE6XQIWg6eEmvbuOG4L9/5VsNtRlsQ2qXBVWvkLt
         qHSMcn+JgrGSiKJYsJEBvT1YMl5yruP0BkKkl05e58zyTCboFTknM695wdeQR/dpnm4m
         mlyDhJ81s3maCLd3OzQW9Hlu+SHsgdbMH2qtE323eIguZogk5tmVDY3aPcyH5OcAq+CO
         0JpTlX8YN0LySNtIjSFuy2IifkVeaGdRaVAZ0kt7nuNXwgkG613/9myyiR1jHCvJ0mRh
         T2Tvar08m7DTHdYjR08qCmTH3vm03PEV289HXEdoHahE63ODqak5Ow0WPS8a5f4jxrjv
         hvcA==
X-Forwarded-Encrypted: i=1; AJvYcCXYmnmlta6jlPvGiIq7v5/RzSP9wW9OhD6u2XVf+Z89VH0VRNC8s99ia/IhPSNBUf2gjzQfGMmKSqmCMyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPunxHfwtkIjgnuobCJH9CGalPCJQ0qf/vrCo8M5BXnTfTJ9uF
	f16FRFyVyTHlHxIXVn80nTx4Bpwe+7fTUaEuDu2xPzd/r2qdJro8MAIS
X-Gm-Gg: ASbGncv8pAnOpeSuqeYDMaWrMyoNL1PxbTBMk8szRzjzC9yd74Id+fddmQsSIJ2crov
	RAnludYycq6FOL887qI+CkkNnAuc68sMZnJ+nQezXSxEkNyE4CRYGXJsP47+micL3ev4KYgsHp5
	RdZpkXMeT72X34JR6NEFeWWwGGiC3lihXhpA7k2O3XW+apRNYe1q/6hggX/TOw8rzD9PTbeJ2H2
	ZNk7uH5ztvDao+M4krRFuOiiAFY1097kOQt1yu992nhhT4/IBbW8TktPowsSOMACkBVQ/cWrtGV
	KE8oU47l+IifUwivgsjXBH70oYlJgqwjWGdZ23ABIV//iB42R5JH70du1XLnF4/nL7huCjf1DsZ
	DGvmxeMFDYuJHipbnLC7m+t7mtTcUT2Ji4himJr7FrK35ND+8JYLJcFyJyYEc8ZtJkvY8L5Kh0z
	Z4Pe1dz4+/OQ==
X-Google-Smtp-Source: AGHT+IEanSf8MNOoYPmR8r6QP42O+LoZWPLOQBKQDi9X75YOlY83hfm2jvOchw3UXfBmb7KUYvVt2A==
X-Received: by 2002:a17:902:f601:b0:295:915d:1eed with SMTP id d9443c01a7336-297e56d0e7dmr168612555ad.47.1762873895461;
        Tue, 11 Nov 2025 07:11:35 -0800 (PST)
Received: from localhost ([2804:30c:1661:8a00:578a:911c:ac25:24a6])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-ba901c3817csm15946063a12.30.2025.11.11.07.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:11:33 -0800 (PST)
Date: Tue, 11 Nov 2025 12:12:51 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/6] spi: axi-spi-engine: support
 SPI_MULTI_BUS_MODE_STRIPE
Message-ID: <aRNSc1GEz0UNx17i@debian-BULLSEYE-live-builder-AMD64>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
 <20251107-spi-add-multi-bus-support-v2-4-8a92693314d9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-spi-add-multi-bus-support-v2-4-8a92693314d9@baylibre.com>

Hi David,

The updates to spi-engine driver look good.
Only one comment about what happens if we have conflicting bus modes for the
offload case. Just to check I'm getting how this is working.

On 11/07, David Lechner wrote:
> Add support for SPI_MULTI_BUS_MODE_STRIPE to the AXI SPI engine driver.
> 
> The v2.0.0 version of the AXI SPI Engine IP core supports multiple
> buses. This can be used with SPI_MULTI_BUS_MODE_STRIPE to support
> reading from simultaneous sampling ADCs that have a separate SDO line
> for each analog channel. This allows reading all channels at the same
> time to increase throughput.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> v2 changes:
> * Fixed off-by-one in SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK GENMASK
> ---
>  drivers/spi/spi-axi-spi-engine.c | 128 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 124 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index e06f412190fd243161a0b3df992f26157531f6a1..c9d146e978b89abb8273900722ae2cfafdd6325f 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -23,6 +23,9 @@
>  #include <linux/spi/spi.h>
>  #include <trace/events/spi.h>
>  
> +#define SPI_ENGINE_REG_DATA_WIDTH		0x0C
> +#define   SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK	GENMASK(23, 16)
> +#define   SPI_ENGINE_REG_DATA_WIDTH_MASK		GENMASK(15, 0)
>  #define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
>  #define SPI_ENGINE_REG_RESET			0x40
>  
> @@ -75,6 +78,8 @@
>  #define SPI_ENGINE_CMD_REG_CLK_DIV		0x0
>  #define SPI_ENGINE_CMD_REG_CONFIG		0x1
>  #define SPI_ENGINE_CMD_REG_XFER_BITS		0x2
> +#define SPI_ENGINE_CMD_REG_SDI_MASK		0x3
> +#define SPI_ENGINE_CMD_REG_SDO_MASK		0x4
>  
>  #define SPI_ENGINE_MISC_SYNC			0x0
>  #define SPI_ENGINE_MISC_SLEEP			0x1
> @@ -105,6 +110,10 @@
>  #define SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE	16
>  #define SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE	16
>  
> +/* Extending SPI_MULTI_BUS_MODE values for optimizing messages. */
> +#define SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN	-1
> +#define SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING	-2
> +
>  struct spi_engine_program {
>  	unsigned int length;
>  	uint16_t instructions[] __counted_by(length);
> @@ -142,6 +151,9 @@ struct spi_engine_offload {
>  	unsigned long flags;
>  	unsigned int offload_num;
>  	unsigned int spi_mode_config;
> +	unsigned int multi_bus_mode;
> +	u8 primary_bus_mask;
> +	u8 all_bus_mask;
>  	u8 bits_per_word;
>  };
>  
> @@ -165,6 +177,22 @@ struct spi_engine {
>  	bool offload_requires_sync;
>  };
>  
> +static u8 spi_engine_primary_bus_flag(struct spi_device *spi)
> +{
> +	return BIT(spi->data_bus[0]);
> +}
> +
> +static u8 spi_engine_all_bus_flags(struct spi_device *spi)
> +{
> +	u8 flags = 0;
> +	int i;
> +
> +	for (i = 0; i < spi->num_data_bus; i++)
> +		flags |= BIT(spi->data_bus[i]);
> +
> +	return flags;
> +}
> +
>  static void spi_engine_program_add_cmd(struct spi_engine_program *p,
>  	bool dry, uint16_t cmd)
>  {
> @@ -193,7 +221,7 @@ static unsigned int spi_engine_get_config(struct spi_device *spi)
>  }
>  
>  static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
> -	struct spi_transfer *xfer)
> +				struct spi_transfer *xfer, u32 num_lanes)
>  {
>  	unsigned int len;
>  
> @@ -204,6 +232,9 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
>  	else
>  		len = xfer->len / 4;
>  
> +	if (xfer->multi_bus_mode == SPI_MULTI_BUS_MODE_STRIPE)
> +		len /= num_lanes;
> +
>  	while (len) {
>  		unsigned int n = min(len, 256U);
>  		unsigned int flags = 0;
> @@ -269,6 +300,7 @@ static int spi_engine_precompile_message(struct spi_message *msg)
>  {
>  	unsigned int clk_div, max_hz = msg->spi->controller->max_speed_hz;
>  	struct spi_transfer *xfer;
> +	int multi_bus_mode = SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN;
>  	u8 min_bits_per_word = U8_MAX;
>  	u8 max_bits_per_word = 0;
>  
> @@ -284,6 +316,24 @@ static int spi_engine_precompile_message(struct spi_message *msg)
>  			min_bits_per_word = min(min_bits_per_word, xfer->bits_per_word);
>  			max_bits_per_word = max(max_bits_per_word, xfer->bits_per_word);
>  		}
> +
> +		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
> +		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
> +			switch (xfer->multi_bus_mode) {
> +			case SPI_MULTI_BUS_MODE_SINGLE:
> +			case SPI_MULTI_BUS_MODE_STRIPE:
> +				break;
> +			default:
> +				/* Other modes, like mirror not supported */
> +				return -EINVAL;
> +			}
> +
> +			/* If all xfers have the same multi-bus mode, we can optimize. */
> +			if (multi_bus_mode == SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN)
> +				multi_bus_mode = xfer->multi_bus_mode;
> +			else if (multi_bus_mode != xfer->multi_bus_mode)
> +				multi_bus_mode = SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING;

Here we check all xfers have the same multi-bus mode and keep the mode that has
been set. Otherwise, we set this conflicting mode and the intent is to generate
SDI and SDO mask commands on demand on spi_engine_precompile_message(). OTOH,
if all xfers have the same multi-bus mode, we can add just one pair of SDI/SDO
mask commands in spi_engine_trigger_enable() and one pair latter in
spi_engine_trigger_disable(). I guess this is the optimization mentioned in the
comment.

> +		}
>  	}
>  
>  	/*
> @@ -297,6 +347,10 @@ static int spi_engine_precompile_message(struct spi_message *msg)
>  			priv->bits_per_word = min_bits_per_word;
>  		else
>  			priv->bits_per_word = 0;
> +
> +		priv->multi_bus_mode = multi_bus_mode;
> +		priv->primary_bus_mask = spi_engine_primary_bus_flag(msg->spi);
> +		priv->all_bus_mask = spi_engine_all_bus_flags(msg->spi);
>  	}
>  
>  	return 0;
> @@ -310,6 +364,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
>  	struct spi_engine_offload *priv;
>  	struct spi_transfer *xfer;
>  	int clk_div, new_clk_div, inst_ns;
> +	int prev_multi_bus_mode = SPI_MULTI_BUS_MODE_SINGLE;
>  	bool keep_cs = false;
>  	u8 bits_per_word = 0;
>  
> @@ -334,6 +389,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
>  		 * in the same way.
>  		 */
>  		bits_per_word = priv->bits_per_word;
> +		prev_multi_bus_mode = priv->multi_bus_mode;
>  	} else {
>  		spi_engine_program_add_cmd(p, dry,
>  			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
> @@ -344,6 +400,24 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
>  	spi_engine_gen_cs(p, dry, spi, !xfer->cs_off);
>  
>  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
> +		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
> +			if (xfer->multi_bus_mode != prev_multi_bus_mode) {
> +				u8 bus_flags = spi_engine_primary_bus_flag(spi);
> +
> +				if (xfer->multi_bus_mode == SPI_MULTI_BUS_MODE_STRIPE)
> +					bus_flags = spi_engine_all_bus_flags(spi);
> +
> +				spi_engine_program_add_cmd(p, dry,
> +					SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
> +							     bus_flags));
> +				spi_engine_program_add_cmd(p, dry,
> +					SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
> +							     bus_flags));
> +			}
> +			prev_multi_bus_mode = xfer->multi_bus_mode;
> +		}
> +
>  		new_clk_div = host->max_speed_hz / xfer->effective_speed_hz;
>  		if (new_clk_div != clk_div) {
>  			clk_div = new_clk_div;
> @@ -360,7 +434,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
>  					bits_per_word));
>  		}
>  
> -		spi_engine_gen_xfer(p, dry, xfer);
> +		spi_engine_gen_xfer(p, dry, xfer, spi->num_data_bus);
>  		spi_engine_gen_sleep(p, dry, spi_delay_to_ns(&xfer->delay, xfer),
>  				     inst_ns, xfer->effective_speed_hz);
>  
> @@ -394,6 +468,17 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
>  	if (clk_div != 1)
>  		spi_engine_program_add_cmd(p, dry,
>  			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CLK_DIV, 0));
> +
> +	/* Restore single bus mode unless offload disable will restore it later. */
> +	if (prev_multi_bus_mode == SPI_MULTI_BUS_MODE_STRIPE &&
> +	    (!msg->offload || priv->multi_bus_mode != SPI_MULTI_BUS_MODE_STRIPE)) {
> +		u8 bus_flags = spi_engine_primary_bus_flag(spi);
> +
> +		spi_engine_program_add_cmd(p, dry,
> +			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK, bus_flags));
> +		spi_engine_program_add_cmd(p, dry,
> +			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK, bus_flags));
> +	}
>  }
>  
>  static void spi_engine_xfer_next(struct spi_message *msg,
> @@ -799,6 +884,17 @@ static int spi_engine_setup(struct spi_device *device)
>  	writel_relaxed(SPI_ENGINE_CMD_CS_INV(spi_engine->cs_inv),
>  		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
>  
> +	if (host->num_data_bus > 1) {
> +		u8 bus_flags = spi_engine_primary_bus_flag(device);
> +
> +		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
> +						    bus_flags),
> +			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
> +		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
> +						    bus_flags),
> +			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
> +	}
> +
>  	/*
>  	 * In addition to setting the flags, we have to do a CS assert command
>  	 * to make the new setting actually take effect.
> @@ -902,6 +998,15 @@ static int spi_engine_trigger_enable(struct spi_offload *offload)
>  						    priv->bits_per_word),
>  			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
>  
> +	if (priv->multi_bus_mode == SPI_MULTI_BUS_MODE_STRIPE) {
> +		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
> +						    priv->all_bus_mask),
> +			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
> +		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
> +						    priv->all_bus_mask),
> +			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
> +	}
> +
>  	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
>  		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
>  
> @@ -929,6 +1034,16 @@ static void spi_engine_trigger_disable(struct spi_offload *offload)
>  	reg &= ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
>  	writel_relaxed(reg, spi_engine->base +
>  			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
> +
> +	/* Restore single-bus mode. */
> +	if (priv->multi_bus_mode == SPI_MULTI_BUS_MODE_STRIPE) {
> +		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
> +						    priv->primary_bus_mask),
> +			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
> +		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
> +						    priv->primary_bus_mask),
> +			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
> +	}
>  }
>  
>  static struct dma_chan
> @@ -973,7 +1088,7 @@ static int spi_engine_probe(struct platform_device *pdev)
>  {
>  	struct spi_engine *spi_engine;
>  	struct spi_controller *host;
> -	unsigned int version;
> +	unsigned int version, data_width_reg_val;
>  	int irq, ret;
>  
>  	irq = platform_get_irq(pdev, 0);
> @@ -1042,7 +1157,7 @@ static int spi_engine_probe(struct platform_device *pdev)
>  		return PTR_ERR(spi_engine->base);
>  
>  	version = readl(spi_engine->base + ADI_AXI_REG_VERSION);
> -	if (ADI_AXI_PCORE_VER_MAJOR(version) != 1) {
> +	if (ADI_AXI_PCORE_VER_MAJOR(version) > 2) {
>  		dev_err(&pdev->dev, "Unsupported peripheral version %u.%u.%u\n",
>  			ADI_AXI_PCORE_VER_MAJOR(version),
>  			ADI_AXI_PCORE_VER_MINOR(version),
> @@ -1050,6 +1165,8 @@ static int spi_engine_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	data_width_reg_val = readl(spi_engine->base + SPI_ENGINE_REG_DATA_WIDTH);
> +
>  	if (adi_axi_pcore_ver_gteq(version, 1, 1)) {
>  		unsigned int sizes = readl(spi_engine->base +
>  				SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH);
> @@ -1097,6 +1214,9 @@ static int spi_engine_probe(struct platform_device *pdev)
>  	}
>  	if (adi_axi_pcore_ver_gteq(version, 1, 3))
>  		host->mode_bits |= SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;
> +	if (adi_axi_pcore_ver_gteq(version, 2, 0))
> +		host->num_data_bus = FIELD_GET(SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK,
> +					       data_width_reg_val);
>  
>  	if (host->max_speed_hz == 0)
>  		return dev_err_probe(&pdev->dev, -EINVAL, "spi_clk rate is 0");
> 
> -- 
> 2.43.0
> 
> 

