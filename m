Return-Path: <linux-kernel+bounces-890776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF4FC40E77
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE073B4063
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96F3331A5B;
	Fri,  7 Nov 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZPJ5zeTH"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E42EB876
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533488; cv=none; b=luLjg7d5AZTqDcss6L58RiKKmPvsufb1WIhir/KiGJw0lQs2ITBjnhAoGQhlJBL4AEHEnWCvqAsUqUUzqLZjEFfZR7yuUmpWjphmFl4Z9C7XIAsjTJahD0l855L9A2l3j27D/69WhM6a2wn0lZDlHimLz9NzK5wjAmza/fW/vkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533488; c=relaxed/simple;
	bh=ObBiW/8YCXdA1dM5PrOFNbQEzyxLGA+jF2pOcHIePO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oegvbx2Id9FKVCkZDP77Uu3LhdxPZD23WDrp00JP1bah2r+KLrZ9tQ/Eo27UwC9lCeUH2VzoSPdo3wgTX+yri2Xo4G7UzZbFlfFgbHgz5cZgotqA0xulj1zuwxB0fG33LQ/WftI1mLJTI/0xAGtqId0Sn6hpd7OVsLkxLykIwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZPJ5zeTH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47118259fd8so6920035e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762533484; x=1763138284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EnBuCPpYhDh8fv4mhQlI4A/qjc173ylRhxPi6cky5CE=;
        b=ZPJ5zeTHWccWjnxxJ/PDCUyAFVz+knqkiGEqKaMpFlxY9YQzh2c9G+QgNRyTzo+tAM
         o3TL0qgHYTF5KuYgb193Je4T12MIL2uoao8jVgGSa+4DPrWnIudtb8TPgG88dohOi6zg
         T1Z1aI/5sMgl8kjhJlMSG+73ajFz6QJ7JuGUQnTrFRwq4ZIDSZTAtf5NHkjm1zl399qj
         LcTyP2APV8Fh2NG0oR+MKKjN9YbRhqZ77yxhCnFfdfDYMKtco67S5RZPeHQS7SVemqyz
         pXM/Tm0YtmKf/ABN58CWrFQHnb9FEV8vC2EyKPo7HtvC3OYBb0NZSBiD9FCNF1k8KW6C
         P4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762533484; x=1763138284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnBuCPpYhDh8fv4mhQlI4A/qjc173ylRhxPi6cky5CE=;
        b=NjHbOfH7KpiwPBy1Jdj/tppv1vXev9ecmy0dbidMcISZhFsi+qosECsOa2x6ufCcFi
         OBlo9Id/EwRRAeXFBVMWkyNflIzeEvIXCgUoffg4zbfpEVseGz9I09UF0iLDDbQ5GwNK
         hasfw3lkllA2JzJW+aTpf+VWUxLbAaUgd8i5kIkE+jMp2jwS4mkJAvqUDLqakY3RH37v
         Ae8FsRGP4Wcs7/dm4spGPqyV/FSf1ZYyFSDENHC0zysQuN0o4IHPZSrqOp2Zro/C5iC6
         J8ORL2EQEiAao0caokCxTqAVGYg+M29uR1ETtRAzOm4v7FgLcqaMsegQroChd+wNRdJX
         /50g==
X-Gm-Message-State: AOJu0Yyyr8g5ax74tiHvrRae/jePUDxPr/p2uZ9AB2cc2r+azj4/wXn4
	QbNfjzEv5g52MUtX6LXsWbLUG9ZchZYX1D26wV1kZR3Zr75czGQgdnEP0TQ/R/oZmVihzo93lf4
	qDyYY
X-Gm-Gg: ASbGncvAIyfpwcy68iomGlv+7DeIBqlZkeZw42+yjhbJpPBYCJ5NZuchd/EWzel/mq/
	D1kWSYgysUznJHnHtaBKzkUHHf58whk2Nwb7c6Z3Mr+dWCXptGU/ARy27ueSr0cN81U/iqx31sY
	7REPHE4V13sOhrEKb0AqahQUmc0B/9yAfdwY3M0o02ZqJJpi9VcTB5WOrFkv9FZ6PlvOyDvccgj
	Z8fyLY8IbFcAoz/EcAnXBQWwkP1srYMYfafrCehc0oO5qxaoZZ5aDTek5+Qe8S/UAF29TjdhSbO
	A5njRMeMRzwrSxc6VMd362q0+S6VT0Q9xatcMmvBhEbCVm/zMyH0au+0dq1k4VP5GhuF8dtrKbA
	3BRimiPTr4AKOuI8nbkqygjzkD3jKo5YKNSY07u6l8TvCaKYfuh9EhE1b9IHtGsyPuvWwHnoVXO
	kdtXtgrHYdfbrg9GMYKs6uhDbc
X-Google-Smtp-Source: AGHT+IECbxbZLQkmYnlVg1E/TyKBdYaZDSl/1iDiNw/hya9tIrk5F9pIolGn42dVODz6JehBpLAjmg==
X-Received: by 2002:a05:600c:4f53:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-4776bc900e1mr34724655e9.15.1762533483846;
        Fri, 07 Nov 2025 08:38:03 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd08834sm58202935e9.15.2025.11.07.08.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:38:03 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Eli Billauer <eli.billauer@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] char: xillybus: add WQ_UNBOUND to alloc_workqueue users
Date: Fri,  7 Nov 2025 17:37:55 +0100
Message-ID: <20251107163755.356187-1-marco.crivellari@suse.com>
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

This change adds the WQ_UNBOUND flag to explicitly request
alloc_workqueue() to be unbound, because this specific workload has no
benefit being per-cpu.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
Changes in v2:
- WQ_PERCPU replaced with WQ_UNBOUND because there are no advantages
  for this workload being per-cpu.
---
 drivers/char/xillybus/xillybus_core.c | 2 +-
 drivers/char/xillybus/xillyusb.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_core.c b/drivers/char/xillybus/xillybus_core.c
index efb1ae834265..fc4e69b5cb6a 100644
--- a/drivers/char/xillybus/xillybus_core.c
+++ b/drivers/char/xillybus/xillybus_core.c
@@ -1973,7 +1973,7 @@ EXPORT_SYMBOL(xillybus_endpoint_remove);
 
 static int __init xillybus_init(void)
 {
-	xillybus_wq = alloc_workqueue(xillyname, 0, 0);
+	xillybus_wq = alloc_workqueue(xillyname, WQ_UNBOUND, 0);
 	if (!xillybus_wq)
 		return -ENOMEM;
 
diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 45771b1a3716..386531474213 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -2163,7 +2163,7 @@ static int xillyusb_probe(struct usb_interface *interface,
 	spin_lock_init(&xdev->error_lock);
 	xdev->in_counter = 0;
 	xdev->in_bytes_left = 0;
-	xdev->workq = alloc_workqueue(xillyname, WQ_HIGHPRI, 0);
+	xdev->workq = alloc_workqueue(xillyname, WQ_HIGHPRI | WQ_UNBOUND, 0);
 
 	if (!xdev->workq) {
 		dev_err(&interface->dev, "Failed to allocate work queue\n");
@@ -2275,7 +2275,7 @@ static int __init xillyusb_init(void)
 {
 	int rc = 0;
 
-	wakeup_wq = alloc_workqueue(xillyname, 0, 0);
+	wakeup_wq = alloc_workqueue(xillyname, WQ_UNBOUND, 0);
 	if (!wakeup_wq)
 		return -ENOMEM;
 
-- 
2.51.1


