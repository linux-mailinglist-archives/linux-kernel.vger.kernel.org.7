Return-Path: <linux-kernel+bounces-821592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58232B81B26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1DE4A4562
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C0E27A929;
	Wed, 17 Sep 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhZ6qRlZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A402F5A3A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139099; cv=none; b=SEIOePWRoZSUqgq4+/PpvlLXOei7qOeZ57dr2BFnk5MeFtlSrcf5TUOc1U23CgfG8h1TsKLWopdjyu24SlSTqe8Hw6GMgTghmV9i4vvgkMY+Ijh+23KXJ2l2TVgbNGBsQv+ZTDMFkJcHpvKPY/r1Y2I2Ag6lJ2eOfra2zOs059E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139099; c=relaxed/simple;
	bh=2MXbAv0kCGgjdw/se833dTtc0f43qdPxo31NoZAjt3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SSwT8DTy07YuCXXzN2FZtFi8jNSVM/DjUhaJOfg1zBzYIkktc+fLJPnlkXHlA40xT3nHM07kwPRpNXZ4uxcVQfyt10B5D4fvibW+NTIBG7KnFQdw2C7s0uO1kDVodxDaKjzyjBk5zQZom+6JkgsojZeDrbUDZJYj5PSebQRGsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JhZ6qRlZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-733ff1a73dcso4154117b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758139097; x=1758743897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HnN3JvUSgCj73ym6XHuqdmgq/i5u2M7eJ3+csln+azY=;
        b=JhZ6qRlZ4fgb5+RrvrgdZFkTOEK/xrVxUS+vqfxgiCn9Qf26G+obog79leSewLwjyD
         aNwvUffG81GO9W+6KtQ4CWHLxQ2TLPY9uwmcMlkjjCKROAJ3bKcqL49jqnbrQTDnG+cp
         J6qyEiH5vfu0ieJEyKHuGoWjK8BQ+SHqcZBdMiHb0AyQ4zAuPYKQuRIozS27Tfq0uc4U
         KXmBcYk3ct+gpy3Cawz+EeJRyq0CZbVsk2UjsRPsMVfGce9gvYHnBB0GvwXIadZvs87H
         i++MeGozKqmEHPdv07AN201/3wpixwJlohcAZzF+VQcCxDQSCYcx9h5ar7Qb6HRJw2jv
         /HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139097; x=1758743897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnN3JvUSgCj73ym6XHuqdmgq/i5u2M7eJ3+csln+azY=;
        b=vX8cfJ2/7FPCri3yZAQ62pTch09gX+Asc/VigDySGlQ4qvZsfeZPy8Rc1MHb/0702k
         KeseP/MEW2sVvz3ZYzDmgEKBllvrcHlpGXT/HH5pqDwX+lqd0asg1surKQYCBCTK8wv9
         OylgtXk/1zgDDLJp94Oy+NfUrltvqgxUgDCNH3/u3LWn+nYtaYGp4TL3/RXwIXnPQz8/
         o/AvmnECYpaFHlkz7H7PK753V216tnyUcYs2OqZsNYctcSlGDai//AP8tBxNCCiio8Mv
         CYc/uXbn90DYIgwnjcDKzoq6wWuJ34q6Gc1eIGk96vKhamIJELaKlvk1r7HhRbIqku3J
         Ez6w==
X-Forwarded-Encrypted: i=1; AJvYcCUBtb/hfDlfRDYIXYgCkoevHmBA/Qrky5nNQLnnx5iHVj+0+mO500uklDJ+KQMld7jxId3aA4sN1RnJuJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+3fy/UppVUQJjTuQ3TNOCPcQ56JRg5BMUrK1I3tjl27tmSHtC
	5Og+zY/K3mtrVzMdf165Z0jfRzn6aqOifSuw1qSJdTECINL/0AEDcmATPsh2aOpyRORowefbbpF
	1o7+xx6BvxQ==
X-Google-Smtp-Source: AGHT+IHj7+GPPv+UYNJ9mWbDPAecxGy50S64SheNETQVT5qX2NhQt11owM2BprcVkbQpGKTl/HJRyyXkVOjo
X-Received: from ywbii6.prod.google.com ([2002:a05:690c:6a86:b0:723:af81:5294])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:7486:b0:733:2cbb:7afc
 with SMTP id 00721157ae682-73890babf9amr25703647b3.6.1758139096815; Wed, 17
 Sep 2025 12:58:16 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:58:03 +0000
