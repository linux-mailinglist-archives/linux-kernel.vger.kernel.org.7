Return-Path: <linux-kernel+bounces-768450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA68B26130
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA17C566EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC263009D2;
	Thu, 14 Aug 2025 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp5S2yv4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D512FFDD0;
	Thu, 14 Aug 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163887; cv=none; b=kYl6bihrIQRhQu2pp8Vo4KMMSrFoU9P7ZOZc7OfKK91+vulKPoZRHStTJmGt1f5J5yt9B39mPct5FdEcc96l8axjGKP4a5+2/2RXWN1JMMXQyWwYIPc/0MycjJNwk8cCgEQB/8CoAzcwZwdw5KWBFUWXg0jjGidmcYNVpal6lKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163887; c=relaxed/simple;
	bh=ocUwJmUV4DPrk44XhGtp1N/hyLx/RWfc2B2O53uRe/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ot2c3JFrIJk0bOcF4DTgxoxq2qId/EnRV4Y5yKT7qjX8dslMZFdpxr9gJmZKwuXKnxjdBJSRbfdfUNLolxQbZyWmS8wBk32kLgo3cTklkQd25yehjnDUpOGsEECiLaW5jmYk9oYTWggOzpcG9kYs6BaUE4Nm0SCWxnVrTIyE/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp5S2yv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C86C4CEED;
	Thu, 14 Aug 2025 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755163887;
	bh=ocUwJmUV4DPrk44XhGtp1N/hyLx/RWfc2B2O53uRe/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gp5S2yv46PXjRqoigxNT0Dc2+0YlZeUCOUEasZi0lmVatV9EQQczmkpEk7oqkniKt
	 29d9LxHIL10cM/QLGOtSyDaGpnzCTdU9KhwuU8a0cMTAnDHN5tT2m+dWxnHsatz2bf
	 HFe7sIyTaplTAFZeteG6tSupz5Xm5aSyiSjHqkF6XnLTJtv2Z4llKBKTcNty616IiR
	 TjFN9EwQ1AQF37gr8vEtyaAmZW6H37ToNos/Qq5+5thXW6t2sknVnXs9fTHiEAabow
	 KtgBzgAfNYwzeiT52QxKTp4WY9N3Ld42ZVNDKRu5zGF0H5MbX/I16/+cEkDGINwzqN
	 Hh4pPcVXU07KQ==
From: Benno Lossin <lossin@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: devicetree@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/11] rust: of: replace `core::mem::zeroed` with `pin_init::zeroed`
Date: Thu, 14 Aug 2025 11:30:33 +0200
Message-ID: <20250814093046.2071971-7-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814093046.2071971-1-lossin@kernel.org>
References: <20250814093046.2071971-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/kernel/of.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index b76b35265df2..6230bbf2ebc1 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -35,9 +35,7 @@ impl DeviceId {
     /// Create a new device id from an OF 'compatible' string.
     pub const fn new(compatible: &'static CStr) -> Self {
         let src = compatible.as_bytes_with_nul();
-        // Replace with `bindings::of_device_id::default()` once stabilized for `const`.
-        // SAFETY: FFI type is valid to be zero-initialized.
-        let mut of: bindings::of_device_id = unsafe { core::mem::zeroed() };
+        let mut of: bindings::of_device_id = pin_init::zeroed();
 
         // TODO: Use `copy_from_slice` once stabilized for `const`.
         let mut i = 0;
-- 
2.50.1


