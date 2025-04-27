Return-Path: <linux-kernel+bounces-622104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A52A9E313
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 14:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFD23B3F1F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184AA139579;
	Sun, 27 Apr 2025 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srmickLK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676C3FB1B;
	Sun, 27 Apr 2025 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745758148; cv=none; b=be3gwutKshorMT0bn2btp8WZ68+tvXA6FHApiMuIv8V+PKE0TPwtfBxK2lYPZLScZkG+iZwHnAUxrddTQ1FsqSL381LmwAmuRKouDxESfPi7jNC3NiY6Npu43YgM64vQN5GteSlPtKwibGHBv39aruiRWGKP6Fl8krvCU/7Jyfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745758148; c=relaxed/simple;
	bh=JmcVMxmKTanoOPxTXt5eJutrIuKrOgq9JRia9SpFtgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mi5/tX7Mw+MW6ObOgZz0kz7gUz4ey7Icf/er7WfNYSVsmzOXAwC8gTCqCDhV3NqCi5oaeuF6YvDd03mRFicBsoa/z6uZeVhIx+qIJSQNq46YVK3Cou5vRkq9kH1wxtPjQgBueoc7aS5RtjDGVBuO0TrFTqeRCp20rMK4KARP5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srmickLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AA3C4CEE3;
	Sun, 27 Apr 2025 12:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745758147;
	bh=JmcVMxmKTanoOPxTXt5eJutrIuKrOgq9JRia9SpFtgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=srmickLKRaDYx/gLFp0zSSMadtaTf5utONalU1onTNUz53EAowYKK7I8p6I/iMItT
	 1pwQKoV30rkE564+T8ZNmcVa7zXcxh+KD7a7/IErwZ5pGxjlpKzp0PTP4x1R3j5aK8
	 JLv1+gtdYCae8GkMUY/RslxTSIWw4Ya8K4WoOZhTpp4tAskDyFHr89FdHel0CSp6Ry
	 e+zYKL9xQb6/1cs5bWiS4s40N0jbZqi73bgBoRcuak3V0Wr449qeK9I0UEA3j2DzGt
	 CWXakDUOTE11SoqjBLHKAeNu5Riu4ocUFXBEEx/vaKEPh/jl15HwpczbKxkcEn14LD
	 kzxobXjnvrbWw==
Date: Sun, 27 Apr 2025 13:49:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 09/11] iio: accel: adxl345: add inactivity feature
Message-ID: <20250427134900.35d19116@jic23-huawei>
In-Reply-To: <20250421220641.105567-10-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
	<20250421220641.105567-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 22:06:39 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the inactivity feature of the sensor. When activity and inactivity
> are enabled, a link bit will be set linking activity and inactivity
> handling. Additionally, the auto-sleep mode will be enabled. Due to the
> link bit the sensor is going to auto-sleep when inactivity was
> detected.
> 
> Inactivity detection needs a threshold to be configured, and a time
> after which it will go into inactivity state if measurements under
> threshold.
> 
> When a ODR is configured this time for inactivity is adjusted with a
> corresponding reasonable default value, in order to have higher
> frequencies and lower inactivity times, and lower sample frequency but
> give more time until inactivity. Both with reasonable upper and lower
> boundaries, since many of the sensor's features (e.g. auto-sleep) will
> need to operate beween 12.5 Hz and 400 Hz. This is a default setting
> when actively changing sample frequency, explicitly setting the time
> until inactivity will overwrite the default.
> 
> Similarly, setting the g-range will provide a default value for the
> activity and inactivity thresholds. Both are implicit defaults, but
> equally can be overwritten to be explicitly configured.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
One more thing I only noticed later...

>  enum adxl345_odr {
> @@ -232,6 +241,16 @@ static const struct iio_event_spec adxl345_freefall_event_spec = {
>  		BIT(IIO_EV_INFO_PERIOD),
>  };
>  
> +/* inactivity */
> +static const struct iio_event_spec adxl345_inactivity_event_spec = {
> +		.type = IIO_EV_TYPE_THRESH,

Similar to the activity detector. I'd expect inactivity to be magnitude
based not signed value (which EV_TYPE_THRESH is).

> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_PERIOD),
> +
> +};


