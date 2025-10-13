Return-Path: <linux-kernel+bounces-851162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA495BD5AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA7D420C55
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0FD2D372A;
	Mon, 13 Oct 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ck8wTArj"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ADA2D46BB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379384; cv=none; b=c2vtv4U9w2rheKMlDI2BeGZ3MOUT9zCcvg5pIupxL5Wk+CWUZvTQ/YmNEchxoGeVb+CtBx6ziB9Fr1LQZBcsjkFIoVpU/wNBYUAD8ae2pILJDR8pkU+cNXaOm15uW6QUR6YbHtj0+qEPFlfOsC+/M0ePfsS6MTR+vAF41eNbsL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379384; c=relaxed/simple;
	bh=Pndkd/QRACpQhHZvNSqPSCccdoNfqhD3e1jXWeUw25w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kK+A5zcukz/qpfYARWrtnGHPTJ4P90SZxsuIgptFa2T8RVSTANuQgy2fHEY1H6C7JxHoD+3vi95MFV5lfrplXILsfTgUS181fiHO6xPrO1TwXtotqZPIlNbQfLtXYr8euaNaqMMMa1f35wdPyM5kHLoo9DBftHwEyXjx7TbwJXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ck8wTArj; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-870d82c566fso2187365685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760379380; x=1760984180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RUxP/XaBdW28mZoZIkW0DCSwwfDLYDj8cuLBEMmf/U=;
        b=Ck8wTArjZwgZucbMfDCz/inoRN/JWeBzk6Zy8SBOQoOXKmL78IEMW5uF8ERO0MONGt
         SKtdoYYLH5/DdZTGh7N8rxFMvusf5KGRVFdiH5CmGZ++dkuA1zsVvyagZz69tMRqSSsX
         M3qqd/soEViN4gYxMXlmeMy9MzZZemoam0RXaiE961lwiOHZemq57rU91hGzbVz79fuY
         wHZcWIZdNf1H/EBurTIolI++K/R2o+CCxfjP0D5pJu4RVHXIt1biy3JG4Fez2rGPL5KQ
         ko+oORIR3UboLl/f9UpEDc27OVKCJRpGTZ8i1gPfShhhQnrAfswx9F7VS8hHN0FVSPaY
         cUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379380; x=1760984180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RUxP/XaBdW28mZoZIkW0DCSwwfDLYDj8cuLBEMmf/U=;
        b=PiubSdWul4qOMibOtgvF66Ab3YKSXUJM3iHZDd5BlF+pffnuU4t5ZkWCcJc5JVywYr
         8sijPOEXrwsThWCe6PyAAEDRwzerZNzAiizNbIlgndsYGkXgI5dbSMER3z2nOSDcNFd7
         w391AijO4LN1Ln5bfhj3s114PcdnlKXFDkgtb754HIx9TLfB2A0Dzg13Ondlr3I5kmhS
         cwOfEFTZWRSyNR1kiE59OX//onFqX62iO/D4XZz63PLzTQJxt1W9+bvWeudmKEy3375Q
         Gy0HiwJVsfJpDGdMtJKcqgCFvTesYbWHHiNT0FCsXSSRQyrJgR9xcGYn/AmRjBoQh04a
         Ytog==
X-Forwarded-Encrypted: i=1; AJvYcCWBgBTCaFEHT4L8iBOHffQuFvEw2QzWQnRqt6dZ+MQUppnskdL+1gmMO1inKTaOe8SeoNFW4lBbCtecVaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPMQgAyXSnDG8iqu5E49T2R1iCAh4w+O9CeZWb45EQgBHQ9u66
	WAr98eLTnA5PRwwWzwe1yejtPGIEGCcFevaw8O2u1WOe1QNjA9CPAUIg3uHc4ElLZYrnYWQC4z4
	uQc+vpdFL3Q==
X-Google-Smtp-Source: AGHT+IHeQsITfvXzHll7K9FXqGqc6QQfE8GqFWhdrcuka1rjjaXsIdehpA6SOPPl0l7aEG+4RgWv/e8/bBRq
X-Received: from qknb19.prod.google.com ([2002:a05:620a:f93:b0:883:5f20:4151])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:290f:b0:80a:99c3:54b8
 with SMTP id af79cd13be357-8820aeadb7cmr3042982185a.5.1760379380358; Mon, 13
 Oct 2025 11:16:20 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:16:00 +0000
