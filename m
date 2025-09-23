Return-Path: <linux-kernel+bounces-828341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA20B946E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7612A65E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5D330DD24;
	Tue, 23 Sep 2025 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="GC/kLNBI"
Received: from sg-1-19.ptr.blmpb.com (sg-1-19.ptr.blmpb.com [118.26.132.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC30A1339B1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758605970; cv=none; b=VHImBQw7CYRolEC6I+FtAzZW8o6M7lk3cT3f5S/hKUf201Bt017rZYFAhdjIRNZnPh98Vf3d0HXaVjTg5X1F2QiBJmkVwRilzcF+WmSLe0+PuoHT2PdWkC146++gm1btgbGyu021Z460Wy+0mzE0ppP6O++wRJCsFoYdMgmjeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758605970; c=relaxed/simple;
	bh=K2FxbZCGR0cFvo7MSbhK9cYtNVv6G5VQcag2HZyy8so=;
	h=To:Subject:Date:Content-Type:From:Mime-Version:Cc:Message-Id; b=MCuVIa+B2/9qoi5hNORyND1quQisNNEeIymUK3H3TalIlh34jFYOipxkhjSsNkugPvRKRpGORwCNGtYvu0LiStidfKGZfn91jwBORBfSU6+mM4/CfDpP3I9RNVtEaIUxOzMdZ/vOFIdooJXbf2uc9HRO82rL5NWgqkh0RoN1HQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=GC/kLNBI; arc=none smtp.client-ip=118.26.132.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1758605953;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=3gmQ2zoxSsM9TQ/jV7QWiBGtZ/AlH7UzJQwrMEBoGjY=;
 b=GC/kLNBITSmfkcfO9WZhuD+p1gcAboL26Ola/dB47QIZJyGrQetTiT2396L4tz38J27lYj
 u8tATudUDLq2iDESeNEpLYOADAhfuJVwiAXWrwi0BVq/RKJ08DIji/1WhX3zlxrmrlp2GD
 edNQVwJxqfot4tV8TirBcD6+oF504v/unfXZc8RBPdqEV+B48ABwmPosWWir1pF0xmQuCh
 fR480yW0AwYqJWDEzEYQt1acCcsPf7F+b394IVhA3sj2D+KO9NxDbJl6Y2zkkwc4IVjtbt
 sfYwfi7hqjOM8K+u8+UW9bSAtc/pV1yrr6JGG6WBDCtY0QqyVqMkCMHPUn91fQ==
To: <anup@brainfault.org>
Subject: [PATCH v2] RISC-V: KVM: Introduce KVM_EXIT_FAIL_ENTRY_NO_VSFILE
Date: Tue, 23 Sep 2025 13:38:51 +0800
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+268d2327f+e8c879+vger.kernel.org+xiangwencheng@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Cc: <kvm-riscv@lists.infradead.org>, <kvm@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <atish.patra@linux.dev>, 
	<ajones@ventanamicro.com>, 
	"BillXiang" <xiangwencheng@lanxincomputing.com>
Message-Id: <20250923053851.32863-1-xiangwencheng@lanxincomputing.com>
Received: from Bill.localdomain ([222.128.9.250]) by smtp.feishu.cn with ESMTP; Tue, 23 Sep 2025 13:39:10 +0800

Currently, we return CSR_HSTATUS as hardware_entry_failure_reason when
kvm_riscv_aia_alloc_hgei failed in KVM_DEV_RISCV_AIA_MODE_HWACCEL
mode, which is vague so it is better to return a well defined value
KVM_EXIT_FAIL_ENTRY_NO_VSFILE provided via uapi/asm/kvm.h.

Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 2 ++
 arch/riscv/kvm/aia_imsic.c        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index ef27d4289da1..068d4d9cff7b 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -23,6 +23,8 @@
 #define KVM_INTERRUPT_SET	-1U
 #define KVM_INTERRUPT_UNSET	-2U
 
+#define KVM_EXIT_FAIL_ENTRY_NO_VSFILE	(1ULL << 0)
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 };
diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index fda0346f0ea1..937963fb46c5 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -802,7 +802,7 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *vcpu)
 		/* For HW acceleration mode, we can't continue */
 		if (kvm->arch.aia.mode == KVM_DEV_RISCV_AIA_MODE_HWACCEL) {
 			run->fail_entry.hardware_entry_failure_reason =
-								CSR_HSTATUS;
+								KVM_EXIT_FAIL_ENTRY_NO_VSFILE;
 			run->fail_entry.cpu = vcpu->cpu;
 			run->exit_reason = KVM_EXIT_FAIL_ENTRY;
 			return 0;
-- 
2.43.0

