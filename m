Return-Path: <linux-kernel+bounces-810795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4EEB51F82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9ACB5445C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB933A020;
	Wed, 10 Sep 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="c9dETBzu"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D928B501;
	Wed, 10 Sep 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526913; cv=pass; b=KIfmuyHTvFTT4AwmiGfceoomeoSIVdX5u8FvtqhwwjcHBzhAi+refuSfZU780FOVDZHKUekDEkNRuwtLCRLDvx3HNUbgWsrqmPdcgJORo9WsNXFxMo8HNPC87auhUw4dC67+qihrxH4ZR5uX/p/5AXCvddA0Uw/D0vxgOhrFevk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526913; c=relaxed/simple;
	bh=y+Vk5IPf5yAXY3Xy6BiDHoJWHile6Cy9+H+G9a3U388=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QagQkzzSozV20wM9yFNnYU54ujJh1fuiZsS44qd1vLhvCd5NbGlgIHU3QmhaoGgLd70Zr2o+QQAUPa8pt9QNiFZ9VY0dnnrlTnpmxy20Q9mNgHaA5FVeE/ElkXFUyMyqsI8IEQGQUmjaAdq8k46RHXAwmc3J9K51kBnEtWfx4v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=c9dETBzu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757526896; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kjzBnca2hLI5URWNWxH7CM4COzQ3XKoIYKajHHxDkvQ9wjEzil44Ua+wq3EHPJLYfawTjAr67TfIY1C53HyXmG1tUgl+kyxcewluvJ9KfijKYOcEtOrUaHxtVOT4rVYcxLiCEmnJdrlPRA0GtyQybAcYYNISsoxLCqU+1qAewGI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757526896; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oHmbwbkQQvKLhyz4wCp3NOMYVa7zCDTSqMwuifJeQ4I=; 
	b=ITWNLCwAjBspmUcTZASJZhdyKW3UGVbJnJhq8wf4XsaaPZYZDi/vt/P9BHwEEM3Q9h47nC82ztqFfcH6FxNKO5YZfC1LEL/f1WCJthiYSQRElH+5JNjrGbswRKQhhwFba5g4BPI3Q9+CXsBCHnQAiQz1IByruNPJ+0REf8xMPds=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757526896;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=oHmbwbkQQvKLhyz4wCp3NOMYVa7zCDTSqMwuifJeQ4I=;
	b=c9dETBzuNM0e8PJCV7e0gFeM+YXqzmwXObpKwHkaPxPtrJ7VM7cBYz8Bst6B6o04
	qc9W1fLrFHXF4vBvLO9nz9/PLBMisTIkk13ONwhvYdMJN+jWysh/hrlpw0M1gfEb1U2
	5uNhddBYpbcHonLhyknfg7PzyXRnRXEaUCKa7LCk=
Received: by mx.zohomail.com with SMTPS id 1757526894359276.53351403212207;
	Wed, 10 Sep 2025 10:54:54 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 10 Sep 2025 14:54:32 -0300
Subject: [PATCH v3 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-regulator-remove-dynamic-v3-2-07af4dfa97cc@collabora.com>
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

A lot of drivers only care about enabling the regulator for as long as
the underlying Device is bound. This can be easily observed due to the
extensive use of `devm_regulator_get_enable` and
`devm_regulator_get_enable_optional` throughout the kernel.

Therefore, make this helper available in Rust. Also add an example
noting how it should be the default API unless the driver needs more
fine-grained control over the regulator.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/helpers/regulator.c | 10 ++++++++
 rust/kernel/regulator.rs | 60 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)

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
index 5ea2307f02df4a10c1c8c07b3b8c134d13519b69..b55a201e5029fdfbf51d2d54180dc82372d7a571 100644
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
@@ -69,6 +69,41 @@ pub struct Error<State: RegulatorState> {
     /// The regulator that caused the error, so that the operation may be retried.
     pub regulator: Regulator<State>,
 }
+/// Obtains and enables a [`devres`]-managed regulator for a device.
+///
+/// This calls [`regulator_disable()`] and [`regulator_put()`] automatically on
+/// driver detach.
+///
+/// This API is identical to `devm_regulator_get_enable()`, and should be
+/// preferred over the [`Regulator<T: RegulatorState>`] API if the caller only
+/// cares about the regulator being enabled.
+///
+/// [`devres`]: https://docs.kernel.org/driver-api/driver-model/devres.html
+/// [`regulator_disable()`]: https://docs.kernel.org/driver-api/regulator.html#c.regulator_disable
+/// [`regulator_put()`]: https://docs.kernel.org/driver-api/regulator.html#c.regulator_put
+pub fn devm_enable(dev: &Device<Bound>, name: &CStr) -> Result {
+    // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
+    // string.
+    to_result(unsafe { bindings::devm_regulator_get_enable(dev.as_raw(), name.as_ptr()) })
+}
+
+/// Same as [`devm_enable`], but calls `devm_regulator_get_enable_optional`
+/// instead.
+///
+/// This obtains and enables a [`devres`]-managed regulator for a device, but
+/// does not print a message nor provides a dummy if the regulator is not found.
+///
+/// This calls [`regulator_disable()`] and [`regulator_put()`] automatically on
+/// driver detach.
+///
+/// [`devres`]: https://docs.kernel.org/driver-api/driver-model/devres.html
+/// [`regulator_disable()`]: https://docs.kernel.org/driver-api/regulator.html#c.regulator_disable
+/// [`regulator_put()`]: https://docs.kernel.org/driver-api/regulator.html#c.regulator_put
+pub fn devm_enable_optional(dev: &Device<Bound>, name: &CStr) -> Result {
+    // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
+    // string.
+    to_result(unsafe { bindings::devm_regulator_get_enable_optional(dev.as_raw(), name.as_ptr()) })
+}
 
 /// A `struct regulator` abstraction.
 ///
@@ -146,6 +181,29 @@ pub struct Error<State: RegulatorState> {
 /// }
 /// ```
 ///
+/// If a driver only cares about the regulator being on for as long it is bound
+/// to a device, then it should use [`devm_enable`] or [`devm_enable_optional`].
+/// This should be the default use-case unless more fine-grained control over
+/// the regulator's state is required.
+///
+/// [`devm_enable`]: crate::regulator::devm_enable
+/// [`devm_optional`]: crate::regulator::devm_enable_optional
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::c_str;
+/// # use kernel::device::{Bound, Device};
+/// # use kernel::regulator;
+/// fn enable(dev: &Device<Bound>) -> Result {
+///     // Obtain a reference to a (fictitious) regulator and enable it. This
+///     // call only returns whether the operation succeeded.
+///     regulator::devm_enable(dev, c_str!("vcc"))?;
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


