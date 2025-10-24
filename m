Return-Path: <linux-kernel+bounces-869544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7796C0820F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64AF04F5AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7752F5304;
	Fri, 24 Oct 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="D3V9V6Mu"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AB026FA6E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339087; cv=none; b=qNlzW/diq6pMn5QU6veuR5qSH81Yg+k1/aj0XPPLB9zIBSFZeCnbjXNTUfg94ct6NRkfS/0BEdaANG83f40PfdfaS+oaQFxV9dhNVO2ql+NM73/B1Ue0UmjDHR7Pu3crO/DXZR50Zy43trNv1NyRrTBcgg+x2JjgQ6uyapB7t5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339087; c=relaxed/simple;
	bh=9fM9bt6nA/rtW9PgS3LtSyaJE4LpFg+UkmsIFTKRVf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IyWng5PnUXNdgq4tNn1x6Iy8rzkvz6q1FBmwkNzr03qmrssW9Hk0X/LcBDQN7CzYfEsu9+KWqOZHE9+NwL9fu71thnxjDddKH3DsltKc81wNDigE6vHA98pzri7dhDJFfZh7Zn0SAtbBhYVMC+BuQ/UIHa3ni4J6s36fnfSYy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=D3V9V6Mu; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Uek8+Cf4Q/CngsJr56xLN10Qkqpp/D5bhYp2Lu51lME=; b=D3V9V6Muf8SR7Zy3
	DQWRvU8/R2aKx+yt2DgR4S0lITpROSiud4bsN+1KjA/BWb4ZP7PBsfqmRBwa+ILT1P+ULMtdaclum
	5LdMcvRtbsqFxyrQWPRI9jQseQS5SXL7bpJwxXT1sgPhINVZbrPtbYCuQcUWrNcVB1a5zt31u1oMy
	jkxC9g02n6X8VzefZxmjLJ82ExP4vof/LOtL0lsCZnYnfh510TV/O8r+Ny4obGjJhz/bXN24TwDeJ
	79e1FW1BXrQVnJQj4ZUC+AEwjTEtSKHlHoPBXQNjzvTAh3WPajDPCQ9Gc+s1C0+djgrcW8YzqvCZB
	/CeHWX2h8EHBAtb8+g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1vCOkr-0014Q3-0c;
	Fri, 24 Oct 2025 20:51:21 +0000
From: linux@treblig.org
To: akpm@linux-foundation.org,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] lib/xxhash: remove more unused xxh functions
Date: Fri, 24 Oct 2025 21:51:20 +0100
Message-ID: <20251024205120.454508-1-linux@treblig.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

xxh32_reset() and xxh32_copy_state() are unused, and with those gone,
the xxh32_state struct is also unused.

xxh64_copy_state() is also unused.

Remove them all.

(Also fixes a comment above the xxh64_state that referred to it as
xxh32_state).

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/xxhash.h | 46 +-----------------------------------------
 lib/xxhash.c           | 29 --------------------------
 2 files changed, 1 insertion(+), 74 deletions(-)

diff --git a/include/linux/xxhash.h b/include/linux/xxhash.h
index 27f57eca8cb1..587122e2c29c 100644
--- a/include/linux/xxhash.h
+++ b/include/linux/xxhash.h
@@ -141,21 +141,7 @@ static inline unsigned long xxhash(const void *input, size_t length,
  */
 
 /**
- * struct xxh32_state - private xxh32 state, do not use members directly
- */
-struct xxh32_state {
-	uint32_t total_len_32;
-	uint32_t large_len;
-	uint32_t v1;
-	uint32_t v2;
-	uint32_t v3;
-	uint32_t v4;
-	uint32_t mem32[4];
-	uint32_t memsize;
-};
-
-/**
- * struct xxh32_state - private xxh64 state, do not use members directly
+ * struct xxh64_state - private xxh64 state, do not use members directly
  */
 struct xxh64_state {
 	uint64_t total_len;
@@ -167,16 +153,6 @@ struct xxh64_state {
 	uint32_t memsize;
 };
 
-/**
- * xxh32_reset() - reset the xxh32 state to start a new hashing operation
- *
- * @state: The xxh32 state to reset.
- * @seed:  Initialize the hash state with this seed.
- *
- * Call this function on any xxh32_state to prepare for a new hashing operation.
- */
-void xxh32_reset(struct xxh32_state *state, uint32_t seed);
-
 /**
  * xxh64_reset() - reset the xxh64 state to start a new hashing operation
  *
@@ -210,24 +186,4 @@ int xxh64_update(struct xxh64_state *state, const void *input, size_t length);
  */
 uint64_t xxh64_digest(const struct xxh64_state *state);
 
-/*-**************************
- * Utils
- ***************************/
-
-/**
- * xxh32_copy_state() - copy the source state into the destination state
- *
- * @src: The source xxh32 state.
- * @dst: The destination xxh32 state.
- */
-void xxh32_copy_state(struct xxh32_state *dst, const struct xxh32_state *src);
-
-/**
- * xxh64_copy_state() - copy the source state into the destination state
- *
- * @src: The source xxh64 state.
- * @dst: The destination xxh64 state.
- */
-void xxh64_copy_state(struct xxh64_state *dst, const struct xxh64_state *src);
-
 #endif /* XXHASH_H */
diff --git a/lib/xxhash.c b/lib/xxhash.c
index cf629766f376..4125b3e3cf7f 100644
--- a/lib/xxhash.c
+++ b/lib/xxhash.c
@@ -73,21 +73,6 @@ static const uint64_t PRIME64_3 =  1609587929392839161ULL;
 static const uint64_t PRIME64_4 =  9650029242287828579ULL;
 static const uint64_t PRIME64_5 =  2870177450012600261ULL;
 
-/*-**************************
- *  Utils
- ***************************/
-void xxh32_copy_state(struct xxh32_state *dst, const struct xxh32_state *src)
-{
-	memcpy(dst, src, sizeof(*dst));
-}
-EXPORT_SYMBOL(xxh32_copy_state);
-
-void xxh64_copy_state(struct xxh64_state *dst, const struct xxh64_state *src)
-{
-	memcpy(dst, src, sizeof(*dst));
-}
-EXPORT_SYMBOL(xxh64_copy_state);
-
 /*-***************************
  * Simple Hash Functions
  ****************************/
@@ -239,20 +224,6 @@ EXPORT_SYMBOL(xxh64);
 /*-**************************************************
  * Advanced Hash Functions
  ***************************************************/
-void xxh32_reset(struct xxh32_state *statePtr, const uint32_t seed)
-{
-	/* use a local state for memcpy() to avoid strict-aliasing warnings */
-	struct xxh32_state state;
-
-	memset(&state, 0, sizeof(state));
-	state.v1 = seed + PRIME32_1 + PRIME32_2;
-	state.v2 = seed + PRIME32_2;
-	state.v3 = seed + 0;
-	state.v4 = seed - PRIME32_1;
-	memcpy(statePtr, &state, sizeof(state));
-}
-EXPORT_SYMBOL(xxh32_reset);
-
 void xxh64_reset(struct xxh64_state *statePtr, const uint64_t seed)
 {
 	/* use a local state for memcpy() to avoid strict-aliasing warnings */
-- 
2.51.0


