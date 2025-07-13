Return-Path: <linux-kernel+bounces-729162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3C0B032A1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE2D1898750
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAB12877D9;
	Sun, 13 Jul 2025 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTv21OS2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1CA48;
	Sun, 13 Jul 2025 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752431269; cv=none; b=U88mCF/1pv9pslmFNYRY7yMe1SITXtS8+EI1n9BwBkY6WMuTlhZKhS+Ia5VhA+Gr0+BG5JCO6FnXCbwTg+W9FFRDgUVQS6UxjPs4lQXZPteJPE5PfbEH9GkFKUvxTtR/KMeT3DUUcfxjmXKVJOQqDktuWbK+jR/uaRszuc1s3B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752431269; c=relaxed/simple;
	bh=/+7Do9MTOoGgxMZmUe03BkTOZnlwMDtHiRBMDLyDre0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWtGwr5D9SqAqOWgGWrJfBt8hDA83krc1/eIpZjgPlxeBoTWFjwP3orxj74QPgVpE/201TMh5vb/t1hRIV1Mt7I1x6i/lAusm/kZ7GZcQD7jeK166ZPEy0rp6FXBiEXAe2mk2N4jTc5K6o/pg/Jhni0Tcc8SDx+d5/YF2zcuUYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTv21OS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F397EC4CEE3;
	Sun, 13 Jul 2025 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752431269;
	bh=/+7Do9MTOoGgxMZmUe03BkTOZnlwMDtHiRBMDLyDre0=;
	h=From:To:Cc:Subject:Date:From;
	b=lTv21OS2+CzfwQgiVBMuUndm4N/bqG6uDHY/vnW0mefWeBtlLQkzQP6N+D8scbz3y
	 DHaCYHoX70OnmTxwnlYWE2tVx4v38AxWInLpyOMwI6B15SSiyG1fa3jdRlhT648GIC
	 eeZWvyeW4Tfyv+8MWVDQhp0qomZkVl0IwKjo+QMPqCbKG7moIbrqnd+Synnz3PEtu3
	 5YIF71Kcma+qPkVrBcxlD531fo1p7freCP2KETWCOzCM116D9jMctdf8ufUPqRsJv1
	 8A+nslgCryq4yCzMZwOlq6w5GljXqvb5Ex3Q+/BFsXdaIVPjg4oSHJwQz23LvbT7TC
	 sVHeUTnn06CMA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	m.wilczynski@samsung.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/2] rust: devres: provide an accessor for the device
Date: Sun, 13 Jul 2025 20:26:53 +0200
Message-ID: <20250713182737.64448-1-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide an accessor for the Device a Devres instance has been created
with.

For instance, this is useful when registrations want to provide a
&Device<Bound> for a scope that is protected by Devres.

Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index f43de3d77d61..a8a2d24cac24 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -204,6 +204,11 @@ fn remove_action(&self) -> bool {
         } == 0)
     }
 
+    /// Return a reference of the [`Device`] this [`Devres`] instance has been created with.
+    pub fn device(&self) -> &Device {
+        &self.dev
+    }
+
     /// Obtain `&'a T`, bypassing the [`Revocable`].
     ///
     /// This method allows to directly obtain a `&'a T`, bypassing the [`Revocable`], by presenting

base-commit: 3964d07dd821efe9680e90c51c86661a98e60a0f
-- 
2.50.0


