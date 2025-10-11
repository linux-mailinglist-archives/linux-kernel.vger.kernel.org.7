Return-Path: <linux-kernel+bounces-848952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7F6BCEE46
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 023DF3504EB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE7A1465B4;
	Sat, 11 Oct 2025 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMnOc+43"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F24C81
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760147344; cv=none; b=Q3YBd2KEEbqwrqwy/lDw+LRxpqW1fMZW/a6syCFLCJ+LPRgJAiPP8j6Ym7KQTQMneAe9l5jpSm6PmysrdYY465dny2+HaKSaN3ej32PDRplAbzXFzVWaAXVWROtl832nrVMWH5L6Rcu5azoW5HZMTm2vijfrGYy/EhOD4f0EpFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760147344; c=relaxed/simple;
	bh=g7GDvoZrs8cwwpKWce4EUVp8OaXJbDT9MVkHEmFnElU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HlwWu/tnMZk768LIlUVfoIsmaC9inc+J3Nuy5mh0S/ARHmib1v70oEFTcNs/Mc0w3RkMljbpr0x1JvNsJRbLR7kEBN8ayt7rnEu7DVtEJkGx7QCwFzyEboVqFYQrIlYK7OkCXNWGzWu7gtIZlEAjEWpOx/hiX0QiPrAoGBYfsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMnOc+43; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-27d3540a43fso25815125ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760147342; x=1760752142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iruFdvkToYSVQ/3V/DRRgXRgcaTu19K2IWXmsVEetJo=;
        b=KMnOc+43IM201PEOOYmMagOHgeBuEMuNBqHluuFvUCeurHTsZbgZCuybrhrFvNTmvC
         lcBbLU20Q1+ewfFF3gY42QOhB2PsRJ3cvJzBroL4tCMVrbQqNPUUsMBG/m9M5N4W8EK/
         bxnEQLf+seuumtZz6mJePa5AG18nj9D1Q0NPa7F3HB0adt99uMSFmKICfDj/46Poyjzj
         lauMv8ZHJ9hvhz9lqr3KXbD9e//xFbMJYjfe0KayehIQFd5idNblHC5ZIlXkaLvu4YYC
         A5+QHWaErHED79QUiZ9icBSm3eL8g+AeO70y4k0eF12A07GYxu2m2vnSoyaWoHKI8HV6
         LIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760147342; x=1760752142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iruFdvkToYSVQ/3V/DRRgXRgcaTu19K2IWXmsVEetJo=;
        b=GAzdGy0NtSbkvQQW85P0RUriagYgSJ/8MQwPR5lRb8qtsaIkzsKicT1TVeENpSYQVg
         hvk9OG1dvIvxCCQzuXL8SdBgU6/8qM8B7sJXKB12gD2brTxFcbKRynE9W3jhojM/C3S7
         lLr5O857RH/m9/WssyW9a015rdwOVIMRXvs2I68bqIUzuV2wiuxvo4OW1GaaByFMc8xV
         hIwnuVON+t0Xyo16A6qYJ2acFjYHCdm5I9mBHAbd25SJ88UHydqC4BxBhyZeDz9lkg5t
         I7Bl0m5HpuSE6aHlngiCHCbAmdeH6gaFzsWFteZ9ajF2TU9fsnPyQhd9I1UVz5SUMHqg
         FR1w==
X-Forwarded-Encrypted: i=1; AJvYcCWLmHqnMRpXvppLYgLzg3uqkm50hZ4hN4f519mwF1bEMPEs7T13OPgOVBJkQIDYDFr3IMbJESGtXyySyos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/gWJz2TipHJNi007ac6LcAPpCqzjt+itJQ9ggB1ZZ0O+EJgD
	ZD/Rlxt4hhDjLzX67NamGgUoVgRa5AplwaA7aAIi26rR73OBSwo4LqPGfQtVqzHB8GE=
