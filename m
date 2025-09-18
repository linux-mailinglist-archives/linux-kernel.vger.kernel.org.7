Return-Path: <linux-kernel+bounces-817009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE631B57C52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0DC1A23870
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906CC30C379;
	Mon, 15 Sep 2025 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9KsEy/F"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC09302153
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941576; cv=none; b=ipStBlS93DiD1K1gajWLYP9hCPZ0jMNyLWCBfDY5q5ZVUAkfGoZ/2PtiMiE+HR/763QpYOFqgJpG0MzZNrYg15KmlPcv7Hne1otZ/x+94F/fSrG4ZVPuGRt56lFiEICrobtRdrOdDqFkrR2dQqgqHFbhEaEYSnE2iSD+QHlJ16g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941576; c=relaxed/simple;
	bh=xvtyOxlt0sd5V+mr1Uz3PvxlTQ7hAmIsxOoPbAbzTuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P4eW5uhlJXEoAPTLb0xkh3X3CHeeofYNSvEaJnhxiSKYYWOuSjpUiUlm8sIVUayoTE3Tnx9auiEDJ7IRsb9cPuRHUlkw5Qc3TNw2AaYw5Px5wNWOYwsC1aUueilUbbPJKOnN+azKnNzIudVAlQr+67QkSNXc+0ECXw+DHNtEQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9KsEy/F; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77616dce48cso2032731b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757941575; x=1758546375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BDcFa+cXk5N40j8gIEFqJLaKFAmqCOwEkbotvenWYbY=;
        b=S9KsEy/FlN/GvXLJC8A95Ri7QYpP0a67pwOlOfrVhKmHMckw47mdQdKGXZ84DyTliy
         kMnbHx+/mSoa35bFFqMa/A/CPR8K5Yqt6tzey+Lbrc/9SN2HOfm6zPNHvNd3N83lfVZU
         LdePnqCGkMRD/dQcs1jgGyE1hLE1XbMEInQgXc9bQEgqrO6tv7z/txJMFqqjZw5DM6pb
         tZbsdc1Pnngz5EjCowk25rnW9pz1XaWQIItDjS86EvoeY7LL4uHllizc5XzNgmg+JzWH
         m8fyE5Zg1CZQ5NMlrc6Tqw/PeAbIUHY0Anar87KI8xd7T/r4S6dm3uDeLNjtPuLIGVZA
         OJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757941575; x=1758546375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDcFa+cXk5N40j8gIEFqJLaKFAmqCOwEkbotvenWYbY=;
        b=Fz4f9McTsE/LI3p2tUyf/B+mOLBxZ0a7tJcMTKpx7WvtcUQqg8RdQ9JjYqtHpQ8h2Y
         WLI0h8Y3vXob+hOczRGRM5433nHXqDfKRh4P7ctvmch/ZwGvIzFXAvusj7Xcl64/ZnF+
         7KGAqavPPbe2p424wmf84gRe+YKYmyhkKcvQAFZZjW4NhQN2yGlgcCFwm216qtnymsVq
         fupc5x1B1KtOyM1F8YYyI6Syjnoj0bCrJLDxCRXCLE3CnmYJBWAr7+3419i6Puot4lmU
         kOSDsYkTaojyMSW8OdRdAJg/8JxBupsLbD0t1ef5T3YwPEdR2Q1BNBkwVhYGtuZV/XpF
         n7fA==
X-Forwarded-Encrypted: i=1; AJvYcCXC720WGRDxd14Ynxlpjk1gp8IoYHAoaVwaizeGNJOrKil2vA1FvbhM3wNS6rrihUHBpN0IVOpz6Iq+Ozw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUxJZ+gLYazixNM5/q9h5k/miiAzoTUIq7HYCkb8NuHjIzkwka
	3q2ymE5ZoskMWfWwBUprRvZI0YmIKXpgUr3Y9UAYBzVrEUDwG0ZA3gv3
