Return-Path: <linux-kernel+bounces-792454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C30CB3C420
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5413A619D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B7334AAFB;
	Fri, 29 Aug 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="W0y44hMY"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4D346A0E;
	Fri, 29 Aug 2025 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756501942; cv=pass; b=RmdPpYviqBVW6P41sg4VJkS58u7Zocdj4XuefStIrUxGCJlUBpMoNhUZRCAYeC8Z64332Fh6nCH9BkP8IUzLOp/U6l0NpVdLteK5azPC8qCCgoITg9SVD8+Hsi6W5BT3h++sZnASyuRoRRx9OC5knjohc6/2txIptBlCrUUUCS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756501942; c=relaxed/simple;
	bh=ItWpvm4bGwoKXd7BDzJgsgm7des1fGWWNf8eydo67QY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WXtdiVks86EGsvrbc1NT/ba0qr7AFHmSlYDtpzmdKie+9K2hgS9IjdVInF5wD4nItZ2c/eFBNm3ZKnj2icMhOrC+KRUN9FGe8Ut2CUu68X3AP7xoXbXYMupKl6T94jFGPlQyb8UKO+poRdEQpUCHF5I4++gVbXlBK59TJvvPe4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=W0y44hMY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756501927; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Tj1+pNltDF4rLBYKGK8AFrnv4JZ8QzQkmNYJMi1apllwDTH92J//jH+HDcUX09nMRih4G1E4bwmxB8BNh30AQMtNwwGyRcmEeQk6sDhaeYify1ActtcOikI45iN2oGbGeoH2ry1fuaZm+hQrsJvY9fW2xuNQaKqV9q1SdK3/CrI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756501927; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OAdnPymjRmAyyFEKwSL0amv/o6XCe9TnJ/NMzqx/8EA=; 
	b=HNc3M8GRI2xD/WSFaFuMFn8Aypaqm0x2h8KsWF7pv9UTX1XS25ekD4pqN3JPbbXNKRWAKCPjVr+JpNhFyoufVudPTk7DACmlz5YxK2c6H59hfzia6xSROlxWCcMnhlq9rSMYZ1mJQd6Fz9wRJAihS1YaPvnz7HlQv3KGkwl+8Ug=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756501927;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=OAdnPymjRmAyyFEKwSL0amv/o6XCe9TnJ/NMzqx/8EA=;
	b=W0y44hMYI/+7S6fcdzVzVdLLspe2BJblDBiaB8tlYhVAvylcV3c92sIA/WDMSp40
	/5rrHTzCedZEfbvwwNOhXg0wjbsI9WfhAusXyRC7bC5GhKeEZz9COtUf33+75O/ooD3
	GBXlKoEjoTgGLOFXKXrop2SlKyxErUSrf5NDNhpM=
Received: by mx.zohomail.com with SMTPS id 175650192416034.151306544894396;
	Fri, 29 Aug 2025 14:12:04 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 29 Aug 2025 18:11:32 -0300
Subject: [PATCH 2/2] rust: regulator: add devm_regulator_get_enable API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-regulator-remove-dynamic-v1-2-deb59205e8e9@collabora.com>
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

A lot of drivers only care about enabling the regulator for as long as
the underlying Device is bound. This can be easily observed due to the
extensive use of `devm_regulator_get_enable` and
`devm_regulator_get_enable_optional` throughout the kernel.

Therefore, make this helper available in Rust. Also add an example
noting how it should be the default API unless the driver needs more
fine-grained control over the regulator.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/helpers/regulator.c | 10 ++++++++++
 rust/kernel/regulator.rs | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/rust/helpers/regulator.c b/rust/helpers/regulator.c
index cd8b7ba648ee33dd14326c9242fb6c96ab8e32a7..11bc332443bd064f4b5afd350ffc045badff9076 100644
--- a/rust/helpers/regulator.c
+++ b/rust/helpers/regulator.c
@@ -40,4 +40,14 @@ int rust_helper_regulator_is_enabled(struct regulator *regulator)
 	return regulator_is_enabled(regulator);
 }
 
+int rust_helper_devm_regulator_get_enable(struct device *dev, const char *id)
+{
+	return devm_regulator_get_enable(dev, id);
+}
+
+int rust_helper_devm_regulator_get_enable_optional(struct device *dev, const char *id)
+{
+	return devm_regulator_get_enable_optional(dev, id);
+}
+
 #endif
diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index 60993373f4d911f4f0cbec2510f0c67efa24a51b..73d4c9b56dca9c676793d78e35e5758d18eef3e8 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -18,7 +18,7 @@
 
 use crate::{
     bindings,
-    device::Device,
+    device::{Bound, Device},
     error::{from_err_ptr, to_result, Result},
     prelude::*,
 };
@@ -70,6 +70,26 @@ pub struct Error<State: RegulatorState> {
     pub regulator: Regulator<State>,
 }
 
+/// Enables a regulator whose lifetime is tied to the lifetime of `dev`.
+///
+/// This calls `regulator_disable()` and `regulator_put()` automatically on
+/// driver detach.
+///
+/// This API is identical to `devm_regulator_get_enable()`, and should be
+/// preferred if the caller only cares about the regulator being on.
+pub fn enable(dev: &Device<Bound>, name: &CStr) -> Result {
+    // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
+    // string.
+    to_result(unsafe { bindings::devm_regulator_get_enable(dev.as_raw(), name.as_ptr()) })
+}
+
+/// Same as [`enable`], but calls `devm_regulator_get_enable_optional` instead.
+pub fn enable_optional(dev: &Device<Bound>, name: &CStr) -> Result {
+    // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
+    // string.
+    to_result(unsafe { bindings::devm_regulator_get_enable_optional(dev.as_raw(), name.as_ptr()) })
+}
+
 /// A `struct regulator` abstraction.
 ///
 /// # Examples
@@ -146,6 +166,26 @@ pub struct Error<State: RegulatorState> {
 /// }
 /// ```
 ///
+/// If a driver only cares about the regulator being on for as long it is bound
+/// to a device, then it should use [`regulator::get_enabled`] or
+/// [`regulator::get_enabled_optional`]. This should be the default use-case
+/// unless they need more fine-grained control over the regulator's state.
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::c_str;
+/// # use kernel::device::{Bound, Device};
+/// # use kernel::regulator;
+/// fn enable(dev: &Device<Bound>) -> Result {
+///     // Obtain a reference to a (fictitious) regulator and enable it. This
+///     // call only returns whether the operation succeeded.
+///     regulator::enable(dev, c_str!("vcc"))?;
+///
+///     // The regulator will be disabled and put when `dev` is unbound.
+///     Ok(())
+/// }
+/// ```
+///
 /// ## Disabling a regulator
 ///
 /// ```

-- 
2.51.0


