Return-Path: <linux-kernel+bounces-758257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC0B1CCFC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C61A16F26E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7AC2D77EF;
	Wed,  6 Aug 2025 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TeRbBywX"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE72D877C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510305; cv=none; b=Ha2b4VDFo9fFXSG1Of7ulRmQDgf4KR4WL7qaHC39SgeHWwo1HtXLbSGxZjrmRQS5jpohxG4/tfLZq17VoGSHU+W6KUGq7ujwN48ddQQxZkd6Ar7Rk/im83m3fiT4bQws9iVVbagLQPSowEvfnq2HiFqF6jkZ3PD2/OlS9d5aAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510305; c=relaxed/simple;
	bh=jAkcPQi41ZRUiWgI9bcgpSonHu4bIB2ojvxbKVROfG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dp+A70jOuEcLpmhBtdGs/Pogc8QhF9tuOPhJn2tgCUB7px1DfeNK3uxBdixBOL4qgWY3tFEUUFtaDBSiwtaD01EgSF987UZ8y84b0IN9YIUVUPck8QRpmZhAGxTSnpv6Gh2z1ZGyDKndI9uce9bJtQ/jHxg2+i50lH+5HJrjxOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TeRbBywX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3f76a5ba7fso115508a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510297; x=1755115097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=z6mRW3QO5+v30hMhQPo0nMlPZQjpAzxmFKtx3JiIrDs=;
        b=TeRbBywXy3/HckK5eGfsnHxSEh+9vQCZfspv9MpDXJ+LqCtFF9262mSffThUlNvyCZ
         MXeUSfvu3ECVvAy7YUXAM7HMOFML++5Jkn/Vkf3YU6xVzzx2szodilCsNapPiU7t5xXi
         Cv5T8NFMwzJGs4w3T0+dcpXb3EPeXX9BoL0L/jj5oi2dd2wBHMbG/5obSQtRRXJrSAdl
         JGGH9Umcl+Zxn8Ks1JY8aIZMTndtCqfCWbMbzwUmCw6dTf7Ra0VO4sIlM5Cbk/AZfkeb
         68LxFjb7P3XeYDsZZWi9zxJMxRN3oBMj7Po5EOnXFmYiMe4+N9PgJsqcnFVurEUynlei
         iWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510297; x=1755115097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6mRW3QO5+v30hMhQPo0nMlPZQjpAzxmFKtx3JiIrDs=;
        b=KV0EOqHBrsxALQlqGmJSTQe3dP+E2d1bPtHjDbg0jmm6n3rx6sNVRT7mjFGoe6WBPo
         UZayOj1b7PKL8BOzM7SrdfwtMbSNZ70tRoC5iN0+JDihr9y0TA/dy4LHbFA/KAXVZ3NR
         nnJKHEg90N0/42xsKhb8Eld6wRiaYJQi6m80OHu5yKGccVVs5gSaIWAKsbGscVL9/AE3
         eWJoicHYogck7ocJsoQxx2LwnyBhUEn3rgyGup84ctTKBJ9VJNAPN00BP7feEh8qhNDo
         y8dO1jrGeq4KnfrFU4HLgvcAJL2rkx0S2z14Y69xiFOwjnoB/xQcZ4dBJxvSZXptr1ci
         4Wfw==
X-Forwarded-Encrypted: i=1; AJvYcCU2ySWzbA9il+KVcLcFQLIwhKS80Wg3Pya5oKFG4tGAveeaiWtci++TVqm70MNhTFjjDIbiAVXUMlJBiY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKNINmHvOQJviDLCBMRoYfwVqzw5lpj6rqckMI4e4khPec0eQH
	IMh/JG+Gk0xxV4/DRztxLBzpwphAhBdxgCgmuyZ+ZP+VYUwCW/xMx/b+G5x0qaaKnb2pjhTfXA+
	t6Fx17g==
X-Google-Smtp-Source: AGHT+IF1L5jDO3EJUjPLOXu/s6M1eVdU0dJDtzEbPUmRbyNFn2oUqefjt3C97kWpA7IvjzuPBYgNpNpIe1I=
X-Received: from pgbcv5.prod.google.com ([2002:a05:6a02:4205:b0:b42:49c8:5488])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:548d:b0:23f:faa0:2c27
 with SMTP id adf61e73a8af0-240330367c3mr5937028637.20.1754510296766; Wed, 06
 Aug 2025 12:58:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:48 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-27-seanjc@google.com>
Subject: [PATCH v5 26/44] KVM: VMX: Add helpers to toggle/change a bit in VMCS
 execution controls
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Expand the VMCS controls builder macros to generate helpers to change a
bit to the desired value, and use the new helpers when toggling APICv
related controls.

No functional change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: rewrite changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 20 +++++++-------------
 arch/x86/kvm/vmx/vmx.h |  8 ++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6094de4855d6..baea4a9cf74f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4356,19 +4356,13 @@ void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 
 	pin_controls_set(vmx, vmx_pin_based_exec_ctrl(vmx));
 
-	if (kvm_vcpu_apicv_active(vcpu)) {
-		secondary_exec_controls_setbit(vmx,
-					       SECONDARY_EXEC_APIC_REGISTER_VIRT |
-					       SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY);
-		if (enable_ipiv)
-			tertiary_exec_controls_setbit(vmx, TERTIARY_EXEC_IPI_VIRT);
-	} else {
-		secondary_exec_controls_clearbit(vmx,
-						 SECONDARY_EXEC_APIC_REGISTER_VIRT |
-						 SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY);
-		if (enable_ipiv)
-			tertiary_exec_controls_clearbit(vmx, TERTIARY_EXEC_IPI_VIRT);
-	}
+	secondary_exec_controls_changebit(vmx,
+					  SECONDARY_EXEC_APIC_REGISTER_VIRT |
+					  SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY,
+					  kvm_vcpu_apicv_active(vcpu));
+	if (enable_ipiv)
+		tertiary_exec_controls_changebit(vmx, TERTIARY_EXEC_IPI_VIRT,
+						 kvm_vcpu_apicv_active(vcpu));
 
 	vmx_update_msr_bitmap_x2apic(vcpu);
 }
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index d3389baf3ab3..a4e5bcd1d023 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -608,6 +608,14 @@ static __always_inline void lname##_controls_clearbit(struct vcpu_vmx *vmx, u##b
 {												\
 	BUILD_BUG_ON(!(val & (KVM_REQUIRED_VMX_##uname | KVM_OPTIONAL_VMX_##uname)));		\
 	lname##_controls_set(vmx, lname##_controls_get(vmx) & ~val);				\
+}												\
+static __always_inline void lname##_controls_changebit(struct vcpu_vmx *vmx, u##bits val,	\
+						       bool set)				\
+{												\
+	if (set)										\
+		lname##_controls_setbit(vmx, val);						\
+	else											\
+		lname##_controls_clearbit(vmx, val);						\
 }
 BUILD_CONTROLS_SHADOW(vm_entry, VM_ENTRY_CONTROLS, 32)
 BUILD_CONTROLS_SHADOW(vm_exit, VM_EXIT_CONTROLS, 32)
-- 
2.50.1.565.gc32cd1483b-goog


