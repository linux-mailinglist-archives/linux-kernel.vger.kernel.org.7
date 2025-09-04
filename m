Return-Path: <linux-kernel+bounces-801310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC32B4439D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AF13A9337
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC00302769;
	Thu,  4 Sep 2025 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zDfVSoFj"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139AA2BEFF0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004623; cv=none; b=ujL2phnn+Lfp4HCByJRrhUGQb7h/AJQiJ961fZLhCDClyE74I1KWqqf54IqufAq6498BKFMG9O7h+DokGV6W0Kh2g4TuPX5OhXR1EEL7Mp3wxM+bYzzL/RMK1eizU9olAxtM6CuDjBymW9GtAOcrxJOUdZjuql7iO4awftSDw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004623; c=relaxed/simple;
	bh=JuXjSvRq2bke2g9Z+ucNdW08Rm4Mjk2MNdVdWHu/w8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bsad2lYT3hPshKMh2Xykamun8Y76CJWi0gOudLk4NEoRGRnb/uoGm/4MglGA35Zh1kvmTJdI4pZMvRO/H98LIb3VVDagsObFYNGWJ7so+l5V0P4QtMjsqzO9ur3vxUdd5gJdaZvG7wFgbbdxrvw1azW37/7ThEoO1diPq4j5mrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zDfVSoFj; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-61cc801ac1cso1153329a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757004620; x=1757609420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WX5CMXBBdv5TsEcAi84FOU9rA8CaHm/rH0SNKK7NnPo=;
        b=zDfVSoFjA2AoDwyVRxdyChMWquOYGb4eC9n4fDjThd1k13SN5FU4nKrk4giQLKjfbZ
         bmUW6KeIWhw7fBlT/1tCH9oNXG9bQ3pPXc7LI9Tn+FDyreevEjp2Lw2OxFygiOntJC5E
         n/BXXkexaMH4xvANLlOBCDzGcKCZGF+qRXg3trAQtlfP2+FJsIrxSjkUALpM93a+kh9a
         7dKuFSTdHjpeW65oeukxGhVIgPoms/gQQW4QB34yJ4mgq3ob+fG59zScQR5moOChnAF4
         lpd0XuPGPUYV3X+ZRiliTxnwATwReXGcQkIBA206SFzBqvRa1m1DfDgRWBvPsAQw4jL/
         D6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004620; x=1757609420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WX5CMXBBdv5TsEcAi84FOU9rA8CaHm/rH0SNKK7NnPo=;
        b=ORWoPHq2PGKn8xvI7MeUkF8mzBvKhre9WNsUHvi4Ya+v5j9JcYE2k5+7nRKouGzPhj
         B2cCdk7cHCycZRypdKwvAc5DLgxESGX6h6gW4tn5WqdMuBF/e4W/XQkcItzQUvYaoevu
         Z58zz4XFrfNBFGQJ57h2vM2PdcVseG7DVDEGZhOz3BF+j88nRDaLlg7TzbRDnZZLJF5g
         uRSX1MA+vyrevMoKzGB7/Xfa2Y6WYsuHP5IPlEIdl1pdkpzTq4akk52tVe6OyA++qSFN
         paDb9ulnrYJtByo+ENg5MMg3drM1BSidO0tC+6sU2MMiiqvax+JKCVkuzmqrHZcpAyGN
         zV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc9NcBtxAwJ5L7LnFdYMrLHaKGR1dVbniFogV9evSsQ1k1XSDKAHZ4GPzHgNL7Oa96PV4m0f3KpjShKPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf7t1H/zjCHHR9bThgF0tND4i7Ini4Dbb4fr6pBHvumyaf0LYF
	iPj5ydWEd7XXm9Gg3wR1IMwxw+7vhOIUAa/Jo/2hxNjVz3IH/pyuvsG8RpqOi8zdPJqmTQ==
X-Google-Smtp-Source: AGHT+IG0/kxOajb64tOpYOt2ohZyPMFR5j+tWsB7/fP7CR2IFBAVKRyJbcmp01jXmSe/HV8IaE82JBw=
X-Received: from edg18.prod.google.com ([2002:a05:6402:23d2:b0:61d:a6f:ba0a])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:90e:b0:618:a4fe:d821
 with SMTP id 4fb4d7f45d1cf-61d269a208cmr16176843a12.14.1757004620466; Thu, 04
 Sep 2025 09:50:20 -0700 (PDT)
Date: Thu,  4 Sep 2025 16:50:06 +0000
In-Reply-To: <20250904165015.3791895-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904165015.3791895-1-bqe@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250904165015.3791895-3-bqe@google.com>
Subject: [PATCH v15 2/5] rust: add bindings for bitops.h
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

Makes atomic set_bit and clear_bit inline functions as well as the
non-atomic variants __set_bit and __clear_bit available to Rust.
Adds a new MAINTAINERS section BITOPS API BINDINGS [RUST].

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Burak Emir <bqe@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 MAINTAINERS            |  5 +++++
 rust/helpers/bitops.c  | 23 +++++++++++++++++++++++
 rust/helpers/helpers.c |  1 +
 3 files changed, 29 insertions(+)
 create mode 100644 rust/helpers/bitops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c1d72e26fba8..85d846a2ca5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4316,6 +4316,11 @@ F:	include/linux/bitops.h
 F:	lib/test_bitops.c
 F:	tools/*/bitops*
 
+BITOPS API BINDINGS [RUST]
+M:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	rust/helpers/bitops.c
+
 BLINKM RGB LED DRIVER
 M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
new file mode 100644
index 000000000000..5d0861d29d3f
--- /dev/null
+++ b/rust/helpers/bitops.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitops.h>
+
+void rust_helper___set_bit(unsigned long nr, unsigned long *addr)
+{
+	__set_bit(nr, addr);
+}
+
+void rust_helper___clear_bit(unsigned long nr, unsigned long *addr)
+{
+	__clear_bit(nr, addr);
+}
+
+void rust_helper_set_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	set_bit(nr, addr);
+}
+
+void rust_helper_clear_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	clear_bit(nr, addr);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 8437736fdf28..abff1ef14d81 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -9,6 +9,7 @@
 
 #include "auxiliary.c"
 #include "bitmap.c"
+#include "bitops.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
-- 
2.51.0.355.g5224444f11-goog


