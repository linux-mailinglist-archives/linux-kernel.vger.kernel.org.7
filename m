Return-Path: <linux-kernel+bounces-776567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B123B2CED3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947A83B7B47
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB2D353352;
	Tue, 19 Aug 2025 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sgOe/R86"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8665C34DCFE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640374; cv=none; b=EEDekfaelVgQDW6xcK9mHLeCkXyO48RRZtt84k6GqihnQh5UrFuSsrGA1THg8v0jwhSm4gew+NjW0iIXLiY7moUFDV+mkj0l5wDD7a94pmHt9PDjFgtrapmrZHXQJKL+1PzkutF7j5MhneOLLl1SLEHIh5mV7bJi2clsE2ceGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640374; c=relaxed/simple;
	bh=ouFg05ZUoCgKsBBLYpEzl0x2/Hx613KSJzCk/sH774M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nNskOmsOme10ZlawofkOtDlmpo89uA5QAf0is3qtaZW+AfeRlpZJleBAPXjckF1VIsW/7bBMyq1W5caWu49+mXUrVzIsRzFt7SNSHgXMuZqFCrIsQHwrhfUMlEKIhf9Q5S9Al3LrC3N7w5UOrwlAGaFAzwdzu8Boir61QiKIiGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sgOe/R86; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b04f817so21173385e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640371; x=1756245171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAhjHEW7JiGbHkZ3+MEbEcd94kVTPfsHqLQCKJs7pUU=;
        b=sgOe/R86QJmNDeSgtiuR/mFaHxYuEaGLBTYbdrP8fYn2y5aJeMWTWIOybFIoP53ErX
         e1qjwAXsmE8/JfsHhIiihcsC7z4IPBlRVMcTRl7DhAxu9iXVZJ49ND2Za72tM/nIpwQK
         mFXYe1zS6NYBlutTeo9iQAFA29+jOzyoO0udDQjey7yipa+pjPTko2WRwUiXa4dWM7l9
         MxkjVEEzBBP4g9mPJhK9fwfoslJP5RUCi5k25yd3QI0/0sC3YBblgM1yU0UEOHdmqAS5
         XmpAqzxtbvkare4psB0sT+DKqj+ZFpF7tF8BgvWG/hJqP7X4ZqjMNMeKOI6hPgDyeAE4
         u24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640371; x=1756245171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAhjHEW7JiGbHkZ3+MEbEcd94kVTPfsHqLQCKJs7pUU=;
        b=aIVGXeql636wwpXojR8kKZaRh1tzxGlGspSCwh/DVbTgT2dEsfhj5sanl5XDypJ0sc
         qAcZneMXkuzvLrqV/LCozZqnKEoI007nVJhtzcwCEUsthNP+GpgyhiBRqEmtJOlaV45j
         tTLe7MB/f1YCSTOxyfwiRcZqzHVQHqTSc7wGPNpbEXcBt3GSRs+NaStFcXorapPAigC7
         5qB1kgj9Ag6XgQ2o0cyzgn3e6w1AuHTqTQFlEQROtlLxdRDRCXgFbY8n/ZVFe7/YmtNZ
         N0fzmDTtLDGzVEgJtDdEOe/RHfISnNVwLvUsqkue/+9sapbqCglQXVxLtkJyuvl0xG/J
         rERQ==
X-Gm-Message-State: AOJu0YzjEZL1LfZijNOvaZ1WTPqNYpb3An5fEbLdVJt3K9ZCH0/Zp568
	BK2KBGPFvuksPzljQ8yr9HoA7tnxYkTqPTrimdXB5HM2qwRq+mSVvAMwclI7R9V9eDR40+L9KJJ
	jqrhV0ZISlI6m11qKDiYizGm4bYhMUIK63sbqXa8JwzbY3GnTWeXWZvqEi8xP9CDOhSqZeDc3qx
	dnJlX0NkdRET94pfnH8aaCUH/DixNXLZ2KjKGuYLn7YDSS2TaSs33ai18=
X-Google-Smtp-Source: AGHT+IEZystQ29Iwydry030qs2Gr/OWu/XIzN2opOZePf7XxWhuKurUI07dQ/jVoWuLSREf7SL8Xi1ULimkXvw==
X-Received: from wmbhj7.prod.google.com ([2002:a05:600c:5287:b0:456:111e:4717])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f4d:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-45b479a3f4dmr3809755e9.3.1755640370667;
 Tue, 19 Aug 2025 14:52:50 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:56 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-29-smostafa@google.com>
Subject: [PATCH v4 28/28] iommu/arm-smmu-v3-kvm: Enable nesting
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Now, as the hypervisor controls the command queue, stream table,
and shadows the stage-2 page table.
Enable stage-2 in case the host puts an STE in bypass or stage-1.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 72 ++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index 2d4ff21f83f9..5be44a37d581 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -336,6 +336,46 @@ static int smmu_init_cmdq(struct hyp_arm_smmu_v3_device *smmu)
 	return 0;
 }
 
