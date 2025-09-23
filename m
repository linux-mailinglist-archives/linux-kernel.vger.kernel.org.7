Return-Path: <linux-kernel+bounces-829457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9296B971F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B8419C7EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496102DC79D;
	Tue, 23 Sep 2025 17:50:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144FC28B3E7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649805; cv=none; b=kJSbFhGnBFVI7OnAaA+XdADuJ2hJg3Jzdwq/KGPkj1LdcpNblTs/RblxMbPdK1YOofilNYJZppQkZFKYEQGB5moIedvvch9UvChqiVDhdEEDLmA2E0K+DWbYbncvQmY6vO1XBP435CC51c+PmTajg4E/c9V/fGogO0OOUMBSC0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649805; c=relaxed/simple;
	bh=QjGU0Aksok9mK7+fVYuqIavVILfHnzN921TjOMeE/Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibdLEiYHrJu+IgWwU8mjqZFVMU0vHzubc0JsfkjB4sdlemdL1yqSRfhjfnsyaF2EdmVNPibP24pRsfBza0XY5E0E2UhbIFFXELET5+wUjdd/rfTBEVZ6SFcKfhFYXIr4vRlhqcytonEg8819X/HSWAF8QqCzaPs4IEZLLWPIbX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66942497;
	Tue, 23 Sep 2025 10:49:55 -0700 (PDT)
Received: from e137867.cambridge.arm.com (e137867.arm.com [10.1.30.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2F2973F5A1;
	Tue, 23 Sep 2025 10:49:59 -0700 (PDT)
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kasan-dev@googlegroups.com,
	Mark Rutland <mark.rutland@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: [RFC PATCH 12/16] kvm/arm64: make alternative callbacks safe
Date: Tue, 23 Sep 2025 18:48:59 +0100
Message-ID: <20250923174903.76283-13-ada.coupriediaz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923174903.76283-1-ada.coupriediaz@arm.com>
References: <20250923174903.76283-1-ada.coupriediaz@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alternative callback functions are regular functions, which means they
or any function they call could get patched or instrumented
by alternatives or other parts of the kernel.
Given that applying alternatives does not guarantee a consistent state
while patching, only once done, and handles cache maintenance manually,
it could lead to nasty corruptions and execution of bogus code.

Make the KVM alternative callbacks safe by marking them `noinstr` and
`__always_inline`'ing their helpers.
This is possible thanks to previous commits making `aarch64_insn_...`
functions used in the callbacks safe to inline.

`kvm_update_va_mask()` is already marked as `__init`, which has its own
text section conflicting with the `noinstr` one.
Instead, use `__no_instr_section(".noinstr.text")` to add
all the function attributes added by `noinstr`, without the section
conflict.
This can be an issue, as kprobes seems to only block the text sections,
not based on function attributes.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
This is missing `kvm_patch_vector_branch()`, which could receive the same
treatment, but the `WARN_ON_ONCE` in the early-exit check would make it
call into instrumentable code.
I do not currently know if this `WARN` can safely be removed or if it
has some importance.
---
 arch/arm64/kvm/va_layout.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index 91b22a014610..3ebb7e0074f6 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -109,7 +109,7 @@ __init void kvm_apply_hyp_relocations(void)
 	}
 }
 
-static u32 compute_instruction(int n, u32 rd, u32 rn)
+static __always_inline u32 compute_instruction(int n, u32 rd, u32 rn)
 {
 	u32 insn = AARCH64_BREAK_FAULT;
 
@@ -151,6 +151,7 @@ static u32 compute_instruction(int n, u32 rd, u32 rn)
 	return insn;
 }
 
+__noinstr_section(".init.text")
 void __init kvm_update_va_mask(struct alt_instr *alt,
 			       __le32 *origptr, __le32 *updptr, int nr_inst)
 {
@@ -241,7 +242,8 @@ void kvm_patch_vector_branch(struct alt_instr *alt,
 	*updptr++ = cpu_to_le32(insn);
 }
 
-static void generate_mov_q(u64 val, __le32 *origptr, __le32 *updptr, int nr_inst)
+static __always_inline void generate_mov_q(u64 val, __le32 *origptr,
+				 __le32 *updptr, int nr_inst)
 {
 	u32 insn, oinsn, rd;
 
@@ -284,15 +286,15 @@ static void generate_mov_q(u64 val, __le32 *origptr, __le32 *updptr, int nr_inst
 	*updptr++ = cpu_to_le32(insn);
 }
 
-void kvm_get_kimage_voffset(struct alt_instr *alt,
+noinstr void kvm_get_kimage_voffset(struct alt_instr *alt,
 			    __le32 *origptr, __le32 *updptr, int nr_inst)
 {
 	generate_mov_q(kimage_voffset, origptr, updptr, nr_inst);
 }
 
-void kvm_compute_final_ctr_el0(struct alt_instr *alt,
+noinstr void kvm_compute_final_ctr_el0(struct alt_instr *alt,
 			       __le32 *origptr, __le32 *updptr, int nr_inst)
 {
-	generate_mov_q(read_sanitised_ftr_reg(SYS_CTR_EL0),
+	generate_mov_q(arm64_ftr_reg_ctrel0.sys_val,
 		       origptr, updptr, nr_inst);
 }
-- 
2.43.0


