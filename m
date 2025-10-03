Return-Path: <linux-kernel+bounces-841820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE4CBB851E
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 00:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 481CF348E6A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 22:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D5C2E612F;
	Fri,  3 Oct 2025 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKYlFYek"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6957D27F00E;
	Fri,  3 Oct 2025 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530467; cv=none; b=G6vd+jaE8qgT5/qR7XD7Kd/dsJ06HHOxezYF4+i3YuHUkyVMTyTjJIRlLxBZQpa/ZZfvxliusc3rNyIb5KcUUKyG7KW3NBxryHj8EUyYZTarkmCdNPoNkSOCgobz+/BvvTCWABwf0mILxm5an2f1UjxvsACQRb0TcyHbJnVi9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530467; c=relaxed/simple;
	bh=cesWEHmZ+3NQRP/sufBInnvawZo33gpkGKGDDCg4HlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3mYoq/BuwmaA5Zkjmw0+AncDVVOc6WKVJyAlEFk4eZ/BS0vfqQOTOOED4t6IYOm+E68vxvdqmPSlXJpv/NofQrYyE8q5BuQ0VVIzAFvpzzOqUtrj6SeSW7inXR5TZbAsGOvnvWo5OJOolIZNPBKfgMQYlfs50wsL9NJujKnNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKYlFYek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43262C4CEFB;
	Fri,  3 Oct 2025 22:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759530467;
	bh=cesWEHmZ+3NQRP/sufBInnvawZo33gpkGKGDDCg4HlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aKYlFYekw/MBFMa1LvgCTutwElWGkj5ljCjCxCC4JSY2rOKNhT8xi3UBJEcxzeKJf
	 9oIlW2p+powTRZCQCYtWKUJKw57+eg9LQSCG5tOSWhUcpW0ZOfWDFR6eGEwZfZgb1/
	 GRa93ZNaXBaadVBfdfmgtIq8oxfN8C+VglC5GtXdQuRsIGCuj3bffWsJLIlzKLGWPb
	 XHB3NMGm+uBI0GVhULH0ZM4ZNEnRhUcXARLaj50Ajlpo76TMqmH2knJnmX1qYUvatd
	 SF59I+C9q1vjoHFhjyV0jWS+5rv5CqQKRyjXW+u+3xXOyZmcw08a26bXjaID9qPnrY
	 XrvxLcWO6JsEA==
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
	mmaurer@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/7] rust: uaccess: add UserSliceWriter::write_slice_partial()
Date: Sat,  4 Oct 2025 00:26:39 +0200
Message-ID: <20251003222729.322059-3-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003222729.322059-1-dakr@kernel.org>
References: <20251003222729.322059-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing write_slice() method is a wrapper around copy_to_user() and
expects the user buffer to be larger than the source buffer.

However, userspace may split up reads in multiple partial operations
providing an offset into the source buffer and a smaller user buffer.

In order to support this common case, provide a helper for partial
writes.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/uaccess.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 1b0b57e855c9..11bb8f3265dd 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -451,6 +451,22 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         Ok(())
     }
 
+    /// Writes raw data to this user pointer from a kernel buffer partially.
+    ///
+    /// This is the same as [`Self::write_slice`] but considers the given `offset` into `data` and
+    /// truncates the write to the boundaries of `self` and `data`.
+    ///
+    /// On success, returns the number of bytes written.
+    pub fn write_slice_partial(&mut self, data: &[u8], offset: usize) -> Result<usize> {
+        let end = offset
+            .checked_add(self.len())
+            .ok_or(EINVAL)?
+            .min(data.len());
+
+        data.get(offset..end)
+            .map_or(Ok(0), |src| self.write_slice(src).map(|()| src.len()))
+    }
+
     /// Writes the provided Rust value to this userspace pointer.
     ///
     /// Fails with [`EFAULT`] if the write happens on a bad address, or if the write goes out of
-- 
2.51.0


