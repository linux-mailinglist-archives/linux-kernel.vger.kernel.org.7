Return-Path: <linux-kernel+bounces-742342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAD3B0F02E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE333A57A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7264D28DB46;
	Wed, 23 Jul 2025 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="GyJ8d7He"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74B42DA743
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267498; cv=none; b=PPr7q3xA7xzEoJlNXBqMdUU3www7gnHw4qJAEZa7Kd1WvZp1tenMMcj+JF0BCQMEGvY2jLtCR2sd8PLvdmKL4oXjXum0oNehxasbIo1+L4Mgf4v6PgfT+wZ507R4TYYcnQ0wLfSnWqOzat0EKE0U7GSTrbX6b2VWi39GYt7NAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267498; c=relaxed/simple;
	bh=qBX0JDeGTivbXtJf33doQUh6g6lQZVKlqiviu7KFJ/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKLZ3NdoqZYs/i4+eH0U4ETWLLFFq6W/gcP6WmyXiqcvGaVSsQH/RGQsJfu2QtoFivf5EXf6rQOIIBJxN/fYTgFtDW+B/r1MPs1pr54PINJqr2EBwSQ7xkqSyXT5s6LeDHbm58XOCq6uwNgRiDFe+O0H01BJEkij56n9tddTwFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=GyJ8d7He; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6129ff08877so1319272a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1753267494; x=1753872294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7xYOZXPRdiXsohCXzg0pxN0cIN0Hm/modECQR4pJ+7s=;
        b=GyJ8d7HeXC4egm5bctPuZwDAZEZK6bnUMAnGp3yGP0G8Gz6tw4pLRJvUJ12ZuqYGKZ
         766rLcSFyQyTuSlNCM6t2f3dGnEhdDNJEtrqhLRmh3ep/dgDLzkfywGEjiXN58E4sIhQ
         Wv0hrXoilobUhT1esS4rnUnxZcmCmU35NPcYDqyvzAnRajPJx3ho/dBIJU9evFNt2Fa5
         XbeKfD6P26vXT+lbo6EJ+unvJbuQaim8p1M4ESBIAGsILQua7qi82ocWhrXV5bXfEzSM
         w5BqMv91e5Q4OIhRajnC0y343HrDm/BRmn7FEee3u6+wUyFsTtOXhfUCYI/xDqZLsaXn
         XT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753267494; x=1753872294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xYOZXPRdiXsohCXzg0pxN0cIN0Hm/modECQR4pJ+7s=;
        b=dLsQsRMwhDar8ZZxnq4fy5Xdz4hDuYk/Wxwpoe0vVjcVRvyQ1zQtR6g9Wuu0pBjt2D
         vJCD2T73jxuBTqQXPoGXdqQCSIdnUwBHJh0AnVgqMdcTwRKI0gC0RILFej8lKwzNlvHI
         zgJ5M5sJjvqn40+/819xa1OBCXJPi7gD+WZZyLxgtiEP3Qr+7d2yzwBmGEJ9ZKa2Gjen
         mlZ9M5lirygL4A/38dOoxxjpCjPkGgU3ppK9wb7DKLi0ZTsvXUh2cCnIktAbJsTDJ3fc
         nYB4P40F5HgLmuCt/mDkzHchQ0Fu4ZoZEuQORYGSwTjaiYhH78QAsjZu3YCHFW/rd8Tp
         IYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbBDsLE2oW+9NJVvVC8t3VvB8QosxeWhegqY7rFfbyEtU9FA6XNUG6Qg4YBs3LgWt2VFt+IXs3U4HTmPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwavEg1IErtfh5iPwaAH3m0LVtnyyQwdvtaWygxAFdOKCc1zIsi
	kK/S3hs3Zuy3sc5YpDfBRScRQRhSw5FaBnRpxL924ccwHKtARj6x9VswfvSbQUDz2dk=
X-Gm-Gg: ASbGnctCf7x+a5tg7gP0smaUMI3t3SJkbSe62IdXHp1QJqc0T/cnBfNpgV/dwa8wi9G
	u/T1e/CtUn5m1F8J6BDXqQcZsCStdvmVhcpPD/6DOKYlDHlcmVW46O/ZPJAB3BlklBigP/UxfrF
	6OnJ2YKwjhNaf2SCPiIHJVrtGoyj4Q9bnGsixNoq8D2kNngyEYR3JNVjJ41RkiXkm6NmxubALS2
	31M4XGr+CT6TCdUh3d58fhqlACfAnGR/TaMxIO+VYDf3IkTCjHgVZHLFHKnVfH/zvJ5GlhrEBIT
	Zv30MULqqjQtonGmx7u5nbM6nHIQRMedoBmXOHIh5vnaoi2kUOyRDAow6KKz/8EeFzw3XZKzcR1
	P5Mk0a65H6yI/6ekpPDBepC8aP9Vc53eW
