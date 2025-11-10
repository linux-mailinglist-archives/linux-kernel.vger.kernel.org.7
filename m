Return-Path: <linux-kernel+bounces-893201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00634C46C65
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980871888236
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636313128AA;
	Mon, 10 Nov 2025 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SC8EaUiS"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936DB3126C1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779982; cv=none; b=iPQVkRQPhXQlhw7Ahxtg7Q3aCtV2nbKn5LqEsq7VisyYVuSXdHK/GuGU7xAr8WBOFBwxnS+F02n+I2fpYG5DU9Ma3LT+Fs7UftTh5tlKYVSGsZknq++i/kMLgtPK1N5OqInZUjtrFepdq5r2DXg1YC66EmnIRCsir2L62iQmMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779982; c=relaxed/simple;
	bh=b0mct7fLXCpWtZ5UlM9V32efA0UtDjJ5A0aIjp+AVik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M5KnJEyBXybnRLUZEZZcoyzkTtf6IVo5LQvKGtlH29zaNSiCOgqGEG4sOWsySVhRSpmhZHh9sAqQCSbC0LekkGpCnXN1GufZEzJ/AIbF5iUpUR9zmj40V4EovoqFdHg4NQS4mLLKfZoI0FcAvg6scKq0+tpnGPRBIVw9LiZ/bbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SC8EaUiS; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso15138945e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762779979; x=1763384779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A6UuyAXvOZMvot7FtB2GRmNDvVWwg415dKxaxe3i4KE=;
        b=SC8EaUiSujswPby+ZHtuvihAJOOrcrCpu/XALRXdIMmEoMbdO6k383UH2+vZGY9nKY
         HudWQ1pxKtU8eKb4NVGkA5s6dbkzhDxRjoVJyagn6qfEpkUzNTpq8FjkBdiKmtYrCvO3
         vFfXSfxB+0hHakz3PBDcJrpCO2e6bphuXHC6i5HAkVlA1TwcEY0nvi79SzLS2RkV1fEj
         rnUfG1w0bOjFvUoTJTpxm9X3vCVcmQlWp8iKxfJhsxjhcPz5ePWtTuiTPQbLlzq2oKdN
         C9l4GKqXSvcA0Fc4G3gcxp6iOd03Ne02h6Mfhzem4jLzag5/QcirPomFSj7wO+LhRwbF
         ZutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779979; x=1763384779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6UuyAXvOZMvot7FtB2GRmNDvVWwg415dKxaxe3i4KE=;
        b=T7UaFZD7MsfpdUR6Ojm+W0pp9Mcl3NLEUypWm5oWqiqo0rFUf2UAy4zRqjPYQRxI/F
         ExV3XWqPFwF1daUAt5+bZugHgj83o3I85FFIEYvWQq7+x/VxSKJ2ieF8I6Iebhr9Oi0f
         6w/Xy0ddx4U6XOZS/xak81+I4r6Jyci6SjyXbWmMKUP1tAKbLuibgcQxlhMGF4TU0er3
         pjLCB3Q9BDBhZu5xXomMJhEXCbt11V7YUaxknT4EBO+tRMgZOxwncxhO34iz5CyG7Lv4
         jc2Lsyjg1p+apZET38BJp2Bt/p5MGMX1rxZpIW/356z5PaIpnNCWfOvXAtF+u4IHJHea
         RtHg==
X-Forwarded-Encrypted: i=1; AJvYcCUvvNOmMcB9+DoPChelBezhJwJHI32CanqWd56skh2nDGwlgxqtmVl22UDbvga9SacG2u34L4OPoMuxZD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKvwNDSgEIpnIAYe5PZSDSiUFBR4L5YXdPOKxx18sbW7402udx
	U2uZgwQn+u5RdtwBB6H8Egur+A5JsudmyQP3OYqOQoQZv5PzoqM0sNFI+1SQMHqiIhpbEiJiX2L
	UdMVo1tjvOt8a8mw2aw==
X-Google-Smtp-Source: AGHT+IGPU27McRwqoat0Pmv9Cv7PBWj4obujNzeOpWEVAv2UcJ7bUkvlnarUt9oIbaab3TKEEvmUwT+2VlWRZMA=
X-Received: from wmju17.prod.google.com ([2002:a7b:cb11:0:b0:477:4a46:9980])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35c9:b0:477:7b9a:bb0a with SMTP id 5b1f17b1804b1-4777b9abc33mr43733225e9.21.1762779979194;
 Mon, 10 Nov 2025 05:06:19 -0800 (PST)
