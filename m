Return-Path: <linux-kernel+bounces-801676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C49B448A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69B41CC1AE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1748C2C1589;
	Thu,  4 Sep 2025 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUMUEcCv"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8972C0289;
	Thu,  4 Sep 2025 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021743; cv=none; b=D45s1yECCaxQXyCyto1U8+hrgr3P0aUlQefwBvP8hMJ25L6wo2uS5yQgXWH2KR4qk3zdJSGjgTfySqbZ02m49pH7LXS2V6w4wfGK1q3q99DY1uQSTMXwP/97b0ie5bMNz0PYOtsIcCYRmfyVuaMK7/ryjK+mhLjuXMSWdR2HNo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021743; c=relaxed/simple;
	bh=m9NnJCluKVTR11hVnQmXKzYllpPWfe3CilE8MG0CLyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNkr8emepxvT0uqhXIb2oSGf48QvUQQCIAyEblPeCt4+GVwa39ovM24TW8UwiQuHsjT/aOk4mXmUjYdNjhYX0NkrTizOB2B/E022RwUjfIHXMDGxsTZiojxdFg3VU3aDOMe154MvgDg7qqy4q8nliCsYL3XPAcll4lb3I9Hz2zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUMUEcCv; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e96fc00ad79so1472612276.0;
        Thu, 04 Sep 2025 14:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757021740; x=1757626540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IvCBV4RAVElTtuBlztSRnmNbm0dDQBJMrO8cYnccOd4=;
        b=kUMUEcCvbgyKiMBtA3TOdZKAkTSs59VATMCu04VpTnXFXgGFgubXwct1zemC/72jwb
         RQNuhWpStWeWp8uQ1qlW81iKiQWQ6oTPBhcvGrSwUHPb730CBje0wghkmzRp3bM4VDu9
         DNgC1xN9DK/VZbxdFUv7r8kT/piYSSsVS6+qJ8EcezQwEkPfnHcdDQQK7gyuq0BO4UWC
         U77PsjifaDvSg0APe4i5RPDfj9XdRxLNUoqAloFc2R0gdRBuSpJChEzXb1fYhKOywwh2
         +O+RdVCBGs5yywYMFL1yTSbHxD3+d8P+8Y0IojfXcVok9LcPdHdXzuPSxr0INJz2A5OX
         Fs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021740; x=1757626540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvCBV4RAVElTtuBlztSRnmNbm0dDQBJMrO8cYnccOd4=;
        b=YobDCVPnpcdnbk/if4Py4ppagevv/iVl1wJXXqt52Zpb3QHO3JPpjZYcNoHOdbXxVS
         9AO4TsLX4/wBgoZokIGJx1/Z+xnAjv3nC88pL/W1KQGmUfX9sEPMUfazojhXT/5UN0V1
         p4HA8aaIp6ghZXuZVfYpJqb6vVL8ZiG21l9kGdsXk78dJg5nAjzrEOVnGnOkmCSyDFD5
         3s5hOq/gyupDswK21na3vxGHF45kr3TYgmf+EaAs0TqLw2KZGq9AYWoBcj1ZI9daE3gZ
         lfd9/MKy1vdPFcARlZ7DLcSQ4Nes4XOaMnErf6TqeAcngLMlHeRpTnFLu7wfJAwENpWc
         ln7A==
X-Forwarded-Encrypted: i=1; AJvYcCXa3nl8NBzu4s3LH2xP4EAlKxmcuaSxr77quF69jQTWo93gyclW/dmcItjHLZp3UOZxKjSkK/zSNSrQtcuGbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIIz07/HvHe1z90VkacSo8WkX0FD6aEAV7LlSbGR9UmSxUKtHq
	eP8ZRqRfsTFuX3WtELK4qEEg+MgayZo82LceOu7fx2KbQFHvGzqNeO3e
X-Gm-Gg: ASbGncsp2ruT4mpZxLm7tSLOVtv1mGNFx2OsQoPy02GCw2/XqS9J3syZDS8mnytHix3
	MUw3UOLKty+kRAOhXM5tCxyjuGgroaAGc0ssBexgu89S+m8OGLQEgHvKKkpm4yt1GWj+Ey6tAxC
	xUVZMCPuIxm0RCV0bPhDG7zW+S0y/m5ToxufFw6jRKgVIL5oulJwGeipFzo+Lqa/USPNnmz5sUL
	ywiDlmjCb0LWPGVCpG+SgzpBD1cRVuigPFEAifLW0hbnxo0IVE5CMHx+OS2flhv3ucvG/0CtEQp
	Wit/oq5K9YZAXUT8SIHqOjfihYZqSsbTVPrbAKvLDisBsHFgSTumVtCOAXpYEEbv07AWNQkDObB
	NcvXoh0shCdkHj9sRXoNO9w==
X-Google-Smtp-Source: AGHT+IGcjNZusnsLiR6R1wgbKQBrEhDGHmeQUz60B2AGaGgy+2NRFtq0i4WitkyqZVH+hfJ5zflfxw==
X-Received: by 2002:a05:690e:424c:b0:5f3:319c:fec6 with SMTP id 956f58d0204a3-60175b91dfcmr3275590d50.11.1757021740093;
        Thu, 04 Sep 2025 14:35:40 -0700 (PDT)
Received: from localhost ([2601:347:100:5ea0:1218:85e4:58ab:e67f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5ff8ef2b4cdsm1726511d50.7.2025.09.04.14.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:35:39 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:35:38 -0400
From: Yury Norov <yury.norov@gmail.com>
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
Message-ID: <aLoGKilQPupPQkd2@yury>
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

Hi Joel,

(Thanks to John for referencing this.)

On Sun, Aug 24, 2025 at 09:59:52AM -0400, Joel Fernandes wrote:
> Add a minimal bitfield library for defining in Rust structures (called
> bitstruct), similar in concept to bit fields in C structs.

So maybe name it bitfield? 

> This will be used
> for defining page table entries and other structures in nova-core.

I think this is understatement, and this will find a broader use. :)

> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

I agree with the others that this bitstruct is worth to live in core
directory. I just merged bitmap wrapper in rust/kernel/bitmap.rs, and
I think this one should go in rust/kernel/bitstruct.rs (or bitfield.rs?).

Can you please consider this change for v2, and also add the new file in
BITOPS API record in MAINTAINERS?

A couple nits inline.

Thanks,
Yury

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

Is it possible to create overlapping fields? Should we allow that?
(I guess yes.) Does your machinery handle it correctly now?

If the answer is yes, can you add a test for it?

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

Does this '8' mean BITS_PER_BYTE? If so, we've got BITS_PER_TYPE() macro. Can
you use it here?

> +        if width >= storage_bits {
> +            <$storage>::MAX

This is an attempt to make an out-of-boundary access. Maybe print a
warning or similar? 

I actually think that if user wants to make an out-of-boundary access,
the best thing we can do is to keep the memory untouched. So, maybe
return None here, or 0, and make sure that the upper code doesn't
access it?

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
> 

