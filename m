Return-Path: <linux-kernel+bounces-873612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C377FC1438B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B99D581F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD50309DDB;
	Tue, 28 Oct 2025 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uozo1NG2"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E88830C378
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648935; cv=none; b=uTqGX/1hONrgTpVgTndPwDL1yZuv+1aoDk4hBORNIs9Grv/tg5VZV2m1jiFXJ4SZJ/y/gIXOF1452J8RCKq4TzvEGnU3vkWJDdr3YC3nBFnc0csCaJc0Hkh/z5TMYDIzOtFr1tmON96hOpeuR6KsRbHOVR7MkKi4SGWUoJu85vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648935; c=relaxed/simple;
	bh=udW1FE6CeJVfsDJwC6o78IFfdh17JFG2cGpHdZXuV68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ePHSXNvp5XMhlJ+qJAoXy8BCkSdiVz8ewY0RWUEo3JUueC8g4ytzUXjTVElXE9dcs1LEJQZE9GMemLUGVa+aKqzjpKEr10yaNcbthyR1mD8XFVdnChHT2Zw2oWUd/4VEzKr467ucMWjZNmLYxBcCIuXe+0C6JXxDr6XDJbNRFWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uozo1NG2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso41244515e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761648932; x=1762253732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=usUdwV5qA+un71/eG88Mj+9iiBrsIeUHPYN64+4XrwA=;
        b=uozo1NG2HB3KA8nOTG5cGvssqqKP88VhN5Hi+JGkZ7hc1R5E3S+2Tbw+Ng98nJyejy
         o7wvKvim7DHpCxKXiBQrDCzqCcm9sZlNMo3yzy9w1U8TFFyTx4uKT9YxuZc8nZYKlhIC
         ahEpDQ20/FCIR5zEigjM+TOE12YWHY/SuFMuGi2bak95H3nL8EcYVT1DqLO4rkbz2csj
         +RNGYeSVI9T9GaylBRV2yTB3W+KnnVLJMKJ0rmuVcpApm/X2rhlxEhCV0g1WC2vBH1Oq
         3zgKSa5h7ulln4oG1qWza8keGyZBgQM63X0YWj+P4XLkzn26mz8DgkW3r/ywKSovQ0eg
         eCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648932; x=1762253732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usUdwV5qA+un71/eG88Mj+9iiBrsIeUHPYN64+4XrwA=;
        b=Kkz4OtBDagpcFBupEs4o9DQEFsF/+aCj15R0omYH+64vm9u+D49JtpybQjk4Vf+xkt
         6tkBAPeYSVdHY+NJi/K+n8xhtvcD0MbL0wAJJmVZn2/PnQoGtXuTWPnttcfXKXeDPy8a
         RE8Vdtidw/NMpBrF1jPuXISqNj5GVwf37/C4+tMEgXjwS5ftOL/XafGTTcXogo9gph7y
         r5oXnz/P7ngWqpLGQvDHmDJ4DlVcA3O/azevN4Yg0zFiy6lth/iSsvDGEeEgixidk9Pk
         47FXQhB9ymrx5Nq2m1tpyc+/iPXCDcXF90gh9q/eQf6sDeGn98rh3/CBDjye+F0qYKt0
         eJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhBoKCCmm7K0WlUXiXPqyp8gap6xlMAmbBuqS9sC1Ew8lmim08i7BEKnZmT/BMjy3LwPir9y0hk/KlvfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg3R7fHg1Ly7cE61VFYY+1s8WUYyqLQCfjWjvZGOAU4R31Cjmc
	45C6IgMhF/vSbq4AK583NYLiQB4X08LLEA/XBeI6FQwLqlmLnSAsmGTTu8PmzRm1I/ZUd7zPO33
	3ztVd/TQS4fC0Abg4gg==
X-Google-Smtp-Source: AGHT+IFBSW6bF2q+Y3mewsY9Yj4Vi0BdA+pCImOnLmS8xiYMVzsIPBnvLC6oaJxCr7X7JpbuYJv3ec/ih7Towrw=
X-Received: from wmht4.prod.google.com ([2002:a05:600c:41c4:b0:475:da28:9004])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1da3:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47717dfaa6dmr22114485e9.15.1761648932262;
 Tue, 28 Oct 2025 03:55:32 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:55:18 +0000
In-Reply-To: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6215; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=udW1FE6CeJVfsDJwC6o78IFfdh17JFG2cGpHdZXuV68=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpAKEb6/jzR1A++T9KBHbdNW3hm55lNwI/Pvmlm
 Z6AdePXRS6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaQChGwAKCRAEWL7uWMY5
 RlrSEACw0LfP3ntIv+4pqRfxE26K0afKHBul8eqjdsDdO+y3l8yPFfLaZpNu8FSAmrch6mcB9dJ
 FqSwTE6YBV9hpyu1c92GJoaK7W9K1zctnhAfvzopCxdj3m7eHlBw5wInK8XnqK45Ozm5h7staQG
 f5W8ht4W5SSSWLSr2OTcO/NJTbDDctuVZSsYeyI8jjRmEHv9w2JNXNgL22s8gtqhGsuD3KZF01h
 k/has8YncnY9HUXzyaI2ZcsTJt+QhUZx+d11SaElf0SB8957/DE9ThOmvVeVhFpUQ2LJDzswjsl
 qMbQ1Q/AB3ML0/1iSA7S4LD6TzE81WZ/4LD5oWfXwtaiTFgSgHu4WKgNvKIPDVrLKZmaP3nquS3
 4j2asU1qytUrZ4fH21VY3ds2N7NghuXdnYXCl68sN+bLASwxfQH1bYhdWNKohQ6AG/Vyja8+NPQ
 RrSDk4gJY0zZCEDzAD7CLyshcZ9BtKPZL1mLWBxISUCDW+x+HOz0Q/9R3MVCioDbWaUuA/O4eHB
 Jxe9J5MqxENjB/4ak20GcrRmJrO1ZcAc4RONusT3MFLzewBnBVbKfEDp1nXJQ7RSI9RmvD2HLAt
 xLM9FLEq+rVxs9ybWf6W8IjV+2fBrc2xY9vmI4bVE2Fb2qXgF3ajKmbBP1IbC18YdRwYavPTBrS Q/4inrBC73RRMqg==
X-Mailer: b4 0.14.2
Message-ID: <20251028-binder-bitmap-v3-5-32822d4b3207@google.com>
Subject: [PATCH v3 5/5] rust_binder: use bitmap for allocation of handles
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
2.51.1.838.g19442a804e-goog


