Return-Path: <linux-kernel+bounces-890471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BAFC4021E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E343B540B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D32E6CDB;
	Fri,  7 Nov 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bS+A6bFt"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67C19CD1D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522406; cv=none; b=hUuLwxZURLCcfdL/nS3BER1dDm3WHg7xgMEn77jDFKGMuv7fic62G/v97AqeGWe7VCDg7SCA+SuFTJoUAg9/fvg8itsmVduZvMH6bY5jeDdcOHsDXkyz92cJHoP7bog+lGg9T79gbiCtRiiB7E5+lyEGiLutP7i6l9WyxyisAmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522406; c=relaxed/simple;
	bh=rr6r6L3fmjmJiRBxdLfCOfZv5X6qXlIhniqITlnumoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tgsknJCSFbG1ulA3ZMZZvQTsTcqOZ8cFwPjBsc4bVJDpAl5SMLQVq3qtXNe2kuiNn+oNdf2sVCYOMMN0DIEtUBo8yLW3TdSzt3bMOiHobqRO4yjMLJbZu5Mq869LoVfIj5iJ0gE4MHtpp/B92NMMGTcoa1S2HOLBO0E8jjddxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bS+A6bFt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477563bcaacso5544425e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762522401; x=1763127201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SGiLKyBk674zPvRyLzZYpQJmlls8YKxhUjU6CMzNe2E=;
        b=bS+A6bFtE4c4kQrpGCgqtr5+NqmdBM0Ohepu5ekAJZykMHln5c1z4TNn86++RqnQiZ
         VymnhqO9IXGV5szqrR1gmvp6gzMLEp1q0eV1hCEHE9p4182xl2CW+kezJ4otdbaoLoUk
         omhbB2KOtuxMD/RMJUEcdDbZ8ehRGu7UbbhQaHI2S6LA2fnJ+Mdyk0VdtdnVOj1KxQ/z
         503usc1vxfSnOyazPNbCkabSmp19+ua1sakgbe/jqdEmx5EUilgc5FbPACPSoXgg4aW4
         omrTsBgSJVjHcBicGqi0KGa5f4LnKGiaoC9sS8a3p9fJPplogV4WJxXwemxktocdeCLk
         IZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762522401; x=1763127201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGiLKyBk674zPvRyLzZYpQJmlls8YKxhUjU6CMzNe2E=;
        b=vkTzsTnCK49uOHH/U37xSvUUKfEVlqhBzv5H5VM+MBwU5o5DmlnH8gGPhlwKHm/kS+
         UI3N4aCfkmS8aHohNk/WvktC08Udtg7kHxFpJ9Y039aFgLtx7I0XZZ9h7+WSyBlW8ATH
         cuO35VkhuT8hKX1GR05pITen9Ur18npwzvlIu4+Scr3CRiFLd31llAGQRxHbkjArDIng
         IcFAcnJTzJ8vAFRF7NnNEy3wQqPR/fYnDJoHKKG6YVMVYyzqISMSvU9CLL7a5C0Blbk0
         kpaxHInBKOa+vMzDqtXybTMw31dBiW6zi82Pz5ZHAjrZrZTe2Hx5FzUZbPlH3f2yQqUz
         UxHg==
X-Gm-Message-State: AOJu0YxciDwPxdo0sL2zHKmgp8YLg4nilPov1z+ACuatTkGMGOabO24g
	uDzd+2sumjAT8WSxsWFx1TKDb7lonrzOCJwDzEl0SIBt9fnePWBg5SM53DRdG57UjCJ9rUuX5eF
	6rwfJ
X-Gm-Gg: ASbGncsrgVzdlFAv9Fpq1o+ODkz330cr/ABcHYf27fXSc9a5Oo5j3vWpuPnDjmP7l0H
	SBcRzPEdMt2Sjo763sWZFf6admMG45f5suMMRjHwG4pTlrDmg+cbJfuMpyehOiZ1XuUD4d/evLK
	jz8Hs51BOTHggdFBsfoo+2CzJKf4pU37tWG7no2fAaIhILffun6Vkq9zBCeY3iLb0DWR088EfiF
	htq7pzPXJazDxSp52NNNYBe0UZBAJ5ohhwq4CJSmxa4VZy0VZgBIlgw1lsP5GFBTiiyzftisHjE
	HxRowSm6EuewuoA05nPFNfkj6djsFoFD29p8CwpO3THRKOQkvy2LIBN6Q4ITjJLIw1KsA84s+WU
	1zu7IAsliaQjZlfVqQfWA+0G1tAZX2Gy10KDs2p6g4ClDZvxIQQgczNDIrxWADkPzJ9f5euRW7a
	OefxRel6rewoVdoA5z95weq+RXrhsD2/l7HUA=
X-Google-Smtp-Source: AGHT+IHqn8l82QI2FvynvEtmKQ88fDIKD344vI+VzALApBnJ82qM3UJ3KcaVbdcfycniAHlcbP5/cg==
X-Received: by 2002:a05:600c:4fcb:b0:471:9b5:6fd3 with SMTP id 5b1f17b1804b1-4776bc25b36mr24303905e9.0.1762522401117;
        Fri, 07 Nov 2025 05:33:21 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47767749916sm86260235e9.4.2025.11.07.05.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:33:19 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH] IB/iser: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 14:33:06 +0100
Message-ID: <20251107133306.187939-1-marco.crivellari@suse.com>
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
 drivers/infiniband/ulp/iser/iscsi_iser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 2e3c0516ce8f..dc531fad73de 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -1029,7 +1029,7 @@ static int __init iser_init(void)
 	mutex_init(&ig.connlist_mutex);
 	INIT_LIST_HEAD(&ig.connlist);
 
-	release_wq = alloc_workqueue("release workqueue", 0, 0);
+	release_wq = alloc_workqueue("release workqueue", WQ_PERCPU, 0);
 	if (!release_wq) {
 		iser_err("failed to allocate release workqueue\n");
 		err = -ENOMEM;
-- 
2.51.1


