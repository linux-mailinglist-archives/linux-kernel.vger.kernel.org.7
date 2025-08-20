Return-Path: <linux-kernel+bounces-777772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE30B2DD9D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEC816E6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3751E31DDA1;
	Wed, 20 Aug 2025 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="E0YPuvzV"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D831CA59;
	Wed, 20 Aug 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695919; cv=pass; b=WwVjRCFQclcFSfTvXFq8n7ctRKyoecCVhzy16sN3znIY4QrKiziwosH5tY4xC0vnxYBaY4/lDzbjcdB+fkJg+vPnc9eIrwrtSFRAxo/xxGJFw5VJCh5vKXXr3U34qk7NQ5e/YyYAPBfs+sa8PJWfb6VLGBKQ/WN5KhmCnh9KPUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695919; c=relaxed/simple;
	bh=frt5KZGMpNc9RTPB+XpfdVGQov7vhfrWJBllvqHsGTg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BhowfHdsQzjsAKrb+nwN1B7O1E9OwXYol1DsQXsUOFAOlJ0+0AtPsoiJOOh4o5aeQyv9XHFIrTg5oSqxghMETGqxyo4/CmLWsHlWyV1PlFSE/NHesz7Q1DN+pZPG7+Y+Of9NReyy2BqOOpo31M9BElxhy1HtRnL6IRLPIctBH7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=E0YPuvzV; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755695895; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d8ylaho56bpW/bUGWgLu8sCBoXQQeEwxvuuIFu0j1newVzMHNn0RXmRcCAE9jGt0LpGPTBmjXeOWwebQl2KtF8AftahoT8QOh/TPlxyVdCS5R/pcX1LEEH5Z9bq1nAiFu7pLX7vY2FL1SkULMTNHNcVVqagbyzSIEt4kQLa5Vm4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755695895; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HIzJQLFg94r0N33A3IhRbNr3hlEkNsrOX22DxXcUn/c=; 
	b=mw9AT+TA8Hh5CgQBdpsPXV+daWY69MSw69/Xzd3GCmEb7+NVNtK2E7znY4l1JQRWgxgJN7qml5imkToUihU00JBViInsbqWgWvK7dCO8BSPKaSj4o6Oy9jW5I9Tp1q/EG8zflNBkdqlyOFieloRCaj/GvdY184MaLZQjqkyGgfE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755695895;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=HIzJQLFg94r0N33A3IhRbNr3hlEkNsrOX22DxXcUn/c=;
	b=E0YPuvzVDnaZHVB6bSBlktJX+8DznmdQ57D5OAOiKlXhPOW9EEuNk1VYfiUatgsv
	P8SnnHfjjjeR6ERyh5KhQCZ+/TbxIywGIZxEW5b+uEyH92CO26bY+GWjYQGw7L+5wGk
	sq1CV9wdg1AdWnHHyEupAhvE84pSslCUJMUnx24k=
Received: by mx.zohomail.com with SMTPS id 1755695893238551.6073039074761;
	Wed, 20 Aug 2025 06:18:13 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 1/4] rust: dma: implement DataDirection
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DC5UWIXHVAGI.1TTU2K9WIC1E9@kernel.org>
Date: Wed, 20 Aug 2025 10:17:54 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 akpm@linux-foundation.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 tmgross@umich.edu,
 abdiel.janulgue@gmail.com,
 acourbot@nvidia.com,
 jgg@ziepe.ca,
 lyude@redhat.com,
 robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <99CFF9D2-962E-4322-BCFD-273485DBAF62@collabora.com>
References: <20250815171058.299270-1-dakr@kernel.org>
 <20250815171058.299270-2-dakr@kernel.org> <aKLzrp0m00J6CCYz@google.com>
 <DC5INEG2DXU5.DM4JIICEQ2PC@kernel.org> <aKMa7YzO-PwEv9AT@google.com>
 <DC5KK67M752R.N9PX4LUG2F68@kernel.org>
 <CAH5fLgi6OZaqjnDScDrJ3YjN2a8mJuPiO5MLPUqUWo62WkvvrA@mail.gmail.com>
 <DC5Q80UUHSUV.360VLIC6DYZ78@kernel.org>
 <CAH5fLgjymw6Mr8qv8NDFA8hz+nfh3-B4XcZ_N-UAmJrc3Ug_QQ@mail.gmail.com>
 <DC5UWIXHVAGI.1TTU2K9WIC1E9@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 18 Aug 2025, at 18:03, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Mon Aug 18, 2025 at 8:47 PM CEST, Alice Ryhl wrote:
