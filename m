Return-Path: <linux-kernel+bounces-745814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907B1B11F21
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68AC83B8EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4952E24466C;
	Fri, 25 Jul 2025 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdX3FAY+"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C69D14386D;
	Fri, 25 Jul 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753448555; cv=none; b=buLf9/9LCXFl+Wr9R8/CTaeFKhJ7zKQcx8vGHOcjH6HWUiZiU5LHWx/k+HDw+Bf0fUvUVrqAJHbI1o8eoZV8CcPDDe6HXNd8591vnruN1PWduQ+1s9oyrov3Hkist4Vl6SYdzKMkNopYQB8GwNG/41+PmtECUUCMWkML30biZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753448555; c=relaxed/simple;
	bh=hBWk+eJZ51MS8vWVq3YQVcbxtEJmCPUqddaDjcEOM1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvDqekF1CcpcpscQA8oR9zRHX/3UnS9GrBOyb0T72L3jEoP6YYoZfoRM5QfSjVf8s1e8o5uUXEMMb389bB4VlfIlrwtPlJgRTkAFwdIC57/oBPPVPz2uPtV65VdPHZ2lM9fzt8akH/+zOSk3wsCo0dpVm5Yd4e9eH0G6Unewrxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdX3FAY+; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso1818011a12.0;
        Fri, 25 Jul 2025 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753448553; x=1754053353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOtixk0pIeNz+uLPRvAlMsTSikV6j0Ax2X/oSMMqz34=;
        b=FdX3FAY+wERjxzBb4eTFI1wbLVH8MQl0EjM+mlrCMKv6Cq7sQ9uNPbmjtQ87FPq6Ak
         J0+87M0iXl1SJZMuKfN6+sLs0NkZRhNgxvivgX+srkwlxXRKHf3989U7zDEOy9tkEe/m
         PmosvZmlkNi192+s3fL0TGxknO/Y48ixNb/bpWDnabE0sjMvqKTyndTZoUfUkTE0uWwX
         bX81GkiovTVOL7Tv8/cQa+pT8IFYFJVZvgdGAmoPDFlfIZiH/E/ln4MiGKwhk10cUc6t
         +goO6QhyI/70+SJy6VeM/vi4Cm5RjqchaU8nBxGDCycgEg4dA4BFm3v2RdlL53tYybXa
         sT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753448553; x=1754053353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOtixk0pIeNz+uLPRvAlMsTSikV6j0Ax2X/oSMMqz34=;
        b=nVomE6mGv4bpsyrCH8VJrGfRkdUzM5aZIIOla4SrI8kATRQbUHsbm+FPFb9bdmP/Ae
         Z1XpyunXXGYxnMjBpSU2aMbX8d6GQhGG+BOUJU4WL74iwRGvFLUGiy88Uc9Hqur3ATMz
         4ZFoleJySIFH1wiIx4j6SpZk4YVFHs/H9tBE6QQ0MqpUycJfTAoYoT/owFH08N54MlPv
         3ml2EC9cCnagLJo3Alzp3Xdynn3T5dgd4LF//wr/VZvi76GdMCVa7aN9GVp6cq5269Uo
         OtSsFE1ZWdWy3WUBUNciy6nrQeJ65S8c5hL4ndRfIKUsw2uPabYYSNvDKFUa9s5ySM/a
         OrtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdOK2ancEeLdwI2SOAcvpP6INick9n551fIdyK9oy2Tooh/DoLaIeFBWNouiRHCdzNRqglniwWBFaOK7WhPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6en5XCJi0zuUCD6bWzrvo77LBLLU761IHlshH6UNs0izdcxwU
	2dYULAE6I3EXCXKSjp14GUtlQreCo5LSQVckoIxzoUVJjKTkoqyZVYd/Hmkfv5L8gG3Zrgqo7I0
	yqN82GrTCHsSbGmJhd1ZFst5nk4s+DQsIrfEf
