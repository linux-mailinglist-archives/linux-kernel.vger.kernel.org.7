Return-Path: <linux-kernel+bounces-886651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DF6C36350
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC47E623EFB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8120D32E68F;
	Wed,  5 Nov 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mikref44"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7332C237C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354259; cv=none; b=BKjkmQ9+kMBS/+grLADjIJnK1ASzNbpv/6cetI2Zt2o01TcNYILqiIKrzwpEIB1lMJaH/qXjaQFU0rDpjrmk+FUFzPoYqjHfLYqcyNIOAO1YCe/08ca+fOWNESQwgtmTkCMruMa5g48B5BBLXU3fr+joOqJr3APYemdARJPgl9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354259; c=relaxed/simple;
	bh=ewgCy57GvvNL/4ckT/tDm1bzqS9HtAnggSwRh9X34wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isskDDNq1oUEw83nOPuqvzzJeoBWciQXaZhn1dWEQzx8+uJ3q2c1J1/P0fl/xbheFTmgTdTvxf1cLl7eDkjst1BR57bSf8JmRQ68Gc8YKYPvtw6hDU97TtvAKthWRQXYiQh02pLZR3D9E9yl9HmMYfzPn2ay8q5qzKZ4oK4nrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mikref44; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429bcddad32so4290544f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762354256; x=1762959056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSAtykixYoDc8mDqE0NZFVUWNpp9tkRehnUBmieVPhM=;
        b=Mikref44xLhnzAoTkV32Y1KJQ1UqjarEHeCQKpsFG34Duij+eNf/0WNEl0cFHXTGyD
         T+mjaKBToX1BCCL9StF1srwbtDyIcpVAhNJ/HBEQJDmI5FGRj+2pFQkVTMGiAQlG09eu
         pGnyGUHfu6b3hDae66NphwcfozcWxgQLEIbKTUTmJLWuGlptCUdGwZvPFWV9pouvoEYM
         lMyxQXfGEi2FlqJCZyhS/ilq+qdUrJLk4ob6cQG9i9Ih/N4imCbBTsB0iBOGE3CSpSgR
         al5yw+vCpCdPQGE1OBCbKBPBwz/C0W7T9TkVOOohuEXonnTa0Cx7K9XBRwQBBBlIemSe
         4/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354256; x=1762959056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSAtykixYoDc8mDqE0NZFVUWNpp9tkRehnUBmieVPhM=;
        b=OyCgP0X1XEQRx0BhzDd3GhpOEQg0Wtd9sEKXUI6lwof+lozJQ4BVYcGI7yZMwkLWSW
         8MU5jzPYyayTh6atYVZnHd78OrKFPXPutiVx51WsWYaNGbNGBRsbHo44CyTbHHQbs6MZ
         exNtxOp19ZwsXfrJzaRagGi3hRPRxQeU9WJDZfYcjNBjZ0DnFZr4PktEudYv5IQMzYHB
         L1b+S35GwXRD+MiFIGunkS9giJ5vZOzgpyrE5LPT1/QGPcZvZTXlraGwi/x4CyLuNw/L
         9J/1LgmzWBZfyJJ7eAwEzmC5h9GZ1ohb/eZ1QAiF+5mvGGri5lvwTcbRMcZAIIgBneNf
         x+zw==
X-Gm-Message-State: AOJu0YxbHt/UkM8tstNBCzHSQKXAfuvi7V92O5fmrbEQb+Jiocj4r79H
	8X2CnEJBBHTM+2t6QDLxfyo9brxGfhaNVXCVd5/00OaL+B8y6zHM2UqACh4zuoe1zbs+QEzEp1g
	cybP6
