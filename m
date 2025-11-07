Return-Path: <linux-kernel+bounces-889775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E23EDC3E7CC
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 06:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56D2F34A1D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 05:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB0925A2A4;
	Fri,  7 Nov 2025 05:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OIOdXUTY"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4B01DA60D;
	Fri,  7 Nov 2025 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762492131; cv=none; b=pnrAkqTnBXaMeI1LKwMckICDOs3MHX4weEPLY69AeI6nBeEmsMK/sxsp+2KjJl4MbMqs53Y27JTbVDV6+VNPoegnQSs2CQpNR/6q5J6K0JDXMECppNHYb+++fv3mgLnPW0lxayM0/NWZX0VzcDC6ySszRf7WoLHJdklM1Eyz9ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762492131; c=relaxed/simple;
	bh=wz0RbXvDANs4xP0BLLV/sMIOmtF2tGmZKTNplvZYyNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UclS8SS71IHMbi6BQGz2HVHPtS40VeUo61JjVftgCyRss6DCPoLpCcl6HuoHqSgtzmP5az/th+Pd8jui9kvnnrAKKJyGktHQRJ99nEjrrfQ4/8jWzHvxRqDKPYTcVXGNhvygISUqMdVSKBm0lIk3grc1tu2w4a/kwY7SJ0KkbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OIOdXUTY; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Zc
	gaUWkAGv8CNfCH//KMQiCLJzuISS/tabOyOTpq+Bg=; b=OIOdXUTYa45sOU/PF3
	9EtnkX+r8hLhU/bAzRplBg80qyXrf7MzkhWCMibWG/ZdQhKrQ6LL+Ulxsf0ddvkb
	7KYpOOW09j18HpXc6NaTCakybVKjKtkppAh41uqybhajlLGgPfKlfkZg0GE0B1f9
	4VbL1H+bo7c+uRl9H6kcParMw=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3d9CBfg1p6iv4CA--.2027S2;
	Fri, 07 Nov 2025 13:07:15 +0800 (CST)
From: Hang Shu <m18080292938@163.com>
To: ojeda@kernel.org
Cc: Hang Shu <hangshu847@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Hang Shu <m18080292938@163.com>,
	Charalampos Mitrodimas <charmitro@posteo.net>,
	Borys Tyran <borys.tyran@protonmail.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Daniel Sedlak <daniel@sedlak.dev>,
	Tamir Duberstein <tamird@gmail.com>,
	Matt Gilbride <mattgilbride@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: rbtree: fix cursor method lifetimes to match tree lifetime
Date: Fri,  7 Nov 2025 05:06:56 +0000
Message-ID: <20251107050700.1086059-1-m18080292938@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d9CBfg1p6iv4CA--.2027S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxur15Cw1rKw1DKrW7WF1Dtrb_yoW5try8pr
	s0g347JwnxAF4xWrn0vF18uF13X3y8Xw45CF4DCw48Aw43JFZ7t3WUtFWY9ryUurn5Zr4r
	ZryIgwsrCw45AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziO6pDUUUUU=
X-CM-SenderInfo: bpryimqqszjmity6il2tof0z/1tbiPRH+kWkNdid6kQAAsd

From: Hang Shu <hangshu847@gmail.com>

The returned keys and values of cursor methods should be bound by
the lifetime of the rbtree itself ('a), not the lifetime of the cursor.

Without this adjustment, examples like the following fail to compile:

fn test_rbtree_cursor(rbtree: &mut RBTree<i32, i32>) -> &i32 {
    rbtree.try_create_and_insert(1, 1, GFP_KERNEL).unwrap();
    let mut cursor = rbtree.cursor_front().unwrap();
    // compile error
    // cannot return value referencing local variable `cursor`
    cursor.peek_next().unwrap().1
}

This modification ensures that references to tree elements remain valid
independently of the cursor's scope,
aligning with the actual lifetime dependencies in the data structure.

The changes will be applied to multiple similar methods
throughout the Cursor implementation to maintain consistency.

Fixes: 98c14e40e07a ("rust: rbtree: add cursor")
Signed-off-by: Hang Shu <hangshu847@gmail.com>
---
 rust/kernel/rbtree.rs | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 9e178dacddf1..702a1b6ef7a9 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -742,7 +742,7 @@ unsafe impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {}
 
 impl<'a, K, V> Cursor<'a, K, V> {
     /// The current node
-    pub fn current(&self) -> (&K, &V) {
+    pub fn current(&self) -> (&'a K, &'a V) {
         // SAFETY:
         // - `self.current` is a valid node by the type invariants.
         // - We have an immutable reference by the function signature.
@@ -750,7 +750,7 @@ pub fn current(&self) -> (&K, &V) {
     }
 
     /// The current node, with a mutable value
-    pub fn current_mut(&mut self) -> (&K, &mut V) {
+    pub fn current_mut(&mut self) -> (&'a K, &'a mut V) {
         // SAFETY:
         // - `self.current` is a valid node by the type invariants.
         // - We have an mutable reference by the function signature.
@@ -831,16 +831,16 @@ fn mv(self, direction: Direction) -> Option<Self> {
     }
 
     /// Access the previous node without moving the cursor.
-    pub fn peek_prev(&self) -> Option<(&K, &V)> {
+    pub fn peek_prev(&self) -> Option<(&'a K, &'a V)> {
         self.peek(Direction::Prev)
     }
 
     /// Access the next node without moving the cursor.
-    pub fn peek_next(&self) -> Option<(&K, &V)> {
+    pub fn peek_next(&self) -> Option<(&'a K, &'a V)> {
         self.peek(Direction::Next)
     }
 
-    fn peek(&self, direction: Direction) -> Option<(&K, &V)> {
+    fn peek(&self, direction: Direction) -> Option<(&'a K, &'a V)> {
         self.get_neighbor_raw(direction).map(|neighbor| {
             // SAFETY:
             // - `neighbor` is a valid tree node.
@@ -850,16 +850,16 @@ fn peek(&self, direction: Direction) -> Option<(&K, &V)> {
     }
 
     /// Access the previous node mutably without moving the cursor.
-    pub fn peek_prev_mut(&mut self) -> Option<(&K, &mut V)> {
+    pub fn peek_prev_mut(&mut self) -> Option<(&'a K, &'a mut V)> {
         self.peek_mut(Direction::Prev)
     }
 
     /// Access the next node mutably without moving the cursor.
-    pub fn peek_next_mut(&mut self) -> Option<(&K, &mut V)> {
+    pub fn peek_next_mut(&mut self) -> Option<(&'a K, &'a mut V)> {
         self.peek_mut(Direction::Next)
     }
 
-    fn peek_mut(&mut self, direction: Direction) -> Option<(&K, &mut V)> {
+    fn peek_mut(&mut self, direction: Direction) -> Option<(&'a K, &'a mut V)> {
         self.get_neighbor_raw(direction).map(|neighbor| {
             // SAFETY:
             // - `neighbor` is a valid tree node.
-- 
2.43.0