X-Gm-Gg: ASbGncuxy8aqJpUFUL+BUX/YUojnBTB0QTshrP6qYeU7BcN+Xv2cDSPUSe5v/FwJnDc
	Gbsy1v87mceLKuat0K3esn9J9vdxMh4K9v2V5t9Hs/7AreqDkaDqVZqHKTTsqZ+3Pe5HbFYF96B
	HGdAevppwvEBEc+vgNHM3Lan370QT7pYRu2xuZV0kGlr5wnRzS+8evmCCoyrrO4WZcjgcMa3NjE
	wy7javw/halCDQs
X-Google-Smtp-Source: AGHT+IFTQ6t+COb/h6R2h5GwjqllDWm8AjUMg0wRWRjYgsuItGGVdO5yPr5hAEOzzQ0xSdF7YXO7oUcWRfwLWpAwbjQ=
X-Received: by 2002:a17:90b:280d:b0:311:c5d9:2c70 with SMTP id
 98e67ed59e1d1-31e7789934emr2781966a91.15.1753448551828; Fri, 25 Jul 2025
 06:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717073450.15090-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250717073450.15090-1-shankari.ak0208@gmail.com>
From: Shankari Anand <shankari.ak0208@gmail.com>
Date: Fri, 25 Jul 2025 18:32:20 +0530
X-Gm-Features: Ac12FXzehj8kGGLvdSyGA3YMAWuBF6zlvgOVZTCNAY4CNox03yylEP0TfwwNKqI
Message-ID: <CAPRMd3nhDKApttF_wBU01es76NG=qAyZMAer_gjbbtTSH_FmSA@mail.gmail.com>
Subject: Re: [PATCH 7/7] rust: kernel: update ARef and AlwaysRefCounted
 imports from sync::aref
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Can this be picked up for review? Should I be splitting each core
kernel file into a separate patch?

