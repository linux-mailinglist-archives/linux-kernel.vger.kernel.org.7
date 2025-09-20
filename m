Return-Path: <linux-kernel+bounces-825893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A783EB8D0F2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1297B27D8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074D62DE1E4;
	Sat, 20 Sep 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FxVvIjmh"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53A2DC32A
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400744; cv=none; b=l19ARCiqu9IMk0Ct+Cgy/hpMWiurCJOKYNgagWM5ibh42BMQyPR70Zf5DUV7HM9928yIRM5QssuG9syI96oczXKdybjvh1XShgdwc5BgvmMegRdj79RMyKN7kutmOAqgtR5z1wyzsvNnZRjkMpW7iiMt3qilXBpHsN7ij03b3yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400744; c=relaxed/simple;
	bh=EvyxKCPC4Acx5fWjfq8OicLakDgx6vQxoHIqaP2XVMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXQ9sHXS15K4Cla2+EghkFVS7BwFSFbvQ/jhjwiwKBl0qyp8+mcHpXisQhySWOKD7xjfj1eQvG3bVqM2HOSQ+xBHx1XOEP5O9Iotme2MTZd8WwOodscIG+LOM/6s0NN6R6G9C//g3ti3b+PYXEyk33ERJtFJtsQkkRv6bLBq5eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FxVvIjmh; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42480cb4127so26717195ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400741; x=1759005541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+FxtKFkaMzqfsBOx/+M2AhSickIS3oj89OMniHKUZk=;
        b=FxVvIjmhz55lIp4PhPioHkY7BvIDsviKW+doI/DXhx02dcdZCZGJgAPyn3w66cXUQN
         twZo+pfc/1nXmPgw9LaAjhBhdIf8pdl20IhmLzghWl5TrofRGwOEZj1MtW8EbSi9YfNh
         mCGaPdG3qu4c2zMJwXCn5tpxp0N9KnkJTvH11p+C1/cISYZ7kjC7qOzObW3b1eRNvc2w
         n7nUWQbXfWpWo3Pdvw3XHGw8uVaAvHxGYWIJpnSUD9bL9azGa887OD9cyuzwOs7jbIsl
         kPta8WgOyOC8YyFdB5o67SzAIRYOXfVXHhc8t6NTnxhxMeHc4MuzENziLAWGfIjynYLu
         odhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400741; x=1759005541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+FxtKFkaMzqfsBOx/+M2AhSickIS3oj89OMniHKUZk=;
        b=GUzn8O58uCJQOc4X70TR5MJJdMzZXzTVF6DSXyrukbu7ZV1an12Aj39t/h7haWpJcw
         Y1j/DOPN/8iLkQuK27y9Rjy/Tr3AOe7fRxFOVFXMgQLA1jdZs5jpLHaaIfF8B5NlMM5v
         yUIndoyGaaSY1rws3lrU2vF7mqUHk+Xk3zM1Hca1ELpVwKJMWxKKIa8+zUmgHD1nEnSb
         QSTsTGPe64xOfMFEiCzqW5pezEqO6rbJHZf+z77R2DEL+elrucqlVko0jr8nN//ja1u+
         zEuj9vuOGXH+LjeQ5O/zdVtwqOQSZejjmjcUiw0DlgB7dq2nmExok9iUaOLel1Zi07X5
         hR4w==
X-Forwarded-Encrypted: i=1; AJvYcCUH+p3/pgHZXon/hbC2UOe1Hv/VDUXpU06am3G5BXwofEMjXhHPfgxnuHZfte6ODmNB98u0Uokv65KI+ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YynzBinxYe97eM0s2nTRPtK/d0yOaLK+fiDso7kFU6UW5puPK7j
	n1NSWXQ7nkIkN7eOqQbHesF3rtZDjPcZJUSucIDQSHeKUe3d2eGKMvPSQ74+xMDUQ9w=
