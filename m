Return-Path: <linux-kernel+bounces-733620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 568C7B07711
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F6D1C23E14
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6025D1C6FE1;
	Wed, 16 Jul 2025 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="EADvPoax"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D3619E97A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672781; cv=none; b=Pn3FMtcsiig64TtfwLyNjKqn3P6OfXqM7TmjDkKilJg3dHt3sjubZJvE7lY+/BqCzJyQjWxapxtAkMyfewVfXrhTyUzAuGxqNdqNRGUxN/l22+jtsW8tBopGGkVn/NbhznHvUjmTXkGoAQf8grXHFbhbXX3gDSzshniU3FamXqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672781; c=relaxed/simple;
	bh=UUHoguIdstpvFT2NbvNnnSQZ/Qj3oGXOWaavgxupbqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBF9LWfv3hbL8Oo6v/lOwn84CYBDQg5H+Rfca+Zvd/Av/NMF+PU6XRQaBLSCtyvs7ZJRMnF8XBcKz9CW1dV18Cro76pPH/NyJUVyPs0fZhqkaK/AsJboE009SOHGr+mFZcbUx+TDR/zVTI26lMASvyETFX0cXLHx1Th4Lm0E8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=EADvPoax; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=0qwp6Gi8EUdJZCbe1QwSKwoqDtjQllX3p2oxki7w6wA=; b=EADvPoax3j5VmF75
	B2zemYLLSCx8UrLSq15zxWdEkUyETHGHpEhTR09OMSgQPDlAqWiu7cBOVid6f6zKZ1ZB2tWZig03w
	aemjC4MEaXk/4ALqSLbY4iC8qAHjRSNQKsymP4A+Ev/a4cznUbZEzqFRreq+ts6neKtE5jQS2gn9/
	NHWJ6bEGShDgyS1M/PvtDvoW113umlZv4U0BaBGQ3+GwwOiwaqsO72mZ/Sg1ObMZ1K51ymClZBSJ9
	ujAEA8oHIguQklXb2Y7qqVfC+yft7qCq29cTJxrAjoKOWX9u2TokWmpZv9JHwoD/N+bxSIIMHC8oM
	Qe0CBmHD1A3ELW1fWA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uc2Fa-00GQXY-1F;
	Wed, 16 Jul 2025 13:32:46 +0000
From: linux@treblig.org
To: akpm@linux-foundation.org,
	hch@infradead.org,
	terrelln@fb.com
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] lib/xxhash: Remove unused functions
Date: Wed, 16 Jul 2025 14:32:45 +0100
Message-ID: <20250716133245.243363-1-linux@treblig.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

xxh32_digest() and xxh32_update() were added in 2017 in the original
xxhash commit, but have remained unused.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
v2
  Actually remove the code rather than comment it out (Christoph)

 include/linux/xxhash.h |  26 ----------
 lib/xxhash.c           | 107 -----------------------------------------
 2 files changed, 133 deletions(-)

