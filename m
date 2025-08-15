Return-Path: <linux-kernel+bounces-770654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFE6B27D80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD0AE1CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52B02FCC15;
	Fri, 15 Aug 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="du7AGgSP"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D452FCBE7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251300; cv=none; b=nLpn2L2+o+1Kuw87Ydx8FGSxyqacgWif0P/3M26/R/YgXvIFZZRme/unvl5KWx3SBtvAFzH5B7/f9InAeN/bc4L8D7SU/UFcG7gE2hmEHaT8gg9P/vKvJEqWSnIzRUm/rj2CJPzuIVkCfoWWs2Kx8GsuSKH/TiP2gvusIT3SaFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251300; c=relaxed/simple;
	bh=N/V6hRe5DIEgL1pTRZcFgFnUSZN4UbYQwsoALpQtFqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPIbsjJJ4CO5t5rcKBi2Kc853o8RlPsGoCfvG2ocn9+7YH7TTNqBwLng/lWY1Z1ehFiXvVsNnBRj/6jLTVNPJ1Yht4X7GMmoFhBBjpdueYSsN9ET2Fgbdls2icXWF7TOJ1fNmdyuJJjFy4kNxHi/6Qb/UOzlUsK0zlSRj83wpCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=du7AGgSP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so9226145e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755251296; x=1755856096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEARy1lXoDK0g0MYvhhJVy52n0QhOQf4B9qHOrGhxq4=;
        b=du7AGgSPjpmpmhycE05Pj19RWrI+eWjxmrQio6RXz1De6gtslthGo8aLvAa1xMojfr
         S1DCNt14jA+Ccr+5G0LFLsf/g5C3F+XIjIKbCywdspvpcMWNLVoVG2mw/XzSQpugehXH
         QBDd0HtBVGTUXtLFwONLy5oqSCNg0zLrZafgZBd2o69qzU59pZzvbmwvPfinnN2NIP1q
         3fpOi+JiDaEXy+nV5NQvxaXqqECFoGjFBHiOAWeJpFt8ZMOVCr7dUfA+E/fK9KPB4NT7
         SmdVJWGlNxXDwUEMFEUaCI7MbHTsZfdiLLwTtKZ4JbaCOqy1dy8mwG/bsYnfD3DNdI2/
         kXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755251296; x=1755856096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEARy1lXoDK0g0MYvhhJVy52n0QhOQf4B9qHOrGhxq4=;
        b=OCdtAhaEjBHElthPyGFugnG1lD6CigG9Rl69ssh9xemt765IW2HMD+kxMMntxj/Mn8
         xtWWk7KKK/8u1uu69aJMj0mLrF/BylturEgLhqNgTn+jrSY+oE/9fDmFW0E+Zl7iijJa
         JKAWBiVIPX4n4JdmQWUtHEIaIxjHBwmjijbcVCpDJFLXGMDRAQ2eM9nsx1zHOKP5YIm/
         DgCxO6XNvtEsEVJGCW2zi8bXo7kGG05sBsTz7ULAFpGk6BG7V6bvdQijY4gFAIlJAXzL
         2ZcxRYpgt9otsAIwoqA51mFSKmkJENSDEN2/ad/K0FXh0K9ZGyq4lkgviTkh2Y2c+Vin
         zlIQ==
X-Gm-Message-State: AOJu0YzHPOj2dIp0phPQ66fC7yxG7c0YnKTT6d2NtrTmacyE8GVCJ5Z0
	x/LYNYHnkXR42cvzr1S0ljDOmOkaRxvSzfj7CLuqcU8TPdVMTQ6cDAyXf2VIzRu9OO9VtXL9lQ9
	jnm8k
X-Gm-Gg: ASbGncu/U+t1PjJT3To+fZMc6JIg19BPJUjjhezha4xNa+eI0wjwG7kQuEADmiFbOCt
	YK7mv5BI3ex1GJVTcPgVPBFti7uHok4ta4+tT5OfQD9HGmPKlbItPTKTUZvCI7A+OsaVRPdxIMW
	TAMhTfHHRrIUl3FAtFVu3oYsFXiUTiBDy7KUOftdjqkq9P7hOGBjHcaaaq48fxFeYD0Ks49jT1P
	8smKCfOuwPG+F4ubuWplz27fGoUWMKJ7kiQvDtQuq9ndQX9N5xgHRUzzsPbMmI6kDcOEyonxwga
	EizBgNK93vadco/RS4PNM6i+QTWajSk88LqAubP0jYyfFyqmJ9+uH6ne5IwnHVSXXdH20hzYdja
	Q8CyU17epX4KVjqeF5dIDrzwkp1y+9rhNVJ8w5moE05WGcg==
X-Google-Smtp-Source: AGHT+IGLxfFuWza4XyXKpS+CPLdj8C1iIfdMBIKkBf+/nSGrCG0rN7ytt7IXYiQK+k4/HVEU7HeN4Q==
X-Received: by 2002:a05:600c:c1d7:20b0:456:fc1:c26d with SMTP id 5b1f17b1804b1-45a21bb3d3emr8595755e9.2.1755251296395;
        Fri, 15 Aug 2025 02:48:16 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a223299ebsm12943805e9.23.2025.08.15.02.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:48:15 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 2/2] Workqueue: net: WQ_PERCPU added to alloc_workqueue users
Date: Fri, 15 Aug 2025 11:48:08 +0200
Message-ID: <20250815094808.54888-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815094808.54888-1-marco.crivellari@suse.com>
References: <20250815094808.54888-1-marco.crivellari@suse.com>
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

