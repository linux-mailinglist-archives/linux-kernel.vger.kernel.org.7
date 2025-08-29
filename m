Return-Path: <linux-kernel+bounces-792455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F39B3C421
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72CB1C84073
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F7734DCC9;
	Fri, 29 Aug 2025 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="KbXcc+5H"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE041EEA49;
	Fri, 29 Aug 2025 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756501944; cv=pass; b=edjvuFp521rldhFF7eYSuiLVzOe2n9P0Wr2GMj0fAyHJx3y6H3kGX1eCKfOF4urFv+eadyJZgEt5xS3bCamZqLWThPrwRQUn9yAlOai5IBdi0gENtCqb3Qy/PSthSC8FTQMVfcUyViDOajae7VdPJp7P3pkYZwkIII0o9zE57Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756501944; c=relaxed/simple;
	bh=IIUWAVosf84Vc3aZQ2fQ8EZCXYVMr2x5PGHrWDVNg4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XtILxRtvaKF8w2NriKfsbm6lYy964jJHkTnJvpnsPC1XpPwvm+JM45hdLfDMB899F/uRosdpOnvy0zC9yXb6R9UnqfbuKvNzBwiQdI0iPI+7K6cNn/Av6JbE9geHfV+BqEkDSCV1NxAbBV3NcwC4mqd4BMZX3i7o+sIPEVhK4io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=KbXcc+5H; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756501923; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dRs2LrdHqTq7YKqPmkNWD8U0bLZ4bSEJ3nz43mizOz13BPGHIyABxvywwElbagmh64Ur+TcbTrl8v0J+q9a1PbIWK0+uMkIDwGBD7tSO7PVak4q9BkrVe0V+qfoG1r21rhQ0VMOVnt2X/NrQhN20V1HRAglailXrhxk5xpbGLTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756501923; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uUtezq+LZ7Ws3yiBh/zy4oG0wsEbWJ6pHMwpgE2qR/g=; 
	b=GYopPzXAyJBdXWpu+9OUPG3rJJBASkSr7E7IcME0+7gAnpd7KM3P52qjaUJQvy41vEd7YFEnMEEHhruH/qaMWFL1vQ/Ryax/KRhBYpZIA74GJk/ON25buyvs1aPa0DCj787YdunlzBADOZwliOCQTaS6L/PvGqN1a/oFln7sBk4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756501923;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=uUtezq+LZ7Ws3yiBh/zy4oG0wsEbWJ6pHMwpgE2qR/g=;
	b=KbXcc+5HBaNSaB8BEju41DoPz6twD18oBQxLh9t8kYyqYr5xGlzbIuShWsmfzLcU
	iOsjlQzDT09POXvz8epS50XzurTCYCrQFgSmGlEVQXjnAZvgxKVesqeZZwwkMmXXDGd
	rrOKZEzZJ76l3EbuQZVot68KKKESh0OY9/zbHcO0=
Received: by mx.zohomail.com with SMTPS id 1756501920131349.5983155234038;
	Fri, 29 Aug 2025 14:12:00 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 29 Aug 2025 18:11:31 -0300
Subject: [PATCH 1/2] rust: regulator: remove Regulator<Dynamic>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-regulator-remove-dynamic-v1-1-deb59205e8e9@collabora.com>
References: <20250829-regulator-remove-dynamic-v1-0-deb59205e8e9@collabora.com>
In-Reply-To: <20250829-regulator-remove-dynamic-v1-0-deb59205e8e9@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

After some experimenting and further discussion, it is starting to look
like Regulator<Dynamic> might be a footgun. It turns out that one can
get the same behavior by correctly using just Regulator<Enabled> and
Regulator<Disabled>, so there is no need to directly expose the manual
refcounting ability of Regulator<Dynamic> to clients.

Remove it while we do not have any other users.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/regulator.rs | 88 +-----------------------------------------------
 1 file changed, 1 insertion(+), 87 deletions(-)

diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index 65f3a125348f2d821898188b4ac6a0b593f18bf2..60993373f4d911f4f0cbec2510f0c67efa24a51b 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -30,7 +30,6 @@ pub trait Sealed {}
 
     impl Sealed for super::Enabled {}
     impl Sealed for super::Disabled {}
-    impl Sealed for super::Dynamic {}
 }
 
 /// A trait representing the different states a [`Regulator`] can be in.
@@ -50,13 +49,6 @@ pub trait RegulatorState: private::Sealed + 'static {
 /// own an `enable` reference count, but the regulator may still be on.
 pub struct Disabled;
 
