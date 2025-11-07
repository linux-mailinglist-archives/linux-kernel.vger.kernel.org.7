Return-Path: <linux-kernel+bounces-890650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1EEC4091E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C963E1A4241D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9F32B9AF;
	Fri,  7 Nov 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YZKT2RWX"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201D32860F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529042; cv=none; b=uZ8uUFlFtwrP+1grupsHmMcPa/tNpDDYv2ncvgjULDvT6GICefnqes9WvkvaKfM2UKdRrvHYniqo4ZwjIt5EfuX2dXDoCkBOOM3HuZn9wou4CZjWsOluKsyBFR4ch081TXcmbZVhg42GKDi+PcNFB+1JmICw8aTvcMm5GUebUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529042; c=relaxed/simple;
	bh=nDb0O6dzOVMWuFDYYVHFPTwHHNQ+pWTzegor75kDLfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gPS6nBm1R5xE16Os11DCjlqhgwcIMO3Lzn7M1PBite3Oxr05jTkzVVmFO7S17QWt4cDFTZgBxuTCplAKc4D7tp1HKTqoDUcsukio6NJGPUQTnXuosbXSyVRtW6LkA7bJMKnuZCynSCy6ayVhTBXzu/R+GXWu5YmJ+Dp7/5/7jJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YZKT2RWX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47117f92e32so7288455e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762529039; x=1763133839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn7GUP8McG3zK7DlEJjzjjz52xWwiXzwF/L1BD65MSE=;
        b=YZKT2RWXXR+VOAnDkQQPgtndgLWi3Q1kwe7utMKlVLSUgzUw8A+u6cPkDcJONmxl89
         n6H99/PGUvutnU1a7NsZTztMvkm59RunczfPY1a7JOt4K1tLV8cNtcx3aA8aI9oUnlJd
         SKTdqjcPfNKnuWxovB2jt/km79UVKoimObsygrFCt1R+FkYzvCh/lDedrPSOQExcgGST
         dSRO79MxYzO8IvEVl9Q+pvaquXVtNqdWe6XpFf48pNIaGaV9WYPH9OFHSUapwLsz4W36
         A47X8Kuc7dAnsGSLtQkypWA8d17lKdItXnO2sZDjIDisx2tR7dmi8bpXSGokIklblDTh
         RK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529039; x=1763133839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn7GUP8McG3zK7DlEJjzjjz52xWwiXzwF/L1BD65MSE=;
        b=k1oDXV/JEy7WtnNEAKKoefaopGiEPLQH0cEqvw8Xlfy/LGN7PjgQDSSulp0VNZwn0A
         K2+CScwZ06VbJ5GypRgJm2fVPQZrl8s4k3VPZA0NzhvHoZZ3a7Nbv0oczj6nZOLxJgWG
         LqzkJ+t1aPsYUxnSplCPUK24Av6sx3L51rv1n9/TWeWhl2jOZA1+X8Oj49L6gWjkU97U
         63WMiN3/kRfMRlZT9lwkksm41UHVyuaxgCbK+zaQdUhtkxFe9Ry+3LfSHndEpBQVkvTN
         2dBjUfs80NAkknYXWsoulDToeenJQdNa0p0WM9IgruPJunYS11G6i1Wsj8Bsff3m9fQG
         8k5w==
X-Gm-Message-State: AOJu0YzavwaZegQR0OdjOuT1+jSvEd/TwBuXEHSS0q5/9TEKxxPaC5Up
	3WSvbaz2VcwLIFPIHl9GPh7u9MPUn+T/c7IgaAAOmX+WuJpvpL35CqWTjNHv55+h8CfQpjoF3lb
	HkH2rN6c=
X-Gm-Gg: ASbGnctbFuB8oWmiuebUGetPSOGqYi2+EK322QNpB7roU/4iU5tHWkRLIHAk4RedY2e
	5JeQsl7cb/Gv2uSYIWuH+/F6ZAK2/lkEdzhGzhjOXZWSBqLuzlArPRDVBIr7HgjxJbBg28D2n3+
	ZOrqXnwo2aE+bbM/91+xOtsgmL6mRjOzqCOrj4xNDe5cIoyKsu2/SrSgQ4j3SH1iZb/IFsrAXog
	Jt4fr+1ClnmxmeYGQcs1aGyDjGRI7XrkO7k3XD720a9Hv5DZ4Ch5O5iStoMZmpv0lzEKF3lltum
	fafKBrqYDfEJqvMAZte+zHmO8lJVrJlfB7Ko75VwUWHpKdWJiR+1ADNRcnHoJfa7qZwdOdN13IW
	daNbCENzxmGWiUcPK55HapvohmDBaPb42Jmd++yWNfhHIW9iDIalLsN/7+Qxrr1jep/IHiuZ2xt
	iiZ0AfrFAscjTqFvTzIOQEoLIB
X-Google-Smtp-Source: AGHT+IEuB02jHpSTzBJzUrZVFlClNFUykNNdfp7CZbsJjUOeJSALKQCmJL04EEkoidUr0XP27QRO2w==
X-Received: by 2002:a05:600c:1c8c:b0:475:dd9a:f791 with SMTP id 5b1f17b1804b1-4776bd04d59mr27043215e9.28.1762529038867;
        Fri, 07 Nov 2025 07:23:58 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4f13dsm42953005e9.5.2025.11.07.07.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:23:58 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: qedf: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 16:23:49 +0100
Message-ID: <20251107152349.288190-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/scsi/qedf/qedf_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 6b1ebab36fa3..9c234a36dbff 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3374,7 +3374,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	QEDF_INFO(&(qedf->dbg_ctx), QEDF_LOG_INFO, "qedf->io_mempool=%p.\n",
 	    qedf->io_mempool);
 
-	qedf->link_update_wq = alloc_workqueue("qedf_%u_link", WQ_MEM_RECLAIM,
+	qedf->link_update_wq = alloc_workqueue("qedf_%u_link", WQ_MEM_RECLAIM | WQ_PERCPU,
 					       1, qedf->lport->host->host_no);
 	INIT_DELAYED_WORK(&qedf->link_update, qedf_handle_link_update);
 	INIT_DELAYED_WORK(&qedf->link_recovery, qedf_link_recovery);
@@ -3628,7 +3628,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	}
 
 	qedf->timer_work_queue = alloc_workqueue("qedf_%u_timer",
-				WQ_MEM_RECLAIM, 1, qedf->lport->host->host_no);
+				WQ_MEM_RECLAIM | WQ_PERCPU, 1, qedf->lport->host->host_no);
 	if (!qedf->timer_work_queue) {
 		QEDF_ERR(&(qedf->dbg_ctx), "Failed to start timer "
 			  "workqueue.\n");
@@ -3641,7 +3641,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 		sprintf(host_buf, "qedf_%u_dpc",
 		    qedf->lport->host->host_no);
 		qedf->dpc_wq =
-			alloc_workqueue("%s", WQ_MEM_RECLAIM, 1, host_buf);
+			alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_PERCPU, 1, host_buf);
 	}
 	INIT_DELAYED_WORK(&qedf->recovery_work, qedf_recovery_handler);
 
@@ -4177,7 +4177,7 @@ static int __init qedf_init(void)
 		goto err3;
 	}
 
-	qedf_io_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM, 1, "qedf_io_wq");
+	qedf_io_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_PERCPU, 1, "qedf_io_wq");
 	if (!qedf_io_wq) {
 		QEDF_ERR(NULL, "Could not create qedf_io_wq.\n");
 		goto err4;
-- 
2.51.1


