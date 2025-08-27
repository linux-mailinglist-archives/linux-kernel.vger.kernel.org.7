Return-Path: <linux-kernel+bounces-788369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA4EB38370
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B04446196D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128B6352074;
	Wed, 27 Aug 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRLt6OIO"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45BF212D83
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300345; cv=none; b=TxDrl/nufZf5Ri1T9LS+MxHlhP67btWNHbvHP/G7XJ8vkFyF4SDNbl1k4eVy1XDd5oJDH/m2X3XdhklOhGDrg2laOR5eyMvUosa+gLg0VasA50zOQ4yOf9it1RNehtFTOYFCBnGlh4ApoKGvoR7KxhwIfTUC17JGpCXAgSjvLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300345; c=relaxed/simple;
	bh=wWgdQ19EGsKqy61U2HJjYn18KusjjHaNd+N0E7bCBB8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hnp6H2hxEr2zZpsX4VDeNCJKK/5UKocsbP/quVA8cHpvILbfAmShYUyZ4lPj8/n2Bib1lyznWLPIP/v4ZO+XUyUBMWbLC5vBWaHmDV9u+OGI5Ms0o5kP8rRRF0gqlsf9rS0ZP7DtlsssdFUpSnuZlXhVx24nTBpLWaDFRsXQxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRLt6OIO; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b72ef3455so2236525e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756300342; x=1756905142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M/qj0KIxW19sF8WYNMWnzatZZJgCn+BfMx+Tm/YHX/8=;
        b=KRLt6OIOKjVIGyZQ7m5KeZcI0LlIyNdTvaOctPE8K4201YDfdM0e6d9ZutFbzZO7wQ
         A+8ViBNWAve1NlVxTcT8KeBBGNEAfRMZRd9DETYmUxgqOfzPtOQjKMQowSr1+t8x1y8h
         qVec1l+F7Jl5BOnEodFlCmjkCmatPwjOwiv55oW5aKA8A9EfC5WkiKYYnK1zCJbBWAy3
         LeLLZNjhNXcYTlcWh2V07KTWKsld17XQ2+CYHdv3t9QEV80HabFMSnHTBf6ndAa2swoR
         O778ojvFelWds2Mj6S9OwlP+20tSnSc3QY9GiibvyMHRroyqAr9f8cNW1ZJPMTPuMi1n
         DD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756300342; x=1756905142;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/qj0KIxW19sF8WYNMWnzatZZJgCn+BfMx+Tm/YHX/8=;
        b=O030rIoe8OwkUXix4RPjgBJEzw95zPc/Bi10dMWAFsYr13DJ8nZKVVttKWJwX3oFnF
         M1cdBaFPw+kpkUY+Z8XdLtLs5uns5fn51Dx+YSogzNu9tEons7t554gAyxtmyXJdFFqG
         wm43CDUXVo+7EXj8ybf3GmOdGuxahMX5v/HOebs3i3zYjZirkl+2xpEsDOCUuMZLSHKC
         cahUB6ow6Sam13eryxHGP+qubpvGdSejZUJJG6coSDwwUVbuCwvsDd1UgvQ2jo0q/Xkw
         J1P8twwlUFNIVoC2AcbL8FRfCnMiDNyPiRe+Hvd2MpktIM2k8ON/mS0pfTbvJqvw1rSi
         2SvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc6XGOm/jgKGliBtbcVqiDAW3XigOYid4aRdsQJ4dO02pA9takVow1i63n+o74SUaP7pboN9s69WBPkL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypJPZ7azEXhvJXAqGQoGG5ARTdNW/IwGAXWyYBVLhPA/QBzzRs
	IDwD5NO7vzcgYvEub5sXYd00CipuEW+aCC/d/4/9xm3Z7LvU9GLJeSUvZYDtdQ5SvHDk+2dkWda
	y40eQ0Tuuqycq8NqQxw==
X-Google-Smtp-Source: AGHT+IHVNAAr6r5+Sc9GkH6RCMEf2jv4KsDL+gLsBCc26wh6BssKXaIo+LMJNL2lUuU+ghV6Ys4ZoghECk17F8E=
X-Received: from wmbip38.prod.google.com ([2002:a05:600c:a6a6:b0:458:c0b7:b936])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4450:b0:45b:74fc:d6ec with SMTP id 5b1f17b1804b1-45b74fcd8a2mr4734675e9.8.1756300341900;
 Wed, 27 Aug 2025 06:12:21 -0700 (PDT)
Date: Wed, 27 Aug 2025 13:12:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC8Er2gC/x3MQQqAIBBA0avErBNMjKKrRIjpWANh4UQE4t2Tl
 m/xfwbGRMgwNRkSPsR0xoqubcDtNm4oyFeDkqqXoxpEoAONZeMM30ms2mt0VjvUEmpzJQz0/r9 5KeUD8izZol8AAAA=
