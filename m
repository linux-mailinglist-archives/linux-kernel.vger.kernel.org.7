Return-Path: <linux-kernel+bounces-776564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6599DB2CED0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3B01885777
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7215234DCF8;
	Tue, 19 Aug 2025 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yb7N7ANf"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F7634166B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640371; cv=none; b=p2KTkUorHsiSfmT8pONdPn14Sa+0M/iY2grqPG5BUEQz1DnX7twuDgzRWKNyvodWwJ7orh5UDTwcbMKRYxXmRzfFEIe4sW7YzOtJTq5x3Y0g9AGFRmxDYjc6xxkxic06ZMXOEpp4FuT/hE0b4QHUtenSqIjr8/VpjyPuj/HpKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640371; c=relaxed/simple;
	bh=zmVhO1Fx//55azUTuwuZDUNjyqH7HeyRTi3vIAgq+T8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RenQWfMnFAz20iLLJLAP1RUCPLC4H9HLpePzgYylulCk9ZilFylcQ/SQPoiCzkb/FtxuyaJOxLHJs/N1BabHMNzUDs+jEc5H5Fwgpo3PXoOet7v753dnjFMoNwJpwvUyF7F6FmiDSXRjiwgLHnQH0nfk8Z6MtjIGMy+Z2zsj1/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yb7N7ANf; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0ccb6cso29972755e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640368; x=1756245168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5Xrv+yZchFUzMTWX2SO30dKLg2MrQIxC8g2iyFC05M=;
        b=Yb7N7ANfQdl5j86gjVcUYci1d7MgNzZ8w0kDghryd+CkVOnRmTqTOrqBosBGT8Wz95
         +kDA7IToZFAd1M5BDZ9v6q3qSXv2xevJz0QBn3JRMTQMgObbzcaq9R+Vy6h47VBCn/1r
         wKfvb4FVy98N8kGRxWlGJDpmEmAUMbvLkPG7Fxu639qqo7EJAIKSGJoAe6gVyhbybkfV
         Al7piyAvSS64fJlnKBs3ycajlq9l9zFv7W0M4x9WlQpkkK20p9HXz2JGJlwTPhW0eB8W
         EZxtQoUNYEfHSDWUMFssw+QcftGdmrEEPChSl0X+d+tbJIQls1FwIKzM+ZZzPJeEHhMY
         v4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640368; x=1756245168;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w5Xrv+yZchFUzMTWX2SO30dKLg2MrQIxC8g2iyFC05M=;
        b=Z6YnvdtxOXTFXiT78GNKn/ZQWNe/GV22oSPNf9lB5VXi+r3jghyc4L2+198oLIrzg9
         5RGNCGbvHJ3izEXPNSdr6u9/HArTZblw1CfaVQJSvr5No3fFlv2djO4VWgrA8kRlRLbD
         JpwkFjlHjTmW5Syu+n5LyeF5WUUHYbghUR9xcqe0unL9IVdBhEfvLi1q+aKVbvgFh2I7
         pAwyA7TOj3XH18cDCjUlQOJhm9dH6Q8Pc2aGBYPCywq1uGVNPdEATSJ+nesZ4lItxYwX
         BYj/672q87aEr5U2aymcVTA0et7wcnEzcZULSBqmsyp86zmvvTYcXMfEnQdrpKQKnK7A
         QNng==
X-Gm-Message-State: AOJu0YySTdJeGKAFnkCeWZU/zjwgdpuEFWutLCMFraE0V8NXE2ac1jnq
	Czr6tEH0GopGK1zntaNQ4M39j6AcSQ5Yzw4NI7QedUJ26sMDAThd1EMhX5Roftv+EcwSOXoAftb
	CtSiCrc1XVoeP7nrGUPzEh8vcPRQzUsXp4kCRoHD90RX8Mun++0abpwC9yAa7165O6SRqGR6cfl
	yyabZoBWUw0qIFC3bf3Z4FRO/u9mxKS4BUAz1NimPGPIg8y8cI+RdXA1Q=
