Return-Path: <linux-kernel+bounces-835548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A9BA76A8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6BA1796F8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878EB27147C;
	Sun, 28 Sep 2025 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCb+BYW5"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA326E17A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086478; cv=none; b=O4OR9yU/CQt8ZTJ5ZOAOdB+mr+rQ4Ar/truwFpy0bNUQTqcXrNDBJ7eMxTps4CMiuaUGl+dYj3cWV2H3PgGvSoxyFCzCFKQszJBYv1SnnqnQiP4sEoKjUrbqtzFKVHrVZqO2BxxQcBofK/uMb5VI1V02vXij1V2o9J6mk3LqIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086478; c=relaxed/simple;
	bh=cUNulnp9gxtOtkG7ryVsF75CYtxVqmeKGRtBY6UQkRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iO4D8+/h2/a6ngNWmcTsUzQYekuIKLDjUyd2amoGctPcIRWiTTKZ7AsZFKrYrxqggutVLrGtK4k3ApuZ9tfmI080FUSn8BtoJ3NnsncfqN/IKpG39T89ZZXN249ofd3iP24BXquhtukHhsjM/iBQv1+v+bZjIgUwC93wtjtnNMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCb+BYW5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7811a602576so3398812b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086476; x=1759691276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DoORliUGK7lTSGlg4cqnmqfBZFAdVY0fHhO98K40Ca0=;
        b=bCb+BYW5dM93jC5Kc8VWJr0MyXKxaX+m/AFsTOcPn5dcz58vt5QlN7wLO9CyPxDHm5
         MLI7pG0MGf5lNe6HOfjTEQ2ad5NORHB6K74jOWfcAzV0t6X0P2WV3/cpC79FYWaSfef9
         A4BDv5TvmWdrnd/HMf4eB0ra+QsLM+Z2DZaWvhxmcK2myaOmfwO88G8mlppE2XkOYI1t
         gNI/B+QJDlKpe24+oWCSAIvXgpXP4xq+e15xeQpRdU1p66HYXlYDXsHN3lqNmHSPgWlV
         qONHCyjOwjCL760IewZw3rxmVlfUqWYUzGEJU59DiG8jOgLNZIFvHh+qHcyts40sZaMn
         u+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086476; x=1759691276;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoORliUGK7lTSGlg4cqnmqfBZFAdVY0fHhO98K40Ca0=;
        b=KYbwUZR89NUFnSXaWRBzkYebjcbP+F2OuRrAgDeScgfB/7/OEVAPWNSu6crAjhZbEo
         3r9YJCpysiJ0A+Jz16QnsERyWe7hV2IzTVXmZiDD5SgNegJGhsYJJXeBgUjY2iB0N5OL
         zeD8v2K/a6MkNrK6VUYas+DDemA0wVjOMXv47JApbGePmwryFyKzrvZMh6LphvxGXNsq
         tZUPus9/jysrUlkAwIKF+j1O3POOzBT9kK+Wea3tYBRMZvj/73FVEi4tjRjq2AuBatCK
         K7VAPRaEY8TPueODfItazurXPYLB5JtMDQMm6Aqq7kjmRur9JwnuxCfrGr4Of48vRRjR
         PhPw==
X-Forwarded-Encrypted: i=1; AJvYcCXquyJUEgOYzTNXzd5D977gOeiPBaypTbz4gEdbCeEelLY89x6upO1FNeQyeDVyZlZHv9k4e8fokISGTZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LmjSYih1n4bKIrFooYAfgpao1PGNNsyEzCIRmrUXt7OVsOrI
	JiwJ4UsaSwL8k3kgsmtm9OW15jxyYa4JvgC/ha/OTBoNgHZwnW02jL/NnjhlKhfszqhQEbtu0MP
	QxE7okdkOjU7lxw==
X-Google-Smtp-Source: AGHT+IFLhnnoCDxarwczs9atmxqzu3Xs3uCyHPAxyqgbhg5fCT67/boDgPD+SbYpcL4XGVurMCxpUaxVyD6jzw==
X-Received: from pfux37.prod.google.com ([2002:a05:6a00:be5:b0:77f:24f4:40f7])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3906:b0:77f:40ce:9c4 with SMTP id d2e1a72fcca58-780fcf12f65mr17541869b3a.32.1759086476439;
 Sun, 28 Sep 2025 12:07:56 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:18 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-11-skhawaja@google.com>
Subject: [RFC PATCH 10/15] iommu/vt-d: Restore iommu root_table and context on
 live update
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

