Return-Path: <linux-kernel+bounces-883583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43CEC2DCCA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC25518962F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CECB20C001;
	Mon,  3 Nov 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdrgL0XK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A6FBA45;
	Mon,  3 Nov 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196830; cv=none; b=KnlvBiTVR1TCIU6NYeRdibOP/kAXu1WYIjjcOcez+f6Lw9BeLcc0p0xzjHvdMwc2KFeq0sZ2Q9U6hSn9l3vEMGksfIV+ZmI1O7FY5V4J4GUWanScStV/d62o8Kr/bc4YFvHVgIM+P8SyNfRJ4DO/HihcC05PZciaSgsVaoa43EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196830; c=relaxed/simple;
	bh=UQobyf8g0KLDJMuQrsKIqIr661VqCgE6LzrYkepQlNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4wJW2edv/BOusK57CALdlep1Nk1ErrVBxxhfzdexaEAFzjib8A3qxv/ePYfwOBKCr9YYaMc1CnzV0JEZ0ynUEGm+U2UKjuy781uCp8RAJVFdqrHhQOvWcu5hM8FxSJ4OSVy9oSNpONHKqLXqZ1W3jJM+NHxUFY85gxIuv3XGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdrgL0XK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54AAC4CEE7;
	Mon,  3 Nov 2025 19:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762196829;
	bh=UQobyf8g0KLDJMuQrsKIqIr661VqCgE6LzrYkepQlNw=;
	h=From:To:Cc:Subject:Date:From;
	b=DdrgL0XKTbFh5OMJqsCjgIZpbjlkEbH1KZN0GvKx+lRwMFyDz8zcn+WRTirL1y7Bh
	 kRsT+yjUzQIp0QjLy0dc7n2xzGcKGk6/oNT0KHh92VMn9l0Yld0muaDSggg3n0Ly6Y
	 esg+WPsB955UeSvwg3HOK+66T9jcK3jQqHB7CcpAdsL4+OeSe1S0AJzJzME6u3gttN
	 hAIK97anDN30l6L6NpQlhRKonlNN93n24Pz1sBZxQxH889wyHQyOdIvy3T+NnuIw1w
	 zDxG0cUelWXA+a70KiKqdtmG2OM3ciTqZxo9a9YDh7r+XpPJAl1w2X1+EBijwYUVNW
	 xGCIJpxKOLJ0A==
From: Danilo Krummrich <dakr@kernel.org>
To: abdiel.janulgue@gmail.com,
	daniel.almeida@collabora.com,
	robin.murphy@arm.com,
	a.hindborg@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/2] rust: dma: make use of start_ptr() and start_ptr_mut()
Date: Mon,  3 Nov 2025 20:06:49 +0100
Message-ID: <20251103190655.2326191-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using start_ptr() and start_ptr_mut() has the advantage that we inherit
the requirements the a mutable or immutable reference from those
methods.

Hence, use them instead of self.cpu_addr.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/dma.rs | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 4e0af3e1a3b9..f066cbb53cfa 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -505,7 +505,7 @@ pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
         //   data is also guaranteed by the safety requirements of the function.
         // - `offset + count` can't overflow since it is smaller than `self.count` and we've checked
         //   that `self.count` won't overflow early in the constructor.
-        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset), count) })
+        Ok(unsafe { core::slice::from_raw_parts(self.start_ptr().add(offset), count) })
     }
 
     /// Performs the same functionality as [`CoherentAllocation::as_slice`], except that a mutable
@@ -525,7 +525,7 @@ pub unsafe fn as_slice_mut(&mut self, offset: usize, count: usize) -> Result<&mu
         //   data is also guaranteed by the safety requirements of the function.
         // - `offset + count` can't overflow since it is smaller than `self.count` and we've checked
         //   that `self.count` won't overflow early in the constructor.
-        Ok(unsafe { core::slice::from_raw_parts_mut(self.cpu_addr.add(offset), count) })
+        Ok(unsafe { core::slice::from_raw_parts_mut(self.start_ptr_mut().add(offset), count) })
     }
 
     /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
@@ -557,7 +557,11 @@ pub unsafe fn write(&mut self, src: &[T], offset: usize) -> Result {
         // - `offset + count` can't overflow since it is smaller than `self.count` and we've checked
         //   that `self.count` won't overflow early in the constructor.
         unsafe {
-            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset), src.len())
+            core::ptr::copy_nonoverlapping(
+                src.as_ptr(),
+                self.start_ptr_mut().add(offset),
+                src.len(),
+            )
         };
         Ok(())
     }
@@ -576,7 +580,7 @@ pub fn item_from_index(&self, offset: usize) -> Result<*mut T> {
         // and we've just checked that the range and index is within bounds.
         // - `offset` can't overflow since it is smaller than `self.count` and we've checked
         // that `self.count` won't overflow early in the constructor.
-        Ok(unsafe { self.cpu_addr.add(offset) })
+        Ok(unsafe { self.start_ptr().cast_mut().add(offset) })
     }
 
     /// Reads the value of `field` and ensures that its type is [`FromBytes`].
@@ -637,7 +641,7 @@ fn drop(&mut self) {
             bindings::dma_free_attrs(
                 self.dev.as_raw(),
                 size,
-                self.cpu_addr.cast(),
+                self.start_ptr_mut().cast(),
                 self.dma_handle,
                 self.dma_attrs.as_raw(),
             )
-- 
2.51.0


