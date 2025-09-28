Return-Path: <linux-kernel+bounces-835539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B874BA7691
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906E41896678
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF2125CC42;
	Sun, 28 Sep 2025 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GV3GfVZm"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51525B1E0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086465; cv=none; b=I+cY/6yMCDSkka7jv2fZ7LXzXntzQhzmW/JluNwraDt97PGEbhF1wxg2td3g7nv/qwP1upxtpJd/KyOLwe/yTSDelS8JbHcJU7th0gMb1+vQV7dcNseKhciCENsfEL7+w3qELMMIG/0GzqvSqFH7JpEacqhsrx6OS8gQX+X+8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086465; c=relaxed/simple;
	bh=K5fHpHWFykCx8GSNl+bRBubKB+z9YJLFyN3qkeQz+gs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B5mST3ipSnkLfgA4gZkPlGsyC2DTT5bC3fT+nOaVSkblyjd08x9aMBuUFPEdwDEHvdHvFjss+Tsl47a24QcZm9lRwWaH0+16b2/bHDnHRxW1XgVLKuzOyycPuXyM9Q+NC4Yxf8KYWBdfFns7cdBmrcV+Lg2WKk/xsWuh9ioT3lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GV3GfVZm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2711a55da20so31851565ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086463; x=1759691263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCuO86qV7dZm/aG2Dppf5kSqYkYatsl7iuzcTQdCTDQ=;
        b=GV3GfVZmiepgSw60vYBkuo+4Jn3eNhSgmv3tBMkqRH2UVbzxuSlGsuNAtxwQ8tNWWE
         6i1GxecoVWL3geLV6e+5CmfpgrcyaRE1xqXm9zmnXVaVDFsC3agyJ1bicltByYQSMglM
         YR8b1jk17xvmdnysYEBB1ZCwxzHCbYXECXcE2UM5hKW2bOpIAyRMKvCIPF3nH/V9UlcF
         E0RjZxk4bxGplmtba2ASH1bPc+rySRLRzJTerh/r6N/NbcZW1cDm58y3/mc90q/VWtF3
         l0C5YSp2wosgbQyqfkioCt7UyLBT2jL6HbICwjDd5tCD7dYKVK00fAQjcLQTywbwAHwU
         2NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086463; x=1759691263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCuO86qV7dZm/aG2Dppf5kSqYkYatsl7iuzcTQdCTDQ=;
        b=aRLsf9aPFs4KxrrLcwFE7sRYph0FTWn3A1l7aYsQW0jH++bZEgnrvbDe9vgsUj9oDh
         AXOg3jUPd+Udn90aQQ3OxPTf8FGX6x+39dF/jcPXicPjOkkq5Duy6/K3dCHrWi8BaVRL
         BvqCIIhA9NeDsXpZl3TgO5SMGdDnAhRtuanW48voSG4yElvpu8Cjl7j5lDr2hfTVczHZ
         nqA0W2G3SInnZJ68eBtdMe2O6MJLzvH74cxpaXxNvmaI86uHFdTw/1j6CBREj2IPeiHl
         KfS/o2uuUq7spx/GmiPGbNkBd5RqGQGo1Qjh2bojfbbK4o6/73RlVsrMvzi6u6Ic46Dh
         3kJg==
X-Forwarded-Encrypted: i=1; AJvYcCWBPX8DqVepg/E1J22EODHF85hiOUaPzqtOaurWgz+IPqEeDXl4nRHDiC47U74cy0IzXQ4n0UiyMOIMFpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGBIEVilDUVg3TU23nD8dPQyKDpDtbZGs8TmYYElAlDBsIpdT
	sIeUBRFEL3WtBIg5TGol8mouMtHhVtErrDFaOHQZ0Fxyk5+eb7VKQzgz6KItx8zwFy/TxFCCc5b
	7PoH5LTRa8ue61g==
X-Google-Smtp-Source: AGHT+IGpJ49K/7HkT1GORRMDUMXXC7GDu2XGPfU5JdrnHAHFnDeqzWXWkVU/StxzhY59C7N/ChZl6seiFoS9WQ==
X-Received: from pjbaz14.prod.google.com ([2002:a17:90b:28e:b0:32d:e264:a78e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d2d0:b0:25c:b6fb:778 with SMTP id d9443c01a7336-27ed49fbbd6mr146672005ad.14.1759086462824;
 Sun, 28 Sep 2025 12:07:42 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:09 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-2-skhawaja@google.com>
Subject: [RFC PATCH 01/15] iommu/vt-d: Register with Live Update Orchestrator
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Register Intel IOMMU driver with live update orchestrator as subsystem.
Add stub implementation of the prepare, cancel and finish callbacks.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                      |  2 ++
 drivers/iommu/intel/Makefile     |  1 +
 drivers/iommu/intel/liveupdate.c | 45 ++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 drivers/iommu/intel/liveupdate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index baeda8a526aa..e038cdd6aa41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14228,6 +14228,7 @@ F:	tools/testing/selftests/livepatch/
 LIVE UPDATE
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
 R:	Pratyush Yadav <pratyush@kernel.org>
+R:	Samiullah Khawaja <skhawaja@google.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
@@ -14235,6 +14236,7 @@ F:	Documentation/admin-guide/liveupdate.rst
 F:	Documentation/core-api/liveupdate.rst
 F:	Documentation/mm/memfd_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
+F:	drivers/iommu/intel/liveupdate.c
 F:	include/linux/liveupdate.h
 F:	include/uapi/linux/liveupdate.h
 F:	kernel/liveupdate/
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index ada651c4a01b..58922d580c79 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
 obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
+obj-$(CONFIG_LIVEUPDATE) += liveupdate.o
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
new file mode 100644
index 000000000000..d73d780d7e19
--- /dev/null
+++ b/drivers/iommu/intel/liveupdate.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#define pr_fmt(fmt)    "iommu: liveupdate: " fmt
+
+#include <linux/liveupdate.h>
+#include <linux/module.h>
+
+static int intel_liveupdate_prepare(struct liveupdate_subsystem *handle, u64 *data)
+{
+	pr_warn("Not implemented\n");
+	return 0;
+}
+
+static void intel_liveupdate_cancel(struct liveupdate_subsystem *handle, u64 data)
+{
+	pr_warn("Not implemented\n");
+}
+
+static void intel_liveupdate_finish(struct liveupdate_subsystem *handle, u64 data)
+{
+	pr_warn("Not implemented\n");
+}
+
+static struct liveupdate_subsystem_ops intel_liveupdate_subsystem_ops = {
+	.prepare = intel_liveupdate_prepare,
+	.finish = intel_liveupdate_finish,
+	.cancel = intel_liveupdate_cancel,
+};
+
+static struct liveupdate_subsystem intel_liveupdate_subsystem = {
+	.name = "intel-iommu",
+	.ops = &intel_liveupdate_subsystem_ops,
+};
+
+static int __init intel_liveupdate_init(void)
+{
+	WARN_ON_ONCE(liveupdate_register_subsystem(&intel_liveupdate_subsystem));
+	return 0;
+}
+
+late_initcall(intel_liveupdate_init);
-- 
2.51.0.536.g15c5d4f767-goog