X-Change-Id: 20250827-file_as_c_str-b4d4eca4ce40
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2971; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=wWgdQ19EGsKqy61U2HJjYn18KusjjHaNd+N0E7bCBB8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBorwQ0SweBT52ZKqzEy9Ic1TSli1rd7xjmeOxZ3
 Rtip6cBfIyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaK8ENAAKCRAEWL7uWMY5
 Ri5BD/43dy44+pzK34gqb4BEHKa+p5nEaIqfUjGDWTJ6fRUk/Pjh+T9olj2AMAaORkQLqDRX78r
 MZsHcy0h358g7XLoTGnYQZwdjAwXSmYP+Hgsdn9Pu3MbeAD0okEhqBKblDzXtgQ539YOJJL3SA3
 WF/YPsNjQe5f240BvOvbuxnusXAYtxihSq/dDrNISqYvBU/ksQ3EM9Hm+wiO6umm6f+BwLRNNaA
 mSbwAZUp7TH4Pv/wXiG9sdwUAeqjVewLuTbdMH9Gg+7DgddtEr2zlahpkoKFp1XpGRGlXxHJ/TM
 tJz41EPpdS430qOohanPKm+kIuKzD9+ovJEXgMxLZWGnyLg2akmVUhwMt0qKh9RojNy8toKRKnR
 2rY6fbPU1PHkdyrYQJT9AOuS65Yne1iAM4wK5ud4A/e0LsS8mTZpeM5QztG3kV2vpFVPY14NK36
 FHXA9PM1QVb0rhlz81MVM7RFZs/P4dKiAuJQPpOfaAgoaTUeZjKKrLgGYf7J4yKt4mPfngCD/hs
 sDLruYFuakvq90/VNzz0w1sK0TqQQ8PARlUFNkvIFiObIRBLu2016Okm9Aw1/voSjHfK+Q5ogOt
 nD9xFCh0LSn9GP8/m3i5Qg3qHRkH3z2XbSI57Ez+9LlJ4OILPwdO/hDGWnOW4SjN6AsDeEqNB8n 8DXSb/0ZjdPOfjQ==
X-Mailer: b4 0.14.2
Message-ID: <20250827-file_as_c_str-v1-1-d3f5a3916a9c@google.com>
Subject: [PATCH] rust: use the new name Location::file_as_c_str() in rustc 1.91.0+
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

As part of the stabilization of Location::file_with_nul(), it was
brought up that the with_nul() suffix usually means something else in
Rust APIs, so the API is being renamed prior to stabilization. Thus,
adjust Linux to use the new name on new rustc versions.

Link: https://www.github.com/rust-lang/rust/pull/145928 [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This hasn't been merged upstream yet. It shouldn't be merged until that
happens.
---
 init/Kconfig       |  3 +++
 rust/kernel/lib.rs | 15 +++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 83632025121937527523f5977a493bd3ae24ed9f..e7459cbea6ca800e56a1e54423e399b689557885 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -145,6 +145,9 @@ config RUSTC_HAS_UNNECESSARY_TRANSMUTES
 config RUSTC_HAS_FILE_WITH_NUL
 	def_bool RUSTC_VERSION >= 108900
 
+config RUSTC_HAS_FILE_AS_C_STR
+	def_bool RUSTC_VERSION >= 109100
+
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c0badf548025a57f946fa18bc73e3..604069b1bd5c373d2ad8419872a358a8d01d0bb5 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -296,7 +296,7 @@ macro_rules! asm {
 
 /// Gets the C string file name of a [`Location`].
 ///
-/// If `file_with_nul()` is not available, returns a string that warns about it.
+/// If `Location::file_as_c_str()` is not available, returns a string that warns about it.
 ///
 /// [`Location`]: core::panic::Location
 ///
@@ -310,8 +310,8 @@ macro_rules! asm {
 ///     let caller = core::panic::Location::caller();
 ///
 ///     // Output:
-///     // - A path like "rust/kernel/example.rs" if file_with_nul() is available.
-///     // - "<Location::file_with_nul() not supported>" otherwise.
+///     // - A path like "rust/kernel/example.rs" if `file_as_c_str()` is available.
+///     // - "<Location::file_as_c_str() not supported>" otherwise.
 ///     let caller_file = file_from_location(caller);
 ///
 ///     // Prints out the message with caller's file name.
@@ -326,14 +326,17 @@ macro_rules! asm {
 /// ```
 #[inline]
 pub fn file_from_location<'a>(loc: &'a core::panic::Location<'a>) -> &'a core::ffi::CStr {
-    #[cfg(CONFIG_RUSTC_HAS_FILE_WITH_NUL)]
+    #[cfg(CONFIG_RUSTC_HAS_FILE_AS_C_STR)]
+    {
+        loc.file_as_c_str()
+    }
+    #[cfg(all(CONFIG_RUSTC_HAS_FILE_WITH_NUL, not(CONFIG_RUSTC_HAS_FILE_AS_C_STR)))]
     {
         loc.file_with_nul()
     }
-
     #[cfg(not(CONFIG_RUSTC_HAS_FILE_WITH_NUL))]
     {
         let _ = loc;
-        c"<Location::file_with_nul() not supported>"
+        c"<Location::file_as_c_str() not supported>"
     }
 }

---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250827-file_as_c_str-b4d4eca4ce40

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


