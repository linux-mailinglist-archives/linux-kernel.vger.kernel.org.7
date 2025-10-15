Return-Path: <linux-kernel+bounces-855250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 748F8BE09E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F94D4E8744
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300D12BE7B0;
	Wed, 15 Oct 2025 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0USLYG7"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5462BE652
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559625; cv=none; b=X8L1TlyL4Lph5bRxN6yM/RHfDWKKPNDW0ylXT1K8OvMj1zQ6Kpwd3eWt64V+LEAb4k2h1yFjE48z/P8REhBdUTgY5NtPkjZo7cFYG/N8/f5dZPJ4VvE42DdoAx3Ayabo6QW7Kc22JTNG1DDT6eNh2lo2Kw3K+gEjm/cxNFfuLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559625; c=relaxed/simple;
	bh=W5lL+7clCIuimE2JZ8XP6AYfpvpiK8gFacYRPIHJLgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkhYR4nPrPQhKrH1HhkdO9GlyUKtt9aF/L4V+x049xM0wA2MGmKH55jnxXH24L6VA6+IQlbXNHbMGvDxVSI6ocUp8p9nILAIq4BjNLU0C6mNhj7PURHheeB7DGVH47ZDW8x+PYxtHx3mZavHlKpp38A+1qkZVXfMEweMILHIj2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0USLYG7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so31746b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760559623; x=1761164423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=95gcM031oDoREK3NrLaeDpeIxgdfvAPsa65KxdRg+ks=;
        b=M0USLYG7rUyAgUurL2h04e/V1EqNNSdzSyAhWbOIWIUzbwrgQwFk7gInAPhBx5bV87
         O5kHGaOVCHfcp/qc9YKMpHQ5WQtkzrg4pBRAC2pMjcOzN63hTYmWzuNYpWtXoQ2zy+x+
         atk+kv8u0l55hq2ycBKbEChrSlNb6has74FBUMhcX05gM91i/e25Vhj9cJewKB/GleIo
         mnSq17a/61qKK4/q/PMJ6IPE3JGJj3FfnXKzRXq2e3vEf/+B60IDSX4KBVJcjd+LGJbM
         GdAmZRrL5LA+eK5RDPqGPtAipr52YRKMV8rgYbqb8plXn36YXcMUBBCAzrL1GdbH3q1p
         0LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760559623; x=1761164423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95gcM031oDoREK3NrLaeDpeIxgdfvAPsa65KxdRg+ks=;
        b=MHZ3vOWM6iCqFZmVJApdv/yiQa3SPRNaZPWclowYDpEpEeNdhfOHJvmglSMCSlk9xH
         fVN4zSgTTBgFh4nJmr+lLppbpJMNrtr6sqgmOuCoH7pzZBwQlghfjfydaLOKn6w436zQ
         kAyZTdOMokA7LNT0maRShB+fK1a6W25hypUBAtG+r9mv/Vib1yMARu75mmyW4hkANaen
         8Mca8tBdU0YqtPJcgbZ8PF/ZSdHQ6Qkhqnh+srLuBRXicrVp3MJkyS2Xfs1quupy1foT
         UY+ECMNE2FYJG6A7++5GujNd1qBnkLsYg0ONwvCr5nVReAUvFeBDUvsb/tYJEjQQROBL
         m2fw==
X-Forwarded-Encrypted: i=1; AJvYcCWBHAPJQGfAslefe+w4flne7gncASC1Hzf7NKLXi5ULrut/HUV660cxOqz3TZHJuWjUGmkDO/QZ4eP2ngc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQrRwTE1CaMFWTz8OZacucaKbdWhzEhH+ZHOwJNVTkdoloaGpb
	eU4zvfvXPfJIWNC6QnveZKzbeYqrlma3h5AJtG4QbkNVoBctbebcvr6o
