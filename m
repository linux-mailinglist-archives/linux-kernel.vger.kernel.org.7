Return-Path: <linux-kernel+bounces-762572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50494B2088C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAD217D94F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E722D3A85;
	Mon, 11 Aug 2025 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVdQUQw7"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D512D374A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914493; cv=none; b=F1hkcaFFefQ0sJ1snvSbgcv63/zmLSS4X5LLQsU59cdsSdgr/RT8hq/wOIeyKCZ8y1jmoGQDchBlp5aTepb4DtQbkikyeYFYrd1FYbLorezdNAEA2U8F0DTZhemnt34NAmoaUWYoDfI8xUBpYpztE+CT9LdCJ0GKiqLoJNGELhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914493; c=relaxed/simple;
	bh=OmGO8RZeQs5efNIOEB082lvBPWWzyt5OcEhCesBZVdo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=emHPAyrMS2fmNFyCtBTJfpN4UVUagJ0zfdkK5Ro71w5sMHUYzig5ZNPqlE8p/+RS5hzRBwN4Q370XGVbonGsTDja35H4GEfyWjPVbJxBXgTMZbNqGkZO3FO2Mcafa0ZUMk4gOSbwfHHfniqYce27hU1pshLYKuqfMPn3W1x4vG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVdQUQw7; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45891629648so24708125e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754914490; x=1755519290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RrWdq+nHc027wwNUZR6dfCVUulevY4FTq+xdy09PBac=;
        b=fVdQUQw7a4EidMuzAQqNC3ErX39Rk833vH+87Q1yjeMcmjeZgYna0rCY136HFA2caJ
         BEij09vTYOuXNnl99WvKM3WZqbzsbB2Fv0kUWvXYzCPkFeyuxSQsRGICnnmuFW8oOfNX
         YygFvLPndsvyzoHcTjpFpSiZISguj877NZKDEy+caRC7aJZus2f8r8+pzw9jhr5ThwZS
         /++WEX7z3ipnCGZ9na1qlOvq+n4a0vnEQ+tXHHUwXlYFiW4VvMS4wBhQ7mCJypDYvfR5
         a2rfxe98T7htDIs0/75o1IY+cYr3M0ozuR0H/QSjzrr0Bu1RqHh5WrQZIZ3lzSsuAagU
         0xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754914490; x=1755519290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrWdq+nHc027wwNUZR6dfCVUulevY4FTq+xdy09PBac=;
        b=c3zLlqRm7OIsn4+7nc/8u3UT2PVDeP7YixBchuTWw5aYuxJ8Kw1RiMUndUcMeZVUBQ
         9gE5Zq+5k050HEWUA/f4+EYSvLCPBxDElm3Ow0vcSkJuJMoDuhZtZK/yJl7lzBezu+kJ
         TyrCqTjjlkdNugRkUxZ6UwpjfYz8Lmnr3vNtx1LqtWnd+XVgWatDGVTDsMOwwC+Reo6L
         y2e736HFaNxrLqx2TM/5pmaOWyPYdutS6gb+VpdB6vU6dKXnMUizKLkv1Z5boDVr6URR
         UcvkOEh3nGRK2YuR4CRUuKWb4m9TJAZnnYXsigQ+Yk2SfexE1Sdk4Pmhwi/qRNn3xeZ0
         05gA==
X-Forwarded-Encrypted: i=1; AJvYcCVu48F2PVKl2t330d2qlUWBUhp95ruvGQywoz9hX39lrplcPNg4fHAWCnKRTbW8B6LjrrZKXy7oC71ctDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywskx9969sYa48vg9xsuhOnO575Ud9ZwdqAMv6YFNMLbo6l/FkZ
	oR1ieGtg5gbWKc5hkchqdkjU5UQKqxfU2XeeBI9PlQ0ZhF3DUDo7FkJBsGdnsNqVZxsfJyYglLX
	0oFrHSWzC6u7qXLiwFg==
