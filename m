Return-Path: <linux-kernel+bounces-833415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B909BA1E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46503B8FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D72EA475;
	Thu, 25 Sep 2025 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ez1ywjj4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bka1SvHn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C56291C13
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840604; cv=none; b=Y/6B5GRb132Yk4lcJunuSLklzU6cTpehCfemSENa3Wn+JxJQF6IDHpbQTgD4r7JXNdodoZDeHu8+eNYFVv8k2tCxxmgo5VZ4UPjBnTfsBtCwtZqBPCTVZ7MbPT2ILKmtnHF9yEx0jIjb47ltvViqQcW7UA+dhzE+q9DMZc1E9bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840604; c=relaxed/simple;
	bh=A3CHGbHPJBdh22yvJWDOTmn69+OQF87+HwGNWzLO6Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lGBE2WDkk1PlcO4XrVZb0WJIqu8NSHmE/j2PMUfBHCJATCONVEHQiJFtpB0OlGOv9FWc1nnvyONuGMEfaz3KS+c9LnH8IrQMUjzOmqUtrT2q6wVx4hwFw9jT1BFbZdoRm7Gi7M43YkaCBFtb3fg8+pckK90ZOlHyWyhuix/GaE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ez1ywjj4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bka1SvHn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758840599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VO0sjrvN1UeOT0WTQK5AU3LX8rTg4W0iKo3neg2tdcU=;
	b=Ez1ywjj47xHuAwZxpHLRhreyCFVSH5QPpn9BsY/yStLHZ9Lcg0116SgDkILTkNnFB/hUL/
	8wb241xysJ31FFc/2MNJU897HHPPZQbL7gEKIZ70b89Lq59aPpInmV4pYg8ffplr8C/eyo
	6y2uL3TUKZw8rXK5XpL6Q90jQySIJiDOj/qb2UhcIKkKrGB7qk0AZlmqY01vMnYD4D8bq1
	UZY31KxO25aryL8+PFexmdOvbhi/Qfy/+8luGPZxshl513gKiC7Lc+5tqKYiHmsoOfQ9HO
	ZEKicrwEc4SWFaVPX38MduArOIj5Fpvm6OOtvRf7dHu2Zgi4YNszuAT0p/2aLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758840599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VO0sjrvN1UeOT0WTQK5AU3LX8rTg4W0iKo3neg2tdcU=;
	b=Bka1SvHnGGMHHPR3/V5ejc7g9TTYN1bTTJiT/ZISpzm5NKezU8ZgeLHQK0Vz5TY9wPBkia
	Gni8GMd2I+Jn9FAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v1] printk: ringbuffer: Fix data block max size check
Date: Fri, 26 Sep 2025 00:55:59 +0206
Message-Id: <20250925224959.757266-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently data_check_size() limits data blocks to a maximum size of
the full buffer minus an ID (long integer):

    max_size <= DATA_SIZE(data_ring) - sizeof(long)

However, this is not an appropriate limit due to the nature of
wrapping data blocks. For example, if a data block is larger than
half the buffer:

    size = (DATA_SIZE(data_ring) / 2) + 8

and begins exactly in the middle of the buffer, then:

    - the data block will wrap
    - the ID will be stored at exactly half of the buffer
    - the record data begins at the beginning of the buffer
    - the record data ends 8 bytes _past_ exactly half of the buffer

The record overwrites itself, i.e. needs more space than the full
buffer!

Luckily printk() is not vulnerable to this problem because
truncate_msg() limits printk-messages to 1/4 of the ringbuffer.
Indeed, by adjusting the printk_ringbuffer KUnit test, which does not
use printk() and its truncate_msg() check, it is easy to see that the
ringbuffer becomes corrupted for records larger than half the buffer
size.

The corruption occurs because data_push_tail() expects it will never
be requested to push the tail beyond the head.

Avoid this problem by adjusting data_check_size() to limit record
sizes to half the buffer size. Also add WARN_ON_ONCE() before
relevant data_push_tail() calls to validate that there are no such
illegal requests. WARN_ON_ONCE() is used, rather than just adding
extra checks to data_push_tail() because it is considered a bug to
attempt such illegal actions.

Link: https://lore.kernel.org/lkml/aMLrGCQSyC8odlFZ@pathway.suse.cz
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 43 +++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index bc811de18316b..7d50c65e86234 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -394,25 +394,21 @@ static unsigned int to_blk_size(unsigned int size)
  * Sanity checker for reserve size. The ringbuffer code assumes that a data
  * block does not exceed the maximum possible size that could fit within the
  * ringbuffer. This function provides that basic size check so that the
- * assumption is safe.
+ * assumption is safe. In particular, it guarantees that data_push_tail() will
+ * never attempt to push the tail beyond the head.
  */
 static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
 {
-	struct prb_data_block *db = NULL;
-
+	/* Data-less blocks take no space. */
 	if (size == 0)
 		return true;
 
 	/*
-	 * Ensure the alignment padded size could possibly fit in the data
-	 * array. The largest possible data block must still leave room for
-	 * at least the ID of the next block.
+	 * If data blocks were allowed to be larger than half the data ring
+	 * size, a wrapping data block could require more space than the full
+	 * ringbuffer.
 	 */
-	size = to_blk_size(size);
-	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
-		return false;
-
-	return true;
+	return to_blk_size(size) <= DATA_SIZE(data_ring) / 2;
 }
 
 /* Query the state of a descriptor. */
@@ -1052,8 +1048,17 @@ static char *data_alloc(struct printk_ringbuffer *rb, unsigned int size,
 	do {
 		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
 
-		if (!data_push_tail(rb, next_lpos - DATA_SIZE(data_ring))) {
-			/* Failed to allocate, specify a data-less block. */
+		/*
+		 * data_check_size() prevents data block allocation that could
+		 * cause illegal ringbuffer states. But double check that the
+		 * used space will not be bigger than the ring buffer. Wrapped
+		 * messages need to reserve more space, see get_next_lpos().
+		 *
+		 * Specify a data-less block when the check or the allocation
+		 * fails.
+		 */
+		if (WARN_ON_ONCE(next_lpos - begin_lpos > DATA_SIZE(data_ring)) ||
+		    !data_push_tail(rb, next_lpos - DATA_SIZE(data_ring))) {
 			blk_lpos->begin = FAILED_LPOS;
 			blk_lpos->next = FAILED_LPOS;
 			return NULL;
@@ -1141,8 +1146,18 @@ static char *data_realloc(struct printk_ringbuffer *rb, unsigned int size,
 		return &blk->data[0];
 	}
 
-	if (!data_push_tail(rb, next_lpos - DATA_SIZE(data_ring)))
+	/*
+	 * data_check_size() prevents data block reallocation that could
+	 * cause illegal ringbuffer states. But double check that the
+	 * new used space will not be bigger than the ring buffer. Wrapped
+	 * messages need to reserve more space, see get_next_lpos().
+	 *
+	 * Specify failure when the check or the allocation fails.
+	 */
+	if (WARN_ON_ONCE(next_lpos - blk_lpos->begin > DATA_SIZE(data_ring)) ||
+	    !data_push_tail(rb, next_lpos - DATA_SIZE(data_ring))) {
 		return NULL;
+	}
 
 	/* The memory barrier involvement is the same as data_alloc:A. */
 	if (!atomic_long_try_cmpxchg(&data_ring->head_lpos, &head_lpos,

base-commit: 37dbd4203b42c10b76d55471bb866900f99d6bc1
-- 
2.39.5


