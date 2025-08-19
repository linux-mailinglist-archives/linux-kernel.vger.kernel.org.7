Return-Path: <linux-kernel+bounces-776560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEE5B2CECC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD43A976E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D47E341661;
	Tue, 19 Aug 2025 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Px0wOzM8"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979D334381
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640368; cv=none; b=hbek/Zs3uebxW6g3LLsKjcNPma2sCBUsaSI5JR69OgxXuxHkX1/fQxVKdTV8O8fMBdHjm/sPZ4kRQLzLkJTOxdmIe2AiqMlWSCxlmloMyzZHdLN5+pQJbNhENPdj0ZyuXVcbsm8FgVqKhiSjvPowNCTuFxBjtZUoSeLhStr9RV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640368; c=relaxed/simple;
	bh=BdXTwmydT3BtN8HebN1Pb6HB/oKVhfmvfEyBuFMb0uM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BOAj7KxZzr7fXZ5hMYYLY378r0pFWWByOgwTEZBfId+CFh+MB5l0j1ZUig5RJNmioBtZA+R6GroVtuRs5utN5tMIg+1vtgPhJUbZO0vWqMaeDbiFRiY+/Q2yPH8VMUTtF1ynHmTIIfpxgzKFdUiRyNez4dUr+iuppoOx7kfgQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Px0wOzM8; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0c5377so25525015e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640364; x=1756245164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyRtXnhnhppM44IFifDXYrWtilG94lpK59HvMcWGonE=;
        b=Px0wOzM8IVtiZ1ZqfqewqgtOC6HOfYvH/HU7ILKM6M1OhUDas5OXz/7TGXF5BmakUy
         vEyX/XrqwF69gUiVcRr6ty0tdIi+x4m6fohVJidk6JdecEDLKM6LDsK4C6o2u0S3hPcY
         5NnPrnYLGIO6OHVEnuJA0lJ4eBYifmLdN1AFmxSP+IXavnPmrxXeuPO9uwKVgS9UB8u8
         qhfN2IGPBysLvRlJOBW8AJEJ1pIpSWRxo197xOKgaInTyQ5GV8WgxLsSqGJiGS1LC/2o
         h97p5PGuRlg+dPnMLLETLoN0ir9qzXQ3kB/ZyIdLlY4sIIn6VWvkI8G2PhayFqtEWYks
         nHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640364; x=1756245164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyRtXnhnhppM44IFifDXYrWtilG94lpK59HvMcWGonE=;
        b=pQycM16uRIixMHJ2jpdY4PjR7Tg4ig5ApBLXEinym4qrOLJ5fMt1t6O+aR5wM0pXce
         MgrtAKd4g3A5K4cupt+axXNnuh6MWx6IHDgWQyuLEkCMlU6qkhW+moDjaGdh9f4GwgMe
         0+E1ht9LH06XYCidXOTj2cFRhceBtr2ntdLlEYQr4wRNF9fsVFU3cZhbhX+dtuQ432JO
         +z/RYiDWraect8nUYEhW03A+k3ZNY4O17y+gbHJ0A2hWmWebBFUe89c99XyUXQBe67Xa
         1lhCS6ZK/AvDi8qZLWoIGkNDezwyQFujytSl1yx9U+AM0JrR1bxeZoY1RQ7PuwTQ9mjC
         /cZQ==
X-Gm-Message-State: AOJu0Yw2JBkpea2fD2zSDW+588n2a2tt76AU9BbJ5wpEo3faQ1be9vLl
	6QIyjM2HFWt+vG9IK0Fv/vVjbgR8ZA6WThIG//nswN5yDILTbgkdb4sZzna0p8bz8+uvzPlQDh3
	k5ez3KxWeIxrOQtPwRbn29c7JESWJa1JcPtMxNA7t7tiY4MDA4hjq1AgPkgK0K2K2GC2XGwSmN/
	0fGuBm/Yt3dAzf2InnO6N6jRGCmpbso1QdSTKvs6T8BnjbNkCVk2rze6U=
X-Google-Smtp-Source: AGHT+IGr5ioioVJcsD/j/B2rJ42P01JBGG14bJdGLQMTv0vagaiysEKhVuqLi/9sRGavTW3nFD47MLqZZDL7iQ==
X-Received: from wmqd6.prod.google.com ([2002:a05:600c:34c6:b0:458:c02c:3ccd])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:b86:b0:456:eb9:5236 with SMTP id 5b1f17b1804b1-45b479bdf64mr3584515e9.15.1755640364362;
 Tue, 19 Aug 2025 14:52:44 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:49 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-22-smostafa@google.com>
