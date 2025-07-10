Return-Path: <linux-kernel+bounces-725760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA220B0035B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C005A07C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C651725A2AB;
	Thu, 10 Jul 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YXS1MaOk"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2896D2586EC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154245; cv=none; b=Iv8tJeYWoXhwLTtczatiMaxatUaZ7mdF7KsLgwUCzY/z2lCJr+uV5vVf8O2xcWpC5YBxw8pNO29cIKLj5Sd+Dggou84ksqZUGAdBj4rOTmGwIUOY0pCK//d0NZcApZOJkd9n/96swm2qD/swkfyq520jwg9EJpL690Akmh97IPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154245; c=relaxed/simple;
	bh=6cJe+9YLwNrTwWDQYUOtkNfP4N7/9YXpdhwaVt+OH4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VXe4SuHXYS3vq/YeorSCJjJOUhRTS3tHPDs5D1T4NV5dwIao3tWrKwVjTf96eIo/yHnXWNobZcQB+o5kzlEBgM+g15OskteDz4x9PWIPeSQhDlIrEV+JjzKV18DDOwIfRIQOdRpQ3K7CvRQ3IcmMXR6FGRPORVSwNAnh49gIwFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YXS1MaOk; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74ce477af25so622770b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752154242; x=1752759042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSBRru92EdCdQV6HwNa+ZCQ/jNa0Vw05HCx0FcTUBpY=;
        b=YXS1MaOk5QDe7t3fFDXsU0qT6IuOTEF1vqOPcnL/XL5XO1EEntwCGz6SqUyeMoPQhl
         /5qvHXY6XTRgh+WiXIXPNR/PQcqJdwfc6pj7w+1/cMlkujBlHXmXEsxTTvo+Pf116AR6
         kujTydwQFVsn1sMW6m6rDjas4RWUJSuilEWzJPEH3iJcGayuSgIw4rOBjRyPZ223Zj1f
         5GRYryE/I4hqQXfDU2Yzu7yaFBGZ3U2D5jHzL2IDk7DK+p71NoDAV3Re5YBEVpl6GV5H
         +CHUxtKaYBC67q5UOJiq+bi5sqWgUUtXIDeinvV9qwcQnc4ja5VmCo8dsMb/m265DpCv
         8n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752154242; x=1752759042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSBRru92EdCdQV6HwNa+ZCQ/jNa0Vw05HCx0FcTUBpY=;
        b=K+zsDsLVIGNlj+QnyLeG7PItAXaNgbDNQvDI3TYkJ5fEdtC0Ik3zdhjSj/fpjxwEFE
         AXJOEqgDVigA1Xk8+bIc5C+lnz9FSE+PikMoXZXZrKec5qChPRhNx0rTDxIwrN+DBpjf
         Qo5kvqMciXERUf4LuRWC1aVU2ppspGYDY2f5NvkuNCR9pNSVm0nGK5C2uG4q5jGzAC77
         TszBeNT0qn5p4Czd+J4BAfpLRMxeJjD9+62L8DRwt4JPHUc4gua8P4nzmuGEPUYC5zsT
         R6t7ttmAsfHWIO5pANayz65V1Ue2AjoUDZjh5EHAcHV7wkiGilepRjXUBT6DxYggE8TZ
         Ww6w==
X-Forwarded-Encrypted: i=1; AJvYcCVBVwqB+q8iubwBR9G1/0HW1ietW/C+5HyNO98LHjaNVP9wXnXw3mzCUZgxsSEYACV0clGCqnQXGa2Or1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGnMI3fX3dMt0Vj8xXXCzdHTRPNK3t+gMpWPj1qj0BjGri1b0
	kA0I4+8nbW42KR0tBTpu8O+/D6+lGTe/AMrIgK6xh8KBLA979cAZcnd99TSk+kS7ar0=
