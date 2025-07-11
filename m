Return-Path: <linux-kernel+bounces-727397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA69FB01989
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1281417FDDA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3B127EFF8;
	Fri, 11 Jul 2025 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="heICupAI"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2927EFE6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228949; cv=none; b=N1fWaPDJcOZpwFm1YccPD/Q/yvycW/Cd+aeEIAdIbzXZNUopej0z04L0/WxhpIZ9qbJP4pINJ99/DiiElVZmmKoZbnb28aFEDUOHTDQJSQ1SdKfzZP5vzd5xDT2kB6s6K0KuP7HSkwgJBK9T5LPQBjPxdCXcpkV9pjr2SKHDi4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228949; c=relaxed/simple;
	bh=FlSlIBO0balsP11mEF//2MH7vBlUT9o8miavVHAqWIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tQmGofHYU/T+2/YXmbP8bm039RQ2flX3i7VQXU57QVOIpWYKCtU9dpwwgUZ3lRKO7GZquPzZUoKTObimxhAsNTd8MIwf0XH+HTBEFyZwbE9KKl14dXn8oweqvvRlnBHWtlFVvJSxTAb9MtKqKcUbssCtKiPXgLXeTXItzRkO09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=heICupAI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748e63d4b05so1203487b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752228947; x=1752833747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EooS1f2JEaJ0MSXv8Pftab8ZGwzW6brdtxNMV0U2ebo=;
        b=heICupAIDsUJlrRd+EywEGg41nn69Zj+Iy517tqMwj3HZt0D8OIaAyANyMzXjeO4O+
         bDdt6J0SdoxEef2OH79jc9gqPGdd9CP2Wd+BwK71QLxr/W75etD4cgo38vegdDJKSNS8
         kAf4Z5n+yWVaHSU5ZXvqXOd2qo71y/6o+1ITHt22J2ucFmiWU7ZW/WpJLLrpyd5dFrls
         ITbwFggJ8u2mIZ02GdHBX9iatUCPGbHWBUGne88YFdQtzcT8qaZECPbvjlvPp7+2vseG
         O5C5fQxB5I1idN4+RB+8AEJu4u7teJL+76Syp8U5YHblLP4GXs3HfjSpjGgsJ1qCih+D
         xD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752228947; x=1752833747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EooS1f2JEaJ0MSXv8Pftab8ZGwzW6brdtxNMV0U2ebo=;
        b=sTAN9eiMVzVgrWx1TuhQXRKTz2Eswu9ZFvQbZDj0Gn3mdK94ZBoD5p4wr6vh0B0Bjc
         7oAPgljcSaPEmMxWzAVgLZ8CGe3YuA3Xd2Yvo6awjtWqoTVGp4AAdXRQwTtw8WT8n8Zh
         y7F2C2GoE+gxFVYeTtpGeArgH592/4OdCD0bDxtLkis5EA12HEtfvQ3SlsKalqgTdkbQ
         semsvaFoY+vQrtsuTQeN4AF2XDTf967RKqSnRGKSZvzrWkUdJWgFryG5zhBv0WO2h99r
         61v4ThkEjdEAEqnJCX83dhXC0Ix1t4hdTqlxnsSWTAK8KUs9WghenaMk4uIy8Hv5Rs5P
         OPAg==
X-Forwarded-Encrypted: i=1; AJvYcCU3CQeZAtDagd8gAec9PzCmqvxoPRvmtggGsLTEMDd/F4sZgAO1Pn4CLz+lI7F4vzRQfxdw+98UQ/LbLnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCSnsTR6MFv6Kdojl5UeTYDv3qrgMB32+TKeO7DxnJYoMBS1mG
	P2zwMaSPmu3vroez3A6jMvXBh10FYfPUJHZ6LYLX1z2p3ALQQUCCNu1JMW9isppkQfw=
X-Gm-Gg: ASbGncuW5KiUXJWc0fB7OhdXVOSEQxNlA8LuMtZWhAsg0TqlqvxPP7xqcDeBja5pTLV
	o+4sTY/Yw7BLaPs723Bjg2dMtHaEJIicnZ8uP1RqR5+CY9pKlQntNumUbdqqItqpK7VD8lowFdt
	3ISYjyjvJK9Fab4aRWNtoBUW1iG4vTkaAWnVe4ZByLn3sMaNEnYxPSulU5cnX6D2tQE+Rgc6zSB
	yu44s/nvNzuZzW4c6GpkJQ7dxsARa+LR3uJ2c8PAZJLOwVzxf5A/O0oUJdsiTPIkEHKHezYvsPG
	bJDzQESM/ga+GYJde97lwBVKQPR21oDy43/8SbUTAGWdNT+fVdAUCW0wx51hElB7CGvrx/f8HMA
	9fkhsXxGwHdVBRaS3rmUUVs2FyAX7hfX5kovJPjB9MRtnwbeURoSATV+bZ4PuSqKxxxLIuybAJA
	gz3uPppuroCA==
X-Google-Smtp-Source: AGHT+IGpj33BleFxzAPRm55+ECQhrqvsjdgnGSCUQSi44RJyUsIBajs+sZylsyU6wVkfs3hyvw0WQw==
X-Received: by 2002:a05:6a00:2789:b0:748:ffaf:9b53 with SMTP id d2e1a72fcca58-74ee274ca0emr3090929b3a.16.1752228946640;
        Fri, 11 Jul 2025 03:15:46 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd73d1sm4974855b3a.10.2025.07.11.03.15.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Jul 2025 03:15:46 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: rkrcmar@ventanamicro.com,
	cleger@rivosinc.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v3] RISC-V: KVM: Delegate illegal instruction fault to VS mode
Date: Fri, 11 Jul 2025 18:15:37 +0800
Message-Id: <20250711101537.16308-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delegate illegal instruction fault to VS mode in default to avoid such
exceptions being trapped to HS and redirected back to VS.

The delegation of illegal instruction fault is particularly important
to guest applications that use vector instructions frequently. In such
cases, an illegal instruction fault will be raised when guest user thread
uses vector instruction the first time and then guest kernel will enable
user thread to execute following vector instructions.

The fw pmu event counter remains undeleted so that guest can still query
illegal instruction events via sbi call. Guest will only see zero count
on illegal instruction faults and know 'firmware' has delegated it.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/kvm_host.h | 1 +
 arch/riscv/kvm/vcpu_exit.c        | 5 -----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 85cfebc32e4cf..3f6b9270f366a 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -44,6 +44,7 @@
 #define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(6)
 
 #define KVM_HEDELEG_DEFAULT		(BIT(EXC_INST_MISALIGNED) | \
+					 BIT(EXC_INST_ILLEGAL)     | \
 					 BIT(EXC_BREAKPOINT)      | \
 					 BIT(EXC_SYSCALL)         | \
 					 BIT(EXC_INST_PAGE_FAULT) | \
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 6e0c184127956..cd8fa68f3642c 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -193,11 +193,6 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	ret = -EFAULT;
 	run->exit_reason = KVM_EXIT_UNKNOWN;
 	switch (trap->scause) {
-	case EXC_INST_ILLEGAL:
-		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_ILLEGAL_INSN);
-		vcpu->stat.instr_illegal_exits++;
-		ret = vcpu_redirect(vcpu, trap);
-		break;
 	case EXC_LOAD_MISALIGNED:
 		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_MISALIGNED_LOAD);
 		vcpu->stat.load_misaligned_exits++;
-- 
2.20.1


