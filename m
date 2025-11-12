Return-Path: <linux-kernel+bounces-897236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1286FC5256D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8490E4FC152
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0519733AD8F;
	Wed, 12 Nov 2025 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EiYc/p/B"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109A338F23
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951659; cv=none; b=GQdLO8k4XGZR7zD9O2ZTS+kY02GIFoNpV3B5pKMpNll+1l/kxiFYgNMRTMOGCXvKd0PCJaxzYMY/qyex0k/Z970LbF9PrKIrm300+noeiyqSFYJ7LeJCdXEE6GxEBTYHSI3SZIYs2mYSi0AEnEYeK8w9pVn6mKadRXcVJ5k7xOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951659; c=relaxed/simple;
	bh=7993m8OvBem5aU3JmUxqvYCw1dEJgILWjzrL2R/Lw9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HNnUFbYSltIyEl/NzTAdJ+8ZBJtoBeRKAAbLE/YhabVZiHPtUGO+iIWYW/PAlCJOxESPf4v9n1X37M6nijxH9PB1dA1YrBiS05yyoQXxwbpFV0TMOJZ8YOmDwrUa/N2gNqmxGr44MHjUAEhWtYsQl5/eUBBTDgoUoMEXSY0ep7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EiYc/p/B; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-64161017e34so934633a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762951655; x=1763556455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSGXuP7AugTGZlYmteSMimkU/xIm9yUQuBQEE4/o9H4=;
        b=EiYc/p/Bebh2mGSss8X+0tmIkj9sofnkpCThpDG+Bb1+wi0EwnDR9Pd7Ri8y1cl5mN
         RzA6EoiHLIKKKc3DdFh/Gf7iYspThRkiTCV6Zq5VJsnEaJpF03OWTtBm5KovX64TF0uq
         CVEkuZ0IZJplsgkvoyzYaH+ZMzz7fKW3lDDEq/1q7tOMUCct58B8GRmQFfoT3WhkNrnU
         9ASvzS321Sq0jCqsH2Ggql2dJDmB+KwOP3OqzqLZPS7nvOBz7QZDGwTiZNkFlhYtCo7W
         O2TxqRrtX+gW3Xyl+PcNMXjR1+TIB3aTka+F8ELVl3oSMhNj8YzQbXYc6QN9msdxtA5D
         lasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762951655; x=1763556455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSGXuP7AugTGZlYmteSMimkU/xIm9yUQuBQEE4/o9H4=;
        b=Y72thAFxKkiqgh4PH2edFupSPMH0QUI2AYKqJw61+GlreJUe7CD1klgyFS/i5V4ZE4
         0phRK+O7MxwQAvp5jn7ojact9Lo8Z+OoOF3gSbgBGJuE69uRHBuNE5Dqo3wd99QBWs1l
         QNxBaoiptRbpcHT0zlHVQKjMl1x5aB8aTq5U1yN7Jt7KZcfwQ3/FYqvc7XDSUo2k2mSA
         qIDDUp+O9406NfqCDp55DkEfwonkURo7OEsL8TZxJRjhTNERitXmuFj0LQzoQTxVuRy3
         9d54JDZamLBsoyd8owQcCPx8pWqA7CAm5pXR2geKdKwrugx3GeabQOLYF6l3U+acu3pU
         RGYA==
X-Forwarded-Encrypted: i=1; AJvYcCXtcTf4O2A5nw9BjWKhNrXGWzXpAxw1JySW3kbMzWuBWFURuTtDogGcsRyZZph3rAFGw1W3oZWLUOPzT3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnApWTJtXoflaM6i8Bik7IZQBIsGHp7TRqh3MuDI/m0UjlZYmk
	v8XEH+d2wG8hX8G41UoOwwRHnnjqU6FZFV66K+9Xxbae5VsbC3w26k7fwG8BFdjPK8M272hyRQi
	HjDtWovFbISamdliGiA==