X-Gm-Gg: ASbGnctxDe7nyFl1TuRV4duoWyLplO1TpSGFE/Du9j5YAR78zjcDpVLY6x4xUpp2m50
	XudFkhg8+B9+G8ZeNlgMN+8dk0Eo5CxrxY9hW405dbZ/dC8ymi82NoNwWHqPenHMKvU8DDTwrLj
	SnbJbm47Q/jVPH2e9aycyJWA6iYnMd/r6p21DJdMivUcInFNH1n053yQae6KL3gRiRrWAheaJwG
	HSMLzHR5Qjv/gxcIV6VeK4md8g1/nKLZiqsXMCcxs5qPhw3THIdqmixfAwzyk0lDs5C0zIiQ2Gv
	qUDe+M892bkP9ZuFO+DxkGKUHkugdvjMONrRNmgDnj2OWJRrQ6MFYvMWpBvP2/dfH2dGetf3+Fe
	1FZzeizrUkE2ctdhdrqO5F9o70+ug5LO+ZeubOajqFQ==
X-Google-Smtp-Source: AGHT+IEYTp589+Jwre/BvJaC5w/WWVYQKdwor88i4CTTMt0bRlBAFpwCuP6hdr/NPHxriRgjt2kUfw==
X-Received: by 2002:a17:902:e943:b0:26c:bcb5:1573 with SMTP id d9443c01a7336-29027303192mr170515445ad.53.1760147342092;
        Fri, 10 Oct 2025 18:49:02 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f07275sm69336655ad.66.2025.10.10.18.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 18:49:01 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: herbert@gondor.apana.org.au,
	neilb@ownmail.net
Cc: tgraf@suug.ch,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH v2] rhashtable: use likely for rhashtable lookup
Date: Sat, 11 Oct 2025 09:48:55 +0800
Message-ID: <20251011014855.73649-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, the result of the rhashtable_lookup() is expected to be found.
Therefore, we can use likely() for such cases.

Following new functions are introduced, which will use likely or unlikely
during the lookup:

 rhashtable_lookup_likely
 rhltable_lookup_likely

A micro-benchmark is made for these new functions: lookup a existed entry
repeatedly for 100000000 times, and rhashtable_lookup_likely() gets ~30%
speedup.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- remove the unlikely, as it's not suitable

This patch base on the patch that I commit before:
  rhashtable: use __always_inline for rhashtable

The new functions that we introduced can be used by other modules, and I'm
not sure if it is a good idea to do it in this series, as they belong to
different tree. So I decide to do it in the target tree after this patch
merged.
---
 include/linux/rhashtable.h | 70 +++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index e740157f3cd7..5b42dcdef23f 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -355,12 +355,25 @@ static inline void rht_unlock(struct bucket_table *tbl,
 	local_irq_restore(flags);
 }
 
-static inline struct rhash_head *__rht_ptr(
-	struct rhash_lock_head *p, struct rhash_lock_head __rcu *const *bkt)
+enum rht_lookup_freq {
+	RHT_LOOKUP_NORMAL,
+	RHT_LOOKUP_LIKELY,
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
+	else
+		return (struct rhash_head *)
+			(p_val ?: (unsigned long)RHT_NULLS_MARKER(bkt));
 }
 
 /*
@@ -370,10 +383,17 @@ static inline struct rhash_head *__rht_ptr(
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
@@ -381,13 +401,15 @@ static inline struct rhash_head *rht_ptr(
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
@@ -588,7 +610,8 @@ static inline int rhashtable_compare(struct rhashtable_compare_arg *arg,
 /* Internal function, do not use. */
 static __always_inline struct rhash_head *__rhashtable_lookup(
 	struct rhashtable *ht, const void *key,
-	const struct rhashtable_params params)
+	const struct rhashtable_params params,
+	const enum rht_lookup_freq freq)
 {
 	struct rhashtable_compare_arg arg = {
 		.ht = ht,
@@ -599,12 +622,13 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
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
@@ -643,11 +667,22 @@ static __always_inline void *rhashtable_lookup(
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
 /**
  * rhashtable_lookup_fast - search hash table, without RCU read lock
  * @ht:		hash table
@@ -693,11 +728,22 @@ static __always_inline struct rhlist_head *rhltable_lookup(
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
 /* Internal function, please use rhashtable_insert_fast() instead. This
  * function returns the existing element already in hashes if there is a clash,
  * otherwise it returns an error via ERR_PTR().
-- 
2.51.0


