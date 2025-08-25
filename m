Return-Path: <linux-kernel+bounces-785693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAFBB34FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2B704E22C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0EE2594B4;
	Mon, 25 Aug 2025 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="Kw7HvHkO"
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEEFA92E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756164040; cv=none; b=lNeA758wrFOJbLN1OkEdhf8v7ZEXr9v494I81svFrJt+XZxXyeKEkX3sOuGtkeaKS1IfTWOaHn5w/UkUGX0Ekxi69BQN25mt1f1FxtogZ0h0JsR0BmVTPum3jC0wk+GsD8aXGIa8aL1MpjZD4/YMhZRNS/uobKjVHOdyZWloXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756164040; c=relaxed/simple;
	bh=gbTmdVfYx6WD/wWYJEFXu2sOB9/ZLFj1eXj5NVqzxQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeZs15DWR7pti2Ktnfj6nuYi0qmXczSQJe43Lb2+AQJJ+7xW8YY00dQ5zKoQ/quxt0P6dwFiofBYR5qGp84PiDv4bUp1XygUmbgbdJHGL9F4rYDFMxqtnCPuXkpAkC0Q99O+W6stXG3pX5729ATdLaTaCvdLa0QOafOQDxk2n6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=Kw7HvHkO; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1756164027; x=1756423227;
	bh=dbfxHDr+4prCVmBev/sJiog2Lc66l2bjBKk57p6NvnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Kw7HvHkOW/t/7aBcbbaxEWgJIAosTbK9FiF/6CDyQESX2BXBlTRAFBUsx8tZMfYAr
	 db6I272BNYVLGhyhLUyUt86/sxo7RmXvwpjm8C+Jjkr6JyInW0/IQOAJVfpeF90Zzj
	 5+nWo4hHFKRADJMvcZTjlkhAKamuNUw58vSUs7fVOJwNUZ+ypNoX6ybtgrOTqt75Yx
	 yea2VWK69D3FhqUjpwyABmkcfz2XUDQq1VoKse3WnJus3t53cG1bvF/aEuAhTVNkiR
	 BfCPH2IfwZzREM40vUa2Qc7C0DylCv6VtERKOBfbExqguu0BHpwvtB36zuKpOjPWJ6
	 8cI9ZlrrjiWNA==
X-Pm-Submission-Id: 4c9mx60wYnz1DDLJ
Date: Mon, 25 Aug 2025 23:20:22 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	John Hubbard <jhubbard@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] nova-core: Add a library for bitfields in Rust
 structs
Message-ID: <aKzvpFf9PkTHYNet@archiso>
References: <20250824135954.2243774-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250824135954.2243774-1-joelagnelf@nvidia.com>

