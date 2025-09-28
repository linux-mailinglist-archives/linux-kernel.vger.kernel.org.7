Return-Path: <linux-kernel+bounces-835545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9794ABA76A5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1471896894
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB95261573;
	Sun, 28 Sep 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NM9vtxBT"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8452652B4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086473; cv=none; b=o1NR/fUmiQmAHuMHf37V/AB2EbJiPUYJIIi+c7h0LlmCGL/Of5HuaM5TBWY82KCDYdZwfsRozTizgQaBOpkLCDUbcz4h6iGYYBpU5Pmfit9jsP4daT3KJd3t5zYFA8p50pjnPDm/BPSXcToT9uF5wRMvMr1Kc93Nzz4NUcnVyGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086473; c=relaxed/simple;
	bh=5afXYIp78DkALWn3sB5Jmp4qKGsGM5Fm7+lS4mnhcaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qtI2I9PTIGZ+UyqChoCKKV8Hg8wlmBOSPXbmnyYe3I4QVF0CZXO8rPnzPD71p5NWFG6dGxoXmIZVV1Lvw1VbFW3NVXyDtAL6vqHQ909fMaPV4ImWyN4lVbvANw97mK6ci/3eSXULhcg61umc988eFBqea1bFXuvEFTI7WLQxDcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NM9vtxBT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b55443b4114so2583695a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086472; x=1759691272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vsU7Kqlniap8aOZDcuZtGEaTcQ9taaF5KqlzYc+vBSw=;
        b=NM9vtxBTRIiCTVTmD8vMWdvEgg94ehiga03k+AWltTWXb4/mHfpZWoTvb91PulV7Vz
         hbU+K9kwEbIIZY5v3wejyDn1jB37TWHPJ1EIxIkSwxcxM4vqTfH5Z2pddSuLIfbxcRhD
         H62IOOmeytSdH3fExu8sITvGnAveSI+zkus795PcobwbyhHnoa6Sinbw+iL/Z1e+dPlq
         BWr4gkLvJ1XPzw7F1Ikz0fTZ0FCMBMcWMJ3UVu4OY0UINe3mY0G/C9UW+dKaSowlPMk7
         1zIHkmSpy1h22KRPz0wg1VbB/GgwucGm9DFz76lWUuVoxLk5gld2Fl0/j5QVn0WVhaoh
         A2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086472; x=1759691272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsU7Kqlniap8aOZDcuZtGEaTcQ9taaF5KqlzYc+vBSw=;
        b=EM3m6tteCMdvPxeiH2btY95Mn+y96lVo7KVk4Wf1/ndmu/vLBK/UBzEinQGgVZjHfF
         IsczXgqft9qGnsnzxES3aNPhWqos0cbhiLAeAd2qj1E5XVTkmLsrNfxbAxhPVuJtKZtQ
         75THdq+o/9G4rqp8ooCfyltFatsy+7KLhRKftS6MRebH9paQfjjpvr1oam2esWLiyEEd
         +TtvA/OTDNmKzK3zKyIma7DfDkJlt8YZYxpcule/Hvd0xxw65ICJloUpq9DjNiXb/lI7
         vl7dJw7HRTJ+lX+oACGHOhDFeOoS4KvURKsKBsGcctfXA+yX8MU4Oic59eugK9GWPQO6
         q5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHxYqX8CgEvBvrCcZE31eWy0DkhZdsQMktTzJ7HwyFrYGnw/9H0yQin0zvJPz6RtzdOUkZwuhwnAISiT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwNBxYSgCZJ7bUqzUc1+gMr8geugJMQ4XV8U6JiEbBH0ujaiV
	s3/jshYT7HJGBfc+v6WfUiu021iFLy4x3icR8CptUDxXJxbrhmRuAuG4be3daKA7iXovsMfkwwi
	YlWLxETc+JeLWIw==
X-Google-Smtp-Source: AGHT+IHfdirlJBqh06AiPWU9gZRM34sOyCYlhqLwriEV1slCgLDHGPkpGuA/w9oi9uxQsxmHSL03/Is8uy3WGQ==
X-Received: from pfrb29.prod.google.com ([2002:aa7:8edd:0:b0:772:749b:de38])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:6d1a:b0:2f9:dc8d:d2b3 with SMTP id adf61e73a8af0-2f9dc8dd5e4mr5325467637.22.1759086471611;
 Sun, 28 Sep 2025 12:07:51 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:15 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-8-skhawaja@google.com>
Subject: [RFC PATCH 07/15] iommu/vt-d: Add implementation of live update
 prepare callback
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

Liveupdate prepare callback preserves the iommus of the devices that are
attached to a preserved iommu domain. It does this for only pcie devices
by iterating through all the pcie devices and checking whether the
attached iommu domain is preserved.

Only stub implementation of the iommu and device preservation are added
with this commit.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/dmar.c       |   4 +
 drivers/iommu/intel/iommu.h      |   3 +
 drivers/iommu/intel/liveupdate.c | 150 ++++++++++++++++++++++++++++++-
 3 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 248bc7e9b035..cd6ce519c1da 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1101,6 +1101,10 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	ida_init(&iommu->domain_ida);
 	mutex_init(&iommu->did_lock);
 
