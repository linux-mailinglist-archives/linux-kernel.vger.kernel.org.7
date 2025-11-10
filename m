Return-Path: <linux-kernel+bounces-893200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B69D7C46C77
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77B13A7FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD0D312837;
	Mon, 10 Nov 2025 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="an5aooZZ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EAE311C19
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779981; cv=none; b=n4QF2ixhE9zx4efrP+5pRrBtWmRXyy0tG5DWAmY9PNJ6xAfMF5SdPSfD6+g3LCHEUrLTu9Imnxdok/ydFCCAArQUhLKuh/Xe/OslgXM2GPGoJTg0altspd7oaUKIMV/Okne5/nnZI+wv5o2AicvqpEpv+T6r/RxhhK2nXP47Cb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779981; c=relaxed/simple;
	bh=ayKh7eRPmt39BKeLb+5YWnWEmBjxsqI3/VnRGUgVE6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sMVToPHdInwqXps+Egrr4N54fN9ACgLnI/D5hArg9YwGH24ncPRr1+tZirwexOw7eTguaV/lQMfqAnFqrAC4PArTEcABNv/sNE3HvbmfsaMTqFmAq2DQljEKO1QcUZJ6696wXgZ14VvICkFS7LctJAGDGgCumsG8I35PExPxYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=an5aooZZ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso15138695e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762779978; x=1763384778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLB4AoS8IBNy6MZr4QrMLHvbvqNSudvLyDFwnQxNXDk=;
        b=an5aooZZKprUBAnoAsz6hcn/K45MRag5h8bY8Khk9RItliuAujN7g61ykiDqFfwV1X
         4EWmre5rOTn9VlCT4K3m/E8r9H2bsrEMti3wKg+pK9ssc8STEa+GkcdNeGx/iTj8Vm1l
         5SqJUe/G7gN9+TfGH6aUcCk7ynsYVq+a/mncJDbwjYumjaZEZksqenMrRuJk1oGoopUl
         RkLaHV1jwPLQ9Jdqqgu0kloxaW7MqyfQ/kLkxdt1zwcYyQMaBXpzNtwfBT9jGw4IPmuB
         mkCGvk81sqfull+GYrvnfsEW7BR5IQe2KTa8MPLyaTPqaloydjc2XmUKuUxA6IN2y2TT
         8grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779978; x=1763384778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLB4AoS8IBNy6MZr4QrMLHvbvqNSudvLyDFwnQxNXDk=;
        b=lY1f9+UBPWL0tPrTqdpNW8jOoD3xVGckZJUWxQxyBuO7yCLxj0A+14zWS13/LeE2Vh
         Bl5Sen4i045q3I776/Gg0JpKokQEHxdwbuILi88Bj0RdacFnlNQzTHDGHocASw1eSFvF
         QrfD74rm2n5xgCTpk4V0d54uuyZsH/7iYsM26qLRvEbMWnUDMl8fpC+8sx+H6OAkW4de
         s77cDzSqa66EKIj0AIZ0JNVH4QN6OnCQX9YjGNOVMY+OJpWqGelem13uDDzF2OSL8hdD
         7aRqO1ytHjJQ+vlCLEjYUh4jAbHU/g6dt/gZQzc/7CYkumw/o/ZZY/PEK/Hn7T7/cUor
         71UA==
X-Forwarded-Encrypted: i=1; AJvYcCWz+Zs4lJ4BRRXS6S3wNXJnfHbp61nE8x9F3/++DzLNjuFAubOcWvDlk6DIchipBAeFkdv6AVEStRZK5Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZp/5fLF+h+Ayigd2/ZIn3rJRgo3SpxeD97o8G/aWT32FUJZ9s
	vNvMqqog56Qp8m//QOuodaWgbhchmrMkpUET50uyRtGXebEZkQgPfpjoHpwlAwqaKHMNhC/VbWH
	kU6raR9S38bUfsWF68g==
X-Google-Smtp-Source: AGHT+IE4Bj9VtWynjqWGzBolY4VDb+uUS/jkQqrMZXnbI/ZZ2OFgcdmEyEvLQetp+3MPf0KhJ5VPrEpcK68xjXg=
X-Received: from wmbgy22.prod.google.com ([2002:a05:600c:8816:b0:46e:4c7c:5162])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1987:b0:477:1bb6:17de with SMTP id 5b1f17b1804b1-47773290dcamr78018585e9.30.1762779977900;
 Mon, 10 Nov 2025 05:06:17 -0800 (PST)