X-Gm-Gg: ASbGncvWo2Z769DhVC8K3L1DgVPveILgjtHh/NIhgSR4AdEJi5BY466C97yme46LMEM
	rrnKXVC8/oZTsiN1oHMJRImtOKcuKHnc0w+0aNKr/WXXdfk1P1LFiXS2LYE8Gx5aptsXcybnxTj
	41AOHbe7p3j8/ENdaPn+b9XJbQigeZAY2xdjtpqoDtEmRpuz4RdopOn3TeTXmPq1cZlTVwF5aO7
	JAElY3cMtJ9yfQdHqJM/8Yur0pMd67QrA8cOEQ6Lq9s5sgDysrPJhbZqpQdFGWLMgp+q+RJJmBG
	q5LQiloxB8VKP2pVWffBbhmKAr8m7k/Px9+GPQVCrROJ5Aevy8vOUaaNq7IqGFblpLIZe48Ll3S
	gTsEuvTh6+yG9G2td2tKS0qpEmxM2+NZDyV0RNyOl2lcX4xvIvg3kmXcFfrTDE9ygQB0QwM0Arp
	7chL98+FzaC1n+f2s9wYDUSBI=
X-Google-Smtp-Source: AGHT+IFIMPHuR2cFy/+vGAJGaRdbo/j8v+7gg3T/Gz/ibk8ShofabyYEEVWonAEzkaYjj7GUmFmuDA==
X-Received: by 2002:a05:6000:2282:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-429e32e4607mr3152625f8f.23.1762354255926;
        Wed, 05 Nov 2025 06:50:55 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5ccasm10662873f8f.25.2025.11.05.06.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:50:55 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-bcache@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Coly Li <colyli@fnnas.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 2/2] bcache: WQ_PERCPU added to alloc_workqueue users
Date: Wed,  5 Nov 2025 15:50:43 +0100
Message-ID: <20251105145043.231927-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105145043.231927-1-marco.crivellari@suse.com>
References: <20251105145043.231927-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/md/bcache/btree.c     |  3 ++-
 drivers/md/bcache/super.c     | 10 ++++++----
 drivers/md/bcache/writeback.c |  2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 210b59007d98..e7b8c688d963 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -2822,7 +2822,8 @@ void bch_btree_exit(void)
 
 int __init bch_btree_init(void)
 {
-	btree_io_wq = alloc_workqueue("bch_btree_io", WQ_MEM_RECLAIM, 0);
+	btree_io_wq = alloc_workqueue("bch_btree_io",
+				      WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!btree_io_wq)
 		return -ENOMEM;
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 8ce50753ae28..a0425351c179 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1939,7 +1939,8 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 	if (!c->uuids)
 		goto err;
 
-	c->moving_gc_wq = alloc_workqueue("bcache_gc", WQ_MEM_RECLAIM, 0);
+	c->moving_gc_wq = alloc_workqueue("bcache_gc",
+					  WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!c->moving_gc_wq)
 		goto err;
 
@@ -2905,7 +2906,7 @@ static int __init bcache_init(void)
 	if (bch_btree_init())
 		goto err;
 
-	bcache_wq = alloc_workqueue("bcache", WQ_MEM_RECLAIM, 0);
+	bcache_wq = alloc_workqueue("bcache", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!bcache_wq)
 		goto err;
 
@@ -2918,11 +2919,12 @@ static int __init bcache_init(void)
 	 *
 	 * We still want to user our own queue to not congest the `system_percpu_wq`.
 	 */
-	bch_flush_wq = alloc_workqueue("bch_flush", 0, 0);
+	bch_flush_wq = alloc_workqueue("bch_flush", WQ_PERCPU, 0);
 	if (!bch_flush_wq)
 		goto err;
 
-	bch_journal_wq = alloc_workqueue("bch_journal", WQ_MEM_RECLAIM, 0);
+	bch_journal_wq = alloc_workqueue("bch_journal",
+					 WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!bch_journal_wq)
 		goto err;
 
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 6ba73dc1a3df..ccbd9a8f28f5 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -1076,7 +1076,7 @@ void bch_cached_dev_writeback_init(struct cached_dev *dc)
 int bch_cached_dev_writeback_start(struct cached_dev *dc)
 {
 	dc->writeback_write_wq = alloc_workqueue("bcache_writeback_wq",
-						WQ_MEM_RECLAIM, 0);
+						WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!dc->writeback_write_wq)
 		return -ENOMEM;
 
-- 
2.51.1


