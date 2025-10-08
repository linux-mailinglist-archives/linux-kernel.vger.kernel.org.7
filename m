Return-Path: <linux-kernel+bounces-845952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72D3BC68FC
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A462D407F3C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831622857E9;
	Wed,  8 Oct 2025 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opnsrc.net header.i=@opnsrc.net header.b="EG/KVrzm"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26375284B36
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954844; cv=none; b=BKO8bFAO4e4aClXdihDdleI3PM2HkHKARFG95eo1vryNt+5G2aogBKKuegcl6RqmFeLGY+JgQpQHXWEIBCqfQoLxUY3KOHA41T59aZsU0nJbb1hVKAKYMiduKwbhsTW0j9zbLHk1wy0slv3z2Qx/K+yVA+Y/IQhZvP5LmxYQjQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954844; c=relaxed/simple;
	bh=Kblm/YBuCqsYDj4lXesYlOM0jGmwKFYpGtWrm3NKd7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=REwAgxr8Mb/a4dHpJkTVC1gdVIr15wOgKTaZ2OHK07iSqM/AClpnFHtA+jIJZTp93F+dxTN/nskWHj1DPxOEuwOo+YrPriXCvHdNu+uOEF9O7rJ6gCXoafvrDL9bh1BrrqcxK89R0+sxgR+Cw84RTqGjpaALos3C0DityO3OgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=opnsrc.net; spf=pass smtp.mailfrom=opnsrc.net; dkim=pass (2048-bit key) header.d=opnsrc.net header.i=@opnsrc.net header.b=EG/KVrzm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=opnsrc.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opnsrc.net
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so2652495e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opnsrc.net; s=google; t=1759954840; x=1760559640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJNpPsdQklqfKtuRWABGJHNN5kI2pylvrPJggCRG4l0=;
        b=EG/KVrzm2BarQzCP0DhQEkCLGirvEzzLMX6r5m2L8F5n/MX60MSe0xffQwj5XL4r6K
         UF5/jpfEY0iHPohs2Qy3psu/utoffF/sUkhnQ0VPAA4E6QclivRoaNpXoFiBVVeXBC9G
         5qSt33o0AQqH/o+LPBF3blRwZBrfjVBV3O7BO8NmQkoauBCQPwkGtE8xvyCb1pCvCMSS
         kD1IE8Om0RzyVyvT3FMzwu2IH862cYvNLK2xJFYQ/kXlsG1mf+01ANAiikKnBWv7Iw4H
         N3Dx68VMhZOBuP0qZPZCfNv81teDv2/qxlTXYEJfEaQJEdLZth8Z3MSZg22e4nEqSq1T
         iKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759954840; x=1760559640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJNpPsdQklqfKtuRWABGJHNN5kI2pylvrPJggCRG4l0=;
        b=muA38zEa8qck18njQ6Ti7cUzChnCHJv8YsYBKRWxTIBjhItSLbqzR3fkOg0qwFWWPt
         d8hvjNiic3dz8cJxUlSi0JoEbHfvVTI6LEYsS4uDcqQTmo/orhjVHYtUjGzv9QsUF9Hs
         A+JmYJEBS7NSTFP27Z8rSNyXh/49ujg9AIBouI0AWods21ypXEKRXEzoFuoYGOhsrCvH
         zhfisKyQLlQ3MB+1B9fSjd5aEfwrUlrNyt83Xxl2bXGbbZj9G5vThsamsyt849hKQ67V
         aCdNImLyd29eCHOpZ409tVCnWiZrxbuwbdmgCYTuf48RfDJUyuOlCrOyhHvb6f8oEHyk
         4wtA==
X-Gm-Message-State: AOJu0YxPgMirCjn2eFSbgzd66Vq3G8eY9SPy3UySppa2jGnJUVrdGJbt
	RM+u2XlqtkyrznoiHaYTmrogf4VQTJdUr8IwZoQHsuOhxJpj4i/IzVVmsyQbEF70Nx8cOHJ0ljv
	bwDfnPwL10A==
