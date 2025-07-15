Return-Path: <linux-kernel+bounces-731966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01833B05F43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41A54A3CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337F42F0C43;
	Tue, 15 Jul 2025 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ijwj7khZ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93092EFD97
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587207; cv=none; b=n80L46eg24CJdqrmiO+ezoXVvMpaU8DC4Ng6J0jXQ4aKx3kkqGzG5DODCXrxRLItwdulkB9sG1fQW3h5Mq0qBDIWv1YthXpQO7nWSGwapCwBCyKGBo5aT2PqBaZ6jTq+J4WvJc/3Z5oiXT7Pn1COQOv+s45SJNKWXcCmWAhFiWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587207; c=relaxed/simple;
	bh=HCwawN0YyQsKejL+XoDR9LPJoThO5UjHqKypm6OsTj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cMtob6vtJVq3lXoOMZucmf1ECPaUhkAXBj7/U4RdiKLDiordJUmvcBIH/52+3GToITF6jXH2+XNw4HcQ/9s2K9v5F4F66ufZa3aF/MTOF6UTF2fmpwN5RDtOMhNLynHUsKW0iB8SgzRGoIK/eF4E1sAuY4Uz6GDtKTYH6+xTI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ijwj7khZ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-454dee17a91so42358135e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752587204; x=1753192004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAn9sAZ8EZsg3ucGTZ/4Am850EAhLwSfcOwCMtHhu60=;
        b=Ijwj7khZmNto8Jvri8/BwZzcc+4sDIqZngqRLMAeT3kW9HmwogCbnELFyBuIEwxw5y
         mLolHNBemyn1GVhwU9UrvnL8y6M3b/hJNuRix6UtHpQnHtBXtQVuA0HXDS9Tk5E3LXl3
         /eTTBhTG+eR8QL9lDGhhqa3Ky9hDeYJXsz6S4JwJ0bw5EMjQJNRvETqgK3lAos+GxnZ6
         zPdkHbOF6nbHatMdOK2RVTBt21NSReDIYydk2LSGB5uXHpcAgHcgT5pPYU6GPVFfOR+V
         kVJoWbeMVgX2By+yw38y+2/kI7w9yD7lMiT9JvvYTSKha8BjqVz4mOMcPRN6pVkqR4dE
         slVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752587204; x=1753192004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAn9sAZ8EZsg3ucGTZ/4Am850EAhLwSfcOwCMtHhu60=;
        b=safiK7yyq7114Q8uE4gymr/c0oZOOeMGo5iLgAeGkYuKplAfR0eK+GJvERaBMk5kXq
         p9h1OmTfWrD7h1EDoy/bFPlIkxIpcXqPz4oTEVIbhuL2jiS0RKcCV7aBjx8WudV7L0qh
         r+Gp0AqpixljxODFzuK9KBVO3gVOKvmzLOvg8IaApv2dK+BqsEHGZYUq+0BGal6IjLA0
         JYD+ABTv1EGHOTZ3BD1PQbJ2lUFH98Deg+FZJBxW7U/R39GR+y3j86y6Xg0CsgXAvexw
         PHIivO4/hXHve7bZViluoV+ZckVBpgZMHj8c+1oyCWVy4Ra7buzGmMCirnfC+5AkgA3D
         aSRw==
X-Forwarded-Encrypted: i=1; AJvYcCWvb+iefaLengRWl22uGsrh9tYX0CWovAG8ds42TeC8sRsxNJkaLNCKLYyikEwSPAtz0PpW3uWe/8hH0wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyOvbYZQ+hE+kQrKIN4Vhh2z76OaRQiVLrUygv6Jv60SA+UhEN
	jsp59wSYgYzOJzNMk/TmjvBfrlPLkggZrEurYZ+peM7K5rzechDt0FoET7+mdNyieOE8HFvPd+t
	8XawfwJS9XKLlQjtc7g==
