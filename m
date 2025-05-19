Return-Path: <linux-kernel+bounces-654136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E60ABC46A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 18:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298A57ADC12
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895BB289836;
	Mon, 19 May 2025 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJC0inxF"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A328937B
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671455; cv=none; b=eo3u7BdIXFteJKWum+lr9UN2GSzrhcOm7CsGjQsy1FYhjetQGawcW7ZjKgBJuOrm32vE+pNsfUkO1kpaau1UVix71jzzWAseSACE31y4Vs4rVCIbAE7BsQI3/xEAdjuG8Bam7nMiL5PQ0cx7cm7PEswG3DdV8vV4ODEarEAoHoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671455; c=relaxed/simple;
	bh=AGiPPLwtKkHyIil5nX5UwvjN3gwIsKNADdoIbt4a+GM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G+OE6T80/I8+CecF+sQW7uKlVoMk9ZFYx9JRfLCVdWncxI1+m0SQg8aI+yDctfpAq1Qhnw71tGL3uNLXxUOAeby078OB5QFC62jGp/VXwq53ANvdmVP9dJzL4636zjk2lQ4EQ5+8ED6rKqTZ+A5aRfDcZAR/9hR1Hm+KQ5yWA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJC0inxF; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so36730815e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747671452; x=1748276252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TV/U6hOZ4/6jhNCFGPyepIdJ6+QNwHJqLnSNzUB1aUM=;
        b=SJC0inxFkNMufCHqNwkn5SSIoYbSW6QIB8NzO6Zf75cULBVayaoY10U1DjP4XyxCf4
         zp6eRl/ySz3jOJ7XFxM0RraVqlXOVXnxx1htXXiYbgl28f+4Syhg1RRD2URxE1yD4dkz
         /ez+TyOP51z6fG7nxBqrLNDrXBVR6pwr9eVQ+UVzyZL5rxZabFgWqVsE5onzu+4Wq8y0
         RHEZHi02l3JQjZXKzb5DEtffew2bRsDiGbZXa2oE0mpDfT2y+6NU+2EM7dB/7i9tgzun
         EP98TUU2Hh9ZqHqs0PGpTLunmlnUMDGoLPiiIutrqfLO5rhs7zbQpuK+WL3hrDfqv0Bx
         b8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747671452; x=1748276252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TV/U6hOZ4/6jhNCFGPyepIdJ6+QNwHJqLnSNzUB1aUM=;
        b=wLTrzl0G6q1D9WPjHNJlGvE/H/XOEWd1hTO48ta6eMMGVjYpXNynrZkqYDRX5zpvQH
         /6gu40cdQCRF27T/qTGNgpNIzELgKQxvBIpkQS5iFytreKDSZ5e4UmqeBx3nBVxt2DLw
         I7m9wrYyfiDTrOkZtrRPfUBaND2UJjYnBSszcdHNU3LARO64uxSAfkLewLFxxofN4fe4
         /ePC1SoSgJ/Fo6CYFZTsmydh5GgGtEdBnZ2gQ73DdBpHViS2cOyK93t2RIMUHhAcuENg
         gPC/EvJvM21FZdO8DCKEMWoDOpdOPzczM9zUms58GeNa/Gj1gIADUTDfWrvtnGJSnmw/
         rjzw==
X-Forwarded-Encrypted: i=1; AJvYcCXxr/Fd3oMI83S/lbISEOQjsfNtaqUdmkLU6m+euudprFAZks7EKseQbup9fPSVvO7/9oyBpcn8W9gxw+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSNlvrk7a3zeNSYxJd9qOp2XDABe0mQDS+FWn05VAnspw3Mg3
	PGAk0w/30u4nliwon7y0FoNKXcLoeTBphRTzTUozIpRdWlzvzN1x404reGuvhWQlFVx+gw==
X-Google-Smtp-Source: AGHT+IHcEWGvOdJO9xFxXMdY5FMhyx8Fhjz4I9MlF5gLqk0an+OT/w+E/WP9CLdn10WpcEfgMtZ1wgM=
X-Received: from wmbes7.prod.google.com ([2002:a05:600c:8107:b0:43d:9035:df36])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:45cf:b0:43c:f470:7605
 with SMTP id 5b1f17b1804b1-442fd610128mr130095715e9.12.1747671452177; Mon, 19
 May 2025 09:17:32 -0700 (PDT)
Date: Mon, 19 May 2025 16:17:01 +0000
In-Reply-To: <20250519161712.2609395-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519161712.2609395-2-bqe@google.com>
Subject: [PATCH v8 1/5] rust: add bindings for bitmap.h
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Makes the bitmap_copy_and_extend inline function available to Rust.
Adds F: to existing MAINTAINERS section BITMAP API BINDINGS [RUST].

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Burak Emir <bqe@google.com>
Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 MAINTAINERS                     | 1 +
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/bitmap.c           | 9 +++++++++
 rust/helpers/helpers.c          | 1 +
 4 files changed, 12 insertions(+)
 create mode 100644 rust/helpers/bitmap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d48dd6726fe6..86cae0ca5287 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4124,6 +4124,7 @@ F:	tools/lib/find_bit.c
 BITMAP API BINDINGS [RUST]
 M:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
+F:	rust/helpers/bitmap.c
 F:	rust/helpers/cpumask.c
 
 BITOPS API
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ab37e1d35c70..b6bf3b039c1b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
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
index 1e7c84df7252..92721d165e35 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,6 +7,7 @@
  * Sorted alphabetically.
  */
 
+#include "bitmap.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
-- 
2.49.0.1101.gccaa498523-goog