X-Gm-Gg: ASbGncsfdyAhNlolD/1n/3nZFnC8BxHhZ/+6wKQUy6Z2Dln+6SWlX3oYxgehb4OuSGA
	M9Im9J1E03745mTOUbNw8E4Wzx4joUVD5SyPNUuYp0jeBxtxGN6WDw3/pIiUbGgMn0jdkpnHDOY
	JGS0gclMuQy3/XP15RL+QYPpydj/iUT8PI1/PApVudjeyc9+cJg/sKL37fkpOPPPhISCJbw5jO9
	5INn9zQG5mJgZ1Dgx6RNqm5YkdUTYDysQSIm7oPCRwvXI8YdrbsoUF14EJhtXBngdBBHVrWzdmj
	ogrwsNyou6Abk6EwAXKq8OY/dIENfCd8N1RLKPcLfW2r9wtIuaHDjSUkWvB5U8U1yY2jq7W5ApN
	96fUJT/sJoBsbXZsqk94i6mvY
X-Google-Smtp-Source: AGHT+IFxmBfdoZnMs3c0M0178SC39JXmddc/LJRJQPqbnDUoA8qGm+QsdfK/ozn9beIf3j5HQa9YAA==
X-Received: by 2002:a05:6e02:1aa8:b0:424:8166:9b7b with SMTP id e9e14a558f8ab-42481927117mr116642155ab.9.1758400740851;
        Sat, 20 Sep 2025 13:39:00 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afaa351sm39931975ab.29.2025.09.20.13.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:00 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 06/18] iommu/riscv: Implement MSI table management functions
Date: Sat, 20 Sep 2025 15:38:56 -0500
Message-ID: <20250920203851.2205115-26-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export more in iommu.h from iommu.c and implement functions needed
to manage the MSI table.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-bits.h |  7 ++++++
 drivers/iommu/riscv/iommu-ir.c   | 43 ++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c      | 36 +++-----------------------
 drivers/iommu/riscv/iommu.h      | 32 ++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 98daf0e1a306..d72b982cf9bf 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -715,6 +715,13 @@ static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
 	cmd->dword1 = 0;
 }
 
+static inline void riscv_iommu_cmd_inval_gvma(struct riscv_iommu_command *cmd)
+{
+	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_IOTINVAL_OPCODE) |
+		      FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA);
+	cmd->dword1 = 0;
+}
+
 static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
 						  u64 addr)
 {
diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index bed104c5333c..290d91a6c6cd 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -106,6 +106,49 @@ static size_t riscv_iommu_ir_nr_msiptes(struct riscv_iommu_domain *domain)
 	return max_idx + 1;
 }
 
+static void riscv_iommu_ir_msitbl_inval(struct riscv_iommu_domain *domain,
+					struct riscv_iommu_msipte *pte)
+{
+	struct riscv_iommu_bond *bond;
+	struct riscv_iommu_device *iommu, *prev;
+	struct riscv_iommu_command cmd;
+
+	riscv_iommu_cmd_inval_gvma(&cmd);
+	riscv_iommu_cmd_inval_set_gscid(&cmd, 0);
+
+	if (pte) {
+		u64 addr = pfn_to_phys(FIELD_GET(RISCV_IOMMU_MSIPTE_PPN, pte->pte));
+		riscv_iommu_cmd_inval_set_addr(&cmd, addr);
+	}
+
+	/* Like riscv_iommu_iotlb_inval(), synchronize with riscv_iommu_bond_link() */
+	smp_mb();
+
+	rcu_read_lock();
+
+	prev = NULL;
+	list_for_each_entry_rcu(bond, &domain->bonds, list) {
+		iommu = dev_to_iommu(bond->dev);
+		if (iommu == prev)
+			continue;
+
+		riscv_iommu_cmd_send(iommu, &cmd);
+		prev = iommu;
+	}
+
+	prev = NULL;
+	list_for_each_entry_rcu(bond, &domain->bonds, list) {
+		iommu = dev_to_iommu(bond->dev);
+		if (iommu == prev)
+			continue;
+
+		riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
+		prev = iommu;
+	}
+
+	rcu_read_unlock();
+}
+
 static struct irq_chip riscv_iommu_ir_irq_chip = {
 	.name			= "IOMMU-IR",
 	.irq_ack		= irq_chip_ack_parent,
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 0ba6504d4f33..7418e91d8edd 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -26,12 +26,6 @@
 #include "iommu-bits.h"
 #include "iommu.h"
 
-/* Timeouts in [us] */
-#define RISCV_IOMMU_QCSR_TIMEOUT	150000
-#define RISCV_IOMMU_QUEUE_TIMEOUT	150000
-#define RISCV_IOMMU_DDTP_TIMEOUT	10000000
-#define RISCV_IOMMU_IOTINVAL_TIMEOUT	90000000
-
 /* Number of entries per CMD/FLT queue, should be <= INT_MAX */
 #define RISCV_IOMMU_DEF_CQ_COUNT	8192
 #define RISCV_IOMMU_DEF_FQ_COUNT	4096
@@ -480,15 +474,15 @@ static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
 }
 
 /* Send command to the IOMMU command queue */
