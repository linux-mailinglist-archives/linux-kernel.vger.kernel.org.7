Return-Path: <linux-kernel+bounces-774639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00195B2B56A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0B337B2C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E0E17A2E0;
	Tue, 19 Aug 2025 00:39:24 +0000 (UTC)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8BC156F45;
	Tue, 19 Aug 2025 00:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563963; cv=none; b=hjwitRM0hq7chtWYMgk0pbYU+LbsAMgqngsA6BxAfI+uNdHyEPHIov6Qwu7ND/4lHalm8gc8LNFUJ8xFu+UpjYg3N0bChKAhOTFukfZfbzxTNA48LCufAzAjBQZkFIB6YVIrhiv2XNFESfZ3106th2q3S7CX07gjz3z2OuA97KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563963; c=relaxed/simple;
	bh=9ctqvRAbXHv64kcfdPUKxqZBp+Y1HtMMeudgGBWW9FY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucVzbG1/8G1qCcreG1JDnfhNlz83g0AatWPA4eCb8OP9/d1Liy7KWUYwrnrFmJKprbEiFPDX6+hW1TPQKQa4mQqgoJijdR6vAmvaXVYJXdCu6xqn/8kORsRwsx9OK6BjxWVbD3eN46i5ICTmKCCO0FONFMIN4qG3UkKbTm2LQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=antoniohickey.com; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antoniohickey.com
Date: Tue, 19 Aug 2025 00:38:56 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Antonio Hickey <contact@antoniohickey.com>
Cc: Antonio Hickey <contact@antoniohickey.com>, Daniel Cote <danielstonecote@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] rust: uaccess: refactor to use `overflow_assert!`
Message-ID: <20250819003824.23019-3-contact@antoniohickey.com>
In-Reply-To: <20250819003824.23019-1-contact@antoniohickey.com>
References: <20250819003824.23019-1-contact@antoniohickey.com>
Feedback-ID: 144211621:user:proton
X-Pm-Message-ID: 24ccb59df20558e67dcd9b99c5d6f80f9cdaab96
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Using the `overflow_assert!` macro here adds documentation to
the intent of the assertion, and avoids local `#ifdefs`s by
encapsulating the conditional behavior to the macro itself.

Co-developed-by: Daniel Cote <danielstonecote@gmail.com>
Signed-off-by: Daniel Cote <danielstonecote@gmail.com>
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1159
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/uaccess.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index a8fb4764185a..cbf201ebd426 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -9,6 +9,7 @@
     bindings,
     error::Result,
     ffi::{c_char, c_void},
+    overflow_assert,
     prelude::*,
     transmute::{AsBytes, FromBytes},
 };
@@ -499,8 +500,7 @@ fn raw_strncpy_from_user(dst: &mut [MaybeUninit<u8>], s=
rc: UserPtr) -> Result<us
         return Err(Error::from_errno(res as i32));
     }
=20
-    #[cfg(CONFIG_RUST_OVERFLOW_CHECKS)]
-    assert!(res <=3D len);
+    overflow_assert!(res <=3D len, "strncpy_from_user wrote past dst buffe=
r length");
=20
     // GUARANTEES: `strncpy_from_user` was successful, so `dst` has conten=
ts in accordance with the
     // guarantees of this function.
--=20
2.50.1



