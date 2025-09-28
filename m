Return-Path: <linux-kernel+bounces-835238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E80EBA68DD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B094817BBC7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59632571D8;
	Sun, 28 Sep 2025 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNc9PdTV"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392D17C91
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759040398; cv=none; b=RvW6lqN9SbH0Te+PyoS7zzhwd0lFbDVbemsQd+6hAkH8YPeUpUncsNT/I1DMxxjwie4idMdjjFNIRvTeZkPZYaVcsfO4JG+bpmKcUMtchG7U1yysErIQwWeTO8yZmBkcgtHAkfaUo8nTdyoS2r/6DrPJjiNl+9tjIe7pfBoTBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759040398; c=relaxed/simple;
	bh=EczTh2ggNaPZHbqwCwAxzg8eCUmjYRljLUU+zfNR9Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRcUJlwiFdHFrTNJvW0C5UX8gK6qCZDgRPt/w2w6sirzWpZ2sxmNT9R8A7YBgFNCF86Uwa1RXd4ajuFz78HyTkJWq7ItRz26YFZnnVV48VbNHOdk9+7f6NncNE5elOhDrqwaZuTtiV11zEnGZtp/cPW3nEvhvVn4kIYO9zeiprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNc9PdTV; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so3672482b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 23:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759040396; x=1759645196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8yGIvrkgUDdz26L60d9oWaR1bEYlZvy7H9kA4NT0xY=;
        b=MNc9PdTV8ySh4DSO1TnHLLkURRdvco4OwDdaknU2gRsQjSwrKOzt9JzD32HTRmNZdN
         QRUJ3QzdVaHXuGxNvGzgGqUPdbXhlPgNHvYlLccuNzw4eP1vIdeedJNgtcBAEpEJRSqn
         /iPFPuH4cu2S+Vy5dxcDZwPBP+UKyLGH76bDj53vVnTZbfRftgXqBHJkuQzwSgxm2bZ2
         h49k+9AXWqpnazquEXgRMe4TqMO8TcjMQCWz13KbswnYM7faGQA0mZpOc1yOr+dpmw5h
         pd7yZiiU810dEeetHhSxzlZlKuALzLE+zhddESYmkoe4XFfAAaAW74fr3HxZLi+RbnUW
         InOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759040396; x=1759645196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8yGIvrkgUDdz26L60d9oWaR1bEYlZvy7H9kA4NT0xY=;
        b=dxkItNVJgVunw51kcM/Xp15+SfInEv4QeIxLKrtfwBBjrkxS3r0lgu09gzUsUq1cVr
         pnEcUxuCIv7N95+ucsvjD35+CW+LsrSkaXvZJXMyqfF8SMPytYdDbDXkOekcWFoHPIWd
         x2fw0z9kTkw7L3Tny38qwftgOplo91iIX6erl0VSRM6ia17pSLS20Nwh2R9/yAZtULjS
         aZufV/e6DMo+57F0WlYxQpKFUVs/0StOzlKjws6TZPXB1FDVEWexkQ9Qt3rdIzkWzQqt
         oXp/jj8lIQbUUMaqiJwQAZl8mPvxMsy+/QtpGgNk6wIE2nMmLkoRT7HKgWu7T3f+gbzQ
         Peyw==
X-Forwarded-Encrypted: i=1; AJvYcCVqCu+rCVTfgtw+E6gBE9Npv7nGKGqVpMqISS5mb4/xAFhm0sxenz9yCAuaSDhFnSS7FKFFUZUwK5gpE6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Nb98izhvXhIiF3ZTFOL6PpZPKaFwn5Ejc+kcy2FL532KGdVN
	WFPr0YxR3pIPfGj5orNADCIwg2UmgP/d7bghEzYRRNPEjSRf6HVOSIfx
X-Gm-Gg: ASbGncvMW0rF8O3FcMiglY4v4uQYpnn/8UiMVY1uB0qXePhJNA0advh9SQkTacnw3e7
	U6lSRr6JAWspdBc3WLDSRJu5zwrWCaAWoN3O+UH7ept1iOXRF+a7GRXD8Uhqx4lQiSbDICaEPxt
	SjCV1mipOZ6/SZbPkzCb+RixNer8/VKj9mInXkR6igyHh1Rr2i1Z/4QbxMl5wobrFEFlko3lPxu
	k6ZsY77PdncPRy0lHY1HEAGlyjXF5ERC+EAVXWXlxqtPaNgj/y6CICGkAUXU9s4Gew041LoEN2g
	ht9vGfWu9MrvsPOWZ5tJ9vEsCGaiytoMNeGZJmdwz/6w8AImOzl8BJk8MouYWso+b2RTfoiSoav
	W2ynZEKOJer9wIymOa+EL/9v6QC+cng==
