Return-Path: <linux-kernel+bounces-797494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066D6B41117
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949297B5737
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6C03C01;
	Wed,  3 Sep 2025 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="VZhxHlt/"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21328F4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857804; cv=none; b=uQDbU3Z5QtjED06LEltpNZBusICogzu3S0NqtV6Og0L+Q1n2p+7fUevK/mXOlCSTS7uUG8yjJBK8q8nk7B0jBnf4XPe3hSM9mYLfISbKh7+EaXYCihkY2RMuiQgWA2sDHQVzNrWZS636Ch7hOFsMQlEqjezUJjHvvYj9G4EwVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857804; c=relaxed/simple;
	bh=Ev/LFsIiKjcWSf5/uIWsoyRRfDo4cA2N34Q7h9i8brE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oL6qT9jrgtCeyneXxR2+lYvmL61PzYPwaUd8NxQwELAeO4eQsUppuxpj4vl1YodqljODUCwyntjAQoUEbtM6PEBZIass14VHdR3oeQYz1oM0C6dV3rvZrkV3gDnna2YA3nXAuW4vaLxRrgqMeXFkkhy9oivGRIMxKQiHKqtIfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=VZhxHlt/; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 30913C00BB;
	Wed, 03 Sep 2025 03:01:29 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:a32::1:3a])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id H1TLoN3GnGk0-HbMySUgR;
	Wed, 03 Sep 2025 03:01:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1756857688;
	bh=1EoLTpc1aQVudCxr4NP5QmG79jqnIFauOSCGf/8PzCM=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=VZhxHlt/RtE8q9Nx5C6QCKyHlMdNbYWEFnE57oUqDoT+kvbZW81yrd1W4juYRBZ3e
	 BOCDJy1FKXnaNm5GLsvyiJijHuz8F14FRfXxSih2a69Y7U9MCKYcigP4QnN9hWUP7l
	 s2THWtc0rCq2UW49xcySwGzJssIO9DVsXY3PAgLg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Petr Mladek <pmladek@suse.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] printk_ringbuffer: don't needlessly wrap data blocks around
Date: Wed,  3 Sep 2025 03:01:02 +0300
Message-Id: <20250903000102.3744-1-d-tatianin@yandex-team.ru>
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
 kernel/printk/printk_ringbuffer.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d9fb053cff67..1ae4e93024ad 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1002,6 +1002,18 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 	return true;
 }
 
+static bool same_lpos_wraps(struct prb_data_ring *data_ring,
+						unsigned long begin_lpos, unsigned long next_lpos)
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
-	    blk_lpos->begin < blk_lpos->next) {
+	if (same_lpos_wraps(data_ring, blk_lpos->begin, blk_lpos->next) &&
+			    blk_lpos->begin < blk_lpos->next) {
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