+#ifdef CONFIG_LIVEUPDATE
+	atomic_set(&iommu->preserved, 0);
+#endif
+
 	ver = readl(iommu->reg + DMAR_VER_REG);
 	pr_info("%s: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
 		iommu->name,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 6b69232efffd..93ac55eb49f0 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -758,6 +758,9 @@ struct intel_iommu {
 	void *perf_statistic;
 
 	struct iommu_pmu *pmu;
+#ifdef CONFIG_LIVEUPDATE
+	atomic_t preserved;
+#endif
 };
 
 /* PCI domain-device relationship */
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index a15feef4d9ca..94aabf025a60 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -6,24 +6,172 @@
 
 #define pr_fmt(fmt)    "iommu: liveupdate: " fmt
 
+#include <linux/kexec_handover.h>
 #include <linux/liveupdate.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 
 #include "iommu.h"
 
+struct iommu_unit_ser {
+	u64 phys_addr;
+	u64 root_table;
+};
+
+struct device_ser {
+	u64 bdf;
+	u64 pasid_table;
+	u64 pasid_order;
+	u64 iommu_phys;
+};
+
+struct iommu_ser {
+	u64 nr_iommus;
+	u64 nr_devices;
+
+	union {
+		u64 iommu_units_phys;
+		struct iommu_unit_ser *iommu_units;
+	};
+
+	union {
+		u64 devices_phys;
+		struct device_ser *devices;
+	};
+};
+
 int intel_iommu_domain_liveupdate_preserve(struct iommu_domain *domain)
 {
 	pr_warn("Not implemented\n");
 	return 0;
+}
+
+static bool is_device_domain_preserved(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
+	return atomic_read(&info->domain->domain.preserved) == 1;
 }
 
-static int intel_liveupdate_prepare(struct liveupdate_subsystem *handle, u64 *data)
+static int preserve_device_state(struct pci_dev *dev, struct device_ser *ser)
 {
 	pr_warn("Not implemented\n");
 	return 0;
 }
 
+static int preserve_iommu_state(struct intel_iommu *iommu,
+				struct iommu_unit_ser *ser)
+{
+	pr_warn("Not implemented\n");
+	return 0;
+}
+
+static void unpreserve_state(struct iommu_ser *ser)
+{
+	pr_warn("Not implemented\n");
+}
+
+static int preserve_state(struct iommu_ser *ser)
+{
+	struct device_domain_info *info;
+	struct pci_dev *pdev = NULL;
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	int ret = 0;
+
+	for_each_pci_dev(pdev) {
+		if (!is_device_domain_preserved(&pdev->dev))
+			continue;
+
+		info = dev_iommu_priv_get(&pdev->dev);
+		if (!info)
+			return -EINVAL;
+
+		if (ser->devices)
+			ret = preserve_device_state(pdev, &ser->devices[ser->nr_devices]);
+
+		if (ret)
+			return ret;
+
+		atomic_set(&info->iommu->preserved, 1);
+		ser->nr_devices++;
+	}
+
+	for_each_iommu(iommu, drhd) {
+		if (!atomic_read(&iommu->preserved))
+			continue;
+
+		atomic_set(&iommu->preserved, 0);
+		if (ser->iommu_units)
+			ret = preserve_iommu_state(iommu, &ser->iommu_units[ser->nr_iommus]);
+
+		if (ret)
+			return ret;
+
+		ser->nr_iommus++;
+	}
+
+	return 0;
+}
+
+static struct iommu_ser *alloc_preserve_state_mem(void)
+{
+	struct iommu_ser *ser_ptr;
+	struct iommu_ser ser;
+	struct folio *folio;
+	size_t sz;
+	int ret;
+
+	memset(&ser, 0, sizeof(ser));
+	ret = preserve_state(&ser);
+	if (ret)
+		goto error;
+
+	sz = sizeof(struct iommu_ser) +
+			(ser.nr_iommus * sizeof(struct iommu_unit_ser)) +
+			(ser.nr_devices * sizeof(struct device_ser));
+
+	folio = folio_alloc(GFP_KERNEL, get_order(sz));
+	if (!folio)
+		return ERR_PTR(-ENOMEM);
+
+	ret = kho_preserve_folio(folio);
+	if (ret)
+		goto error_preserve;
+
+	ser_ptr = folio_address(folio);
+	memset(ser_ptr, 0, sz);
+	ser_ptr->iommu_units = (void *)(ser_ptr + 1);
+	ser_ptr->devices = (void *)(ser_ptr->iommu_units + ser.nr_iommus);
+
+	return ser_ptr;
+
+error_preserve:
+	folio_put(folio);
+error:
+	return ERR_PTR(ret);
+}
+
+static int intel_liveupdate_prepare(struct liveupdate_subsystem *handle, u64 *data)
+{
+	struct iommu_ser *ser;
+	int ret;
+
+	guard_liveupdate_state_write();
+	ser = alloc_preserve_state_mem();
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	ret = preserve_state(ser);
+	if (ret)
+		unpreserve_state(ser);
+
+	if (!ret)
+		*data = __pa(ser);
+
+	return ret;
+}
+
 static void intel_liveupdate_cancel(struct liveupdate_subsystem *handle, u64 data)
 {
 	pr_warn("Not implemented\n");
-- 
2.51.0.536.g15c5d4f767-goog


