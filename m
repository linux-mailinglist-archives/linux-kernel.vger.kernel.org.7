Return-Path: <linux-kernel+bounces-802405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A021B45219
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B1B5832BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E21308F1D;
	Fri,  5 Sep 2025 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z74N/31q"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3713281356
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062336; cv=none; b=fHNFyyJLSkvr3lAGakFXDxkyAT+JAGpTwhrX5CkYyN8JOhndTIcUuTWSjEJ3/hI7P3ltaJ7rBJLvohhjB3TeoRWEMtN73KzhgPubkY+2VATI5se9d8VVmsG8ek0Wy3zJ7hxtZRHwh9KuCEPnYWAjndGu780ejvpWYHYs7n+O3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062336; c=relaxed/simple;
	bh=DF/iEzWHIQwESB2SDSgXYrot5syuW7SMnlKhZF3RVYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsmgVAnVOxDbBYC5LDBsvork1XWDA0QYMvXJuim3yUEND3eoHH/gwILItFliSXA4dQYi1MLW3dYPOTudILmdINRvTuXYNyymXCWPXczNDmw6/c4MN1mRhuh8PHI5wa7AV2D87qXq9Ky+HXN5mjFPuZf5uDnIFQB/Li8xP1UV27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z74N/31q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45cb5e1adf7so14944275e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062332; x=1757667132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mgapDPHuM0mgof/uZH7wCRcMetT8aod2+Badkbrp1o=;
        b=Z74N/31qYKQjWAV+cE7YhKB9H6JM2rXegGNk3T14tSwjo3iCOEM+y7XmssXafgg7n7
         QliGaWAxNS/nxl8KjP4hiB+ySKVwNY0a41JR+Te7EWtGhePE4i+5O+EL505kCVcShigS
         hRpEbkwbRD9j76uvVNRUUWGO7mDCn5pZxE8TObZo/Z6ppn7k0HiJaBmjPRh6dYe3xtcY
         mwKKVlN7bnegKjH8cflzXhfi46jxGOssRnXcN4p2DbABPFyzmEaE7OtKuviHEufgN1g/
         vtBCgTHs6hBf7NZRSD2Rdya9cpX8LTreLYc9+oCl99QDamGR3Yi5fSzTNMDNGsqQR7/Z
         ZeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062332; x=1757667132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mgapDPHuM0mgof/uZH7wCRcMetT8aod2+Badkbrp1o=;
        b=m3SFjQPRclXKj5rGL80T7MwwTshyP9QzDQBReA716c1Rdn0r5YCeWCTtdchO1Z6nFI
         RoOq4ZCwtpyoj2AyNhjlVFmg6uCGY5SNWIjBWD5DmQs2m+sN7HlXHcm8RIjMfXriWxLB
         V8lkDiQvLJGoQQ6BOPBqQI4seO2Y4GSDAMComzGYrJ7ypZXX/niwpkyeRVXQJLeNZS+t
         yClq/Q6LbddJjuyueo1clphHXCS1rOphtmDVm4t/0zAgLpkxtWYPlIKSqkOBfidteE8d
         pH9ztZ3l+W5ueJLq11RpA8Cp+iOLJCJiKjTM79JvVmkq4AuHOY6sz4P7BbEsa7OS40Tx
         OZAA==
X-Gm-Message-State: AOJu0YzXhfUZdLNPeGe2VSDU0ZWxePDlcuGks4ZQ91YM14CDlU3PKR4F
	p+pN4mqSJVGdkfczdzyXfmgnU9Izv8mmia9Dq6knnnpFu38yNgZBHje2dT9XRD0uEv4JRjyUuO2
	a8f/4
