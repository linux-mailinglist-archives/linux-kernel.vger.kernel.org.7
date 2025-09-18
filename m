Return-Path: <linux-kernel+bounces-776561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DE6B2CECE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526011BA6FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8A133439E;
	Tue, 19 Aug 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JPE6G6gP"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49933439B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640369; cv=none; b=HvQIsYUIFZKGZXkEQevsL3U/aNfhlqHRee8OyFbJKI418Hzy8yELFEN7UrCTEING0FwY36+SPZRa9gGSMBPWBrvSEs9u5GADGQ2S4pYxyB7edwroYA+ExODFiIVjw0gQtUJy+m87lZ3FtOeyncuS0lWK0WcJ0QPoNGeEwGcG9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640369; c=relaxed/simple;
	bh=x6+sOLq4FPZ4CMFUSWd3Y8U0nD5a7Aqh64+XSIM/UM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ig1r4UG+I8i3pPSv2DHhIjRKm4BdS7+TZiljk9sqefs+4Y8eecHXkCLpJdU2qGJtidOQ9EHJGDXCvRmSEHacJmmKQwVZ1moNE7O0fNrYJtoj11UtKX8TP1oa//3dew+FMDT+IiCZpkyaW3ulEwen2UGnEE+IlZP/MaZwgy/2T4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JPE6G6gP; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-afcb7338319so416396166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640365; x=1756245165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2OiNO3KzQO8B0w4ffRojG8RRfuYkjFyK2nm+fAlxiU=;
        b=JPE6G6gP6019p8hLhpjNUoZjXTziIKld8Wu5Q/a4mxE4NtYt4GiWSiiq/kioBJ89HW
         IaX2zzlXqPIX9iYmNo4igxAtnYNlzRQzu6acW7nAYa43throeoydZ6NtRuOnhcq3Zi0L
         uZ8qGePAs1+v0TTfJ+lYf9xNjEX2ZQYSe3KXlo3jMpYZXyz4ad85P6sN/wrGlO33OdFk
         qtl0y2ViDmFyvg6mr47abLJtOjVRCQMOcp6MkRn7pvQZNDFpTeHQq5rMf1/paSD/7Anv
         CnW25A/kc3EhTaA4LafOzr1bysena40E1lkgtXV9A3MmlvesNo/hJzkel2kPK3O/o8VE
         042w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640365; x=1756245165;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s2OiNO3KzQO8B0w4ffRojG8RRfuYkjFyK2nm+fAlxiU=;
        b=QDuGUWNVIZopLtVA68Z5Tu6irrUpwoZt3svpt9/0Rwd31gvFEzGuBgffDHa+HOMoiu
         ZvCZNC0Qcka/HoJZ0Q6C/I+Xt/nGnRxnhQLJGr26J4tCps+ScIl10sRIRkWTbjUFUuWe
         FJzIIYw0RldT6dXdUZOpfCY5g2GocMb8vFlALraDoLEkxIpJiQUg9RGekkGU3QxADLto
         s+kH4YmWlASEutSBHrUaKZso/tFzP5scc8X3WqqGHI1WFP93t/M/gKVThM5LatkwsJoq
         1WZQ/CGW9W2XFK0Y3KRSfDOjxaB9+Y2Ya6/wx6Da+tQcHMmhNLzKwwGlH1S250SbG67S
         JdZQ==
X-Gm-Message-State: AOJu0YzczCZVdLq4kzCd8HTYGoCeGmQFNoj1NKnBvZmTfdpdSPv4k8T6
	b9rrdYvsskVtmdjdfSOXLrFZwlgfnfdxL5uCoZcrV/4m31qHB8P+Bo2RWlsIo0o4H+nLB+Kxlfv
	2MFs7Q1FE2Es/7oe2Ga1+MYgJFdPD3bBDYc54pPUXpyJKQQyICSN+0oTM+er1Jfxb3lSBL5oxDy
	XGTpLjy48DpuQogLKeVbuKYTFkH8j3LOacoSaCTYRibNFmmas/G71sK/0=
