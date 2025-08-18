Return-Path: <linux-kernel+bounces-773309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B193DB29E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A7B2A4F88
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F53430EF73;
	Mon, 18 Aug 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfaYLBCi"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8C30E85A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509682; cv=none; b=PElIB9bht4WwQVLKhevpk1yp44a3dYlXkWEqFqTRZcHu/RSCy8p5nAURyXxD8ATXtbGGLOBJpXXhJ8VhOHeF4ipsgVBu59LfRUUjCvEQLfn5aFdgcixnTFOSYuIZ5V31kS6hd22ofzITP5mlGpx5TI9u1xVuNjYsjj240Hu175w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509682; c=relaxed/simple;
	bh=a+etiZYruUWbmNGIqX4kShOdCzW5WsCXUhUXSAJs36o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WQNP+bCsgcnx+iJB1teL9xLyzT11ED/qztNaTaxKl6LjPBfJJy2uengL0ITB3ksJgoqTXvkRGVhjVr+xYAlZvAQ331RHZ+nleuryeIsND/RqyAExrCG+SQeD7j3pajzr+5Rq+l0cfd27PPasBgjcMAnXEuWf2JvLFrYIZNZsATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VfaYLBCi; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-618af99f6e5so1529882a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755509679; x=1756114479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxScC+t6YfykJP91EppLJ4JtjaT1ZtIiluXFre5egrg=;
        b=VfaYLBCir8mekvz2g+G00YfJznIK/wFdpyLmpmW2+e9iIbFle2bpp5YIVVQ6f+w/7D
         4VXzxe52JW35Ukb+YEkvsnenjsLm/kUarO2Y/lWwVfRYSdKPteKjhH1tPzflc+48Er/I
         +mRnuIPGAkf/nEWnb2k9gywqOstEPdD/LMEgql3PUngluoiA4VKER6xFj2lw/XVDhusR
         1WtK8tJf0vJ0oJmxnpiXiK9x0ZQahzQa8pgf2C3SYue2xZXscc4hl7ncLHNjNQUip2jx
         NZTe8SxdFTqGwFwKBfJnxk+IzvyiRSVN8vFDAKyOKGI7LiZfnCA51RbaX7m9c+6/YljS
         BpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509679; x=1756114479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxScC+t6YfykJP91EppLJ4JtjaT1ZtIiluXFre5egrg=;
        b=iy9MDMxzBuHh/Vaf6C+Qp2Qp3a3GtNfncQd2N8bg9aaH+sGjpznLUHmiezMn+yK+Cc
         Pdd+dKUNoCQsq1cV1jhDF3mo3jAHpivLoaIMaDSZZKspr1Idg9oE0Vq2FmcMUo5tV98r
         /KhInn4qbfnlF1X7mOJC3cday89PNSJMnycoUVH9R7xGhqjcx5M1typy6oqxrGExpYk8
         2SZhi1KvLtJpyCyH4im3IwfTsTds4/SuKLfdbqKx3VxBJuZ+iZcy2NANsB95qabV05uQ
         0bU4yTlrcwF19WgLquFDhr8iYEffdWzLR6ylaurJ7wvOYt12g3BhPm6pC8o6AMu24IAr
         /NPA==
X-Forwarded-Encrypted: i=1; AJvYcCUlgdUB3YDft+BdLvPn/YRGbYFvipfnNt8UtaGiUMHFaRqW/bmemwSSEEAhOv3j7U6JC+lnDknnsgnMtUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp64NHfebYJc3jnPuSLeHObcvBfSH71HWlSNNCb3dHdF1vmz7f
	25xN1Re++dsjkFN4iXvY5QvMlwjFBm05s3VOCdIayVRGlGf8riGyYVwdBB5QyBIly/Pq/3hXUbz
	tbGWOn7JLUXo71kzM0w==
X-Google-Smtp-Source: AGHT+IEs5GmDksLjwRu0yfO21DllPTLa9ydpvK+eEh0RR1vr1aoOT8dBMcP63FUYBNCBIYDIHGXp3QEgxo+FF7g=
X-Received: from edad32.prod.google.com ([2002:a05:6402:4020:b0:618:7545:ce28])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:518f:b0:618:40ef:fa47 with SMTP id 4fb4d7f45d1cf-619b6f621c4mr6130226a12.1.1755509679511;
 Mon, 18 Aug 2025 02:34:39 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:34:38 +0000
In-Reply-To: <20250815171058.299270-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815171058.299270-1-dakr@kernel.org> <20250815171058.299270-2-dakr@kernel.org>
Message-ID: <aKLzrp0m00J6CCYz@google.com>
Subject: Re: [PATCH 1/4] rust: dma: implement DataDirection
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	abdiel.janulgue@gmail.com, acourbot@nvidia.com, jgg@ziepe.ca, 
	lyude@redhat.com, robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 15, 2025 at 07:10:02PM +0200, Danilo Krummrich wrote:
> Add the `DataDirection` struct, a newtype wrapper around the C
> `enum dma_data_direction`.
> 
> This provides a type-safe Rust interface for specifying the direction of
> DMA transfers.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

> +/// DMA data direction.
> +///
> +/// Corresponds to the C [`enum dma_data_direction`].
> +///
> +/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
> +#[derive(Copy, Clone, PartialEq, Eq)]
> +pub struct DataDirection(bindings::dma_data_direction);

Perhaps this should be a real Rust enum so that you can do an exhaustive
match?

> +impl DataDirection {
> +    /// The DMA mapping is for bidirectional data transfer.
> +    ///
> +    /// This is used when the buffer can be both read from and written to by the device.
> +    /// The cache for the corresponding memory region is both flushed and invalidated.
> +    pub const BIDIRECTIONAL: DataDirection =
> +        DataDirection(bindings::dma_data_direction_DMA_BIDIRECTIONAL);
> +
> +    /// The DMA mapping is for data transfer from memory to the device (write).
> +    ///
> +    /// The CPU has prepared data in the buffer, and the device will read it.
> +    /// The cache for the corresponding memory region is flushed.
> +    pub const TO_DEVICE: DataDirection = DataDirection(bindings::dma_data_direction_DMA_TO_DEVICE);
> +
> +    /// The DMA mapping is for data transfer from the device to memory (read).
> +    ///
> +    /// The device will write data into the buffer for the CPU to read.
> +    /// The cache for the corresponding memory region is invalidated before CPU access.
> +    pub const FROM_DEVICE: DataDirection =
> +        DataDirection(bindings::dma_data_direction_DMA_FROM_DEVICE);
> +
> +    /// The DMA mapping is not for data transfer.
> +    ///
> +    /// This is primarily for debugging purposes. With this direction, the DMA mapping API
> +    /// will not perform any cache coherency operations.
> +    pub const NONE: DataDirection = DataDirection(bindings::dma_data_direction_DMA_NONE);
> +
> +    /// Returns the raw representation of [`enum dma_data_direction`].
> +    pub fn as_raw(self) -> bindings::dma_data_direction {
> +        self.0
> +    }
> +}

