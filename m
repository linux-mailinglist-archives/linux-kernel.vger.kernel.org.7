Return-Path: <linux-kernel+bounces-873611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 102DEC14428
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 382005628E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A66A30C635;
	Tue, 28 Oct 2025 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ne7pXCTC"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6B30B519
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648933; cv=none; b=W/zNrz6HRD+7fID52ITsxJYPjOberpC94mV1G24yIi2Y00MybgZs7x+rcFtKbthDVBd1Iw46SyCuH1o9sKFWUYEY15KIgr7rS3ep+kl/Qq2f3k58ARHmJbSdcSn9Pn7YZyV8Sit7/qCxyvp+iJjBxzzZshqH4g+2qGI9QaLaAx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648933; c=relaxed/simple;
	bh=mKyR9/h7rlG7KiZjyzS5QxeqgESuhech2GJoN8dGoVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ajir69zRjUu2XTlmOJIDSu3wnWvV3jwINaQ1kiMFj8TuiSdw32LCKIf++Hi1Ld5MwZjSsGdjIlRSu9sMxVANJvRVVNzFCW14jRK8XA1edqIBc8Q8t7S8AZ9lNjxC+2Z6m2gPltc69PwRuNibOwiJloB97qeRCot4/RuX56rQJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ne7pXCTC; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-475dabb63f2so13634395e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761648930; x=1762253730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n9exySn0FhaBtD6aPkK902goSNi5LE/rsvaCxJ4AAlk=;
        b=Ne7pXCTC+OR64XGqUhcTwqvuEsmCkZ7XBoqJSd8vh3XY9Qwu54NMXPRvrdxiXshGE0
         UIXHflQPBz47qZ6sDWzHwhguswqP6F43ThjMEtDgA1hl0RDG9YJMKDLFXGHiFUUPmtlx
         1JWw+BdPMJkKOK82W8kP6HiEBs1F0o5STCAm17HFJZgeuCcC1rtqxHLrjLhIb7k4O0Ji
         TR7igLFV84CtrtFY/e3nkMHqqd9OxbifnaePHkIhJabq21CA/rDMewBeTPu1PERjs0/2
         WnjjcP9bUS+5RvPJW6h9h545PSR6Ec3cWuFMjkn+6BhYJi2Yp4xstYaOUDlPOpNsfCMt
         uJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648930; x=1762253730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9exySn0FhaBtD6aPkK902goSNi5LE/rsvaCxJ4AAlk=;
        b=v2XznbmDnhACjEjGiyLI80iCc4v5fZha1WwAZbFqF+vi5J6ru+gA1ASCV7OjFqE3zU
         H4FxgheW+XFvNCsT6hLjQ7vWsDPkgqExhXdwvmWdLM67OKIF/WkmwdPYlZbgLqgy75lW
         FFU0mc+01LWNbp5QID0AkQ3VBLg3d2yotYuTAD7ZKqZfYlF5ced13rm95jAlHXcdMrF/
         vi1FgPkiecoKz7ZlyaoScCsTdJ9QkZQTSkQkcQ4/TkGqa3WOhQmsMyuMTAu6QvkmE4D3
         LcOttc2fQUsFDYXCug/Pyj9WuugTLQmMM3Z5s2GN+inxzCmr0nSL+mfyJn2StzQBw0IH
         qgYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmOUu76Vpg9EnogihIUAhhF6wQjUJtMXZ4ydxV9NGe2bXu2CDXuz1as1wHBqCcwQ2zmVe5/nV8ltDA2pM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ZrDJp2F5ma4tSezNSUuF2HBMIx3ogLXNRrgNQA1tc22PIVyl
	yGFc1NFWxycODy48UGnSxZulYi/WuFTbBglyhvtNEb23M10JsVYk5RT58oNVTZK/NZo/RJfEqG7
	/DXB7ggglgtT8pPM1EA==
