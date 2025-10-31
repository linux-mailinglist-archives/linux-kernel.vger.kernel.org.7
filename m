Return-Path: <linux-kernel+bounces-880056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D24C24C46
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166341A67DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3243451A8;
	Fri, 31 Oct 2025 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S5hIfB5s"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031491E9919
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909789; cv=none; b=Eo67D2MkS72eWhqdD5D+mwEDGMLXOsaCyEi+9Zeio+AUyOvdp38HFuPKDP+j93L1iOaY7B0/A/bZgApgYnEm7FS6NLAm8tM5kGK24L7STQwodnxzu08NoC9jmq7jOCl9ygCSeQcH43vLCLpdGVnmJxbc8CNsprNVxKbN5CZQ6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909789; c=relaxed/simple;
	bh=BT8okCA8eZEgOFX0SczxxGmDYshaWqQ7hCqmcwWlNak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIHzOF197w58Zc8EnXthSmqyUhQVspCQj9gInvzrVw2NldM9pqW+3hoWJDiMjfXBF4dHC7iiW6WVHGTyFA7r5fmZhSnY68G6F9zheNYXPl9Twew5RX7bIQdQz9Lavw42W66D7FtJYlWLmyW/GbIBvSPsRl/uKOj021+f5Rewey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S5hIfB5s; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so17040295e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761909785; x=1762514585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V0xMu5Ua6JY9tynLrWU4a3rWJNSe8oVSDMvD70HfAAI=;
        b=S5hIfB5s+JWxIV02x9KxN17ajwluZnOoG5FRW4kPagLK9CiKY19fR1lkqyMHzPso9R
         t+/VayfN6PZOrp2zQIhpUYkCq0n+HebUb/XFf3dKbXQ3OP49ResgLIkoaU6tVWOtz7iE
         OCvrIDj1ws9mPRfsR8w5oHZ+w6UYbaAp9pn+YT2OxgRzufYBhLX/+uJEMTNNq1zVEL7t
         6G0bVPjVvi/qBuCn/nieKs9NVZq9PCcj02qCb0T/ikgnbmzSo6oAqbtEU6BI8sx1OOQv
         V4IOW+1/s2EhBwczh2WasI+yN+DMJMNz5wTq+NszzBRVvvlfzycZ/PrlTwMXPwFcg8OT
         Wy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909785; x=1762514585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0xMu5Ua6JY9tynLrWU4a3rWJNSe8oVSDMvD70HfAAI=;
        b=MRGFfefEkhKX+DuMM/eOPEip0/zo9nWTZYd2J0ZHgmiiM1kb/3B+N7ZtxWDO53IaCI
         5zrgHBv1aPmeAGuQRfF2qB0sTvmHofq5/kUQbDbFzAdqHIkZLLtTcZks0fdHx1snaWTG
         3/DLBZ2Es0yT2phhZVA/yWBbKro7gzpwFuCyNGjiXTy200TvnhSuLWsLz0SIN3polKjn
         MurgbiONDXC97fzt7+NOsqBG5Q9dLcgqKXp0xf4eGiEjAVmwaY5AGJ4EPzDIwT8cMqyy
         ZGevp83fzdX8RbLyYBn7qe1flyj2mGnkwtl/lAmHoyHmd2OKBPI8ITZ8Sw12oEaHQbX+
         ayuQ==
X-Gm-Message-State: AOJu0YzAR5rfHPOqR7EfbOC2ghIwagAHINVu7/Q27RQogQltyFfpPnfO
	HubCcMlvtiDqvW8wBFmoKHA1DdKuW2el3HuBTw+T5uxYzBXWm1WrXr5tbSH/Y3FDGGUUsAIyJ2z
	WRpWn
X-Gm-Gg: ASbGncsd8rjKozE1prt9RLllPx3M/otb8YEudkHsZDse6Llrc4YOxZW+/R8zNL1pljB
	f9YPu+nGdQrXsvnvXm74tADJhVyDkINdDowCTT50GdtmMK71QQ04R6iq4tlWlsfVMXn86OGhF+X
	rPpJhLW0h7i6eg+M9dbul+vktDaCgo8jps6TyDUJixldv0oVH2cybGvuKHVBfjI7clLaQKuZw6C
	d8/LsXSzJHna/UIZUdFloMVd6r93sI3a6IJOMLGKfuYjAGI/P3udmQeRq6Y4Ry6cX7Rgpp/Y566
	ECKbEaKnyXJnsnhgu6n6ypRFH2tywG9bhPyYfaPuJtXn+1pqKrtAXjmxvMXHKN9Nqy8OTpy6sIe
	3G4e8Kq949WunCDqQFbBjTHaB4IuOW8gK23g0FNgaKniboYWYD4B68b5Qg6UGvtWSZFniVX1jeG
	nkiQ4XT/6fc2ZT5nsnOZGruBtD
X-Google-Smtp-Source: AGHT+IH8IpAvQq5pUwzK1vwfIRUxicibFTP05YUKImMjbAHpOVXsVVERZU8YxomZ/j6mb0BGr3IQPg==
X-Received: by 2002:a05:600c:524f:b0:475:dc98:4489 with SMTP id 5b1f17b1804b1-477308be79dmr27679575e9.33.1761909784890;
        Fri, 31 Oct 2025 04:23:04 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728ab375asm89060275e9.17.2025.10.31.04.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:23:04 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	timestamp@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH] hte: replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 31 Oct 2025 12:22:56 +0100
Message-ID: <20251031112256.149436-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/hte/hte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
index 23a6eeb8c506..e2804636f2bd 100644
--- a/drivers/hte/hte.c
+++ b/drivers/hte/hte.c
@@ -826,7 +826,7 @@ int hte_push_ts_ns(const struct hte_chip *chip, u32 xlated_id,
 
 	ret = ei->cb(data, ei->cl_data);
 	if (ret == HTE_RUN_SECOND_CB && ei->tcb) {
-		queue_work(system_unbound_wq, &ei->cb_work);
+		queue_work(system_dfl_wq, &ei->cb_work);
 		set_bit(HTE_TS_QUEUE_WK, &ei->flags);
 	}
 
-- 
2.51.0


