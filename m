Return-Path: <linux-kernel+bounces-746319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C12B1256B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382C617DCC7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC32725A344;
	Fri, 25 Jul 2025 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOuKzQCJ"
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BEA25A328
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475310; cv=none; b=AEwRn4Hap6w92MIEyPKBkwpYnGUpStPZsw9O/s05fKX3N56yiLnALOYqo7PnFPG7ecrwOiqZCo5zSYSrtzAAm8uZN4ICXEvB8d4qj+Rlvt98TyNyP9n8AUaHiiZ5iqXpGJyvz1jU7RWIkWAksQVie+YZFBlhJqf3D+hAamPU060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475310; c=relaxed/simple;
	bh=lv54xUtQ3WONfNqydnskRHUhGzP6WkcXiLDmvg3vg48=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VZDAAzsdOS01W81dCWfS9OjQirWmVRp/vmZJZxl4nExPifgUE0lqZ4Zu02eI4kUjIEYNgOLMiUrhcQe8Z7/OH7dubiCzY7sWM6CRkKbaXVeAax1gQUKuLtMy/0NY4OJ7aj3iW8/mTlXYe7OjCm9jpFqKDIdI7C1QNwGpK3+wLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vOuKzQCJ; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ab7464e3bfso24789971cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753475307; x=1754080107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JgtV/JZRHlv0+PHl5j1NSg/A21YbT9f5uAr0q6A1H5c=;
        b=vOuKzQCJCSQPTmbimUQnQG7eIkzupEINRwMU+azquzpWHJ+3F9jXssmZNCdhyurrgs
         VJNkwGuQb69IZBHyzxrvX3H++z/Yhh1niFSQ6Z5t4p1BbiUDkc5MIs2GH2eKNA41ryW0
         hjzkHF3wcZshawk/Yzn5YOHfWc5Zib/hTSWuxOgByheuBdzWvB0YDJQeWKfnNwGArQyv
         JQfkgcKecE/M2T2g1R9kRij+Ya01OUR+Kd3WWhKNfTyQm9t2dqMqNHEjQhN8h4XxE2P+
         PAWnA+DVvHOdHnIU1q5G5W68Nlf0y5sn7Nhi9DEKyKVBhFEI+a2mGgApB7HlDfyphp1c
         aOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753475307; x=1754080107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgtV/JZRHlv0+PHl5j1NSg/A21YbT9f5uAr0q6A1H5c=;
        b=qJZJCvVCZJDywOpvGXpo8u+6yg6EuC+5cPlvji7rjcnXFTgSBHYQMvRNhpyI3qGaGG
         BEepDGqUDsrK9zxT7oNVIM4A/BbJsh2QNuyNIXxgCMKzQgSZpwo/WP5NuecjYJ5DW/r7
         4j+7Yy1j2fU1k7SdeN3woyVytmLOQuEMlXCdkRAWOIv8qAKNsqCBqtBgcYevVanTLcnO
         gYOOMsgXMZcbnIEWR7gW962fwOHU42LhDAmqfYPGMOmdxhGb4pei8p1Ux/kWek3cu4U0
         dVkMQ4b7xHjtWurq/m+lcK37kPKDJbe9sJsHwPRGIFQJE7Uy+cyGYLm/XDvSCLXCMH58
         kmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUObK9jJJrzshx57L36L1I8lVsXr2SnbMwT1eO76DmLAAMXgBg9WsfS8Bwf/KZrv8STnlFcxLkXDcBmt1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzecm97FTN8CnHbsj6bec24L4otbEjcSDYkWWkvCaRWBBS2DqtS
	HOxUqQT9VDgKhMbqBEQ3bnEMQYWDSFWaBmQger9N+RqwldUiovthDl2E6NOX8mXia5fb2/SZALi
	DGJSI3TqbXQ==
X-Google-Smtp-Source: AGHT+IEaPavaGTYObiXIJE1ukWXvmgQePpoF9ZlEjnTtODAqdevAV+DR5yKu8V2x2kO3XF3fMCQqXamylvm1
X-Received: from qtbfk17.prod.google.com ([2002:a05:622a:5591:b0:4a9:91da:e87e])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:1888:b0:4ab:b0a0:5b58
 with SMTP id d75a77b69052e-4ae8f11e1efmr51406351cf.46.1753475307164; Fri, 25
 Jul 2025 13:28:27 -0700 (PDT)
