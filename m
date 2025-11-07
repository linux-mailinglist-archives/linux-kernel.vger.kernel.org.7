Return-Path: <linux-kernel+bounces-890554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43029C40548
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE6D3AA228
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04E6322C8A;
	Fri,  7 Nov 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P32fnPGZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D691328B6F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525536; cv=none; b=udI9AitiAWtR0/AuiZ/ih/947Jd+izfqHeopWYuHyaNea/HVmh5hjcmMachWYOYPTMhK91f00Yr7w9q+Ux7Avm80pTIGE5vvixJuXWuNfdeRDW0WDkRhE22zErTVgkCq1P6juLUd8cgoTZM2fnl70S9QUhE/Gb4pYilWmFavf0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525536; c=relaxed/simple;
	bh=HaeGIdJqZ3psFf94Qv9C1pxEkuWWM5yYs+Xoo/xY/PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z76okO1GppWEYTvLGNIj1H3ngj02M/lhKoRRS/ot1x0VZYmf/EpKrBdL2sWCY1beG/bE3od6BEBIFeH+tpUnYpdbFQS+4AHDVTH133AGbedTJb0aNpQ8vFImo51lOE5z+y5ZGIaUHDuGKVoG4kmonZLCVCavF/YyXeV5BwBM8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P32fnPGZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47754547a38so6643205e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762525532; x=1763130332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRZZPRDUZ7lRY76avfLnVO53M//uu4xgze6C2tCsP8I=;
        b=P32fnPGZZ6DexatQm71Xl+1n2r0hUftSkW5k/KJkParcNMncTdoGMkeAbF7KfKJpdN
         0ZEMfIE3Ymce/JKbjRZZ3NtNYwzpMxuCLZVOgTbwigGOy7xVMgdmZcf3OhNWgUHFvx9k
         Omn5D7VMz+3KIpd8MSEOngwMNKCX5KW88blF9KTypxxhXj9eftlvOS1drNyFKwRpEs1C
         aSteINAHCO1fxN5opJKh1JYB3lIWWjbjlBRn+niNqbI8pjbELwcrVY48C5Bxw8vSwPKi
         pLFxW8Bk/NRVAHWDn6qnbRLosi2Dk+ezvyjP6is/+BcA8LvTgkP1bPVVTHGBoPoXUc6b
         x7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525532; x=1763130332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRZZPRDUZ7lRY76avfLnVO53M//uu4xgze6C2tCsP8I=;
        b=YA3dGndocc+m20Uv/Nrrm670x4e3oDxQy5UciFOrHS3GBMy84xwmKZwigS69mohus6
         BqXm7g1tO8xCy/mUIMXBkSk/bPcwvtAIR+IwfD50YxDLejA4Nc2hjSMTcEfn2idNSdkD
         fKfFEN3JoWHcYhZMXAD87J8qm0ccXYOyNtXM2qOgBXT+SdgY1g0txNWjEJtISo6VnSQ9
         2SU52BuWr9ok7OAC9a/BxJApgX0GDAkqTgza5DdGXDg5oAKU0o5o6JV5fO8S591dXk4B
         RWM+Cp7PXU8L2Amx/tw31sDZf8WpG0DKP4rmk0s3178dkORGF1C5jv/GAowTAsvZdYxY
         lSVw==
X-Gm-Message-State: AOJu0YyacGT8xnlxyfzv+8Va6lX/Ex4kHkzDgFnE8OvajmxEhs01cSPE
	8PfiyxI71rnh39Q5IEiPfURXYysWpi/Uy2mllVgYLwRJ490fgTBZpEm2Jtuu3p3dtNzgelyFjIf
	scxDE
X-Gm-Gg: ASbGncv7V1+vrvggx8heFS0Buy64+NSwHZ4kjfdE7sjBxQR2apq+8WbrYTa++LnKkZy
	akfuuYlke1MOe/2v30Mvy0P3S32hphajGCUZ9MYRfmhEaf9qXaCBRkt6hR8nj4Kr3gPL0EBRjar
	Y1sTP7wWn+y0V8xP13/BENQaUx2Snh7sluJTDDAWVGf9Lh1/Oh4axP/w9Qnb+/IRcvFKlusbWI/
	Os2hSHlAZ5O1Dk4YKx/3/E+KsVyLCrEx3pRvumTjWmtdwCkOpcmuKm91Pl4Rh1/CxheaR0ZOA9u
	z9pIutsLiL61mVj+eeArAqRJ/7N2LBYROMuqG3s0gGe3QDfUwvG/Ay6AuyY8xN8y6Wc9NNQe2sI
	lbqU+1qZXJ1JhjySoiEw3W1hotx3VNJhad8FfUh2atgcnkC1MdrlgWjKoRGrlO+rMI0juv7WC1Q
	VIyuma4Ode37O3DOeLYt8s+2Yk
X-Google-Smtp-Source: AGHT+IE/swO0ECBwSKu80fX22MXr+gJKhInlEKy4hccqPn7CHjNPtGTEl1myfo6pa29cT5DzIn1ZtA==
X-Received: by 2002:a05:600c:4508:b0:46e:394b:49b7 with SMTP id 5b1f17b1804b1-4776bccec42mr29103625e9.37.1762525532165;
        Fri, 07 Nov 2025 06:25:32 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcd51dfsm50624375e9.5.2025.11.07.06.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:25:31 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: endpoint: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:25:26 +0100
Message-ID: <20251107142526.234685-1-marco.crivellari@suse.com>
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
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 5 +++--
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index e01a98e74d21..5e4ae7ef6f05 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -2124,8 +2124,9 @@ static int __init epf_ntb_init(void)
 {
 	int ret;
 
-	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
-					    WQ_HIGHPRI, 0);
+	kpcintb_workqueue = alloc_workqueue("kpcintb",
+					    WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
+					    0);
 	ret = pci_epf_register_driver(&epf_ntb_driver);
 	if (ret) {
 		destroy_workqueue(kpcintb_workqueue);
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4..162380ca38fb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1532,8 +1532,9 @@ static int __init epf_ntb_init(void)
 {
 	int ret;
 
-	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
-					    WQ_HIGHPRI, 0);
+	kpcintb_workqueue = alloc_workqueue("kpcintb",
+					    WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
+					    0);
 	ret = pci_epf_register_driver(&epf_ntb_driver);
 	if (ret) {
 		destroy_workqueue(kpcintb_workqueue);
-- 
2.51.1


