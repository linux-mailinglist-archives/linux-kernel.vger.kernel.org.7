Return-Path: <linux-kernel+bounces-803061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5B9B45A0F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8881CC02E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D930335E4DB;
	Fri,  5 Sep 2025 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m++qufVq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206A1D79BE;
	Fri,  5 Sep 2025 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081148; cv=none; b=Oz1vvhdldID2ti5hcOpP9ReHmJhJRzI70gspFKJGnw/oY4oztByyepAAQEwVYfbgKqIK+ZHKLKnUCee32rhUl44Pw8RIYVNV2/X3kEIhH2Uycw266NwdbeY2woI9S8Tmsw1cAMrg+GHXQu/pxiNMGZGgxBnjhlylTTQ4d3sv9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081148; c=relaxed/simple;
	bh=UwYf6aiAZ2tzYpnyDEo15hIrDyNLtlmRPc87xthLYrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULrw6gG3542CRKeIJcQyASnEVDUZJ+SbAJsZZ4M8qotuHmqYii/VN9hokwEXxNSHZXzCtyngdnr+TCfQP28ObsTBSrbx7G79hDu0yANaDFtXdGZwV0Cc6Q3MQKU2cAURxJi1zdfcELrs6iV0JAqAzusA/iCgOmDktcT22i4RBOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m++qufVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBA0C4CEF1;
	Fri,  5 Sep 2025 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757081146;
	bh=UwYf6aiAZ2tzYpnyDEo15hIrDyNLtlmRPc87xthLYrg=;
	h=From:To:Cc:Subject:Date:From;
	b=m++qufVqTo/vIBYD63aaEDbBB6qv+XNmGpvDaUZViptafxmpPidrINF58oiDnxBj4
	 ftJQeewbjYRjnT9OElVORe6VxpR4XlJD+9hVKbdeufkk/Gpb4jK8fcKBYWB4LSOP3P
	 m94Gkh71dW1tLebSHsS6d/4UJlx54m23BeMFgPq4FfKYX+0qLvXd7LJaJthmK44Qt2
	 ohPMdm3deoJtLb1kyvPCTVXdCF7WkhqKLGt/0VHYl6CBq32lR+4R0aCe1eNqY8JSqr
	 nY8EkQvY5qcQWyyyO5px0yCecwuH8ha0OpyfuPobvnj+/yusvX5RK4LbpAWgRefce0
	 4WQzWPwQeyk+g==
From: Benno Lossin <lossin@kernel.org>
To: Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Fiona Behrens <me@kloenk.dev>,
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	Alban Kurti <kurti@invicto.ai>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: pin-init: add code blocks to `[try_][pin_]init!` macros
Date: Fri,  5 Sep 2025 16:05:31 +0200
Message-ID: <20250905140534.3328297-1-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow writing `_: { /* any number of statements */ }` in initializers to
run arbitrary code during initialization.

    try_init!(MyStruct {
        _: {
            if check_something() {
                return Err(MyError);
            }
        },
        foo: Foo::new(val),
        _: {
            println!("successfully initialized `MyStruct`");
        },
    })

Link: https://github.com/Rust-for-Linux/pin-init/pull/84/commits/2880a9b898336e2d54f80715f00ce00f21f74d2f
Signed-off-by: Benno Lossin <lossin@kernel.org>
---
I originally wanted to do some more modifications to the syntax of
initializer macros, but I didn't have the time this cycle. See

    https://github.com/Rust-for-Linux/pin-init/pull/69

For the development of that syntax, it's probably going to be like a
closure where in order to support formatting via rustfmt. But it still
needs some disucssion around removing `<-`.

That change would allow having a `let` that binds a value for use in the
initializer. IIRC @Alice, you needed that for something.
---
 rust/pin-init/src/lib.rs    |  2 ++
 rust/pin-init/src/macros.rs | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 62e013a5cc20..8b556b0e106a 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -740,6 +740,8 @@ macro_rules! stack_try_pin_init {
 /// As already mentioned in the examples above, inside of `pin_init!` a `struct` initializer with
 /// the following modifications is expected:
 /// - Fields that you want to initialize in-place have to use `<-` instead of `:`.
+/// - You can use `_: { /* run any user-code here */ },` anywhere where you can place fields in
+///   order to run arbitrary code.
 /// - In front of the initializer you can write `&this in` to have access to a [`NonNull<Self>`]
 ///   pointer named `this` inside of the initializer.
 /// - Using struct update syntax one can place `..Zeroable::init_zeroed()` at the very end of the
diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
index 9ced630737b8..752e77db998c 100644
--- a/rust/pin-init/src/macros.rs
+++ b/rust/pin-init/src/macros.rs
@@ -1202,6 +1202,21 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
         // have been initialized. Therefore we can now dismiss the guards by forgetting them.
         $(::core::mem::forget($guards);)*
     };
+    (init_slot($($use_data:ident)?):
+        @data($data:ident),
+        @slot($slot:ident),
+        @guards($($guards:ident,)*),
+        // arbitrary code block
+        @munch_fields(_: { $($code:tt)* }, $($rest:tt)*),
+    ) => {
+        { $($code)* }
+        $crate::__init_internal!(init_slot($($use_data)?):
+            @data($data),
+            @slot($slot),
+            @guards($($guards,)*),
+            @munch_fields($($rest)*),
+        );
+    };
     (init_slot($use_data:ident): // `use_data` is present, so we use the `data` to init fields.
         @data($data:ident),
         @slot($slot:ident),
@@ -1351,6 +1366,20 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
             );
         }
     };
+    (make_initializer:
+        @slot($slot:ident),
+        @type_name($t:path),
+        @munch_fields(_: { $($code:tt)* }, $($rest:tt)*),
+        @acc($($acc:tt)*),
+    ) => {
+        // code blocks are ignored for the initializer check
+        $crate::__init_internal!(make_initializer:
+            @slot($slot),
+            @type_name($t),
+            @munch_fields($($rest)*),
+            @acc($($acc)*),
+        );
+    };
     (make_initializer:
         @slot($slot:ident),
         @type_name($t:path),

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


