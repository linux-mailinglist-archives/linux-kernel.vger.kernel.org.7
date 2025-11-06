Return-Path: <linux-kernel+bounces-888342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D925C3A904
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96FA463355
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C43D30DEC8;
	Thu,  6 Nov 2025 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dFXgyogD"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634430BF66;
	Thu,  6 Nov 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428125; cv=none; b=XMuhpbkDujyrshbVSgYY47bakgDQpPlgcEHxPcXAW5EkoLumUdZ1i/dte1Ex/nG5BpQks+9IWqJuwET5M7l4uMQRaC0Rsq/vrBO6AsNoS9fWvISpo5LMRPbfKo1TKwnha0GUpfl4ob6qVeR6hxKh/7PP24ArjHUSLo1BqT4CTAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428125; c=relaxed/simple;
	bh=NdLfAVUeT/ytNabjs6xqCGDoi9eV7GZq2NHkn8N7lpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSlAl6gBxljChr9IeiTZbpbXLubxhEhxjNIVFY6G6xx6p2fNZiCAXEJ9ChOQQ3lY5ZCLS8/dkYJ6ELarPOOuRCJo0AaNSSAVHf5+EeYuQZUYcblIXmHdVjEjZPI3Py1AP7QM7MvsxEb5Km+9/IC/3a3BObQC6LiU20tqIVuzpAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dFXgyogD; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=GG
	Jr17qKdc34PltHTdQzC51mfe8l8hdR3MCBbmWEcEo=; b=dFXgyogDuJiUNiQwLH
	wEQ/wPeTzeXzM7jw6V/9ZDadcQUG+b2m1m4w84Nr07f8RsNcHjilqBB6Ilu5Yriq
	9fYquEEQokg/hMD1xUXK1sze/BJ8hc466s0ADqJd4o3sqE5Qt6+5AKl9TsOaN7l2
	bxsj54J11wALcl9VpOngMy1tI=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3d6+dhAxpkL8BCA--.11322S2;
	Thu, 06 Nov 2025 19:21:02 +0800 (CST)
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
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: correct documentation comment for rbtree cursor peek_next method
Date: Thu,  6 Nov 2025 11:20:14 +0000
Message-ID: <20251106112015.214867-1-m18080292938@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d6+dhAxpkL8BCA--.11322S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr18GryfKFW5ArWftry3CFg_yoWfJwb_WF
	n0qF18Aa48uF4qvasxArs3AryIgr4fGr4Fkw17KrWUKryUCF4UJrn5ur90q3s3W3yIgrZr
	Zr1Sg3WDKr17JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMPfHUUUUUU==
X-CM-SenderInfo: bpryimqqszjmity6il2tof0z/1tbiPQL9kWkMgeMtigABsy

From: Hang Shu <hangshu847@gmail.com>

The peek_next method's doc comment incorrectly stated it accesses the
"previous" node when it actually accesses the next node. This commit
fixes the documentation to accurately reflect the method's behavior.

Signed-off-by: Hang Shu <hangshu847@gmail.com>
---
 rust/kernel/rbtree.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index b8fe6be6f..9e178dacd 100644
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


