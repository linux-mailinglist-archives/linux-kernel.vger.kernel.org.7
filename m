Return-Path: <linux-kernel+bounces-755629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C261B1A981
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D530181759
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEB9291C08;
	Mon,  4 Aug 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IiBBN4dr"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7628B4F3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335110; cv=none; b=sJ5Oo9Mcj/S1BizEhZg4wBf5/dfIP6O0AoGxD4aIToWzngutBudc2inE/SNZ8JmNXhx6K+57QdoAXUlVTfTNJyvYHcCc2MS1uDGP3xkH039wrabqIOts3YKacq+l8z5HH3fD47G6yHt7jx0rJ2WO7MkmMK4RR67IH6ea61VnDr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335110; c=relaxed/simple;
	bh=NjE72AJfCjjPyCkru/f2MOaH1lg7CZ5EkGcOF4OBDks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KlMZRarewH+6u2yTYZlfil/Bt3++8jLj2T9S9y5L3QuxqVkBS9cYtDTcoCCLyRwOzQj3RzDDGDA/wqce3+BGFlD2Qf0e7Z3lujAHEbr+A1LWGJj0pMEeQ9q9ly8T21yTQEAZT+yCje5UTa2oSWsLBC773gCHqJ4mB23AIcNaXtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IiBBN4dr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459d5ab32d1so20035e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754335107; x=1754939907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLpMpvoA1z4oTuimkC9AbHvBIqL/ABDs45bxwTwR93E=;
        b=IiBBN4dra0JYqYB5NHzWkMQ7T1kfqFgT2u18L4R75JzYatUUjjcdvMYE/eJB5bdTrE
         5D2ZbD1MtAy3rX+mDYOISawy2zYP/KKVJbaZ5DUqQQR7dzEetfhzx1ZNPk4ZrhJcbiFm
         6isaT0X1PdO/AE9yQyNEo50EhISeAS0brnT9sZk0SsecGRZSuLLESgqsbCAUBJI/S+7Y
         g5fq1XewT/kvPw9t3P1Pc2+HVNF71zjreVx16+CC0QjpyYhQyAMq6WL8dbdAdTN2fxj0
         7r3T7IIEl/wtT1CM1xW7pVCybGhivnPvBeXoa5/RnhjEXvcCRAlSdAx2o7ZEAkLz1RfI
         q2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754335107; x=1754939907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLpMpvoA1z4oTuimkC9AbHvBIqL/ABDs45bxwTwR93E=;
        b=FQEvTuDQbssKMlH1AIzeFHNDeFeMbSaoxxfBrePA5to6cB2d1YfsngiLdzQxrqGcmv
         IJ+enY+iqhfDnpxaMR7zj5448MXiXdjGHN60J2QLRyexLnaWLqDWt9d8AFMEkx0x3Qsc
         qnKyD83YvjIS8LIgapD3DbzkLvXL13SzAf3P91NkYIAVea019UiFPbJ4y8z89jQmUSAs
         mvGbuYerS0yzFHebxb590TKDp1Z0PoPFOilbhT59L5/No3PVc1+PPwOz1B2EWhwenmL+
         WLxPGSTDO5rEv5kgz74286OfDlkOthz5YQiNuppfG+MBzAoZrJK123knZ49R+7zf37Dc
         hACw==
X-Forwarded-Encrypted: i=1; AJvYcCXMsOSaNjO3nMS+N8RY94CsC56qzkOk/THuWszl4DI0eTI4bM+wsFJqhL+FPHpU3KjU58L6Yuqy2/NOFTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bVPOiWRxBX7XUUuxfpN0afjTPdLnhxPfAS8yWQvEUNGg4pPz
	Rg6LvMSfaMge5MYInK56FzpaYrMxarcqEYnK5jOUdhXY1+yhZ2dcme4t37ZoxZqFYA==