X-Google-Smtp-Source: AGHT+IGCF2nl0/6AjN0iIOilZKlYdieGcVoO4haBJAcSd4c5Q78m3e4EUcOR9h3yQKRHTOD4YaebPQ==
X-Received: by 2002:a05:6a00:8c8:b0:781:27f8:d2e7 with SMTP id d2e1a72fcca58-78127f8d9b9mr3506127b3a.10.1759040396478;
        Sat, 27 Sep 2025 23:19:56 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238f11esm8130046b3a.19.2025.09.27.23.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 23:19:56 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: herbert@gondor.apana.org.au,
	neilb@ownmail.net
Cc: tgraf@suug.ch,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH] rhashtable: use likely/unlikely for rhashtable lookup
Date: Sun, 28 Sep 2025 14:19:50 +0800
Message-ID: <20250928061950.34531-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, the result of the rhashtable_lookup() is expected to be found
or not found. Therefore, we can use likely() or unlikely() for such cases.

Following new functions are introduced, which will use likely or unlikely
during the lookup:

 rhashtable_lookup_likely
 rhashtable_lookup_unlikely
 rhltable_lookup_likely
 rhltable_lookup_unlikely

A micro-benchmark is made for these new functions: lookup a existed entry
repeatedly for 100000000 times, and rhashtable_lookup_likely() gets ~30%
speedup.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
This patch base on the patch that I commit before:
  rhashtable: use __always_inline for rhashtable

The new functions that we introduced can be used by other modules, and I'm
not sure if it is a good idea to do it in this series, as they belong to
different tree. So I decide to do it in the target tree after this patch
merged.
---
 include/linux/rhashtable.h | 94 +++++++++++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 12 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index e740157f3cd7..a4953ab334c5 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -355,12 +355,29 @@ static inline void rht_unlock(struct bucket_table *tbl,
 	local_irq_restore(flags);
 }
 
-static inline struct rhash_head *__rht_ptr(
-	struct rhash_lock_head *p, struct rhash_lock_head __rcu *const *bkt)
+enum rht_lookup_freq {
+	RHT_LOOKUP_NORMAL,
+	RHT_LOOKUP_LIKELY,
+	RHT_LOOKUP_UNLIKELY,
+};
+
+static __always_inline struct rhash_head *__rht_ptr(
+	struct rhash_lock_head *p, struct rhash_lock_head __rcu *const *bkt,
+	const enum rht_lookup_freq freq)
 {
-	return (struct rhash_head *)
-		((unsigned long)p & ~BIT(0) ?:
-		 (unsigned long)RHT_NULLS_MARKER(bkt));
+	unsigned long p_val = (unsigned long)p & ~BIT(0);
+
+	BUILD_BUG_ON(!__builtin_constant_p(freq));
+
+	if (freq == RHT_LOOKUP_LIKELY)
+		return (struct rhash_head *)
+			(likely(p_val) ? p_val : (unsigned long)RHT_NULLS_MARKER(bkt));
+	else if (freq == RHT_LOOKUP_UNLIKELY)
+		return (struct rhash_head *)
+			(unlikely(p_val) ? p_val : (unsigned long)RHT_NULLS_MARKER(bkt));
+	else
+		return (struct rhash_head *)
+			(p_val ?: (unsigned long)RHT_NULLS_MARKER(bkt));
 }
 
 /*
@@ -370,10 +387,17 @@ static inline struct rhash_head *__rht_ptr(
  *   rht_ptr_exclusive() dereferences in a context where exclusive
  *            access is guaranteed, such as when destroying the table.
  */