-/// A state that models the C API. The [`Regulator`] can be either enabled or
-/// disabled, and the user is in control of the reference count. This is also
-/// the default state.
-///
-/// Use [`Regulator::is_enabled`] to check the regulator's current state.
-pub struct Dynamic;
-
 impl RegulatorState for Enabled {
     const DISABLE_ON_DROP: bool = true;
 }
@@ -65,14 +57,9 @@ impl RegulatorState for Disabled {
     const DISABLE_ON_DROP: bool = false;
 }
 
-impl RegulatorState for Dynamic {
-    const DISABLE_ON_DROP: bool = false;
-}
-
 /// A trait that abstracts the ability to check if a [`Regulator`] is enabled.
 pub trait IsEnabled: RegulatorState {}
 impl IsEnabled for Disabled {}
-impl IsEnabled for Dynamic {}
 
 /// An error that can occur when trying to convert a [`Regulator`] between states.
 pub struct Error<State: RegulatorState> {
@@ -183,64 +170,13 @@ pub struct Error<State: RegulatorState> {
 /// }
 /// ```
 ///
-/// ## Using [`Regulator<Dynamic>`]
-///
-/// This example mimics the behavior of the C API, where the user is in
-/// control of the enabled reference count. This is useful for drivers that
-/// might call enable and disable to manage the `enable` reference count at
-/// runtime, perhaps as a result of `open()` and `close()` calls or whatever
-/// other driver-specific or subsystem-specific hooks.
-///
-/// ```
-/// # use kernel::prelude::*;
-/// # use kernel::c_str;
-/// # use kernel::device::Device;
-/// # use kernel::regulator::{Regulator, Dynamic};
-/// struct PrivateData {
-///     regulator: Regulator<Dynamic>,
-/// }
-///
-/// // A fictictious probe function that obtains a regulator and sets it up.
-/// fn probe(dev: &Device) -> Result<PrivateData> {
-///     // Obtain a reference to a (fictitious) regulator.
-///     let mut regulator = Regulator::<Dynamic>::get(dev, c_str!("vcc"))?;
-///
-///     Ok(PrivateData { regulator })
-/// }
-///
-/// // A fictictious function that indicates that the device is going to be used.
-/// fn open(dev: &Device, data: &mut PrivateData) -> Result {
-///     // Increase the `enabled` reference count.
-///     data.regulator.enable()?;
-///
-///     Ok(())
-/// }
-///
-/// fn close(dev: &Device, data: &mut PrivateData) -> Result {
-///     // Decrease the `enabled` reference count.
-///     data.regulator.disable()?;
-///
-///     Ok(())
-/// }
-///
-/// fn remove(dev: &Device, data: PrivateData) -> Result {
-///     // `PrivateData` is dropped here, which will drop the
-///     // `Regulator<Dynamic>` in turn.
-///     //
-///     // The reference that was obtained by `regulator_get()` will be
-///     // released, but it is up to the user to make sure that the number of calls
-///     // to `enable()` and `disabled()` are balanced before this point.
-///     Ok(())
-/// }
-/// ```
-///
 /// # Invariants
 ///
 /// - `inner` is a non-null wrapper over a pointer to a `struct
 ///   regulator` obtained from [`regulator_get()`].
 ///
 /// [`regulator_get()`]: https://docs.kernel.org/driver-api/regulator.html#c.regulator_get
-pub struct Regulator<State = Dynamic>
+pub struct Regulator<State>
 where
     State: RegulatorState,
 {
@@ -354,28 +290,6 @@ pub fn try_into_disabled(self) -> Result<Regulator<Disabled>, Error<Enabled>> {
     }
 }
 
-impl Regulator<Dynamic> {
-    /// Obtains a [`Regulator`] instance from the system. The current state of
-    /// the regulator is unknown and it is up to the user to manage the enabled
-    /// reference count.
-    ///
-    /// This closely mimics the behavior of the C API and can be used to
-    /// dynamically manage the enabled reference count at runtime.
-    pub fn get(dev: &Device, name: &CStr) -> Result<Self> {
-        Regulator::get_internal(dev, name)
-    }
-
-    /// Increases the `enabled` reference count.
-    pub fn enable(&mut self) -> Result {
-        self.enable_internal()
-    }
-
-    /// Decreases the `enabled` reference count.
-    pub fn disable(&mut self) -> Result {
-        self.disable_internal()
-    }
-}
-
 impl<T: IsEnabled> Regulator<T> {
     /// Checks if the regulator is enabled.
     pub fn is_enabled(&self) -> bool {

-- 
2.51.0


