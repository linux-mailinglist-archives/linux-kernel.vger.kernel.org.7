Return-Path: <linux-kernel+bounces-881427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F07C282EE
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813FC3A22CE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE9E266EFC;
	Sat,  1 Nov 2025 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e4Gc7Cvs"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB9248F73
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014705; cv=none; b=dAgk856KQyT3UFXAleD+eDbO0fOq8L6+ElE/DVM9ImgIcV8qrPX/2/yAuKhzB3zwn4GcTrlHn430RsBpSmDg2M0SlpLvR/1Zsyivx4Il3qyxCPcnA8Rn2TlwBC1zB0pQ/Ijt0nTriGnczUPTbr0U5n3g+LO4PABhHqZwXbrhjpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014705; c=relaxed/simple;
	bh=fUwSOfS/JQ1YZ/LF2G9bxAVZk2c6ITbmOr49On69LyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBVEWTCtGUg+dPJqQegAqjoTYWMoQTmULu+EfemsakHL5iEd+w7mINO8USBb/1n4suytbxnyRPsYAntqNyKAj0CflHI9EVcGrtkmlIpc1so4kyUUTrszzFRIQ5tlzPt9JI4duPo/vXdanXXPv4yHK3kg9Ftmf0z/J9vGtlRD8oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e4Gc7Cvs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477365fbdf9so7347655e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762014702; x=1762619502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KowcjY2LbU+WXa81br5hz8D4Udfl4Hhy3wjoXjY4BIM=;
        b=e4Gc7Cvs4/G6JV7xYLQYIirvbJS4supEqYu8URRM05im94jYi+QBGxj6Rloqv23dmf
         xdiUbWrIxcI/EKJnuj2AxHmQU6E0jR4tByCmMMUoDatAq1QrJ3KpfzJxd3Vp4OOJ+BT/
         1LaVI+XK7RvzHBSrwvXhYEhKaOvCGD9jpBCgE7LyAH+ywnQStVzf8bbXo9Lsarpr4bUG
         28dNssasd0naHU2W2/FMiNGwIz/KH+eSTAd3iIZlG/rECi0Mg8t4+6QT5SvXif5Kz4aH
         JVTzHT2hq6rm8cuufKZ2ewYcoh1g7ARG91itsEGl6wNBo9ND7rGOgbmz/vwsQ2NCc50l
         0bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762014702; x=1762619502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KowcjY2LbU+WXa81br5hz8D4Udfl4Hhy3wjoXjY4BIM=;
        b=X6TTzJsHocfiIOVkQN61odQfNBpepdgVocAxdm0L7pL0Q3TrBx6ow5wg98wD0Y23pE
         2y/Sr/zFNP2SqzPgmofgPAWTB/1rcpHL8JhHp3kyxsyT3yFP/LGab7Il0Y3h+REsjJBP
         Wt7rBWYOO5p9aSkF74z4ae24jqRq6jyRtKhGP0xYPuUjkDxs/FB0s+ayPhGfUnLzEpyS
         Q61ysu8WrJXnFYYR7aIWSKKtkKFV4vCcmeMG+GvVPxukpeg6rQUfEIVosedNOrau2Kie
         eci1SYq3ZZ/wsWJMFmHML1t3SccO2ZLtPeWydCpJ9V++lSDdS3vSD9OIxz8PGVVizhPR
         jSGw==
X-Gm-Message-State: AOJu0YynPJh4zjMcyuLlv+rSAqWeMZ3LwAM4phFdrrmDjwCm4P80wNzY
	PQ0B+uQr7/+wvRZW1e33rCXiHdmDd4FiIj2UCIZJnSkUFMgyaQaeD2ohaRLC3aFIJhgUm9Pw324
	MHZrA
X-Gm-Gg: ASbGnculQvLr2Hg4ohnjc1BINlaQv0/ak3e0/gYBzs6l/3WeAPvEXqmm1NQBWxBgj4W
	UMUcavjTr5wvm97ReVtFny3jbbJfyhxLX3KZLQdTWVY+jLeA+1p7+uTLKstnyzPf/aQLmAGIGVR
	smK/ePy56TKRgTKFbkKTUro52jIBV26FkxxDn2B18vFVYDYvI9vT7XtRkiY+MO5/98T6KgpI0ob
	SPVgyqFAFMLqUelLoxPVmkRakGE/saOXLAD+e48W9Ih5SZPBcUJdyncjhnzRrtjW0C63V0T/Mwy
	qpETgt7Nvkg2znh581QY6ld9MPJ3srWzGvfl3Zv2qIAaNs4zVPsPYTuiajIrcfGU3d8X5GVHJFF
	NfI2WC5/3UM1jHJD4bffvlcVzRq+5zGkd12nJXoXkrEj8z1l3b0GD/IRdKBPkmgDuGFaQnZCEXp
	Cie4E9cKZSwAXlodWWBF7KKYHXyXZ4LnSEwMy/2RpRVWFfgQ==
X-Google-Smtp-Source: AGHT+IE65kfOmr/e5vfFoEU/LQB+yC/5lMxdNKvMUzA9r3W7MCtOJR2KSGX5SefdemI64QDECoc9Sg==
X-Received: by 2002:a05:600c:5026:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-4773087e7e7mr71335115e9.19.1762014701945;
        Sat, 01 Nov 2025 09:31:41 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm56742285e9.13.2025.11.01.09.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 09:31:41 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 2/5] RDMA/core: WQ_PERCPU added to alloc_workqueue users
Date: Sat,  1 Nov 2025 17:31:12 +0100
Message-ID: <20251101163121.78400-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101163121.78400-1-marco.crivellari@suse.com>
References: <20251101163121.78400-1-marco.crivellari@suse.com>
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
 drivers/infiniband/core/cm.c     | 2 +-
 drivers/infiniband/core/device.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 01bede8ba105..47d0022cadac 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -4518,7 +4518,7 @@ static int __init ib_cm_init(void)
 	get_random_bytes(&cm.random_id_operand, sizeof cm.random_id_operand);
 	INIT_LIST_HEAD(&cm.timewait_list);
 
-	cm.wq = alloc_workqueue("ib_cm", 0, 1);
+	cm.wq = alloc_workqueue("ib_cm", WQ_PERCPU, 1);
 	if (!cm.wq) {
 		ret = -ENOMEM;
 		goto error2;
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b4f3c835844a..13e8a1714bbd 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -3021,7 +3021,7 @@ static int __init ib_core_init(void)
 {
 	int ret = -ENOMEM;
 
-	ib_wq = alloc_workqueue("infiniband", 0, 0);
+	ib_wq = alloc_workqueue("infiniband", WQ_PERCPU, 0);
 	if (!ib_wq)
 		return -ENOMEM;
 
@@ -3031,7 +3031,7 @@ static int __init ib_core_init(void)
 		goto err;
 
 	ib_comp_wq = alloc_workqueue("ib-comp-wq",
-			WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+			WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_SYSFS | WQ_PERCPU, 0);
 	if (!ib_comp_wq)
 		goto err_unbound;
 
-- 
2.51.0


