Return-Path: <linux-kernel+bounces-742778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D54B0F688
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13998AC5E20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E555A30115E;
	Wed, 23 Jul 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sk6c1fb8"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6008A2FBFF9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282830; cv=none; b=MJjulxc/iaUZPZqk2uFtx/+V9o7pnPABxp9+Z4W7lihRug7kqtFToLJzOuJW8Rke2cTeGK0Hi7e19ewJCKR6nU0qqh3vAa0mpnfJE+87s8Y2wOeuAaXPhPOKpD52IlO2sjImcqh0i0Llain/Fhvll9ITJJ7JbIBeiQKvLoB+8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282830; c=relaxed/simple;
	bh=adPHI4t4JoxREbQY3IlmOrd4nE1YbruoXqCJg1mANYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gxwF8ugLr1xyERg3L9Bikulm4LONMM0R0EZddpE8rH4S1kIHpRi84nYo0//jr/en/9LZTkEOILNMfvMv1I4al+CALXl6if11M8+pNvU8JmLo9R0vN1UdfomYVZ2z0nlNoi0wBlvP/PX7nmE5dke8XpOqMYB2UCPlKg8uMt3CnSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sk6c1fb8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-456007cfcd7so83635e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753282768; x=1753887568; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mrUzeAqJAgSJcs0yfhfK8Cv47SEHn3fw+SKS6td8SA0=;
        b=Sk6c1fb8hS4CWz2tZ4CqeKi5X1B5MP+Zqseb3bk5M6cTMjoPuwtvVwO5H/BR/0DBDl
         41wKV2uuta/oFvJqftSbWVuMONRRXgzWdx4vmdBNHKFAQxu2l2N3YEwlB1XCnuFC/wIJ
         sViK5KJdQnR7VFRIkTA2qzNSA4ZDNlvEwdeVE6t7SApck1syldT5cLtvOhpaYq5zN1Gx
         p07ym1uCZlLmQljTlhwk0MnGbrfM7gY36R4/ftQOJjkMS1VBPtx0kBo8E9jVeRh5mHhx
         GBq856TTY79TyW53e2q4szkR/o2KOxQppAl90sQiW53YLwcsBBOLX1k/O5HU5UVXZYOR
         KpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282768; x=1753887568;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrUzeAqJAgSJcs0yfhfK8Cv47SEHn3fw+SKS6td8SA0=;
        b=XZ595qR0KYFQ3Bdjs2/AGUqeJZkmYT4F6l/Hos4unBF1SWcL0NRrZjDOJnTGYLRwFy
         poZrBsVGtCgM5ib6irs4wn3SGPMsZhsykW6+R7ve5d7VbtDPSu+ZbP7kcSP3F6jikAyi
         +kN5KXZC48vIqwxpiAO66ebQxJkcIeDQr1kVS9pWso98K0cW7raw9HLqINN+EAy44OLe
         Uu8oXoegDpLcqIyKIVBv+vg5zG4Mz/AnoNciJOlorTYbzACPwGzHiq70qqno5G+yyS+0
         euuktL5WaZe6yVBC3TpfbdL7zpybBKsDkZ9fIxax8UjPAiXyULu6QBMO5WVqsC6Xs36v
         nVeg==
X-Forwarded-Encrypted: i=1; AJvYcCUMEi1pQoZoMJrEc2b8+sbfj9Q/0jd41rWV5fxNS+BS1MfHw6V7U5rQAmz4NHL3R/glzDCu6Jk2lBfzGhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlbJIC5QBL/SJarC3YuuAOokiGqS9af8y9ukIt/tfa8g/bcO5/
	EBk8n96UKMDev+Ly1jBOtTVWtzgCZgBFt6/f0pST8HE5hTiLHBD/23kmWSyRuwakvQ==
X-Gm-Gg: ASbGnct3aVlI4KUOCEWbWNru7WFuaJUbKlGrfRNjCejAFA1x0UrTJWwAu1KRudZLRPx
	ywNkU5l7b08ofUzG+AMHA5cR7kC0Evr9VxaWAPGu0QPIThDpcf19xeE4Rj2hKYYosH2XZIkt3SJ
	j/JfpBc+JaLnAENJL9SD2/2rqM53xFH/ZxrUFlSxO/Vo/ZncHqlkwzGa33tcIRQ2q8oIUNPXUzZ
	JA7DBc7VOqJPJs96/4jKIfng3e3gFAD4nLly9WXWibdWdPTvODF3dOPLKJzUg/Nie+2VDYjZQj4
	hM68VsDkSWnEenJd32a8nFiYU/J/nGZbYcehpGWp70GOgl6Z57xaK/CfSuuB+hDTJBIhCOxaI4G
	b0AavSwp+vOVq4sdePllZ
