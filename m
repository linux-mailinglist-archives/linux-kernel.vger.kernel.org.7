Return-Path: <linux-kernel+bounces-890103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70BCC3F3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEE83B3589
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1B431814A;
	Fri,  7 Nov 2025 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O0dNUkZi"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E15302155;
	Fri,  7 Nov 2025 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508470; cv=none; b=b28wA/5NGyG5pwQFCuwWh89Jk5cyvyxy/WEJOZCLBo7UCj1uVMAEq5k7WTqrSUwUBp91jbRgEwbRe2qrXqTe70ydMf4vA5OPfh5GNrD66j+x3vAIWNEAc1AGNZ3NHHyGrlSyAM40zcboOr/AHhDuXc0TuYRYQcGk0MW6qQZiu70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508470; c=relaxed/simple;
	bh=HU9e2vnNjxWlIhwA3QVCisFinU2zTQ4zAQwQ/T99kHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PS0ZKllOwLr/93zTSAijVxZWFhw03S2LTIn1AG/++Mjowg/tjHHWM2wY9w85rBmDs8WwZY27PC+747NJ3tKAKu67dulTTIX3C79Lau1jabN38NMgQ2GXrpPmlWLqrBY+uhFQNwNeEFb/6RNqIJxfXnjeXk3B3As5ytoBlzHAjT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O0dNUkZi; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Z9
	Z2z6lYD454SSTMg93od2aYjbd6mTtEGW7aRBQLsbU=; b=O0dNUkZiLMXp+YwniD
	J2pSzdqcH0nXlcy7RZUj7aqdrwHBCrqVSJStr7JL/VbFn5k0Duvx/XV0LkTLjWr+
	VtQtayTfQ9H6oKgi4ROzK3QYT4uRXg1o1Fo3gY49WHGerqtb3EsM3mF75mXltwPY
	hNogOsZH2+/gbkZhsdHw5oVok=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3l5JQvg1pZnE4CQ--.925S2;
	Fri, 07 Nov 2025 17:39:30 +0800 (CST)
From: Hang Shu <m18080292938@163.com>
To: ojeda@kernel.org
Cc: Hang Shu <m18080292938@163.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Borys Tyran <borys.tyran@protonmail.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Daniel Sedlak <daniel@sedlak.dev>,
	Charalampos Mitrodimas <charmitro@posteo.net>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Matt Gilbride <mattgilbride@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: correct documentation comment for rbtree cursor peek_next method
Date: Fri,  7 Nov 2025 09:39:17 +0000
Message-ID: <20251107093921.3379954-1-m18080292938@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l5JQvg1pZnE4CQ--.925S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr18GryfKFy8tFWrXr1rXrb_yoWfZFg_Ga
	90qr1fAay09FWjvasxJws3ZFyfKw1xGF4Fkw17KrW7Ka45CF45JrnYgr98Z3sxG39Fvr9r
	ZFnaqa9rKw129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtmiiUUUUUU==
X-CM-SenderInfo: bpryimqqszjmity6il2tof0z/1tbizRH+kWkNvEskdQAAsx

The peek_next method's doc comment incorrectly stated it accesses the
"previous" node when it actually accesses the next node. This commit
fixes the documentation to accurately reflect the method's behavior.

Fixes: 98c14e40e07a ("rust: rbtree: add cursor")
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Hang Shu <m18080292938@163.com>
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


