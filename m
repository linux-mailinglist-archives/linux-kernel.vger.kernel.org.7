Return-Path: <linux-kernel+bounces-806906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C064B49D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E5D1B27A1B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C5E2F7446;
	Mon,  8 Sep 2025 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="RY+kqgKB"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AE62E92B4;
	Mon,  8 Sep 2025 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757373089; cv=pass; b=HdnZpDdxximNucbM9lhijclRVLPdd22zHaNQT+bFTvU5j9u62yiIjqCcjOxXmV01FuLXjaK/2h4/OqGaTTgOPVy3+85b6XQsbbxT/1D7LWFRIpVFSzqvzd2iCyEY/S2SaEd3VJOu8h2cr2+JQbbzAUj/Oa9M0qN7SXnWZawVsa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757373089; c=relaxed/simple;
	bh=4P3O0JRDIogtTwLhR0MOXt5MOdne0MxiEfPUX45wK8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SoXTpwMx+ii48wsoAeIDuvx3kwK2mMY8e7xCm+W5vRqykn8XNHaGOOEZvaXN5szDXZHmHsHMpWt+m7UUSPqpTH/QEYKK6JKAYklZbXk1moVrrWLAWA1XoAYpZVLCQ+ZLC+MTV5ii3CQrzwKYd1iPuW0M+vQ3n9UlSV31T4hwGFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=RY+kqgKB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757373072; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B2YfTwVJ/Sm3kNvDmkHGHyUJzOETFJYTvywSs4B0lYw27ZxNT10erh7dXvy1dYIbNUuoOM7A3zpmk0wHT7jGGEU4OmwRC0gCMC1wudGYx+8v56Fp+TugboqLrFV1pnQFrZ+ieAL5U1fwOZZ/Ninzt871vdLwi1QlL8Kt5sEk1t4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757373072; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mZds/sNDo5RWYI6EE4Y1XLgDCxsgfuOfTXpd1zdFTJ8=; 
	b=LrKlQZW33/mneUr86crIQaq3+Pc30duGLY+b4Wx3KX0H11IILscg3pMxbzou1kt4FHUyh509hftqaaCdWiKtCdF2ptunYbYq1JCcthNLx3XJoSM5tn+LUXalfxFhkh4G8TCcHGwCV9ksgHAAXvyFvx2frWerGoNB4aZsKfWi21o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757373072;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=mZds/sNDo5RWYI6EE4Y1XLgDCxsgfuOfTXpd1zdFTJ8=;
	b=RY+kqgKBszygPjbVeDZDL92r8W2+ViEkb/sUYTZEJDDyiaFzRUqOAWB+KHr2J4H9
	tqaWIRHYYaVqN+5TLXFOzclH2QZHL0W4EpUcHzEulwF9Q8l1rwgTP36Dx6NVxis+Nhf
	WJY3zqcnpmdv8FZ1sZAAlj7ujCcQ9s0jlXzW3xIM=
Received: by mx.zohomail.com with SMTPS id 1757373069537564.0170375580834;
	Mon, 8 Sep 2025 16:11:09 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 08 Sep 2025 20:10:28 -0300
Subject: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
In-Reply-To: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
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
 rust/helpers/regulator.c | 10 +++++++++
 rust/kernel/regulator.rs | 58 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 1 deletion(-)

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
index 5ea2307f02df4a10c1c8c07b3b8c134d13519b69..d1c8c7308cdd9ae398883ddac52ff093b97764cd 100644
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
@@ -70,6 +70,39 @@ pub struct Error<State: RegulatorState> {
     pub regulator: Regulator<State>,
 }
 
+/// Enables a regulator whose lifetime is tied to the lifetime of `dev` through
+/// [`devres`].
+///
+/// This calls `regulator_disable()` and `regulator_put()` automatically on
+/// driver detach.
+///
+/// This API is identical to `devm_regulator_get_enable()`, and should be
+/// preferred if the caller only cares about the regulator being on.
+///
+/// [`devres`]: https://docs.kernel.org/driver-api/driver-model/devres.html
+pub fn devm_enable(dev: &Device<Bound>, name: &CStr) -> Result {
+    // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
+    // string.
+    to_result(unsafe { bindings::devm_regulator_get_enable(dev.as_raw(), name.as_ptr()) })
+}
+
+/// Same as [`devm_enable`], but calls `devm_regulator_get_enable_optional`
+/// instead.
+///
+/// This enables a regulator whose lifetime is tied to the lifetime of `dev`
+/// through [`devres`], but does not print a message nor provides a dummy if the
+/// regulator is not found.
+///
+/// This calls `regulator_disable()` and `regulator_put()` automatically on
+/// driver detach.
+///
+/// [`devres`]: https://docs.kernel.org/driver-api/driver-model/devres.html
+pub fn devm_enable_optional(dev: &Device<Bound>, name: &CStr) -> Result {
+    // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
+    // string.
+    to_result(unsafe { bindings::devm_regulator_get_enable_optional(dev.as_raw(), name.as_ptr()) })
+}
+
 /// A `struct regulator` abstraction.
 ///
 /// # Examples
@@ -146,6 +179,29 @@ pub struct Error<State: RegulatorState> {
 /// }
 /// ```
 ///
+/// If a driver only cares about the regulator being on for as long it is bound
+/// to a device, then it should use [`devm_enable`] or [`devm_enable_optional`].
+/// This should be the default use-case unless they need more fine-grained
+/// control over the regulator's state.
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