X-Google-Smtp-Source: AGHT+IEy759MKaPGI2654Ynt2AeYqR1Q+U51y6PIqyWtN/FW0QjSbKYn/cnewpGhFjEZmbceiGWFu/CxCbtY/Z0=
X-Received: from edaa13.prod.google.com ([2002:a05:6402:24cd:b0:641:4e96:ca96])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2111:b0:640:976f:13b0 with SMTP id 4fb4d7f45d1cf-6431a4b3b46mr2630907a12.12.1762951655524;
 Wed, 12 Nov 2025 04:47:35 -0800 (PST)
Date: Wed, 12 Nov 2025 12:47:24 +0000
In-Reply-To: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6263; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7993m8OvBem5aU3JmUxqvYCw1dEJgILWjzrL2R/Lw9k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFIHfP1ioXJwPrlND7Tla2uYLkuZFJQ0Av10lr
 s39fKs/uZSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRSB3wAKCRAEWL7uWMY5
 RjlMD/wLULd/jxmYFkhyWU/z7yy/xQKcsW9l0KKM+P1I5MAogFkXt80QhZx3cUaUmfFoWoqUYRR
 wmLZxfRhnB6XtwDDmajbQkjWLA+557FhkRakTyMVpK2YDhzamoLBGnFWbPqDUCvvD5onHSWA08w
 YTkGjQa810BzXKe5A0dfzqrSfKuQOVD44/8TTVyNF7Fny8yyD/A5UvbNzV6eDcNBEpfCMgku8Qj
 E1dpRX3EVpL3sL2b5YkrDcWw2T9mXeVp7WKJtPaTaEYoHGOZz0h8LkD+Er/bCNgWU9JOaukr8xG
 WH7s/sn12VDXJylHnYEKCL4gQtBgnOzI4KOA3KUR/Z/G9zFSY/rgj1WJZab2UdSeTO/q6yQh3gG
 nukVS3TX5S5RR/6mi0xRP9PQpB7sdYcORbBpK980w6BIaQJTOsfXXwGf3jJrf6ppaiChcUm2vau
 cLC/P9Ivp1Cl8OSWNp0loDKyLQrPkIDE7mhjfu3g1vWyoCv6gj38KvZOcsynvUdKiymdgvoUyFY
 Cam6JL5BQ2H3E/TLa7F0fecSQJ2YwaqKbovEB3B5FnkGstmq2Org7sOnGVQI3J6ZyTM+J8UXotQ
 NK9jBWL/ikgKPCscAoSwdkjtYOSa6FdNrQZcniTD7BUgEVe1PoQNBjz7BFD/XbAS2mhnvtJxD+W 5omNTnn984rat7Q==
X-Mailer: b4 0.14.2
Message-ID: <20251112-binder-bitmap-v5-6-8b9d7c7eca82@google.com>
Subject: [PATCH v5 6/6] rust_binder: use bitmap for allocation of handles
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

Reviewed-by: Burak Emir <bqe@google.com>
Acked-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/process.rs | 63 ++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f13a747e784c84a0fb09cbf47442712106eba07c..933b0f737b38ffac536b19c9330dfc63ffc72f2b 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -19,6 +19,7 @@
     cred::Credential,
     error::Error,
     fs::file::{self, File},
+    id_pool::IdPool,
     list::{List, ListArc, ListArcField, ListLinks},
     mm,
     prelude::*,
