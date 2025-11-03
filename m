Return-Path: <linux-kernel+bounces-883677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A37C2E0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B5F1899FEE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507C52C031B;
	Mon,  3 Nov 2025 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtAllsmY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4902BE62C;
	Mon,  3 Nov 2025 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762202387; cv=none; b=aP0Mhm8wYAkny49N63t6IAorrp9nT2AJNZC66CJukHhmIbCUZqX2fgcq44FAYEeDO4PT8bi47x4Z20lcQex59aSHIc2imha6bOS97jig8r0gVG1Wgo1DvPPj8e21ofjkcGShsW6JQqtocgpQ3oa9BbzoW5iV3pZSQMeKFuudQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762202387; c=relaxed/simple;
	bh=CKJ2dWX29pHh2c/Go2eprsCctu1UnilG+O/Qxm33fRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbt3YV92wN6Dcn9NuRrOzrN7+EZyNeqwosq3sSMd8nrlqd9Oy3i8+yJc3S6ro6sECNzIHmOC4eh5cWByutWCMl2CNlHBP/DO8bAzmm3oM/myOloVIqV2DxKkGXVontpoj5QnWtzZx1yLOkC6Q4jx8TWtcDUFNjUhW5Dgeccx2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtAllsmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4FFC4CEF8;
	Mon,  3 Nov 2025 20:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762202387;
	bh=CKJ2dWX29pHh2c/Go2eprsCctu1UnilG+O/Qxm33fRA=;
	h=From:To:Cc:Subject:Date:From;
	b=CtAllsmYimFLNBJQZsNdA6iwh16lghl252i+v5lbfgcn6FKDIdS9GhQVS4gJqKNB8
	 qDy2MdyUsjeFc9OsQ0GoKeVd3hN9QO3nTedxbR/hI3h4fbOTV2FYk4z/P7fptyNbGb
	 8GBHV4pVcI026seepRe/KEcZW4zd1r7SQEeKBiYoXkFOJOLQV3cuUoQ7a7hynu7983
	 t9UZYC8vfIxjx/LsioG57G4SC6y5HSanQ8a88ozOvq1BIEru4NJfxB0SeSH9wjvZoF
	 e8CykFicE3JwTVpdZaT5GKGIaUR7/7iokB6UmUsRt7a/BK+OKgljUAzSPH+wbUsLi/
	 zeyVpZN2ZAs0g==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] rust: auxiliary: fix false positive warning for missing a safety comment
Date: Mon,  3 Nov 2025 21:39:18 +0100
Message-ID: <20251103203932.2361660-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some older (yet supported) versions of clippy throw a false positive
warning for missing a safety comment when the safety comment is on a
multiline statement.

warning: unsafe block missing a safety comment
   --> rust/kernel/auxiliary.rs:351:22
    |
351 |                 Self(unsafe { NonNull::new_unchecked(adev) }),
    |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    |
    = help: consider adding a safety comment on the preceding line
    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#undocumented_unsafe_blocks
    = note: requested on the command line with `-W clippy::undocumented-unsafe-blocks`

warning: 1 warning emitted

Fix this by placing the safety comment right on top of the same line
introducing the unsafe block.

Fixes: e4e679c8608e ("rust: auxiliary: unregister on parent device unbind")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index cc67fa5ddde3..618eeeec2bd0 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -341,13 +341,12 @@ pub fn new<'a>(
                 return Err(Error::from_errno(ret));
             }
 
-            // SAFETY: `adev` is guaranteed to be non-null, since the `KBox` was allocated
-            // successfully.
-            //
             // INVARIANT: The device will remain registered until `auxiliary_device_delete()` is
             // called, which happens in `Self::drop()`.
             Ok(Devres::new(
                 parent,
+                // SAFETY: `adev` is guaranteed to be non-null, since the `KBox` was allocated
+                // successfully.
                 Self(unsafe { NonNull::new_unchecked(adev) }),
             ))
         })
-- 
2.51.0


