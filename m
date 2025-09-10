Return-Path: <linux-kernel+bounces-810794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6729B51F81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651485446AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA745338F3B;
	Wed, 10 Sep 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="JvsjEWoS"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86033768C;
	Wed, 10 Sep 2025 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526911; cv=pass; b=HdvE9ufafxo8bBglGWjfWYZl7SGiXLU3GjZLBtgM0cM1baOAUfA45jCiFKmLI0lnQYBDnPgeE8v5dgu4V2EkxJ0kBli5ypqG9XSTFFg5TLAUMKbk36jT4uO9XE6or1lO3rctgeBYDAlDTnC2efTnU/g617MLLILJafWxIfO+Z/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526911; c=relaxed/simple;
	bh=zFj+R5kTMjlxnrXEQAAUt9knfjTPtUoGGaJzG8DXwYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZAippE/5UyX1e/xA7rMRfobuMSwpYa0uo3oOQjVJTJns7JbDoBwlEBX2yfr7PE4Na27cL1c2yIvbs4ltCUEjAvBa7/Z0swmuRQXP+VxSmpQ6j1PW2fcwl5PQCnMMWuUq5g3rfxKKeOJVMgD07+cb/IFu+w57RxGIwB5U8pBJPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=JvsjEWoS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757526892; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LhidXHh7i2yxE0I7roi2e5Lf8aaZ+U7mUIXKX25pect72uJ2ZVjwwa3Kfcy6jHzUf1Va7oUkjsJGQ5vY3W9BKJBc7HHAp6Rb78kyx0KeQgV9S0DAck4mfS9HC3Jh7UmNp2vCwNcXiPal0LX6wYAofAEDy5HeOAXejIUmbUbvV2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757526892; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=euykHIurjP2M1+RFqd36amnFZDpKkvGFVANwdFCrkgY=; 
	b=ZD469Evs+ldzAUX1jTpRhwWKAfAeeMOOV1oZ4W0y040BDde+AHohLJ5uqGUwjboUguaNMqP6XLNnC8/7PSt27IrJm9JWch7+Fd6qJPxF4/0OFTjZBF03/XYUbyk+RLzNfs/g/sc8G4iRzoMaGO8R6kLR5bTvdL7LG6W5IC9ipCU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757526892;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=euykHIurjP2M1+RFqd36amnFZDpKkvGFVANwdFCrkgY=;
	b=JvsjEWoSaI7lPaxRSEA0XhsYCcD4mrDFr+fIkK7HpQZpS3CZF6jhI0NxqH5VQ+sR
	Y5YUfIkx5R6eeup8CFxpadYPiEccuFMLZLh/tWf0zbKYuzB1shNImydjDnvKEpUN309
	3Mc3Qwrz2UF01myyAORClhZLM8/+pAr+GmHXm7oE=
Received: by mx.zohomail.com with SMTPS id 1757526890109158.44175385000972;
	Wed, 10 Sep 2025 10:54:50 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 10 Sep 2025 14:54:31 -0300
Subject: [PATCH v3 1/2] rust: regulator: remove Regulator<Dynamic>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-regulator-remove-dynamic-v3-1-07af4dfa97cc@collabora.com>
References: <20250910-regulator-remove-dynamic-v3-0-07af4dfa97cc@collabora.com>
In-Reply-To: <20250910-regulator-remove-dynamic-v3-0-07af4dfa97cc@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

After some experimenting and further discussion, it is starting to look
like Regulator<Dynamic> might be a footgun. It turns out that one can
get the same behavior by correctly using just Regulator<Enabled> and
Regulator<Disabled>, so there is no need to directly expose the manual
refcounting ability of Regulator<Dynamic> to clients.

Remove it while we do not have any other users.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/regulator.rs | 88 +-----------------------------------------------
 1 file changed, 1 insertion(+), 87 deletions(-)

diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index 34bb24ec8d4d436437d92a344c61fc3a46de0b5d..5ea2307f02df4a10c1c8c07b3b8c134d13519b69 100644
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
-///     let regulator = Regulator::<Dynamic>::get(dev, c_str!("vcc"))?;
-///
-///     Ok(PrivateData { regulator })
-/// }
-///
-/// // A fictictious function that indicates that the device is going to be used.
-/// fn open(dev: &Device, data: &PrivateData) -> Result {
-///     // Increase the `enabled` reference count.
-///     data.regulator.enable()?;
-///
-///     Ok(())
-/// }
-///
-/// fn close(dev: &Device, data: &PrivateData) -> Result {
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
@@ -351,28 +287,6 @@ pub fn try_into_disabled(self) -> Result<Regulator<Disabled>, Error<Enabled>> {
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
-    pub fn enable(&self) -> Result {
-        self.enable_internal()
-    }
-
-    /// Decreases the `enabled` reference count.
-    pub fn disable(&self) -> Result {
-        self.disable_internal()
-    }
-}
-
 impl<T: IsEnabled> Regulator<T> {
     /// Checks if the regulator is enabled.
     pub fn is_enabled(&self) -> bool {

-- 
2.51.0