X-Gm-Gg: ASbGncuEiADnmaz4tJai7eoNlZab0/s1JJIi8GcenizpkroNs1cbW3KcvbSFzKaIgJb
	sjiOG7M2YhgG+lG0oJpDwkFLkjKk6r2hox8VK7vCC5nDaGuiftXSGC+vnYDWh0vYOhcc4rXeY/e
	U7snp9Q2aLN7IlMQGc+G0ABSzwB67N8sg7ldg943CTk403LK2N6gZq71n89VDsHi7P9DjfiFwON
	6feJ7A+k180sjvsLE1BOXse+wUB/Qg32PZYHEfNES7+0Mo/866PiZoMBGQKG2CDFnkg+9JspuE5
	g7CSHUfxLMnYWx4VTTMXy3g9aprpM45+utJyHBw7U6c0XYJnLiKQvxPIlYVKl0wxSflSoIkGJiI
	aoJ3KnjzwF+YhO3OEDQzPIWfbCv0W3O7n72ptXlPvv9I6P6RHwMJXnSnO65o=
X-Google-Smtp-Source: AGHT+IEgPnJcnHP3rgj4/s7O4zA02USZLvX4VYAf4gtyDIGF/KoF1y/PyB3PZ5opq/mq4KZzbBRenw==
X-Received: by 2002:a05:6a00:3a1c:b0:776:214f:2021 with SMTP id d2e1a72fcca58-776214f2858mr9475735b3a.31.1757941574392;
        Mon, 15 Sep 2025 06:06:14 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77613e4308csm10451133b3a.73.2025.09.15.06.06.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Sep 2025 06:06:14 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH RESEND] block/mq-deadline: Replace DD_PRIO_MAX with DD_PRIO_COUNT
Date: Mon, 15 Sep 2025 21:06:06 +0800
Message-Id: <20250915130606.97949-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chengkaitao <chengkaitao@kylinos.cn>

Remove redundant DD_PRIO_MAX and enum types, Move DD_PRIO_COUNT
into enum dd_prio{}, and similarly for DD_DIR_COUNT.

Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>
---
 block/mq-deadline.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b9b7cdf1d3c9..f1facbdf85c1 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -41,19 +41,17 @@ static const int fifo_batch = 16;       /* # of sequential requests treated as o
 enum dd_data_dir {
 	DD_READ		= READ,
 	DD_WRITE	= WRITE,
+	DD_DIR_COUNT	= 2
 };
 
-enum { DD_DIR_COUNT = 2 };
-
+/* Ensure that "DD_RT_PRIO < DD_BE_PRIO < DD_IDLE_PRIO" */
 enum dd_prio {
-	DD_RT_PRIO	= 0,
-	DD_BE_PRIO	= 1,
-	DD_IDLE_PRIO	= 2,
-	DD_PRIO_MAX	= 2,
+	DD_RT_PRIO,
+	DD_BE_PRIO,
+	DD_IDLE_PRIO,
+	DD_PRIO_COUNT
 };
 
-enum { DD_PRIO_COUNT = 3 };
-
 /*
  * I/O statistics per I/O priority. It is fine if these counters overflow.
  * What matters is that these counters are at least as wide as
@@ -441,7 +439,7 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
 	if (prio_cnt < 2)
 		return NULL;
 
-	for (prio = DD_BE_PRIO; prio <= DD_PRIO_MAX; prio++) {
+	for (prio = DD_BE_PRIO; prio < DD_PRIO_COUNT; prio++) {
 		rq = __dd_dispatch_request(dd, &dd->per_prio[prio],
 					   now - dd->prio_aging_expire);
 		if (rq)
@@ -475,7 +473,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	 * Next, dispatch requests in priority order. Ignore lower priority
 	 * requests if any higher priority requests are pending.
 	 */
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+	for (prio = 0; prio < DD_PRIO_COUNT; prio++) {
 		rq = __dd_dispatch_request(dd, &dd->per_prio[prio], now);
 		if (rq || dd_queued(dd, prio))
 			break;
@@ -530,7 +528,7 @@ static void dd_exit_sched(struct elevator_queue *e)
 	struct deadline_data *dd = e->elevator_data;
 	enum dd_prio prio;
 
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+	for (prio = 0; prio < DD_PRIO_COUNT; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 		const struct io_stats_per_prio *stats = &per_prio->stats;
 		uint32_t queued;
@@ -565,7 +563,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 
 	eq->elevator_data = dd;
 
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+	for (prio = 0; prio < DD_PRIO_COUNT; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
 		INIT_LIST_HEAD(&per_prio->dispatch);
@@ -748,7 +746,7 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
 	enum dd_prio prio;
 
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++)
+	for (prio = 0; prio < DD_PRIO_COUNT; prio++)
 		if (dd_has_work_for_prio(&dd->per_prio[prio]))
 			return true;
 
-- 
2.39.5 (Apple Git-154)


