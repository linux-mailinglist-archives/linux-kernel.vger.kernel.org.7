Return-Path: <linux-kernel+bounces-883415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0FCC2D5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FC524F5DE4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A600531AF2E;
	Mon,  3 Nov 2025 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IpG1y1eK"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D670B3191C7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189582; cv=none; b=HMhlvw2eKBwGSNw7oJOvkbZkqDy3G+hDUbfPH6Y6+UHFifP/0uDxunJAQFa7eEmhIP5j0aBIJDiTHI3Ya/7fZc7F2WQnBL4px7EFW7xopd54LVm/nV18VCAOJ9pd1SPih5dwZw85wkrebdbk5/InYtus4So2ndf1A1eviURkBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189582; c=relaxed/simple;
	bh=JGbAJY4laoEPs2zQT9hwRteXdPe4JCkLtPIeA2c9Vpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=radhPochnWpPS7Neb6RTQKOp+eC8hmn5+kxgVg7oGFdmo5uiLxWfYqvDIFQ2tNg5O+h/hYA3RYbIyC4B8ctXuautOPKu8j8pBxoMi/BSC67fTFSL5Umv/dhZZ20dNrQYjSdIO7mu58YUDZSW4f8H7PYAcrvHShMVHFDgjuqvdGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IpG1y1eK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47118259fd8so34863905e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762189578; x=1762794378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/E+yekLZHoYnEpR/iQ6pLhaCNwhnBlrdLlxkEXpohE=;
        b=IpG1y1eKRlthLbPXtrjkuD+3qhcB6smSAQ9D7OE8XgI5bn8X3p0ynBwiIKIqxrhm7j
         cR7rLTUNosF5I1NwTtZFRvW1P3z6NKpYTJOp2iE2Wgq2Z2EUJv8xj2nje/wU7NoVUMga
         G3jsi3o/hu0GVZswYeR9ssVwjtbnJcVhU0ske1YPg2R/zTwDRxBMaHNNpozqRWpknuxT
         Ul5npksC7sYjGML7KZA5SgiIcCgMheKYsvxtpg137Tytrt0aKl6jIXYUhq/o6Ru+Jewm
         nLX2V7jaPv8IcgzIuJv551wqeFVtwMs4NOzQmPAdFCNmFDK29tejPjNUhw0RpaPteM7/
         OWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189578; x=1762794378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/E+yekLZHoYnEpR/iQ6pLhaCNwhnBlrdLlxkEXpohE=;
        b=IsPwKWOumMcuBNRvCAtO47u2u5h+PbDTp/5hsmA3moxmASlJ9FIt39Smm45sjSU7J7
         AiGIgHlEHOTKMO8eqKXDA21++RGhk7ZYu4FXlWqqBskHL7faQUJxhPPk/TAL7/lumGzy
         O0eaqdJyiGFAzaVLm2zPMXD8f1pEL1ronhDMcnJkR01tu/eHVE36uz7roKJW870VNWuk
         tgW53v9prM4F9lJbDHHyKATdk8IJlRQQxwqar5/Iqukt5yawQY/EbG4zv9Z9Qn9MFJQ5
         0fJ5Gyjw+Q5Mq7hcRmf+KYVisDQJ9HuE4DgR23ISkrPWOCAnVD/Kov7bcbKaoVAOiHKo
         o15g==
X-Gm-Message-State: AOJu0YwCbqktT09odj336Ql9vz+VEGPOZ0SIGuXgkBq4nq8+/5WIvBpO
	+UMkgkJ66Fu3eNSmTDBuqJppyk1T0H1bSnsZfKnL0SPZ0DMuydvoNSyWWIXB+DuxwRTJte9AW84
	pNNfH
X-Gm-Gg: ASbGncuybQnww2lRc5+xkJ49qAsm4Aj61hV7wSz3KaOu7jIpbGXsuXGKQEa9JukavLZ
	pwGqH+4KA31EHLwhe5p0v7AP9X/b1hboQXfa6iklgbKLi1n6Dng4d/duPS1YPJdSDJygrR9K6Wq
	UKb70vOLKgJ2kG989CfQAQ/XBtdD/uMjfhKz1O0C77KMPnlTACITT3Jf4h+3xM0EkutQpJdWhdM
	GnBd+uL6NuSuublHK3AAmUXgQyCaVWRt5/qVKhwvSM7gxIHhAvfnMmU5M+lH90tY1vHef7jlG7O
	k4R0OvtqeiCIkkfp7DH4ACl2UusTzbND09tzA4B+VinedRsJWWj/3wohPNDAZIFc/Rwc1QM6Uy2
	KZIKNk2SLbkOJViDI3YPNNmroYK4jSTtkgAeeKD2GtJSl2s1jjMBD42YZBnwR37gpLoylTC0j92
	sOALPupzS5JbSCnRJPCPpSnMwQ
