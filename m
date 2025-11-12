Return-Path: <linux-kernel+bounces-897235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7881C5253A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C91189FA75
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FDF3385B6;
	Wed, 12 Nov 2025 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOKp3Js0"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6C3385B8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951658; cv=none; b=oa5d7jpR5KYHVyyM+clb5Ud6wHFpSsOfQr6INHa22TXZ+kmDi6FJiU7ZesmedBkBBaDNqaeyfPgk8PvwPyv94uk0Ajl267ugelkINC98d//BRSiJLc2hhd+f3n05W2WjsyB0ECtTq1/8jjhDtTAjIqcIos18DZc53/Zu3CVqQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951658; c=relaxed/simple;
	bh=6MeYm25HociD581vSqYtJ2eptFsvAZ44ncTNn+Udga4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GcLdW4Pt4i6yRV0mB91E2rJk9/f+PRWRqK4e5Q2dcIgLiJamRNrE2pncnX+AI1hcZ34X4Jg2aUi8G5WRr8h/EGmqHUpysJXCs2WYBYh0ziBU9LkUpgDyj8BUaIV5ZhZ67cCPEBihrPeT6zbd9Of+P9Ve2f1oPzPzEINMNHksU44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOKp3Js0; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429c5da68e5so474253f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762951654; x=1763556454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QATGzgIOoHBhOcPYuGxb2KGfX2Q3a4/bHnK1FxMmdk=;
        b=hOKp3Js0djsTm6iPQ9M0p8KRFqp93+fgPHbyZKBYRnqtc4t6Jpn/cLOksgk/FYDCRf
         bszPhDECozvuH3hfNwQ2JWKzEtqbjDyajMr10IC8fb8gh0I36jLqlbaIjxHkYkvlj06D
         81csjewvJul5qwmLBtgAi+yL9oxOEZp0b9oAS30vK0Qx17x+6BUUZbyf71/04xrCxN9a
         zC4Q4XfEoJEo5VrHY93cdpJx8E7Uw3w7lWrgs866iDiIizljs+BXaxme6ZW5xJgkORv9
         UtVvxjwkos3dqQOzmSGTiPYwluWGXw4hFxMm6KMcrUwHsWUUjFBqGnEdc+9ZXzo+u0ou
         qsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762951654; x=1763556454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QATGzgIOoHBhOcPYuGxb2KGfX2Q3a4/bHnK1FxMmdk=;
        b=JaWLalj7Y/9BQzGX6RJgS5lHXLHQpejsKqepv/wMi5plmrdBdUmg19dauOZI2VnlBS
         PLNU2YDzIGmYlOhctYB/NX29+GfMir9qgFfU2AmlOAW4vbNTMpBcdyVFDwAKxQ2UBkrS
         LqJdXVO4Z/v16Y5SLUa0FDk22E8+udvs3UZHer5i1yt7Mgx46QaTwne2t1yghGdgprKx
         zQmq+bGajnrorJv4RyFMW4FhfrBniE6NdrGFyNEKhwAnAmBcPDSYjwa7BKbBR5IdDZq/
         DwvHSluveCKIjvgctuT3iFsKbbv7VwJvQG03rBL+NyxMMMbPJuh4gdiu7EuVbCfA+O4I
         fOrw==
X-Forwarded-Encrypted: i=1; AJvYcCWqoi380SPt+F+/DZ7OutPyChZYjYKQLO1tmtVB2A0s+Uj1T3x/zcPuHzmrrCiGR+QRrIjLoXXgei/yD54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsAiBHyL0IBcLvWcOKV744PgiXm5CeBqEJdBlody7AYkYfEfBK
	DGmyapaipwS8gu1KHoVcUPd+9mNPugstOZM05gz59KGP5ASRgGuPNDGE4Td6psb6HdSAmqFFhq+
	VegZcR+vudziY3aKZ3Q==
X-Google-Smtp-Source: AGHT+IGwiUuX9VtxNziIMNKFP7L3vhGfq/C2gnxBaVZw9+q+Hgp8MO4PmqGJrM1wwjJ1aM0vSDKzaVr3lt7Es4Y=
X-Received: from wrbfr8.prod.google.com ([2002:a05:6000:2a88:b0:429:c639:ae9d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1862:b0:3e7:428f:d33 with SMTP id ffacd0b85a97d-42b4ba7581cmr3109209f8f.16.1762951654322;
 Wed, 12 Nov 2025 04:47:34 -0800 (PST)
Date: Wed, 12 Nov 2025 12:47:23 +0000
In-Reply-To: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4865; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=6MeYm25HociD581vSqYtJ2eptFsvAZ44ncTNn+Udga4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFIHfLA8vn0C1oY1F+euOlddJEO00TimBmnEge
 +5HciDEBouJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRSB3wAKCRAEWL7uWMY5
 RnUjD/0c7M1eODfqPcBGXBo+T+rTzLyzomD0QAN+EJQW7ks75vDyr8vXUY0fccukmGf72vM83jX
 TetEr9WGw8TYvNjBfe6OeE05kpyYNiJT2D2LD54B/NmzJ+C14fLKd9q6PD55KfmfueF9EFDfTRF
 vf4vbISE4CdjluR84fNh7ec7rfvOFT8UiPgV5dpGgN4eqV/T8bYbQtpiihbqJdhJ5nVgG0kWFHk
 IwFl9Rll22aMRJiYuXV/oOH+4BPCmcewgXzOS8lJt2F0jGe4EyCn+klDZwVCOvdlh1ikRAcBKST
 gXVTdtGPNQUe4HVyLMrzutiSqdYyduj3Urii+6+EmLzp8x13zKmavDuNK7TWk6D5if7ykzb9BTu
 hAiJ5qde1qOOGO2tI97d5fYpnAkdZNAeiWUsqplx2gdBOMxgccpUS1kv/dk4SbJgB0ZCdNUz7Hy
 YKpdkEAS5/md9jyA+5fcw/XMiVqqv3cMJFGmCPsMxEol7ty11xYstMPwOG3xpxoIqeB5Y8A6qvJ
 qTNLp/MX9Gaf8bwT3GnuM5OxHcnrrP/4GdUx5tKQgY82+Jx1mRAMVgXbS5WiSFPpPEvRzAvwZev
 4Mls9REFDU4/LslOYobd3och2d6/SeTonlxiN1lxNRPyJ1WFiKIkSE7GVx7rkUJVukqU74Hx+Xd oYkefAVkH06Ln4g==
X-Mailer: b4 0.14.2
Message-ID: <20251112-binder-bitmap-v5-5-8b9d7c7eca82@google.com>
Subject: [PATCH v5 5/6] rust: id_pool: do not immediately acquire new ids
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
index dc856fc68f4cf38971332f15e63440f27868a3b6..114e39176cb48b3806797aba48e4d43e0c42e3d2 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -23,8 +23,8 @@
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
@@ -32,13 +32,13 @@
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
@@ -52,8 +52,8 @@
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
@@ -215,18 +215,18 @@ pub fn grow(&mut self, mut resizer: PoolResizer) {
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
@@ -236,6 +236,51 @@ pub fn release_id(&mut self, id: usize) {
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


