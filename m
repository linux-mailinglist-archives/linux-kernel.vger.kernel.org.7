Return-Path: <linux-kernel+bounces-818418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C5B59184
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D33D7AF9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D351293C42;
	Tue, 16 Sep 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbjscKHF"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD7213E6A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013283; cv=none; b=XvboLE+gebKCBWCkmhZZIK0782wohoEeQ7LWFv46LhZ6GNgQuJc+usnQRkVxAr/gCPPCvFbbeL5VdFvUq6BQBTb2BOiJw+6Jez1Luaot+g4O45jDKWgm20Grhz25SZSR72nD94lJSMKNu9zta3I0ETkuO8uFG+O5GkmnByDg2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013283; c=relaxed/simple;
	bh=qJDnwsi8rYP5Wp+H8LxkPOvT+aBCJa1jnIBCRmNCEj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hbt8YLTeVbIL5CfjQye2VSySfN97Pm3yrElgU/vkXL1v89gGqS3gNDt3RXi+r24AArIlO4nf2N85VA+MZYuMOI/ZTD8Cxk7EA45/Zb1zer2JhlulqRr1KMOObDmCLrbrwsNTeqlON4AROFvXIXAufBsOVufOGeMg7bXWCh1fWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbjscKHF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45f2b062b86so15316275e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758013280; x=1758618080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yrCmffzlGuEExOPu+2JuPwFc40pU2sHK0rUuIT3g74=;
        b=AbjscKHFL8ivpiE4yWO+py7ajRN2ClTsfiDFIRjyAWoo9kIt4V+jaLQmEtXoTMVOoU
         rrt8EjbnVxENPm5Fi2UHy3/PUzGC3BUeNun/bglZzVRhHIOPWHgmgBIaHl06VqL4S4Rm
         aPtBklFN924h2JgG7ULc8v5G4BNM+BPurRoQ2azY6NBh+CFMD0rbNoa+FPXInbSZPRZe
         T+DxzhyzxzX9y4nlWTB4nH/tfnphWTV+1VhiJs5kI3szySOS+f3870jwMy/DKI4YCWb3
         9QL2EzjFAb2cQc8SIMZ6rKixzpInrUj/aNN+Hh5csqoziUUtZeLgijcFRrKXSeS8KGmc
         dtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758013280; x=1758618080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yrCmffzlGuEExOPu+2JuPwFc40pU2sHK0rUuIT3g74=;
        b=GbiJX/2Bm2HW2k4Hqg/F0DI8+cAnbQGocRsBjuW42rPtfo7LSJHxBfrTqGxXLQ4psf
         7zpKIpdvZEpE9lZ70L8rgaNIZVh/P5JZEDHSwoL2CTHtIvJqO0pOKao57RFOIDv8dE1T
         ha6OpHsqQlWN+bNty9w1d00dg4lZYDGBU7THI3BRffonxDh+IPL6YC6dLjUo7bvd4s6K
         vkEpsZRGd0ZXziFYWa27Dbltp83mYOpZQiai49KAlccATHR3tQzy7nkR8R+r8guBqCw8
         /zoW5WK+ypBMnZX+Sc8/LgtcG30/k1h2DUkA/K3wbhZkRrMBXcetVqxCPOOrbPDbM3LT
         Sf7g==
X-Forwarded-Encrypted: i=1; AJvYcCXlK07LO9LtsODD8Jurb2XoWL3qgkkrTTWnBext2mExmJWZaNvcj7DFakuKewx/xLWtPG9VIGa7lWixx9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3pIkm+T1+chsEgeY0nhVXZSbGdnUihYjYyJvujrmeXXs0lW4Q
	lDvx0zKmlE0RSN6coSre9lxzbPGAHweAlyUlvK22Jt56RD2ml6lq01x9
X-Gm-Gg: ASbGncsYt1KU1bf1SFZ0w8YLS/8ZwzAIiNDQVF5Si4abDT3r5VsXoNlGQzEw3/t3Sjp
	hOxX5TxEl/PrqwlTgA7V0TdmIHunccT18bXAxp+BeWkRlj6H4ReY9Znzpd6sUN115lobeKq/Fgd
	OV1hXhFRwcReIfhie42EXs6BEbNoFvrUSWkHljIhSYfJ+iT9moISVl2KWqpkLJ4/33wQqVTqbcK
	gppfwWkD/Pi1L6FDCPpJoEX3EXzan4ttpoQJVlFjL6nwBvSyOvGUQz/J0ZgXevS8/kdAZVSrwgV
	aPamiwrDg0lPAOMUMZ+gywkt9vIucnQSjVp6nV9LgCCe4pQx6DuQio09/XfK2YtZdBd/XCOOcNl
	rqjDZcO0cjdpThkGsZmWYhlnZ7wmCdWujtQc57/om6KMEyHxsVeMwwiH4aGtzP+9dTg2tE87736
	RGLItQCs2/+JyDUadJojnspHM=
