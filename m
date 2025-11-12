Return-Path: <linux-kernel+bounces-897232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F75C5257F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879D93B1106
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8516133711D;
	Wed, 12 Nov 2025 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgTP+NTr"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2928A31326C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951653; cv=none; b=oxN+m7/yOLvZNThxA0JMpNr7UE+PAcfaYDTDp8/3JV2HKXFt5kfYklVrkAGD+4Je0PTtSEV8top5IumZbKScJ5SdbT3wCwKgHoSg2BTiqK+WXd4XcRNgNXuHSWbFdueQsjel6zgwRzJo/5TClpEsUECVjyBkWLFG9WIXZBpd0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951653; c=relaxed/simple;
	bh=jU12ZpgtH991h5e7ZBwBatZK4g5q1U/xD8yC7I7uHME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qXVCdD/TroQj9WZYZKDeJfI4ExGFoyc+p/oGsJwMQuESXQ/x44hlM3uMovbpL9B/vkPhxuCOFVRT3ZKd+oSSFpZQOl02kwrhVGZaKPaYaeJWgD3R41zeKJatElcplE1J8PbYTShWOCqT0GAO5IkZFf90Pvc3BPijN9hdxBHIi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgTP+NTr; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47775585257so7067715e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762951650; x=1763556450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAyL6DXdlWMMZNXZ5ef4zX5oC6lp6MOoZedmRmCWqCk=;
        b=lgTP+NTr/M8Gm48Yj8XGLAlp4oF/HO5/6RgojVAbh0MclKXN8XHna3ugrq01wJt+c8
         g5Jt3JnuK757V9rJcbGpAKup+19Fnfbk4DWyJiqW48r17Nyvj5ku8ZbEsW8242dc3fHe
         BV3Wi98AZVhzmdjsFUDhJyMA5k4JckbCUo8UveMFl+2YmNjJoQM7epzzWhzGM4lXRHm4
         xRdyxIVQBVxGNlXMpqLezvFxvcq1tuPvg2bhJWwHv1WkWHhlP/BWm/D1h2BvsPY30v8b
         +1L/q0jRNGQJQjvmwx8AYnYAgH7xuhNuVoCQgmDMj1V5Q9WUER0hQbeuu8JD4MHoBHm0
         U67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762951650; x=1763556450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAyL6DXdlWMMZNXZ5ef4zX5oC6lp6MOoZedmRmCWqCk=;
        b=TYpz+3DmO8UO3MYb6v3dw4llz6+wOxGX+KDYYtDH5fsUUo80RbjlyLyAkHDZlYSVFh
         z8H28tynI99dpxCKdz6ucyJSB7WBicgaCOoKNOKU0+xa444KjdbqrsQdX8mDg8N4kRRb
         5a5oSGX+PXc9l/CTiaLnhvcKW33CJwHDHShXQpMTvcDfZzVTEj6q/04Kk88izDl4iCmV
         69Dx6HRxKgY1yY0QYKL1ww1sRj2tlsfJvIMoIAoYYhdpSHXgD/bxXCc9cgU7R/jfzvd4
         8UXxfcJVOYBl9vAhsTwK3azekM5jvuVSAmbwWmpyWF9Qskoa2ZJe77s2JW1raATfMTQj
         3a/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6mn26HZOeLJ4Q0kgPVJKdUDamxzLiGTURZ5WUwFxsxtdi4zhvJD2qvgoBx9rhWaTEbCRlyD9q94Swbg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8bzakYywwoaB4Uj5RZh2BNvMoXZUQ3txQqLVPM+WFLAoO4vx
	Jg7IzQ2IyhkiL3JeV96f5XM1lXPgdSTp2vvS5/OND9d37mHTadUvOiWP2qUDobWwxHDlNI41Qyw
	UMcsdBWTegxp4qNWwEA==
