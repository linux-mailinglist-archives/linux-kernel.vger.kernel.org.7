Return-Path: <linux-kernel+bounces-861221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E059BF21DD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26BDD4F9C26
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FBE2690D9;
	Mon, 20 Oct 2025 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW4NEmcD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098D21B9C5;
	Mon, 20 Oct 2025 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974054; cv=none; b=nji/QFr9RBzuusgYneYGtQOSmU350xoqrzmHilm/Yg87aWWoQKZBIqXZx3UJemi6+eNSm/UOs5pnIvsXVvo5CQLQIngg3HWHTsIGRSoA3Z+sPvzyAptVKRxlCG6wusvL1J/TKn84s8yW6V6fr7FjZaTc6UpDj6/OqI0Ul9pujrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974054; c=relaxed/simple;
	bh=laqYjU2YEjT+EsRes/yYLVhr2HXH5lWPRM0SbrX/h4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RfcFFivKqTu7aPNhOwa/0AIv3t7LwhKIorDxmKKq/t53/E2Niwt9xPTRtqs7zVSIT4VvGLXTgVxqZkVLpvGwmNa2H+1aT0Yvc/QrLhhWdKmv6cAQ5GoXPk7x4Qfpo8yTqOdEtDFRkyrdCk4RXHv+hRECuLGG3EgX4NZW0SpGzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qW4NEmcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5E8C4CEF9;
	Mon, 20 Oct 2025 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760974053;
	bh=laqYjU2YEjT+EsRes/yYLVhr2HXH5lWPRM0SbrX/h4k=;
	h=From:Date:Subject:To:Cc:From;
	b=qW4NEmcDj7ugpaqTo+vGQ004hJcMg0Ehsc8MblOJhkVEBP3L1eG66qhMXGKnK7yLp
	 0emLMBbQWc40d+dcQvrQzRIkT7leJbxwVAq4KnU6X2Ht01oqTo0b7GSaIRQutj+V46
	 fLIQrEhf7nEXjOj+bUZKXpwguyVOHFgxakvGUN5YYTP7hsJdoWQETtXu62BocJYNG+
	 mtCw8/1R/4FFAtbWrrfa8LSyY8wu5HEuxqmej3wFLFQnOO5eGfnznWpT2beR+ReyRK
	 LFTAwnwMRyfov48AmoZJIDTlV3OkpDfPE4I+SdN361WTOGaKCg33mK2sS3nxdD7I7f
	 6SRFO11HsWJgA==
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 20 Oct 2025 11:27:28 -0400
Subject: [PATCH] rust: fix tests under Rust 1.89.0's `CStr` `Debug` impl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251020-cstr-debug-utf-8-v1-1-1933c0a6d6b9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN9U9mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMD3eTikiLdlNSk0nTd0pI0XQtdi1TLZBPjRMMkc1NzJaC2gqLUtMw
 KsJHRsbW1AEFu9gdiAAAA
X-Change-ID: 20251020-cstr-debug-utf-8-8e9c43a1b757
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760974050; l=1833;
 i=tamird@kernel.org; h=from:subject:message-id;
 bh=laqYjU2YEjT+EsRes/yYLVhr2HXH5lWPRM0SbrX/h4k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO94MP6//4/gXN06fOYflr7yBUZtP4A4RddSYIvuBliEb+OZxmlJA49jpSANQ48Wx7AveFJEZAZ
 7QTSqaGnO4gc=
X-Developer-Key: i=tamird@kernel.org; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Starting with Rust 1.89.0, `<CStr as Debug>::fmt` prints UTF-8 sequences
unescaped.

Thus update our test to expect the new behavior starting with Rust
1.89.0.

Fixes: a1ec674cd709 ("rust: replace `CStr` with `core::ffi::CStr`")
Link: https://github.com/rust-lang/rust/commit/a82062055af1ecdcb7f4d3371855aae843fc0ae3
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
Hi Miguel, please feel free to rebase this in, if easier.
---
 init/Kconfig       | 3 +++
 rust/kernel/str.rs | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49..aa29eae7f14b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -156,6 +156,9 @@ config RUSTC_HAS_SPAN_FILE
 config RUSTC_HAS_UNNECESSARY_TRANSMUTES
 	def_bool RUSTC_VERSION >= 108800
 
+config RUSTC_HAS_CSTR_DEBUG_UTF8
+	def_bool RUSTC_VERSION >= 108900
+
 config RUSTC_HAS_FILE_WITH_NUL
 	def_bool RUSTC_VERSION >= 108900
 
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index da539e1f29d4..f2d60288eced 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -478,7 +478,11 @@ fn test_cstr_debug() -> Result {
         let non_ascii = c"d\xe9j\xe0 vu";
         assert_eq!(format!("{non_ascii:?}"), "\"d\\xe9j\\xe0 vu\"");
         let good_bytes = c"\xf0\x9f\xa6\x80";
-        assert_eq!(format!("{good_bytes:?}"), "\"\\xf0\\x9f\\xa6\\x80\"");
+        if cfg!(CONFIG_RUSTC_HAS_CSTR_DEBUG_UTF8) {
+            assert_eq!(format!("{good_bytes:?}"), "\"🦀\"");
+        } else {
+            assert_eq!(format!("{good_bytes:?}"), "\"\\xf0\\x9f\\xa6\\x80\"");
+        }
         Ok(())
     }
 

---
base-commit: a1ec674cd709fec213acbb567e699c5f6f58cb60
change-id: 20251020-cstr-debug-utf-8-8e9c43a1b757

Best regards,
--  
Tamir Duberstein <tamird@kernel.org>