X-Google-Smtp-Source: AGHT+IEkIYLt8jKXZ6jlGQreyOBP5MPpq4IR1pMtFairXlGsN9A2lAviNYTKCG1j1G3gzMwAxgyEa1tGajcbqg==
X-Received: from wmqa4.prod.google.com ([2002:a05:600c:3484:b0:459:dbaa:93b0])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ba7:b0:458:bb0e:4181 with SMTP id 5b1f17b1804b1-45b47d904a1mr1114035e9.10.1755640367876;
 Tue, 19 Aug 2025 14:52:47 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:53 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-26-smostafa@google.com>
Subject: [PATCH v4 25/28] iommu/arm-smmu-v3-kvm: Emulate GBPA
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The last bit of emulation is GBPA. it must be always set to ABORT,
as when the SMMU is disabled it=E2=80=99s not allowed for the host to bypas=
s
the SMMU.

That =E2=80=98s is done by setting the GBPA to ABORT at init time, when the=
 host:
- Writes, we ignore the write and save the value without the UPDATE bit.
- Reads, return the saved value.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 21 ++++++++++++++++---
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  |  2 ++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iom=
mu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index 0f890a7d8db3..db9d9caaca2c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -100,6 +100,13 @@ static int smmu_unshare_pages(phys_addr_t addr, size_t=
 size)
 	return 0;
 }
=20
+static int smmu_abort_gbpa(struct hyp_arm_smmu_v3_device *smmu)
+{
+	writel_relaxed(GBPA_UPDATE | GBPA_ABORT, smmu->base + ARM_SMMU_GBPA);
+	/* Wait till UPDATE is cleared. */
+	return smmu_wait(readl_relaxed(smmu->base + ARM_SMMU_GBPA) =3D=3D GBPA_AB=
ORT);
+}
+
 static bool smmu_cmdq_full(struct arm_smmu_queue *cmdq)
 {
 	struct arm_smmu_ll_queue *llq =3D &cmdq->llq;
@@ -416,6 +423,10 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_dev=
ice *smmu)
 	if (ret)
 		goto out_ret;
=20
+	ret =3D smmu_abort_gbpa(smmu);
+	if (ret)
+		goto out_ret;
+
 	return 0;
=20
 out_ret:
@@ -663,10 +674,14 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_d=
evice *smmu,
 			smmu->host_ste_cfg =3D val;
 		}
 		goto out_ret;
-	/* Passthrough the register access for bisectiblity, handled later */
 	case ARM_SMMU_GBPA:
-		mask =3D read_write;
-		break;
+		if (is_write)
+			smmu->gbpa =3D val & ~GBPA_UPDATE;
+		else
+			regs->regs[rd] =3D smmu->gbpa;
+
+		WARN_ON(len !=3D sizeof(u32));
+		goto out_ret;
 	case ARM_SMMU_CR0:
 		if (is_write) {
 			bool last_cmdq_en =3D is_cmdq_enabled(smmu);
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h b/drivers/iom=
mu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
index cf85e5efdd9e..aab585dd9fd8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
@@ -31,6 +31,7 @@
  * @host_ste_cfg	Host stream table config
  * @host_ste_base	Host stream table base
  * @strtab_cfg		Stream table as seen by HW
+ * @gbpa		Last value of GBPA from the host
  */
 struct hyp_arm_smmu_v3_device {
 	phys_addr_t		mmio_addr;
@@ -54,6 +55,7 @@ struct hyp_arm_smmu_v3_device {
 	u64			host_ste_cfg;
 	u64			host_ste_base;
 	struct arm_smmu_strtab_cfg strtab_cfg;
+	u32			gbpa;
 };
=20
 extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
--=20
2.51.0.rc1.167.g924127e9c0-goog