-static void riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
-				 struct riscv_iommu_command *cmd)
+void riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
+			  struct riscv_iommu_command *cmd)
 {
 	riscv_iommu_queue_send(&iommu->cmdq, cmd, sizeof(*cmd));
 }
 
 /* Send IOFENCE.C command and wait for all scheduled commands to complete. */
-static void riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu,
-				 unsigned int timeout_us)
+void riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu,
+			  unsigned int timeout_us)
 {
 	struct riscv_iommu_command cmd;
 	unsigned int prod;
@@ -804,28 +798,6 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 #define iommu_domain_to_riscv(iommu_domain) \
 	container_of(iommu_domain, struct riscv_iommu_domain, domain)
 
-/*
- * Linkage between an iommu_domain and attached devices.
- *
- * Protection domain requiring IOATC and DevATC translation cache invalidations,
- * should be linked to attached devices using a riscv_iommu_bond structure.
- * Devices should be linked to the domain before first use and unlinked after
- * the translations from the referenced protection domain can no longer be used.
- * Blocking and identity domains are not tracked here, as the IOMMU hardware
- * does not cache negative and/or identity (BARE mode) translations, and DevATC
- * is disabled for those protection domains.
- *
- * The device pointer and IOMMU data remain stable in the bond struct after
- * _probe_device() where it's attached to the managed IOMMU, up to the
- * completion of the _release_device() call. The release of the bond structure
- * is synchronized with the device release.
- */
-struct riscv_iommu_bond {
-	struct list_head list;
-	struct rcu_head rcu;
-	struct device *dev;
-};
-
 static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
 				 struct device *dev)
 {
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index dc2020b81bbc..1fe35f1210fb 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -17,6 +17,12 @@
 
 #include "iommu-bits.h"
 
+/* Timeouts in [us] */
+#define RISCV_IOMMU_QCSR_TIMEOUT	150000
+#define RISCV_IOMMU_QUEUE_TIMEOUT	150000
+#define RISCV_IOMMU_DDTP_TIMEOUT	10000000
+#define RISCV_IOMMU_IOTINVAL_TIMEOUT	90000000
+
 /* This struct contains protection domain specific IOMMU driver data. */
 struct riscv_iommu_domain {
 	struct iommu_domain domain;
@@ -89,10 +95,36 @@ struct riscv_iommu_device {
 	u64 *ddt_root;
 };
 
+/*
+ * Linkage between an iommu_domain and attached devices.
+ *
+ * Protection domain requiring IOATC and DevATC translation cache invalidations,
+ * should be linked to attached devices using a riscv_iommu_bond structure.
+ * Devices should be linked to the domain before first use and unlinked after
+ * the translations from the referenced protection domain can no longer be used.
+ * Blocking and identity domains are not tracked here, as the IOMMU hardware
+ * does not cache negative and/or identity (BARE mode) translations, and DevATC
+ * is disabled for those protection domains.
+ *
+ * The device pointer and IOMMU data remain stable in the bond struct after
+ * _probe_device() where it's attached to the managed IOMMU, up to the
+ * completion of the _release_device() call. The release of the bond structure
+ * is synchronized with the device release.
+ */
+struct riscv_iommu_bond {
+	struct list_head list;
+	struct rcu_head rcu;
+	struct device *dev;
+};
+
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 
+void riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
+			  struct riscv_iommu_command *cmd);
+void riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu, unsigned int timeout_us);
+
 struct irq_domain *riscv_iommu_ir_irq_domain_create(struct riscv_iommu_device *iommu,
 						    struct device *dev,
 						    struct riscv_iommu_info *info);
-- 
2.49.0