During boot if the live update state is updated then the iommu live
update state needs to be checked to see if the state of any iommu
hardware unit was persisted before live update. If there is preserved
state available for an iommu hardware unit then restore the root_table
and the iommu context from preserved state.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      |  7 +++
 drivers/iommu/intel/iommu.h      |  1 +
 drivers/iommu/intel/liveupdate.c | 92 +++++++++++++++++++++++++++++++-
 3 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index caac4fd9a51e..245316db3650 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -984,6 +984,13 @@ static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 {
 	struct root_entry *root;
 
+#ifdef CONFIG_LIVEUPDATE
+	if (!intel_iommu_liveupdate_restore_root_table(iommu) &&
+	    iommu->root_entry) {
+		__iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);
+		return 0;
+	}
+#endif
 	root = iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K);
 	if (!root) {
 		pr_err("Allocating root entry for %s failed\n",
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 273d40812d09..6119a638c530 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1351,6 +1351,7 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
 
 #ifdef CONFIG_LIVEUPDATE
 int intel_iommu_domain_liveupdate_preserve(struct iommu_domain *domain);
+int intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu);
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index a7d9b07aaada..755325a5225c 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -253,9 +253,11 @@ static void intel_liveupdate_cancel(struct liveupdate_subsystem *handle, u64 dat
 	pr_warn("Not implemented\n");
 }
 
+static struct iommu_ser *serialized_state;
+
 static void intel_liveupdate_finish(struct liveupdate_subsystem *handle, u64 data)
 {
-	pr_warn("Not implemented\n");
+	serialized_state = NULL;
 }
 
 static int intel_liveupdate_freeze(struct liveupdate_subsystem *handle, u64 *data)
@@ -280,6 +282,94 @@ static struct liveupdate_subsystem intel_liveupdate_subsystem = {
 	.ops = &intel_liveupdate_subsystem_ops,
 };
 
+static struct iommu_ser *get_liveupdate_state(void)
+{
+	struct iommu_ser *ser;
+	u64 data;
+	int ret;
+
+	if (serialized_state)
+		return serialized_state;
+
+	ret = liveupdate_get_subsystem_data(&intel_liveupdate_subsystem, &data);
+	if (WARN_ON_ONCE(ret))
+		return NULL;
+
+	if (!kho_restore_folio(data))
+		return NULL;
+
+	ser = __va(data);
+	ser->iommu_units = __va(ser->iommu_units_phys);
+	ser->devices = __va(ser->devices_phys);
+	serialized_state = ser;
+
+	return ser;
+}
+
+static int restore_iommu_context(struct intel_iommu *iommu)
+{
+	struct context_entry *context;
+	int i, ret = 0;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		context = iommu_context_addr(iommu, i, 0, 0);
+		if (context)
+			BUG_ON(!kho_restore_folio(virt_to_phys(context)));
+
+		if (!sm_supported(iommu))
+			continue;
+
+		context = iommu_context_addr(iommu, i, 0x80, 0);
+		if (context)
+			BUG_ON(!kho_restore_folio(virt_to_phys(context)));
+	}
+
+	return ret;
+}
+
+static struct iommu_unit_ser *get_iommu_unit_state(struct iommu_ser *ser, u64 reg_phys)
+{
+	int i;
+
+	for (i = 0; i < ser->nr_iommus; ++i) {
+		if (ser->iommu_units[i].phys_addr ==  reg_phys)
+			return &ser->iommu_units[i];
+	}
+
+	return NULL;
+}
+
+int intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu)
+{
+	struct iommu_unit_ser *iser;
+	struct iommu_ser *ser;
+	int ret;
+
+	if (!liveupdate_state_updated())
+		return -EINVAL;
+
+	ser = get_liveupdate_state();
+	if (!ser)
+		return -EINVAL;
+
+	iser = get_iommu_unit_state(ser, iommu->reg_phys);
+	if (!iser)
+		return -EINVAL;
+
+	iommu->root_entry = __va(iser->root_table);
+
+	ret = restore_iommu_context(iommu);
+	if (ret) {
+		WARN_ONCE(ret, "Cannot restore iommu [%llx] root context\n", iommu->reg_phys);
+		folio_put(virt_to_folio(iommu->root_entry));
+		iommu->root_entry = NULL;
+	}
+	pr_info("Restored IOMMU[0x%llx] Root Table at: 0x%llx\n",
+		iommu->reg_phys, iser->root_table);
+
+	return ret;
+}
+
 static int __init intel_liveupdate_init(void)
 {
 	WARN_ON_ONCE(liveupdate_register_subsystem(&intel_liveupdate_subsystem));
-- 
2.51.0.536.g15c5d4f767-goog


