Return-Path: <linux-kernel+bounces-737413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AC3B0AC34
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C7C1887B51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD1522424C;
	Fri, 18 Jul 2025 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oI7Bw7Th"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C04224254
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878038; cv=none; b=DWWBht8y5iQ3g1Jd6G5IW5fv08Bq+1FE+XEuBnYOfbgdmh1EBxpj/MGwSvtIT6PJp5Q4dm8+/weeEpvkI7UImD4RkA1HnOW9Y9LEH7ZOkbJ8LXhm4wZ7Ocrkrh3jC30e8ZizP86enzYDFlTsAUmCivH21AhRdj8PIPrXFFu1TQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878038; c=relaxed/simple;
	bh=V+dt4wW9K74uYhg92zaTld9WHEncBcnDJyhO9sfR1hk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IKXtJwNoB866qh7eQ4GZNaJ664IQ/KOXzPynsiemRzWiNuIr7fOBdtrZtl7YvhvyYeERS/kKo6qt0FXpc7QdpFW5oT0YpVXAP3KX3URiXIFrsdGvog+s6gpMUuJq7KlYK+oK3s75yo6rvy3BixFgtqIc1nYVhcPugylS+33iyzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oI7Bw7Th; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31c38d4063so1718552a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752878036; x=1753482836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHownloYScgx/peEPOAu+NanD7LJponwsGoBJ5e+uKQ=;
        b=oI7Bw7ThmTp4tRjgB/7JqO4/MSNI8ZimiQz7rj9hUuvgl9vGGfYSHMQVtKzfuJVh5b
         M8KvSVyKKvE2ZgyhdDLHOATl7AfEF6I0qCt1OfKSnhvWbVTtyI7tPq4qcrojd3ES+lER
         kgXNTDtbvhZ+2g+Sx2JD+fIFD4xW3SzjFOxV0lXtXqSg9k0k+rYn5hXXTgOT9ZEB0N1M
         Lrn5bTohRo/GYeqf35tm5oxOJy59/ahjdZttD/hR5FpCCghHs7uYt0pyUDOFAQZvy6Rc
         wf++/O+2lfvB9N17Osdc2MTKu+F1/u9qdq7w5lc5j9pMhOLOPfdgFEnDi7WI1I4z4JV7
         vkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752878036; x=1753482836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHownloYScgx/peEPOAu+NanD7LJponwsGoBJ5e+uKQ=;
        b=NU68zkxuGmVxU7rh/JbcuH9xtTZpm54brW383ojpRi0zUCnCwA8aQsnzGklUeJOK8w
         IcEKfTaz5gPIazpZugjgTtO10HTxVdj/GGpsFgiJVZPjBnWSQFcC+rf0jpqbuZeEaLYo
         gGehyan5FkD19LeM2b9sbuPB35nglIJnWZtkxWaETgBGd8OBvgGhAuScnZ8Qi5A0txxc
         XtJKfykTkQE+l/G09nyzDhtZPr0wfvSzEzVTe/AQxzg77zpq4utXw0SHO7/Tyixa8/sn
         3ETrdGqpIfefDENGJZ223SN64ww6qCvFB8y7h2R1WqEPMgIpny7OUKALM17tYNHLQ1AZ
         1JEA==
X-Forwarded-Encrypted: i=1; AJvYcCVtMxJ6EP7O4aBGEAv7whwPjCH2crpKvDMNyJhKXJZ1BnOiW2SJP8D5IA8Ezchz6xAoIvDGQj9wvasnyo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8mtK9IOlm2+Vf0KeZ7ZA8xxO7sN9NxsM8dllg8IHFf3ato1h
	7AzcoqiQ2qi7kFpMciTzbpRZUY03T9g5NvKQuo/esqgwv9lPiZqXTJ1YV9iDyUwpHNF+a9hpSoN
	bKF9rzaMXXByFQZrpQMYQAbu/KxwI+g==
X-Google-Smtp-Source: AGHT+IH/zdK2zKLGKRZy6B1NJr3Oj3Ajj+FM6XNXJaqaMMi3F49NCdknto5RfR6BR+VXKXY2MJ7ChfHz+3y7/DnjrgM=
X-Received: from pgbcw13.prod.google.com ([2002:a05:6a02:428d:b0:b3b:b53c:abce])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7283:b0:220:b161:431 with SMTP id adf61e73a8af0-23811d5b52dmr20957669637.7.1752878036666;
 Fri, 18 Jul 2025 15:33:56 -0700 (PDT)
Date: Fri, 18 Jul 2025 22:33:49 +0000
In-Reply-To: <20250718223345.1075521-5-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250718223345.1075521-5-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=4115; i=samitolvanen@google.com;
 h=from:subject; bh=Btyu244psEehuoYDLzh4LQVWud/Fy+nWITFJv1APkz4=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBlVp0+vOOYy/+r1p9FXT9/9bvhfYatWqmliIcvzpfss7
 nEd6b5e0lHKwiDGxSArpsjS8nX11t3fnVJffS6SgJnDygQyhIGLUwAmYv2Q4b/Tz0kKatVhr094
 /Mh1+8s362EK68bAg55SBpU3Z/W19b9h+MOxK2GeXUlXzJuM9M3uFzpnH7O2PvB9isca9m0a5pX XgngB
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250718223345.1075521-8-samitolvanen@google.com>
Subject: [PATCH bpf-next v11 3/3] arm64/cfi,bpf: Support kCFI + BPF on arm64
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
Acked-by: Will Deacon <will@kernel.org>
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
index 89b1b8c248c6..f4a98c1a1583 100644
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
@@ -2426,6 +2435,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
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
@@ -2942,6 +2957,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 					   sizeof(jit_data->header->size));
 			kfree(jit_data);
 		}
+		prog->bpf_func -= cfi_get_offset();
 		hdr = bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
-- 
2.50.0.727.gbf7dc18ff4-goog


