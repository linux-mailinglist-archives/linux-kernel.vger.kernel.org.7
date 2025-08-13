Return-Path: <linux-kernel+bounces-766998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC6EB24D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 782317BF62D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5087271457;
	Wed, 13 Aug 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PEavuCU+"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5C24467F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099358; cv=none; b=Dp6Xe7F4CKvvfR/xiEthagsZAnX5LmH31Qw69ay58vMmSNvhr8YHyS67SQ8s8TPjOVTv8prIvbAS2QZtUyWwK8tuffwXn/Gz7Sfb13edDxITnX+4khPvnuQm6G7uWo1IkOAekKEQKV7xTsO6mtyNQC6y31IiJbbh+dCIjK4JxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099358; c=relaxed/simple;
	bh=2KT9b66Vpg7O1XgImm+s2jh7nuCN0RUQGXoqFyCFNjk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z1fdfQ8vi/whyMZCjWSf6MWTIB2PpxDxkoQveqrvYrL46bL9M5pGQLt1yxm1J1BWXZzrSENBd61499bUx3e6rk2zwHkGSmgMb9yfnC/q2c4ULZYHUmLiJpc+tTd0X2bKfMiUHRlTeIbCdKh2Dl9W3uMIEHABwWQhmnoaIyMnJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PEavuCU+; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-459db47f138so26142175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755099355; x=1755704155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1zuyuW5ibidXnQHsNdkTLhAD2Ht6AEd8unQ15QbNYg=;
        b=PEavuCU+RIqHMc7OHilivwyGaiNvno7DipUpmPzwac0ojBw2ntttx3IeIQX6f5h/Yx
         bBzvM027guK+FRq1d5gkuPLN+rlgAAAyLURzS6HKanE+Yfz6XFcyqoHh5Npal2oR6hg/
         BUq3tQeXkUcreBGy9Lqez/oVgvx0vlJzCp4+bzZDxjuXfvNm1A0iw5qyTANr/QyKG7lr
         unISbuUFddBcBkR+SulIH8JQuNQS3Y5yeM3WmXBTIc2P0jL0vyHrdHwQAZ5QF3QuFxwa
         2nKUcHI+tHdpIZCigOZrAlyzuoAZpKJpnJ4dEeBM79y8mlHLnXCyNSlaNDXmMSDIoOWj
         pD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099355; x=1755704155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1zuyuW5ibidXnQHsNdkTLhAD2Ht6AEd8unQ15QbNYg=;
        b=IqmgrjtTTaAdTmxeOZBVy00xMonk/GYTATCLOnDMdsanEXDpl7d1I6OgMUTpVGna7/
         OMT5LQfZ0GPfbsgCHZFWk7JYbxEbHsXf8J5UNLBCAKPtYuFDP2Y8vjAdISuzvwIQ8FvU
         bifnmE68feX11F3/i2LunBglvQzfNRIGoMEUg6RBGZ18tJ+CzduFZAqezNlwAaqAse5u
         T6ybWVlA8gXVkTc5DLIhL+KLbj4bb57A4Msqhbyr3l12cCkHnpLyvq9yD7zTQXFsEQZQ
         RjzPFIC/NHFAzwXy8/48bjsU6SNwsTIsHXCOm1YyMXIrm9KNu1qRMCNalVO5BM+Z1JYp
         Gdtw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ7HDZ2krLE4rg8akWccfsZ5f8NNPgz0TNkNQzAappgvoQBCmr0DdSiLBtSwX7IGKWm8v/bGpE88fmTF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVj+TOUjS56jwgPLlWWS1LP2JA2IAvGhTXOoHPSADyeVOCB37N
	HNSG0NtPSsBwkjk2nGRWx3LKOSna9iz+EAnmO0khYkL5SNHyYURraNuBGv+j0jtGdlT8KQ==
X-Google-Smtp-Source: AGHT+IE+ZSG2eAcaUH4f0r+LrEDrUC08HR0FFobmR0CDvCZLYCneSrtTQPGZWhGgBEeqiV6j3om+DHA=
X-Received: from wmbei18.prod.google.com ([2002:a05:600c:3f12:b0:459:dd4e:4446])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:35c2:b0:458:bbed:a812
 with SMTP id 5b1f17b1804b1-45a19769f4bmr18661845e9.17.1755099354918; Wed, 13
 Aug 2025 08:35:54 -0700 (PDT)
Date: Wed, 13 Aug 2025 15:35:42 +0000
In-Reply-To: <20250813153548.1650533-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813153548.1650533-1-bqe@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250813153548.1650533-2-bqe@google.com>
Subject: [PATCH v14 1/5] rust: add bindings for bitmap.h
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos LLama <cmllamas@google.com>, Pekka Ristola <pekkarr@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Makes the bitmap_copy_and_extend inline function available to Rust.
Adds F: to existing MAINTAINERS section BITMAP API BINDINGS [RUST].

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Burak Emir <bqe@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
-
---
 MAINTAINERS                     | 1 +
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/bitmap.c           | 9 +++++++++
 rust/helpers/helpers.c          | 1 +
 4 files changed, 12 insertions(+)
 create mode 100644 rust/helpers/bitmap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..3950f605dedb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4298,6 +4298,7 @@ F:	tools/lib/find_bit.c
 BITMAP API BINDINGS [RUST]
 M:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
+F:	rust/helpers/bitmap.c
 F:	rust/helpers/cpumask.c
 
 BITOPS API
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 84d60635e8a9..7bb575043c86 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -36,6 +36,7 @@
 #include <drm/drm_ioctl.h>
 #include <kunit/test.h>
 #include <linux/auxiliary_bus.h>
+#include <linux/bitmap.h>
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
diff --git a/rust/helpers/bitmap.c b/rust/helpers/bitmap.c
new file mode 100644
index 000000000000..a50e2f082e47
--- /dev/null
+++ b/rust/helpers/bitmap.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitmap.h>
+
+void rust_helper_bitmap_copy_and_extend(unsigned long *to, const unsigned long *from,
+		unsigned int count, unsigned int size)
+{
+	bitmap_copy_and_extend(to, from, count, size);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 7cf7fe95e41d..8437736fdf28 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -8,6 +8,7 @@
  */
 
 #include "auxiliary.c"
+#include "bitmap.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
-- 
2.51.0.rc0.205.g4a044479a3-goog