On Sun, Aug 24, 2025 at 09:59:52AM -0400, Joel Fernandes wrote:
> Add a minimal bitfield library for defining in Rust structures (called
> bitstruct), similar in concept to bit fields in C structs. This will be used
> for defining page table entries and other structures in nova-core.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  drivers/gpu/nova-core/bitstruct.rs | 149 +++++++++++++++++++++++++++++
>  drivers/gpu/nova-core/nova_core.rs |   1 +
>  2 files changed, 150 insertions(+)
>  create mode 100644 drivers/gpu/nova-core/bitstruct.rs
> 
> diff --git a/drivers/gpu/nova-core/bitstruct.rs b/drivers/gpu/nova-core/bitstruct.rs
> new file mode 100644
> index 000000000000..661a75da0a9c
> --- /dev/null
> +++ b/drivers/gpu/nova-core/bitstruct.rs
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// bitstruct.rs — C-style library for bitfield-packed Rust structures
> +//
> +// A library that provides support for defining bit fields in Rust
> +// structures to circumvent lack of native language support for this.
> +//
> +// Similar usage syntax to the register! macro.
> +
> +use kernel::prelude::*;
> +
> +/// Macro for defining bitfield-packed structures in Rust.
> +/// The size of the underlying storage type is specified with #[repr(TYPE)].
> +///
> +/// # Example (just for illustration)
> +/// ```rust
> +/// bitstruct! {
> +///     #[repr(u64)]
> +///     pub struct PageTableEntry {
> +///         0:0       present     as bool,
> +///         1:1       writable    as bool,
> +///         11:9      available   as u8,
> +///         51:12     pfn         as u64,
> +///         62:52     available2  as u16,
> +///         63:63     nx          as bool,
> +///     }
> +/// }
> +/// ```
> +///
> +/// This generates a struct with methods:
> +/// - Constructor: `default()` sets all bits to zero.
> +/// - Field accessors: `present()`, `pfn()`, etc.
> +/// - Field setters: `set_present()`, `set_pfn()`, etc.
> +/// - Builder methods: `with_present()`, `with_pfn()`, etc.
> +/// - Raw conversion: `from_raw()`, `into_raw()`
> +#[allow(unused_macros)]
> +macro_rules! bitstruct {
> +    (
> +        #[repr($storage:ty)]
> +        $vis:vis struct $name:ident {
> +            $(
> +                $hi:literal : $lo:literal $field:ident as $field_type:tt
> +            ),* $(,)?
> +        }
> +    ) => {
> +        #[repr(transparent)]
> +        #[derive(Copy, Clone, Default)]
> +        $vis struct $name($storage);
> +
> +        impl $name {
> +            /// Create from raw value
> +            #[inline(always)]
> +            $vis const fn from_raw(val: $storage) -> Self {
> +                Self(val)
> +            }
> +
> +            /// Get raw value
> +            #[inline(always)]
> +            $vis const fn into_raw(self) -> $storage {
> +                self.0
> +            }
> +        }
> +
> +        impl core::fmt::Debug for $name {
> +            fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
> +                write!(f, "{}({:#x})", stringify!($name), self.0)
> +            }
> +        }
> +
> +        // Generate all field methods
> +        $(
> +            bitstruct_field_impl!($vis, $name, $storage, $hi, $lo, $field as $field_type);
> +        )*
> +    };
> +}
> +
> +/// Helper to calculate mask for bit fields
> +#[allow(unused_macros)]
> +macro_rules! bitstruct_mask {
> +    ($hi:literal, $lo:literal, $storage:ty) => {{
> +        let width = ($hi - $lo + 1) as usize;
> +        let storage_bits = 8 * core::mem::size_of::<$storage>();
> +        if width >= storage_bits {
> +            <$storage>::MAX
> +        } else {
> +            ((1 as $storage) << width) - 1
> +        }
> +    }};
> +}
> +
> +#[allow(unused_macros)]
> +macro_rules! bitstruct_field_impl {
> +    ($vis:vis, $struct_name:ident, $storage:ty, $hi:literal, $lo:literal, $field:ident as $field_type:tt) => {
> +        impl $struct_name {
> +            #[inline(always)]
> +            $vis const fn $field(&self) -> $field_type {
> +                let field_val = (self.0 >> $lo) & bitstruct_mask!($hi, $lo, $storage);
> +                bitstruct_cast_value!(field_val, $field_type)
> +            }
> +        }
> +        bitstruct_make_setters!($vis, $struct_name, $storage, $hi, $lo, $field, $field_type);
> +    };
> +}
> +
> +/// Helper macro to convert extracted value to target type
> +///
> +/// Special handling for bool types is required because the `as` keyword
> +/// cannot be used to convert to bool in Rust. For bool fields, we check
> +/// if the extracted value is non-zero. For all other types, we use the
> +/// standard `as` conversion.
> +#[allow(unused_macros)]
> +macro_rules! bitstruct_cast_value {
> +    ($field_val:expr, bool) => {
> +        $field_val != 0
> +    };
> +    ($field_val:expr, $field_type:tt) => {
> +        $field_val as $field_type
> +    };
> +}
> +
> +#[allow(unused_macros)]
> +macro_rules! bitstruct_write_bits {
> +    ($raw:expr, $hi:literal, $lo:literal, $val:expr, $storage:ty) => {{
> +        let mask = bitstruct_mask!($hi, $lo, $storage);
> +        ($raw & !(mask << $lo)) | ((($val as $storage) & mask) << $lo)
> +    }};
> +}
> +
> +#[allow(unused_macros)]
> +macro_rules! bitstruct_make_setters {
> +    ($vis:vis, $struct_name:ident, $storage:ty, $hi:literal, $lo:literal, $field:ident, $field_type:tt) => {
> +        ::kernel::macros::paste! {
> +            impl $struct_name {
> +                #[inline(always)]
> +                #[allow(dead_code)]
> +                $vis fn [<set_ $field>](&mut self, val: $field_type) {
> +                    self.0 = bitstruct_write_bits!(self.0, $hi, $lo, val, $storage);
> +                }
> +
> +                #[inline(always)]
> +                #[allow(dead_code)]
> +                $vis const fn [<with_ $field>](mut self, val: $field_type) -> Self {
> +                    self.0 = bitstruct_write_bits!(self.0, $hi, $lo, val, $storage);
> +                    self
> +                }
> +            }
> +        }
> +    };
> +}

This is awesome. Is there a place for this to live outside of
`nova-core`? I would think this would be extremely useful as a general
helper for bitfield struct definitions.

> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
> index cb2bbb30cba1..54505cad4a73 100644
> --- a/drivers/gpu/nova-core/nova_core.rs
> +++ b/drivers/gpu/nova-core/nova_core.rs
> @@ -2,6 +2,7 @@
>  
>  //! Nova Core GPU Driver
>  
> +mod bitstruct;
>  mod dma;
>  mod driver;
>  mod falcon;
> -- 
> 2.34.1

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