X-Google-Smtp-Source: AGHT+IFI5B+dFc02etCEUKNGMEZzOXhjeeTvJA6aGthcx6enDt6qD5PZBf2EjRLWbCEEEEXiEkI0kVaRy9+vo7k=
X-Received: from wmbei22.prod.google.com ([2002:a05:600c:3f16:b0:459:e0a8:599b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e19:b0:456:2257:3777 with SMTP id 5b1f17b1804b1-459ede7d661mr135103285e9.4.1754914490257;
 Mon, 11 Aug 2025 05:14:50 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:14:41 +0000
In-Reply-To: <20250811-lock-class-key-cleanup-v3-0-b12967ee1ca2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811-lock-class-key-cleanup-v3-0-b12967ee1ca2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2867; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=OmGO8RZeQs5efNIOEB082lvBPWWzyt5OcEhCesBZVdo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBomd640Ujz6kdFVkBfzE84lsrEBwE98n3V4lEi5
 fHQnBRhEcyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJneuAAKCRAEWL7uWMY5
 RgRYD/46ybwSfMP6I/o49KD7nYZHwHvQA+xo6WpE4ebLELz+x7CArpE2zN08y9+D6Az2SsJrDDe
 ib0++BBNy2ShhxCtFe1a5eg8Z4FrZMcl1CfgCd84hpf+WzVJ81E00Te4rJIeSyLHIkkz71bJSSc
 me1lXb4dS4N7qFAT9RGiCMYpBvy44VXFcC3igbHYFJM4w3FrNUjskohQ0J2FbgtRhAp4/Es52iJ
 U25F4UFYkDsr6fKFCyCA6ZRmKfC7qkYAoySAQ57uktWtuAExAtUybf0xf0RhKFmFV2sVXLnxBhP
 sJ8uv6l5tf7To7BMW213JpVnxyny/xEnzDoOqs5dGKZNbeSo3Oe5AGLHY6C5h0HA+IvsbxTGW2c
 KELD1UNLNZJ5sYiWsxS3B67eJFqSKDqSS9leIo+1ra0mbiu4fYSsu+A0Kl6rYJxQw9XTrbmwgJG
 xKj//HcuzysHghpHepQA5kmAVw8c2iZjHP5MRLlxi2AFNcTZsZ00IkmmQiV2dmblibc+FWjfNM8
 BwOdzYZGhuB0iJEPXBhasfP03rUZ1PxV3E+5M81vQMZrQu1mbI90N71yjBV5jHrlHoIpWB3ia1o
 WT+kE1XFaD/06o0OtrOTj2S2otwWQUXDjAODoKF7WUxIzhJQOyjK59BKl9laX+P+K2RxidZYfWk Y8pNOL4vFIu45cg==
X-Mailer: b4 0.14.2
Message-ID: <20250811-lock-class-key-cleanup-v3-1-b12967ee1ca2@google.com>
Subject: [PATCH v3 1/2] rust: sync: refactor static_lock_class!() macro
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

By introducing a new_static() constructor, the macro does not need to go
through MaybeUninit::uninit().assume_init(), which is a pattern that is
best avoided when possible.

The safety comment not only requires that the value is leaked, but also
that it is stored in the right portion of memory. This is so that the
lockdep static_obj() check will succeed when using this constructor. One
could argue that lockdep detects this scenario, so that safety
requirement isn't needed. However, it simplifies matters to require that
static_obj() will succeed and it's not a burdensome requirement on the
caller.

Suggested-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync.rs | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 00f9b558a3ade19e442b32b46d05885b67e1d830..edc75f8713ffb6de4025d7bb7e0a9c30cc66fa99 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -39,6 +39,21 @@ pub struct LockClassKey {
 unsafe impl Sync for LockClassKey {}
 
 impl LockClassKey {
+    /// Initializes a statically allocated lock class key.
+    ///
+    /// This is usually used indirectly through the [`static_lock_class!`] macro.
+    ///
+    /// # Safety
+    ///
+    /// * Before using the returned value, it must be pinned in a static memory location.
+    /// * The destructor must never run on the returned `LockClassKey`.
+    #[doc(hidden)]
+    pub const unsafe fn new_static() -> Self {
+        LockClassKey {
+            inner: Opaque::uninit(),
+        }
+    }
+
     /// Initializes a dynamically allocated lock class key. In the common case of using a
     /// statically allocated lock class key, the static_lock_class! macro should be used instead.
     ///
@@ -95,13 +110,11 @@ fn drop(self: Pin<&mut Self>) {
 #[macro_export]
 macro_rules! static_lock_class {
     () => {{
-        static CLASS: $crate::sync::LockClassKey =
-            // Lockdep expects uninitialized memory when it's handed a statically allocated `struct
-            // lock_class_key`.
-            //
-            // SAFETY: `LockClassKey` transparently wraps `Opaque` which permits uninitialized
-            // memory.
-            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
+        // SAFETY: The returned `LockClassKey` is stored in static memory and we pin it. Drop never
+        // runs on a static global.
+        static CLASS: $crate::sync::LockClassKey = unsafe {
+            $crate::sync::LockClassKey::new_static()
+        };
         $crate::prelude::Pin::static_ref(&CLASS)
     }};
 }

-- 
2.50.1.703.g449372360f-goog