X-Gm-Gg: ASbGncvCBx9wRcsGOAmG4Uz2+K2nnmZG4CouugbG9KmIK17cUF8XNG6CdNQSXOplNEq
	0QxAx8F08YJTTqSB5L33d2J+mDRQKW5OaUNL+cRHGcBxvlKqnG0BuWg6LXL9rfB9q29+fbj/iY3
	8N1AC+O80DIRjBeIgB2KZl5a1z0Is2zzsX0+0FVZ6TCL26UEq3aHHiQ4ynf9lrW1lCUPCGIODCz
	/gyGIGERqKAlM9XsmRMTdseu0Slh551qREEq87f4dIfw3zzQ46o0w+580DonZlETqNTZdA8JN8C
	VaFpewU079MWrU54TKMWvPDX9s98lc1bV0XXPiEXAu6HrlfgH5O9UqQC93h4QnOl1Tec57/QHmx
	9PANlegg0QJz49JWYiU1R0olC5193xLos0KLbSL3bsCc1Ozo2O7ZTkdcdtenpqlx3AT4sfYy46X
	hSU6/qOPftBl1Tp3pGjz3QKu6Vn5A+bJQzo8yJf/WxH3M=
X-Google-Smtp-Source: AGHT+IFM4K7XP4z2AGieVbbR2IlzDu8DLCDL4uKG4v9Kaas6lvil6rTJOq2Qsk2XBXTkAez+pnL+vQ==
X-Received: by 2002:a05:600c:c162:b0:45f:2cb5:ecff with SMTP id 5b1f17b1804b1-46fa9b02fa3mr40867845e9.31.1759954839949;
        Wed, 08 Oct 2025 13:20:39 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab64aed8sm20124745e9.10.2025.10.08.13.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:20:39 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: salil.mehta@huawei.com,
	jonathan.cameron@huawei.com,
	maz@kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	james.morse@arm.com,
	sudeep.holla@arm.com,
	lpieralisi@kernel.org,
	jean-philippe@linaro.org,
	tglx@linutronix.de,
	oliver.upton@linux.dev,
	peter.maydell@linaro.org,
	richard.henderson@linaro.org,
	andrew.jones@linux.dev,
	mst@redhat.com,
	david@redhat.com,
	philmd@linaro.org,
	ardb@kernel.org,
	borntraeger@linux.ibm.com,
	alex.bennee@linaro.org,
	gustavo.romero@linaro.org,
	npiggin@gmail.com,
	linux@armlinux.org.uk,
	karl.heubaum@oracle.com,
	miguel.luis@oracle.com,
	darren@os.amperecomputing.com,
	ilkka@os.amperecomputing.com,
	vishnu@os.amperecomputing.com,
	gankulkarni@os.amperecomputing.com,
	salil.mehta@opnsrc.net,
	wangyanan55@huawei.com,
	wangzhou1@hisilicon.com,
	linuxarm@huawei.com
Subject: [RFC PATCH] KVM: arm64: vgic-v3: Cache ICC_CTLR_EL1 and allow lockless read when ready
Date: Wed,  8 Oct 2025 20:19:55 +0000
Message-Id: <20251008201955.3919537-1-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Salil Mehta <salil.mehta@huawei.com>

[A rough illustration of the problem and the probable solution]

Userspace reads of ICC_CTLR_EL1 via KVM device attributes currently takes a slow
path that may acquire all vCPU locks. Under workloads that exercise userspace
PSCI CPU_ON flows or frequent vCPU resets, this can cause vCPU lock contention
in KVM and, in the worst cases, -EBUSY returns to userspace.

When PSCI CPU_ON and CPU_OFF calls are handled entirely in KVM, these operations
are executed under KVM vCPU locks in the host kernel (EL1) and appear atomic to
other vCPU threads. In this context, system register accesses are serialized
under KVM vCPU locks, ensuring atomicity with respect to other vCPUs. After
SMCCC filtering was introduced, PSCI CPU_ON and CPU_OFF calls can now exit to
userspace (QEMU). During the handling of PSCI CPU_ON call in userspace, a
cpu_reset() is exerted which reads ICC_CTLR_EL1 through KVM device attribute
IOCTLs. To avoid transient inconsistency and -EBUSY errors, QEMU is forced to
pause all vCPUs before issuing these IOCTLs. Later operation should be avoided
as it ends up in freezing VM till the entire KVM device IOCTL operation is
completed (and this could happen every time when PSCI CPU_ON is requested by
the Guest user). There are also known issues with the implementaiton of the
{pause, resume}_all_vcpus() in the QEMU which can lead to race conditions.

