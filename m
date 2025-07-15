Return-Path: <linux-kernel+bounces-732612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FB3B06980
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30813BC5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6DC288C09;
	Tue, 15 Jul 2025 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxpsSWQ3"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6322D5C7C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620270; cv=none; b=O3jbLsgVS/TlEFcnAEJgsqt2JFPIPJRwXx+mripWv+iO0gNWGsq+yJcHTQFnsz6O8U7vCc6TU6FhblaGZlvdtezcGCuL59qyfUnRz6dCks4DmEAYdrmvZ8wX/MNyDFGVj9IFDj851U/hOO4Q4ey3hIjdCcDVb9Fu4mGhP7R9Im0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620270; c=relaxed/simple;
	bh=cfGraB+ty8ghSuPDkOx2L0sZYlF2Nl9H3u/A7CqoDTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cKVG8frf8rFOms2Udz7CHCpFPMxnJ5okeSVRPCeR9gT5UBnStNucpJMhR23kELMTe1fhx4Qy3VuYCyao+xVXIm+QaPpElezKicCKVNgUHKnjJt/IVIhADWVjbDpqEB7lzO5o5jgfO3LoCQE5Ga4bUjgKkpQq7fhhKYf0K3nwg2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxpsSWQ3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-756bb07b029so384725b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752620268; x=1753225068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UMeLoHHXfTV79ojOu6a6TdIa46QGFM3PiTHew+k00C8=;
        b=FxpsSWQ3M+sE//NvWX7+zutQyeGf72aQIYMI7rlwV4QZBnjHwr5GEEgcDsop9L62su
         qMWN6XYqVsfiNgdq3bRgVyyQwcv9cdFyX8y85v6S9YpZEUiVj4LCfOEnBuKbVOmonftr
         pmiRvVh7NpHMgNVs/FYcx3rUClrS6zpMOGprr42a+2CQwptK0GnpiD0pi2PfVYnsjsqu
         TpXepB3Wo+e7HJ9bQ6Wo/7U7W3CRYfR+fDip8TYYYrLYj/z2gPWTn3T6ueNMawvxI2KL
         0/T0wIjCdFcqydifUvilNnHiHZ0+HSgNJ077BQt+iITgdga8oUKpPDZsgqEJ2w9Xe7Mi
         y6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620268; x=1753225068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMeLoHHXfTV79ojOu6a6TdIa46QGFM3PiTHew+k00C8=;
        b=KOeuRh5Jt9MPtEIvGWDxwCtLv96p44VdByorUAx3JhRxhFb0I9itqio2eX88Z7Onsz
         sOxr7Ey2EzEc7EyDz65VLiYuTr1LZA1FISih4N3I6BGURNMMlWXbfnN57MchSMcP4B9C
         VQONCMWAqhpZnWmqxmSVntfc8T/fJGOpUh3g/mbp39sZJxtdiQjE4Ihkoc1hCli+fkM/
         qho7/AZ1HZfnpKhbl/kERti8jlEzq31K+gL0fAMCff8QIC8pWNaBUMRQbg1b3hFRnQW4
         ZQD69IB6mToefYwSlXK6Zq1QiTbw1wqI/uA2TC9bZAn4DYkiUi9cwbGFkj1IsfuP0Gtd
         MbRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlXmFje7JUIjo0h7MLHty+qqgyVyO9jfiI7EtVExv6kekrihkGvufpOa1ZNx6oqu1mUdyjGCXLqtw2Eqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgmH3KBoHzzFkGrh1mEAITwHBaasVNgVAc3aiI86qpNUfrESwB
	LT3YbnPwVy9gjcxMhbDvQlp5xaCxgGWd8GYTrzSA/sZji6kqZsA4pvEPXjVCVwdt64S7y8Agv+q
	dcZFQ9ATexyA+5cjbIeXURX7VhBKinQ==
X-Google-Smtp-Source: AGHT+IG3vbzi3NS1evCtARelMjUlrEo+9oD75X7Kycti+9xG6ucYm6MbJrliwfPbGT6yJzXUkmX1s4WzbSQSu1uIXYw=
X-Received: from pfbcw5.prod.google.com ([2002:a05:6a00:4505:b0:748:f4a1:ae2e])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:33aa:b0:22f:bba6:5dee with SMTP id adf61e73a8af0-23813350a48mr649865637.34.1752620268643;
 Tue, 15 Jul 2025 15:57:48 -0700 (PDT)
