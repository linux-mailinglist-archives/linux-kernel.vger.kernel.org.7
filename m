Return-Path: <linux-kernel+bounces-860997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EFFBF18BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38E9421FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F337131B133;
	Mon, 20 Oct 2025 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2lzKac2"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1656B3191D2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967241; cv=none; b=leF0GEq0OWa2Ukm5A5NA+jZRzu90YNkiCTwG7YUP2UaGQdJghx7I25F5DUdcz6SikSRljG3j2LY1lLvpd23lriZLIwF8nbkWMbZ3qHfk68KE+xT4zQkdosyyhmkfc4hU6MNmG7XCKE9nf/Li/x3PKdw22f5xmg7siPU9P4Pi65I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967241; c=relaxed/simple;
	bh=R4pXEmMNsuBfi+wBM9oIG78safYpExcG2zg7DqP0UyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZoyG+Zsfzrg09OgSJv7AVvy0oqmd3k2hZtRX4LVm6yM4P6rKwKRxJMl9wkZ2Mhl7J1SVvk1acoWyOutDFd26OHz1Fic3o/V5VpPaukuPoA7iAsAaf/O4GxqxUw1g3J3hupf0h0xbiuC/anSJcEP3tm44jt+WIX96RepYr3yjvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m2lzKac2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-471125c8bc1so51778045e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760967237; x=1761572037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XujdrAVflWUs/mjjly58vQki5jrDGo9CKvfr8/mpjRU=;
        b=m2lzKac2YXlReoAZsD/h7ZAyLwVRqe3lw2JwAx0O0j2a+G8OoA95VyXc31ZM1n5cGn
         82mcZ9HcZrhlXq8vHnfeyiFa4KLLE8gHfi8BoYs+He6PwNK5vASEjMUnJ8tBSeQfVlWu
         1Q/VEDjKaWi5AewFKou03OIVla4EOGROdfc3+51QqZOxJQdyCWaF6DtTwENyrrgykdS4
         tYij16iZyVKCQlvInilH5aBsSVVMQPCnQyy2JE30XBKQigOHjFzOl/NDYGXqCBz08eEc
         sIueUmnQpnphCuLguKoYCw9dRfDQnie+OqIQoQkuLE2h7I55YBB/+N7BOmNQTY116Kwz
         wkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760967237; x=1761572037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XujdrAVflWUs/mjjly58vQki5jrDGo9CKvfr8/mpjRU=;
        b=PZAOgnmqdcoPQF1ZhkLwuj3L8+7p1HnHV9K7ausp58XnNYs5dlgPTC4xAyWe6iedgB
         Uf9+hhhZP9CfDyVByPz7KH4vtiSBo31TIBdKTI7rLGnhIythoo5+Pxb0YYy6Xw/VGWVQ
         cEpX8pWKb2mxd64yZrY8QQifC8rgfGCWwyZZ/rsuvtKN+iG9BO4DC/0188QxViZ3T26n
         IC+AmkUgFWh9i2MouV2xG/J4omN9WSlUosUdnGq4Y5CUAXv8qO06YTRrRJAQ6OZqkGQT
         8TGBOCrSGrLAzINkN0yMHdyuN0HlsYuhq79l2ic4Wt5LQBjHUGNGzjXC6vimMOCoqKD0
         zGmA==
X-Forwarded-Encrypted: i=1; AJvYcCVm+2Dj9BNI0l3baFm6hnWPWX8j/40T+ll0XNSw8OgjO2hD0O2PJ+7sEzY4nhbA6vVnAvJKywT04Wxnjrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlzrWsGaJkTxJM1gTRypAonqMIeTlpGmrpLvloD5Lnnrsmqqvz
	7TODmprx9b+Eqj+0FvqkDpeQaLH600C4dFv931sio03qLNh1UbeY6knuIBGTB94ZZU4W0qqEU9d
	ja9nwvrvGCBjTTmRTmQ==
X-Google-Smtp-Source: AGHT+IGyFsfWuYmaNbQe9k6gzEwF9MvBVO5TrVWkBk5cWGn3hqRMTnHHpA5EzHmHzJv4ZT2BnK9gOCnVwnD8tng=
X-Received: from wmbgz13.prod.google.com ([2002:a05:600c:888d:b0:46f:aa50:d703])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:820b:b0:471:1717:40a with SMTP id 5b1f17b1804b1-471178a8245mr89377715e9.18.1760967237543;
 Mon, 20 Oct 2025 06:33:57 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:33:42 +0000