X-Google-Smtp-Source: AGHT+IGBGsazRL54FZwV9R3EStOOg/ha2XSfRRiPYubsZPxrgejlBZWmFz3G/PdUeaNC1qLhaOWWWtWRy9V8zww=
X-Received: from wmbiv8.prod.google.com ([2002:a05:600c:5488:b0:477:1186:dfaf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e4b:b0:471:13fc:e356 with SMTP id 5b1f17b1804b1-47717def78cmr26198225e9.3.1761648929762;
 Tue, 28 Oct 2025 03:55:29 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:55:17 +0000
In-Reply-To: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4579; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=mKyR9/h7rlG7KiZjyzS5QxeqgESuhech2GJoN8dGoVw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpAKEbI64GJwTDLy8qUysgob6rTWmZt9rhINssF
 1/Vgg0grAiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaQChGwAKCRAEWL7uWMY5
 RvOlEACtUDd/QdwUS7owdfpd9PpxRihEgoSppAXrCHcE6pkuyXny15p5Jc4QorveoZekgK1vZdO
 1pjtSw0HSRKe9oBndWd0TsQrEeoqQuYIh1dom6wN1Vq3sEUe2mNrd5lmBbijq+6V8KssLvgpT99
 cAaayRaS78ZGb9vP+dIuZSZrJ7QQyqYKS0EPkFDoCGAk7641y5nRnmFDX7EUMtuUvqIVNjWA55b
 Q9ReryCdM0nzG63+w4sF1fOxp3RBwSj8/bvvDxbrWGoElLP6N3l236h4Xhb/aET05lBBmjZu+CU
 L/TJexmt0Qz2mlDaWuG2FRO76YNwopKZUWCbOxC8cOPzK9bTdas/ydqDD7C0fsdcmkGmnAEXFnQ
 qP4Litp2XOCHpUxI8qzzHNgN53v5ab5kyaHsGP4QncpVTSioQREK13KOEGZMkqoTUzFHOqZs3OE
 qRyuHRQZ9nHwjItat0a0UvBGSjkV5rof7PH5PMWYykSg2uopHpZnoc6Uj+gyTto4BAYa65biwzh
 H+2vWV9mehnsaJotev+Pilefa3I19IL91CGUV4TU17Oq/WW4yiXhg2suwP0nflFeuu3tCXXCedX
 xtUdyettXLm5S/83kbFSbmAU8LZ7QPNQiLSTug7k6LohYaUy0yLHpaDDD4TwjIp8bdk67QHXlSg 8r4jjzXI7n74Yvw==
X-Mailer: b4 0.14.2
Message-ID: <20251028-binder-bitmap-v3-4-32822d4b3207@google.com>
Subject: [PATCH v3 4/5] rust: id_pool: do not immediately acquire new ids
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When Rust Binder assigns a new ID, it performs various fallible
operations before it "commits" to actually using the new ID. To support
this pattern, change acquire_next_id() so that it does not immediately
call set_bit(), but instead returns an object that may be used to call
set_bit() later.

The UnusedId type holds a exclusive reference to the IdPool, so it's
guaranteed that nobody else can call find_unused_id() while the UnusedId
object is live.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/id_pool.rs | 67 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index d53628a357ed84a6e00ef9dfd03a75e85a87532c..e5651162db084f5dc7c16a493aa69ee253fe4885 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -25,24 +25,24 @@
 /// Basic usage
 ///
 /// ```
-/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
-/// use kernel::id_pool::IdPool;
+/// use kernel::alloc::AllocError;
+/// use kernel::id_pool::{IdPool, UnusedId};
 ///
 /// let mut pool = IdPool::new();
 /// let cap = pool.capacity();
 ///
 /// for i in 0..cap {
-///     assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
+///     assert_eq!(i, pool.find_unused_id(i).ok_or(ENOSPC)?.acquire());
 /// }
 ///
 /// pool.release_id(5);
-/// assert_eq!(5, pool.acquire_next_id(0).ok_or(ENOSPC)?);
+/// assert_eq!(5, pool.find_unused_id(0).ok_or(ENOSPC)?.acquire());
 ///
-/// assert_eq!(None, pool.acquire_next_id(0));  // time to realloc.
+/// assert!(pool.find_unused_id(0).is_none());  // time to realloc.
 /// let resizer = pool.grow_request().ok_or(ENOSPC)?.realloc(GFP_KERNEL)?;
 /// pool.grow(resizer);
 ///
-/// assert_eq!(pool.acquire_next_id(0), Some(cap));
+/// assert_eq!(pool.find_unused_id(0).ok_or(ENOSPC)?.acquire(), cap);
 /// # Ok::<(), Error>(())
 /// ```
 ///
@@ -56,8 +56,8 @@
 /// fn get_id_maybe_realloc(guarded_pool: &SpinLock<IdPool>) -> Result<usize, AllocError> {
 ///     let mut pool = guarded_pool.lock();
 ///     loop {
-///         match pool.acquire_next_id(0) {
-///             Some(index) => return Ok(index),
+///         match pool.find_unused_id(0) {
+///             Some(index) => return Ok(index.acquire()),
 ///             None => {
 ///                 let alloc_request = pool.grow_request();
 ///                 drop(pool);
@@ -187,18 +187,17 @@ pub fn grow(&mut self, mut resizer: PoolResizer) {
         self.map = resizer.new;
     }
 
-    /// Acquires a new ID by finding and setting the next zero bit in the
-    /// bitmap.
+    /// Finds an unused ID in the bitmap.
     ///
     /// Upon success, returns its index. Otherwise, returns [`None`]
     /// to indicate that a [`Self::grow_request`] is needed.
     #[inline]
-    pub fn acquire_next_id(&mut self, offset: usize) -> Option<usize> {
-        let next_zero_bit = self.map.next_zero_bit(offset);
-        if let Some(nr) = next_zero_bit {
-            self.map.set_bit(nr);
-        }
-        next_zero_bit
+    #[must_use]
+    pub fn find_unused_id(&mut self, offset: usize) -> Option<UnusedId<'_>> {
+        Some(UnusedId {
+            id: self.map.next_zero_bit(offset)?,
+            pool: self,
+        })
     }
 
     /// Releases an ID.
@@ -208,6 +207,42 @@ pub fn release_id(&mut self, id: usize) {
     }
 }
 
+/// Represents an unused id in an [`IdPool`].
+pub struct UnusedId<'pool> {
+    id: usize,
+    pool: &'pool mut IdPool,
+}
+
+impl<'pool> UnusedId<'pool> {
+    /// Get the unused id as an usize.
+    ///
+    /// Be aware that the id has not yet been acquired in the pool. The
+    /// [`acquire`] method must be called to prevent others from taking the id.
+    #[inline]
+    #[must_use]
+    pub fn as_usize(&self) -> usize {
+        self.id
+    }
+
+    /// Get the unused id as an u32.
+    ///
+    /// Be aware that the id has not yet been acquired in the pool. The
+    /// [`acquire`] method must be called to prevent others from taking the id.
+    #[inline]
+    #[must_use]
+    pub fn as_u32(&self) -> u32 {
+        // CAST: The maximum possible value in an IdPool is i32::MAX.
+        self.id as u32
+    }
+
+    /// Acquire the unused id.
+    #[inline]
+    pub fn acquire(self) -> usize {
+        self.pool.map.set_bit(self.id);
+        self.id
+    }
+}
+
 impl Default for IdPool {
     #[inline]
     fn default() -> Self {

-- 
2.51.1.838.g19442a804e-goog


