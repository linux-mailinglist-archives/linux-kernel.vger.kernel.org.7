Return-Path: <linux-kernel+bounces-766757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C11CDB24AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC359189A79C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E742EA753;
	Wed, 13 Aug 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab/9eGle"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A42EA483
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092323; cv=none; b=MerCEZJjT0NHTkX5Tq9PB63qXFwoitqqDIJuTgXaaO4+stV8cbiTL/B9NJr2ugawAhCVuf7krtXx77lWcXatTXIV8AI8Zg2wKgw8b5rtKQ/qBh0DT7tDLbHMmSnUl9S5vG8pLuFZn1ZfeUrdcDbG3i2hKFztzeJ4IQJswvPEWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092323; c=relaxed/simple;
	bh=JQkfk7058DpeupZ5iLpC21qDgS8vcgz+bZhgajNmMTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dInJB9DV2IaeJ7+q2LTOg112X4i1SrlokYHCg1Dtg75g5u/t9bUSETovMgd/1zvCPwBzXzxt5G6S/gO1S+CXisKtbpQyy+eeVhCMqWnBWIzgTb6rI3l/0YQaUNHjmZBQgCSykM1CkjTtc//C/DIkSAwE9ktPGzTpWFmx3Suj+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab/9eGle; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b914186705so1062283f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755092320; x=1755697120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7I1CLCGLbU0y9mn/lwEJ1bdLkYwEZFUd6f7/dKgAqBc=;
        b=ab/9eGle7QRrn0xj7w49h7I5BmOQKgAxEetjCQVYR300pxDAnpN5jI5P//kz4IXCqz
         WBw1ROKNDj7Vm+EB2gusSWwpOoLb+u2NABsMvfDRczVyJlgU6KIXHFN8rPRxu9R3sIT5
         9c0UAcuL0GE1U8ZpcUBnWZngQiOk0tEd1DlzgH3UGs9k+dTXFjSKzU5oEoiv8ipErWm8
         4Guz9w8NTbUBSYb7dwJRypWTBQTAW3Zg8bMWxGIsOkkdb4b6Q/9jFqfRMdJID7Hvthcu
         IHXlAOm78nfpDYuLi7U75NxlUckWEs/6aYGPe5bybRieRvTtzPDrGuv394+2zVoWqASM
         ErEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092320; x=1755697120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7I1CLCGLbU0y9mn/lwEJ1bdLkYwEZFUd6f7/dKgAqBc=;
        b=JqtinZHQ/cpgIFvq1R4fOcYQEO/SjgF1np+pIDMAk/WJjHdFW7YISF10GQemH2T85c
         tO+J5HtfG+PXJQeWrwNL4lTeEodKl12Q3mIrdzh1o0kxooMDZpbVufYiOkhuLw0noH02
         cUBHIA6X8vRoKQzSrJdxaXTq1uJi1ZJLmeCwciL8FR7MStLnRJpnsRuC9wzoOnlXG2sv
         4G+LdEITIkIyNiesRCVNlzD8EANeGZx08sn46JX2APZj3cqv33vYoxiFRhC2j+IO1Bum
         0cfn7Bn/aqYTdX0oWd6PM8g7k00cs7jlBivf+gJSKz7KPOpfp8obiuoJlc2oh2nRXfg1
         1dwg==
X-Forwarded-Encrypted: i=1; AJvYcCWl6Wi5KT7KulLdfuC/IwBmmv8CBwbP5QVqAbQrxhwhoTnr6wlv4YG+3G+xVZJztAh15yUD0mmpCMs7GCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4wLVTHh6GlETDZx0nYe5aNIROFGcI8ypWvK23kDG+PFojiGP
	NO+/CF2/Ucp/CI0R7SDOgqhUCC4YKrRmBVdzHMnc9Gbub73243xBBuVl
X-Gm-Gg: ASbGncsQNZp08bL7roBEUHcxgCj000TByEGi1Xo2GwmxEuGVGFM2aQRIV4fUy8Ngu8C
	d/psdLmXBF9Q2+l0uLMKW2eKWKF0VS/SHXSWEABENfMv0Nj2D1o9/cGKwM/AKlEdYL0tzaQG6la
	lvxDgoSsh7FDma7nFBjA9bbnZCsTjrj4Lfm8gC0aRO9hIbQ8dBql3ZX0DPfujdV/qNQq32ZP0Fp
	wTemuWTAnFMsPhLdrDjGx+rxNsC/LevIomhoKvWlNhjjYsxwtR4JqMh0yaon85t3yZdsmLCmDBA
	lfYuaN8xXxIjM9lcVZdI4s9G1uisemk/HQs4B1wWHskfT70Nq7BSixff8n9aKdubYU2Eqd/NMl+
	RIjb6QybJtMn0jLF3kHidkpHqPUrrQXoX7UKr9Pfio1EcA6nONfLWeVUIgUqLz/25cbZbPQSwVv
	L5O0eaYxpvYhHppm6SUeXhQhtHQg==
