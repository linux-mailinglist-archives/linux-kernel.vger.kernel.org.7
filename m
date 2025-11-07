Return-Path: <linux-kernel+bounces-889705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0836FC3E47B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 03:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E22304E87A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 02:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C84B2E091C;
	Fri,  7 Nov 2025 02:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CNy72u2a"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ACCF9EC;
	Fri,  7 Nov 2025 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483726; cv=none; b=VBI65atmHjwgX3psvDYp1xAWbUUT9m44NMftXB5RtJjLq1Od86dYDBkrcv12/NtHwhmV1wFe0KrkHpOkTq1R1frZNg76yoRFvIQOOLhglDo4wXpOW/HERhiaanmndBI8co30NLY4fTnoH8djQgy566fJU/EYEvInBIHmnvr4h3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483726; c=relaxed/simple;
	bh=Nzxc++sU6mUt4sg8GFpT//GCEmkIIBR7C7SAwadAP+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sC4ALIdALIbP+QG2TufbTHpP21x5DgbJnD79SrNnZdfH/iFDGyDk2AffhxN4kXSDFNuANt25sIc8GVtb6J4AGvvE5yiqEq1kKiqUvPipRi4NG8qVze8JgKe9tLyul7Tc58j+mpZq5da6lDWaHcVDnHbZyhbz+VEtb80H1eilQVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CNy72u2a; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bq
	TmSsEZd+iT+od1QkOZ1tdQHRJRxsI2AoEOj94xfW4=; b=CNy72u2aKnljlSCj25
	KRQxao++3j4QN1GE4UrfYZgE5q0luhtwS+VkoDD8k5j4wF6EJZQ4BqcBD0Dnm7bC
	+hxvMbJTA6RGdpEmtTwujXHCVRIQ1Ou4bBGYCEVXYZ2KEMeO+gOycibXdfkcaeVr
	v9g4A1UDHb/Ec4VqYaSGmikUk=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3F9fFXQ1pJFfeCA--.1066S2;
	Fri, 07 Nov 2025 10:47:36 +0800 (CST)
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
	Yutaro Ohno <yutaro.ono.418@gmail.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Borys Tyran <borys.tyran@protonmail.com>,
	Charalampos Mitrodimas <charmitro@posteo.net>,
	Daniel Sedlak <daniel@sedlak.dev>,
	Tamir Duberstein <tamird@gmail.com>,
	Matt Gilbride <mattgilbride@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: correct documentation comment for rbtree cursor peek_next method
Date: Fri,  7 Nov 2025 02:47:16 +0000
Message-ID: <20251107024720.369067-1-m18080292938@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3F9fFXQ1pJFfeCA--.1066S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr18GryfKFyktFyfXF1UKFg_yoWfCFX_WF
	s0qF18Aay8uFWjv3sxArs3AFy0gr4xGr4Fkw17KrW7KFyUCF4UJrn5Wr90qr93GrWIgrZr
	Zr1Sg3WDKw129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0g_-DUUUUU==
X-CM-SenderInfo: bpryimqqszjmity6il2tof0z/1tbiPRj+kWkNW44zwAAAsI

From: Hang Shu <hangshu847@gmail.com>

The peek_next method's doc comment incorrectly stated it accesses the
"previous" node when it actually accesses the next node. This commit
fixes the documentation to accurately reflect the method's behavior.

Fixes: 98c14e40e07a ("rust: rbtree: add cursor")
Signed-off-by: Hang Shu <hangshu847@gmail.com>
---
 rust/kernel/rbtree.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index b8fe6be6fcc4..9e178dacddf1 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -835,7 +835,7 @@ pub fn peek_prev(&self) -> Option<(&K, &V)> {
         self.peek(Direction::Prev)
     }
 
-    /// Access the previous node without moving the cursor.
+    /// Access the next node without moving the cursor.
     pub fn peek_next(&self) -> Option<(&K, &V)> {
         self.peek(Direction::Next)
     }
-- 
2.43.0