On Thu, Jul 17, 2025 at 1:05=E2=80=AFPM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> Update call sites in the core kernel files to import `ARef`
> and `AlwaysRefCounted` from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
> Its part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=3DNSRMV_6UxXVgkebmWmbgN4i=
=3DsfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintena=
nce.
>
> The original moving patch is here:
> https://lore.kernel.org/rust-for-linux/DBCLH4WXYTJL.FDZ9B39OO3TY@kernel.o=
rg/T/#mb67fbddcd894665d6ec6b0854e37930dedab468b
>
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.
> ---
>  rust/kernel/auxiliary.rs     |  2 +-
>  rust/kernel/cred.rs          |  6 +-----
>  rust/kernel/device.rs        | 10 +++-------
>  rust/kernel/devres.rs        |  3 +--
>  rust/kernel/dma.rs           |  2 +-
>  rust/kernel/opp.rs           | 13 +++++++------
>  rust/kernel/pci.rs           |  5 +++--
>  rust/kernel/pid_namespace.rs |  5 +----
>  rust/kernel/platform.rs      |  2 +-
>  rust/kernel/task.rs          |  7 ++++---
>  10 files changed, 23 insertions(+), 32 deletions(-)
>
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index d2cfe1eeefb6..776c63387832 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -250,7 +250,7 @@ extern "C" fn release(dev: *mut bindings::device) {
>  kernel::impl_device_context_into_aref!(Device);
>
>  // SAFETY: Instances of `Device` are always reference-counted.
> -unsafe impl crate::types::AlwaysRefCounted for Device {
> +unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
>          unsafe { bindings::get_device(self.as_ref().as_raw()) };
> diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
> index 2599f01e8b28..4a2229542fb7 100644
> --- a/rust/kernel/cred.rs
> +++ b/rust/kernel/cred.rs
> @@ -8,11 +8,7 @@
>  //!
>  //! Reference: <https://www.kernel.org/doc/html/latest/security/credenti=
als.html>
>
> -use crate::{
> -    bindings,
> -    task::Kuid,
> -    types::{AlwaysRefCounted, Opaque},
> -};
> +use crate::{bindings, sync::aref::AlwaysRefCounted, task::Kuid, types::O=
paque};
>
>  /// Wraps the kernel's `struct cred`.
>  ///
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 5c946af3a4d5..8b965b82163c 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -4,11 +4,7 @@
>  //!
>  //! C header: [`include/linux/device.h`](srctree/include/linux/device.h)
>
> -use crate::{
> -    bindings,
> -    str::CStr,
> -    types::{ARef, Opaque},
> -};
> +use crate::{bindings, str::CStr, sync::aref::ARef, types::Opaque};
>  use core::{fmt, marker::PhantomData, ptr};
>
>  #[cfg(CONFIG_PRINTK)]
> @@ -216,7 +212,7 @@ pub fn property_present(&self, name: &CStr) -> bool {
>  kernel::impl_device_context_into_aref!(Device);
>
>  // SAFETY: Instances of `Device` are always reference-counted.
> -unsafe impl crate::types::AlwaysRefCounted for Device {
> +unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
>          unsafe { bindings::get_device(self.as_raw()) };
> @@ -322,7 +318,7 @@ macro_rules! impl_device_context_deref {
>  #[macro_export]
>  macro_rules! __impl_device_context_into_aref {
>      ($src:ty, $device:tt) =3D> {
> -        impl ::core::convert::From<&$device<$src>> for $crate::types::AR=
ef<$device> {
> +        impl ::core::convert::From<&$device<$src>> for $crate::sync::are=
f::ARef<$device> {
>              fn from(dev: &$device<$src>) -> Self {
>                  (&**dev).into()
>              }
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index d0e6c6e162c2..7a1e2f2721b8 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -13,8 +13,7 @@
>      ffi::c_void,
>      prelude::*,
>      revocable::{Revocable, RevocableGuard},
> -    sync::{rcu, Arc, Completion},
> -    types::ARef,
> +    sync::{aref::ARef, rcu, Arc, Completion},
>  };
>
>  #[pin_data]
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 1f7bae643416..6339e1e22e08 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -9,8 +9,8 @@
>      device::{Bound, Device},
>      error::code::*,
>      error::Result,
> +    sync::aref::ARef,
>      transmute::{AsBytes, FromBytes},
> -    types::ARef,
>  };
>
>  /// Possible attributes associated with a DMA mapping.
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index 0e94cb2703ec..de1fea9964f3 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -16,7 +16,8 @@
>      ffi::c_ulong,
>      prelude::*,
>      str::CString,
> -    types::{ARef, AlwaysRefCounted, Opaque},
> +    sync::aref::{ARef, AlwaysRefCounted},
> +    types::Opaque,
>  };
>
>  #[cfg(CONFIG_CPU_FREQ)]
> @@ -162,7 +163,7 @@ fn from(power: MicroWatt) -> Self {
>  /// use kernel::device::Device;
>  /// use kernel::error::Result;
>  /// use kernel::opp::{Data, MicroVolt, Token};
> -/// use kernel::types::ARef;
> +/// use kernel::sync::aref::ARef;
>  ///
>  /// fn create_opp(dev: &ARef<Device>, freq: Hertz, volt: MicroVolt, leve=
l: u32) -> Result<Token> {
>  ///     let data =3D Data::new(freq, volt, level, false);
> @@ -211,7 +212,7 @@ fn drop(&mut self) {
>  /// use kernel::device::Device;
>  /// use kernel::error::Result;
>  /// use kernel::opp::{Data, MicroVolt, Token};
> -/// use kernel::types::ARef;
> +/// use kernel::sync::aref::ARef;
>  ///
>  /// fn create_opp(dev: &ARef<Device>, freq: Hertz, volt: MicroVolt, leve=
l: u32) -> Result<Token> {
>  ///     let data =3D Data::new(freq, volt, level, false);
> @@ -262,7 +263,7 @@ fn freq(&self) -> Hertz {
>  /// use kernel::clk::Hertz;
>  /// use kernel::error::Result;
>  /// use kernel::opp::{OPP, SearchType, Table};
> -/// use kernel::types::ARef;
> +/// use kernel::sync::aref::ARef;
>  ///
>  /// fn find_opp(table: &Table, freq: Hertz) -> Result<ARef<OPP>> {
>  ///     let opp =3D table.opp_from_freq(freq, Some(true), None, SearchTy=
pe::Exact)?;
> @@ -335,7 +336,7 @@ fn drop(&mut self) {
>  /// use kernel::error::Result;
>  /// use kernel::opp::{Config, ConfigOps, ConfigToken};
>  /// use kernel::str::CString;
> -/// use kernel::types::ARef;
> +/// use kernel::sync::aref::ARef;
>  /// use kernel::macros::vtable;
>  ///
>  /// #[derive(Default)]
> @@ -581,7 +582,7 @@ extern "C" fn config_regulators(
>  /// use kernel::device::Device;
>  /// use kernel::error::Result;
>  /// use kernel::opp::Table;
> -/// use kernel::types::ARef;
> +/// use kernel::sync::aref::ARef;
>  ///
>  /// fn get_table(dev: &ARef<Device>, mask: &mut Cpumask, freq: Hertz) ->=
 Result<Table> {
>  ///     let mut opp_table =3D Table::from_of_cpumask(dev, mask)?;
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 5ce07999168e..7c17c937de59 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -14,7 +14,8 @@
>      io::Io,
>      io::IoRaw,
>      str::CStr,
> -    types::{ARef, ForeignOwnable, Opaque},
> +    sync::aref::ARef,
> +    types::{ForeignOwnable, Opaque},
>      ThisModule,
>  };
>  use core::{
> @@ -438,7 +439,7 @@ pub fn set_master(&self) {
>  kernel::impl_device_context_into_aref!(Device);
>
>  // SAFETY: Instances of `Device` are always reference-counted.
> -unsafe impl crate::types::AlwaysRefCounted for Device {
> +unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
>          unsafe { bindings::pci_dev_get(self.as_raw()) };
> diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
> index 0e93808e4639..979a9718f153 100644
> --- a/rust/kernel/pid_namespace.rs
> +++ b/rust/kernel/pid_namespace.rs
> @@ -7,10 +7,7 @@
>  //! C header: [`include/linux/pid_namespace.h`](srctree/include/linux/pi=
d_namespace.h) and
>  //! [`include/linux/pid.h`](srctree/include/linux/pid.h)
>
> -use crate::{
> -    bindings,
> -    types::{AlwaysRefCounted, Opaque},
> -};
> +use crate::{bindings, sync::aref::AlwaysRefCounted, types::Opaque};
>  use core::ptr;
>
>  /// Wraps the kernel's `struct pid_namespace`. Thread safe.
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index e894790c510c..1c136341b670 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -198,7 +198,7 @@ fn as_raw(&self) -> *mut bindings::platform_device {
>  kernel::impl_device_context_into_aref!(Device);
>
>  // SAFETY: Instances of `Device` are always reference-counted.
> -unsafe impl crate::types::AlwaysRefCounted for Device {
> +unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
>          unsafe { bindings::get_device(self.as_ref().as_raw()) };
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 927413d85484..b46488f6d1a8 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -9,7 +9,8 @@
>      ffi::{c_int, c_long, c_uint},
>      mm::MmWithUser,
>      pid_namespace::PidNamespace,
> -    types::{ARef, NotThreadSafe, Opaque},
> +    sync::aref::ARef,
> +    types::{NotThreadSafe, Opaque},
>  };
>  use core::{
>      cmp::{Eq, PartialEq},
> @@ -76,7 +77,7 @@ macro_rules! current {
>  /// incremented when creating `State` and decremented when it is dropped=
:
>  ///
>  /// ```
> -/// use kernel::{task::Task, types::ARef};
> +/// use kernel::{task::Task, sync::aref::ARef};
>  ///
>  /// struct State {
>  ///     creator: ARef<Task>,
> @@ -340,7 +341,7 @@ pub fn active_pid_ns(&self) -> Option<&PidNamespace> =
{
>  }
>
>  // SAFETY: The type invariants guarantee that `Task` is always refcounte=
d.
> -unsafe impl crate::types::AlwaysRefCounted for Task {
> +unsafe impl crate::sync::aref::AlwaysRefCounted for Task {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
>          unsafe { bindings::get_task_struct(self.as_ptr()) };
>
> base-commit: 8ecb65b7b68ea48350833ba59c1257718e859768
> --
> 2.34.1
>