X-Gm-Gg: ASbGnctdx9XjVsqdfqa7xhTqAuVC5G7p+/68hTE+efkG4LhLQR/s5lkM32feytxBdkt
	s3+dYkzhJhIOIR1Lk/2japcOYOrjezGrMwqfWjMjEAMTGbjoeqOJ7KSf7YUxxNfEzFMBnOqEGea
	dA2Ez0O3lkepGfeQYSISaIEMYKxsPkgDFAAIYvxAqguJQZJorgU/9gCXifu6YfnIWi+UfANJzTI
	tzgJgXJ4u0NZBnfAO1wcDwyZvipeUo8M6/ACrS2x9b6mgRK2QHnvqZjtjQtft/pniyjJrCrtxXN
	X72QhYxn13ld6bOZ8s1+md4bzyXH6khJlVEkCvMFC4nGfGvOckSYR/xj2mCJ/zINVDZXiuqxmrL
	dW4dRHy4ljA==
X-Google-Smtp-Source: AGHT+IFk5pynUlS9FSBP/BDYtXEaR7BK3ItjDT3ayyMn7XCBf8iPKo4JkSB801Lzlyp1iGac3gCIhg==
X-Received: by 2002:a05:600c:3b8d:b0:458:92d5:3070 with SMTP id 5b1f17b1804b1-459e13d16demr154465e9.6.1754335107203;
        Mon, 04 Aug 2025 12:18:27 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:2069:2f99:1a0c:3fdd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c4a2187sm17020318f8f.70.2025.08.04.12.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 12:18:26 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 04 Aug 2025 21:17:06 +0200
Subject: [PATCH early RFC 2/4] kbuild: kasan: refactor open coded cflags
 for kasan test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-kasan-via-kcsan-v1-2-823a6d5b5f84@google.com>
References: <20250804-kasan-via-kcsan-v1-0-823a6d5b5f84@google.com>
In-Reply-To: <20250804-kasan-via-kcsan-v1-0-823a6d5b5f84@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754335100; l=1736;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=NjE72AJfCjjPyCkru/f2MOaH1lg7CZ5EkGcOF4OBDks=;
 b=BDqvSo8zU4lISb3FEBItz3PSoNVV4TwDjBHeB1I690t0v00wbQL0cLH2axC58YYT1CIBDzJMN
 B6MMKb0Zo8SD3vG6eifgKNbCFz0c5cSCDSxaGd5VhvQ+hGbZMmExTSZ
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

In the Makefile for mm/kasan/, KASAN is broadly disabled to prevent the
KASAN runtime from recursing into itself; but the KASAN tests must be
exempt from that.

This is currently implemented by duplicating the same logic that is also
in scripts/Makefile.lib. In preparation for changing that logic,
refactor away the duplicate logic - we already have infrastructure for
opting in specific files inside directories that are opted out.

Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/kasan/Makefile | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index dd93ae8a6beb..922b2e6f6d14 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -35,18 +35,10 @@ CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_hw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 
-CFLAGS_KASAN_TEST := $(CFLAGS_KASAN)
-ifndef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
-# If compiler instruments memintrinsics by prefixing them with __asan/__hwasan,
-# we need to treat them normally (as builtins), otherwise the compiler won't
-# recognize them as instrumentable. If it doesn't instrument them, we need to
-# pass -fno-builtin, so the compiler doesn't inline them.
-CFLAGS_KASAN_TEST += -fno-builtin
-endif
+KASAN_SANITIZE_kasan_test_c.o := y
+KASAN_SANITIZE_kasan_test_rust.o := y
 
 CFLAGS_REMOVE_kasan_test_c.o += $(call cc-option, -Wvla-larger-than=1)
-CFLAGS_kasan_test_c.o := $(CFLAGS_KASAN_TEST)
-RUSTFLAGS_kasan_test_rust.o := $(RUSTFLAGS_KASAN)
 
 obj-y := common.o report.o
 obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o

-- 
2.50.1.565.gc32cd1483b-goog


