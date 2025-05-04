Return-Path: <linux-kernel+bounces-631378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9434CAA8755
	for <lists+linux-kernel@lfdr.de>; Sun,  4 May 2025 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D293A9863
	for <lists+linux-kernel@lfdr.de>; Sun,  4 May 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407791DB92E;
	Sun,  4 May 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9auhm/a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDAB6D17;
	Sun,  4 May 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746373223; cv=none; b=WIzkdQhPaaRPRrWjPqF9jUd43u1DEQL6iRzltd9rMLr7XxD/JLUFAssDCHkW431bZK1yrU3mrDvGTVuT6GwiDoLJNbwsyj6nIyxvtXzzWwIHMHZj5qcT7k4koZt9ZXdJtJ5wO/i3JdQYAAOowDNgv42wtxMux1yIOadoH/vHQVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746373223; c=relaxed/simple;
	bh=H/DmNOmqCWO0GtACrgiG85dQ3OLs0Q+7EoCQAS+gDRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GX28T6Cbp9ZiKtHtqs2mv3EFkXsb3plwN9iZb6KiwkSU26YCQ/lt6wvMzb+kHZch+nL5ILNcNpz91FBsoCqZl0hItVF7jY9iSFrUPgdsMFFYVXue8k+g8L8IRaTQEE4f2EVkCWrev42iPxUqluo2PxXDKZkG1d/MuET2DfOFy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9auhm/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF65C4CEE7;
	Sun,  4 May 2025 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746373223;
	bh=H/DmNOmqCWO0GtACrgiG85dQ3OLs0Q+7EoCQAS+gDRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L9auhm/anpX+Fe0ymPnU4NWkSLAGPfgNL0i4XXldD/HN+9HXCM7pAe/yPNXLqH1VY
	 2OuQcPoBxAMj9sDQraPJSGdVk6QmilaHqZc3koDR8UiGcQP8opluboMO8lZbzlNUjA
	 Ald0ayhXc6dr2fmieqjYYOe+fITbONhGvf3c9scvx8XqaFN79djGGCKaVJViI96yQr
	 mOnKN3RJ9zF0BZhQ0986SW3AjokWIz+IvGukEvicdc1DPPAAlAtiCdNslpgenvAMMs
	 X7uVm4OMwbvz30scsnuUg6v3NsAT0I6nfwKqEraD7CMTMqfSDAghheUn8sWT7o81Wr
	 J3pJmXgCywq1g==
Date: Sun, 4 May 2025 16:40:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/10] iio: adc: ad4080: add driver support
Message-ID: <20250504164015.4b6f8dd1@jic23-huawei>
In-Reply-To: <20250502085905.24926-10-antoniu.miclaus@analog.com>
References: <20250502085905.24926-1-antoniu.miclaus@analog.com>
	<20250502085905.24926-10-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 May 2025 11:59:04 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for AD4080 high-speed, low noise, low distortion,
> 20-bit, Easy Drive, successive approximation register (SAR)
> analog-to-digital converter (ADC).
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

One trivial thing I noticed to add to Nuno's much more detailed review!


> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> new file mode 100644
> index 000000000000..9168dee9323e
> --- /dev/null
> +++ b/drivers/iio/adc/ad4080.c

> +static int ad4080_set_dec_rate(struct iio_dev *dev,
> +			       const struct iio_chan_spec *chan,
> +			       unsigned int mode)
> +{
> +	struct ad4080_state *st = iio_priv(dev);
> +	int ret;
> +
> +	if ((st->filter_type >= SINC_5 && mode >= 512) || mode < 2)
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
> +				 AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
> +				 FIELD_PREP(AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
> +					    (ilog2(mode) - 1)));
> +	if (ret)
> +		return ret;
> +
> +	return 0;

return regmap_update_bits();


> +}


