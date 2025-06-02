Return-Path: <linux-kernel+bounces-670496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4651ACAF2B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 15:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233DF16BA72
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 13:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E1322171C;
	Mon,  2 Jun 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUEJXZK0"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207322171E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871424; cv=none; b=s8dNYdRY568zfbCkQUyHzyFeA6NZdRRjugmYcFSyShjhbaPnbaIOxX4PKHxrfmcuWmw10HoZ2RRttrlrXHPZhglcmO7bMumuYurkIdOYjsGw74V/6Z7mPPxrKCZQ4ceA+UXh2HkgthGJoEpOTMOBVPXeNdo+C77zt1x/15ZDkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871424; c=relaxed/simple;
	bh=E/w79vVPcT3Zr2nhL4Sj2w1AZemSgO2OaKw7xSVzVdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oKtq4tq3Llmiy+fGXhY8ITq4sWkwCshPNIjCy+ZM6uvQGroAUAwSRSgVaE7O5LMikrY9cidIvuUzYt8aZfOzStBSNpQUfZwNUKxhHZEeviIqJwckEo/jDsYhdL/47XCsUmeb+HTxsFDrGH7t+ifHkOJWTqb6niAelzfKpvMEqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUEJXZK0; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4f8192e2cso1631600f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 06:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748871421; x=1749476221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xsZ3bzHWEHjMHqu05pw0LNNFT3NBkPT2T7RuaKPsqs=;
        b=AUEJXZK01RNf9xH8EiLdXaOSfCcK9g9pawjZ0+qk4wCAIqwAJwwivswUU1bBl1MLH/
         RVw1HlYqoHug7cEGLYOADJ5cat3ty0jbUo/tCmW+f8ycDE+CU441u2FKN8gNnuOZD/hB
         8jYDnBFANaoLzHv1XbsZtHtw/N6iQIrdTgtxIEcnxPt107CT3CUZg8EdhXGlQfCqqJpu
         mxIVYT2HPF4HnsfB82/o39bk6ZVxG67rJm05zEU3OCiPBBkv4RVL14kRZbGi11Lsiw4A
         7yZSpJBy4tcRZdsOpu3o6e5juAqEfmrt7MddoSA7DPR8MPU6PCTkHU+tw6FEGaDyFjTb
         FbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748871421; x=1749476221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xsZ3bzHWEHjMHqu05pw0LNNFT3NBkPT2T7RuaKPsqs=;
        b=Gf70fzMaVjpJvrBrC+/rpu5McERIVmC6tZtIEYjl0CI3/0J90Ev5gjzTxjZhXv5c+e
         47ZN9+IawnNyKkE86YK4x2ZGMzgSr0Wrcny5e1/ZQGC6fjlD6y/akhy6wqlek5GcuozH
         fKxylNNuS6kOJsgNUyUt1LBcuwhyLg8xT0Dz0mZ+VIkhInIMields36UbQG62bq1tnxg
         OxacmnR6f61a0OLWeDKgKH3Km1ntx/uo08+I89T9inAVvmdVedk8cF8BBolIpHdLfbng
         Q5XaWTDfGqQjPUKspIBm12XmkCLDEDisvJKLEcRwejLkVS/CBrcS6cwjDsDn0wMVIFu2
         cMAg==
X-Forwarded-Encrypted: i=1; AJvYcCX7IbOHMJw0yZsacRQOZUTjnn59RpScjL3wkDnJ7yaZ0KlUINPVWcFZc/ZKHfPjNW6GssdygbzAd1ElJIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV1ebzYaLuANNBTj/VX7qMkRI+ktZh5BKPrmsF0Mo/PoGXP8Rw
	f2DMPZ/sEctrHHHpSZiMKFI3ofGh9kFf/d5a+cACfmIP3En3i3BJDMSHaGesU14b5NHRoQ==
X-Google-Smtp-Source: AGHT+IFUd3/Au7r0/E7zO/NvqFb2d5LVWOIiZ8HD6Xtu76YAGOeLpsZQ2jP0GboADBe+dtG5nQN0HQQ=
X-Received: from wmbet10.prod.google.com ([2002:a05:600c:818a:b0:450:df6d:a450])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2586:b0:3a4:fb7e:5fa6
 with SMTP id ffacd0b85a97d-3a4fe154b3emr6667986f8f.1.1748871420861; Mon, 02
 Jun 2025 06:37:00 -0700 (PDT)
Date: Mon,  2 Jun 2025 13:36:43 +0000
In-Reply-To: <20250602133653.1606388-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602133653.1606388-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602133653.1606388-3-bqe@google.com>
Subject: [PATCH v10 2/5] rust: add bindings for bitops.h
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
Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 MAINTAINERS            |  5 +++++
 rust/helpers/bitops.c  | 23 +++++++++++++++++++++++
 rust/helpers/helpers.c |  1 +
 3 files changed, 29 insertions(+)
 create mode 100644 rust/helpers/bitops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 86cae0ca5287..04d6727e944c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4141,6 +4141,11 @@ F:	include/linux/bitops.h
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
index 92721d165e35..4de8ac390241 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -8,6 +8,7 @@
  */
 
 #include "bitmap.c"
+#include "bitops.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
-- 
2.49.0.1204.g71687c7c1d-goog