Subject: [PATCH v4 21/28] iommu/arm-smmu-v3-kvm: Add CMDQ functions
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add functions to access the command queue, there are 2 main usage:
- Hypervisor's own commands, as TLB invalidation, would use functions
  as smmu_send_cmd(), which creates and sends a command.
- Add host commands to the shadow command queue, after being filtered,
  these will be added with smmu_add_cmd_raw.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index d3ab4b814be4..554229e466f3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -20,6 +20,33 @@ struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
 	     (smmu) != &kvm_hyp_arm_smmu_v3_smmus[kvm_hyp_arm_smmu_v3_count]; \
 	     (smmu)++)
 
+/*
+ * Wait until @cond is true.
+ * Return 0 on success, or -ETIMEDOUT
+ */
+#define smmu_wait(_cond)					\
+({								\
+	int __ret = 0;						\
+	u64 delay = pkvm_time_get() + ARM_SMMU_POLL_TIMEOUT_US;	\
+								\
+	while (!(_cond)) {					\
+		if (pkvm_time_get() >= delay) {			\
+			__ret = -ETIMEDOUT;			\
+			break;					\
+		}						\
+	}							\
+	__ret;							\
+})
+
+#define smmu_wait_event(_smmu, _cond)				\
+({								\
+	if ((_smmu)->features & ARM_SMMU_FEAT_SEV) {		\
+		while (!(_cond))				\
+			wfe();					\
+	}							\
+	smmu_wait(_cond);					\
+})
+
 /* Transfer ownership of memory */
 static int smmu_take_pages(u64 phys, size_t size)
 {
@@ -62,6 +89,77 @@ static int smmu_unshare_pages(phys_addr_t addr, size_t size)
 	return 0;
 }
 
+static bool smmu_cmdq_full(struct arm_smmu_queue *cmdq)
+{
+	struct arm_smmu_ll_queue *llq = &cmdq->llq;
+
+	WRITE_ONCE(llq->cons, readl_relaxed(cmdq->cons_reg));
+	return queue_full(llq);
+}
+
+static bool smmu_cmdq_empty(struct arm_smmu_queue *cmdq)
+{
+	struct arm_smmu_ll_queue *llq = &cmdq->llq;
+
+	WRITE_ONCE(llq->cons, readl_relaxed(cmdq->cons_reg));
+	return queue_empty(llq);
+}
+
+static void smmu_add_cmd_raw(struct hyp_arm_smmu_v3_device *smmu,
+			     u64 *cmd)
+{
+	struct arm_smmu_queue *q = &smmu->cmdq;
+	struct arm_smmu_ll_queue *llq = &q->llq;
+
+	queue_write(Q_ENT(q, llq->prod), cmd,  CMDQ_ENT_DWORDS);
+	llq->prod = queue_inc_prod_n(llq, 1);
+	writel_relaxed(llq->prod, q->prod_reg);
+}
+
+static int smmu_add_cmd(struct hyp_arm_smmu_v3_device *smmu,
+			struct arm_smmu_cmdq_ent *ent)
+{
+	int ret;
+	u64 cmd[CMDQ_ENT_DWORDS];
+
+	ret = smmu_wait_event(smmu, !smmu_cmdq_full(&smmu->cmdq));
+	if (ret)
+		return ret;
+
+	ret = arm_smmu_cmdq_build_cmd(cmd, ent);
+	if (ret)
+		return ret;
+
+	smmu_add_cmd_raw(smmu, cmd);
+	return 0;
+}
+
+static int smmu_sync_cmd(struct hyp_arm_smmu_v3_device *smmu)
+{
+	int ret;
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_CMD_SYNC,
+	};
+
+	ret = smmu_add_cmd(smmu, &cmd);
+	if (ret)
+		return ret;
+
+	return smmu_wait_event(smmu, smmu_cmdq_empty(&smmu->cmdq));
+}
+
+__maybe_unused
+static int smmu_send_cmd(struct hyp_arm_smmu_v3_device *smmu,
+			 struct arm_smmu_cmdq_ent *cmd)
+{
+	int ret = smmu_add_cmd(smmu, cmd);
+
+	if (ret)
+		return ret;
+
+	return smmu_sync_cmd(smmu);
+}
+
 /* Put the device in a state that can be probed by the host driver. */
 static void smmu_deinit_device(struct hyp_arm_smmu_v3_device *smmu)
 {
-- 
2.51.0.rc1.167.g924127e9c0-goog