X-Google-Smtp-Source: AGHT+IHd99Hbl/EO+Fv3HJ9l/C88pz7JGJRqrSKU6LiBDjnLkGYw7fqHFm99BcFANhnvyjy+geOwjTDrJ/MdzA==
X-Received: from ejcuy5.prod.google.com ([2002:a17:907:d105:b0:ae9:c7c1:c2a2])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7ba3:b0:ae0:d9f3:9131 with SMTP id a640c23a62f3a-afdf00bda1bmr33581766b.6.1755640365290;
 Tue, 19 Aug 2025 14:52:45 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:50 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-23-smostafa@google.com>
Subject: [PATCH v4 22/28] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
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

Don=E2=80=99t allow access to the command queue from the host:
- ARM_SMMU_CMDQ_BASE: Only allowed to be written when CMDQ is disabled, we
  use it to keep track of the host command queue base.
  Reads return the saved value.
- ARM_SMMU_CMDQ_PROD: Writes trigger command queue emulation which sanitise=
s
  and filters the whole range. Reads returns the host copy.
- ARM_SMMU_CMDQ_CONS: Writes move the sw copy of the cons, but the host can=
=E2=80=99t
  skip commands once submitted. Reads return the emulated value and the err=
or
  bits in the actual cons.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 108 +++++++++++++++++-
 1 file changed, 105 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iom=
mu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index 554229e466f3..10c6461bbf12 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -325,6 +325,88 @@ static bool is_cmdq_enabled(struct hyp_arm_smmu_v3_dev=
ice *smmu)
 	return FIELD_GET(CR0_CMDQEN, smmu->cr0);
 }