diff --git a/include/linux/xxhash.h b/include/linux/xxhash.h
index df42511438d0..27f57eca8cb1 100644
--- a/include/linux/xxhash.h
+++ b/include/linux/xxhash.h
@@ -177,32 +177,6 @@ struct xxh64_state {
  */
 void xxh32_reset(struct xxh32_state *state, uint32_t seed);
 
-/**
- * xxh32_update() - hash the data given and update the xxh32 state
- *
- * @state:  The xxh32 state to update.
- * @input:  The data to hash.
- * @length: The length of the data to hash.
- *
- * After calling xxh32_reset() call xxh32_update() as many times as necessary.
- *
- * Return:  Zero on success, otherwise an error code.
- */
-int xxh32_update(struct xxh32_state *state, const void *input, size_t length);
-
-/**
- * xxh32_digest() - produce the current xxh32 hash
- *
- * @state: Produce the current xxh32 hash of this state.
- *
- * A hash value can be produced at any time. It is still possible to continue
- * inserting input into the hash state after a call to xxh32_digest(), and
- * generate new hashes later on, by calling xxh32_digest() again.
- *
- * Return: The xxh32 hash stored in the state.
- */
-uint32_t xxh32_digest(const struct xxh32_state *state);
-
 /**
  * xxh64_reset() - reset the xxh64 state to start a new hashing operation
  *
diff --git a/lib/xxhash.c b/lib/xxhash.c
index b5bd567aa6b3..cf629766f376 100644
--- a/lib/xxhash.c
+++ b/lib/xxhash.c
@@ -267,113 +267,6 @@ void xxh64_reset(struct xxh64_state *statePtr, const uint64_t seed)
 }
 EXPORT_SYMBOL(xxh64_reset);
 
-int xxh32_update(struct xxh32_state *state, const void *input, const size_t len)
-{
-	const uint8_t *p = (const uint8_t *)input;
-	const uint8_t *const b_end = p + len;
-
-	if (input == NULL)
-		return -EINVAL;
-
-	state->total_len_32 += (uint32_t)len;
-	state->large_len |= (len >= 16) | (state->total_len_32 >= 16);
-
-	if (state->memsize + len < 16) { /* fill in tmp buffer */
-		memcpy((uint8_t *)(state->mem32) + state->memsize, input, len);
-		state->memsize += (uint32_t)len;
-		return 0;
-	}
-
-	if (state->memsize) { /* some data left from previous update */
-		const uint32_t *p32 = state->mem32;
-
-		memcpy((uint8_t *)(state->mem32) + state->memsize, input,
-			16 - state->memsize);
-
-		state->v1 = xxh32_round(state->v1, get_unaligned_le32(p32));
-		p32++;
-		state->v2 = xxh32_round(state->v2, get_unaligned_le32(p32));
-		p32++;
-		state->v3 = xxh32_round(state->v3, get_unaligned_le32(p32));
-		p32++;
-		state->v4 = xxh32_round(state->v4, get_unaligned_le32(p32));
-		p32++;
-
-		p += 16-state->memsize;
-		state->memsize = 0;
-	}
-
-	if (p <= b_end - 16) {
-		const uint8_t *const limit = b_end - 16;
-		uint32_t v1 = state->v1;
-		uint32_t v2 = state->v2;
-		uint32_t v3 = state->v3;
-		uint32_t v4 = state->v4;
-
-		do {
-			v1 = xxh32_round(v1, get_unaligned_le32(p));
-			p += 4;
-			v2 = xxh32_round(v2, get_unaligned_le32(p));
-			p += 4;
-			v3 = xxh32_round(v3, get_unaligned_le32(p));
-			p += 4;
-			v4 = xxh32_round(v4, get_unaligned_le32(p));
-			p += 4;
-		} while (p <= limit);
-
-		state->v1 = v1;
-		state->v2 = v2;
-		state->v3 = v3;
-		state->v4 = v4;
-	}
-
-	if (p < b_end) {
-		memcpy(state->mem32, p, (size_t)(b_end-p));
-		state->memsize = (uint32_t)(b_end-p);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(xxh32_update);
-
-uint32_t xxh32_digest(const struct xxh32_state *state)
-{
-	const uint8_t *p = (const uint8_t *)state->mem32;
-	const uint8_t *const b_end = (const uint8_t *)(state->mem32) +
-		state->memsize;
-	uint32_t h32;
-
-	if (state->large_len) {
-		h32 = xxh_rotl32(state->v1, 1) + xxh_rotl32(state->v2, 7) +
-			xxh_rotl32(state->v3, 12) + xxh_rotl32(state->v4, 18);
-	} else {
-		h32 = state->v3 /* == seed */ + PRIME32_5;
-	}
-
-	h32 += state->total_len_32;
-
-	while (p + 4 <= b_end) {
-		h32 += get_unaligned_le32(p) * PRIME32_3;
-		h32 = xxh_rotl32(h32, 17) * PRIME32_4;
-		p += 4;
-	}
-
-	while (p < b_end) {
-		h32 += (*p) * PRIME32_5;
-		h32 = xxh_rotl32(h32, 11) * PRIME32_1;
-		p++;
-	}
-
-	h32 ^= h32 >> 15;
-	h32 *= PRIME32_2;
-	h32 ^= h32 >> 13;
-	h32 *= PRIME32_3;
-	h32 ^= h32 >> 16;
-
-	return h32;
-}
-EXPORT_SYMBOL(xxh32_digest);
-
 int xxh64_update(struct xxh64_state *state, const void *input, const size_t len)
 {
 	const uint8_t *p = (const uint8_t *)input;
-- 
2.50.1


