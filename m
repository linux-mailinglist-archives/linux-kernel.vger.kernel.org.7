Return-Path: <linux-kernel+bounces-766999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A098CB24DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EEF2563829
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C52275B08;
	Wed, 13 Aug 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OYeG69vv"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790D24887E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099359; cv=none; b=mNl6GwrMMfQoO3L3qv6peAiyPJcdY/6NDQzd0y34rHwBPPpqgozQFRrEajffG7SjXaG2Cqcro7EWtvjwzMABJqY56SPIC+HUEET9MHKvMuONpOvEWhB253Qznu8ZiorTbqASJRoZay3wjldWOl2lJNNfaUTi89OjtmzDOc48XVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099359; c=relaxed/simple;
	bh=I77vfuLlWBPCt14LYZ8NtrBQVu12DONLwfRtZcKx0sw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MSFRyu3pesiTkabWKAsTlvARAXJJneHw3l6DovuYqt5d07VsTNrsaCApNWZ3TTzMn/J/4Z2x2Cdeg6zGQ395kSZBz/Cl+hb7DQpqFGoGB/nSj+p+xu3QpkCR3Ow4to5IFSu4GostrdEhL6gxLtxGidaqFjZ2O6ywuhOOGaEr8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OYeG69vv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so5872495e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755099356; x=1755704156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L4WS8GvYue7559uQTybXRBqpjFVSzlkpZmS/XMzMhb4=;
        b=OYeG69vvFXZObry69u0edLqOk7l9IECTg4QSEUosZ6VsJeE3a7adcqFdep0Ae8U30z
         08RPzT+eEG3c86Qlhb3t5X/OXUt0cKOUj6+KyBmF4bXgsifVunwJ/Nub9oGgE2moD10d
         AYznJ0lqyM1JQbpGmSBjR/WSY05R2wRgXrdpedOKFDRnZ3dCMVRGjUjaP9PPVfKhllOk
         DnvSR+tKCW+Sdh69QLjXW7adAPfQDN1PhqQjxnKb1JQdANbHGIg/615h66VhA3/fxOWP
         Y+UUO69O9iVBjRwdVuoQDLAdX2QFBIzFYx1dwRbcrcMzVR8NR0LOm/81EO4lrsFCZ0cV
         MM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099356; x=1755704156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4WS8GvYue7559uQTybXRBqpjFVSzlkpZmS/XMzMhb4=;
        b=VGS1eNq1fEHJeeXguAOPgYCIFPhuFTdZTwDyUaQftnwkFux1lYbr2NitKmbt8N25do
         hEhuGFCkNirD7psu9QxRzxFB1Ziyna5vrcUbJK8YZYzNhyGlH48gsbPJLes/8cDWy+It
         gVCuwyQeU6As3MHbQxAvmpj3lymLWeZqnPhpj9/mcn35oRToVYb4JijaPKqaHDaM5UBD
         rcYf2zVEFeX0pKxgwtFo+8lgLUDRTrFwDpxijDwjJCOhcWsisURflvzt6l7Pounc5Bzm
         V/YwUgDgtsgLGxIcyHFwDQ1yd2bAFYOWw7EZHK+cP/Vq0hnDRl6VoZj//kJtnn+5nIWe
         ldAg==
X-Forwarded-Encrypted: i=1; AJvYcCVtcYauoGkOGxNSfGiRaVIMh0ZlcJ+/gj7yQMqdayV3vWWQUcIacyC+TUnuluTgUsW2PhF8ywVxlFFgiEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC7QlwtNtm1prgL3+FV8UBIx1qRB/W24E6v/WaYnKUpy6ONsYC
	i+napZY6ETMnRiHSULXF+/f9jtNtate8S1QxAEQYj2DgRNc2g06T+NSDPhbv9ukbJG5DuA==
X-Google-Smtp-Source: AGHT+IEe3dz6q96KeNmchrPq1cz+rF22A1Bsx6DhEle2xVBOzYq6ivW8h+sNse0JlVP+6oJyR4izDtk=
X-Received: from wmbep10.prod.google.com ([2002:a05:600c:840a:b0:459:d8e5:aea6])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d1f:b0:439:4b23:9e8e
 with SMTP id 5b1f17b1804b1-45a1acf4a5amr167855e9.3.1755099355884; Wed, 13 Aug
 2025 08:35:55 -0700 (PDT)
Date: Wed, 13 Aug 2025 15:35:43 +0000
In-Reply-To: <20250813153548.1650533-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813153548.1650533-1-bqe@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250813153548.1650533-3-bqe@google.com>
Subject: [PATCH v14 2/5] rust: add bindings for bitops.h
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
index 3950f605dedb..a9ebb2d49dea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4315,6 +4315,11 @@ F:	include/linux/bitops.h
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
2.51.0.rc0.205.g4a044479a3-goog


