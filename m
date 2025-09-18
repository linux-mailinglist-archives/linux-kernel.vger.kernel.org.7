Return-Path: <linux-kernel+bounces-810265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B6EB517F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD06563929
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DC531C582;
	Wed, 10 Sep 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ik2HyNEH"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCF31D38A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511044; cv=none; b=IaF6djITNKbZgTupjF8aprVlQNZc3tgrVUO1oglRgtxhngqzThHDoRf6nn5iMDSU6iS8j9KiDmd01mR171R6jtZRnkxhGqUwo1uBdu1tgesSR32SOU0UkWEKV20etvQIadxJCmGz0QFdIaHYUUMdgd6ZOGm6U2yNb0SDP2ibDSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511044; c=relaxed/simple;
	bh=kz9MnwLNIUYhd2kABpkYHoQ5hZMb1yb52o3pVdxHCew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d5oL8oTpJwKWv1GTfGSzMEWw1QdPPHP6s2EtJWVjAijVV7ubL1G6NdM7PrPhw8wUbianpwckH+lH/vP62UjqNBc/QUABquUEnrQypoE0rjVUSTNT4LnFABJcXFMTTQ7scfFIwPoTokMggPZv9MDosNWOLV3H0pMxPLJBCEOIvkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ik2HyNEH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e5190bca95so2858954f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757511040; x=1758115840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHj3jpCjC14hsHFHiScJPY4VVnYPCcVygwtJKAlE9Pc=;
        b=Ik2HyNEHg3CLNIie2PQpSSB+0G6MiJoZvUVK4JvcfPMLBPsp0kg7yy29BNiDMw+WFZ
         gWc0hpbCKamw4Y3BdHJWu/z7R/FOg9vRcVOp8gBZXz/rzPDFkOqn4OIwDUk7xo2e8Ptv
         dkyi6qnO1QkZo1mltuREaVO6rwpOJ6YlJ5l743WMpp+schEHhTuODppd3UdQZU4LrO3q
         KsbmUtaiCei7+O6mE5gB66tp3izdQwMCbUfb+CqeYeA/8+2mXVgNUtsZP0vkSuKk9/FI
         sjI7WPu2/XFP8k1Me6Ju/K/0LgotqCfVei2s8GESGpqaEUGJMSpKSY/LM+vNHj6EtNsv
         +qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757511040; x=1758115840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHj3jpCjC14hsHFHiScJPY4VVnYPCcVygwtJKAlE9Pc=;
        b=DKhJBu+QiDGLHLV1I6QAXX5KaRNiuHaT5Ouh7YkeHykeU7Ig1xd98ILSe06hK5ev9K
         Ne62OB5G8uwb3pJMRuIrYnVGXSEJp27zpDm7FdDrKjg0nXV/ny/QhEuu7BsSVuUyJZvn
         EvDncPg4RF78GcagOG+L2oQuWqGVKn5/5EjkNF0tTclmEqHcPTxe69MXRttr0VSRLWIP
         xZiTjNXaahegmZP5Q3h1A2Q+KJnlyTDA9kbvcTsgA+WKlWY1mCBcHN3fy1BhmE+ZQmsO
         9hrvPpb2oTfG5G53waqoTi+Mpqf7ZN7v5hDhP03QKljzFsHS1A2GgVkjK1R/CUk1TlvB
         R7Cg==
X-Gm-Message-State: AOJu0YxJ/bbO5CXRzQuYzhNoMuXkwZmUsFv6Yx17Lt3rcsI3V3JGkuFx
	aPtRy3lO7JXK0FU+2i01k64sS0CFj+xladkCg0kAsk+XcRzzel6IWPkSWb9pOGGKtz0=
X-Gm-Gg: ASbGncsumQdp87w33JdiQDIQros/vJauT7T7QhL3zj/iWVN4ZAY9C9kpvnjohIcq/yZ
	t8WVs+H1Mpc3HrJ+0rW2MQSUebCFJMDtNNrG4Rc3E13eyYPyGXkAW8POLSGq57qgERnIdDr1bgY
	7i1PLxHI50sUtGiuh45kxmoQCeqLoP/NYqSEehWhe/oIz9ygemqT0Zc4avxsqHo6VxFkrcVVFMO
	hZjI6v+XndcQkY+9X26JI8jEl1BNzLyxRNrBS/TrDSVF6tcuoGbtB7bpmxibU6LnGc/EumGpUY1
	NujE4C2aDc2p+Sx407LSnIfZTDO/AOZswbJjrj11YT8q7WKB7iE0nEUsfPkOKRMgIJQA4Zi75Qn
	9C6Tkr5eMXgPUHrl75O7fcZ2WV1fFq/qvRNEJQo4FGg==
