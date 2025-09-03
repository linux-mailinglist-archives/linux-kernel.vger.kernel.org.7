Return-Path: <linux-kernel+bounces-797502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CFEB41138
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C9E3A19FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5231758B;
	Wed,  3 Sep 2025 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="xzDMQhK4"
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AB020EB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756858364; cv=none; b=eHMEl1ybvC50qelWWayVpA3K5UgJuXZSAO+IvI+SHjvMrWAFPQAidkx4GpHRUXx9+q7/rAV2BR05TuikRsnx+u3Sg4iOILZUl5/Jf4Gkl4EXo9NDsHTe701LY3zqAf1xewdCGq3Zif1ofqklmbH/rQPO37o6B/VTp6BJtG6JEXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756858364; c=relaxed/simple;
	bh=6eKs7pmWNHMZ+YBD6rjS0V+lA2DSjUe0r+S51YJx6gg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CuIs4/ma/0i69lHUGUVuJOndGyrzA9ZIJOdfbNvKCqLdm3DsdW8zH775fsgmluQtEFwQl/l08YjOAYN2XGauRVXx3MECz0nCIUaXwPoIi9Vt9AVSj5Qu7WVesNLYLZlLPQ5sOyUj4T6ydxQFRmojg1W2slKd3aGtepKJM7YpFsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=xzDMQhK4; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id EFBEC80466;
	Wed, 03 Sep 2025 03:10:20 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:17c::1:11])
	by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id CATs4K3FkCg0-xuU5ae4O;
	Wed, 03 Sep 2025 03:10:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1756858220;
	bh=4qNB3bM4lAGMMbxsC4WocSpusKzhhwjzpuaa3Pe6mtk=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=xzDMQhK49WWjOWTcRp/XfEAtJn5H5G1F3+3TFFODjpgRaCWq64Idm7BnuMMVc98Bc
	 GIRPkfdkfmlqI5b+oTlzsADuhNUwaLXPgLGSwADBnhXJJzG2UXcYkJ9/+bWvLQ6QN9
	 p4l+kIPPYUfVU7pW99RXCTRY6ydI59FOrqVPoaqg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Petr Mladek <pmladek@suse.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v1] printk_ringbuffer: don't needlessly wrap data blocks around
Date: Wed,  3 Sep 2025 03:10:08 +0300
Message-Id: <20250903001008.6720-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, data blocks that perfectly fit the data ring buffer would
get wrapped around to the beginning for no reason since the calculated
offset of the next data block would belong to the next wrap. Since this
offset is not actually part of the data block, but rather the offset of
where the next data block is going to start, there is no reason to
include it when deciding whether the current block fits the buffer.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---

v0->v1:
- Fix severely broken code alignment

---
 kernel/printk/printk_ringbuffer.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d9fb053cff67..f885ba8be5e6 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1002,6 +1002,18 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 	return true;
 }
 
+static bool same_lpos_wraps(struct prb_data_ring *data_ring,
+			     unsigned long begin_lpos, unsigned long next_lpos)
+{
+	/*
+	 * Subtract one from next_lpos since it's not actually part of this data
+	 * block. We do this to prevent perfectly fitting records from wrapping
+	 * around for no reason.
+	 */
+	return DATA_WRAPS(data_ring, begin_lpos) ==
+	       DATA_WRAPS(data_ring, next_lpos - 1);
+}
+
 /* Determine the end of a data block. */
 static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
 				   unsigned long lpos, unsigned int size)
@@ -1013,7 +1025,7 @@ static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
 	next_lpos = lpos + size;
 
 	/* First check if the data block does not wrap. */
-	if (DATA_WRAPS(data_ring, begin_lpos) == DATA_WRAPS(data_ring, next_lpos))
+	if (same_lpos_wraps(data_ring, begin_lpos, next_lpos))
 		return next_lpos;
 
 	/* Wrapping data blocks store their data at the beginning. */
@@ -1081,7 +1093,7 @@ static char *data_alloc(struct printk_ringbuffer *rb, unsigned int size,
 	blk = to_block(data_ring, begin_lpos);
 	blk->id = id; /* LMM(data_alloc:B) */
 
-	if (DATA_WRAPS(data_ring, begin_lpos) != DATA_WRAPS(data_ring, next_lpos)) {
+	if (!same_lpos_wraps(data_ring, begin_lpos, next_lpos)) {
 		/* Wrapping data blocks store their data at the beginning. */
 		blk = to_block(data_ring, 0);
 
@@ -1125,7 +1137,7 @@ static char *data_realloc(struct printk_ringbuffer *rb, unsigned int size,
 		return NULL;
 
 	/* Keep track if @blk_lpos was a wrapping data block. */
-	wrapped = (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, blk_lpos->next));
+	wrapped = !same_lpos_wraps(data_ring, blk_lpos->begin, blk_lpos->next);
 
 	size = to_blk_size(size);
 
@@ -1151,7 +1163,7 @@ static char *data_realloc(struct printk_ringbuffer *rb, unsigned int size,
 
 	blk = to_block(data_ring, blk_lpos->begin);
 
-	if (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, next_lpos)) {
+	if (!same_lpos_wraps(data_ring, blk_lpos->begin, next_lpos)) {
 		struct prb_data_block *old_blk = blk;
 
 		/* Wrapping data blocks store their data at the beginning. */
@@ -1187,7 +1199,7 @@ static unsigned int space_used(struct prb_data_ring *data_ring,
 	if (BLK_DATALESS(blk_lpos))
 		return 0;
 
-	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next)) {
+	if (same_lpos_wraps(data_ring, blk_lpos->begin, blk_lpos->next)) {
 		/* Data block does not wrap. */
 		return (DATA_INDEX(data_ring, blk_lpos->next) -
 			DATA_INDEX(data_ring, blk_lpos->begin));
@@ -1234,14 +1246,14 @@ static const char *get_data(struct prb_data_ring *data_ring,
 	}
 
 	/* Regular data block: @begin less than @next and in same wrap. */
-	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
+	if (same_lpos_wraps(data_ring, blk_lpos->begin, blk_lpos->next) &&
 	    blk_lpos->begin < blk_lpos->next) {
 		db = to_block(data_ring, blk_lpos->begin);
 		*data_size = blk_lpos->next - blk_lpos->begin;
 
 	/* Wrapping data block: @begin is one wrap behind @next. */
-	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
-		   DATA_WRAPS(data_ring, blk_lpos->next)) {
+	} else if (same_lpos_wraps(data_ring,
+		   blk_lpos->begin + DATA_SIZE(data_ring), blk_lpos->next)) {
 		db = to_block(data_ring, 0);
 		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
 
-- 
2.43.0


