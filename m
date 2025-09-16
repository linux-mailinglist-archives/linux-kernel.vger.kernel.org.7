Return-Path: <linux-kernel+bounces-818615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CB6B59403
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D96E1B24889
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2F22C029D;
	Tue, 16 Sep 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCAMiWD5"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672CE7081E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019583; cv=none; b=OhKURfxt2PPCHvx1eQUJ3FVRejA84fNmr306kyXVecEGMdq7POgc5OpPfRbirv7Bl+IsqldUrs7IDUIcEg8oJInHVKZA1EQaR70TEovIySH1a2utozBqWRLUf+UXYAWf9h2WZaZxoIk5T0G6J6wG8BgoY8td3y7mMjaBYpBYXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019583; c=relaxed/simple;
	bh=6mcsjg4mpO7vTJmNBL+xKZEXfWJ+PXy1vWl3m3v7CM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0xYOPxmcSoT0+425jq8TJ6bafXLMius7zj/ZKnJeZnTMKYute9BQNUvnj0lcerfWb+7spjyGDirzMv/uwIidfU6KF6hgVyXmmj6z+Zkf4uh2tB1VQsDvivV158/q1DXR2oDoOQle60zzBYewBI+NA+dvqQFwC5WHyAgerY67ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCAMiWD5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so14445685e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758019580; x=1758624380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EdigPIMX6NPHC4cwORQzphly7TiWe8t44OOW+EEUbE=;
        b=gCAMiWD5ze16gMImlXrdxpm0tgQ/svAv7yoE/gJaJ0JpqSSviYIvcKJDME7FuYXIAa
         qR64S4+f9w/FVSEzcnTiDYxMKGEhr68KgsG0xdsDPCbVt3TZS5YjGVcCUeFiAwEY2o2H
         dOOafJsftPGu9y7DRBNRsyg330HBkHrSW6M00B9H/YsOe/y3RIbzxY+/bZcCOcZuTfHd
         6yb0zzSJ+OpJDf1hN2aDN0B71B3lsxtfLQDQ7oBeH3PUGfoXD8tZNAK9Iz9woW/WPzh7
         yjTfZxHuC9c0imCS5WX7apRZ1sKaD0KBpceFTlf7y5eEGk6jqFQvHbjZBuwxuRCxfmJk
         Y9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019580; x=1758624380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EdigPIMX6NPHC4cwORQzphly7TiWe8t44OOW+EEUbE=;
        b=bYkgpB/c8PcobrcUezf2kvJxu9VRJQNmpgDbNJyczABpqe2la457QxiYL4tO8RfYhn
         1AOvp6OiFoLh//bHU11Jpjd3X+qPLjEtyudhRA9PehtBUfXe8F1Tw4XDcG+Rdb8VtcdO
         QRMlUIF0gR447RkBYrO8fxra44JoGqlVoNSQfic4ScWm272Hr05bnAI5/Nm/ANzTNgWA
         xKWIUuUMZkyFeZYpPCqtsjieA9q8OxKQZQs547vdoorjP+Y7H4BL4xr1rKTSuVtUlfLV
         lxzaL7oosdwAbHIOAqYRWFKz4sobtfTPfTYVYNJ8lSTJxgKJK82RqZYFTbHJhhic+XwR
         LdCA==
X-Forwarded-Encrypted: i=1; AJvYcCXV3je+PRufVKXy0H23VrUbx5YLFFnFgQ7OvjG33VM7QUOSZEN250V7olD/e5jTRutNaQCFMiEbziqPx9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFdy3afEPbBLl3gwMUPxoDYkxCKiswzwU3+RV2W6WbDUZ0YaO
	VuMuT5yBARd1oCNfY4QoDkq3OvEc+hev85h2Q8aniqgDdyatOzuBvDXD
X-Gm-Gg: ASbGnct9olSA2TXIxSJkGgjGokHqej2ihpIsOaery0WdfXtw8WoWYUONZnk4yRNOmCt
	frRgzvUPSKES7WDym+Vp+XyDIQHZnXcc+pEt3d7UwhLFwHpc2QJu2vKLTbLXsCMLLlrSC0EiB5z
	a2aH0841Xe+6JdaY1qVmGXu1ax/QOTSSev1Ec3nX6rKpoNVj0mSVjw2r8F+P9fpc3qiR1+mac9+
	/zn3a0fJT4Ekx9TTXT6sfbXQE5T0LdEK5UJZUR6jsD4+zCtNEKyPkJFv6yIcOejg7ZaSjFlJ/ot
	ib4tKYnJXnaWQiQvYh7zs18enSZt2zL9KWKlmFetoDm3kRd/7XGa/GvZJ0CkOPQ1Sp76x4ORkm1
	f/s9FLmeSMvUQI2/CNcwAaC9T
X-Google-Smtp-Source: AGHT+IEwploMqHYB5eM2vvE3PR4MXORlVYqWpE9ZMhJ/ZDhY5aGxDy1NW3Rem0cCgzWHPEtu12e+OA==
X-Received: by 2002:a05:600c:4fcb:b0:45d:d099:873 with SMTP id 5b1f17b1804b1-45f2926264fmr106100155e9.6.1758019579471;
        Tue, 16 Sep 2025 03:46:19 -0700 (PDT)
Received: from gmail.com ([136.226.167.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45edd9f75d1sm195147265e9.17.2025.09.16.03.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:46:19 -0700 (PDT)
From: hariconscious@gmail.com
To: shuah@kernel.org,
	syzbot+c3dbc239259940ededba@syzkaller.appspotmail.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH] sound/core/seq : fix data-race in snd_seq_fifo_cell_out/snd_seq_fifo_poll_wait
Date: Tue, 16 Sep 2025 16:15:48 +0530
Message-ID: <20250916104547.27599-2-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

data race in both the functions, snd_seq_fifo_cell_out &
snd_seq_fifo_poll_wait is protected with guards

Reported-by: syzbot+c3dbc239259940ededba@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=c3dbc239259940ededba
Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---
 sound/core/seq/seq_fifo.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/core/seq/seq_fifo.c b/sound/core/seq/seq_fifo.c
index f23c6b7ae240..65e28ebb0eb1 100644
--- a/sound/core/seq/seq_fifo.c
+++ b/sound/core/seq/seq_fifo.c
@@ -138,16 +138,18 @@ static struct snd_seq_event_cell *fifo_cell_out(struct snd_seq_fifo *f)
 {
 	struct snd_seq_event_cell *cell;
 
-	cell = f->head;
-	if (cell) {
-		f->head = cell->next;
+	scoped_guard(spinlock_irqsave, &f->lock) {
+		cell = f->head;
+		if (cell) {
+			f->head = cell->next;
 
-		/* reset tail if this was the last element */
-		if (f->tail == cell)
-			f->tail = NULL;
+			/* reset tail if this was the last element */
+			if (f->tail == cell)
+				f->tail = NULL;
 
-		cell->next = NULL;
-		f->cells--;
+			cell->next = NULL;
+			f->cells--;
+		}
 	}
 
 	return cell;
@@ -210,7 +212,9 @@ int snd_seq_fifo_poll_wait(struct snd_seq_fifo *f, struct file *file,
 			   poll_table *wait)
 {
 	poll_wait(file, &f->input_sleep, wait);
-	return (f->cells > 0);
+	guard(spinlock_irqsave)(&f->lock);
+	int isNonzero = (f->cells > 0);
+	return isNonzero;
 }
 
 /* change the size of pool; all old events are removed */
-- 
2.43.0


