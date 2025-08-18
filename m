Return-Path: <linux-kernel+bounces-772701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D69A6B29632
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33391966F09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2761A242D6E;
	Mon, 18 Aug 2025 01:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Pq+7/l0n"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CED23505F;
	Mon, 18 Aug 2025 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480471; cv=none; b=ZlBvOjoSNRKNdWr1Lro4vgCC6cqauyMl9LnOan9oeBifSzgKnQpYTREAcUn/g3iCoB+G56xDhEwj6Vl8UVgZBuAjQvb0ZHOhLqrF75a8hOEWGyhwL9HYig0JwC50269Q9n7PkvTl6D/6c70nrzXWROhPQ3+3ygctsgUlnA7mjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480471; c=relaxed/simple;
	bh=gMG8MJrWuk/qUqRkiJQCye5ZQGoAL+OWsy+X2CGo3U4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OAoB9On8Fp4N+DZ8TOUvnNiLJhUP7IzD6qdtXni6vpgr2BcCM93xt9WVt1jGOsY6ur+2vxdCw0C18OevK/dRmDryAXRfjN6b7o13xCeHrooX8iPC/pApGDdtKOfN8DMn9sZ8IsKAA8aU/7rEW1WU5i0haR+RHX1TgMjJ1Zg5txE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Pq+7/l0n; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4Q
	SZcLqtO/Xp+X7K7U2xBjh39ylCBB34t0ZX+reOtO4=; b=Pq+7/l0nJ1gOHLBj95
	1jtLW5KYHhY8d3cJHUDYBodO4Ie8ah18lG8rnA343iQg8HPB/yq3YwI//yywajN6
	rSk8DIaLgpP1zWdpgeV6L65wTsAdCBzdx1n6b0xdgmDX49gMhxR+0gSlv/Be6Td/
	t6UST1pNKmNQNkdSX8ZJ9+rdc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXD+tbgaJoNfzABw--.47615S2;
	Mon, 18 Aug 2025 09:26:51 +0800 (CST)
From: lingfuyi@126.com
To: Tamir Duberstein <tamird@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lingfuyi <lingfuyi@kylinos.cn>
Subject: [PATCH] rust: xarray: optimize lock functions with inline attribute
Date: Mon, 18 Aug 2025 01:26:48 +0000
Message-Id: <20250818012648.1841387-1-lingfuyi@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXD+tbgaJoNfzABw--.47615S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw48AF1xJFykXrWfJF1rXrb_yoW8XF17pr
	4DGr17CrW5XF40vw17X395Ga4rW3ySqr45Cr4rKw1Iv39xJF1qkr1Fqr1SvryqyanxAasI
	vFyUuFn0vw4fuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZFxUUUUUU=
X-CM-SenderInfo: polqwwxx1lqiyswou0bp/1tbirxmtR2iie-hvlQAAsv

From: lingfuyi <lingfuyi@kylinos.cn>

The XArray lock and try_lock functions are simple wrappers around
the C functions xa_lock and xa_trylock. These Rust functions don't
add significant logic beyond the unsafe FFI calls and safety guarantees.

Mark them as inline to avoid unnecessary function call overhead in
hot paths where XArray locking is frequent, such as in page cache
operations and other kernel data structure management.

This follows the same optimization pattern as other Rust kernel
modules where simple C function wrappers are marked inline to
improve performance.

Signed-off-by: lingfuyi <lingfuyi@kylinos.cn>
---
 rust/kernel/xarray.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index a49d6db28845..c96589f92927 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -119,6 +119,7 @@ fn iter(&self) -> impl Iterator<Item = NonNull<c_void>> + '_ {
     }
 
     /// Attempts to lock the [`XArray`] for exclusive access.
+    #[inline]
     pub fn try_lock(&self) -> Option<Guard<'_, T>> {
         // SAFETY: `self.xa` is always valid by the type invariant.
         if (unsafe { bindings::xa_trylock(self.xa.get()) } != 0) {
@@ -132,6 +133,7 @@ pub fn try_lock(&self) -> Option<Guard<'_, T>> {
     }
 
     /// Locks the [`XArray`] for exclusive access.
+    #[inline]
     pub fn lock(&self) -> Guard<'_, T> {
         // SAFETY: `self.xa` is always valid by the type invariant.
         unsafe { bindings::xa_lock(self.xa.get()) };
-- 
2.34.1