In-Reply-To: <20251020-binder-bitmap-v1-0-879bec9cddc1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020-binder-bitmap-v1-0-879bec9cddc1@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8183; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=R4pXEmMNsuBfi+wBM9oIG78safYpExcG2zg7DqP0UyI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo9jpBTeFPzhytp2JfiEHURGOLAXJTd8EcDJTJY
 3I+swFFn82JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaPY6QQAKCRAEWL7uWMY5
 Ri7/D/wO3vwSeuqFI3SlvaFEd+bgQP6HLNB2W4OQmJPhT98ZjJk/QJ6/0BnRAWJk5U8vWy9DZyk
 lDe7GqVjg33v2q3EUbxlm7N2psb0B+Ev88goRywyoeEO1mm5UBwyahmoqWmJkK67wfKqvwbW9WD
 UkiOuzFhiEkDTbh7/ze0W9KOCkkgsRwkm/CDWmYdQBjBFvfU/WFqxAowoDAw2oHY0GvWFD/IGFO
 elFPld6E5YQ4fVp2aCIleMAJe4e3TprTG/sALpSigwcTDJlWXkoXrur+p2YF/sLJKX8+RHf51mm
 bax+Pt9iZBSxgLdLPxyOsY09OEnhV8VoEkI7MX9bf5qGfthO6K1KiE/2SVyHo75SpTwXjeIZJyn
 zMlXRPxe4oGy3SdFzVLZmb19N4do/L/F3TH/xQ7Rk078J2z09mZw1/O7pYWHyynLwSCFykY/DEv
 EDyHYUwNqPjsukTh2lxX77D1Sq3Y2l9IxqzJdCBSB6B//vc3/4NEbiy39UsQ92F0st3qVa98/+w
 /Ir+AyH/zZFyH1o4D39qbecRFERN6+WBkzFJqgVUTq97En75jO2SV1z6OXjcU+Soxz2HElvg8lh
 lEmlNTjrtY24tzp3cQi1wlBN41oMvYjYstikc6wNvlhXLtAnB6ixpjANsWhJVUZBL1jpWxIgimp jJ2nQsBec18eeEg==
X-Mailer: b4 0.14.2
Message-ID: <20251020-binder-bitmap-v1-2-879bec9cddc1@google.com>
Subject: [PATCH 2/2] rust_binder: use bitmap for allocation of handles
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

To find an unused Binder handle, Rust Binder currently iterates the
red/black tree from the beginning until it finds a gap in the keys. This
is extremely slow.

To improve the performance, add a bitmap that keeps track of which
indices are actually in use. This allows us to quickly find an unused
key in the red/black tree.

