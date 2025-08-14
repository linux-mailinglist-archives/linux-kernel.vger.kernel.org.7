Return-Path: <linux-kernel+bounces-768445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B1DB26114
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62E177BEEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877B2ECD3A;
	Thu, 14 Aug 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdXTfgv5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BAD2ECD31;
	Thu, 14 Aug 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163867; cv=none; b=hxjQQdylm/FSOxK4cxo84NCyA0lGpUgfvoFH06EzHP5mssH26j6nUdyTDR45QisdZQ2DxSj6FGzS9lyyAHqe5LvhC3GCd+cMuc4NkN6deh7zZlUi6wNAXrEm2euo8IoONy7PdNcOjUlWlxjkg0/y9LSwXGel1NeUfeQCEbrWWd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163867; c=relaxed/simple;
	bh=YVO3FzmwMn3oydZ+yVwPg+yyh7DVgHFfYq3vuvRJ5+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPMqgzK2F7YiI++WQzIfPy7AA67BPK0FIdyTXXgEl66ZOTSpfJN2sYOTVX9UdSGJfKaXwbMnoOhPiTkzVKLvxT2QgIUPBKuO7+r0R1JAwLdoaHKxmVLjcqw9dKoLl7Pf6J79sfsVLmVkBF/WfZTCCvYxx5qIv3PJvpAiKrsILe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdXTfgv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E690BC4CEED;
	Thu, 14 Aug 2025 09:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755163867;
	bh=YVO3FzmwMn3oydZ+yVwPg+yyh7DVgHFfYq3vuvRJ5+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MdXTfgv5LOM1OlFK+K5zyfLuI8mGHmgJiUZr6B9ijcxiG01igoc+C+Zyz64jL6LZ6
	 BgKoJlBNBQIqAjSl4/2BdNkZKUDjjYJ3jjVuPAuajhXTIzXxXvtgsq/S8qZahUsrXG
	 djHyhpJVplocYB+5mxkrgsAWdMRSDyuuNdOtyXTc8FQA984CPkyOQ6gHEqheEZJWlq
	 IfpwFuxEL+w7eWAmsni9DdYhl+KF+kjuGiwaXL1LqnD0UA3WTr2Y4Dt2PNphT+n+/c
	 YUv0HNyMGhmfF06WXSKvNFJa2EvttszlgsoQksZqkKbJt0jTynlkcsYMvWLJELgIsd
	 eaFfHh2bz/OUQ==
From: Benno Lossin <lossin@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/11] rust: add `pin-init` as a dependency to `bindings` and `uapi`
Date: Thu, 14 Aug 2025 11:30:28 +0200
Message-ID: <20250814093046.2071971-2-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814093046.2071971-1-lossin@kernel.org>
References: <20250814093046.2071971-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows `bindings` and `uapi` to implement `Zeroable` and use other
items from pin-init.

Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/Zeroable.20trait.20for.20C.20structs/near/510264158
Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/Makefile                     | 14 ++++++++------
 scripts/generate_rust_analyzer.py |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 4263462b8470..09d4f389240a 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -184,12 +184,12 @@ rusttestlib-kernel: $(src)/kernel/lib.rs rusttestlib-bindings rusttestlib-uapi \
     $(obj)/bindings.o FORCE
 	+$(call if_changed,rustc_test_library)
 
-rusttestlib-bindings: private rustc_target_flags = --extern ffi
-rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi FORCE
+rusttestlib-bindings: private rustc_target_flags = --extern ffi --extern pin_init
+rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi rusttestlib-pin_init FORCE
 	+$(call if_changed,rustc_test_library)
 
-rusttestlib-uapi: private rustc_target_flags = --extern ffi
-rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi FORCE
+rusttestlib-uapi: private rustc_target_flags = --extern ffi --extern pin_init
+rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi rusttestlib-pin_init FORCE
 	+$(call if_changed,rustc_test_library)
 
 quiet_cmd_rustdoc_test = RUSTDOC T $<
@@ -521,17 +521,19 @@ $(obj)/ffi.o: private skip_gendwarfksyms = 1
 $(obj)/ffi.o: $(src)/ffi.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
-$(obj)/bindings.o: private rustc_target_flags = --extern ffi
+$(obj)/bindings.o: private rustc_target_flags = --extern ffi --extern pin_init
 $(obj)/bindings.o: $(src)/bindings/lib.rs \
     $(obj)/ffi.o \
+    $(obj)/pin_init.o \
     $(obj)/bindings/bindings_generated.rs \
     $(obj)/bindings/bindings_helpers_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
-$(obj)/uapi.o: private rustc_target_flags = --extern ffi
+$(obj)/uapi.o: private rustc_target_flags = --extern ffi --extern pin_init
 $(obj)/uapi.o: private skip_gendwarfksyms = 1
 $(obj)/uapi.o: $(src)/uapi/lib.rs \
     $(obj)/ffi.o \
+    $(obj)/pin_init.o \
     $(obj)/uapi/uapi_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 7c3ea2b55041..fc27f0cca752 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -139,8 +139,8 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
             "exclude_dirs": [],
         }
 
-    append_crate_with_generated("bindings", ["core", "ffi"])
-    append_crate_with_generated("uapi", ["core", "ffi"])
+    append_crate_with_generated("bindings", ["core", "ffi", "pin_init"])
+    append_crate_with_generated("uapi", ["core", "ffi", "pin_init"])
     append_crate_with_generated("kernel", ["core", "macros", "build_error", "pin_init", "ffi", "bindings", "uapi"])
 
     def is_root_crate(build_file, target):
-- 
2.50.1


