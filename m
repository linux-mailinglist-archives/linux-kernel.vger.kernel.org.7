Return-Path: <linux-kernel+bounces-880017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D5DC24AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526FE4214A1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECEA344040;
	Fri, 31 Oct 2025 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d+QMU9ZW"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19E3431EA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908399; cv=none; b=mpflDeGEcGaNLe8DTR0GheoZdhFpppdCcXJoK0viw1tfarLAT6cUtND8WJ+DBWZUFNE1LDUyBL6q/jjH8hmNDtgtkr0P46k5a8ZvETPxusgrSukps25/Qt3m3qF2Zz8AhT7Oyh4V9XmDhHeSUZlr1fPERx2dvR17z4SuvkIFHCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908399; c=relaxed/simple;
	bh=AzMnPvKG1flg0HPoR/EI9rScb58nkrj67hFYs0Jg4+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQhXFCYS8tmlv5eY77EtlutLBZlEVUt5IIIzZmvus7zSt841vXsCk+NWDNxhQHEEQaZY+BPbW1t6NxSjXsYQmocNMzUmHd921nOFXdPtBlkIH8yNHHxBON3lA1nf8QHudybjMR8L7RdX8y//KmxsFQwRZ+B3V3CvMC3ejHfAxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d+QMU9ZW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso1588225f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761908395; x=1762513195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtaLGTlpD3zXcAXtMJEoSUxTvoU8HRv8A7mRZZemTDs=;
        b=d+QMU9ZWsen1VqEv+nZ6tvbqiauffYjxYvJeTnOiv/X5MRXbfaL34iOWm38B7d2f6c
         QjuOm4797oV23M22NbPLjK/qfMKq+WMANg36qkFgG7iJin8/juZpBfEd80LZkFlmWsMh
         Sr+ckQ4E+w7/5O5kCFD95mQdWKMj5CDVkC+Gdii0uicjIvhjNbN814PRcJeG1DRQO4dM
         kYe1bvHyBrsFvNH1tR3Rdl+5GH91y4v6NI79pPMO0OSgWHHASrp6jDEdKrgAQrS6mdw3
         IFkXNFPou8vJ0ZERVlbaqTSb5PyimOgicAsW0HIzV2CEZgvQfl3TnFUhCAKOjhpPVC4S
         kIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761908395; x=1762513195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtaLGTlpD3zXcAXtMJEoSUxTvoU8HRv8A7mRZZemTDs=;
        b=oHGsH9uyWaYAzanbDf1V8K7i5bxeeLbN0GeEB6ijBDmp3nHbX0rb3E3ZcXcR9hqLuv
         s0u0OWsfeao4tbsnJho8tfvajW3xu0dAIDuGkJW+sb2slPQ+5k56kn9YD0LuzvbC2Fby
         d+903hcAzxf/HRxCT6ZZH03XBOQxB6U2HlBCiZ8cPxYSugL1r5zFS4h9b/NatCLJL2Z+
         ze3yzmMC0G4FEbebBQxLAGXZp0JUcVEfJi+eTv4IZcC2HCeju69e48GXCXg/MnVm+Sue
         RrjaGLFk15dfsEygZwCQXwNie52hybm9/CLXMHV3ZAWeJ4NUI9SP/KhWtAt0hxf1q/7c
         KBRw==
X-Gm-Message-State: AOJu0YxyITelNqtYPEORsvNA486PsiLzE1PAIWcgtyLyLK9S28Mxi+2H
	luBHOUYJk6YgBxdU4CaaFguvKJ20lRRpW5u8fHr93lwN5QSNel7A8I0jiy40ypdvnN9NgpKc74T
	6XWg8
X-Gm-Gg: ASbGncuxmv0e2kVIZwR4jAiojYCCgZXCSlxozF/Zawwbh2MFvWaDdPbEx8Mj2I+1emn
	TkFFPElaCd44J2KOyLqyP81CpmyluOw3DwKKSmoBDzmtoS23mgMB9ZM6+u2eYqVbKXxTvLB9NNn
	u5Obw/Z8gvGVyxB2jvzwLQJTttkisLpsJNRpFoKHmG81FiUrHWejZV9wfM9WUI+JZgV5Oz5orbo
	hWd6nUFzhxpMpwRCT+739/DT+DUmjFMjjhkEHvXqazoUgrg0iEtUBCfiZ11XfMg3MA4cU3DlVYy
	cJn07saA7v3AEvXEUsYPyDwbv+qM0UPMb/+gB15WrEnMrMl8DwXuSQcUBCntDex8k/o0agvyN8G
	LBQQv5ZvN7BwgR1Zlr6XYxBCLQenj0z8kwfUC0KjIEqEY21W1jNZdm29cmuXiCCtZf95P+5RW7I
	t1LNy4rJhjNcyV+AdU/5q6t3emCh/9Hr9NxyE=
X-Google-Smtp-Source: AGHT+IEsdl8gncmk7O5sGQX6oiw6d1c49YNa/Zznn0PBesJNtmDV3CtY5LM2CvoEk/+qA0YvvOvK6Q==
X-Received: by 2002:a05:6000:310f:b0:428:3fa7:77ff with SMTP id ffacd0b85a97d-429bd67a046mr2960086f8f.14.1761908394888;
        Fri, 31 Oct 2025 03:59:54 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c110035esm2965528f8f.6.2025.10.31.03.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:59:54 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/xe: WQ_PERCPU added to alloc_workqueue users
Date: Fri, 31 Oct 2025 11:59:39 +0100
Message-ID: <20251031105939.129200-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031105939.129200-1-marco.crivellari@suse.com>
References: <20251031105939.129200-1-marco.crivellari@suse.com>
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
 drivers/gpu/drm/xe/xe_device.c          | 4 ++--
 drivers/gpu/drm/xe/xe_ggtt.c            | 2 +-
 drivers/gpu/drm/xe/xe_hw_engine_group.c | 3 ++-
 drivers/gpu/drm/xe/xe_sriov.c           | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 2883b39c9b37..2ad633abf3b2 100644
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
index 7fdd0a97a628..84466be244ab 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -291,7 +291,7 @@ int xe_ggtt_init_early(struct xe_ggtt *ggtt)
 	else
 		ggtt->pt_ops = &xelp_pt_ops;
 
-	ggtt->wq = alloc_workqueue("xe-ggtt-wq", 0, WQ_MEM_RECLAIM);
+	ggtt->wq = alloc_workqueue("xe-ggtt-wq", WQ_PERCPU, WQ_MEM_RECLAIM);
 	__xe_ggtt_init_early(ggtt, xe_wopcm_size(xe));
 
 	err = drmm_add_action_or_reset(&xe->drm, ggtt_fini_early, ggtt);
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
2.51.0