Date: Fri, 25 Jul 2025 20:28:09 +0000
In-Reply-To: <20250725202809.1230085-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725202809.1230085-1-zecheng@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725202809.1230085-7-zecheng@google.com>
Subject: [PATCH v1 6/6] perf annotate: Track arithmetic instructions on pointers
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Track the arithmetic operations on registers with pointer types. We
handle only add and lea instructions. The original pointer information
needs to be preserved for getting outermost struct types. For example,
reg0 points to a struct cfs_rq, when we add 0x10 to reg0, it should
preserve the information of struct cfs_rq + 0x10 in the register instead
of a pointer type to the child field at 0x10.

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

Limitation: Offset tracking for register moved to the stack is not yet
implemented. Currently, moving an register with offset to the stack
resolves to the member type, which worked in some of the cases. Strictly
it should be a pointer to the immediate child member. Multi-register
addressing modes in LEA are not supported.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/arch/x86/annotate/instructions.c | 109 +++++++++++++++++++-
 tools/perf/util/annotate-data.c             |  14 ++-
 tools/perf/util/annotate-data.h             |   6 ++
 3 files changed, 120 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index c6d403eae744..82fc0106a4de 100644
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
@@ -291,6 +293,15 @@ static void update_insn_state_x86(struct type_state *state,
 		else
 			return;
 
+		/* Ignore add to non-pointer types like int */
+		if (dwarf_tag(&tsr->type) == DW_TAG_pointer_type &&
+		    src->reg1 != DWARF_REG_PC && tsr->kind == TSR_KIND_TYPE && !dst->mem_ref) {
+			tsr->offset += imm_value;
+			pr_debug_dtp("add [%x] offset %#"PRIx64" to reg%d",
+				     insn_offset, imm_value, dst->reg1);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+
 		if (tsr->kind != TSR_KIND_PERCPU_BASE)
 			return;
 
@@ -302,6 +313,7 @@ static void update_insn_state_x86(struct type_state *state,
 			 */
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_POINTER;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("add [%x] percpu %#"PRIx64" -> reg%d",
@@ -311,6 +323,68 @@ static void update_insn_state_x86(struct type_state *state,
 		return;
 	}
 
+	if (!strncmp(dl->ins.name, "lea", 3)) {
+		struct type_state_reg *src_tsr;
+		int sreg = src->reg1;
+
+		if (!has_reg_type(state, sreg) ||
+		    !has_reg_type(state, dst->reg1) ||
+		    !src->mem_ref)
+			return;
+
+		src_tsr = &state->regs[sreg];
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
+			/* TODO: the pointer type may not exist */
+			/* Now the register becomes a pointer to the stack variable */
+			if (!die_find_pointer_to_type(cu_die, &stack->type, &type_die))
+				return;
+
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
+			tsr->ok = true;
+
+			pr_debug_dtp("lea [%x] -> reg%d points to %s + %#x on stack\n",
+					insn_offset, dst->reg1,
+					(sreg == fbreg) ? "fbreg" : "sp", offset);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+		/* Case 2: Based on a register holding a typed pointer */
+		else if (has_reg_type(state, sreg) &&
+			 state->regs[sreg].ok &&
+			 state->regs[sreg].kind == TSR_KIND_TYPE) {
+
+			/* Check if the target type has a member at the new offset */
+			if (__die_get_real_type(&state->regs[sreg].type, &type_die) == NULL ||
+			    !die_get_member_type(&type_die,
+						 src->offset + src_tsr->offset, &type_die))
+				return;
+
+			tsr->type = src_tsr->type;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = src->offset + src_tsr->offset;
+			tsr->ok = true;
+
+			pr_debug_dtp("lea [%x] -> reg%d points to reg%d + %#x\n",
+					insn_offset, dst->reg1, sreg, src->offset);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+		return;
+	}
+
 	if (strncmp(dl->ins.name, "mov", 3))
 		return;
 
@@ -345,6 +419,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			if (var_addr == 40) {
 				tsr->kind = TSR_KIND_CANARY;
+				tsr->offset = 0;
 				tsr->ok = true;
 
 				pr_debug_dtp("mov [%x] stack canary -> reg%d\n",
@@ -361,6 +436,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] this-cpu addr=%#"PRIx64" -> reg%d",
@@ -372,6 +448,7 @@ static void update_insn_state_x86(struct type_state *state,
 		if (src->imm) {
 			tsr->kind = TSR_KIND_CONST;
 			tsr->imm_value = src->offset;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] imm=%#x -> reg%d\n",
@@ -388,6 +465,7 @@ static void update_insn_state_x86(struct type_state *state,
 		tsr->type = state->regs[src->reg1].type;
 		tsr->kind = state->regs[src->reg1].kind;
 		tsr->imm_value = state->regs[src->reg1].imm_value;
+		tsr->offset = 0;
 		tsr->ok = true;
 
 		/* To copy back the variable type later (hopefully) */
@@ -421,12 +499,14 @@ static void update_insn_state_x86(struct type_state *state,
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
@@ -446,9 +526,10 @@ static void update_insn_state_x86(struct type_state *state,
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
@@ -473,6 +554,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] global addr=%"PRIx64" -> reg%d",
@@ -504,6 +586,7 @@ static void update_insn_state_x86(struct type_state *state,
 			    die_get_member_type(&type_die, offset, &type_die)) {
 				tsr->type = type_die;
 				tsr->kind = TSR_KIND_TYPE;
+				tsr->offset = 0;
 				tsr->ok = true;
 
 				if (src->multi_regs) {
@@ -526,6 +609,7 @@ static void update_insn_state_x86(struct type_state *state,
 					     src->offset, &type_die)) {
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] pointer %#x(reg%d) -> reg%d",
@@ -548,6 +632,7 @@ static void update_insn_state_x86(struct type_state *state,
 							&var_name, &offset) &&
 				    !strcmp(var_name, "__per_cpu_offset")) {
 					tsr->kind = TSR_KIND_PERCPU_BASE;
+					tsr->offset = 0;
 					tsr->ok = true;
 
 					pr_debug_dtp("mov [%x] percpu base reg%d\n",
@@ -571,6 +656,22 @@ static void update_insn_state_x86(struct type_state *state,
 			int offset = dst->offset - fboff;
 
 			tsr = &state->regs[src->reg1];
+			type_die = tsr->type;
+
+			/* The register is derived from a pointer to the type */
+			if (tsr->offset != 0) {
+				/*
+				 * deref gets the innermost field, but we actually want direct
+				 * child field and take a pointer to it.
+				 * However array type like unsigned long[] is already a pointer
+				 * and is the most common case for this kind of stack variable.
+				 */
+				if (die_deref_ptr_type(&tsr->type, tsr->offset, &type_die)) {
+					pr_debug_dtp("find member: tsr->offset: %d", tsr->offset);
+					pr_debug_type_name(&type_die, tsr->kind);
+				} else
+					return;
+			}
 
 			stack = find_stack_state(state, offset);
 			if (stack) {
@@ -583,10 +684,10 @@ static void update_insn_state_x86(struct type_state *state,
 				 */
 				if (!stack->compound)
 					set_stack_state(stack, offset, tsr->kind,
-							&tsr->type);
+							&type_die);
 			} else {
 				findnew_stack_state(state, offset, tsr->kind,
-						    &tsr->type);
+						    &type_die);
 			}
 
 			if (dst->reg1 == fbreg) {
@@ -596,7 +697,7 @@ static void update_insn_state_x86(struct type_state *state,
 				pr_debug_dtp("mov [%x] reg%d -> %#x(reg%d)",
 					     insn_offset, src->reg1, offset, dst->reg1);
 			}
-			pr_debug_type_name(&tsr->type, tsr->kind);
+			pr_debug_type_name(&type_die, tsr->kind);
 		}
 		/*
 		 * Ignore other transfers since it'd set a value in a struct
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 1ef2edbc71d9..9cb215e499ef 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -887,7 +887,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 					     insn_offset, -offset);
 			}
 			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
-		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
+		} else if (has_reg_type(state, var->reg)) {
 			struct type_state_reg *reg;
 			Dwarf_Die orig_type;
 
@@ -898,13 +898,17 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				continue;
 
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
+			pr_debug_dtp("var [%"PRIx64"] reg%d at offset %d",
+				     insn_offset, var->reg, var->offset);
 			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
 
 			/*
@@ -1092,7 +1096,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (__die_get_real_type(&state->regs[reg].type, type_die) == NULL)
 			return PERF_TMR_NO_POINTER;
 
-		dloc->type_offset = dloc->op->offset;
+		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
 
 		if (dwarf_tag(type_die) == DW_TAG_typedef)
 			die_get_real_type(type_die, &sized_type);
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 541fee1a5f0a..a6df0491eebf 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -173,6 +173,12 @@ extern struct annotated_data_stat ann_data_stat;
 struct type_state_reg {
 	Dwarf_Die type;
 	u32 imm_value;
+        /*
+         * The offset within the struct that the register points to.
+         * A value of 0 means the register points to the beginning.
+	 * type_offset = op->offset + reg->offset
+         */
+	s32 offset;
 	bool ok;
 	bool caller_saved;
 	u8 kind;
-- 
2.50.1.470.g6ba607880d-goog