This patch adds a new WQ_PERCPU flag at the network subsystem, to explicitly
request the use of the per-CPU behavior. Both flags coexist for one release
cycle to allow callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 net/ceph/messenger.c             | 3 ++-
 net/core/sock_diag.c             | 2 +-
 net/rds/ib_rdma.c                | 3 ++-
 net/rxrpc/rxperf.c               | 2 +-
 net/smc/af_smc.c                 | 6 +++---
 net/smc/smc_core.c               | 2 +-
 net/tls/tls_device.c             | 2 +-
 net/vmw_vsock/virtio_transport.c | 2 +-
 net/vmw_vsock/vsock_loopback.c   | 2 +-
 9 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d1b5705dc0c6..183c1e0b405a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -252,7 +252,8 @@ int __init ceph_msgr_init(void)
 	 * The number of active work items is limited by the number of
 	 * connections, so leave @max_active at default.
 	 */
-	ceph_msgr_wq = alloc_workqueue("ceph-msgr", WQ_MEM_RECLAIM, 0);
+	ceph_msgr_wq = alloc_workqueue("ceph-msgr",
+				       WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (ceph_msgr_wq)
 		return 0;
 
diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index a08eed9b9142..dcd7e8c02169 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -350,7 +350,7 @@ static struct pernet_operations diag_net_ops = {
 
 static int __init sock_diag_init(void)
 {
-	broadcast_wq = alloc_workqueue("sock_diag_events", 0, 0);
+	broadcast_wq = alloc_workqueue("sock_diag_events", WQ_PERCPU, 0);
 	BUG_ON(!broadcast_wq);
 	return register_pernet_subsys(&diag_net_ops);
 }
diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
index d1cfceeff133..6585164c7059 100644
--- a/net/rds/ib_rdma.c
+++ b/net/rds/ib_rdma.c
@@ -672,7 +672,8 @@ struct rds_ib_mr_pool *rds_ib_create_mr_pool(struct rds_ib_device *rds_ibdev,
 
 int rds_ib_mr_init(void)
 {
-	rds_ib_mr_wq = alloc_workqueue("rds_mr_flushd", WQ_MEM_RECLAIM, 0);
+	rds_ib_mr_wq = alloc_workqueue("rds_mr_flushd",
+				       WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!rds_ib_mr_wq)
 		return -ENOMEM;
 	return 0;
diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index e848a4777b8c..a92a2b05c19a 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -584,7 +584,7 @@ static int __init rxperf_init(void)
 
 	pr_info("Server registering\n");
 
-	rxperf_workqueue = alloc_workqueue("rxperf", 0, 0);
+	rxperf_workqueue = alloc_workqueue("rxperf", WQ_PERCPU, 0);
 	if (!rxperf_workqueue)
 		goto error_workqueue;
 
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 3e6cb35baf25..f69d5657438b 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3518,15 +3518,15 @@ static int __init smc_init(void)
 
 	rc = -ENOMEM;
 
-	smc_tcp_ls_wq = alloc_workqueue("smc_tcp_ls_wq", 0, 0);
+	smc_tcp_ls_wq = alloc_workqueue("smc_tcp_ls_wq", WQ_PERCPU, 0);
 	if (!smc_tcp_ls_wq)
 		goto out_pnet;
 
-	smc_hs_wq = alloc_workqueue("smc_hs_wq", 0, 0);
+	smc_hs_wq = alloc_workqueue("smc_hs_wq", WQ_PERCPU, 0);
 	if (!smc_hs_wq)
 		goto out_alloc_tcp_ls_wq;
 
-	smc_close_wq = alloc_workqueue("smc_close_wq", 0, 0);
+	smc_close_wq = alloc_workqueue("smc_close_wq", WQ_PERCPU, 0);
 	if (!smc_close_wq)
 		goto out_alloc_hs_wq;
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index ab870109f916..9d9a703e884e 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -896,7 +896,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 		rc = SMC_CLC_DECL_MEM;
 		goto ism_put_vlan;
 	}
-	lgr->tx_wq = alloc_workqueue("smc_tx_wq-%*phN", 0, 0,
+	lgr->tx_wq = alloc_workqueue("smc_tx_wq-%*phN", WQ_PERCPU, 0,
 				     SMC_LGR_ID_SIZE, &lgr->id);
 	if (!lgr->tx_wq) {
 		rc = -ENOMEM;
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f672a62a9a52..939466316761 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1410,7 +1410,7 @@ int __init tls_device_init(void)
 	if (!dummy_page)
 		return -ENOMEM;
 
-	destruct_wq = alloc_workqueue("ktls_device_destruct", 0, 0);
+	destruct_wq = alloc_workqueue("ktls_device_destruct", WQ_PERCPU, 0);
 	if (!destruct_wq) {
 		err = -ENOMEM;
 		goto err_free_dummy;
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f0e48e6911fc..b3e960108e6b 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -916,7 +916,7 @@ static int __init virtio_vsock_init(void)
 {
 	int ret;
 
-	virtio_vsock_workqueue = alloc_workqueue("virtio_vsock", 0, 0);
+	virtio_vsock_workqueue = alloc_workqueue("virtio_vsock", WQ_PERCPU, 0);
 	if (!virtio_vsock_workqueue)
 		return -ENOMEM;
 
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 6e78927a598e..bc2ff918b315 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -139,7 +139,7 @@ static int __init vsock_loopback_init(void)
 	struct vsock_loopback *vsock = &the_vsock_loopback;
 	int ret;
 
-	vsock->workqueue = alloc_workqueue("vsock-loopback", 0, 0);
+	vsock->workqueue = alloc_workqueue("vsock-loopback", WQ_PERCPU, 0);
 	if (!vsock->workqueue)
 		return -ENOMEM;
 
-- 
2.50.1