@@ -367,6 +368,8 @@ impl ListItem<{Self::LIST_NODE}> for NodeRefInfo {
 struct ProcessNodeRefs {
     /// Used to look up nodes using the 32-bit id that this process knows it by.
     by_handle: RBTree<u32, ListArc<NodeRefInfo, { NodeRefInfo::LIST_PROC }>>,
+    /// Used to quickly find unused ids in `by_handle`.
+    handle_is_present: IdPool,
     /// Used to look up nodes without knowing their local 32-bit id. The usize is the address of
     /// the underlying `Node` struct as returned by `Node::global_id`.
     by_node: RBTree<usize, u32>,
@@ -381,6 +384,7 @@ impl ProcessNodeRefs {
     fn new() -> Self {
         Self {
             by_handle: RBTree::new(),
+            handle_is_present: IdPool::new(),
             by_node: RBTree::new(),
             freeze_listeners: RBTree::new(),
         }
@@ -775,7 +779,7 @@ pub(crate) fn get_node(
     pub(crate) fn insert_or_update_handle(
         self: ArcBorrow<'_, Process>,
         node_ref: NodeRef,
-        is_mananger: bool,
+        is_manager: bool,
     ) -> Result<u32> {
         {
             let mut refs = self.node_refs.lock();
@@ -794,7 +798,32 @@ pub(crate) fn insert_or_update_handle(
         let reserve2 = RBTreeNodeReservation::new(GFP_KERNEL)?;
         let info = UniqueArc::new_uninit(GFP_KERNEL)?;
 
-        let mut refs = self.node_refs.lock();
+        let mut refs_lock = self.node_refs.lock();
+        let mut refs = &mut *refs_lock;
+
+        let (unused_id, by_handle_slot) = loop {
+            // ID 0 may only be used by the manager.
+            let start = if is_manager { 0 } else { 1 };
+
+            if let Some(res) = refs.handle_is_present.find_unused_id(start) {
+                match refs.by_handle.entry(res.as_u32()) {
+                    rbtree::Entry::Vacant(entry) => break (res, entry),
+                    rbtree::Entry::Occupied(_) => {
+                        pr_err!("Detected mismatch between handle_is_present and by_handle");
+                        res.acquire();
+                        continue;
+                    }
+                }
+            }
+
+            let grow_request = refs.handle_is_present.grow_request().ok_or(ENOMEM)?;
+            drop(refs_lock);
+            let resizer = grow_request.realloc(GFP_KERNEL)?;
+            refs_lock = self.node_refs.lock();
+            refs = &mut *refs_lock;
+            refs.handle_is_present.grow(resizer);
+        };
+        let handle = unused_id.as_u32();
 
         // Do a lookup again as node may have been inserted before the lock was reacquired.
         if let Some(handle_ref) = refs.by_node.get(&node_ref.node.global_id()) {
@@ -804,20 +833,9 @@ pub(crate) fn insert_or_update_handle(
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
@@ -838,9 +856,10 @@ pub(crate) fn insert_or_update_handle(
         // `info_node` into the right node's `refs` list.
         unsafe { info_proc.node_ref2().node.insert_node_info(info_node) };
 
-        refs.by_node.insert(reserve1.into_node(gid, target));
-        refs.by_handle.insert(reserve2.into_node(target, info_proc));
-        Ok(target)
+        refs.by_node.insert(reserve1.into_node(gid, handle));
+        by_handle_slot.insert(info_proc, reserve2);
+        unused_id.acquire();
+        Ok(handle)
     }
 
     pub(crate) fn get_transaction_node(&self, handle: u32) -> BinderResult<NodeRef> {
@@ -905,6 +924,16 @@ pub(crate) fn update_ref(
                 let id = info.node_ref().node.global_id();
                 refs.by_handle.remove(&handle);
                 refs.by_node.remove(&id);
+                refs.handle_is_present.release_id(handle as usize);
+
+                if let Some(shrink) = refs.handle_is_present.shrink_request() {
+                    drop(refs);
+                    // This intentionally ignores allocation failures.
+                    if let Ok(new_bitmap) = shrink.realloc(GFP_KERNEL) {
+                        refs = self.node_refs.lock();
+                        refs.handle_is_present.shrink(new_bitmap);
+                    }
+                }
             }
         } else {
             // All refs are cleared in process exit, so this warning is expected in that case.

-- 
2.51.2.1041.gc1ab5b90ca-goog


