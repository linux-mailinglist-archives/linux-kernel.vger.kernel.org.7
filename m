Return-Path: <linux-kernel+bounces-670495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D60ACAF24
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 15:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3341168C4D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD14221DA2;
	Mon,  2 Jun 2025 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vk+KPtg3"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C482221297
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871422; cv=none; b=Sp9wfljQwKz9OcC6qEmfp6BVRsvcPDPBUgIYHCPtAAZ74BDAhVZXUFCwzPdqVwnaj0/BjMrtuD4lTUlG7riUCmKtWy9A9U6mgMu9S7C5dGKKeesVI2w3YJWHgD7Mpskmov/9QLnBh2rc3Km0W5kYu9ES4JIFXJKhipIUsmAsQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871422; c=relaxed/simple;
	bh=Rzcn2D1R7zSupN/1sKBCkj6sw/WKyT+A5UTnYCzGiiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tKc17z1DfCLESbXDbEpRy54fRgenAvP1+PfKgpiPh8OKpOQHO5yUjRtkK2Y4vBl0kCAn4BzkusdR4xrV5NN0XBERw1hcz98jDbxsG2JllQyf1BelRUhgS+cLwEVg3lFipiGl6d466H9nDat16oHMjO6gtMmbPkfeE3gUVpJF+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vk+KPtg3; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-441c122fa56so22850795e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748871419; x=1749476219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXNjx/GHWFg5i/sgYd5jVrVVV/q/iAdZaBE+RX63LUg=;
        b=vk+KPtg3q0vNxyXlksCjBZrB7ATwa5SzKWjhJels7JtM4GAtclQ63kE/u8BV1CeSbp
         Ub4ZIq8ku98Jm9IWOBjtfbFrGflQR0bcPt6cmYHpEQM9TalWtMcj5zEykeIhp56j3I5J
         J8KaqEmN/7XO4ji4idlIY3q6dCEJ2JYNY8EOV+HiSvpcdww50UcxTmTIyb4xN6OrD3VP
         7EmONLtiiv0flShUnHbvx6rBTnnodLI7WS1QlcY09MuussFH+yEJRBe9V7F02dRYzoo0
         OtGMJdWKiqTeDc3t6HTdNcneQc+qVnuXvwOVYjf75+o8gKjq/dM2ICOWu4cEo7BW2ElA
         8R6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748871419; x=1749476219;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXNjx/GHWFg5i/sgYd5jVrVVV/q/iAdZaBE+RX63LUg=;
        b=GW7KTczvVGYwd4WnLwemCwj1taDp9JkV3yoREgsTP3TofelesWrQLOBX1obF9UMssk
         g0JyEg3+C1VMIfLY4CZ5zSTusz5qaMxd13XghJxumfse25T3KdX03RhqsYV8Z6VdqvjN
         P+TUx2ZYoepaXDq1HeHFalhK5QwvcJaWOjWEPUD68rhZX05KsSGq6/bze6V96KBwoKBT
         VyFnULoDaT0l9l5uqLHLMeQvOPKS4O0O0D3TONptg72E/m45QfyWHtGuWPfOWQhpb5QY
         QVpCs6y78knWtys1tN3bVn60YIyocs3FRMrrl01YJFHd6WkTp7WBnO/+dIZsLs7AkI23
         e+vA==
X-Forwarded-Encrypted: i=1; AJvYcCVaM1O0CSXl8y9D/T8/kwIiiE1gaiYe9uLzuM63TcI22pMnyyZ3cylsGmd4uqXtjuDlnn1ubvsYwuiEras=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoIXIoFvySKDj4hpRAhGPgthbS/d7GA/uTAzbSMsF+xBIKL8dK
	zU5wk567nzPokoFsfb5UtZzfP9RkUkhO/4yPmrwdHFzdEnksIdhgvZWRJaZO9pGwnJy8Vw==
X-Google-Smtp-Source: AGHT+IH+XTiaopR1o9rCxUTaqEGddIxwDMEs5nBiRbjH3ugypXNCoZanuCJ+ki2CgKcXOM/X2V/sUsk=
X-Received: from wmqc13.prod.google.com ([2002:a05:600c:a4d:b0:44a:ebc5:9921])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c0cf:b0:442:d9f2:ded8
 with SMTP id 5b1f17b1804b1-450d65008a7mr102584095e9.15.1748871418996; Mon, 02
 Jun 2025 06:36:58 -0700 (PDT)
Date: Mon,  2 Jun 2025 13:36:42 +0000
In-Reply-To: <20250602133653.1606388-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602133653.1606388-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602133653.1606388-2-bqe@google.com>
Subject: [PATCH v10 1/5] rust: add bindings for bitmap.h
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
2.49.0.1204.g71687c7c1d-goog