Date: Mon, 10 Nov 2025 13:05:58 +0000
In-Reply-To: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4865; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=b0mct7fLXCpWtZ5UlM9V32efA0UtDjJ5A0aIjp+AVik=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpEeNDqIx9uMc8a3ltMlM0rubrKicf0Ye9pdw/C
 MgxsYNu54OJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRHjQwAKCRAEWL7uWMY5
 Rv6UD/9jGQ5w6hzpirGqKTn82O9NRR+qspGk5ZtuGaLq80obEXHaW8C8cSQyMnqwpn33RhOfAqR
 vWhPDDTpyuQM+pDsD4Zpu4Z6pzouMK11+To9RRgwA8/IQj+ncoYu1CIxamYXmtvV6MujVSDcLV8
 xq065vMM5MHo6jGXj/E1fu1VPmR2XdwXa1j55s9tE1kLl84zsucX/Ie/YVJwJZFQkBW1uUFpP/b
 Ifi/fFK5QJYkmRgqjeVbJE0qC+n0UO+S4//zhaN7Dviz4qIiCDUxiKXQ74Q2BAJGL0iUC+JH3e+
 gIq9x6n5BRm7sginXukcXx9r/BkAuAKo/tHqM1S05M5C0EQhpxjmgUhS6vbfT4AvOx89tgcQERI
 0yFimvKkz//oNqFxsgBjHFRxO9xvnUswjckZ2d5HPu4DjR3BeE3k1fd+4l8AgCvDj2jw1fExgFV
 Q2SyZMUW940Z0WHR33MCwsvfrMEuXQellesggAAiBSlefzIzR8T6CIawssLip8VYCYWfAzMwShU
 pK4lGEb/V5YmWUErFfzZW6vPsH2nDIrK1/OtN8NkPPdWyiZcxmt9oLfmdFrrzTqe1hVxlrzJ26s
 fR0YM9xdnpy1Yn2Up0j2g5dQSEugsfC9DWdY7eLerJvXEtKfKY4yFRh3Syxi4Uj0WCVF3h6TYxn 2dA6QGKqi9FquvQ==
X-Mailer: b4 0.14.2
Message-ID: <20251110-binder-bitmap-v4-5-5ed8a7fab1b9@google.com>
Subject: [PATCH v4 5/6] rust: id_pool: do not immediately acquire new ids
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

Reviewed-by: Burak Emir <bqe@google.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/id_pool.rs | 75 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 6f607f04331c9bd3fc79c6d91d04005bd0685839..bf1aad1d7fcc54794b79484d1cf8861c328f02fb 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -25,8 +25,8 @@
 /// Basic usage
 ///
 /// ```
-/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
-/// use kernel::id_pool::IdPool;
+/// use kernel::alloc::AllocError;
+/// use kernel::id_pool::{IdPool, UnusedId};
 ///
 /// let mut pool = IdPool::with_capacity(64, GFP_KERNEL)?;
 /// for i in 0..64 {
@@ -34,13 +34,13 @@
 /// }
 ///
 /// pool.release_id(23);
-/// assert_eq!(23, pool.acquire_next_id(0).ok_or(ENOSPC)?);
+/// assert_eq!(23, pool.find_unused_id(0).ok_or(ENOSPC)?.acquire());
 ///
-/// assert_eq!(None, pool.acquire_next_id(0));  // time to realloc.
+/// assert!(pool.find_unused_id(0).is_none());  // time to realloc.
 /// let resizer = pool.grow_request().ok_or(ENOSPC)?.realloc(GFP_KERNEL)?;
 /// pool.grow(resizer);
 ///
-/// assert_eq!(pool.acquire_next_id(0), Some(64));
+/// assert_eq!(pool.find_unused_id(0).ok_or(ENOSPC)?.acquire(), 64);
 /// # Ok::<(), Error>(())
 /// ```
 ///
@@ -54,8 +54,8 @@
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
@@ -216,18 +216,18 @@ pub fn grow(&mut self, mut resizer: PoolResizer) {
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
+        // INVARIANT: `next_zero_bit()` returns None or an integer less than `map.len()`
+        Some(UnusedId {
+            id: self.map.next_zero_bit(offset)?,
+            pool: self,
+        })
     }
 
     /// Releases an ID.
@@ -237,6 +237,51 @@ pub fn release_id(&mut self, id: usize) {
     }
 }
 
+/// Represents an unused id in an [`IdPool`].
+///
+/// # Invariants
+///
+/// The value of `id` is less than `pool.map.len()`.
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
+    ///
+    /// [`acquire`]: UnusedId::acquire()
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
+    ///
+    /// [`acquire`]: UnusedId::acquire()
+    #[inline]
+    #[must_use]
+    pub fn as_u32(&self) -> u32 {
+        // CAST: By the type invariants:
+        // `self.id < pool.map.len() <= BitmapVec::MAX_LEN = i32::MAX`.
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
2.51.2.1041.gc1ab5b90ca-goog


