Return-Path: <linux-kernel+bounces-881428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1AAC28300
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7933AC180
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0518C26ED20;
	Sat,  1 Nov 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ar9f79Pk"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD995263F30
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014708; cv=none; b=SrUnEvARJOpHYhGmMImd18lv7C6hN71raIuZVyuJYTkF+mnLgANH0pw+YhQ+tzHpY48fWcw9ZN1AjwFHUYZgueMZqlh9yuL85EFZxBviVHIk54VHore6Ua5ZnZNpabroWjm5yOj0+KftSQbarVm6CpKjMpK79OYTvOA7d5+tAj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014708; c=relaxed/simple;
	bh=/+z72a0HG4HnREfzMdeSt5GSakxveM/XKf3p4bLSwYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFLkZgEpHQSXkQVIlhCIeg2auSicm39dllAkIgFz9F2xP0b0P1M0fYG/9CKXpMlvXKIRmyg3feyudv00fbZD4whxH1MdKweIYNFVgU8wW5ac26f8kIe7X4Vu2v1wrU1iJlx76cbB8XrrOk0gqvhm3dmWLNJruw7ba0M0BL0UKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ar9f79Pk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso20981955e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762014704; x=1762619504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYxN3f0sISH3VgYFCYL8piMSpurElNpYj5fttjw9+bM=;
        b=ar9f79PkWyGJ9NEpBnvnlSROM8LMMeiPT6FS7QJJP8DTcXybfcPuCrWOUrZY2pw5jz
         Q4aaBGj4jXvgj9CYWql8FGb/H6FC8xqUbSiyif0nHjnRuWNJUXh2hLhEPgRTVkr/3U7G
         WqaBRenyEjtLn6ZI6OC9HlkYdSW15V3rkrjAqzBJu6hHt4ktQrKRbSIxepOxao/O3o4J
         NAtdS3DGhwkkQleja4VaobmtxT19fa7/4auTAujLfGbj3UCNd+yZi0YtvHm451Wkh2Uz
         klfqHo5UTkNhBNVnHLZKp0xgp0/vOS1mPszIdS9p9vBimoLZtlse8PN8qFXZ90Fg5RqH
         Y5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762014704; x=1762619504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYxN3f0sISH3VgYFCYL8piMSpurElNpYj5fttjw9+bM=;
        b=iVilnMdBxR10SnFjF60xZS5ooeLmhT+FNaUod6719vfxWfU7HcWtdVPR4xM/xb7Biq
         k7Z+w+vHashLaxATOPdeHUo2RNtr7Pa2E/ZhOE3q1PB+K3FzqCCW2cYQ3TinzEC0t2fO
         GLNkHXUYtS1TOrfCusVKO56FTdFgSw1wm2fLNs1zLtX3NscXt9DfLrgZ7VpbbmUGuvrc
         eZMJJ9OaBcvrlYcx9zF2juSJblrIvr8UfQHXYJ3uPqhqiHIxXmK7HZVWKeJfPEnaWFNC
         pEfqM5UrKNA1s4I/Jl5cSVySKn89jkzEDYGAwz1I6XrVpV6mWFDrNPi/VkFUVb493bmc
         ef9w==
X-Gm-Message-State: AOJu0YxO1Wtm37Y3bpv0tAZ/AkxqZOCT+9t79vCkFEI/RuxG5vV6PiKo
	kWG3SoMOe5hKrpQDDm0J1L9kBu7ArVQbJ69Obrd515lSLWL2C4JCa919Ujic3/Og7RBR2phAa1f
	KCUn0
X-Gm-Gg: ASbGncsxBu5+fRXI9AFgSoR6Z3o8cLGBGGim98wo3VlJeX1JzEMkn+M30QbUVganAKn
	A6tZA7esJQ/F2+LdNPfnCZknpjiTcRKNg2KGByrlzFj8bE+7IuiafMJmpZ5d1hrL8Hh3tTGg4cZ
	qsa5Vm8ovlsQAvpFlFc54t8I99U+9oHRQ6GyEvHFZsyi3DqX7JDjHyB9aumwG18jQ8cE3O1a8eE
	HI+uK/ChioXj745e7YqT79jDxhg7wjtfdFdBwJ5d09mV1PPO65uLgteV+iH0EaBB4oPuwUukqdq
	VvRyMnGkYIoXKDwPIV1BnjZkDJzPifqnD+ddM+dy9KStIPwU3GlfwPpwOSyytzv6hlXtNv6RqkQ
	oLRjfPEdh77frVyccdJPhdeQFGi8SPeLi7WgZdQT1aMoivdi5BXDaUNOpHD/nSNgVU4K+6mq2nU
	HXDN+2mg1PnebEgbqMFVtHytkm
X-Google-Smtp-Source: AGHT+IEQI/OmS9cYFi4nezlD18gB9/y0tILr+1Qa0cLSqTcdp9k3IlgKBk0q4nInZ5a3mPNL8k0tmA==
X-Received: by 2002:a05:600c:3511:b0:476:4efc:8edc with SMTP id 5b1f17b1804b1-477307d9920mr63343645e9.15.1762014703867;
        Sat, 01 Nov 2025 09:31:43 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm56742285e9.13.2025.11.01.09.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 09:31:43 -0700 (PDT)
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
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH 4/5] RDMA/mlx4: WQ_PERCPU added to alloc_workqueue users
Date: Sat,  1 Nov 2025 17:31:14 +0100
Message-ID: <20251101163121.78400-5-marco.crivellari@suse.com>
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

CC: Yishai Hadas <yishaih@nvidia.com>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/infiniband/hw/mlx4/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index 12b481d138cf..03aacd526860 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -591,7 +591,7 @@ void mlx4_ib_cm_paravirt_clean(struct mlx4_ib_dev *dev, int slave)
 
 int mlx4_ib_cm_init(void)
 {
-	cm_wq = alloc_workqueue("mlx4_ib_cm", 0, 0);
+	cm_wq = alloc_workqueue("mlx4_ib_cm", WQ_PERCPU, 0);
 	if (!cm_wq)
 		return -ENOMEM;
 
-- 
2.51.0


