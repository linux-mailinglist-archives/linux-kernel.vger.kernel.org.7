Return-Path: <linux-kernel+bounces-787073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E1CB37101
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E131BA356C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC5E2E266C;
	Tue, 26 Aug 2025 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="XS/blkfX"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D7E234973;
	Tue, 26 Aug 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228257; cv=pass; b=EvxOPzLoX1oJArKD3eetWLiqEzqjZOSSCVXpfX8wnb0sO1mg2n8GSRSSWMLzd/QSCwV8GKvFwEAr95OlSKx0s+2AcP5r4AQO3uIVM7wn+jGBdmqTtxnL5xdCUMvw9tCs+EcIGYHk+UD1UMLYdI4tipSYrjLFuA58ADsGZLU3ZvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228257; c=relaxed/simple;
	bh=4Vx/QI4i55J2XDbPq76nlwchHfVrQMCLkJssf+8o3as=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OcXVk93lZzM9vkrPXqMum+YlOR8eDsiPT40SM7fPVp0/t8sG+n4HEjB0fImzf1W7wHCOLnwlx4kB1d+eu6ZWkGBKArZLazQTfLkdZ9jbDo6+keR/PWsM+VxjTQxv37CFs8MEMVjrC537C/n9Af4isTB9gEW+SY9SnvkqojNjlD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=XS/blkfX; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756228232; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S/rN8Rgmw230boCeNSf08fQpYegFKcxu+nTy5OV6yUipX4rjEr0txFn4fqoBicJFomWryBIgk/1OwoU5g2R9Z2wjpteOy8JFQkfDCAXfvCLVlOIxnnWMHH298Bec+f7orcZ025xdbOBIp8cU+kYfqHZmixvcU3s6TUaradjZCXg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756228232; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6ESWsgBJC8fPbJpsp4MhmuWc0RcABRP9zNnzcCiUOGA=; 
	b=f9mWCGo6m2kXHbnqireWwe5MyWzmo0WixNJLlTQvkSA5/2ngby+7yvsw1ihwl7pEb46wa3Rn7sRp3L1qfNJ0SqDp8JCzue1R7AWkHyH8YF2Voa32QTSA1dOtG+TC/lpyACSK5zAT6h82zr1Jqg49Rr9xH+fnqdH1GMbBNlrsA+4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756228232;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=6ESWsgBJC8fPbJpsp4MhmuWc0RcABRP9zNnzcCiUOGA=;
	b=XS/blkfXwCXoT0kdoZhLJ0i91bV6beJya2tGQvEAebsl+GJOOHMUr/IwDzDhLfkb
	h7qtSoI2blD4q93YZ0edrw8gEdHP8tg9tIJBz3xkeP1j9N3G6Ce9ja3amB/9PGtWqRs
	q3fTWiXYhprtKKlrrNXPXLWn+B4qliUjcvAPm0TE=
Received: by mx.zohomail.com with SMTPS id 1756228230518249.55696295371752;
	Tue, 26 Aug 2025 10:10:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 1/5] rust: dma: implement DataDirection
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250825132539.122412-2-dakr@kernel.org>
Date: Tue, 26 Aug 2025 14:10:13 -0300
Cc: akpm@linux-foundation.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 abdiel.janulgue@gmail.com,
 acourbot@nvidia.com,
 jgg@ziepe.ca,
 lyude@redhat.com,
 robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7B266B2-4CD6-4C20-9969-AC5BEA57C5A4@collabora.com>
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-2-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 25 Aug 2025, at 10:24, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> Add the `DataDirection` struct, a newtype wrapper around the C
> `enum dma_data_direction`.
>=20
> This provides a type-safe Rust interface for specifying the direction =
of
> DMA transfers.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> rust/bindings/bindings_helper.h |  1 +
> rust/kernel/dma.rs              | 68 +++++++++++++++++++++++++++++++++
> 2 files changed, 69 insertions(+)
>=20
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index 0e140e07758b..c2cc52ee9945 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -47,6 +47,7 @@
> #include <linux/cpumask.h>
> #include <linux/cred.h>
> #include <linux/device/faux.h>
> +#include <linux/dma-direction.h>
> #include <linux/dma-mapping.h>
> #include <linux/errname.h>
> #include <linux/ethtool.h>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 2bc8ab51ec28..27b25f041f32 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -244,6 +244,74 @@ pub mod attrs {
>     pub const DMA_ATTR_PRIVILEGED: Attrs =3D =
Attrs(bindings::DMA_ATTR_PRIVILEGED);
> }
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
> +    /// The cache for the corresponding memory region is flushed =
before device access.
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
> +            build_error!("C enum value is out of bounds for the =
target type `u32`.");
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
> +
> /// An abstraction of the `dma_alloc_coherent` API.
> ///
> /// This is an abstraction around the `dma_alloc_coherent` API which =
is used to allocate and map
> --=20
> 2.51.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