Date: Tue, 15 Jul 2025 22:57:37 +0000
In-Reply-To: <20250715225733.3921432-5-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715225733.3921432-5-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=4074; i=samitolvanen@google.com;
 h=from:subject; bh=rKFd0jTYWs9nu9VBagQnyYYRJmgpx3uHjv+Tze4TT2E=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBlld+5/zxS2cDSfHqLN/vbuV84Dj1mDfnw4sbZX68E19
 qcvVLK9OkpZGMS4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBErGUZ/ucd6+sWWrUn72aQ
 i8bsr+f7t+RMz9/wsbnj7z1n9hUW+R6MDBM+2oewJ+8In9Tk5rx9vcjNHY3LRL0viWbyvjKfFtL IxQcA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715225733.3921432-8-samitolvanen@google.com>
Subject: [PATCH bpf-next v10 3/3] arm64/cfi,bpf: Support kCFI + BPF on arm64
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Maxwell Bland <mbland@motorola.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Dao Huang <huangdao1@oppo.com>
Content-Type: text/plain; charset="UTF-8"

From: Puranjay Mohan <puranjay12@gmail.com>

Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
calling BPF programs from this interface doesn't cause CFI warnings.

When BPF programs are called directly from C: from BPF helpers or
struct_ops, CFI warnings are generated.

Implement proper CFI prologues for the BPF programs and callbacks and
drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
prologue when a struct_ops trampoline is being prepared.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Co-developed-by: Maxwell Bland <mbland@motorola.com>
Signed-off-by: Maxwell Bland <mbland@motorola.com>
Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Dao Huang <huangdao1@oppo.com>
---
 arch/arm64/include/asm/cfi.h  |  7 +++++++
 arch/arm64/net/bpf_jit_comp.c | 22 +++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h

diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
new file mode 100644
index 000000000000..ab90f0351b7a
--- /dev/null
+++ b/arch/arm64/include/asm/cfi.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_CFI_H
+#define _ASM_ARM64_CFI_H
+
+#define __bpfcall
+
+#endif /* _ASM_ARM64_CFI_H */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b6c42b5c9668..7509ac6e76bf 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -10,6 +10,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
+#include <linux/cfi.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
 #include <linux/printk.h>
@@ -166,6 +167,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
 		emit(insn, ctx);
 }
 
+static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
+{
+	if (IS_ENABLED(CONFIG_CFI_CLANG))
+		emit(hash, ctx);
+}
+
 /*
  * Kernel addresses in the vmalloc space use at most 48 bits, and the
  * remaining bits are guaranteed to be 0x1. So we can compose the address
@@ -476,7 +483,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	const bool is_main_prog = !bpf_is_subprog(prog);
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
-	const int idx0 = ctx->idx;
 	int cur_offset;
 
 	/*
@@ -502,6 +508,9 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	 *
 	 */
 
+	emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
+	const int idx0 = ctx->idx;
+
 	/* bpf function may be invoked by 3 instruction types:
 	 * 1. bl, attached via freplace to bpf prog via short jump
 	 * 2. br, attached via freplace to bpf prog via long jump
@@ -2055,9 +2064,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		jit_data->ro_header = ro_header;
 	}
 
-	prog->bpf_func = (void *)ctx.ro_image;
+	prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
 	prog->jited = 1;
-	prog->jited_len = prog_size;
+	prog->jited_len = prog_size - cfi_get_offset();
 
 	if (!prog->is_func || extra_pass) {
 		int i;
@@ -2431,6 +2440,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	/* return address locates above FP */
 	retaddr_off = stack_size + 8;
 
+	if (flags & BPF_TRAMP_F_INDIRECT) {
+		/*
+		 * Indirect call for bpf_struct_ops
+		 */
+		emit_kcfi(cfi_get_func_hash(func_addr), ctx);
+	}
 	/* bpf trampoline may be invoked by 3 instruction types:
 	 * 1. bl, attached to bpf prog or kernel function via short jump
 	 * 2. br, attached to bpf prog or kernel function via long jump
@@ -2947,6 +2962,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 					   sizeof(jit_data->header->size));
 			kfree(jit_data);
 		}
+		prog->bpf_func -= cfi_get_offset();
 		hdr = bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
-- 
2.50.0.727.gbf7dc18ff4-goog


