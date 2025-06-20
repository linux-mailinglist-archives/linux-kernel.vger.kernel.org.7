Return-Path: <linux-kernel+bounces-695171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07266AE160A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 10:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF52A5A54AC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 08:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E6623A9AE;
	Fri, 20 Jun 2025 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0bW92K+t"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4693523AB8E
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408205; cv=none; b=bbWys6rbVOMKOq9o+2YxjTz2ql3emNxOxrgEVIr2NkF0H6LR6shGxCm4cr/kLObj2KarhVPYf9le0OiCMlzfGiZLH21Sxhmp9D7sEuY9dcBA4I/sAcq3+2j7b2FQjKS49Jqha0F+K0Hjli5y8ovN//yYUMzHh7rdvKVKzhSlT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408205; c=relaxed/simple;
	bh=i1IiqtaP4vU1fiGfarevRnRsGceuvE99I4D0AcK8s5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=srEAuZ0fBAETqd5mcOlIlp7G4PHxtUuJQ55cPykezle02Ek1llBt5ZLYIe/qT/5PP5ZLAk9D4A1T6x4TdbOK0HBAVTbPbu2Rb0PJPnr+C2ATJ6AA07/Cq2tsjp5OOWTBffnEjAXm/8i4daI6o6L88mfO324Q/w00oUE9CyCL7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0bW92K+t; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45320bfc18dso7513265e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 01:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750408202; x=1751013002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4WdVMidd3IWSbmXnfVaoceNHSKJV4TyPWV/M491/eY=;
        b=0bW92K+tx0HnuAHdvFmUDhXXMDjoA6p5Dw1stCfNxBuBY+AqOrHqwSKF87WaFmf0PZ
         ZYV8rCqe4e/nnKI6ok39y1A6TNHTTkIK8RvJlerM+sxN5Cjtep8lHhO6Ak7hKN4m6fTd
         58EZ+F77vypkruj50Yr1ir/QDRD/R8dlUbge3272q2fRucQXDEB2mHln7EGBvWZYUvSv
         7wU60kc0kDHBLPfmMiGEyNosRL92Wamg3qak3w48t6rr7jmApbS8Km6+PZIt3nv5wYAA
         qPQdKvYjLjIp4wxPxjMEg3aq83z8O+ALWxnXUQuhr1Vpd45BHb8q2JWJpajFAX0qGAop
         Insw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408202; x=1751013002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4WdVMidd3IWSbmXnfVaoceNHSKJV4TyPWV/M491/eY=;
        b=iqCBApQItGNPmhMXvzKgnTgVzOMJK78FRLZCHLed7C0mjqystMqSpWG0liIus27DeM
         PIMQrzkHDR+fIt6rIa7PQpTmDRYBmJ1+WJzGqn4Hzii47rCgodUIULF+GA9bysA344cA
         TQsUGCXi0MwaGnFkhjtqU42pF2xQpzyjRlZnSW8tgaM1Zz7YQJXGARbEoXXzhANJ49wy
         NEWmgwzP3dXSinzpvdzyRGx9WKWNMaMUMU2+VhEfgt4wIwwTTqsK0yuNGVCmjG7L3t82
         bfNji4bxr+SmR3ubX9URXEuwL5mSdBio3yblYNNkF99v6GwG9MDrzB3kRUVVvQeUM6mw
         k6Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVvG/FhDp4VDc/hZUE4kL/w+NrIx5yv+ELgu5MBRm/zFMfWs+ptdd0lbOlJ++PjiLPlBwQ64UezuUt0DpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7hnczZGcgaFdYPJlOJKIfSHlOTtCrzGmmdXCYhXTBkUeBg7aC
	oE40wuVmxlY6ErEuozwVAyyjDc5U7qr2J+vdrq2ZRq0xJk4MYXh/mMbhDQSA6uEeb6xwfA==
X-Google-Smtp-Source: AGHT+IGjC1GCzzfXL0PQAZN568Sl9MlgsYKwTdsszKx+tTogNMJ/alG5r4bQl5Hy+XYZaE+0PCMvufs=
X-Received: from wmbem7.prod.google.com ([2002:a05:600c:8207:b0:453:b96:8ef9])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6818:b0:43b:c6a7:ac60
 with SMTP id 5b1f17b1804b1-45365e5e62fmr11988435e9.10.1750408201580; Fri, 20
 Jun 2025 01:30:01 -0700 (PDT)
Date: Fri, 20 Jun 2025 08:29:46 +0000
In-Reply-To: <20250620082954.540955-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620082954.540955-1-bqe@google.com>
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Message-ID: <20250620082954.540955-2-bqe@google.com>
Subject: [PATCH v13 1/5] rust: add bindings for bitmap.h
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
Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 MAINTAINERS                     | 1 +
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/bitmap.c           | 9 +++++++++
 rust/helpers/helpers.c          | 1 +
 4 files changed, 12 insertions(+)
 create mode 100644 rust/helpers/bitmap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f584e170cfc3..f83386712a2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4200,6 +4200,7 @@ F:	tools/lib/find_bit.c
 BITMAP API BINDINGS [RUST]
 M:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
+F:	rust/helpers/bitmap.c
 F:	rust/helpers/cpumask.c
 
 BITOPS API
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 8cbb660e2ec2..cc2ae3b172da 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -35,6 +35,7 @@
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
index b15b3cddad4e..cb47c4708a3b 100644
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
2.50.0.rc2.761.g2dc52ea45b-goog