Introduce a per-vCPU shadow of ICC_CTLR_EL1 that allows userspace to read this
register without taking any vCPU-wide locks once the VGIC has been initialized.
The new helper vgic_v3_try_icc_ctlr_el1_lockless_access() attempts a fast,
lockless read of the per-vCPU shadow and returns -EBUSY if the VGIC is not yet
initialized, allowing the caller to fall back to the existing contended path.
This reduces cross-vCPU contention and prevents spurious -EBUSY errors during
userspace-driven CPU_ON sequences, without changing architectural behaviour.

The shadow is updated in set_gic_ctlr(): after VMCR fields are written, we
recompute ICC_CTLR_EL1 via get_gic_ctlr(). Writes remain unchanged and continue
to use the existing synchronized path.

Without this change, QEMU must cache ICC_CTLR_EL1 itself to avoid racy
pause_all_vcpus() usage during cpu_reset(), as described in:
https://lore.kernel.org/qemu-devel/20251001010127.3092631-22-salil.mehta@opnsrc.net/

RFC Discussion (Architectural Considerations):
=============================================

It might have been helpful if the ARM architecture were to have clearer
boundaries between dynamic and static (or pseudo-static) system registers(?)
Registers such as ICC_CTLR_EL1 contain configuration fields that are effectively
static once the VM is initialized (even the EOIMode, CBPR & PMHE are guest
GICv3 driver configured constants), yet the architecture allows them to coexist
with other more dynamic runtime fields of the ICH_ VMCR_EL2. If these
configuration registers had been architecturally immutable after VM
initialization, their accesses could have avoided expensive all-vCPU locking
otherwise required to guarantee atomic visibility across vCPUs.

ICC_CTLR_EL1 [63:0]

  63                                                                       32
 +---------------------------------------------------------------------------+
 |                                   RES0                                    |
 +---------------------------------------------------------------------------+
  31        20 19 18 17 16 15 14 13 12 11 10   9   8  7  6   5  4  3  2  1  0
 +------------+--+--+--+--+--+--+--+--+--+---+---+---+--+--+--+--+--+--+--+--+
 |    RES0    |Ex|RS|RES0 |A3|SE| IDbits |  PRIbits  |R0|PM|  RES0     |EO|CB|
 +------------+--+--+--+--+--+--+--+--+--+---+---+---+--+--+--+--+--+--+--+--+
              |  |        |  |                       |   |             |  |
              |  |        |  |                       |   |             |  +CBPR
              |  |        |  |                       |   |             +EOImode
              |  |        |  |                       |   +-PMHE
              |  |        |  |                       +----RES0
              |  |        |  +--SEIS
              |  |        +-----A3V
              |  +--------------RSS
              +-----------------ExtRange

 Access: {Ex, RS, A3, SE, IDbits, PRIbits} = RO;
         {PMHE} = RW*;
         {EO, CB} = RW**;
	 others = RES0.
 Notes : * impl-def (may be RO when DS=0)
         ** CB may be RO when DS=0 (EO stays RW)

 Source: Arm GIC Architecture Specification (IHI 0069H.b),
         §12.2.6 “ICC_CTLR_EL1”, pp. 12-233…12-237

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 arch/arm64/kvm/vgic-sys-reg-v3.c      | 14 ++++++++++++
 arch/arm64/kvm/vgic/vgic-kvm-device.c | 32 +++++++++++++++++++++++++++
 include/kvm/arm_vgic.h                |  3 +++
 3 files changed, 49 insertions(+)

diff --git a/arch/arm64/kvm/vgic-sys-reg-v3.c b/arch/arm64/kvm/vgic-sys-reg-v3.c
index bdc2d57370b2..80d6e38b4aa7 100644
--- a/arch/arm64/kvm/vgic-sys-reg-v3.c
+++ b/arch/arm64/kvm/vgic-sys-reg-v3.c
@@ -10,12 +10,17 @@
 #include "vgic/vgic.h"
 #include "sys_regs.h"
 