In-Reply-To: <20251013181607.2745653-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013181607.2745653-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251013181607.2745653-4-zecheng@google.com>
Subject: [PATCH v4 3/9] perf annotate: Track arithmetic instructions on pointers
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Track the arithmetic operations on registers with pointer types. We
handle only add, sub and lea instructions. The original pointer
information needs to be preserved for getting outermost struct types.
For example, reg0 points to a struct cfs_rq, when we add 0x10 to reg0,
it should preserve the information of struct cfs_rq + 0x10 in the
register instead of a pointer type to the child field at 0x10.

Details:

1.  struct type_state_reg now includes an offset, indicating if the
    register points to the start or an internal part of its associated
    type. This offset is used in mem to reg and reg to stack mem
    transfers, and also applied to the final type offset.

2.  lea offset(%sp/%fp), reg is now treated as taking the address of a
    stack variable. It worked fine in most cases, but an issue with this
    approach is the pointer type may not exist.

3.  lea offset(%base), reg is handled by moving the type from %base and
    adding an offset, similar to an add operation followed by a mov reg
    to reg.

4.  Non-stack variables from DWARF with non-zero offsets in their
    location expressions are now accepted with register offset tracking.

Multi-register addressing modes in LEA are not supported.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/arch/x86/annotate/instructions.c | 137 +++++++++++++++++++-
 tools/perf/util/annotate-data.c             |  17 ++-
 tools/perf/util/annotate-data.h             |   6 +
 3 files changed, 152 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 746443e04089..def7729a394c 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -248,6 +248,7 @@ static void update_insn_state_x86(struct type_state *state,
 			tsr = &state->regs[state->ret_reg];
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("call [%x] return -> reg%d",
@@ -284,6 +285,7 @@ static void update_insn_state_x86(struct type_state *state,
 			    !strcmp(var_name, "this_cpu_off") &&
 			    tsr->kind == TSR_KIND_CONST) {
 				tsr->kind = TSR_KIND_PERCPU_BASE;
+				tsr->offset = 0;
 				tsr->ok = true;
 				imm_value = tsr->imm_value;
 			}
@@ -291,6 +293,19 @@ static void update_insn_state_x86(struct type_state *state,
 		else
 			return;
 
+		/* Ignore add to non-pointer or non-const types */
+		if (tsr->kind == TSR_KIND_POINTER ||
+		    (dwarf_tag(&tsr->type) == DW_TAG_pointer_type &&
+		     src->reg1 != DWARF_REG_PC && tsr->kind == TSR_KIND_TYPE && !dst->mem_ref)) {
+			tsr->offset += imm_value;
+			pr_debug_dtp("add [%x] offset %#"PRIx64" to reg%d",
+				     insn_offset, imm_value, dst->reg1);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+
+		if (tsr->kind == TSR_KIND_CONST)
+			tsr->imm_value += imm_value;
+
 		if (tsr->kind != TSR_KIND_PERCPU_BASE)
 			return;
 
@@ -302,6 +317,7 @@ static void update_insn_state_x86(struct type_state *state,
 			 */
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_PERCPU_POINTER;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("add [%x] percpu %#"PRIx64" -> reg%d",
@@ -311,6 +327,106 @@ static void update_insn_state_x86(struct type_state *state,
 		return;
 	}
 
+	if (!strncmp(dl->ins.name, "sub", 3)) {
+		u64 imm_value = -1ULL;
+
+		if (!has_reg_type(state, dst->reg1))
+			return;
+
+		tsr = &state->regs[dst->reg1];
+		tsr->copied_from = -1;
+
+		if (src->imm)
+			imm_value = src->offset;
+		else if (has_reg_type(state, src->reg1) &&
+			 state->regs[src->reg1].kind == TSR_KIND_CONST)
+			imm_value = state->regs[src->reg1].imm_value;
+
+		if (tsr->kind == TSR_KIND_POINTER ||
+		    (dwarf_tag(&tsr->type) == DW_TAG_pointer_type &&
+		     src->reg1 != DWARF_REG_PC && tsr->kind == TSR_KIND_TYPE && !dst->mem_ref)) {
+			tsr->offset -= imm_value;
+			pr_debug_dtp("sub [%x] offset %#"PRIx64" to reg%d",
+				     insn_offset, imm_value, dst->reg1);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+
+		if (tsr->kind == TSR_KIND_CONST)
+			tsr->imm_value -= imm_value;
+
+		return;
+	}
+
+	if (!strncmp(dl->ins.name, "lea", 3)) {
+		int sreg = src->reg1;
+		struct type_state_reg src_tsr;
+
+		if (!has_reg_type(state, sreg) ||
+		    !has_reg_type(state, dst->reg1) ||
+		    !src->mem_ref)
+			return;
+
+		src_tsr = state->regs[sreg];
+		tsr = &state->regs[dst->reg1];
+
+		tsr->copied_from = -1;
+		tsr->ok = false;
+
+		/* Case 1: Based on stack pointer or frame pointer */
+		if (sreg == fbreg || sreg == state->stack_reg) {
+			struct type_state_stack *stack;
+			int offset = src->offset - fboff;
+
+			stack = find_stack_state(state, offset);
+			if (!stack)
+				return;
+
+			tsr->type = stack->type;
+			tsr->kind = TSR_KIND_POINTER;
+			tsr->offset = offset - stack->offset;
+			tsr->ok = true;
+
+			if (sreg == fbreg) {
+				pr_debug_dtp("lea [%x] address of -%#x(stack) -> reg%d",
+					     insn_offset, -src->offset, dst->reg1);
+			} else {
+				pr_debug_dtp("lea [%x] address of %#x(reg%d) -> reg%d",
+					     insn_offset, src->offset, sreg, dst->reg1);
+			}
+
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+		/* Case 2: Based on a register holding a typed pointer */
+		else if (src_tsr.ok && (src_tsr.kind == TSR_KIND_POINTER ||
+			 (dwarf_tag(&src_tsr.type) == DW_TAG_pointer_type &&
+			  src_tsr.kind == TSR_KIND_TYPE))) {
+
+			if (src_tsr.kind == TSR_KIND_TYPE &&
+			    __die_get_real_type(&state->regs[sreg].type, &type_die) == NULL)
+				return;
+
+			if (src_tsr.kind == TSR_KIND_POINTER)
+				type_die = state->regs[sreg].type;
+
+			/* Check if the target type has a member at the new offset */
+			if (die_get_member_type(&type_die,
+						src->offset + src_tsr.offset, &type_die) == NULL)
+				return;
+
+			tsr->type = src_tsr.type;
+			tsr->kind = src_tsr.kind;
+			tsr->offset = src->offset + src_tsr.offset;
+			tsr->ok = true;
+
+			pr_debug_dtp("lea [%x] address of %s%#x(reg%d) -> reg%d",
+						insn_offset, src->offset < 0 ? "-" : "",
+						abs(src->offset), sreg, dst->reg1);
+
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+		return;
+	}
+
 	if (strncmp(dl->ins.name, "mov", 3))
 		return;
 
@@ -345,6 +461,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			if (var_addr == 40) {
 				tsr->kind = TSR_KIND_CANARY;
+				tsr->offset = 0;
 				tsr->ok = true;
 
 				pr_debug_dtp("mov [%x] stack canary -> reg%d\n",
@@ -361,6 +478,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] this-cpu addr=%#"PRIx64" -> reg%d",
@@ -372,6 +490,7 @@ static void update_insn_state_x86(struct type_state *state,
 		if (src->imm) {
 			tsr->kind = TSR_KIND_CONST;
 			tsr->imm_value = src->offset;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] imm=%#x -> reg%d\n",
@@ -388,6 +507,7 @@ static void update_insn_state_x86(struct type_state *state,
 		tsr->type = state->regs[src->reg1].type;
 		tsr->kind = state->regs[src->reg1].kind;
 		tsr->imm_value = state->regs[src->reg1].imm_value;
+		tsr->offset = state->regs[src->reg1].offset;
 		tsr->ok = true;
 
 		/* To copy back the variable type later (hopefully) */
@@ -421,12 +541,14 @@ static void update_insn_state_x86(struct type_state *state,
 			} else if (!stack->compound) {
 				tsr->type = stack->type;
 				tsr->kind = stack->kind;
+				tsr->offset = 0;
 				tsr->ok = true;
 			} else if (die_get_member_type(&stack->type,
 						       offset - stack->offset,
 						       &type_die)) {
 				tsr->type = type_die;
 				tsr->kind = TSR_KIND_TYPE;
+				tsr->offset = 0;
 				tsr->ok = true;
 			} else {
 				tsr->ok = false;
@@ -446,9 +568,10 @@ static void update_insn_state_x86(struct type_state *state,
 		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
 			 state->regs[sreg].kind == TSR_KIND_TYPE &&
 			 die_deref_ptr_type(&state->regs[sreg].type,
-					    src->offset, &type_die)) {
+					    src->offset + state->regs[sreg].offset, &type_die)) {
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] %#x(reg%d) -> reg%d",
@@ -459,9 +582,10 @@ static void update_insn_state_x86(struct type_state *state,
 		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
 			 state->regs[sreg].kind == TSR_KIND_POINTER &&
 			 die_get_member_type(&state->regs[sreg].type,
-					     src->offset, &type_die)) {
+					     src->offset + state->regs[sreg].offset, &type_die)) {
 			tsr->type = state->regs[sreg].type;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = src->offset + state->regs[sreg].offset;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] addr %#x(reg%d) -> reg%d",
@@ -486,6 +610,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] global addr=%"PRIx64" -> reg%d",
@@ -517,6 +642,7 @@ static void update_insn_state_x86(struct type_state *state,
 			    die_get_member_type(&type_die, offset, &type_die)) {
 				tsr->type = type_die;
 				tsr->kind = TSR_KIND_TYPE;
+				tsr->offset = 0;
 				tsr->ok = true;
 
 				if (src->multi_regs) {
@@ -539,6 +665,7 @@ static void update_insn_state_x86(struct type_state *state,
 					     src->offset, &type_die)) {
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] pointer %#x(reg%d) -> reg%d",
@@ -561,6 +688,7 @@ static void update_insn_state_x86(struct type_state *state,
 							&var_name, &offset) &&
 				    !strcmp(var_name, "__per_cpu_offset")) {
 					tsr->kind = TSR_KIND_PERCPU_BASE;
+					tsr->offset = 0;
 					tsr->ok = true;
 
 					pr_debug_dtp("mov [%x] percpu base reg%d\n",
@@ -609,6 +737,11 @@ static void update_insn_state_x86(struct type_state *state,
 				pr_debug_dtp("mov [%x] reg%d -> %#x(reg%d)",
 					     insn_offset, src->reg1, offset, dst->reg1);
 			}
+			if (tsr->offset != 0) {
+				pr_debug_dtp(" reg%d offset %#x ->",
+					src->reg1, tsr->offset);
+			}
+
 			pr_debug_type_name(&tsr->type, tsr->kind);
 		}
 		/*
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 48f3bf20070f..4204a7956ee5 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -905,7 +905,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 					     insn_offset, -offset);
 			}
 			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
-		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
+		} else if (has_reg_type(state, var->reg)) {
 			struct type_state_reg *reg;
 			Dwarf_Die orig_type;
 
@@ -921,6 +921,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				    !is_better_type(&reg->type, &mem_die))
 					continue;
 
+				reg->offset = -var->offset;
 				reg->type = mem_die;
 				reg->kind = TSR_KIND_POINTER;
 				reg->ok = true;
@@ -932,13 +933,17 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 			}
 
 			orig_type = reg->type;
-
+			/*
+			 * var->offset + reg value is the beginning of the struct
+			 * reg->offset is the offset the reg points
+			 */
+			reg->offset = -var->offset;
 			reg->type = mem_die;
 			reg->kind = TSR_KIND_TYPE;
 			reg->ok = true;
 
-			pr_debug_dtp("var [%"PRIx64"] reg%d",
-				     insn_offset, var->reg);
+			pr_debug_dtp("var [%"PRIx64"] reg%d offset %x",
+				     insn_offset, var->reg, var->offset);
 			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
 
 			/*
@@ -1126,7 +1131,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (__die_get_real_type(&state->regs[reg].type, type_die) == NULL)
 			return PERF_TMR_NO_POINTER;
 
-		dloc->type_offset = dloc->op->offset;
+		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
 
 		if (dwarf_tag(type_die) == DW_TAG_typedef)
 			die_get_real_type(type_die, &sized_type);
@@ -1155,7 +1160,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		 */
 		*type_die = state->regs[reg].type;
 
-		dloc->type_offset = dloc->op->offset;
+		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
 
 		/* Get the size of the actual type */
 		if (dwarf_aggregate_size(type_die, &size) < 0 ||
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 026783442056..14655b76db65 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -174,6 +174,12 @@ extern struct annotated_data_stat ann_data_stat;
 struct type_state_reg {
 	Dwarf_Die type;
 	u32 imm_value;
+	/*
+	 * The offset within the struct that the register points to.
+	 * A value of 0 means the register points to the beginning.
+	 * type_offset = op->offset + reg->offset
+	 */
+	s32 offset;
 	bool ok;
 	bool caller_saved;
 	u8 kind;
-- 
2.51.0.788.g6d19910ace-goog