=20
+static bool smmu_filter_command(struct hyp_arm_smmu_v3_device *smmu, u64 *=
command)
+{
+	u64 type =3D FIELD_GET(CMDQ_0_OP, command[0]);
+
+	switch (type) {
+	case CMDQ_OP_CFGI_STE:
+		/* TBD: SHADOW_STE*/
+		break;
+	case CMDQ_OP_CFGI_ALL:
+	{
+		/*
+		 * Linux doesn't use range STE invalidation, and only use this
+		 * for CFGI_ALL, which is done on reset and not on an new STE
+		 * being used.
+		 * Although, this is not architectural we rely on the current Linux
+		 * implementation.
+		 */
+		WARN_ON((FIELD_GET(CMDQ_CFGI_1_RANGE, command[1]) !=3D 31));
+		break;
+	}
+	case CMDQ_OP_TLBI_NH_ASID:
+	case CMDQ_OP_TLBI_NH_VA:
+	case 0x13: /* CMD_TLBI_NH_VAA: Not used by Linux */
+	{
+		/* Only allow VMID =3D 0*/
+		if (FIELD_GET(CMDQ_TLBI_0_VMID, command[0]) =3D=3D 0)
+			break;
+		break;
+	}
+	case 0x10: /* CMD_TLBI_NH_ALL: Not used by Linux */
+	case CMDQ_OP_TLBI_EL2_ALL:
+	case CMDQ_OP_TLBI_EL2_VA:
+	case CMDQ_OP_TLBI_EL2_ASID:
+	case CMDQ_OP_TLBI_S12_VMALL:
+	case 0x23: /* CMD_TLBI_EL2_VAA: Not used by Linux */
+		/* Malicous host */
+		return WARN_ON(true);
+	case CMDQ_OP_CMD_SYNC:
+		if (FIELD_GET(CMDQ_SYNC_0_CS, command[0]) =3D=3D CMDQ_SYNC_0_CS_IRQ) {
+			/* Allow it, but let the host timeout, as this should never happen. */
+			command[0] &=3D ~CMDQ_SYNC_0_CS;
+			command[0] |=3D FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
+			command[1] &=3D ~CMDQ_SYNC_1_MSIADDR_MASK;
+		}
+		break;
+	}
+
+	return false;
+}
+
+static void smmu_emulate_cmdq_insert(struct hyp_arm_smmu_v3_device *smmu)
+{
+	u64 *host_cmdq =3D hyp_phys_to_virt(smmu->cmdq_host.q_base & Q_BASE_ADDR_=
MASK);
+	int idx;
+	u64 cmd[CMDQ_ENT_DWORDS];
+	bool skip;
+
+	if (!is_cmdq_enabled(smmu))
+		return;
+
+	while (!queue_empty(&smmu->cmdq_host.llq)) {
+		/* Wait for the command queue to have some space. */
+		WARN_ON(smmu_wait_event(smmu, !smmu_cmdq_full(&smmu->cmdq)));
+
+		idx =3D Q_IDX(&smmu->cmdq_host.llq, smmu->cmdq_host.llq.cons);
+		/* Avoid TOCTOU */
+		memcpy(cmd, &host_cmdq[idx * CMDQ_ENT_DWORDS], CMDQ_ENT_DWORDS << 3);
+		skip =3D smmu_filter_command(smmu, cmd);
+		if (!skip)
+			smmu_add_cmd_raw(smmu, cmd);
+		queue_inc_cons(&smmu->cmdq_host.llq);
+	}
+
+	/*
+	 * Wait till consumed, this can be improved a bit by returning to the hos=
t
+	 * while flagging the current offset in the command queue with the host,
+	 * this would be maintained from the hyp entering command or when the
+	 * host issuing another read to cons.
+	 */
+	WARN_ON(smmu_wait_event(smmu, smmu_cmdq_empty(&smmu->cmdq)));
+}
+
 static void smmu_emulate_cmdq_enable(struct hyp_arm_smmu_v3_device *smmu)
 {
 	size_t cmdq_size;
@@ -360,17 +442,37 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_d=
evice *smmu,
 		mask =3D read_only & ~(IDR0_S2P | IDR0_VMID16 | IDR0_MSI | IDR0_HYP);
 		WARN_ON(len !=3D sizeof(u32));
 		break;
-	/* Passthrough the register access for bisectiblity, handled later */
 	case ARM_SMMU_CMDQ_BASE:
=20
 		/* Not allowed by the architecture */
 		WARN_ON(is_cmdq_enabled(smmu));
 		if (is_write)
 			smmu->cmdq_host.q_base =3D val;
-		mask =3D read_write;
-		break;
+		else
+			regs->regs[rd] =3D smmu->cmdq_host.q_base;
+		goto out_ret;
 	case ARM_SMMU_CMDQ_PROD:
+		if (is_write) {
+			smmu->cmdq_host.llq.prod =3D val;
+			smmu_emulate_cmdq_insert(smmu);
+		} else {
+			regs->regs[rd] =3D smmu->cmdq_host.llq.prod;
+		}
+		goto out_ret;
 	case ARM_SMMU_CMDQ_CONS:
+		if (is_write) {
+			/* Not allowed by the architecture */
+			WARN_ON(is_cmdq_enabled(smmu));
+			smmu->cmdq_host.llq.cons =3D val;
+		} else {
+			/* Propagate errors back to the host.*/
+			u32 cons =3D readl_relaxed(smmu->base + ARM_SMMU_CMDQ_CONS);
+			u32 err =3D CMDQ_CONS_ERR & cons;
+
+			regs->regs[rd] =3D smmu->cmdq_host.llq.cons | err;
+		}
+		goto out_ret;
+	/* Passthrough the register access for bisectiblity, handled later */
 	case ARM_SMMU_STRTAB_BASE:
 	case ARM_SMMU_STRTAB_BASE_CFG:
 	case ARM_SMMU_GBPA:
--=20
2.51.0.rc1.167.g924127e9c0-goog