X-Gm-Gg: ASbGncvU7Qz6bwwcchWYPqINSneak4aEy9FtK7r3aQpI1UXmXrKrL/XWZd2zes4PdES
	xCpT+RPgxLsiz9ixxSi7gLG3sysUvPUsuSUgEGJLfOfSumH69HxE9tyl7pXqO58mDl7UkJRzaH3
	QupWNlCyRo8jUFr8QfjhWDjR5NHPelsEdq9W5JCRtsoRUIrOS2hQLkUk1qA9RXzYKsh6eVogxj9
	i38LeYcECX2Aa3jj3zgsRjYJbfRbdGHHVQVAi03dIoYyCw4vuqDCOHH609z+rxyAbe6wUJy+LDV
	iGfh4C0IC7OjCC8wSdv1UhVYFok2w32EvKNZx6v7IUMfn7IBuAFNSpIAK1t9qUsoCbkenYzbcCQ
	vKeHDCX2jZ8RWXv21nVUW5+pWt/ZkKMjULDkYTb6rl2g08c8=
X-Google-Smtp-Source: AGHT+IHFQYNFVYiIXssiaSNUtqeFtGmKO8sqK1MzfGdIBLqddINzipVIOD+1qcAfN7bHYh9ABu5QFw==
X-Received: by 2002:a05:600c:c48f:b0:45b:7c4c:cfbf with SMTP id 5b1f17b1804b1-45b855709d3mr171510145e9.23.1757062332004;
        Fri, 05 Sep 2025 01:52:12 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b940bbc0dsm166359115e9.2.2025.09.05.01.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:52:11 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] drivers/block: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 10:51:41 +0200
Message-ID: <20250905085141.93357-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085141.93357-1-marco.crivellari@suse.com>
References: <20250905085141.93357-1-marco.crivellari@suse.com>
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

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/block/aoe/aoemain.c   | 2 +-
 drivers/block/rbd.c           | 2 +-
 drivers/block/rnbd/rnbd-clt.c | 2 +-
 drivers/block/sunvdc.c        | 2 +-
 drivers/block/virtio_blk.c    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
index cdf6e4041bb9..3b21750038ee 100644
--- a/drivers/block/aoe/aoemain.c
+++ b/drivers/block/aoe/aoemain.c
@@ -44,7 +44,7 @@ aoe_init(void)
 {
 	int ret;
 
-	aoe_wq = alloc_workqueue("aoe_wq", 0, 0);
+	aoe_wq = alloc_workqueue("aoe_wq", WQ_PERCPU, 0);
 	if (!aoe_wq)
 		return -ENOMEM;
 
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index faafd7ff43d6..af0e21149dbc 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -7389,7 +7389,7 @@ static int __init rbd_init(void)
 	 * The number of active work items is limited by the number of
 	 * rbd devices * queue depth, so leave @max_active at default.
 	 */
-	rbd_wq = alloc_workqueue(RBD_DRV_NAME, WQ_MEM_RECLAIM, 0);
+	rbd_wq = alloc_workqueue(RBD_DRV_NAME, WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!rbd_wq) {
 		rc = -ENOMEM;
 		goto err_out_slab;
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 15627417f12e..b3a0470f9e80 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1809,7 +1809,7 @@ static int __init rnbd_client_init(void)
 		unregister_blkdev(rnbd_client_major, "rnbd");
 		return err;
 	}
-	rnbd_clt_wq = alloc_workqueue("rnbd_clt_wq", 0, 0);
+	rnbd_clt_wq = alloc_workqueue("rnbd_clt_wq", WQ_PERCPU, 0);
 	if (!rnbd_clt_wq) {
 		pr_err("Failed to load module, alloc_workqueue failed.\n");
 		rnbd_clt_destroy_sysfs_files();
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 442546b05df8..851763e5dd18 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -1215,7 +1215,7 @@ static int __init vdc_init(void)
 {
 	int err;
 
-	sunvdc_wq = alloc_workqueue("sunvdc", 0, 0);
+	sunvdc_wq = alloc_workqueue("sunvdc", WQ_PERCPU, 0);
 	if (!sunvdc_wq)
 		return -ENOMEM;
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7cffea01d868..a5a48f976a20 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1683,7 +1683,7 @@ static int __init virtio_blk_init(void)
 {
 	int error;
 
-	virtblk_wq = alloc_workqueue("virtio-blk", 0, 0);
+	virtblk_wq = alloc_workqueue("virtio-blk", WQ_PERCPU, 0);
 	if (!virtblk_wq)
 		return -ENOMEM;
 
-- 
2.51.0