+static __always_inline struct rhash_head *__rht_ptr_rcu(
+	struct rhash_lock_head __rcu *const *bkt,
+	const enum rht_lookup_freq freq)
+{
+	return __rht_ptr(rcu_dereference(*bkt), bkt, freq);
+}
+
 static inline struct rhash_head *rht_ptr_rcu(
 	struct rhash_lock_head __rcu *const *bkt)
 {
-	return __rht_ptr(rcu_dereference(*bkt), bkt);
+	return __rht_ptr_rcu(bkt, RHT_LOOKUP_NORMAL);
 }
 
 static inline struct rhash_head *rht_ptr(
@@ -381,13 +405,15 @@ static inline struct rhash_head *rht_ptr(
 	struct bucket_table *tbl,
 	unsigned int hash)
 {
-	return __rht_ptr(rht_dereference_bucket(*bkt, tbl, hash), bkt);
+	return __rht_ptr(rht_dereference_bucket(*bkt, tbl, hash), bkt,
+			 RHT_LOOKUP_NORMAL);
 }
 
 static inline struct rhash_head *rht_ptr_exclusive(
 	struct rhash_lock_head __rcu *const *bkt)
 {
-	return __rht_ptr(rcu_dereference_protected(*bkt, 1), bkt);
+	return __rht_ptr(rcu_dereference_protected(*bkt, 1), bkt,
+			 RHT_LOOKUP_NORMAL);
 }
 
 static inline void rht_assign_locked(struct rhash_lock_head __rcu **bkt,
@@ -588,7 +614,8 @@ static inline int rhashtable_compare(struct rhashtable_compare_arg *arg,
 /* Internal function, do not use. */
 static __always_inline struct rhash_head *__rhashtable_lookup(
 	struct rhashtable *ht, const void *key,
-	const struct rhashtable_params params)
+	const struct rhashtable_params params,
+	const enum rht_lookup_freq freq)
 {
 	struct rhashtable_compare_arg arg = {
 		.ht = ht,
@@ -599,12 +626,13 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
 	struct rhash_head *he;
 	unsigned int hash;
 
+	BUILD_BUG_ON(!__builtin_constant_p(freq));
 	tbl = rht_dereference_rcu(ht->tbl, ht);
 restart:
 	hash = rht_key_hashfn(ht, tbl, key, params);
 	bkt = rht_bucket(tbl, hash);
 	do {
-		rht_for_each_rcu_from(he, rht_ptr_rcu(bkt), tbl, hash) {
+		rht_for_each_rcu_from(he, __rht_ptr_rcu(bkt, freq), tbl, hash) {
 			if (params.obj_cmpfn ?
 			    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
 			    rhashtable_compare(&arg, rht_obj(ht, he)))
@@ -643,11 +671,32 @@ static __always_inline void *rhashtable_lookup(
 	struct rhashtable *ht, const void *key,
 	const struct rhashtable_params params)
 {
-	struct rhash_head *he = __rhashtable_lookup(ht, key, params);
+	struct rhash_head *he = __rhashtable_lookup(ht, key, params,
+						    RHT_LOOKUP_NORMAL);
 
 	return he ? rht_obj(ht, he) : NULL;
 }
 
+static __always_inline void *rhashtable_lookup_likely(
+	struct rhashtable *ht, const void *key,
+	const struct rhashtable_params params)
+{
+	struct rhash_head *he = __rhashtable_lookup(ht, key, params,
+						    RHT_LOOKUP_LIKELY);
+
+	return likely(he) ? rht_obj(ht, he) : NULL;
+}
+
+static __always_inline void *rhashtable_lookup_unlikely(
+	struct rhashtable *ht, const void *key,
+	const struct rhashtable_params params)
+{
+	struct rhash_head *he = __rhashtable_lookup(ht, key, params,
+						    RHT_LOOKUP_UNLIKELY);
+
+	return unlikely(he) ? rht_obj(ht, he) : NULL;
+}
+
 /**
  * rhashtable_lookup_fast - search hash table, without RCU read lock
  * @ht:		hash table
@@ -693,11 +742,32 @@ static __always_inline struct rhlist_head *rhltable_lookup(
 	struct rhltable *hlt, const void *key,
 	const struct rhashtable_params params)
 {
-	struct rhash_head *he = __rhashtable_lookup(&hlt->ht, key, params);
+	struct rhash_head *he = __rhashtable_lookup(&hlt->ht, key, params,
+						    RHT_LOOKUP_NORMAL);
 
 	return he ? container_of(he, struct rhlist_head, rhead) : NULL;
 }
 
+static __always_inline struct rhlist_head *rhltable_lookup_likely(
+	struct rhltable *hlt, const void *key,
+	const struct rhashtable_params params)
+{
+	struct rhash_head *he = __rhashtable_lookup(&hlt->ht, key, params,
+						    RHT_LOOKUP_LIKELY);
+
+	return likely(he) ? container_of(he, struct rhlist_head, rhead) : NULL;
+}
+
+static __always_inline struct rhlist_head *rhltable_lookup_unlikely(
+	struct rhltable *hlt, const void *key,
+	const struct rhashtable_params params)
+{
+	struct rhash_head *he = __rhashtable_lookup(&hlt->ht, key, params,
+						    RHT_LOOKUP_UNLIKELY);
+
+	return unlikely(he) ? container_of(he, struct rhlist_head, rhead) : NULL;
+}
+
 /* Internal function, please use rhashtable_insert_fast() instead. This
  * function returns the existing element already in hashes if there is a clash,
  * otherwise it returns an error via ERR_PTR().
-- 
2.51.0


