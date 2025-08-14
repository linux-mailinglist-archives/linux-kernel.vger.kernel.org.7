Return-Path: <linux-kernel+bounces-769150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34769B26AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6541CC1206
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C26F218EA8;
	Thu, 14 Aug 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuRv7zpD"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1D15E5C2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184288; cv=none; b=mPGT4iFbolsNlh2GyjTAQ7zpEQk+WicKxt0fjU5Hy17Z73xsELgRAQnJtNptXcrk9eQc0heC3k7781zibJaFOrlie0chkxXbLExn2PhgTQTFAA9X0WFosnmxxZb6O0uA5Zg8vkE4VRj7aRyyGTSKci/qkoOl0g+Bxwsrv25Mh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184288; c=relaxed/simple;
	bh=1jDJoKW+0uL8pCUw24xwM3FK0vdRrfgga7GPmYtrP6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=maRB6aORlWg6klUKSwY/TVaJXaCk1X1IY/al5lnCuVh3HE4oY1SAFCqyT/csL441TgPNfHP6r/J3+Gqe6TsQkIifQCK0/6rjJlbKXyIRzF1y0RJcrMiZpyQAvzA75vAOETbLzrbxjmNsCwcim9r8ar8R/Mg1MW0oYdUke7SJZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tuRv7zpD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459fbc92e69so77735e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755184285; x=1755789085; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SskdpEkHcdWpBQfUP2UXfkwhjkYyC/FVECNBfHZs9y8=;
        b=tuRv7zpDfZuZUllQUthn4cINMQouhuenRAJbZiCglNS6CLd9sBOXolOt5qCzxti86A
         drgDgOdBtGXZ7xkBmnWLJEif2Yksl43vXWOCUHbqFpgfqydDCwt0XOSHJVZJhBlYELv3
         2UBm3i8k+vhnOU/wBRYn8aY9eYK6Zm2iri2dSXPEMh2L61C1o4OMXfodj3RGUj2mFj5e
         y8cem+mHbuF/I5rWbHRZtKHlJmPkabJrk2olJt5yFs3ywYuaaECWUsR72nIE8sj8p9pL
         6yl7dqSuCzK41c8Thadv7ZRnHV7j4UkmeU2hzChwFkgnCDa2VQEyvdnkQXwF0X9v3slw
         pMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184285; x=1755789085;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SskdpEkHcdWpBQfUP2UXfkwhjkYyC/FVECNBfHZs9y8=;
        b=L4EV/XXAgIo7y9/pWwpsmo2O/3lZqG6gwvtnAq5P8hsyyxGQLshHYuCTHqi+eMVx1j
         CJP3xDTcdbYIDhTX5UW/+wEOwNs96/UID3Vuy3kXTKVxLbFgFIZxmSa3AW5+m2UVWKPE
         dfEhsdiag9C1fNv/wZKn3cYBk1udGSYIZvuHn57mkX4+tlGME3N9vebJfqFKUH9Nmyb7
         ewzwHJLzDGtbB/WOXCCp3/8oMeU3zul8g42N9dL4NawNJyIgzY/E5c6iNBtToMvlO+OL
         ZXzdtO83qD/A5X00GhB7zMbiAlyucp10QFjoXNMv+iV6l2eUf4SkXwvxu+DRE74OPhm5
         L+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCV67cAQagdWSuuSYrGTxL2w8LVzT/T9dJ+eHsw7LhsT2qRtSHtIjXIFoao5hWm0wt6fMZe+0s8/rQItF1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCSOTu4J8mI97dyWdXCzc7oIyTs+G5/xLTpgA+yb8Jm2bRvNlL
	SU9tnmdy+brjgG+8/034qT0xhsyREa8cB/lz1AjhIK6KrK2TVTM4Itbak9Ufvao6YA==
X-Gm-Gg: ASbGnctOzLo6UoG9SQa5H4NYg82GDYCzUs6ZY6LMsKGonTaY+r4ycyccnaj6KpmA6XF
	Xjfz8iaKnqlI+Pak09FbcxzRJRd8hCT4eQo1MKzO63Qov5edXmFTMUl65n0Zxs/tN/nqsFKT5o+
	1s/ggotjIs+3dmiS5c/c1H9rXuoR94ze5nBSTpLBJqXVU7v0XFTVCDrWMwgtXiwOwC/si2bb79y
	lGN0xMT8vVB/qJqJi1kQP8W+akZKi9toUDTJjm2soY9BW2fu4F5UucvZC31Xtth+IzqPebmC05/
	C1tYfXCgi0jLApIHWJrO9RUT9ILf3NafGHN9U1svWS+p1qv3pdkcvevQO7KDI9BogPaEMlEy6fy
	+WZZxKrYsf2W+21St
