Return-Path: <linux-kernel+bounces-881429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 586F3C282DC
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E7E14EF567
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3249726ED32;
	Sat,  1 Nov 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UcYYUJpy"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198825FA0A
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014708; cv=none; b=aLm4ifkgVjjHYfMRHvCOQJyUXbf/gVR7H1af2KtQsnIWJSOcFYZU2PovpM2NQCfCsxE2MIVRxVJcmaued1mirosfaY+0AesKwGBfwQYs/1ScJFjcbUbMH8qpStuuypJCSOUsqKNMwzBFLF+dCSYT5CcF1CP98Y6rIW+7B1EnEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014708; c=relaxed/simple;
	bh=/fJWXrgv/OmTyZRl62UO7f1B2tt8SS+io9NaSSSihmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIyyXD5ixhM584Qv1sNP5B9Rq9c5ukqRBZw9wkjMav7sUIj8m4iKGhBp76z0DvqWasP6IA8aq5Ha1aDpdgsS35IVs4xR5d2NpatuAkLbYkZ2z7aeznnaSNkuVupkukoJ47B7S3q8XH0WqSs35S1miYoPHSTb+zaobOH465iRLIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UcYYUJpy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475e01db75aso19939095e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762014703; x=1762619503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiF6O5TboqTQJwgMv2bEVEic5NcjvvE8AbRu81SIfqU=;
        b=UcYYUJpysslvXn3Tz0p9AD4H55NNmm8nzd/HYevTVjwTQfzO9mKaJ196w2mts5QLMh
         mqxRcV3V3dXzjRwBWYQaK5jcQyos1En8hm29LpfThjIIiBv4PbwMz+ahBvGpPrf4uQl/
         04I60OWyxmUCZ9fkHH0ve8iUx+TfZj2EK4wL+c67enH8kzZIcj9VNK1TtvXXTostljP3
         sfMDREBRiSU3Cdb86WsWCqlGqQFClYLqy45u54Cl3O/pC1FlVx8kJsN4pi4L25nWEUyd
         m5zeDC9msQycuxRwY1MQ80lGilbtfc0S7txluQxFxKRNqQr2EevT/LOk8QoHvnXgzi32
         udRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762014703; x=1762619503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiF6O5TboqTQJwgMv2bEVEic5NcjvvE8AbRu81SIfqU=;
        b=q8Z8Uvm2Pgfduf2JFJm5hAOAD1UHmQpHlHVfBAbbWemLjuf5gN0bkhQtoF+9DoTxq7
         0ciFPrR6LItK9vDA2u0gtrDljTDMJBkO6Ey6h9EY+EE8sTdjOE9SYpUIEE2EWQ7zLBDs
         L1gL+4hItpc78dGtr0UUg49FDz/0QCUOLGyW/6m6cN9o+93GFCYrli7SLwqXcC5tDMma
         q3DgpPeyRLz1p0nEu1aWGAuI80IgP6qzYzydBsQS2a/NGsAJACB+TayXa4pAqrnja6b1
         kytozTsIZSupVywCxibNPX2tnTH0R3267Bjl34RkMBe2F9EKCvH09Xl6zl7RlgthatG7
         WqXQ==
X-Gm-Message-State: AOJu0YwZSVwN8/SuzWoH+mRObxz++AgvHi2Uk6mBCU2OOOr/pHh2ZwK1
	Ednt5WUug6I3MnbMIoWMTzzpqvW6t344uGj8ZWCpbcX8+PU4zmzhDgV6wgmGmjZtvCHnsOLX+fW
	jOtsi
X-Gm-Gg: ASbGncu7YH/LRDWL1NchtuzqnML863OoUQIqSqbrkBIl9BfcINLg/V0yJOnooKiBPD+
	eUCQNvaHLdF5wwXL05tArNn/BzZg9W4mciDoChoJdOqj8RqJ81KMPH9VxqBL6FsOJNHMTWuhDco
	mNFHUhWXhhwzxUQj9evXU57eBnx22tj4jxbK4nmz1L3Ed8dGtrb9R42GkIpkJ2uw3zd9oGcr5os
	nsxqpDpvdvr8zuhP6llprNCZCmYFdJP5seFa+2liaDGjtzA8PnebZaKSouiaBs/fvTOZuuw9UUm
	52TiPai3NbmhJftppnmt43wC6f0i0a8dSdWNVrwcmnQwLqtQ7u8SyHWe0zSeeXAH7EGmvlHOlFv
	p8KZyJ8aNrbkw9cOZ0rAgn+GLe/1/0AFQMM8ybb18++BiMl+A0JPNSoAsDFuVduhyTPs/iPoGTk
	NNVP3NB8AzWnEO90vnWSF5C18G
X-Google-Smtp-Source: AGHT+IG5VsZ0I9qX4nQcvqF1Dy4VWh3f2+M5kkzIn3zTq7wV9N3+7gooZ1qGGJuV0B5fn4K9tBOhGA==
X-Received: by 2002:a05:600c:870e:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-477307c2233mr79040245e9.2.1762014702972;
        Sat, 01 Nov 2025 09:31:42 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm56742285e9.13.2025.11.01.09.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 09:31:42 -0700 (PDT)
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
	Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH 3/5] hfi1: WQ_PERCPU added to alloc_workqueue users
Date: Sat,  1 Nov 2025 17:31:13 +0100
Message-ID: <20251101163121.78400-4-marco.crivellari@suse.com>
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

CC: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/infiniband/hw/hfi1/init.c | 4 ++--
 drivers/infiniband/hw/hfi1/opfn.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index b35f92e7d865..e4aef102dac0 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -745,8 +745,8 @@ static int create_workqueues(struct hfi1_devdata *dd)
 			ppd->hfi1_wq =
 				alloc_workqueue(
 				    "hfi%d_%d",
-				    WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE |
-				    WQ_MEM_RECLAIM,
+				    WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM |
+				    WQ_PERCPU,
 				    HFI1_MAX_ACTIVE_WORKQUEUE_ENTRIES,
 				    dd->unit, pidx);
 			if (!ppd->hfi1_wq)
diff --git a/drivers/infiniband/hw/hfi1/opfn.c b/drivers/infiniband/hw/hfi1/opfn.c
index 370a5a8eaa71..6e0e3458d202 100644
--- a/drivers/infiniband/hw/hfi1/opfn.c
+++ b/drivers/infiniband/hw/hfi1/opfn.c
@@ -305,8 +305,8 @@ void opfn_trigger_conn_request(struct rvt_qp *qp, u32 bth1)
 int opfn_init(void)
 {
 	opfn_wq = alloc_workqueue("hfi_opfn",
-				  WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE |
-				  WQ_MEM_RECLAIM,
+				  WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM |
+				  WQ_PERCPU,
 				  HFI1_MAX_ACTIVE_WORKQUEUE_ENTRIES);
 	if (!opfn_wq)
 		return -ENOMEM;
-- 
2.51.0


