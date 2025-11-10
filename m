Return-Path: <linux-kernel+bounces-893202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF28CC46C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22EDB4EBFB3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ECA31282C;
	Mon, 10 Nov 2025 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPvVM0CQ"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636531282D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779983; cv=none; b=KBuLby/Qpy8BIxQ71Y0g5n4BnrKzw/LwH3kKCTXLEjnX81PhzskIN1icmbO+h47YgwYzYupvtDyh+oN6YqW3tswEuA6bfjbszjkmnMXI1cqt89UX/Xz6ORQq4PBanQwfNVa60nuCGVj7iE53KrkcxjTHNEo90BJDs6HcyQVEU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779983; c=relaxed/simple;
	bh=7993m8OvBem5aU3JmUxqvYCw1dEJgILWjzrL2R/Lw9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gaF8ctpbb3fHcgAC0LZuIN/6EBCBA5+b+ZYmVzgyio9xBE8AkSpkoDvxJ77M7PU/jEfZXQnG5CFK2E9Eo/pLKOn8cqhOOgw2LvdNDZjvAWcvwTxdXWE9Ypididgona74DtU8RYzyZHZqNnGlsQpk+z7evNHT/Q/tA+QkGCKCIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPvVM0CQ; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b6d7405e6a8so317466766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762779980; x=1763384780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSGXuP7AugTGZlYmteSMimkU/xIm9yUQuBQEE4/o9H4=;
        b=wPvVM0CQVbQQT2J3iJR/Gw44Xu+nVqLy5nF2102cvBohp+JbndFDYl6GXaj3cf7BW4
         gTsP3CYlupQd+JxEngRODvxh8r5SLegef0UBwOXAhB4hruQ70J08mTV7gi8Fu6NOOpDG
         tV9cWmyhIxwqDpzWqNx4teIvn4EHcv9b8XHGqnEIDB20kBL1sPrmywgTN2Xgk2nH5Vqd
         FYPgZu+axFlnLi9vf6w1L4A24ylFrwy7YsNcidhAtkYIaTdAihwAYBy7rCDUjkgtW4G2
         kEeX+Wh3hwwkw3fDFr7J/FW5QHIwf4AyDnMr5USYJop8i3CIps67oDaj0GXL2RtuL8+e
         CjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779980; x=1763384780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSGXuP7AugTGZlYmteSMimkU/xIm9yUQuBQEE4/o9H4=;
        b=C8qUMcYTzz+RyG8Yva4j7IlPe6PLW3OlPxWgEkISHAbXosvNWnDcJEhS2NK5hcKDDP
         xj4udjSjBxdpgDljORGfsJdS/1EohHkPdJsxHKmdJULCIGVmdr7WcndOSVao43+t4oJO
         a69ebZ5sYM/PBxqSra8V2axNfB9Ce97mUmldRbyF1NjYmJBTPhgS0KBLoMQeuVDc/nLk
         q8z6RBWjADY2kshWgRkSmv8dvZI/ydKlLhO6r1oci3ntdRlLOGJKAbJwnBtOxava7DlW
         7b8/m8+Mms46md4pL9QCeI0x/PwBMjhFjwiJVVE4X2qRCO6IJIZ4KVzayCk2IhjXObJY
         2xHA==
X-Forwarded-Encrypted: i=1; AJvYcCWt0drqDf/Uu2DbfB4gmoi+KqbSVMsgn8ewm6fDPA/xkEgk6Xu7ReA7+yixBffSYDfSwSUPsKrsEo6eNN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQGVyx88s0MHcpS+6kavbvn8WpyxnOnGgC9Ga6LZXufnF0+Tu/
	T2mqOcRmbiqlT1R6wgafCNLcmKhsQ6st5WV3u39NwqCHTx7yTbNYTYoU549xWIXMB18bE70g8O9
	mtJZwRMYULBCkwL/zxw==
X-Google-Smtp-Source: AGHT+IHOFRtzj17r98BrZnYhPDH7BcIr6LDvYu4u4o4VD9su1BOVPDC9ImKEK33//ppmHMOfYOGZsDg3neBj2Us=
X-Received: from ejra23.prod.google.com ([2002:a17:906:4697:b0:b72:99b5:37df])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:96a6:b0:b71:d742:5148 with SMTP id a640c23a62f3a-b72dff5fe26mr813962066b.31.1762779980520;
 Mon, 10 Nov 2025 05:06:20 -0800 (PST)
Date: Mon, 10 Nov 2025 13:05:59 +0000
In-Reply-To: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6263; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7993m8OvBem5aU3JmUxqvYCw1dEJgILWjzrL2R/Lw9k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpEeNEMpMJqOpS6vIvvgVJKQWGpTEXjHrw5nnLe
 DBhh9GwD8mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRHjRAAKCRAEWL7uWMY5
 RsTlD/4yqoxdmXqu0CysOfbItj6bzfgoWbW4mYKEwrHO0xdwfBI2NyzZGGvy5l3jRI0q+iDf2Bi
 L5dmkNwuzmb4mgo8EaQgMnG1LzOSLw9Xxo7cY0v/pyO0y8VqkOqfMzGjj6jWe8Nn3MVSbEdcpa8
 0kRmzy5JT3HnIr7C6BgopF3HIxu+dFHZCIvAiEw6DCRjlizXmd8W+xShEP1/5gOLeBAEBlTVQoV
 BAvVcJuUuP/+V/jzAaVPAQSPatevA5owydUoWSu16/ctbTmCsOvpjkIIz0YDHyAg5B1CLLzj7kA
 Y4R12Nb2+YerF+wjgReex+60s9KyOkMxbBKsDjlT4kauvsPjrl2vVYl7dlFCRU+B4PJotXCtTWd
 87jQ19xNFHOH4w0XtqmVc7zzaxAk73BuDq5hz2HiJTdMsCbdFW49+z/8kNmN4XrNZWV9dNJxHBC
 hcuMJzLB6WoUgkYA4g5maa1tf6/HJRI7wsGe8bIz/hwfCKAUBd7bdXUaJMv3OK98/KySdzE9fzF
 gDc4ZtPPAhDeZPg+T75Efnwqd+OWniKhDq42Bi0RisKy4nt/+QoEEpEYdL2iNn32nN8kJFZP3nV
 4Es8cNR7O4bSiHziscyy0hSIi4SLHehvE/bHY5s4N0gi8ma70X+oNOUZVUd63ZWsiEpCyzJeiSJ tD6nGm7fXBHiAvg==
X-Mailer: b4 0.14.2
Message-ID: <20251110-binder-bitmap-v4-6-5ed8a7fab1b9@google.com>
Subject: [PATCH v4 6/6] rust_binder: use bitmap for allocation of handles
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


