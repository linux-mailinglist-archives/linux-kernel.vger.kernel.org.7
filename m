Return-Path: <linux-kernel+bounces-886723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC16C36585
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C37566C07
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550BE335579;
	Wed,  5 Nov 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NX11r/Hv"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3843331A78
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355819; cv=none; b=TSOKsc1c21MUSBMrcbIaqLW2q7X/3/j8RV4hqWimQT2sk7B7cQ8Y+mbxw/Gz8VktflaAVCRkjJD+hvTWG8qPViEAr6tNQgXc/NugMFh76vMhEPwss0pHLKYND033PydQWILSEPqCCR4y8OatXAxTDi4CkBSI4/rLPlsP9e/1uCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355819; c=relaxed/simple;
	bh=8YeZygjza8/7gRfw/A9FL79bGlwhSzrkGSMfOyDO/R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6Zu8Y6SDBYwzstlyiIOa4oGZVXH6bhf/epI2kmxC9JY6fOOgGjaMYat9RvS8LUNkdkriFvqo2lVFwisa4zmdJJekdYM6DfYXlwAzn0Ry1bLf77UIpjAZey8xsQzyr7GFQZqboK2CopOG2zdjEv8lxHxNRRncBIBkNoIMPbxd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NX11r/Hv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47754b9b050so15048955e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762355816; x=1762960616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=26j0ekeJAt+MjPT8JhPGkZNYOpU999yhGjBkXTB65Qo=;
        b=NX11r/Hvp2U92XTzpGNXNfLPt5I28tLBPE6Hc2d/WnyIuinFRPqHYT1qypQLmRpgGO
         J377X2lmkcpyg16pIQjONq//XRWEk1eGFA7GxdZgtRDD6IFof9Te7DGbnzVIVZ03WWxz
         29fRO5HziVz4WsMgJ0aay9UkZVd6DRYpWAxzFuPVGc9pwUQA1rLBnSbXIPJ00kGcpSaj
         8W89HRzPWXFbto1H2DfiCzIL2YKF7gr1uJbkb6vUjkVI40e1tRRRjwcW8GfPEHiF0M3M
         8uNu3flLpM2dT2vYrlQcbALrgJ0CmBQgd9kujfECJS0VTJV4flNiFvy1v0AO+qyZq0sN
         YfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355816; x=1762960616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26j0ekeJAt+MjPT8JhPGkZNYOpU999yhGjBkXTB65Qo=;
        b=dCtmYjmYP7p+DT2UMEVV7kP4gwZSaqiSQj3LOK5yUXvDvp6zSSFLfiW5cqBN7APET2
         jF76JJYNdIL35ghGtaCMRdrAH4r4p+TwKV2sG/jDQwkeYfTeKLYbSoz9ONtxBjXPkd+H
         31iVzWyG41WQE6DR+z1LXpecdU1OhD/WtpgBpPxWtYBvoyt6cWqajV3ryS6+g7NQHiLd
         q68TO0KmtEjqNANe+pJ0AkqknyjYupHkQ2tYp+V9h8vNquucZFL/hIhTeOyZsqtAbU1K
         yYM6eaDaCQaptjGOETqn9kf0c/iIpuWO5KpS5qKo2w+sJ7sJuGKRCr8rLgwsQHbL2Y/6
         X9lA==
X-Gm-Message-State: AOJu0YyyTQAhrapZkB0bV4RH+1sjq3OxuiqwHLN/n3o5y2L2TtVbtsn0
	JDamdLcB4qIkEkynM4eYjNSQpXZqGUtpU+QpSfQ21uYMZ2w3Mj75VcPZlv/Q7YoCKmXFrBXoxiF
	1bjy0
X-Gm-Gg: ASbGnctYiWKgrk1qc/7kmFHvi160RKA7ssPBXm/EkvmtzhgQcNI//HCszEAfG6wYTHX
	gznZZ+5yn5VekM4k44UKBwe47ov/Wa7iNTQt7O0n5mX+OqMvTJjY7CLeDmmza2zqMfuTgfqFR9Z
	xYmlc2xdAj+qW0pVjN5hmfwoSlBjDR+6Zn1R6b5pbTeTrXLojyyGqCrjnmIuGXvOx1NF5rQiZRp
	PqGRKWUPZ81Z4ikoGSnsv6tawGT5QJjNgkLJ3YX70QA7Mks4mX7amopD8E6ieAUSyXcgjuzrSxU
	NboU+w5r8eF2OacOIL2EHqtP/fuNI3KG/BDycuVczmNJvYT9vZVCRWiHg12G5jd/zdv7Ya3ebst
	zwdH8iMlmvO0P+HQGin73Oj1smIiIhubSCqCHEOsg9U/gKQlIIqjBQ5eudgY0vI/IekTkgO2mAt
	R8fmr74rxoBwshPPtwKnFjOqM=
X-Google-Smtp-Source: AGHT+IF6f24h0/KL2PYW2pfErFRR5yf/pq/jG7ooPFf+nzfOgo7C0RcnE+SZ+CriuvilRfh56OZTBw==
X-Received: by 2002:a05:600c:524d:b0:46e:37af:f90e with SMTP id 5b1f17b1804b1-4775cdad6e9mr35742065e9.6.1762355815648;
        Wed, 05 Nov 2025 07:16:55 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cddf87asm53993655e9.11.2025.11.05.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:16:55 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [PATCH] PCI: endpoint: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 16:16:49 +0100
Message-ID: <20251105151649.256274-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Replace system_wq with system_percpu_wq, keeping the same behavior.
The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index ef50c82e647f..c787ce59d9de 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -638,7 +638,7 @@ static struct config_group *pci_epf_make(struct config_group *group,
 	kfree(epf_name);
 
 	INIT_DELAYED_WORK(&epf_group->cfs_work, pci_epf_cfs_work);
-	queue_delayed_work(system_wq, &epf_group->cfs_work,
+	queue_delayed_work(system_percpu_wq, &epf_group->cfs_work,
 			   msecs_to_jiffies(1));
 
 	return &epf_group->group;
-- 
2.51.1