X-Gm-Gg: ASbGncsrUZDUZzHaSJo9j8DO5L9Yzu89n5n/vYDxUms1lsfbk0zCoWUM0jgEH0qlMRY
	EpQ1iG9HJkW87+9ngclDcNSAQremflmJ4c6zXhhDC852TUGsODhwR17BzK1g2fJ7UpiX3IZ1DPI
	qx0vlE0YTvUOJ8Fj1dh2gu5owy4jpSroCCUIB+KzEa3u+2NC5iQAkIjfxThTQFKJrvnN9SlpBv8
	J8r0ZGLFIcrbGMzGsPpPPnLw6tlNMpKO/aojfgLCJq4OvwIPtsvLFX7YRwgZx46xEoAhpho26cS
	ji4TrtKXi3S736t1iWdunA+n/WvKIDbC9ySz+RrhPRleWfREag8Q3niN9KiZto+Gvi/sPgWtA7U
	V3foRVl3LMRQXW3TYOEmoXKDWrzKb11FNxsjXRwzlnS6BxKSVfA==
X-Google-Smtp-Source: AGHT+IHzdljx762BgYLfxVy1uhiO6LuhOaahxzDQYVaWG7z0trKJ290Cb4AzI3z+szgHVgerISzuBA==
X-Received: by 2002:a05:6a00:4f8e:b0:749:b9c:1ea7 with SMTP id d2e1a72fcca58-74eb55f4f43mr4292361b3a.17.1752154242363;
        Thu, 10 Jul 2025 06:30:42 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4c9c4sm2334373b3a.126.2025.07.10.06.30.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Jul 2025 06:30:41 -0700 (PDT)
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
Subject: [PATCH v2] RISC-V: KVM: Delegate kvm unhandled faults to VS mode
Date: Thu, 10 Jul 2025 21:30:30 +0800
Message-Id: <20250710133030.88940-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delegate faults which are not handled by kvm to VS mode to avoid
unnecessary traps to HS mode. These faults include illegal instruction
fault, instruction access fault, load access fault and store access
fault.

The delegation of illegal instruction fault is particularly important
to guest applications that use vector instructions frequently. In such
cases, an illegal instruction fault will be raised when guest user thread
uses vector instruction the first time and then guest kernel will enable
user thread to execute following vector instructions.

The fw pmu event counters remain undeleted so that guest can still get
these events via sbi call. Guest will only see zero count on these
events and know 'firmware' has delegated these faults.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/kvm_host.h |  4 ++++
 arch/riscv/kvm/vcpu_exit.c        | 18 ------------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 85cfebc32e4cf..e04851cf0115c 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -44,7 +44,11 @@
 #define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(6)
 
 #define KVM_HEDELEG_DEFAULT		(BIT(EXC_INST_MISALIGNED) | \
+					 BIT(EXC_INST_ACCESS)     | \
+					 BIT(EXC_INST_ILLEGAL)    | \
 					 BIT(EXC_BREAKPOINT)      | \
+					 BIT(EXC_LOAD_ACCESS)     | \
+					 BIT(EXC_STORE_ACCESS)    | \
 					 BIT(EXC_SYSCALL)         | \
 					 BIT(EXC_INST_PAGE_FAULT) | \
 					 BIT(EXC_LOAD_PAGE_FAULT) | \
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 6e0c184127956..6e2302c65e193 100644
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
@@ -208,19 +203,6 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		vcpu->stat.store_misaligned_exits++;
 		ret = vcpu_redirect(vcpu, trap);
 		break;
-	case EXC_LOAD_ACCESS:
-		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_ACCESS_LOAD);
-		vcpu->stat.load_access_exits++;
-		ret = vcpu_redirect(vcpu, trap);
-		break;
-	case EXC_STORE_ACCESS:
-		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_ACCESS_STORE);
-		vcpu->stat.store_access_exits++;
-		ret = vcpu_redirect(vcpu, trap);
-		break;
-	case EXC_INST_ACCESS:
-		ret = vcpu_redirect(vcpu, trap);
-		break;
 	case EXC_VIRTUAL_INST_FAULT:
 		if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV)
 			ret = kvm_riscv_vcpu_virtual_insn(vcpu, run, trap);
-- 
2.20.1