X-Google-Smtp-Source: AGHT+IHoGckLvWDzkowkR6ET5+sYI+3T5P/yl3EGQk6HDQYDmQOtjc6slluNfepxqCpjmwkDzVqlDNegBJVJLnA=
X-Received: from wmcq23.prod.google.com ([2002:a05:600c:c117:b0:453:b96:8ef9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6387:b0:441:b3eb:574e with SMTP id 5b1f17b1804b1-455fffb208fmr111920755e9.5.1752587204158;
 Tue, 15 Jul 2025 06:46:44 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:46:35 +0000
In-Reply-To: <20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3033; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=HCwawN0YyQsKejL+XoDR9LPJoThO5UjHqKypm6OsTj4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBodlvAMOKwdRZUEmkjEvHfadcX8KT55zoaKkjtB
 8/E2YVNvsSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaHZbwAAKCRAEWL7uWMY5
 RvWlEACVwTf3LaGWPdZzVjA0VxARZTMPfXdATCnuEUEOTxoZQ9YNo/+fR2zxY86i5WPXNkWRED/
 E9zSgm9BzC2iJNlaeJ38MOO/SOIAnJgU1NNfG6G2wwEFw0I6e5iud6Z7kD+SZhB+SSsZg+sUlOZ
 EilR3I1gZVm/+Pz5bYlQ5/tBL/dSJaFmf1FmQpPjiiMcoJZN7gQZ3imMHoLecxbODebe4WsEFq4
 BHYymGqRHX3Gi6eMXpXcnUzho1V9+9wV0yS1PyBJjffvfiuI4+u/GGM+SYnT+y0VbxxsB9uvE+c
 DYA8egDnAUwf8cIq7k9SSnbrKUOZgkwS/a66kDtfHowzCWXddpKXX0OQENhf+yhHNH7IsPp+W0J
 qpkQisawgO209fpixKZcKxSYm96Fv9NyG/YVZPTvVyAmVC27YNI8O/2YVKW386GUPUWvzEgnHUo
 F7pVrw6TTgCz/n42Ihabs5tZBR1mvE9kuynH810aMz6qv1X0OOXE2cDYvCU3MqpsuSofl9q98/r
 VVUnc5j7DXrG3dY7jonuZTsJnhqmPBgg6a4qm16/epTuJzhmoAZZwaUVaFLKQ1Y4iX3kCjnf+Mq
 iG/9DMVwaxiY3Cv/IXjY7HFtYL/P2vpNJevbhyt2gKEEmDAqoMWQ864rou6xqqVhy6Z9qu5aC/4 2ll/WoFLWAg2wjg==
X-Mailer: b4 0.14.2
Message-ID: <20250715-align-min-allocator-v1-2-3e1b2a5516c0@google.com>
Subject: [PATCH 2/2] rust: alloc: take the allocator into account for FOREIGN_ALIGN
From: Alice Ryhl <aliceryhl@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When converting a Box<T> into a void pointer, the allocator might
guarantee a higher alignment than the type itself does, and in that case
it is guaranteed that the void pointer has that higher alignment.

This is quite useful when combined with the XArray, which you can only
create using a ForeignOwnable whose FOREIGN_ALIGN is at least 4. This
means that you can now always use a Box<T> with the XArray no matter the
alignment of T.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kbox.rs | 15 +++++++++++----
 rust/kernel/sync/arc.rs   |  6 +++---
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index bffe72f44cb33a265018e67d92d9f0abe82f8e22..fd3f1e0b9c3b3437fb50d8f1b28c92bc7cefd565 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -400,12 +400,19 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
 }
 
 // SAFETY: The pointer returned by `into_foreign` comes from a well aligned
-// pointer to `T`.
+// pointer to `T` allocated by `A`.
 unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
 where
     A: Allocator,
 {
-    const FOREIGN_ALIGN: usize = core::mem::align_of::<T>();
+    const FOREIGN_ALIGN: usize = {
+        let mut align = core::mem::align_of::<T>();
+        if align < A::MIN_ALIGN {
+            align = A::MIN_ALIGN;
+        }
+        align
+    };
+
     type Borrowed<'a> = &'a T;
     type BorrowedMut<'a> = &'a mut T;
 
@@ -434,12 +441,12 @@ unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a mut T {
 }
 
 // SAFETY: The pointer returned by `into_foreign` comes from a well aligned
-// pointer to `T`.
+// pointer to `T` allocated by `A`.
 unsafe impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 where
     A: Allocator,
 {
-    const FOREIGN_ALIGN: usize = core::mem::align_of::<T>();
+    const FOREIGN_ALIGN: usize = <Box<T, A> as ForeignOwnable>::FOREIGN_ALIGN;
     type Borrowed<'a> = Pin<&'a T>;
     type BorrowedMut<'a> = Pin<&'a mut T>;
 
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 63a66761d0c7d752e09ce7372bc230661b2f7c6d..74121cf935f364c16799b5c31cc88714dfd6b702 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -373,10 +373,10 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
     }
 }
 
-// SAFETY: The pointer returned by `into_foreign` comes from a well aligned
-// pointer to `ArcInner<T>`.
+// SAFETY: The pointer returned by `into_foreign` was originally allocated as an
+// `KBox<ArcInner<T>>`, so that type is what determines the alignment.
 unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
-    const FOREIGN_ALIGN: usize = core::mem::align_of::<ArcInner<T>>();
+    const FOREIGN_ALIGN: usize = <KBox<ArcInner<T>> as ForeignOwnable>::FOREIGN_ALIGN;
 
     type Borrowed<'a> = ArcBorrow<'a, T>;
     type BorrowedMut<'a> = Self::Borrowed<'a>;

-- 
2.50.0.727.gbf7dc18ff4-goog