X-Google-Smtp-Source: AGHT+IG5iZ2HWUjjmWFwCC/GHnLa6bpp4pAlSd7iyIhSqBHOTc39tKRs7gflZ9w5k6y0UE7LS5O+zA==
X-Received: by 2002:a05:6000:250e:b0:3ec:d789:b35e with SMTP id ffacd0b85a97d-3ecd789b5b1mr817634f8f.8.1758013279529;
        Tue, 16 Sep 2025 02:01:19 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (42.16.79.34.bc.googleusercontent.com. [34.79.16.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037186e5sm212975035e9.5.2025.09.16.02.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:01:18 -0700 (PDT)
From: Ethan Graham <ethan.w.s.graham@gmail.com>
To: ethangraham@google.com,
	glider@google.com
Cc: andreyknvl@gmail.com,
	andy@kernel.org,
	brauner@kernel.org,
	brendan.higgins@linux.dev,
	davem@davemloft.net,
	davidgow@google.com,
	dhowells@redhat.com,
	dvyukov@google.com,
	elver@google.com,
	herbert@gondor.apana.org.au,
	ignat@cloudflare.com,
	jack@suse.cz,
	jannh@google.com,
	johannes@sipsolutions.net,
	kasan-dev@googlegroups.com,
	kees@kernel.org,
	kunit-dev@googlegroups.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lukas@wunner.de,
	rmoar@google.com,
	shuah@kernel.org,
	tarasmadan@google.com
Subject: [PATCH v1 01/10] mm/kasan: implement kasan_poison_range
Date: Tue, 16 Sep 2025 09:01:00 +0000
Message-ID: <20250916090109.91132-2-ethan.w.s.graham@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250916090109.91132-1-ethan.w.s.graham@gmail.com>
References: <20250916090109.91132-1-ethan.w.s.graham@gmail.com>
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

---
v3:
- Enforce KASAN_GRANULE_SIZE alignment for the end of the range in
  kasan_poison_range(), and return -EINVAL when this isn't respected.
---

Signed-off-by: Ethan Graham <ethangraham@google.com>
---
 include/linux/kasan.h | 11 +++++++++++
 mm/kasan/shadow.c     | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 890011071f2b..cd6cdf732378 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -102,6 +102,16 @@ static inline bool kasan_has_integrated_init(void)
 }
 
 #ifdef CONFIG_KASAN
+
+/**
+ * kasan_poison_range - poison the memory range [@addr, @addr + @size)
+ *
+ * The exact behavior is subject to alignment with KASAN_GRANULE_SIZE, defined
+ * in <mm/kasan/kasan.h>: if @start is unaligned, the initial partial granule
+ * at the beginning of the range is only poisoned if CONFIG_KASAN_GENERIC=y.
+ */
+int kasan_poison_range(const void *addr, size_t size);
+
 void __kasan_unpoison_range(const void *addr, size_t size);
 static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
 {
@@ -402,6 +412,7 @@ static __always_inline bool kasan_check_byte(const void *addr)
 
 #else /* CONFIG_KASAN */
 
+static inline int kasan_poison_range(const void *start, size_t size) { return 0; }
 static inline void kasan_unpoison_range(const void *address, size_t size) {}
 static inline void kasan_poison_pages(struct page *page, unsigned int order,
 				      bool init) {}
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d2c70cd2afb1..7faed02264f2 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -147,6 +147,40 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 }
 EXPORT_SYMBOL_GPL(kasan_poison);
 
+int kasan_poison_range(const void *addr, size_t size)
+{
+	uintptr_t start_addr = (uintptr_t)addr;
+	uintptr_t head_granule_start;
+	uintptr_t poison_body_start;
+	uintptr_t poison_body_end;
+	size_t head_prefix_size;
+	uintptr_t end_addr;
+
+	if ((start_addr + size) % KASAN_GRANULE_SIZE)
+		return -EINVAL;
+
+	end_addr = ALIGN_DOWN(start_addr + size, KASAN_GRANULE_SIZE);
+	if (start_addr >= end_addr)
+		return -EINVAL;
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
+	return 0;
+}
+EXPORT_SYMBOL(kasan_poison_range);
+
 #ifdef CONFIG_KASAN_GENERIC
 void kasan_poison_last_granule(const void *addr, size_t size)
 {
-- 
2.51.0.384.g4c02a37b29-goog


