Return-Path: <linux-kernel+bounces-824772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC86B8A212
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BAA6B60BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4F7314B85;
	Fri, 19 Sep 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdRqnUvr"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80131289821
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293884; cv=none; b=Qioi8Zo3VM9p6r9n528LE2FiRcXAoDmCGSMDUcbAOrJ53CniBQ97YWZbCDSl93r7LuR/yHmkhym+VI9BesMYJuPkVXFzb8EhmNCHd8pGKaz/5x9ZSBquTLJbeREr8osUDgGtZMUO15Y+f8qOGDOeVZxaZt+/WNxiwVUf9Oz0bYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293884; c=relaxed/simple;
	bh=egRlU8I8cap/vMG/cP8j3cYqgKLkvNE8Tghmz+aDQ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACUZzq1Ecnh3QPbTvA6ARJ6J+TKZBDK/m0F6ZeuwDlQ9Yo4oXX/1lo36NqRHxtO4YO5l/S5PKohibaFVrYroOaWlzECb50jxeRMTMmwZ+s3dN5cEd7Laf7RjBdn/2UgYtJAtVWoAEegbbuoeqeJqpvdzPch4YMyBA2aSudcUGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdRqnUvr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso17835915e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758293880; x=1758898680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iux7tJA7Iu45JzwDlqqn3NczB+xQmLnfn/+UUn4bsic=;
        b=JdRqnUvryAa6smB7nKg6KARTl+190Tbrk5xt77sgdnc30u1kPjHdigY4wD/JwYzoDb
         5z3IIcR7ZkVks8kC5AAG1Iqn4hAbuaECNrauHnQpuOD4+1dV/raCWWK5lkli53zbg5GR
         CqmAZUSs6sl3IrGkbWAfn62HYiOkDFVE1gAcssm0LqymrHOv30FeVMHYQuODs9IptO6v
         4/dnn7Zew7lTMqZId4aqOpiKMTswQ3IdU6zQAO8OKCqug/XcIY/bDooDA9qmfUltiIRJ
         e6hLXCKbYgNHrEtORzEekJ+HMok1ATD03jsh57QBxePhlNmhfGK+6vOdf54OIzDSFqGa
         FlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293880; x=1758898680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iux7tJA7Iu45JzwDlqqn3NczB+xQmLnfn/+UUn4bsic=;
        b=aEAZmaGE8eJ1fbLJRXVTTGF/ivZT38A68onYiKsoO5POtQhWPcfG5WUnWOylOGkH/9
         a9yjIlExfn9o3X7EyREdRyVYhcEVKXexNawfpgs9AfJdr2yF+W+Ux163Y/L+M7jEzDqK
         SPk/F5hsaK7KHJ7ZDttU0sSLe9zPpVFE5FLMVOl6GQ/AVTci7U3PyRXH0mdy5oeQ8P0y
         I46/yiOV6JtoilF6TxCHE4cx02AcsKrh4pzz3c29yKrjd/srNW+zC7R/GTH6J0JwbUId
         87tp6YcDPlTP4IIvRQAiD/Ukxz1lixhHqt/Chi1+vwiUpN0nVCmpbBOR+b5cuLuSmwHm
         WHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVblyJNGwUFDOfYq8aTiUJdHgnJ39NEIiyCZSd+5KeIEdDAhWPm3dazB0S7VcvY+SU59O4Va7Env6xtBis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgWx3yCCv5lpTPL+2TB5RJYs4emCbXOBS/i5XtIiWIg9rFqs32
	KKp2C09CteaQtetpMsQqn8CVM7lHPa1JHRJAgx9NgZsMsloaxSGLiaoB
X-Gm-Gg: ASbGnctMAVvbkDx0dJQX4/92ncdPwGFzR/t3Jy4FGaGR8wHpczojW4T00CxO9wMzTKq
	l6q9ARw2tqeh3R99uUzFQruIL59rvckh5T1TvwYjuDpqGk5iSoaMcQelI/2tDlFSobwlAVQoOL2
	o/i5Emu4jY7aawDHn9+2M6mZLdtswjN0KAdGU1PtQ/TAd5ypw2tH5RSYrVH0vTSCUThMFdGY4Fb
	0T3lxDw8X0nx2/dqkqP7qTwPkymLvFBtklFKlgahUcB9EdybbI2jTZyOq7cDluXleluZ6eyVvdF
	Hvchqnwn1WD0P7YmaF1jNLgNlYKwlxXCTwmbPaz2mbcZlykTw0ENwR73kRuYJYiSSGkD/dF0uj/
	lfayuA7/nKr1sUC+ZqOmJIOzL1PH06i4oDwWf2+4A6EHA8d62n7vNqT1gX4dPCQtLDMfKC64Zg/
	LOf5Myg+lOV48qLA0=
X-Google-Smtp-Source: AGHT+IE+XK5nD+9hANJoxYPRSlTs9xbOKfixXYZia7lhztTHnoAksXT/1nQcAsPiiouWjOFFkGLQJg==
X-Received: by 2002:a05:600c:b8d:b0:45d:e326:96fb with SMTP id 5b1f17b1804b1-467ef72d771mr33033965e9.30.1758293879733;
        Fri, 19 Sep 2025 07:57:59 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (124.62.78.34.bc.googleusercontent.com. [34.78.62.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm8551386f8f.37.2025.09.19.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:57:59 -0700 (PDT)
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
	sj@kernel.org,
	tarasmadan@google.com
Subject: [PATCH v2 01/10] mm/kasan: implement kasan_poison_range
Date: Fri, 19 Sep 2025 14:57:41 +0000
Message-ID: <20250919145750.3448393-2-ethan.w.s.graham@gmail.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
In-Reply-To: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com>
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com>
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
Reviewed-by: Alexander Potapenko <glider@google.com>

---
PR v1:
- Enforce KASAN_GRANULE_SIZE alignment for the end of the range in
  kasan_poison_range(), and return -EINVAL when this isn't respected.
---
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
2.51.0.470.ga7dc726c21-goog