>> with no warnings and build-failure if out-of-bounds.
>=20
> +/// DMA data direction.
> +///
> +/// Corresponds to the C [`enum dma_data_direction`].
> +///
> +/// [`enum dma_data_direction`]: =
srctree/include/linux/dma-direction.h
> +#[derive(Copy, Clone, PartialEq, Eq, Debug)]
> +#[repr(u32)]
> +pub enum DataDirection {
> +    /// The DMA mapping is for bidirectional data transfer.
> +    ///
> +    /// This is used when the buffer can be both read from and =
written to by the device.
> +    /// The cache for the corresponding memory region is both flushed =
and invalidated.
> +    Bidirectional =3D =
Self::const_cast(bindings::dma_data_direction_DMA_BIDIRECTIONAL),
> +
> +    /// The DMA mapping is for data transfer from memory to the =
device (write).
> +    ///
> +    /// The CPU has prepared data in the buffer, and the device will =
read it.
> +    /// The cache for the corresponding memory region is flushed.
> +    ToDevice =3D =
Self::const_cast(bindings::dma_data_direction_DMA_TO_DEVICE),
> +
> +    /// The DMA mapping is for data transfer from the device to =
memory (read).
> +    ///
> +    /// The device will write data into the buffer for the CPU to =
read.
> +    /// The cache for the corresponding memory region is invalidated =
before CPU access.
> +    FromDevice =3D =
Self::const_cast(bindings::dma_data_direction_DMA_FROM_DEVICE),
> +
> +    /// The DMA mapping is not for data transfer.
> +    ///
> +    /// This is primarily for debugging purposes. With this =
direction, the DMA mapping API
> +    /// will not perform any cache coherency operations.
> +    None =3D Self::const_cast(bindings::dma_data_direction_DMA_NONE),
> +}
> +
> +impl DataDirection {
> +    /// Casts the bindgen-generated enum type to a `u32` at compile =
time.
> +    ///
> +    /// This function will cause a compile-time error if the =
underlying value of the
> +    /// C enum is out of bounds for `u32`.
> +    const fn const_cast(val: bindings::dma_data_direction) -> u32 {

This should be its own generic helper for similar enums, IMHO

> +        // CAST: The C standard allows compilers to choose different =
integer types for enums.
> +        // To safely check the value, we cast it to a wide signed =
integer type (`i128`)
> +        // which can hold any standard C integer enum type without =
truncation.
> +        let wide_val =3D val as i128;
> +
> +        // Check if the value is outside the valid range for the =
target type `u32`.
> +        // CAST: `u32::MAX` is cast to `i128` to match the type of =
`wide_val` for the comparison.
> +        if wide_val < 0 || wide_val > u32::MAX as i128 {
> +            // Trigger a compile-time error in a const context.
> +            panic!("C enum value is out of bounds for the target type =
`u32`.");
> +        }
> +
> +        // CAST: This cast is valid because the check above =
guarantees that `wide_val`
> +        // is within the representable range of `u32`.
> +        wide_val as u32
> +    }
> +}
> +
> +impl From<DataDirection> for bindings::dma_data_direction {
> +    /// Returns the raw representation of [`enum =
dma_data_direction`].
> +    fn from(direction: DataDirection) -> Self {
> +        // CAST: `direction as u32` gets the underlying =
representation of our `#[repr(u32)]` enum.
> +        // The subsequent cast to `Self` (the bindgen type) assumes =
the C enum is compatible
> +        // with the enum variants of `DataDirection`, which is a =
valid assumption given our
> +        // compile-time checks.
> +        direction as u32 as Self
> +    }
> +}


