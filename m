Return-Path: <linux-kernel+bounces-670225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64432ACAAEB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 10:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA869189D406
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618411E0DD8;
	Mon,  2 Jun 2025 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFLxrG2B"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D7E1DE4EC;
	Mon,  2 Jun 2025 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748854496; cv=none; b=Po50qCq2qD/xJoI7+qny+jq+d4OFQLDqovnvmvQHYjq11zo8NFP3IxSmwWvTjx6k21UE1qIzJxtZFC1wjo1775sgc9WYyBZW5CwLs+f0rEH4KXrdky04t2fgL4+1hOGfS1gnzbmn/n9+l1dcicVBM99NdxwJbfKWqi5AnUZRx1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748854496; c=relaxed/simple;
	bh=aVxlq706IujBRj+HiQ3ah/IIAv77R+CvWdXj/E/ybvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaGNWmzmHTgwicPQZu4sZO6qER71jZ+9MHc5KCgc+vfCQRCnt3AmdY5ZqTjxLfroQgNtvs5F9FZlSxiGRWEdIfYeoaFW5vznA4P3AAQO5SMo4yVw0h8UF1vpyP2d2eA0Ur1E1iPm6GN8UNl4AI4q1QQCvFKIL1Wh/KIZx+WDo9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFLxrG2B; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5532f6d184eso5252381e87.0;
        Mon, 02 Jun 2025 01:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748854493; x=1749459293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRX6ycinlDpWw2cKVx7yjaGxT6xMop9u+LnJF5PNiJQ=;
        b=AFLxrG2BCpV/8CuShJOahxs9CEC64nryKEr5/8YbkmpucZ/Q7dA4jMj7QmlwO2x9eo
         t9mY0gqkltnyu37OY+wSKMtEYofTt+ZKQsKSSXEAoFRzQNJ2t2icGXIwMJPlrDkYtVzp
         oVioK1eIW6aY5YkeMCWyqsLW9/wRV7i3aBCQK9CbxZftATTcPGFZZF69hP0AanggkuB7
         moLKnPyA3NLarQ1QcUL0hreaMb0q4LeYNK5nKmPmL8QudMFbJ02JgEKRv6/IbDuNQdJD
         LjTXVbXnLVdWz8Ll75EHcBDOs7gWvvehQ0xVbB+rRDFfgbXk0W+SXk6+VamrtTMeZNGr
         /YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748854493; x=1749459293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRX6ycinlDpWw2cKVx7yjaGxT6xMop9u+LnJF5PNiJQ=;
        b=mIt8n8mWlWuwzWy/uKP+6y53B970/0UGXjlt+tRTWPkh6E9CFjik1/fqrLNhj6IN7t
         mVH0nQ5uqe2AGVrCJ/AsDJFPxP/xMT9IByu8tExUDTJINJVXMvSq4Qlhw1JNqumrTXOJ
         O5wWRXfHRkR7fpE1aVMzyonppIiWNpAv1vTyl+tUDAYBgfJOFBTewgALk6AXQ/zPjCXh
         8t1s3oaD3P8CqIn69asymMEY3pB7tnjZv2un+vzuimt/UL9YmI3pfnd6Eq+IJggr3QqT
         jMYXmuNU5LP/dTmlIPgDvESZ/uEqTTybpAKzv9rmlaKVJDMyxWzGP6N5XIH+Vt30DOhW
         o8vw==
X-Forwarded-Encrypted: i=1; AJvYcCVn21Q/bDJNkD/fiedgMROT6OPSUYkMh+uCyswyfSHRStu+vRplOwc4b36CliQ6vcqGsZ//DQe3Wdao6nmmNQ0=@vger.kernel.org, AJvYcCWsVerTo19/2tYp56Da6QV9+G/rK2kJaOvwD+BG7u9CFzk4Byp6+fZnYMXrNoyNF5r/IfemOtoxpcMY+DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9smeQX0WNbfOJaJexXYKkEdtiOtMonUwHew+0s6BHO9wYIXO
	AuO5ibLTAzlJwDCPK1YfYMuyZG8nuLT0++IMaMwV50pEkQ3WnJ8z7N2K
X-Gm-Gg: ASbGncvBQRjpcWpJmTIPv0YPm6Tnbh7UWitPIZQCKuq0FcTObUvUn83P1F3KYEZhqgz
	0PCYFyheCs9ueb0N9SnbDrgrj0cHEbRpU6cW2kAQrFq1wAjzwUvgoPdaTMlxr6MtDEvpy5she0T
	HgxsJTCo+TIAlsMoEAWvrBzjzzjhcnESsTUoAWkAyp/DaRGRdde7rsOJu3e+ntOLejQ1fOJxh9Z
	Qwtzf2myJ32DRO5kMxh/rZkqMBQ6oDWax9URNspZf2ew3XCGLC/LipZgzyceYd5DG8652Nkhrfg
	VqDZL7CnWo6SJF/3jQEicv4t/EGszgGYUplJv253rK3iqVo6d4666fV4LnCTjRgyLfmf3MmWZ/b
	228PzkaOYhUIcHjAluiJb8LeHqT4V
X-Google-Smtp-Source: AGHT+IG2LmHus1rr8ydQkHeOUpuq/nYTVQnVNjpmNMi+kbH3v2KVxyMZpriwJL9CZN4aoHvOpzgf9A==
X-Received: by 2002:a05:6512:1328:b0:54e:81ec:2c83 with SMTP id 2adb3069b0e04-5533b8f412cmr3757007e87.18.1748854492276;
        Mon, 02 Jun 2025 01:54:52 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553378a13basm1524325e87.81.2025.06.02.01.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 01:54:51 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: acourbot@nvidia.com,
	dakr@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v4 2/3] rust: dma: convert the read/write macros to return Result