X-Google-Smtp-Source: AGHT+IHZNOhAgTvsuvPk892oDXRewzcTY9/3o1skRWreIGXIT2NRj0SynSZXlXoBlZtHMuIDZekDXA==
X-Received: by 2002:a05:6000:258a:b0:3b7:974d:5359 with SMTP id ffacd0b85a97d-3b917eacf60mr2328459f8f.32.1755092319463;
        Wed, 13 Aug 2025 06:38:39 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (87.220.76.34.bc.googleusercontent.com. [34.76.220.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm25677444f8f.69.2025.08.13.06.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:38:39 -0700 (PDT)
From: Ethan Graham <ethan.w.s.graham@gmail.com>
To: ethangraham@google.com,
	glider@google.com
Cc: andreyknvl@gmail.com,
	brendan.higgins@linux.dev,
	davidgow@google.com,
	dvyukov@google.com,
	jannh@google.com,
	elver@google.com,
	rmoar@google.com,
	shuah@kernel.org,
	tarasmadan@google.com,
	kasan-dev@googlegroups.com,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 RFC 1/6] mm/kasan: implement kasan_poison_range
Date: Wed, 13 Aug 2025 13:38:07 +0000
Message-ID: <20250813133812.926145-2-ethan.w.s.graham@gmail.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
In-Reply-To: <20250813133812.926145-1-ethan.w.s.graham@gmail.com>
References: <20250813133812.926145-1-ethan.w.s.graham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ethan Graham <ethangraham@google.com>

Introduce a new helper function, kasan_poison_range(), to encapsulate
the logic for poisoning an arbitrary memory range of a given size, and
expose it publically in <include/linux/kasan.h>.

This is a preparatory change for the upcoming KFuzzTest patches, which
requires the ability to poison the inter-region padding in its input
buffers.

No functional change to any other subsystem is intended by this commit.

Signed-off-by: Ethan Graham <ethangraham@google.com>
---
 include/linux/kasan.h | 16 ++++++++++++++++
 mm/kasan/shadow.c     | 31 +++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 890011071f2b..09baeb6c9f4d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -102,6 +102,21 @@ static inline bool kasan_has_integrated_init(void)
 }
 
 #ifdef CONFIG_KASAN
+
+/**
+ * kasan_poison_range - poison the memory range [start, start + size)
+ *
+ * The exact behavior is subject to alignment with KASAN_GRANULE_SIZE, defined
+ * in <mm/kasan/kasan.h>.
+ *
+ * - If @start is unaligned, the initial partial granule at the beginning
+ *	of the range is only poisoned if CONFIG_KASAN_GENERIC is enabled.
+ * - The poisoning of the range only extends up to the last full granule before
+ *	the end of the range. Any remaining bytes in a final partial granule are
+ *	ignored.
+ */
+void kasan_poison_range(const void *start, size_t size);
+
 void __kasan_unpoison_range(const void *addr, size_t size);
 static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
 {
@@ -402,6 +417,7 @@ static __always_inline bool kasan_check_byte(const void *addr)
 
 #else /* CONFIG_KASAN */
 
+static inline void kasan_poison_range(const void *start, size_t size) {}
 static inline void kasan_unpoison_range(const void *address, size_t size) {}
 static inline void kasan_poison_pages(struct page *page, unsigned int order,
 				      bool init) {}
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d2c70cd2afb1..a1b6bfb35f07 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -147,6 +147,37 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 }
 EXPORT_SYMBOL_GPL(kasan_poison);
 
+void kasan_poison_range(const void *start, size_t size)
+{
+	void *end = (char *)start + size;
+	uintptr_t start_addr = (uintptr_t)start;
+	uintptr_t head_granule_start;
+	uintptr_t poison_body_start;
+	uintptr_t poison_body_end;
+	size_t head_prefix_size;
+	uintptr_t end_addr;
+
+	end_addr = ALIGN_DOWN((uintptr_t)end, KASAN_GRANULE_SIZE);
+	if (start_addr >= end_addr)
+		return;
+
+	head_granule_start = ALIGN_DOWN(start_addr, KASAN_GRANULE_SIZE);
+	head_prefix_size = start_addr - head_granule_start;
+
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC) && head_prefix_size > 0)
+		kasan_poison_last_granule((void *)head_granule_start,
+					  head_prefix_size);
+
+	poison_body_start = ALIGN(start_addr, KASAN_GRANULE_SIZE);
+	poison_body_end = ALIGN_DOWN(end_addr, KASAN_GRANULE_SIZE);
+
+	if (poison_body_start < poison_body_end)
+		kasan_poison((void *)poison_body_start,
+			     poison_body_end - poison_body_start,
+			     KASAN_SLAB_REDZONE, false);
+}
+EXPORT_SYMBOL(kasan_poison_range);
+
 #ifdef CONFIG_KASAN_GENERIC
 void kasan_poison_last_granule(const void *addr, size_t size)
 {
-- 
2.51.0.rc0.205.g4a044479a3-goog


