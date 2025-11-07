Return-Path: <linux-kernel+bounces-890573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D2728C405F3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D78D34F3E4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D40B265623;
	Fri,  7 Nov 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CE+rONLp"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E22ECE9D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525880; cv=none; b=PCxRZCAvVJUoZB0dAftkwe9UOslK7jvFjMuf0ohSynn0g7B3DP1x6P+PXOfoF0eDywyPTamVj4kHumX56j3nzpEwygxthwflNFktH2lvnqTqGBlFNN+Nq8eHskTZigGnFTVjIHN9xLT3b7jsmElLHKin2hs3EU1FXIx9clyxdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525880; c=relaxed/simple;
	bh=cSdDnIXxswzbdqa2gav6B3GuVmFeRkspqdWD/8dhg5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mFAJ/RIJldXsNHTkCOKb2Q8YHPFiD6T9jA8nGZVzst6E+QzWiPsHceIbgQGc1QbKeGi5X7hA3dFLUHRI80dnhn2mcH8SN2d22J2V4dZ51QtxWHbOux4Qsv2MI3rCUK7+jM5i29ii7nQyddj/NXyMWTWjeJdDucj+lOlKZOrO/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CE+rONLp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so4528935e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762525877; x=1763130677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUBmSzOMW1hVmBvLVfhS6unxv5YlCb/+J2qrVLMEhjI=;
        b=CE+rONLpD5X7mbnF4JMh5VVhIeZ85Z/nRhUVIxDy3k17s1C2rsXJsA7noCRQRvVNVT
         gk9uS9IDoOkEI34dJjSTcRdkKscfGMl/erD9cqTg3l3G2eS32w4WwE1kstF95LOjNPu2
         NMjGb4oyc9irAyC+rNhoBLkSVD0xyrPB9ub7ivovW3Lpa6dYBKWJzzfIbOGVjqRosasO
         nrimhCt/M4jHLyQIHf55ThQZZWWbC2nfSZJIJ8SjKJSfSQiXQjukxJdz0f+W/ED+BtSJ
         KskOjSZ3lIg+Me2thlTvC/GKd6l1yIhvP0NUHSvypEe9QsQajg3xo5IvvFZQHDjpgBkV
         gnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525877; x=1763130677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUBmSzOMW1hVmBvLVfhS6unxv5YlCb/+J2qrVLMEhjI=;
        b=FdOC1d1UAnZ/mN8El29jYQQaW34lZsdOqsx65Z4/+I++pMm9cwAqsfmK4BvLxOm1HX
         Yp4EF92MkKsoAO7+pLPsjw4rzjldH+Rpfyc4o/djho6DHwU4SB5oViiA763LKr4sWf+d
         4hSn5loao+nH/IZukVwxWcdto9xerHhnFyU+pr+NhQN+DeneskBn9ADFnnfZOxPc1sCN
         V793wA5FSGdNqg0yOS/cdWS4yAKsPZY7YQeGotpvaQ9mtnec/CPN4x9AMX7YDR5tv0IS
         wdbr/q3cyzYnKmZNUWmLeXm/+66elNIzsN+5BafN++XsGEHEpfrxmbWb2JnBLm3fIg/a
         8KBw==
X-Gm-Message-State: AOJu0Yz9Y479z4FMkhEjB3LtTF3txEBBZUX8zg5rJPvENs2a6P6CQbVM
	o9PYCcQcQInEpqqcwWEY0RJgGFbpT7dA/JqVbNhT89QLdyVmRuTGeANpTpFoQ0yLDww8o5YXIIK
	rkRfo
X-Gm-Gg: ASbGncvRBDLIugIC6SehVIqOdwy3JYZa+8GfL7wdy0tHcyg3l2F4DlEclpjud/COVgv
	zZSDGXUpAqEd6LJCnIuj3aarEPLAD1oDyOoLURhOcbFHhaQB4+cVQ6MT0ubJAXHW+8+Zw3z1QXp
	W2429YInZPPLTFsgFFl6lnq729KRqIqBoKM6RkZ5ZCwiypbHxnM2JIQZLIYbt0eMo11DloieYuv
	TF0VzUPOYcPzlBUnXms7XytUhD+godB4fI6FqC8sDtOjJr23BLopTxWguFEszDXIONQtY6RyiKN
	mbLFqsV61Q9uTbRzseZIlJb+uy+lC4eTuZ2p9uxZcsBJGELqUxpDU08Lrn95W0K3Sn03+uv9HYr
	Wxeh4w1bRTtYnbd5zQ3waMhx7xmXEaMqvxUVwgryvLdIYUE2avqTvbbB7ebibZksE7fcaQVF5cN
	Fr5F2Zs424GuPc+LiQjE2PhIL1b9xYKO8u+y8=
X-Google-Smtp-Source: AGHT+IGSY6yDLTu3hRcVf/k/pttfkC0OQRPyNDQ0Wl+wJKGkdFmqGU/QfjbxpsGop8pwcaivmOt2vw==
X-Received: by 2002:a05:600c:a4b:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-4776bcde4d5mr31145925e9.29.1762525876714;
        Fri, 07 Nov 2025 06:31:16 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcfd2e5sm52355795e9.13.2025.11.07.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:31:16 -0800 (PST)
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
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: endpoint: pci-epf-test: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:31:08 +0100
Message-ID: <20251107143108.240025-1-marco.crivellari@suse.com>
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
 drivers/pci/endpoint/functions/pci-epf-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 31617772ad51..46e684c0e496 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -1188,7 +1188,8 @@ static int __init pci_epf_test_init(void)
 	int ret;
 
 	kpcitest_workqueue = alloc_workqueue("kpcitest",
-					     WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+					     WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
+					     0);
 	if (!kpcitest_workqueue) {
 		pr_err("Failed to allocate the kpcitest work queue\n");
 		return -ENOMEM;
-- 
2.51.1