Date: Mon,  2 Jun 2025 11:53:12 +0300
Message-ID: <20250602085444.1925053-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602085444.1925053-1-abdiel.janulgue@gmail.com>
References: <20250602085444.1925053-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We could do better here by having the macros return `Result`,
so that we don't have to wrap these calls in a closure for
validation which is confusing.

Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Link: https://lore.kernel.org/rust-for-linux/87h63qhz4q.fsf@kernel.org/
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs       | 54 +++++++++++++++++++++++-----------------
 samples/rust/rust_dma.rs | 28 +++++++++++----------
 2 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index c3fe39e7eb0b..5a690e5f1e66 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -328,20 +328,22 @@ unsafe impl<T: AsBytes + FromBytes + Send> Send for CoherentAllocation<T> {}
 #[macro_export]
 macro_rules! dma_read {
     ($dma:expr, $idx: expr, $($field:tt)*) => {{
-        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
-        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
-        // dereferenced. The compiler also further validates the expression on whether `field`
-        // is a member of `item` when expanded by the macro.
-        unsafe {
-            let ptr_field = ::core::ptr::addr_of!((*item) $($field)*);
-            $crate::dma::CoherentAllocation::field_read(&$dma, ptr_field)
-        }
+        (|| -> ::core::result::Result<_, $crate::error::Error> {
+            let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+            // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+            // dereferenced. The compiler also further validates the expression on whether `field`
+            // is a member of `item` when expanded by the macro.
+            unsafe {
+                let ptr_field = ::core::ptr::addr_of!((*item) $($field)*);
+                ::core::result::Result::Ok($crate::dma::CoherentAllocation::field_read(&$dma, ptr_field))
+            }
+        })()
     }};
     ($dma:ident [ $idx:expr ] $($field:tt)* ) => {
-        $crate::dma_read!($dma, $idx, $($field)*);
+        $crate::dma_read!($dma, $idx, $($field)*)
     };
     ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) => {
-        $crate::dma_read!($($dma).*, $idx, $($field)*);
+        $crate::dma_read!($($dma).*, $idx, $($field)*)
     };
 }
 
@@ -368,24 +370,30 @@ macro_rules! dma_read {
 #[macro_export]
 macro_rules! dma_write {
     ($dma:ident [ $idx:expr ] $($field:tt)*) => {{
-        $crate::dma_write!($dma, $idx, $($field)*);
+        $crate::dma_write!($dma, $idx, $($field)*)
     }};
     ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) => {{
-        $crate::dma_write!($($dma).*, $idx, $($field)*);
+        $crate::dma_write!($($dma).*, $idx, $($field)*)
     }};
     ($dma:expr, $idx: expr, = $val:expr) => {
-        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
-        // SAFETY: `item_from_index` ensures that `item` is always a valid item.
-        unsafe { $crate::dma::CoherentAllocation::field_write(&$dma, item, $val) }
+        (|| -> ::core::result::Result<_, $crate::error::Error> {
+            let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+            // SAFETY: `item_from_index` ensures that `item` is always a valid item.
+            unsafe { $crate::dma::CoherentAllocation::field_write(&$dma, item, $val) }
+            ::core::result::Result::Ok(())
+        })()
     };
     ($dma:expr, $idx: expr, $(.$field:ident)* = $val:expr) => {
-        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
-        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
-        // dereferenced. The compiler also further validates the expression on whether `field`
-        // is a member of `item` when expanded by the macro.
-        unsafe {
-            let ptr_field = ::core::ptr::addr_of_mut!((*item) $(.$field)*);
-            $crate::dma::CoherentAllocation::field_write(&$dma, ptr_field, $val)
-        }
+        (|| -> ::core::result::Result<_, $crate::error::Error> {
+            let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+            // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+            // dereferenced. The compiler also further validates the expression on whether `field`
+            // is a member of `item` when expanded by the macro.
+            unsafe {
+                let ptr_field = ::core::ptr::addr_of_mut!((*item) $(.$field)*);
+                $crate::dma::CoherentAllocation::field_write(&$dma, ptr_field, $val)
+            }
+            ::core::result::Result::Ok(())
+        })()
     };
 }
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 874c2c964afa..9e05d5c0cdae 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -54,13 +54,9 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
         let ca: CoherentAllocation<MyStruct> =
             CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
-        || -> Result {
-            for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1));
-            }
-
-            Ok(())
-        }()?;
+        for (i, value) in TEST_VALUES.into_iter().enumerate() {
+            kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1))?;
+        }
 
         let drvdata = KBox::new(
             Self {
@@ -78,13 +74,19 @@ impl Drop for DmaSampleDriver {
     fn drop(&mut self) {
         dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
 
-        let _ = || -> Result {
-            for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
-                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
+        for (i, value) in TEST_VALUES.into_iter().enumerate() {
+            let val0 = kernel::dma_read!(self.ca[i].h);
+            let val1 = kernel::dma_read!(self.ca[i].b);
+            assert!(val0.is_ok());
+            assert!(val1.is_ok());
+
+            if let Ok(val0) = val0 {
+                assert_eq!(val0, value.0);
+            }
+            if let Ok(val1) = val1 {
+                assert_eq!(val1, value.1);
             }
-            Ok(())
-        }();
+        }
     }
 }
 
-- 
2.43.0


