Return-Path: <linux-kernel+bounces-897234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 165A6C52582
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663803B56F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494243396E4;
	Wed, 12 Nov 2025 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZiEUORbE"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBBC334C1B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951656; cv=none; b=ap5NOpGx+l+UnKSv3/8YJc+Q9+AFFnwC9LDbRgxX6FE2X6WTj+xqJD1OaWNL6Z/X/Ww76xjeCnC3AQN7GYjV2EPal0Ebwb+hVHiu2eBiDsq324CA001EieLNxsrU5DLT2r0zUdk4LqZ9lG2zVYgbg7gUogK6mjTLIUJFfiTwX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951656; c=relaxed/simple;
	bh=Us/zLvFyE9k9qHI3mL8Iz47DL6Q8odLnYIznsT0OSFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cVwRKI80IUCk1Clj6qvvB5oTrUoo3Ex643xFEt5ZYhHD/i505oZnncRvNfD7TZKAEmGlXshVG8JxhnmPdN40iXPwkhuTABv1ZH8U5YxOSe1ucLW6IYvYhkGW5OaEz4VUC0FK2bxrsgwAJBrg0IGICEk9b7dyAsuxay6/yylFmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZiEUORbE; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6417a4b67f9so728244a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762951653; x=1763556453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3f3ldoO9R08QIpB/BHNyvJNE4LJaL87gT6nQsr/65nY=;
        b=ZiEUORbEAuMUeogWj2YlqN4aVNJ7lY8zBGMCV3AsOe4VThZDLZYt7IcVtqgsQI0hy3
         nolHH3kZDziSlCxzX3PdhBUkE9YzbQJy/q7VN9J35qk9NHKefOz2MtavoCjVNcdPhXgf
         zoG39fCo/YDV3CFlvufcmenXvl89djj57nGjNOeMTO+VPSsRrhAcDyAAOsfNc2S7YiM9
         /uCsiT5PS7cjRFAfhzbKVpfZttsP5ylkQ06yL/r8p+8AT3IhoR2WNEycdkEbzkHroBu2
         NoSgxwUWpD48eZ3qJW11Y5Vb09+j5iVhaAQl3ZKE9yqUz05du4yaDOt2GHuNvTlf+ME6
         I13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762951653; x=1763556453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3f3ldoO9R08QIpB/BHNyvJNE4LJaL87gT6nQsr/65nY=;
        b=F0NQ9UQHrXo/AxV5ALjmhJozx1jQMxnJOLntAffJFlFvWeZQ3xTRBbE4wBGR0SWodT
         ctroMMJKhczVGBO2rDSYj/1D5nE4/bc9mTSLNOwFPG0yvUTMnaZa+8kNV6F7BU3arr1e
         wWQ7vclqa+D5G4kmgyY6xtgbbQrFzY5eGSW2OPmDu2RlBt+lDrOooJ0lwWLRkT8vv+FJ
         e0KSxXyzHm1Ofx+cp6pJmi5VF6E2/3EjWFWee1Vmoq8t0BU1FfLAZw2YMk2ozVHHYsUJ
         0znmFa9XpIzBNV2sGhwOSxAthXSTXkT/Bdr1yvWm7GjzAByxgUe+8q7NTB37eaj8iMCx
         3ppA==
X-Forwarded-Encrypted: i=1; AJvYcCXO386Nr2ooLbK8FSEVO4pofERMZLPj/F67HG65LDTU2f2f7FA8uLxeimWfMs4/PS3g9eu2ATSXaHQOowo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqILyvIZ1QtDiJbX6HZisETQw0/R+jFvhcVzHcrjpJomp2J06M
	dMv3eDbPBWGF7wiWThL3X3yVsu6PrE8pWaot/+z+T/k+sNCnv0sOdr/XwwXSzCpiKqXr/F9wuQU
	lnO9/+rfdXfwHrV3K4w==
X-Google-Smtp-Source: AGHT+IH29rIcpbeIT3goMzCDhfweeIVyGKOaeO+HjU4VdSeG5f8TlrA77kWhpxkYNjptpYv78x0JsOJF84UEb6c=
X-Received: from edaa9.prod.google.com ([2002:a05:6402:24c9:b0:643:add:e1c0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2682:b0:640:a03a:af98 with SMTP id 4fb4d7f45d1cf-6431a52ffc6mr2420889a12.18.1762951653173;
 Wed, 12 Nov 2025 04:47:33 -0800 (PST)
Date: Wed, 12 Nov 2025 12:47:22 +0000
In-Reply-To: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Us/zLvFyE9k9qHI3mL8Iz47DL6Q8odLnYIznsT0OSFA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFIHfc7CzR4SxgRNX8ioWyORnLUfzvrYfKI4v+
 cRiUWGPoQOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRSB3wAKCRAEWL7uWMY5
 RowRD/0aRa47W4TvjdH1/jgUrSCq7q2C0cUfnbeyWGUCsg82SeCDLmnnpAzTKBivWMOVYS4qii3
 8FO9TGsBIh1Rzq6YK7SVZHez3NC/lVGY9rTn4WB/VKe8CUjhBSWIEzOvBoerWvneoEH3E/gPUFZ
 cLrAFl/lL/Dq8MwgwRFuKHPI64cwzkKuE3DgsG6k/4lDDECobNO+kcAQ0x8O6XrZXURd2yDvRIZ
 IOdfikmSE57eQYZsmqrC5yeP3vYPTIYlMSiB2N68Rd69W/J7BvgDmxP7q9bfxy6qv75ZvqthlMH
 9LnVxNgyhj/X0kxbweAnLUg9tU0glvYRFv/cl6xJia7GlJ5S2Efk/ThQQ9L04HHzxeM/XBE4wl1
 tdnIZ+Yb84KP8+/IqSWSV4kLC7+Q7i6roEjQlRkSxdWjCj+tgIqKKm2XsHgEyhXbii/txvV2AdI
 AFUVr4u3o5WnyYBBfTfCQq4cwQ+onY0UKjiHHu8uGoK2k46o+IaW1GjgIwCYV8dyJ2hfML9nEyw
 VVwgp5GMeSShzwusxIIcprO6NuJ9u+DJfKVTAf6G3rnlDxHDKRL7yQAeOBwfw/F7biQmDy4Tg/R
 HajzGoMwM+HDFl4l9Xj9bc/eYVcusshKUBwZb1p4G7doYj1uOhhytizCwYKANhD2CgRYAI+hLyx GPjWvySP41qQiiA==
X-Mailer: b4 0.14.2
Message-ID: <20251112-binder-bitmap-v5-4-8b9d7c7eca82@google.com>
Subject: [PATCH v5 4/6] rust: id_pool: do not supply starting capacity
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
index 90836b05c6155f98ab8393c8291749f408dbd4da..dc856fc68f4cf38971332f15e63440f27868a3b6 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -93,6 +93,18 @@ pub fn realloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
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
     /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE_LEN`].
@@ -223,3 +235,10 @@ pub fn release_id(&mut self, id: usize) {
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


