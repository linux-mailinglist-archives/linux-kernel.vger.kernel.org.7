Return-Path: <linux-kernel+bounces-586644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8153A7A1F4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 13:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C2C18982C3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 11:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E02524E00C;
	Thu,  3 Apr 2025 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MohUbOon"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BBB24C076
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743679938; cv=none; b=JUZxxfb0BdmKceLKbnGWUD/4/AgInSDBd15cWaqdDpGkPw+5Su83lNcE85OumVi7R+FFvf9GZ1Q3nLKodlhTarYSQu7IFrI5LP6ad908lUxTf1ET/kCb1CvG2vzuor0G2o7y/TA64Tp06GzdZqnBOLVfockPoUMY7VoNlooqCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743679938; c=relaxed/simple;
	bh=mPYFlhbqwUJghQgdiJTQpQAylQDiVF48Xvlg8qS+To8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BadbyPWynWTwA5QKhDTL0yEo5wwmjRjpPm2AiGEDD9g+iwpSatXl3zEJsZ6dWlsBkb7czSMghsXDFkBi7b0lEo2mRatEMgXxd/Wsqa8Lx1bG304ODHc5KBNLlRnpgLBwcx4yrMl4/LjE5jin5Cy81I2Cr0GKuokJ0cPUYSODVdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MohUbOon; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3912b75c0f2so54784f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Apr 2025 04:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1743679934; x=1744284734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXWumzDe9cV0GiyZzQ4x/1N6jIE102NsKwOmEpuNc8U=;
        b=MohUbOonnRMhVtguRhvo6fGiyVM1wu0WKomRTg3SlY0rN+YN8S+LNN4ZaJPIyruPeY
         n0Yc+LfmHIUFtU+r3DqT2lc6dKEBkUijijUNZ43wa2sqxPRpKdkFlf1g75ihR9dqs3cL
         ZBoqn1HR9t5M1OrusqUz7MBYyKta8t8PGYS9p6yrHG4jRAMCnesr9UTPsRaIP73Ewr+e
         quTOE6TBVWmL9RqvirmYqJQsj68o7rFXgs1r0R6TvJUbb7S9lhHY0/E1F4HYXl2MuKqp
         63kVCScGfSnqGFHYM0cqJoH4bmPk7MYFlRwNvuc2o/P+fY334ZzIosh4nFpUGSx7vMW3
         7P9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743679934; x=1744284734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXWumzDe9cV0GiyZzQ4x/1N6jIE102NsKwOmEpuNc8U=;
        b=a8p4CxGOQXMnSrdyMkxlzjEuYvSo7RJyLoO3t0vTP+xueF3gK9LaJxIMZocvao7Kx1
         B+LCUlbThPlZ2FdOAfKuM+up/9LzBkgpyiZK5Zz5lGj9GRCXaiO6UrpvIAl8HnTrNLrQ
         DIrE1lup9WLHSGUXOSEtyp3+hPlkeakhZ3Iq2P6tNzCRs4o+gh/8DLip6ii6XQsrouTY
         qRxFh693miZ9gfKirF87ZIOiDMRpgaASp4hoSaxN5aKa0EticY1YU4fcXjB+XJVJRUol
         iDrjjT1KDOX5tpImkWenXJxlN9t07nEsEWIMymgfjB5WZNEPxggrTmidSMX66ZWaPxqM
         fpzw==
X-Forwarded-Encrypted: i=1; AJvYcCWufSsn9xlXGj5erNI2mKGJvIPKLvWvFzJetOk0xcvjpQAhizNbTUnZL+rRu2DhC6M82l85ypQtShyavvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3RU0ghOf6xYGhxCoyghN0i62+tXtijQZ1gcbjSW7gxAZhbIQL
	Kko8mrd0sR51jWgGBbjkOtHZixcLX0vZN5bQT2GwwS+IT6vTFGIv7WDXPuEnr64=
X-Gm-Gg: ASbGnct8m3lvXrjzbh+C/PmQCUSE70lTS5tI774vkadR7BkukZBTp/k963pT0CqRPF2
	pJ0mMldBFQqu7519JyRJQ7+f6aS6czz6ABWp4LaqG9EyPiuYIy7d6oeRjO4CYMPQAO6pdwwLpIx
	f3FoYWGYIa4voZZJTkePtizaka2RJ/NmIzB9MPYgPM1tfw2LqequVlldanOMb+vKdpg1KPbWNE6
	zHwmq3wFZ4ll8U8ZdgPGsJ0oVFBJ+BqfFxb/beErGH1dDIYUWvmeQayHQ1dtf2oJtjlD3cnFKD+
	UReYh0UGSX3i+RD7w+Oa9y1iTGwjWDjIaTYNgZ6dDEER2N7cND21Aoxlgbwf1nAMZs6sGgILwVC
	gqA==