This logic matches the approach used by C Binder. It was chosen
partially because it's the most memory efficient solution.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/process.rs | 110 +++++++++++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 20 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f13a747e784c84a0fb09cbf47442712106eba07c..357ba1b577c73ad3f2b525a8573424420577e92d 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -16,6 +16,7 @@
 
 use kernel::{
     bindings,
+    bitmap::BitmapVec,
     cred::Credential,
     error::Error,
     fs::file::{self, File},
@@ -367,6 +368,8 @@ impl ListItem<{Self::LIST_NODE}> for NodeRefInfo {
 struct ProcessNodeRefs {
     /// Used to look up nodes using the 32-bit id that this process knows it by.
     by_handle: RBTree<u32, ListArc<NodeRefInfo, { NodeRefInfo::LIST_PROC }>>,
+    /// Used to quickly find unused ids in `by_handle`.
+    handle_present: BitmapVec,
     /// Used to look up nodes without knowing their local 32-bit id. The usize is the address of
     /// the underlying `Node` struct as returned by `Node::global_id`.
     by_node: RBTree<usize, u32>,
@@ -378,13 +381,56 @@ struct ProcessNodeRefs {
 }
 
 impl ProcessNodeRefs {
-    fn new() -> Self {
-        Self {
+    fn new() -> Result<Self> {
+        Ok(Self {
             by_handle: RBTree::new(),
+            handle_present: BitmapVec::new(BitmapVec::NO_ALLOC_MAX_LEN, GFP_KERNEL)?,
             by_node: RBTree::new(),
             freeze_listeners: RBTree::new(),
+        })
+    }
+
+    fn bitmap_shrink_len(&self) -> Option<usize> {
+        let nbits = self.handle_present.len();
+
+        if nbits <= BitmapVec::NO_ALLOC_MAX_LEN {
+            return None;
+        }
+
+        match self.handle_present.last_bit() {
+            Some(bit) if bit < nbits >> 2 => Some(nbits >> 1),
+            None => Some(BitmapVec::NO_ALLOC_MAX_LEN),
+            _ => None,
+        }
+    }
+
+    fn bitmap_grow_len(&self) -> Option<usize> {
+        let new_len = self
+            .handle_present
+            .len()
+            .checked_mul(2)
+            .unwrap_or(BitmapVec::MAX_LEN)
+            .min(BitmapVec::MAX_LEN);
+
+        if new_len > self.handle_present.len() {
+            Some(new_len)
+        } else {
+            None
+        }
+    }
+
+    fn try_shrink_bitmap(&mut self, new_map: BitmapVec) {
+        if let Some(target_len) = self.bitmap_shrink_len() {
+            if new_map.len() == target_len {
+                self.replace_bitmap(new_map);
+            }
         }
     }
+
+    fn replace_bitmap(&mut self, mut new_map: BitmapVec) {
+        new_map.copy_and_extend(&self.handle_present);
+        self.handle_present = new_map;
+    }
 }
 
 /// A process using binder.
@@ -471,7 +517,7 @@ fn new(ctx: Arc<Context>, cred: ARef<Credential>) -> Result<Arc<Self>> {
                 cred,
                 inner <- kernel::new_spinlock!(ProcessInner::new(), "Process::inner"),
                 pages <- ShrinkablePageRange::new(&super::BINDER_SHRINKER),
-                node_refs <- kernel::new_mutex!(ProcessNodeRefs::new(), "Process::node_refs"),
+                node_refs <- kernel::new_mutex!(ProcessNodeRefs::new()?, "Process::node_refs"),
                 freeze_wait <- kernel::new_condvar!("Process::freeze_wait"),
                 task: current.group_leader().into(),
                 defer_work <- kernel::new_work!("Process::defer_work"),
@@ -775,7 +821,7 @@ pub(crate) fn get_node(
     pub(crate) fn insert_or_update_handle(
         self: ArcBorrow<'_, Process>,
         node_ref: NodeRef,
-        is_mananger: bool,
+        is_manager: bool,
     ) -> Result<u32> {
         {
             let mut refs = self.node_refs.lock();
@@ -794,7 +840,34 @@ pub(crate) fn insert_or_update_handle(
         let reserve2 = RBTreeNodeReservation::new(GFP_KERNEL)?;
         let info = UniqueArc::new_uninit(GFP_KERNEL)?;
 
-        let mut refs = self.node_refs.lock();
+        let mut refs_lock = self.node_refs.lock();
+        let mut refs = &mut *refs_lock;
+
+        let (handle, by_handle_slot) = loop {
+            // ID 0 may only be used by the manager.
+            let start = if is_manager { 0 } else { 1 };
+
+            if let Some(handle) = refs.handle_present.next_zero_bit(start) {
+                let handle_u32 = u32::try_from(handle).map_err(|_| ENOMEM)?;
+                match refs.by_handle.entry(handle_u32) {
+                    rbtree::Entry::Vacant(entry) => break (handle_u32, entry),
+                    rbtree::Entry::Occupied(_) => {
+                        pr_err!("Detected mismatch between handle_present and by_handle");
+                        refs.handle_present.set_bit(handle);
+                        continue;
+                    }
+                }
+            }
+
+            let new_len = refs.bitmap_grow_len().ok_or(ENOMEM)?;
+            drop(refs_lock);
+            let new_bitmap = BitmapVec::new(new_len, GFP_KERNEL)?;
+            refs_lock = self.node_refs.lock();
+            refs = &mut *refs_lock;
+            if refs.handle_present.len() < new_len {
+                refs.replace_bitmap(new_bitmap);
+            }
+        };
 
         // Do a lookup again as node may have been inserted before the lock was reacquired.
         if let Some(handle_ref) = refs.by_node.get(&node_ref.node.global_id()) {
@@ -804,20 +877,9 @@ pub(crate) fn insert_or_update_handle(
             return Ok(handle);
         }
 
-        // Find id.
-        let mut target: u32 = if is_mananger { 0 } else { 1 };
-        for handle in refs.by_handle.keys() {
-            if *handle > target {
-                break;
-            }
-            if *handle == target {
-                target = target.checked_add(1).ok_or(ENOMEM)?;
-            }
-        }
-
         let gid = node_ref.node.global_id();
         let (info_proc, info_node) = {
-            let info_init = NodeRefInfo::new(node_ref, target, self.into());
+            let info_init = NodeRefInfo::new(node_ref, handle, self.into());
             match info.pin_init_with(info_init) {
                 Ok(info) => ListArc::pair_from_pin_unique(info),
                 // error is infallible
@@ -838,9 +900,9 @@ pub(crate) fn insert_or_update_handle(
         // `info_node` into the right node's `refs` list.
         unsafe { info_proc.node_ref2().node.insert_node_info(info_node) };
 
-        refs.by_node.insert(reserve1.into_node(gid, target));
-        refs.by_handle.insert(reserve2.into_node(target, info_proc));
-        Ok(target)
+        refs.by_node.insert(reserve1.into_node(gid, handle));
+        by_handle_slot.insert(info_proc, reserve2);
+        Ok(handle)
     }
 
     pub(crate) fn get_transaction_node(&self, handle: u32) -> BinderResult<NodeRef> {
@@ -905,6 +967,14 @@ pub(crate) fn update_ref(
                 let id = info.node_ref().node.global_id();
                 refs.by_handle.remove(&handle);
                 refs.by_node.remove(&id);
+                refs.handle_present.clear_bit(handle as usize);
+
+                if let Some(shrink_len) = refs.bitmap_shrink_len() {
+                    drop(refs);
+                    let new_bitmap = BitmapVec::new(shrink_len, GFP_KERNEL)?;
+                    refs = self.node_refs.lock();
+                    refs.try_shrink_bitmap(new_bitmap);
+                }
             }
         } else {
             // All refs are cleared in process exit, so this warning is expected in that case.

-- 
2.51.0.915.g61a8936c21-goog