X-Google-Smtp-Source: AGHT+IHFuKzvFCHbuJcOA23BDSSsr0lmibgl/giYWdRmsmNyG65kEdnqrR+zs/DzX5Vpr3zDoXAx/w==
X-Received: by 2002:a05:600c:c4a6:b0:439:8f59:2c56 with SMTP id 5b1f17b1804b1-45a1b177b3amr2085275e9.2.1755184284501;
        Thu, 14 Aug 2025 08:11:24 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:3dd3:b636:a51b:d0a4])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ba54b6c93fsm1524246f8f.12.2025.08.14.08.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:11:23 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Thu, 14 Aug 2025 17:11:10 +0200
Subject: [PATCH v3] kasan: add test for SLAB_TYPESAFE_BY_RCU quarantine
 skipping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-kasan-tsbrcu-noquarantine-test-v3-1-9e9110009b4e@google.com>
X-B4-Tracking: v=1; b=H4sIAI38nWgC/4WPwRKCIBRFf8VhHQ1CarjqPxoXgC9lKkhApsbx3
 yN1pl0tz1ucc9+EPDgNHtXZhBxE7bU1CdguQ6oXpgOs28SIElqQih7xVXhhcPDSqREbO4zCCRO
 0ARzAB1yoijJWVkCKEiXJw8FFP5fAuVnZwTCmTliP30ydbRH2IwKUVFJyToAe6pijj7PXPlj3W
 n6IdJFuJv5vbqQ4x21eypZzRrjip87a7gZ7Ze+omef5DVQWozEhAQAA
X-Change-ID: 20250728-kasan-tsbrcu-noquarantine-test-5c723367e056
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755184280; l=2857;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=1jDJoKW+0uL8pCUw24xwM3FK0vdRrfgga7GPmYtrP6Q=;
 b=7eqsCi6f+oUTHibo06jMfimP7X6uftqxmyns3NemnHriDHDs4/42buGL0Ep6842p7TLguABrF
 82V650jX80EB7QQQKwD0jNYibeGS0nG/peuF5xjkz/gf8dq6hlxxyc7
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Verify that KASAN does not quarantine objects in SLAB_TYPESAFE_BY_RCU slabs
if CONFIG_SLUB_RCU_DEBUG is off.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v3:
 - add vbabka's ack
 - make comment more verbose (andreyknvl)
 - Link to v2: https://lore.kernel.org/r/20250729-kasan-tsbrcu-noquarantine-test-v2-1-d16bd99309c9@google.com
Changes in v2:
 - disable migration to ensure that all SLUB operations use the same
   percpu state (vbabka)
 - use EXPECT instead of ASSERT for pointer equality check so that
   expectation failure doesn't terminate the test with migration still
   disabled
---
 mm/kasan/kasan_test_c.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 5f922dd38ffa..0affadb201c2 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1073,6 +1073,45 @@ static void kmem_cache_rcu_uaf(struct kunit *test)
 	kmem_cache_destroy(cache);
 }
 
+/*
+ * Check that SLAB_TYPESAFE_BY_RCU objects are immediately reused when
+ * CONFIG_SLUB_RCU_DEBUG is off, and stay at the same address.
+ * Without this, KASAN builds would be unable to trigger bugs caused by
+ * SLAB_TYPESAFE_BY_RCU users handling reycled objects improperly.
+ */
+static void kmem_cache_rcu_reuse(struct kunit *test)
+{
+	char *p, *p2;
+	struct kmem_cache *cache;
+
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_SLUB_RCU_DEBUG);
+
+	cache = kmem_cache_create("test_cache", 16, 0, SLAB_TYPESAFE_BY_RCU,
+				  NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
+
+	migrate_disable();
+	p = kmem_cache_alloc(cache, GFP_KERNEL);
+	if (!p) {
+		kunit_err(test, "Allocation failed: %s\n", __func__);
+		goto out;
+	}
+
+	kmem_cache_free(cache, p);
+	p2 = kmem_cache_alloc(cache, GFP_KERNEL);
+	if (!p2) {
+		kunit_err(test, "Allocation failed: %s\n", __func__);
+		goto out;
+	}
+	KUNIT_EXPECT_PTR_EQ(test, p, p2);
+
+	kmem_cache_free(cache, p2);
+
+out:
+	migrate_enable();
+	kmem_cache_destroy(cache);
+}
+
 static void kmem_cache_double_destroy(struct kunit *test)
 {
 	struct kmem_cache *cache;
@@ -2098,6 +2137,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmem_cache_double_free),
 	KUNIT_CASE(kmem_cache_invalid_free),
 	KUNIT_CASE(kmem_cache_rcu_uaf),
+	KUNIT_CASE(kmem_cache_rcu_reuse),
 	KUNIT_CASE(kmem_cache_double_destroy),
 	KUNIT_CASE(kmem_cache_accounted),
 	KUNIT_CASE(kmem_cache_bulk),

---
base-commit: 0df7d6c9705b283d5b71ee0ae86ead05bd3a55a9
change-id: 20250728-kasan-tsbrcu-noquarantine-test-5c723367e056
prerequisite-change-id: 20250723-kasan-tsbrcu-noquarantine-e207bb990e24:v1
prerequisite-patch-id: 4fab9d3a121bfcaacc32a40f606b7c04e0c6fdd0

-- 
Jann Horn <jannh@google.com>


