Return-Path: <linux-kernel+bounces-749722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28739B15219
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25677168524
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE1229992B;
	Tue, 29 Jul 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RfHCFh0J"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF77298981;
	Tue, 29 Jul 2025 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810336; cv=none; b=lH6FInrr8WiU20Gx5dlz7cDaFHMm6TvXC1JrG0dqg98GjLW4wlSUF4TDibQmgX6Agii6Cbm3fBVA1oeF9c9Pcnu0p2FSCzciyoDfkl+m9cGIJejJ/EWKINaUca9kWeDifBT7qs7GFU9dzM4Hths+TNCxLzfyw0mBW7SVMa/Y+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810336; c=relaxed/simple;
	bh=Oj4lRpToTiwjV+8i7TobinzVjwDho+X4zuQNTzFsO9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f85H+g+qYMe3k/v0NnrsHj1Zt9KaUer+ySX5UciTiJwrXRy0JiWH1S8qOpfTQrAec60iYhSS4zwZraWpsgSa2e4h0PfVJg2VtJxuUsLFu7ZGWuyjCfCYYXgZaL5sFFff7B0c2La6TSeaeYSIHTRCVxm0AeSXwt29qR1e7JsajM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RfHCFh0J; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753810332;
	bh=Oj4lRpToTiwjV+8i7TobinzVjwDho+X4zuQNTzFsO9E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RfHCFh0J3kSxDqAZOrX85qUrFJj+QvT40B6cASJSKeH8MDSSMjpdqoMMOS4lRSyM6
	 JcSK/9vAuD27jWweqib+vVd/gHjxZq3RYildi5iRApE+Yw4jq3+P+XAki1YXHUyCQT
	 GhHs0mNi7hG7bf+NQmfUtQxOVt362wIBV7ez4IxmZ+Ln4NJ48aIGacGpixbrZD27I3
	 mpjd5Nprbgc12oqtdcGSuzr9BXIP3mgNzwSda4d1a4GL63CvFOQ7AJa/ypP76yINaL
	 PFS8biNxUwBnFUfEBOa2eeVvOCzjvphN96d8++gOiM5e7EzXLD6eFyROV4nGChJfcN
	 3xknkMe9AZJMQ==
Received: from [192.168.0.7] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 400A617E14DB;
	Tue, 29 Jul 2025 19:32:10 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 29 Jul 2025 14:31:40 -0300
Subject: [PATCH 1/2] rust: regulator: remove needless &mut from member
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-regulator-send-sync-v1-1-8bcbd546b940@collabora.com>
References: <20250729-regulator-send-sync-v1-0-8bcbd546b940@collabora.com>
In-Reply-To: <20250729-regulator-send-sync-v1-0-8bcbd546b940@collabora.com>
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

Regulator functions like "regulator_enable()" and "regulator_disable()"
already provide their own locking through "regulator_lock_dependent()", so
we can safely call the Rust API with a shared reference.

This was already the case with Regulator::set_voltage() on the Rust side,
but it was forgotten for Regulator::enable() and Regulator::disable().

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/regulator.rs | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index 65f3a125348f2d821898188b4ac6a0b593f18bf2..d56aa229e838c45258a27cea742a693dd71e8e40 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -203,20 +203,20 @@ pub struct Error<State: RegulatorState> {
 /// // A fictictious probe function that obtains a regulator and sets it up.
 /// fn probe(dev: &Device) -> Result<PrivateData> {
 ///     // Obtain a reference to a (fictitious) regulator.
-///     let mut regulator = Regulator::<Dynamic>::get(dev, c_str!("vcc"))?;
+///     let regulator = Regulator::<Dynamic>::get(dev, c_str!("vcc"))?;
 ///
 ///     Ok(PrivateData { regulator })
 /// }
 ///
 /// // A fictictious function that indicates that the device is going to be used.
-/// fn open(dev: &Device, data: &mut PrivateData) -> Result {
+/// fn open(dev: &Device, data: &PrivateData) -> Result {
 ///     // Increase the `enabled` reference count.
 ///     data.regulator.enable()?;
 ///
 ///     Ok(())
 /// }
 ///
-/// fn close(dev: &Device, data: &mut PrivateData) -> Result {
+/// fn close(dev: &Device, data: &PrivateData) -> Result {
 ///     // Decrease the `enabled` reference count.
 ///     data.regulator.disable()?;
 ///
@@ -289,12 +289,12 @@ fn get_internal(dev: &Device, name: &CStr) -> Result<Regulator<T>> {
         })
     }
 
-    fn enable_internal(&mut self) -> Result {
+    fn enable_internal(&self) -> Result {
         // SAFETY: Safe as per the type invariants of `Regulator`.
         to_result(unsafe { bindings::regulator_enable(self.inner.as_ptr()) })
     }
 
-    fn disable_internal(&mut self) -> Result {
+    fn disable_internal(&self) -> Result {
         // SAFETY: Safe as per the type invariants of `Regulator`.
         to_result(unsafe { bindings::regulator_disable(self.inner.as_ptr()) })
     }
@@ -310,7 +310,7 @@ pub fn get(dev: &Device, name: &CStr) -> Result<Self> {
     pub fn try_into_enabled(self) -> Result<Regulator<Enabled>, Error<Disabled>> {
         // We will be transferring the ownership of our `regulator_get()` count to
         // `Regulator<Enabled>`.
-        let mut regulator = ManuallyDrop::new(self);
+        let regulator = ManuallyDrop::new(self);
 
         regulator
             .enable_internal()
@@ -339,7 +339,7 @@ pub fn get(dev: &Device, name: &CStr) -> Result<Self> {
     pub fn try_into_disabled(self) -> Result<Regulator<Disabled>, Error<Enabled>> {
         // We will be transferring the ownership of our `regulator_get()` count
         // to `Regulator<Disabled>`.
-        let mut regulator = ManuallyDrop::new(self);
+        let regulator = ManuallyDrop::new(self);
 
         regulator
             .disable_internal()
@@ -366,12 +366,12 @@ pub fn get(dev: &Device, name: &CStr) -> Result<Self> {
     }
 
     /// Increases the `enabled` reference count.
-    pub fn enable(&mut self) -> Result {
+    pub fn enable(&self) -> Result {
         self.enable_internal()
     }
 
     /// Decreases the `enabled` reference count.
-    pub fn disable(&mut self) -> Result {
+    pub fn disable(&self) -> Result {
         self.disable_internal()
     }
 }

-- 
2.50.0