X-Google-Smtp-Source: AGHT+IGxJ3d0IbZk0QFkWaQFMnTLapDBIVf9YBlvK22flTeZA+QR8ISTEO0QCN2ZGUVkJRMoHxV1Ig==
X-Received: by 2002:a05:6000:2dc6:b0:3e3:dc04:7e1e with SMTP id ffacd0b85a97d-3e641e3ca70mr11029407f8f.7.1757511040385;
        Wed, 10 Sep 2025 06:30:40 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df16070bdsm30387015e9.3.2025.09.10.06.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:30:39 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 10 Sep 2025 14:30:12 +0100
Subject: [PATCH 2/2] tools headers: Remove unused arm32 asm/kvm.h copy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-james-tools-header-cleanup-v1-2-7ae4bedc99e0@linaro.org>
References: <20250910-james-tools-header-cleanup-v1-0-7ae4bedc99e0@linaro.org>
In-Reply-To: <20250910-james-tools-header-cleanup-v1-0-7ae4bedc99e0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

arm32 KVM was removed in commit 541ad0150ca4 ("arm: Remove 32bit KVM
host support"). None of the kvm selftests are compiled for arm32 and
it's not indirectly included from anywhere either, so delete it.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/arch/arm/include/uapi/asm/kvm.h | 315 ----------------------------------
 tools/perf/check-headers.sh           |   1 -
 2 files changed, 316 deletions(-)

diff --git a/tools/arch/arm/include/uapi/asm/kvm.h b/tools/arch/arm/include/uapi/asm/kvm.h
deleted file mode 100644
index d5dd969028175..0000000000000
--- a/tools/arch/arm/include/uapi/asm/kvm.h
+++ /dev/null
@@ -1,315 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2012 - Virtual Open Systems and Columbia University
- * Author: Christoffer Dall <c.dall@virtualopensystems.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
- */
-
-#ifndef __ARM_KVM_H__
-#define __ARM_KVM_H__
-
-#include <linux/types.h>
-#include <linux/psci.h>
-#include <asm/ptrace.h>
-
-#define __KVM_HAVE_GUEST_DEBUG
-#define __KVM_HAVE_IRQ_LINE
-#define __KVM_HAVE_READONLY_MEM
-#define __KVM_HAVE_VCPU_EVENTS
-
-#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
-
-#define KVM_REG_SIZE(id)						\
-	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
-
-/* Valid for svc_regs, abt_regs, und_regs, irq_regs in struct kvm_regs */
-#define KVM_ARM_SVC_sp		svc_regs[0]
-#define KVM_ARM_SVC_lr		svc_regs[1]
-#define KVM_ARM_SVC_spsr	svc_regs[2]
-#define KVM_ARM_ABT_sp		abt_regs[0]
-#define KVM_ARM_ABT_lr		abt_regs[1]
-#define KVM_ARM_ABT_spsr	abt_regs[2]
-#define KVM_ARM_UND_sp		und_regs[0]
-#define KVM_ARM_UND_lr		und_regs[1]
-#define KVM_ARM_UND_spsr	und_regs[2]
-#define KVM_ARM_IRQ_sp		irq_regs[0]
-#define KVM_ARM_IRQ_lr		irq_regs[1]
-#define KVM_ARM_IRQ_spsr	irq_regs[2]
-
-/* Valid only for fiq_regs in struct kvm_regs */
-#define KVM_ARM_FIQ_r8		fiq_regs[0]
-#define KVM_ARM_FIQ_r9		fiq_regs[1]
-#define KVM_ARM_FIQ_r10		fiq_regs[2]
-#define KVM_ARM_FIQ_fp		fiq_regs[3]
-#define KVM_ARM_FIQ_ip		fiq_regs[4]
-#define KVM_ARM_FIQ_sp		fiq_regs[5]
-#define KVM_ARM_FIQ_lr		fiq_regs[6]
-#define KVM_ARM_FIQ_spsr	fiq_regs[7]
-
-struct kvm_regs {
-	struct pt_regs usr_regs;	/* R0_usr - R14_usr, PC, CPSR */
-	unsigned long svc_regs[3];	/* SP_svc, LR_svc, SPSR_svc */
-	unsigned long abt_regs[3];	/* SP_abt, LR_abt, SPSR_abt */
-	unsigned long und_regs[3];	/* SP_und, LR_und, SPSR_und */
-	unsigned long irq_regs[3];	/* SP_irq, LR_irq, SPSR_irq */
-	unsigned long fiq_regs[8];	/* R8_fiq - R14_fiq, SPSR_fiq */
-};
-
-/* Supported Processor Types */
-#define KVM_ARM_TARGET_CORTEX_A15	0
-#define KVM_ARM_TARGET_CORTEX_A7	1
-#define KVM_ARM_NUM_TARGETS		2
-
-/* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
-#define KVM_ARM_DEVICE_TYPE_SHIFT	0
-#define KVM_ARM_DEVICE_TYPE_MASK	(0xffff << KVM_ARM_DEVICE_TYPE_SHIFT)
-#define KVM_ARM_DEVICE_ID_SHIFT		16
-#define KVM_ARM_DEVICE_ID_MASK		(0xffff << KVM_ARM_DEVICE_ID_SHIFT)
-
-/* Supported device IDs */
-#define KVM_ARM_DEVICE_VGIC_V2		0
-
-/* Supported VGIC address types  */
-#define KVM_VGIC_V2_ADDR_TYPE_DIST	0
-#define KVM_VGIC_V2_ADDR_TYPE_CPU	1
-
-#define KVM_VGIC_V2_DIST_SIZE		0x1000
-#define KVM_VGIC_V2_CPU_SIZE		0x2000
-
-/* Supported VGICv3 address types  */
-#define KVM_VGIC_V3_ADDR_TYPE_DIST	2
-#define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
-#define KVM_VGIC_ITS_ADDR_TYPE		4
-#define KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION	5
-
-#define KVM_VGIC_V3_DIST_SIZE		SZ_64K
-#define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
-#define KVM_VGIC_V3_ITS_SIZE		(2 * SZ_64K)
-
-#define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
-#define KVM_ARM_VCPU_PSCI_0_2		1 /* CPU uses PSCI v0.2 */
-
-struct kvm_vcpu_init {
-	__u32 target;
-	__u32 features[7];
-};
-
-struct kvm_sregs {
-};
-
-struct kvm_fpu {
-};
-
-struct kvm_guest_debug_arch {
-};
-
-struct kvm_debug_exit_arch {
-};
-
-struct kvm_sync_regs {
-	/* Used with KVM_CAP_ARM_USER_IRQ */
-	__u64 device_irq_level;
-};
-
-struct kvm_arch_memory_slot {
-};
-
-/* for KVM_GET/SET_VCPU_EVENTS */
-struct kvm_vcpu_events {
-	struct {
-		__u8 serror_pending;
-		__u8 serror_has_esr;
-		__u8 ext_dabt_pending;
-		/* Align it to 8 bytes */
-		__u8 pad[5];
-		__u64 serror_esr;
-	} exception;
-	__u32 reserved[12];
-};
-
-/* If you need to interpret the index values, here is the key: */
-#define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
-#define KVM_REG_ARM_COPROC_SHIFT	16
-#define KVM_REG_ARM_32_OPC2_MASK	0x0000000000000007
-#define KVM_REG_ARM_32_OPC2_SHIFT	0
-#define KVM_REG_ARM_OPC1_MASK		0x0000000000000078
-#define KVM_REG_ARM_OPC1_SHIFT		3
-#define KVM_REG_ARM_CRM_MASK		0x0000000000000780
-#define KVM_REG_ARM_CRM_SHIFT		7
-#define KVM_REG_ARM_32_CRN_MASK		0x0000000000007800
-#define KVM_REG_ARM_32_CRN_SHIFT	11
-/*
- * For KVM currently all guest registers are nonsecure, but we reserve a bit
- * in the encoding to distinguish secure from nonsecure for AArch32 system
- * registers that are banked by security. This is 1 for the secure banked
- * register, and 0 for the nonsecure banked register or if the register is
- * not banked by security.
- */
-#define KVM_REG_ARM_SECURE_MASK	0x0000000010000000
-#define KVM_REG_ARM_SECURE_SHIFT	28
-
-#define ARM_CP15_REG_SHIFT_MASK(x,n) \
-	(((x) << KVM_REG_ARM_ ## n ## _SHIFT) & KVM_REG_ARM_ ## n ## _MASK)
-
-#define __ARM_CP15_REG(op1,crn,crm,op2) \
-	(KVM_REG_ARM | (15 << KVM_REG_ARM_COPROC_SHIFT) | \
-	ARM_CP15_REG_SHIFT_MASK(op1, OPC1) | \
-	ARM_CP15_REG_SHIFT_MASK(crn, 32_CRN) | \
-	ARM_CP15_REG_SHIFT_MASK(crm, CRM) | \
-	ARM_CP15_REG_SHIFT_MASK(op2, 32_OPC2))
-
-#define ARM_CP15_REG32(...) (__ARM_CP15_REG(__VA_ARGS__) | KVM_REG_SIZE_U32)
-
-#define __ARM_CP15_REG64(op1,crm) \
-	(__ARM_CP15_REG(op1, 0, crm, 0) | KVM_REG_SIZE_U64)
-#define ARM_CP15_REG64(...) __ARM_CP15_REG64(__VA_ARGS__)
-
-/* PL1 Physical Timer Registers */
-#define KVM_REG_ARM_PTIMER_CTL		ARM_CP15_REG32(0, 14, 2, 1)
-#define KVM_REG_ARM_PTIMER_CNT		ARM_CP15_REG64(0, 14)
-#define KVM_REG_ARM_PTIMER_CVAL		ARM_CP15_REG64(2, 14)
-
-/* Virtual Timer Registers */
-#define KVM_REG_ARM_TIMER_CTL		ARM_CP15_REG32(0, 14, 3, 1)
-#define KVM_REG_ARM_TIMER_CNT		ARM_CP15_REG64(1, 14)
-#define KVM_REG_ARM_TIMER_CVAL		ARM_CP15_REG64(3, 14)
-
-/* Normal registers are mapped as coprocessor 16. */
-#define KVM_REG_ARM_CORE		(0x0010 << KVM_REG_ARM_COPROC_SHIFT)
-#define KVM_REG_ARM_CORE_REG(name)	(offsetof(struct kvm_regs, name) / 4)
-
-/* Some registers need more space to represent values. */
-#define KVM_REG_ARM_DEMUX		(0x0011 << KVM_REG_ARM_COPROC_SHIFT)
-#define KVM_REG_ARM_DEMUX_ID_MASK	0x000000000000FF00
-#define KVM_REG_ARM_DEMUX_ID_SHIFT	8
-#define KVM_REG_ARM_DEMUX_ID_CCSIDR	(0x00 << KVM_REG_ARM_DEMUX_ID_SHIFT)
-#define KVM_REG_ARM_DEMUX_VAL_MASK	0x00000000000000FF
-#define KVM_REG_ARM_DEMUX_VAL_SHIFT	0
-
-/* VFP registers: we could overload CP10 like ARM does, but that's ugly. */
-#define KVM_REG_ARM_VFP			(0x0012 << KVM_REG_ARM_COPROC_SHIFT)
-#define KVM_REG_ARM_VFP_MASK		0x000000000000FFFF
-#define KVM_REG_ARM_VFP_BASE_REG	0x0
-#define KVM_REG_ARM_VFP_FPSID		0x1000
-#define KVM_REG_ARM_VFP_FPSCR		0x1001
-#define KVM_REG_ARM_VFP_MVFR1		0x1006
-#define KVM_REG_ARM_VFP_MVFR0		0x1007
-#define KVM_REG_ARM_VFP_FPEXC		0x1008
-#define KVM_REG_ARM_VFP_FPINST		0x1009
-#define KVM_REG_ARM_VFP_FPINST2		0x100A
-
-/* KVM-as-firmware specific pseudo-registers */
-#define KVM_REG_ARM_FW			(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
-#define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
-					 KVM_REG_ARM_FW | ((r) & 0xffff))
-#define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
-	/* Higher values mean better protection. */
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL		0
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL		1
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED	2
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
-	/* Higher values mean better protection. */
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL		0
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN		1
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL		2
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED	3
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED	(1U << 4)
-
-/* Device Control API: ARM VGIC */
-#define KVM_DEV_ARM_VGIC_GRP_ADDR	0
-#define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
-#define KVM_DEV_ARM_VGIC_GRP_CPU_REGS	2
-#define   KVM_DEV_ARM_VGIC_CPUID_SHIFT	32
-#define   KVM_DEV_ARM_VGIC_CPUID_MASK	(0xffULL << KVM_DEV_ARM_VGIC_CPUID_SHIFT)
-#define   KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT 32
-#define   KVM_DEV_ARM_VGIC_V3_MPIDR_MASK \
-			(0xffffffffULL << KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT)
-#define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
-#define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
-#define   KVM_DEV_ARM_VGIC_SYSREG_INSTR_MASK (0xffff)
-#define KVM_DEV_ARM_VGIC_GRP_NR_IRQS	3
-#define KVM_DEV_ARM_VGIC_GRP_CTRL       4
-#define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
-#define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
-#define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
-#define KVM_DEV_ARM_VGIC_GRP_ITS_REGS	8
-#define KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ	9
-#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
-#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
-			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
-#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK 0x3ff
-#define VGIC_LEVEL_INFO_LINE_LEVEL	0
-
-/* Device Control API on vcpu fd */
-#define KVM_ARM_VCPU_PMU_V3_CTRL	0
-#define   KVM_ARM_VCPU_PMU_V3_IRQ	0
-#define   KVM_ARM_VCPU_PMU_V3_INIT	1
-#define KVM_ARM_VCPU_TIMER_CTRL		1
-#define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
-#define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
-
-#define   KVM_DEV_ARM_VGIC_CTRL_INIT		0
-#define   KVM_DEV_ARM_ITS_SAVE_TABLES		1
-#define   KVM_DEV_ARM_ITS_RESTORE_TABLES	2
-#define   KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES	3
-#define   KVM_DEV_ARM_ITS_CTRL_RESET		4
-
-/* KVM_IRQ_LINE irq field index values */
-#define KVM_ARM_IRQ_VCPU2_SHIFT		28
-#define KVM_ARM_IRQ_VCPU2_MASK		0xf
-#define KVM_ARM_IRQ_TYPE_SHIFT		24
-#define KVM_ARM_IRQ_TYPE_MASK		0xf
-#define KVM_ARM_IRQ_VCPU_SHIFT		16
-#define KVM_ARM_IRQ_VCPU_MASK		0xff
-#define KVM_ARM_IRQ_NUM_SHIFT		0
-#define KVM_ARM_IRQ_NUM_MASK		0xffff
-
-/* irq_type field */
-#define KVM_ARM_IRQ_TYPE_CPU		0
-#define KVM_ARM_IRQ_TYPE_SPI		1
-#define KVM_ARM_IRQ_TYPE_PPI		2
-
-/* out-of-kernel GIC cpu interrupt injection irq_number field */
-#define KVM_ARM_IRQ_CPU_IRQ		0
-#define KVM_ARM_IRQ_CPU_FIQ		1
-
-/*
- * This used to hold the highest supported SPI, but it is now obsolete
- * and only here to provide source code level compatibility with older
- * userland. The highest SPI number can be set via KVM_DEV_ARM_VGIC_GRP_NR_IRQS.
- */
-#ifndef __KERNEL__
-#define KVM_ARM_IRQ_GIC_MAX		127
-#endif
-
-/* One single KVM irqchip, ie. the VGIC */
-#define KVM_NR_IRQCHIPS          1
-
-/* PSCI interface */
-#define KVM_PSCI_FN_BASE		0x95c1ba5e
-#define KVM_PSCI_FN(n)			(KVM_PSCI_FN_BASE + (n))
-
-#define KVM_PSCI_FN_CPU_SUSPEND		KVM_PSCI_FN(0)
-#define KVM_PSCI_FN_CPU_OFF		KVM_PSCI_FN(1)
-#define KVM_PSCI_FN_CPU_ON		KVM_PSCI_FN(2)
-#define KVM_PSCI_FN_MIGRATE		KVM_PSCI_FN(3)
-
-#define KVM_PSCI_RET_SUCCESS		PSCI_RET_SUCCESS
-#define KVM_PSCI_RET_NI			PSCI_RET_NOT_SUPPORTED
-#define KVM_PSCI_RET_INVAL		PSCI_RET_INVALID_PARAMS
-#define KVM_PSCI_RET_DENIED		PSCI_RET_DENIED
-
-#endif /* __ARM_KVM_H__ */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 6eacc02fbb1b3..0987062896bbd 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -46,7 +46,6 @@ declare -a FILES=(
   "arch/powerpc/include/uapi/asm/kvm.h"
   "arch/s390/include/uapi/asm/kvm.h"
   "arch/s390/include/uapi/asm/sie.h"
-  "arch/arm/include/uapi/asm/kvm.h"
   "arch/arm64/include/uapi/asm/kvm.h"
   "arch/arm64/include/uapi/asm/unistd.h"
   "arch/alpha/include/uapi/asm/errno.h"

-- 
2.34.1