Date: Mon, 10 Nov 2025 13:05:57 +0000
In-Reply-To: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ayKh7eRPmt39BKeLb+5YWnWEmBjxsqI3/VnRGUgVE6k=;
 b=kA0DAAoBBFi+7ljGOUYByyZiAGkR40PIt44SMFZNOr2SMwyl/WuUJpJlujYnZZBIMDF01+vci
 IkCMwQAAQoAHRYhBIOSopRNZAcK8Ui9sgRYvu5YxjlGBQJpEeNDAAoJEARYvu5YxjlGykMP/0lG
 wvPenr7XBqzZ7ZljwzlgHU6m5GXfV/paxu3xIqbJiLha3VHx9enOn4m9REaNYF+fww1ZPuS2a//
 FdI2uM5rHayGxWJIAGRlXevLxML9WWnEoVTZ4Am3+G+8iW6qTXMtwxFTZCNdBL5/sp0uxnoucGE
 Mob1ly0j2YTqZsTaGgE6KrGElNAJCh8BXv34/zgGlxbrhdTqClF49+BWO1naXU5p8WQ93bqnwyk
 TryRQDxXMKp8UA9dZtwM9J53HTDxTXqx14bKfvRHoy5K7L4amPHTOwPkKsnmJ/wIEBdFy3E6KwP
 DJfGUlPswt2sPJh3w5zQ/zaNKIvDG5Q4icl9Tu0fVza8C8lydCQZmPV1YCPMzMMHWfTE1wOjSBQ
 IVN3o8xiozcVJXcowbOC1r/fW7vXHcsEoj/crnPMx5BMYDMTAiyMu2QWF5+9ocuEXl/XlSuLr6q
 InH+Vl+u1+hStd6Q1T7G/FpEEFRHRVbYEhl4UwuT7IC/sBnJ8U1Vb+2XtjJoLnQ7ky3jLW6dA9j
 kBbJhb/lKBMJyEqIYyPCKpdEOTwI8OfHv25iHb0R2EaaErZRvq1BTU11bMY4O+lqvsyZ7lI4TDg
 FERTuBDzN0Hl89Omypa95Y2kcxwo7OS+9xf4hUOoAoB/+pdSVS6H82OiqgL65qT/dfuTm6AgnOB +e5LF
X-Mailer: b4 0.14.2
Message-ID: <20251110-binder-bitmap-v4-4-5ed8a7fab1b9@google.com>
Subject: [PATCH v4 4/6] rust: id_pool: do not supply starting capacity
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

Rust Binder wants to use inline bitmaps whenever possible to avoid
allocations, so introduce a constructor for an IdPool with arbitrary
capacity that stores the bitmap inline.

The existing constructor could be renamed to with_capacity() to match
constructors for other similar types, but it is removed as there is
currently no user for it.

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Reviewed-by: Burak Emir <bqe@google.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/id_pool.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 5942f678db015e902fa482eb64c38512a468e449..6f607f04331c9bd3fc79c6d91d04005bd0685839 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -95,6 +95,18 @@ pub fn realloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
 }
 
 impl IdPool {
+    /// Constructs a new [`IdPool`].
+    ///
+    /// The pool will have a capacity of [`NO_ALLOC_MAX_LEN`].
+    ///
+    /// [`NO_ALLOC_MAX_LEN`]: BitmapVec::NO_ALLOC_MAX_LEN
+    #[inline]
+    pub fn new() -> Self {
+        Self {
+            map: BitmapVec::new_inline(),
+        }
+    }
+
     /// Constructs a new [`IdPool`] with space for a specific number of bits.
     ///
     /// A capacity below [`NO_ALLOC_MAX_LEN`] is adjusted to
@@ -224,3 +236,10 @@ pub fn release_id(&mut self, id: usize) {
         self.map.clear_bit(id);
     }
 }
+
+impl Default for IdPool {
+    #[inline]
+    fn default() -> Self {
+        Self::new()
+    }
+}

-- 
2.51.2.1041.gc1ab5b90ca-goog