X-Google-Smtp-Source: AGHT+IHro/MP9UonungEHxvhQ8/oFTI0hKO0Ea28MQuK8I5sRHzjmtcpIky3vjVN1zF4UT9So2PeAQ==
X-Received: by 2002:a05:600d:6352:b0:46e:38f7:625f with SMTP id 5b1f17b1804b1-477316381f2mr63094595e9.10.1762189578380;
        Mon, 03 Nov 2025 09:06:18 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc524ddsm89799895e9.7.2025.11.03.09.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:06:17 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 2/2] drm/xe: add WQ_PERCPU to alloc_workqueue users
Date: Mon,  3 Nov 2025 18:06:04 +0100
Message-ID: <20251103170604.310895-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103170604.310895-1-marco.crivellari@suse.com>
References: <20251103170604.310895-1-marco.crivellari@suse.com>
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

The above change to the Workqueue API has been introduced by:

commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

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
 drivers/gpu/drm/xe/xe_device.c          | 4 ++--
 drivers/gpu/drm/xe/xe_ggtt.c            | 2 +-
 drivers/gpu/drm/xe/xe_hw_engine_group.c | 3 ++-
 drivers/gpu/drm/xe/xe_sriov.c           | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 34d33965eac2..38b42d4f930f 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -486,8 +486,8 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
 	xe->preempt_fence_wq = alloc_ordered_workqueue("xe-preempt-fence-wq",
 						       WQ_MEM_RECLAIM);
 	xe->ordered_wq = alloc_ordered_workqueue("xe-ordered-wq", 0);
-	xe->unordered_wq = alloc_workqueue("xe-unordered-wq", 0, 0);
-	xe->destroy_wq = alloc_workqueue("xe-destroy-wq", 0, 0);
+	xe->unordered_wq = alloc_workqueue("xe-unordered-wq", WQ_PERCPU, 0);
+	xe->destroy_wq = alloc_workqueue("xe-destroy-wq", WQ_PERCPU, 0);
 	if (!xe->ordered_wq || !xe->unordered_wq ||
 	    !xe->preempt_fence_wq || !xe->destroy_wq) {
 		/*
diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index 5edc0cad47e2..566163ab96ae 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -291,7 +291,7 @@ int xe_ggtt_init_early(struct xe_ggtt *ggtt)
 	else
 		ggtt->pt_ops = &xelp_pt_ops;
 
-	ggtt->wq = alloc_workqueue("xe-ggtt-wq", 0, WQ_MEM_RECLAIM);
+	ggtt->wq = alloc_workqueue("xe-ggtt-wq", WQ_PERCPU, WQ_MEM_RECLAIM);
 	if (!ggtt->wq)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_group.c b/drivers/gpu/drm/xe/xe_hw_engine_group.c
index fa4db5f23342..8526addcdf42 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_group.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine_group.c
@@ -48,7 +48,8 @@ hw_engine_group_alloc(struct xe_device *xe)
 	if (!group)
 		return ERR_PTR(-ENOMEM);
 
-	group->resume_wq = alloc_workqueue("xe-resume-lr-jobs-wq", 0, 0);
+	group->resume_wq = alloc_workqueue("xe-resume-lr-jobs-wq", WQ_PERCPU,
+					   0);
 	if (!group->resume_wq)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/gpu/drm/xe/xe_sriov.c b/drivers/gpu/drm/xe/xe_sriov.c
index 7d2d6de2aabf..5c36da17f745 100644
--- a/drivers/gpu/drm/xe/xe_sriov.c
+++ b/drivers/gpu/drm/xe/xe_sriov.c
@@ -120,7 +120,7 @@ int xe_sriov_init(struct xe_device *xe)
 		xe_sriov_vf_init_early(xe);
 
 	xe_assert(xe, !xe->sriov.wq);
-	xe->sriov.wq = alloc_workqueue("xe-sriov-wq", 0, 0);
+	xe->sriov.wq = alloc_workqueue("xe-sriov-wq", WQ_PERCPU, 0);
 	if (!xe->sriov.wq)
 		return -ENOMEM;
 
-- 
2.51.1