X-Google-Smtp-Source: AGHT+IGYZA79TpGdD3IyE6RBBx1HPlO32wDC9YCrigfm8LcUPmDgc+MGuI/dN03f02oGXug0YpJyDw==
X-Received: by 2002:a5d:5f8d:0:b0:386:3a50:8c52 with SMTP id ffacd0b85a97d-39c2470a9a8mr3130677f8f.7.1743679934361;
        Thu, 03 Apr 2025 04:32:14 -0700 (PDT)
Received: from localhost (cst2-173-141.cust.vodafone.cz. [31.30.173.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7045sm1584106f8f.39.2025.04.03.04.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 04:32:14 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: kvm-riscv@lists.infradead.org
Cc: kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH 3/5] KVM: RISC-V: remove unnecessary SBI reset state
Date: Thu,  3 Apr 2025 13:25:22 +0200
Message-ID: <20250403112522.1566629-6-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250403112522.1566629-3-rkrcmar@ventanamicro.com>
References: <20250403112522.1566629-3-rkrcmar@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The SBI reset state has only two variables -- pc and a1.
The rest is known, so keep only the necessary information.

The reset structures make sense if we want userspace to control the
reset state (which we do), but I'd still remove them now and reintroduce
with the userspace interface later -- we could probably have just a
single reset state per VM, instead of a reset state for each VCPU.

Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_aia.h  |  3 --
 arch/riscv/include/asm/kvm_host.h | 12 ++++---
 arch/riscv/kvm/aia_device.c       |  4 +--
 arch/riscv/kvm/vcpu.c             | 58 +++++++++++++++++--------------
 arch/riscv/kvm/vcpu_sbi.c         |  9 +++--
 5 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
index 1f37b600ca47..3b643b9efc07 100644
--- a/arch/riscv/include/asm/kvm_aia.h
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -63,9 +63,6 @@ struct kvm_vcpu_aia {
 	/* CPU AIA CSR context of Guest VCPU */
 	struct kvm_vcpu_aia_csr guest_csr;
 
-	/* CPU AIA CSR context upon Guest VCPU reset */
-	struct kvm_vcpu_aia_csr guest_reset_csr;
-
 	/* Guest physical address of IMSIC for this VCPU */
 	gpa_t		imsic_addr;
 
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 0e9c2fab6378..0c8c9c05af91 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -193,6 +193,12 @@ struct kvm_vcpu_smstateen_csr {
 	unsigned long sstateen0;
 };
 
+struct kvm_vcpu_reset_state {
+	spinlock_t lock;
+	unsigned long pc;
+	unsigned long a1;
+};
+
 struct kvm_vcpu_arch {
 	/* VCPU ran at least once */
 	bool ran_atleast_once;
@@ -227,12 +233,8 @@ struct kvm_vcpu_arch {
 	/* CPU Smstateen CSR context of Guest VCPU */
 	struct kvm_vcpu_smstateen_csr smstateen_csr;
 
-	/* CPU context upon Guest VCPU reset */
-	struct kvm_cpu_context guest_reset_context;
-	spinlock_t reset_cntx_lock;
+	struct kvm_vcpu_reset_state reset_state;
 
-	/* CPU CSR context upon Guest VCPU reset */
-	struct kvm_vcpu_csr guest_reset_csr;
 
 	/*
 	 * VCPU interrupts
diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index 39cd26af5a69..43e472ff3e1a 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -526,12 +526,10 @@ int kvm_riscv_vcpu_aia_update(struct kvm_vcpu *vcpu)
 void kvm_riscv_vcpu_aia_reset(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
-	struct kvm_vcpu_aia_csr *reset_csr =
-				&vcpu->arch.aia_context.guest_reset_csr;
 
 	if (!kvm_riscv_aia_available())
 		return;
-	memcpy(csr, reset_csr, sizeof(*csr));
+	memset(csr, 0, sizeof(*csr));
 
 	/* Proceed only if AIA was initialized successfully */
 	if (!kvm_riscv_aia_initialized(vcpu->kvm))
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 2fb75288ecfe..b8485c1c1ce4 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -51,13 +51,40 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
-static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
+static void kvm_riscv_vcpu_context_reset(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
-	struct kvm_vcpu_csr *reset_csr = &vcpu->arch.guest_reset_csr;
 	struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
-	struct kvm_cpu_context *reset_cntx = &vcpu->arch.guest_reset_context;
+	struct kvm_vcpu_reset_state *reset_state = &vcpu->arch.reset_state;
 	void *vector_datap = cntx->vector.datap;
+
+	memset(cntx, 0, sizeof(*cntx));
+	memset(csr, 0, sizeof(*csr));
+
+	/* Restore datap as it's not a part of the guest context. */
+	cntx->vector.datap = vector_datap;
+
+	/* Load SBI reset values */
+	cntx->a0 = vcpu->vcpu_id;
+
+	spin_lock(&reset_state->lock);
+	cntx->sepc = reset_state->pc;
+	cntx->a1 = reset_state->a1;
+	spin_unlock(&reset_state->lock);
+
+	/* Setup reset state of shadow SSTATUS and HSTATUS CSRs */
+	cntx->sstatus = SR_SPP | SR_SPIE;
+
+	cntx->hstatus |= HSTATUS_VTW;
+	cntx->hstatus |= HSTATUS_SPVP;
+	cntx->hstatus |= HSTATUS_SPV;
+
+	/* By default, make CY, TM, and IR counters accessible in VU mode */
+	csr->scounteren = 0x7;
+}
+
+static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
+{
 	bool loaded;
 
 	/**
@@ -72,16 +99,10 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.last_exit_cpu = -1;
 
-	memcpy(csr, reset_csr, sizeof(*csr));
-
-	spin_lock(&vcpu->arch.reset_cntx_lock);
-	memcpy(cntx, reset_cntx, sizeof(*cntx));
-	spin_unlock(&vcpu->arch.reset_cntx_lock);
+	kvm_riscv_vcpu_context_reset(vcpu);
 
 	kvm_riscv_vcpu_fp_reset(vcpu);
 
-	/* Restore datap as it's not a part of the guest context. */
-	cntx->vector.datap = vector_datap;
 	kvm_riscv_vcpu_vector_reset(vcpu);
 
 	kvm_riscv_vcpu_timer_reset(vcpu);
@@ -113,8 +134,6 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	int rc;
-	struct kvm_cpu_context *cntx;
-	struct kvm_vcpu_csr *reset_csr = &vcpu->arch.guest_reset_csr;
 
 	spin_lock_init(&vcpu->arch.mp_state_lock);
 
@@ -134,24 +153,11 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	/* Setup VCPU hfence queue */
 	spin_lock_init(&vcpu->arch.hfence_lock);
 
-	/* Setup reset state of shadow SSTATUS and HSTATUS CSRs */
-	spin_lock_init(&vcpu->arch.reset_cntx_lock);
-
-	spin_lock(&vcpu->arch.reset_cntx_lock);
-	cntx = &vcpu->arch.guest_reset_context;
-	cntx->sstatus = SR_SPP | SR_SPIE;
-	cntx->hstatus = 0;
-	cntx->hstatus |= HSTATUS_VTW;
-	cntx->hstatus |= HSTATUS_SPVP;
-	cntx->hstatus |= HSTATUS_SPV;
-	spin_unlock(&vcpu->arch.reset_cntx_lock);
+	spin_lock_init(&vcpu->arch.reset_state.lock);
 
 	if (kvm_riscv_vcpu_alloc_vector_context(vcpu))
 		return -ENOMEM;
 
-	/* By default, make CY, TM, and IR counters accessible in VU mode */
-	reset_csr->scounteren = 0x7;
-
 	/* Setup VCPU timer */
 	kvm_riscv_vcpu_timer_init(vcpu);
 
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index f58368f7df1d..3d7955e05cc3 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -159,11 +159,10 @@ void kvm_riscv_vcpu_sbi_system_reset(struct kvm_vcpu *vcpu,
 void kvm_riscv_vcpu_sbi_request_reset(struct kvm_vcpu *vcpu,
                                       unsigned long pc, unsigned long a1)
 {
-	spin_lock(&vcpu->arch.reset_cntx_lock);
-	vcpu->arch.guest_reset_context.sepc = pc;
-	vcpu->arch.guest_reset_context.a0 = vcpu->vcpu_id;
-	vcpu->arch.guest_reset_context.a1 = a1;
-	spin_unlock(&vcpu->arch.reset_cntx_lock);
+	spin_lock(&vcpu->arch.reset_state.lock);
+	vcpu->arch.reset_state.pc = pc;
+	vcpu->arch.reset_state.a1 = a1;
+	spin_unlock(&vcpu->arch.reset_state.lock);
 
 	kvm_make_request(KVM_REQ_VCPU_RESET, vcpu);
 }
-- 
2.48.1