+static void smmu_attach_stage_2(struct hyp_arm_smmu_v3_device *smmu, struct arm_smmu_ste *ste)
+{
+	unsigned long vttbr;
+	unsigned long ts, sl, ic, oc, sh, tg, ps;
+	unsigned long cfg;
+	struct io_pgtable_cfg *pgt_cfg =  &idmap_pgtable->cfg;
+
+	cfg = FIELD_GET(STRTAB_STE_0_CFG, ste->data[0]);
+	if (!FIELD_GET(STRTAB_STE_0_V, ste->data[0]) ||
+	    (cfg == STRTAB_STE_0_CFG_ABORT))
+		return;
+	/* S2 is not advertised, that should never be attempted. */
+	if (WARN_ON(cfg == STRTAB_STE_0_CFG_NESTED))
+		return;
+	vttbr = pgt_cfg->arm_lpae_s2_cfg.vttbr;
+	ps = pgt_cfg->arm_lpae_s2_cfg.vtcr.ps;
+	tg = pgt_cfg->arm_lpae_s2_cfg.vtcr.tg;
+	sh = pgt_cfg->arm_lpae_s2_cfg.vtcr.sh;
+	oc = pgt_cfg->arm_lpae_s2_cfg.vtcr.orgn;
+	ic = pgt_cfg->arm_lpae_s2_cfg.vtcr.irgn;
+	sl = pgt_cfg->arm_lpae_s2_cfg.vtcr.sl;
+	ts = pgt_cfg->arm_lpae_s2_cfg.vtcr.tsz;
+
+	ste->data[1] |= FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING);
+	/* The host shouldn't write dwords 2 and 3, overwrite them. */
+	ste->data[2] = FIELD_PREP(STRTAB_STE_2_VTCR,
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2PS, ps) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2TG, tg) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2SH0, sh) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2OR0, oc) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2IR0, ic) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2SL0, sl) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2T0SZ, ts)) |
+		 FIELD_PREP(STRTAB_STE_2_S2VMID, 0) |
+		 STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2R;
+	ste->data[3] = vttbr & STRTAB_STE_3_S2TTB_MASK;
+	/* Convert S1 => nested and bypass => S2 */
+	ste->data[0] |= FIELD_PREP(STRTAB_STE_0_CFG, cfg | BIT(1));
+}
+
 /* Get an STE for a stream table base. */
 static struct arm_smmu_ste *smmu_get_ste_ptr(struct hyp_arm_smmu_v3_device *smmu,
 					     u32 sid, u64 *strtab)
@@ -394,6 +434,10 @@ static void smmu_reshadow_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, bool
 	struct arm_smmu_ste *host_ste_ptr = smmu_get_ste_ptr(smmu, sid, host_ste_base);
 	struct arm_smmu_ste *hyp_ste_ptr = smmu_get_ste_ptr(smmu, sid, hyp_ste_base);
 	int i;
+	struct arm_smmu_ste target = {};
+	struct arm_smmu_cmdq_ent cfgi_cmd = {
+		.opcode = CMDQ_OP_CFGI_ALL,
+	};
 
 	/*
 	 * Linux only uses leaf = 1, when leaf is 0, we need to verify that this
@@ -409,8 +453,32 @@ static void smmu_reshadow_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, bool
 		hyp_ste_ptr = smmu_get_ste_ptr(smmu, sid, hyp_ste_base);
 	}
 
-	for (i = 0; i < STRTAB_STE_DWORDS; i++)
-		WRITE_ONCE(hyp_ste_ptr->data[i], host_ste_ptr->data[i]);
+	memcpy(target.data, host_ste_ptr->data, STRTAB_STE_DWORDS << 3);
+
+	/*
+	 * Typically, STE update is done as the following
+	 * 1- Write last 7 dwords, while STE is invalid
+	 * 2- CFGI
+	 * 3- Write first dword, making STE valid
+	 * 4- CFGI
+	 * As the SMMU has to least to load 64 bits atomically
+	 * that gurantees that there is no race between writing
+	 * the STE and the CFGI where the SMMU observes parts
+	 * of the STE.
+	 * In the shadow we update the STE to enable nested translation,
+	 * which requires updating first 3 dwords.
+	 * That is only done if the STE is valid and not in abort.
+	 * Which means it happens at step 4)
+	 * So we need to also write the last 7 dwords and send CFGI
+	 * before writing the first dword.
+	 * There is no need for last CFGI as the host will do that.
+	 */
+	smmu_attach_stage_2(smmu, &target);
+	for (i = 1; i < STRTAB_STE_DWORDS; i++)
+		WRITE_ONCE(hyp_ste_ptr->data[i], target.data[i]);
+
+	WARN_ON(smmu_send_cmd(smmu, &cfgi_cmd));
+	WRITE_ONCE(hyp_ste_ptr->data[0], target.data[0]);
 }
 
 static int smmu_init_strtab(struct hyp_arm_smmu_v3_device *smmu)
-- 
2.51.0.rc1.167.g924127e9c0-goog