In-Reply-To: <20250917195808.2514277-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917195808.2514277-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917195808.2514277-6-zecheng@google.com>
Subject: [PATCH v3 05/10] perf annotate: Save pointer offset in stack state
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

The tracked pointer offset was not being preserved in the stack state,
which could lead to incorrect type analysis. This change adds a
ptr_offset field to the type_state_stack struct and passes it to
set_stack_state and findnew_stack_state to ensure the offset is
preserved after the pointer is loaded from a stack location. It improves
the type annotation coverage and quality.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/arch/x86/annotate/instructions.c |  8 ++++----
 tools/perf/util/annotate-data.c             | 12 +++++++-----
 tools/perf/util/annotate-data.h             |  7 +++++--
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index cfb07cff8fc8..709c6f7efe82 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -525,12 +525,12 @@ static void update_insn_state_x86(struct type_state *state,
 			} else if (stack->kind == TSR_KIND_POINTER) {
 				tsr->type = stack->type;
 				tsr->kind = stack->kind;
-				tsr->offset = 0;
+				tsr->offset = stack->ptr_offset;
 				tsr->ok = true;
 			} else if (!stack->compound) {
 				tsr->type = stack->type;
 				tsr->kind = stack->kind;
-				tsr->offset = 0;
+				tsr->offset = stack->ptr_offset;
 				tsr->ok = true;
 			} else if (die_get_member_type(&stack->type,
 						       offset - stack->offset,
@@ -713,10 +713,10 @@ static void update_insn_state_x86(struct type_state *state,
 				 */
 				if (!stack->compound)
 					set_stack_state(stack, offset, tsr->kind,
-							&tsr->type);
+							&tsr->type, tsr->offset);
 			} else {
 				findnew_stack_state(state, offset, tsr->kind,
-						    &tsr->type);
+						    &tsr->type, tsr->offset);
 			}
 
 			if (dst->reg1 == fbreg) {
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 6ca5489f3c4c..68c69d343bff 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -577,7 +577,7 @@ struct type_state_stack *find_stack_state(struct type_state *state,
 }
 
 void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
-			    Dwarf_Die *type_die)
+			    Dwarf_Die *type_die, int ptr_offset)
 {
 	int tag;
 	Dwarf_Word size;
@@ -592,6 +592,7 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	stack->type = *type_die;
 	stack->size = size;
 	stack->offset = offset;
+	stack->ptr_offset = ptr_offset;
 	stack->kind = kind;
 
 	switch (tag) {
@@ -607,18 +608,19 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 
 struct type_state_stack *findnew_stack_state(struct type_state *state,
 						    int offset, u8 kind,
-						    Dwarf_Die *type_die)
+						    Dwarf_Die *type_die,
+						    int ptr_offset)
 {
 	struct type_state_stack *stack = find_stack_state(state, offset);
 
 	if (stack) {
-		set_stack_state(stack, offset, kind, type_die);
+		set_stack_state(stack, offset, kind, type_die, ptr_offset);
 		return stack;
 	}
 
 	stack = malloc(sizeof(*stack));
 	if (stack) {
-		set_stack_state(stack, offset, kind, type_die);
+		set_stack_state(stack, offset, kind, type_die, ptr_offset);
 		list_add(&stack->list, &state->stack_vars);
 	}
 	return stack;
@@ -888,7 +890,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				continue;
 
 			findnew_stack_state(state, offset, TSR_KIND_TYPE,
-					    &mem_die);
+					    &mem_die, /*ptr_offset=*/0);
 
 			if (var->reg == state->stack_reg) {
 				pr_debug_dtp("var [%"PRIx64"] %#x(reg%d)",
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 20237e7e4e2f..e1e9c5f6915a 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -191,6 +191,8 @@ struct type_state_stack {
 	struct list_head list;
 	Dwarf_Die type;
 	int offset;
+	/* pointer offset, saves tsr->offset on the stack state */
+	int ptr_offset;
 	int size;
 	bool compound;
 	u8 kind;
@@ -244,9 +246,10 @@ int annotated_data_type__get_member_name(struct annotated_data_type *adt,
 bool has_reg_type(struct type_state *state, int reg);
 struct type_state_stack *findnew_stack_state(struct type_state *state,
 						int offset, u8 kind,
-						Dwarf_Die *type_die);
+						Dwarf_Die *type_die,
+						int ptr_offset);
 void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
-				Dwarf_Die *type_die);
+				Dwarf_Die *type_die, int ptr_offset);
 struct type_state_stack *find_stack_state(struct type_state *state,
 						int offset);
 bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
-- 
2.51.0.384.g4c02a37b29-goog