+static int get_gic_ctlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			u64 *valp);
+
 static int set_gic_ctlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 			u64 val)
 {
 	u32 host_pri_bits, host_id_bits, host_seis, host_a3v, seis, a3v;
+	struct vgic_v3_cpu_if *cif = &vcpu->arch.vgic_cpu.vgic_v3;
 	struct vgic_cpu *vgic_v3_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_vmcr vmcr;
+	u64 sysreg;
 
 	vgic_get_vmcr(vcpu, &vmcr);
 
@@ -53,6 +58,15 @@ static int set_gic_ctlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	vmcr.eoim = FIELD_GET(ICC_CTLR_EL1_EOImode_MASK, val);
 	vgic_set_vmcr(vcpu, &vmcr);
 
+	/* update the ICC_CTLR_EL1 shadow, if required */
+	get_gic_ctlr(vcpu, r, &sysreg);
+
+	/*
+	 * Update the ICC_CTLR_EL1 shadow to allow lock free access of static
+	 * or pesudo static register fields from KVM device IOCTLs
+	 */
+	cif->icc_ctlr_el1_shadow = (u32)sysreg;
+
 	return 0;
 }
 
diff --git a/arch/arm64/kvm/vgic/vgic-kvm-device.c b/arch/arm64/kvm/vgic/vgic-kvm-device.c
index 3d1a776b716d..4a2971525c1a 100644
--- a/arch/arm64/kvm/vgic/vgic-kvm-device.c
+++ b/arch/arm64/kvm/vgic/vgic-kvm-device.c
@@ -522,6 +522,29 @@ static bool reg_allowed_pre_init(struct kvm_device_attr *attr)
 	}
 }
 
+/*
+ * Fast, lockless read of ICC_CTLR_EL1 for userspace ioctl. Saves calls from
+ * -EBUSY due to inability to acquire vCPU mutexes for all the vCPUs
+ */
+static inline int
+vgic_v3_try_icc_ctlr_el1_lockless_access(struct kvm_device *dev,
+                                         const struct kvm_device_attr *attr,
+                                         struct kvm_vcpu *vcpu)
+{
+	struct vgic_v3_cpu_if *vgic_cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
+	u32 __user *uaddr;
+	u32 shadow;
+
+	/* pathological check, in case we are here too early */
+	if (!vgic_initialized(dev->kvm))
+		return -EBUSY;
+
+	shadow = vgic_cpu_if->icc_ctlr_el1_shadow;
+	uaddr = (u32 __user *)(unsigned long)attr->addr;
+
+	return put_user(shadow, uaddr) ? -EFAULT : 0;
+}
+
 /*
  * vgic_v3_attr_regs_access - allows user space to access VGIC v3 state
  *
@@ -533,6 +556,7 @@ static int vgic_v3_attr_regs_access(struct kvm_device *dev,
 				    struct kvm_device_attr *attr,
 				    bool is_write)
 {
+	u32 sysreg = attr->attr & ~KVM_DEV_ARM_VGIC_CPUID_MASK;
 	struct vgic_reg_attr reg_attr;
 	gpa_t addr;
 	struct kvm_vcpu *vcpu;
@@ -549,6 +573,14 @@ static int vgic_v3_attr_regs_access(struct kvm_device *dev,
 
 	switch (attr->group) {
 	case KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS:
+		/* Try lockless ICC_CTLR_EL1 read first */
+		if (!is_write && sysreg == SYS_ICC_CTLR_EL1) {
+			ret = vgic_v3_try_icc_ctlr_el1_lockless_access(dev,
+				 attr, vcpu);
+			if(!ret)
+				return ret;
+		}
+
 		/* Sysregs uaccess is performed by the sysreg handling code */
 		uaccess = false;
 		break;
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 4000ff16f295..42c767c62291 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -334,6 +334,9 @@ struct vgic_v3_cpu_if {
 	struct its_vpe	its_vpe;
 
 	unsigned int used_lrs;
+
+	/* ICC_CTLR_EL1 shadow (published to readers) */
+	u32 icc_ctlr_el1_shadow; /* upper 32 bits of this reg are reserved */
 };
 
 struct vgic_cpu {
-- 
2.34.1