X-Gm-Gg: ASbGncvnX6UBwycviyBe5oG8uAq4V6HIMwZVNw5XfzPyN7Iu28WyRNMm4qb3fK7Oj2u
	Y/hTLAiV3O7h4hqJqEbWYbdMmiIQKoznYp4MoiiGS3uUS91sJz1SgmH89dmKEbmTEnRH5yp3oTh
	0/6WGvNlWjzwX4EQ1uCPkP7NoTnTRZvq7me70N5Ck9PX8p9tqdb8MErr2nkvi1LBqykns7s8DSp
	VB/8CxJBxROe2BVpe1TU9bMx0RrwG9LT1yhitzBMBBeEMU3NAtz8zqLjAVR9ekUrMcRc1A9kYwF
	kvOE1K/iyKIaPg6tbUfoOXwTAHi7XmUYis1a/JtJ8b/6GSqZMQ3J+4Q+/W+hsVUTYnWAurt0xsy
	lpC67q28GhU89GauA9po7K6hD+MOE+J1CR8hQVEWD75vMJsxJ430BqBYX3x8lsUz2lhTfVob0mO
	pI9Yfy1DPuRXeZ1Y398mi5UjBK2HjTqrA=
X-Google-Smtp-Source: AGHT+IF0EKTCjT3naae1xA/PAZLLqfv/YtCN9ndqoHWsu9/x7DQfDR8VhO2uGork8o9ktOC/MruXJA==
X-Received: by 2002:a05:6a00:2d8f:b0:781:2538:bfb4 with SMTP id d2e1a72fcca58-79385ce2724mr34350286b3a.10.1760559623239;
        Wed, 15 Oct 2025 13:20:23 -0700 (PDT)
Received: from localhost ([2804:30c:402b:1a00:ec78:db53:a246:207a])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-79cf0a052b8sm11363661b3a.67.2025.10.15.13.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:20:22 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:21:26 -0300
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
Subject: Re: [PATCH 3/6] spi: add multi_bus_mode field to struct spi_transfer
Message-ID: <aPACRllAorjG47L7@debian-BULLSEYE-live-builder-AMD64>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>

On 10/14, David Lechner wrote:
> Add a new multi_bus_mode field to struct spi_transfer to allow
> peripherals that support multiple SPI buses to be used with a single
> SPI controller.
> 
> This requires both the peripheral and the controller to have multiple
> serializers connected to separate data buses. It could also be used with
> a single controller and multiple peripherals that are functioning as a
> single logical device (similar to parallel memories).
> 
> The possible values for this field have the following semantics:
> 
> - SPI_MULTI_BUS_MODE_SINGLE: Only use the first bus. This means that it
>     it is operating just like a conventional SPI bus. It is the default
>     value so that existing drivers do not need to be modified.
> 
>     Example:
>         tx_buf[0] = 0x88;
> 
>         struct spi_transfer xfer = {
>             .tx_buf = tx_buf,
>             .len = 1,
>         };
> 
>         spi_sync_transfer(spi, &xfer, 1);
> 
>         controller    > data bits >     peripheral
>         ----------   ----------------   ----------
>             SDO 0    0-0-0-1-0-0-0-1    SDI 0
> 
> - SPI_MULTI_BUS_MODE_MIRROR: Send a single data word over all of the
>     buses at the same time. This only makes sense for writes and not
>     for reads.
> 
>     Example:
>         tx_buf[0] = 0x88;
> 
>         struct spi_transfer xfer = {
>             .tx_buf = tx_buf,
>             .len = 1,
>             .multi_bus_mode = SPI_MULTI_BUS_MODE_MIRROR,
>         };
> 
>         spi_sync_transfer(spi, &xfer, 1);
> 
>         controller    > data bits >     peripheral
>         ----------   ----------------   ----------
>             SDO 0    0-0-0-1-0-0-0-1    SDI 0
>             SDO 1    0-0-0-1-0-0-0-1    SDI 1
> 
> - SPI_MULTI_BUS_MODE_STRIPE: Send or receive two different data words at
>     the same time, one on each bus.
> 
>     Example:
>         struct spi_transfer xfer = {
>             .rx_buf = rx_buf,
>             .len = 2, /* must be multiple of number of buses */
>             .multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE,
>         };
> 
>         spi_sync_transfer(spi, &xfer, 1);
> 
>         controller    < data bits <     peripheral
>         ----------   ----------------   ----------
>             SDI 0    0-0-0-1-0-0-0-1    SDO 0
>             SDI 1    1-0-0-0-1-0-0-0    SDO 1
> 
>         After the transfer, rx_buf[0] == 0x11 (word from SDO 0) and
>         rx_buf[1] == 0x88 (word from SDO 1). If the transfer was longer,
>         the data would continue in an alternating fashion.
> 
Can the above explanation be added to the documentation?
Maybe spi-summary.rst or a new file?

> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Nevertheless,
Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