X-Google-Smtp-Source: AGHT+IE23/w37kh2WpRE8noRTOloYfD2av2U6W+7NxUiHq7HRFeWTokOzqO4eVBP7cTthd6+wZ5C2g==
X-Received: by 2002:a05:6402:50c7:b0:612:dfdd:4718 with SMTP id 4fb4d7f45d1cf-61346fe4392mr6180298a12.12.1753267493631;
        Wed, 23 Jul 2025 03:44:53 -0700 (PDT)
Received: from [10.0.5.28] (remote.cdn77.com. [95.168.203.222])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c9071069sm8214578a12.50.2025.07.23.03.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:44:53 -0700 (PDT)
Message-ID: <d0891c62-6c9a-4036-bf63-f5070ebba084@sedlak.dev>
Date: Wed, 23 Jul 2025 12:44:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: Add initial interconnect framework abstractions
To: Konrad Dybcio <konradybcio@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Georgi Djakov <djakov@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
 <20250722-topic-icc_rs-v1-1-9da731c14603@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <20250722-topic-icc_rs-v1-1-9da731c14603@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Konrad,

On 7/22/25 11:14 PM, Konrad Dybcio wrote:

> +//! Reference: <https://docs.kernel.org/driver-api/interconnect.html>
> +
> +/// The interconnect framework bandidth unit.
> +///
> +/// Represents a bus bandwidth request in kBps, wrapping a [`u32`] value.
> +#[derive(Copy, Clone, PartialEq, Eq, Debug)]
> +pub struct IccBwUnit(pub u32);

IMO this is bit of an anti pattern for the newtype. Wouldn't be better 
to have the inner type private instead of public to keep the u32 as an 
implementation detail?

