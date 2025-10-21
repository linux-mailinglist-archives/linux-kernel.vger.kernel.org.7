Return-Path: <linux-kernel+bounces-863022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D2CBF6CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B041819A5C77
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579583396E5;
	Tue, 21 Oct 2025 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kPzY1oWX"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1DE2F39D0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053607; cv=none; b=Jj3NWvXznu6OIH0NQoKJN4hwP5NJJIzvJkVNM9dxOldit6zfNxDNti0cdd6Q9VL+LBdLZAqNyupYhYUqB3Sj+XG1RQyhWKf8z/rrcFJxM8kQvMFVHpCsWn7tWbVl61jenb/by4/mX8O10iK4uOvScihYiipJ6TnXpY+QaTBgQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053607; c=relaxed/simple;
	bh=PW4fXPFs25L80fF70NuTLXm2bMNHsJLF6jbykyCi4q4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TmmvBMk3HMhDDzjNDDVdi5nebJwLCBjlWT+90p3L1w+toD12p9MjTF4voQL2uduvBlC/bbHBSTSa5M4FAN/1J8qjdfBNSghBf83XNHGxZMnA6w9aXF8gkKWRbR+YschIUZORsLkl+iY+772dZ7vpZ8sA91KjPja1Nb4lC81M6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kPzY1oWX; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso7975965e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761053599; x=1761658399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rTDltL3AAi/RgZ5a/oTDLo3q33+wUkHf+1m9k8QIy7s=;
        b=kPzY1oWXI82SDyGSq54iSrA7W6TKFfjnH+GU5h5WZBfP5R1S8jN8AUs1vjU8LjyE7E
         WpKF93vGMAX/uFr6ykdIjKkLOxXsnus1j3qF5hAuBXC4VwFecpAo+11elnCg0sMOaP3l
         77jGDRyoDqGLATdB3Wsbtyey4VGNtFuwagnJesrEI/1ZGLWWtXXS2/mfUGKp2Me3+ouz
         25OjTJbcCPBui+Xxsbag8BAJ9JpSMIJK+iqKNuLwPsCjWOWe60redVRzFKFMOOxaYMQw
         Y7L4NeFi8MAPWO1sak/eon1IcujZqi4LJY/0s08e+079u+Vo/FMWM/+sWl9HOlF36AeZ
         C7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053599; x=1761658399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTDltL3AAi/RgZ5a/oTDLo3q33+wUkHf+1m9k8QIy7s=;
        b=uv1QDVsdfbPs6TLE2FjxbF6+SvM4XmWOtlC8a8Ba1BIjo+PafBDaIYNhH5WM+HgSa8
         RSlUzv4V8lf1L9jMM2HQGvi9qQ5cx71ZcvoBmlXckzJ3bPh3GTdNjQRkFyxCRYZlRojz
         nqwIltzV5gjsjaxMgrT2fTP3JRaZnC72/HoY0c2rxSma4c55uXoyqOPfb54X3sbqtz9w
         uMJ0Zr6qGFDWAR851X471pQLJCIXXYh0vcR9OTlJWM8Xjpwrdmpw14YQ1QqmflxHSeW3
         Fw7V7s3jeuHJXKWdRUke7aCyD06qdr7pm/dcPRqRQv3k3aQBk1YRjmy2NZOBaHYwn0P6
         eJNA==
X-Forwarded-Encrypted: i=1; AJvYcCVA6WxmHExLQpn8NUbOElq3TbmhVxqFUQdR3QIdHJoZncm2hyzoQwt4M66hoGwQbWmdxbIm4EXqt9nANaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1FYc8QpUpz8TpcEJpK3cJzKuOJNCmtGuv60XznBoTIvrvbHd/
	dfNQbAgeWr1gIfbUp9Hh9HSnwma6Aw4efSGUaE8pLDCDeG2pFfbtd/At8aHHPZaL0okoEVCvkVD
	QzSanI6YfpVd6m4wQkA==
X-Google-Smtp-Source: AGHT+IHbGsycRyExDTiNuYM7y3DxXLafgUs66DExEEUzWwCgEkrutWY1m8SaJ5WXpD9pbMyB1vK4A7vDVsl5Fdo=
X-Received: from wmbhc8.prod.google.com ([2002:a05:600c:8708:b0:46e:49da:cb09])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:310e:b0:471:14f5:1268 with SMTP id 5b1f17b1804b1-47117907a77mr130498745e9.25.1761053598959;
 Tue, 21 Oct 2025 06:33:18 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:32:47 +0000
In-Reply-To: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6173; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=PW4fXPFs25L80fF70NuTLXm2bMNHsJLF6jbykyCi4q4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo94uXSvZrdNt269KCZtQ1EMRnOYj4jE10+cR1a
 rnYxaaJb2GJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaPeLlwAKCRAEWL7uWMY5
 RkUHD/90F8j+1nVwohT77GrcF5m7/v0ucDFj5WnQJp+i4y8p8qPO3sjbQuzHH+B8SHCXGdj5QeP
 QikErE2XXj3V/56RzL9Iohq0dY8bvdeNC3QejLmJXafAi2rninG5VqWCls+1EjRLDlmg7FyFYld
 8pq/m0VzWnKC4+dbQzCarEN0mQ3//GL16rrH7d7Cx3+5mtZxAfbiM1S6thAahHgz1c42ZeuL1j1
 JLDoH+lXrqXtfjqw7JbDhUO5T/veK7tF265P0osBHmQug/0mYLEhecptO5Jfkp4+Nfu3UWomKi9
 0+85suAvZAiPofmvD9MXSnNAlRT0eV8INncE+BFZJzc36uobNdUuUWXt13gtacLA6MVhUIKmBRH
 CnBSPNrspYOLiKJg+y0sbKtG+WTZ7e+dMjBdEQKLDfdnVzM1baR9xvxScab5+QtTDPYswRCTHCY
 rz+Aw5SDfiLIRttPybmaaGXCyZvcSNK0aHTjNXoQEeQdgQWkzVj0l+9vfy0diPRg5dTSGfKaZj4
 f8soJN1hgvxAkgOLjFHCrYvOJR8vEnM4flZ5tSqgQY5SbjjDtAxhlnw6vxb8CnUiAh4BK56yxvk
 GWU/+VNchCf2rYVZqB37ZVxGjUWSBZo2LObWxUaNvRR35tFMOcuUuF6bJqwdOATW6lPFMJkBwZm m33GhNU8VhenUjg==
X-Mailer: b4 0.14.2
Message-ID: <20251021-binder-bitmap-v2-5-e652d172c62b@google.com>
Subject: [PATCH v2 5/5] rust_binder: use bitmap for allocation of handles
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
2.51.0.869.ge66316f041-goog


