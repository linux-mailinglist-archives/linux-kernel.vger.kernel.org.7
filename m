Return-Path: <linux-kernel+bounces-803120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0ECB45AC1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534FE5C3DD2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1BC371EBC;
	Fri,  5 Sep 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Am9H/0j9"
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD0371EA8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083338; cv=none; b=autNDgH/RFV2rWKr3+QgiW4syM4vAtmDGurErQMKKyrFHOUY5SDt+FJdZ4FRPQwb+RwU6G7sazpQzbYlNy2bbOic6/JgaJO5DjclIH0IBcNLquuWuG2wWi4qwz/SbSYsKaZ0Qt+Ag/HjBGXUNgLjtXvsVgYSZEdZlnJ/PIQFvuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083338; c=relaxed/simple;
	bh=upjWqo1zN2SS4FfXHtkOYB/GOK7MiGnIzTXPrRoytcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IYAoxRc4j/OsZNbE6jaBLEDaHROuF2Tj98MIdfVOZHhpasGHY/83qFt3Twg8iGLgNGd0CAnN94nhfPsbU67wUlz4BBej5p7T86A+nA4SvbtOnr24j6E0clWEEJY6QLucBzTQXykN9Qq4mYfTMGzpB8qdD0iz33Vj/mY76weDUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=Am9H/0j9; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 3AF218139F;
	Fri, 05 Sep 2025 17:42:12 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:181::1:23])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 1gjcva4GjSw0-Uzg0XKco;
	Fri, 05 Sep 2025 17:42:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1757083331;
	bh=lHpdoNmMYSLI/LWDNLk2O4x8pqbNv0hrQ59269PvLxE=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Am9H/0j9M1ctTI+afVAdVxSlMDM1erNnheAhenaexH6v+E7CsWmkYb9W5GNkPOyx5
	 xYPYoG4wzt1w8Q/nI1U+CsMPSRsOa9lgBz8JiQ7RUboXDEavPuCzsjrJRvMHzYdjg4
	 80n9Bx+jCT5sdh/kW/gyr7GofnkTRk/RFK26dybw=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Petr Mladek <pmladek@suse.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 1/2] printk_ringbuffer: don't needlessly wrap data blocks around
Date: Fri,  5 Sep 2025 17:41:51 +0300
Message-Id: <20250905144152.9137-2-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
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
 kernel/printk/printk_ringbuffer.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d9fb053cff67..99989a9ce4b4 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1002,6 +1002,17 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 	return true;
 }
 
+static bool is_blk_wrapped(struct prb_data_ring *data_ring,
+			    unsigned long begin_lpos, unsigned long next_lpos)
+{
+	/*
+	 * Subtract one from next_lpos since it's not actually part of this data
+	 * block. This allows perfectly fitting records to not wrap.
+	 */
+	return DATA_WRAPS(data_ring, begin_lpos) !=
+	       DATA_WRAPS(data_ring, next_lpos - 1);
+}
+
 /* Determine the end of a data block. */
 static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
 				   unsigned long lpos, unsigned int size)
@@ -1013,7 +1024,7 @@ static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
 	next_lpos = lpos + size;
 
 	/* First check if the data block does not wrap. */
-	if (DATA_WRAPS(data_ring, begin_lpos) == DATA_WRAPS(data_ring, next_lpos))
+	if (!is_blk_wrapped(data_ring, begin_lpos, next_lpos))
 		return next_lpos;
 
 	/* Wrapping data blocks store their data at the beginning. */
@@ -1081,7 +1092,7 @@ static char *data_alloc(struct printk_ringbuffer *rb, unsigned int size,
 	blk = to_block(data_ring, begin_lpos);
 	blk->id = id; /* LMM(data_alloc:B) */
 
-	if (DATA_WRAPS(data_ring, begin_lpos) != DATA_WRAPS(data_ring, next_lpos)) {
+	if (is_blk_wrapped(data_ring, begin_lpos, next_lpos)) {
 		/* Wrapping data blocks store their data at the beginning. */
 		blk = to_block(data_ring, 0);
 
@@ -1125,7 +1136,7 @@ static char *data_realloc(struct printk_ringbuffer *rb, unsigned int size,
 		return NULL;
 
 	/* Keep track if @blk_lpos was a wrapping data block. */
-	wrapped = (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, blk_lpos->next));
+	wrapped = is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next);
 
 	size = to_blk_size(size);
 
@@ -1151,7 +1162,7 @@ static char *data_realloc(struct printk_ringbuffer *rb, unsigned int size,
 
 	blk = to_block(data_ring, blk_lpos->begin);
 
-	if (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, next_lpos)) {
+	if (is_blk_wrapped(data_ring, blk_lpos->begin, next_lpos)) {
 		struct prb_data_block *old_blk = blk;
 
 		/* Wrapping data blocks store their data at the beginning. */
@@ -1187,7 +1198,7 @@ static unsigned int space_used(struct prb_data_ring *data_ring,
 	if (BLK_DATALESS(blk_lpos))
 		return 0;
 
-	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next)) {
+	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next)) {
 		/* Data block does not wrap. */
 		return (DATA_INDEX(data_ring, blk_lpos->next) -
 			DATA_INDEX(data_ring, blk_lpos->begin));
@@ -1234,14 +1245,14 @@ static const char *get_data(struct prb_data_ring *data_ring,
 	}
 
 	/* Regular data block: @begin less than @next and in same wrap. */
-	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
+	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
 	    blk_lpos->begin < blk_lpos->next) {
 		db = to_block(data_ring, blk_lpos->begin);
 		*data_size = blk_lpos->next - blk_lpos->begin;
 
 	/* Wrapping data block: @begin is one wrap behind @next. */
-	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
-		   DATA_WRAPS(data_ring, blk_lpos->next)) {
+	} else if (!is_blk_wrapped(data_ring,
+		   blk_lpos->begin + DATA_SIZE(data_ring), blk_lpos->next)) {
 		db = to_block(data_ring, 0);
 		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
 
-- 
2.43.0