X-Google-Smtp-Source: AGHT+IFI26OUAU30HxN4N5ESdqUbkEvk5F+6vXXL6DPLRxYyP/If0dVPFSht9YaKcqDMKtTuRH20LVUf6M5dr2I=
X-Received: from wmbbd13.prod.google.com ([2002:a05:600c:1f0d:b0:477:63a3:2748])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d0a:b0:46e:32f7:98fc with SMTP id 5b1f17b1804b1-477870962bemr26756645e9.21.1762951650641;
 Wed, 12 Nov 2025 04:47:30 -0800 (PST)
Date: Wed, 12 Nov 2025 12:47:20 +0000
In-Reply-To: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=jU12ZpgtH991h5e7ZBwBatZK4g5q1U/xD8yC7I7uHME=;
 b=kA0DAAoBBFi+7ljGOUYByyZiAGkUgd7IN5ZSHLCDpzD9Me3XDUof+vZJ+MpQbPfrpbDnUcnSn
 IkCMwQAAQoAHRYhBIOSopRNZAcK8Ui9sgRYvu5YxjlGBQJpFIHeAAoJEARYvu5YxjlG66kQALG6
 l36BdIAxhSaLv06Oh8rVycDqelTzLAe/S4UyL1ibV4SbA2OwlkMe1W/qXjTWofTFjUE+G0d0We+
 mBmiFe5ANObGJoqifL+V/FCeZeyOeGzrL0toiPTwkJ4ORfsfxDy55Ej4QdjqHCb3qrjpHuBgXO7
 pRPNtoy+DH7Lk0ATI4MBx8tYnWPt+WtljVLTPTWkJw0KSn1Q34JSD6klKWRNWseBj5IIvR0Rnxz
 Dmv7Ij6knxHf81G0HLeK1CdLar8KUiDVSateJ4BlG7DG86XU6+lgx3yVqlck1XUqg7wtr2O9XV1
 Ysi1YB/Y6wwe1nHzlhM4afN26AumEWw1iiT3njn5ZSme+lP3pi+48cl3vixgPwv0+aofx0yk1ON
 4WbDuhL7bxF8pDc6/5Ckb+/T5smMsG/YQmaci46CjIruPXLU5ko+RheAsb1WaKBqhExIZF5+ZYb
 ODExzuaiMAqeT7nNrnFGhvWiVLolpxyb4SLJjeJED0AWsWJAJDpmFlXFw1+a8liVZ0fiDCihCqo
 lbdpxmbpSTy5OBenoTAD8Pl7jLe4rs7cNMFkCwBbwg4wguJv+3hDSFNkhH7wvRpEzvxu3kmhEBL
 LiIrQVH8CxKOFQ2l8dEPV0zTWWNUxvw46PsnL37KhDG5px+2+lhodpg5CbF9s1oURhYI+Y3W854 hp7x9
X-Mailer: b4 0.14.2
Message-ID: <20251112-binder-bitmap-v5-2-8b9d7c7eca82@google.com>
Subject: [PATCH v5 2/6] rust: bitmap: add BitmapVec::new_inline()
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This constructor is useful when you just want to create a BitmapVec
without allocating but don't care how large it is.

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Reviewed-by: Burak Emir <bqe@google.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/bitmap.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index 0705646c6251a49f213a45f1f013cb9eb2ed81de..bbbf0f9e5d9251953584581af57042143447b996 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -230,6 +230,16 @@ impl BitmapVec {
     /// The maximum length that uses the inline representation.
     pub const MAX_INLINE_LEN: usize = usize::BITS as usize;
 
+    /// Construct a longest possible inline [`BitmapVec`].
+    #[inline]
+    pub fn new_inline() -> Self {
+        // INVARIANT: `nbits <= NO_ALLOC_MAX_LEN`, so an inline bitmap is the right repr.
+        BitmapVec {
+            repr: BitmapRepr { bitmap: 0 },
+            nbits: BitmapVec::NO_ALLOC_MAX_LEN,
+        }
+    }
+
     /// Constructs a new [`BitmapVec`].
     ///
     /// Fails with [`AllocError`] when the [`BitmapVec`] could not be allocated. This

-- 
2.51.2.1041.gc1ab5b90ca-goog


