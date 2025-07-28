Return-Path: <linux-kernel+bounces-748471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F71B14193
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F2E77B0D17
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DB72877CA;
	Mon, 28 Jul 2025 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKZpGfDS"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8A2857F6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725236; cv=none; b=XqPkdIqtur7TNvtDNUUhDL7teG2WMly/lbl+EgNoGewqAQoDCcaWfStOcs1Bt7a/Hh6GiKkBA1HAbv8tJIJpSqGHvgZvu6WyfudldYPM4khkKSiERqXFqg3QS0GuWpvtQzTkRX5SsAY/Rq26k8XoIK8aVpnlfkgJLLX1Ul5esiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725236; c=relaxed/simple;
	bh=dTOJzCAcVM/NCEsmIl4BGdJTrTBtAfQFPr+jJGgBymI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WpWsZSn4cwh6viyk+bJR7ocJ37VvpcTcsjiwvlrcCpgDRs6EwAjX6YLySC88EOnU2YDeClQLxVI4PDbglLPk7lbb3nj6GlAsvOeQjdP+A+UJNTKiPjGykDLM12E0ZRDACDykZEeReADQMxu1ov+fSf2qCdcntNOXrZ4CXRs9EUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YKZpGfDS; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b7889c8d2bso660459f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725231; x=1754330031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnrJ8rRpiFcwZt6jaLJ2PB3oGBNZG+6tYm8EfAOijts=;
        b=YKZpGfDSCshdtNR7kp9MqvN8VMH3ZuqlRKqKmpUBNA+H1FLsXsVXuuxFdWUZKtqhpY
         gtWoRdkcSbEg0EvPs2nPYS3EnioeqTzdBbfDRcuNJvFORokEqlS/h5qFjO9XesSBHucg
         Sdx0xZvmxBEysCRtseLF33uskozPsa+yYa0Z4Ah7SOIgwbcy1fmJ//XfAFByPCBdUa0i
         5uE5MYkZr3Y9SWtRbCDbH9YSzO4fDIYF3OteZbSeKK3gKhxcCQSOzGPTZzL5M9RjLo75
         Hs2NmZhCko03PnhkRhyuHGUNwibueJiIhEKmtwQeDuXJRdSDHENnHVXOF7q+zCGwSXpN
         k4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725231; x=1754330031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnrJ8rRpiFcwZt6jaLJ2PB3oGBNZG+6tYm8EfAOijts=;
        b=lm4qiLXzvki3T1uj5UqgaYTbQjYDRBFtNP33m2NWcuV/Ji9i4hs9tZTxTzjzg8cfYM
         Sk4Mk5qpLbAZDQZHulq2rADnf0MXtMWm2T5YtZQFJp6kP+u6NgEHfxqRwwuVKBHKROOW
         Y/GLuUyzxoMvQ/Qmp/9eJmO4y/Bc4DnbeFs4efMTBsOEMa5Sd46l8SzmnWB2k1DagA4W
         YLe1/z+8FPhVTi06+hu3e1fB1KqxP81VP3Q3nAZFBXte4PAkpJYZmhCk0qrVL42mOwEG
         eG5FXfL9hvTuTS8UIG0H4MtmjlUULVgMz0wyUnIz4OqpU26JRpU2zYM/GyRMKOodDKAm
         LsdA==
X-Gm-Message-State: AOJu0YzQnq4v3dA4diAobSZMNiVWqhz0ujeObuu2o0/OJr+HGxbbmMbH
	efupE4cf8nlsyFpjG5qbok9qoBibTrS/g3BkFxQRGckAQ93KF3pE+lVmeWmeF2/0s5hwxqj/5Tq
	zuU90J6Kqa+PRxARSx+lfKx3r7RFFn/uQRjVDM+nUCybPK/udyVayLkAthTpxGji9Khbo1wtsCt
	7AmR79o8Za2Cj9AMrRXwEdsLSmQRFzNeEvtLIxucd2WbBKtWFMDydSz3I=
X-Google-Smtp-Source: AGHT+IGHsz9MPgnZj965sBmcV3dHVpcs8CmM+t34RmjDx7BARFkS1+Ew6W35n8N0of95SaKBxWolAPNzAtM27Q==
X-Received: from wrs6.prod.google.com ([2002:a05:6000:646:b0:3b4:972f:ca5c])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:651:b0:3b7:76ac:8b72 with SMTP id ffacd0b85a97d-3b776ac8dccmr7943968f8f.12.1753725231478;
 Mon, 28 Jul 2025 10:53:51 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:53:09 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-23-smostafa@google.com>
Subject: [PATCH v3 22/29] iommu/arm-smmu-v3-kvm: Reset the device
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Now that all structures are initialized, send global invalidations and
reset the SMMUv3 device.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index 74e6dfb53528..5e988ffede92 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -301,6 +301,40 @@ static int smmu_init_strtab(struct hyp_arm_smmu_v3_device *smmu)
 				       strtab_size >> PAGE_SHIFT, prot);
 }
 
+static int smmu_reset_device(struct hyp_arm_smmu_v3_device *smmu)
+{
+	int ret;
+	struct arm_smmu_cmdq_ent cfgi_cmd = {
+		.opcode = CMDQ_OP_CFGI_ALL,
+	};
+	struct arm_smmu_cmdq_ent tlbi_cmd = {
+		.opcode = CMDQ_OP_TLBI_NSNH_ALL,
+	};
+
+	/* Invalidate all cached configs and TLBs */
+	ret = smmu_write_cr0(smmu, CR0_CMDQEN);
+	if (ret)
+		return ret;
+
+	ret = smmu_add_cmd(smmu, &cfgi_cmd);
+	if (ret)
+		goto err_disable_cmdq;
+
+	ret = smmu_add_cmd(smmu, &tlbi_cmd);
+	if (ret)
+		goto err_disable_cmdq;
+
+	ret = smmu_sync_cmd(smmu);
+	if (ret)
+		goto err_disable_cmdq;
+
+	/* Enable translation */
+	return smmu_write_cr0(smmu, CR0_SMMUEN | CR0_CMDQEN | CR0_ATSCHK);
+
+err_disable_cmdq:
+	return smmu_write_cr0(smmu, 0);
+}
+
 static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 {
 	int i;
@@ -333,6 +367,9 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 	if (ret)
 		goto out_err;
 
+	ret = smmu_reset_device(smmu);
+	if (ret)
+		goto out_err;
 	return ret;
 
 out_err:
-- 
2.50.1.552.g942d659e1b-goog