X-Google-Smtp-Source: AGHT+IGbQfy//Qbfm8JE9/qvJe3eag1FupMKSbzpYIXiaLPU6nQJNskytzV7WfCUGDyDxN7sWJtAkg==
X-Received: by 2002:a05:600c:c04b:10b0:442:feea:622d with SMTP id 5b1f17b1804b1-4586947515fmr1001615e9.1.1753282767736;
        Wed, 23 Jul 2025 07:59:27 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:8af4:48b6:182f:2434])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b61ca487fdsm16553683f8f.48.2025.07.23.07.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:59:26 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 23 Jul 2025 16:59:19 +0200
Subject: [PATCH] kasan: skip quarantine if object is still accessible under
 RCU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-kasan-tsbrcu-noquarantine-v1-1-846c8645976c@google.com>
X-B4-Tracking: v=1; b=H4sIAMb4gGgC/x3MQQqDQAxA0atI1g1M0xbRq5QuMjbVIMQ2URHEu
 3dw+Rb/7xDiKgFttYPLqqGTFVwvFXQDWy+o72KgRI9U0w1HDjacI3u3oE2/hZ1tVhMUSnXOTZO
 E7lD6r8tHt/P9fB3HH18ZYKdrAAAA
X-Change-ID: 20250723-kasan-tsbrcu-noquarantine-e207bb990e24
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753282763; l=3240;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=adPHI4t4JoxREbQY3IlmOrd4nE1YbruoXqCJg1mANYY=;
 b=Z83uOcvUi20dyNI/jDIxgSTZANRZyssbbsESb040Fl+CVwwSVB63M3K9wCM+YfaV/mMVv1/Uq
 PqVrnmlmqnlDPPlzwpQFvrT3yOjtJkds8+j17a6WtMFj7gTR0flqjSV
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Currently, enabling KASAN masks bugs where a lockless lookup path gets a
pointer to a SLAB_TYPESAFE_BY_RCU object that might concurrently be
recycled and is insufficiently careful about handling recycled objects:
KASAN puts freed objects in SLAB_TYPESAFE_BY_RCU slabs onto its quarantine
queues, even when it can't actually detect UAF in these objects, and the
quarantine prevents fast recycling.

When I introduced CONFIG_SLUB_RCU_DEBUG, my intention was that enabling
CONFIG_SLUB_RCU_DEBUG should cause KASAN to mark such objects as freed
after an RCU grace period and put them on the quarantine, while disabling
CONFIG_SLUB_RCU_DEBUG should allow such objects to be reused immediately;
but that hasn't actually been working.

I discovered such a UAF bug involving SLAB_TYPESAFE_BY_RCU yesterday; I
could only trigger this bug in a KASAN build by disabling
CONFIG_SLUB_RCU_DEBUG and applying this patch.

Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/kasan/common.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index ed4873e18c75..9142964ab9c9 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -230,16 +230,12 @@ static bool check_slab_allocation(struct kmem_cache *cache, void *object,
 }
 
 static inline void poison_slab_object(struct kmem_cache *cache, void *object,
-				      bool init, bool still_accessible)
+				      bool init)
 {
 	void *tagged_object = object;
 
 	object = kasan_reset_tag(object);
 
-	/* RCU slabs could be legally used after free within the RCU period. */
-	if (unlikely(still_accessible))
-		return;
-
 	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
 			KASAN_SLAB_FREE, init);
 
@@ -261,7 +257,22 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 	if (!kasan_arch_is_ready() || is_kfence_address(object))
 		return false;
 
-	poison_slab_object(cache, object, init, still_accessible);
+	/*
+	 * If this point is reached with an object that must still be
+	 * accessible under RCU, we can't poison it; in that case, also skip the
+	 * quarantine. This should mostly only happen when CONFIG_SLUB_RCU_DEBUG
+	 * has been disabled manually.
+	 *
+	 * Putting the object on the quarantine wouldn't help catch UAFs (since
+	 * we can't poison it here), and it would mask bugs caused by
+	 * SLAB_TYPESAFE_BY_RCU users not being careful enough about object
+	 * reuse; so overall, putting the object into the quarantine here would
+	 * be counterproductive.
+	 */
+	if (still_accessible)
+		return false;
+
+	poison_slab_object(cache, object, init);
 
 	/*
 	 * If the object is put into quarantine, do not let slab put the object
@@ -519,7 +530,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 	if (check_slab_allocation(slab->slab_cache, ptr, ip))
 		return false;
 
-	poison_slab_object(slab->slab_cache, ptr, false, false);
+	poison_slab_object(slab->slab_cache, ptr, false);
 	return true;
 }
 

---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250723-kasan-tsbrcu-noquarantine-e207bb990e24

-- 
Jann Horn <jannh@google.com>