> +
> +impl IccBwUnit {
> +    /// Create a new instance from bytes (B)
> +    pub const fn from_bytes_per_sec(bps: u32) -> Self {
> +        Self(bps / 1000)
> +    }
> +
> +    /// Create a new instance from kilobytes (kB) per second
> +    pub const fn from_kilobytes_per_sec(kbps: u32) -> Self {
> +        Self(kbps)
> +    }
> +
> +    /// Create a new instance from megabytes (MB) per second
> +    pub const fn from_megabytes_per_sec(mbps: u32) -> Self {
> +        Self(mbps * 1000)
> +    }
> +
> +    /// Create a new instance from gigabytes (GB) per second
> +    pub const fn from_gigabytes_per_sec(gbps: u32) -> Self {
> +        Self(gbps * 1000 * 1000)
> +    }
> +
> +    /// Create a new instance from bits (b) per second
> +    pub const fn from_bits_per_sec(_bps: u32) -> Self {
> +        Self(1)
> +    }

This is a very shady API. If I were to call

	let bw = IccBwUnit::from_bits_per_sec(16);

I would expect.

	assert_eq!(bw.as_bytes_per_sec(), 2);

But it would fail (assuming that 8 bits = 1 byte), since 
IccBwUnit::from_bits_per_sec(), always assigns 1.


> +
> +    /// Create a new instance from kilobits (kb) per second
> +    pub const fn from_kilobits_per_sec(kbps: u32) -> Self {
> +        Self(kbps.div_ceil(8))
> +    }
> +
> +    /// Create a new instance from megabits (Mb) per second
> +    pub const fn from_megabits_per_sec(mbps: u32) -> Self {
> +        Self(mbps * 1000 / 8)
> +    }
> +
> +    /// Create a new instance from gigabits (Gb) per second
> +    pub const fn from_gigabits_per_sec(mbps: u32) -> Self {
> +        Self(mbps * 1000 * 1000 / 8)
> +    }
> +
> +    /// Get the bandwidth in bytes (B) per second
> +    pub const fn as_bytes_per_sec(self) -> u32 {
> +        self.0 * 1000
> +    }
> +
> +    /// Get the bandwidth in kilobytes (kB) per second
> +    pub const fn as_kilobytes_per_sec(self) -> u32 {
> +        self.0
> +    }
> +
> +    /// Get the bandwidth in megabytes (MB) per second
> +    pub const fn as_megabytes_per_sec(self) -> u32 {
> +        self.0 / 1000
> +    }
> +
> +    /// Get the bandwidth in gigabytes (GB) per second
> +    pub const fn as_gigabytes_per_sec(self) -> u32 {
> +        self.0 / 1000 / 1000
> +    }
> +
> +    /// Get the bandwidth in bits (b) per second
> +    pub const fn as_bits_per_sec(self) -> u32 {
> +        self.0 * 8 / 1000
> +    }
> +
> +    /// Get the bandwidth in kilobits (kb) per second
> +    pub const fn as_kilobits_per_sec(self) -> u32 {
> +        self.0 * 8
> +    }
> +
> +    /// Get the bandwidth in megabits (Mb) per second
> +    pub const fn as_megabits_per_sec(self) -> u32 {
> +        self.0 * 8 * 1000
> +    }
> +
> +    /// Get the bandwidth in gigabits (Gb) per second
> +    pub const fn as_gigabits_per_sec(self) -> u32 {
> +        self.0 * 8 * 1000 * 1000
> +    }
> +}
> +
> +impl From<IccBwUnit> for u32 {
> +    fn from(bw: IccBwUnit) -> Self {
> +        bw.0
> +    }
> +}
> +
> +#[cfg(CONFIG_INTERCONNECT)]
> +mod icc_path {
> +    use super::IccBwUnit;
> +    use crate::{
> +        device::Device,
> +        error::{Result, from_err_ptr, to_result},
> +        prelude::*,
> +    };
> +
> +    use core::ptr;
> +
> +    /// A reference-counted interconnect path.
> +    ///
> +    /// Rust abstraction for the C [`struct icc_path`]
> +    ///
> +    /// # Invariants
> +    ///
> +    /// An [`IccPath`] instance holds either a pointer to a valid [`struct icc_path`] created by
> +    /// the C portion of the kernel, or a NULL pointer.
> +    ///
> +    /// Instances of this type are reference-counted. Calling [`IccPath::of_get`] ensures that the
> +    /// allocation remains valid for the lifetime of the [`IccPath`].
> +    ///
> +    /// # Examples
> +    ///
> +    /// The following example demonstrates hwo to obtain and configure an interconnect path for
> +    /// a device.
> +    ///
> +    /// ```
> +    /// use kernel::icc_path::{IccPath, IccBwUnit};
> +    /// use kernel::device::Device;
> +    /// use kernel::error::Result;
> +    ///
> +    /// fn poke_at_bus(dev: &Device) -> Result {
> +    ///     let bus_path = IccPath::of_get(dev, Some(c_str!("bus")))?;
> +    ///
> +    ///     bus_path.set_bw(
> +    ///         IccBwUnit::from_megabits_per_sec(400),
> +    ///         IccBwUnit::from_megabits_per_sec(800)
> +    ///     )?;
> +    ///
> +    ///     // bus_path goes out of scope and self-disables if there are no other users
> +    ///
> +    ///     Ok(())
> +    /// }
> +    /// ```
> +    #[repr(transparent)]
> +    pub struct IccPath(*mut bindings::icc_path);
> +
> +    impl IccPath {
> +        /// Get [`IccPath`] corresponding to a [`Device`]
> +        ///
> +        /// Equivalent to the kernel's of_icc_get() API.
> +        pub fn of_get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
> +            let id = name.map_or(ptr::null(), |n| n.as_ptr());
> +
> +            // SAFETY: It's always safe to call [`of_icc_get`]
> +            //
> +            // INVARIANT: The reference count is decremented when [`IccPath`] goes out of scope
> +            Ok(Self(from_err_ptr(unsafe {
> +                bindings::of_icc_get(dev.as_raw(), id)
> +            })?))
> +        }
> +
> +        /// Obtain the raw [`struct icc_path`] pointer.
> +        #[inline]
> +        pub fn as_raw(&self) -> *mut bindings::icc_path {
> +            self.0
> +        }
> +
> +        /// Enable the path.
> +        ///
> +        /// Equivalent to the kernel's icc_enable() API.
> +        #[inline]
> +        pub fn enable(&self) -> Result {
> +            // SAFETY: By the type invariants, self.as_raw() is a valid argument for `icc_enable`].
> +            to_result(unsafe { bindings::icc_enable(self.as_raw()) })
> +        }
> +
> +        /// Disable the path.
> +        ///
> +        /// Equivalent to the kernel's icc_disable() API.
> +        #[inline]
> +        pub fn disable(&self) -> Result {
> +            // SAFETY: By the type invariants, self.as_raw() is a valid argument for `icc_disable`].
> +            to_result(unsafe { bindings::icc_disable(self.as_raw()) })
> +        }
> +
> +        /// Set the bandwidth on a path
> +        ///
> +        /// Equivalent to the kernel's icc_set_bw() API.
> +        #[inline]
> +        pub fn set_bw(&self, avg_bw: IccBwUnit, peak_bw: IccBwUnit) -> Result {
> +            // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`icc_set_bw`].
> +            to_result(unsafe {
> +                bindings::icc_set_bw(
> +                    self.as_raw(),
> +                    avg_bw.as_kilobytes_per_sec(),
> +                    peak_bw.as_kilobytes_per_sec(),
> +                )
> +            })
> +        }
> +    }
> +
> +    impl Drop for IccPath {
> +        fn drop(&mut self) {
> +            // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`icc_put`].
> +            unsafe { bindings::icc_put(self.as_raw()) }
> +        }
> +    }
> +}
> +
> +// SAFETY: An `IccPath` is always reference-counted and can be released from any thread.
> +unsafe impl Send for IccPath {}
> +
> +#[cfg(CONFIG_INTERCONNECT)]
> +pub use icc_path::*;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 87bcaa1c6b8a6291e71905e8dde60d945b654b98..60f6ac6e79cce57a8538ea0ad48f34f51af91731 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -89,6 +89,7 @@
>   pub mod fmt;
>   pub mod fs;
>   pub mod init;
> +pub mod icc;

Nit: formatting/missing space?

>   pub mod io;
>   pub mod ioctl;
>   pub mod jump_label;
> 

Thanks!
Daniel

