Return-Path: <linux-kernel+bounces-890646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C597C408F3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F8F1884B69
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D4E2F6573;
	Fri,  7 Nov 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L4wF4tBe"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C7220F38
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528590; cv=none; b=XAnp5F9OnSAPpMUQEgOkj92HbNo2TcXpgs/6hfyl75KPWzhCLdv4Wj1f0eDjMXeEd+38dH3ZmL/9axt+fY7U7EZYm69+z8QetDwTvLdv4JFKpWnwp39Qr7n24bchfxA3m4scQD0mlFUoXHWhtCtTR4Txd6ei92ZgeSZhCDM0Q9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528590; c=relaxed/simple;
	bh=Q/6vxRricWDrRCUSl44BgJKITMGcBpXQaAm9tnUqR/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=psM/fB2VRA9QLEpCTxO+EzNcWcaAWVLnj6P/ggOkfDgMcH0S13G30zPkPQ5MfCAZvde+yMTtmxTEnBFx78LrYh5eTOeowWAELqTwkQh13/8y6Wz4xKafTz5sGFlM7Lk1hWth/TGfj+f3PkBICAHCwinrBJ1bhfqF5VvKS3RHf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L4wF4tBe; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-426fc536b5dso547857f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762528586; x=1763133386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fcwFTq1/DogLswamjpDbcdEqXnwm4REhdjASNxEdBs8=;
        b=L4wF4tBesny1Tg31eUJYUEIjM2pDo6xT1Z9kmDx89CIRaHLFozx4wm3k4+UVLRjgcs
         SBNMwIhj1753vcP8COqkkE169oVf/CeilpfhOLYHbuwD7AMI0BQdEWaML77jU9EfplbT
         zcy9IAUBcma+VILQ1yZOv01xA/lNJxPevB7DyatiZQtnY5x70BFE7MGtEJspkW2JfY2s
         DCevp2JDSvIgpKLAsPByhjMN+InLYPujWt0eDHzREnX8C9wUKhvmUGoMw0PRj9qHt97V
         xg/zChqqriNqIp5B1QcyJpxICwUBAF0JqBxA6S53adcRr/+jBkmNBVssJiyAErZ8QbZ5
         Gu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762528586; x=1763133386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcwFTq1/DogLswamjpDbcdEqXnwm4REhdjASNxEdBs8=;
        b=YFdH39+CBdR6qJIxGzNRR7mCAD55c5ny+hwFukHaWrtPsdGfG0bH5P8Zjl071Oa0RZ
         HqJ5tfstmzjsIrv90oQLsYQacFQblafDePZaWCY43vt3tW89hUZFCh0oC4rPmo2yBJ2s
         1H+E04xFt5qm3WoyXkBD82Ht9uk9z5oSAdqYGhYFtCI+NNQp7VcKCZOxSRe1ItuVHn3B
         JSWiJhDdqA0KpNg62YmaieC3q5pcv444eaOvCIOmF5A0m9Xymre/xXdEpznnO6Op+qhj
         HJUyM/KIijUS7LD3tl4OdIFYkC+X+XYUCoY5+FyqkWnZujNbIHRB0H34jIKDldxtFPut
         z5GQ==
X-Gm-Message-State: AOJu0YzwzLUR+xR5t5XoY9rZUgGvaG1vQZ8cJYEnNOqnlFAz+u7pcOLi
	M21jfvPCgeIBhZtD9AxHXVallXXHv5GysOOdUu6RKLhtFWOjUVIUNYyFAMvq+asSqcfVMWxulWP
	GH/XO6/U=
X-Gm-Gg: ASbGncuY3J+PquKe1cac1A4ejIcXNTI7MZvr0zpY+aklON/y/7ce3aYmvallqWEYbia
	UUSWrn2VmVdmWqxYAswWcQiS5XUOyfbA/eUIRSX2lr5GSXdAhyF6jK3oOyFDyNFf1NTLE22iUOu
	J6SQN3rvTJiRwHzh79oiqoiKW3dj4fTlR5b4kK+lJj/97hrxcByVQHvnB65p3WTHWia+U6kixzR
	+E9m1IMfZhzQF2ra9t4u1utlTOl3UD1GTSVOafOf/O4g5A13psDSBDBZauH1dfpFcBqNi84xIcc
	YguzR7y42hpH1NjqyNirNPc2pbq0VXyKtGRn9kAXA0poobjT38QFfqlOlfqcIbBRpLxvJ7/Y9td
	8smVTwMk2AjdhY/GJvFibdgR3gO/VJan1c2Y4KdtoK57nX7OSRnNa5sh4oqb/gi3UNba/WGK/jP
	YQ3M1jfG7x3QsJMzcR+4Srt+vH
X-Google-Smtp-Source: AGHT+IEb71e1N6JfIEUJiI9T+djX0T6M9NFuyXbFtIKtj2yXnBFzlQmVzBKFWvRjsc8GOuNvVFya4w==
X-Received: by 2002:a5d:5847:0:b0:429:bc56:cd37 with SMTP id ffacd0b85a97d-42adc68956bmr2219409f8f.6.1762528585653;
        Fri, 07 Nov 2025 07:16:25 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac6794f6esm6688333f8f.41.2025.11.07.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:16:25 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: qedi: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 16:16:18 +0100
Message-ID: <20251107151618.281250-1-marco.crivellari@suse.com>
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

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/scsi/qedi/qedi_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index b168bb2178e9..56685ee22fdf 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2768,7 +2768,7 @@ static int __qedi_probe(struct pci_dev *pdev, int mode)
 		}
 
 		qedi->offload_thread = alloc_workqueue("qedi_ofld%d",
-						       WQ_MEM_RECLAIM,
+						       WQ_MEM_RECLAIM | WQ_PERCPU,
 						       1, qedi->shost->host_no);
 		if (!qedi->offload_thread) {
 			QEDI_ERR(&qedi->dbg_ctx,
-- 
2.51.1


