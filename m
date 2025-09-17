Return-Path: <linux-kernel+bounces-821589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D075B81B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E421B270FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BF92D6E41;
	Wed, 17 Sep 2025 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7vy1f0/"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF3E27CB35
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139095; cv=none; b=hgWhFwpkfpIfNdmsOm+SDbxoTxVmDzkbGeYmqspEaZoL3fKaJRCRERqA9FgxGLDnFkozh6Tk+Ekt1q9ox2TukQB+10vSJpj/WkyvWrb8GvzYfKMZmgETCo8P1hrV5j63qxCSQ5Wc2ymwb0LvgudsdB0izrH4HaE475kk87jIvfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139095; c=relaxed/simple;
	bh=dpu8i8I6A6nGqt1QrLv4wp8M4TqiJP/BduY3wzc1ymE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FOe34bK7JGIYaNsvxRwOSjTO6yVZKd95XU37KxfX47LcDzcGzPX4/Vj3GX11CWcrQ8ja8TikdY5/9MYlYd5hu+WMDJvFtMX5ZPyQMXfc57nNEo0KqDCnY1Dg6uMXJYK+OuFWZpXXurm9FF/9s6uKX5XWifVmwdJBxFBiKvFYkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L7vy1f0/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-730b15a72deso1695067b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758139093; x=1758743893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7i+x5H1L416WqVhcp9K/dXS5Kf1wboTabZYAs3Wqz1g=;
        b=L7vy1f0/khA9bUo0o/PIdHKe4PYdZM3op9JdntiaTDoWrC7ruA2JUQBLdO69YZBhXT
         ow5PkGczmW99eg/2oybbeB1zagiBduexy1HT+BsWRzO6TVOuOmM+AODAZvPohA96rbM3
         usC4dncHDeSEKJ1Qqz7HvgjmKzEPd0ar+szrCMN9fOZbhANSPU9tCZjvYwZRycc4FZ8t
         nHMQXT+XAWb6p4cjh+T4qhCyzqUsqr09bPLDN71o3BymYVMQkPtYDXbn0BItE3XDIDli
         G+vhkKX3zwHYcMb3k0ZVzgCFsTxYsx9Ubs2b+MI6kn8OFdRYmqmK5DNHD4V8NeQ5VqSr
         eKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139093; x=1758743893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7i+x5H1L416WqVhcp9K/dXS5Kf1wboTabZYAs3Wqz1g=;
        b=VegS8MgfwhoXQviQthNhZRruiDDAW5J47e8ViCHpxj7kgLQbs4yQ1bS2SDlUyV4CEw
         JXN/DbYTmi/nUkXkHqZWEdW/wz96ngCDhvvq1AXyyTWxCsDn4uKRLye6pwYcXojYluMf
         u5JdM00UtWSO4A3ogWNA4XAZ0KCULUUiAELdBb4UlzbIoPEZjkO/SKRNYZkK0ers+X5f
         TqbWbq8i9tocYpbVzzQf3sA6l6mIjAjjTjgKvArVgRFxU2ztMEJ08rs4/VuHk12G5U/u
         Wlif1Q/4XHU0Nb76x9PvrRQT3dsFAr6PLOKLSOeE0r3I5eW4lfWiG9XL+dS6orNGDhHr
         dzbw==
X-Forwarded-Encrypted: i=1; AJvYcCVm11ukIQOGzmfNh2HfdPqandAMMHn0bF/asLUdRgefG9dP2pvBKEVQ4IWXQKxHwXWmEGpNzX+lVogtfN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWtrdLV0Nzy3khzXzjst+x3B+EZ5nvHWClSBgJUEDgj6dBSOnJ
	DdeVPHi+hrSn1c23gNgvixcDzWqB7Y9aTgHUxVbJOjjlBh9qpk/l58P3hvje6n9I/yIlNvN1RST
	JLYQsE6MIgA==
X-Google-Smtp-Source: AGHT+IG4W723sYY6hqIWWYmytVPBFPN4vrquo6D23T7Y9myc1cur3ijMv4Yp/xyL3yYQwQevsQ5UOobmscoq
X-Received: from ywbfr3.prod.google.com ([2002:a05:690c:3583:b0:71c:4305:1a38])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:b89:b0:724:fc2c:769
 with SMTP id 00721157ae682-738909bcc85mr28868297b3.24.1758139093213; Wed, 17
 Sep 2025 12:58:13 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:58:00 +0000
In-Reply-To: <20250917195808.2514277-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917195808.2514277-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917195808.2514277-3-zecheng@google.com>
Subject: [PATCH v3 02/10] perf annotate: Rename TSR_KIND_POINTER to TSR_KIND_PERCPU_POINTER
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

TSR_KIND_POINTER only represents percpu pointers currently. Rename it to
TSR_KIND_PERCPU_POINTER so we can use the TSR_KIND_POINTER to represent
pointer to a type.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/arch/x86/annotate/instructions.c | 4 ++--
 tools/perf/util/annotate-data.c             | 6 +++---
 tools/perf/util/annotate-data.h             | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index c6d403eae744..da98a4e3c52c 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -301,7 +301,7 @@ static void update_insn_state_x86(struct type_state *state,
 			 * as a pointer.
 			 */
 			tsr->type = type_die;
-			tsr->kind = TSR_KIND_POINTER;
+			tsr->kind = TSR_KIND_PERCPU_POINTER;
 			tsr->ok = true;
 
 			pr_debug_dtp("add [%x] percpu %#"PRIx64" -> reg%d",
@@ -521,7 +521,7 @@ static void update_insn_state_x86(struct type_state *state,
 		}
 		/* And then dereference the calculated pointer if it has one */
 		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
-			 state->regs[sreg].kind == TSR_KIND_POINTER &&
+			 state->regs[sreg].kind == TSR_KIND_PERCPU_POINTER &&
 			 die_get_member_type(&state->regs[sreg].type,
 					     src->offset, &type_die)) {
 			tsr->type = type_die;
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 258157cc43c2..903027a6fb7d 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -58,7 +58,7 @@ void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
 	case TSR_KIND_CONST:
 		pr_info(" constant\n");
 		return;
-	case TSR_KIND_POINTER:
+	case TSR_KIND_PERCPU_POINTER:
 		pr_info(" pointer");
 		/* it also prints the type info */
 		break;
@@ -591,7 +591,7 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	switch (tag) {
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
-		stack->compound = (kind != TSR_KIND_POINTER);
+		stack->compound = (kind != TSR_KIND_PERCPU_POINTER);
 		break;
 	default:
 		stack->compound = false;
@@ -1116,7 +1116,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		return PERF_TMR_OK;
 	}
 
-	if (state->regs[reg].kind == TSR_KIND_POINTER) {
+	if (state->regs[reg].kind == TSR_KIND_PERCPU_POINTER) {
 		pr_debug_dtp("percpu ptr");
 
 		/*
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 541fee1a5f0a..dd3807b55208 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -34,7 +34,7 @@ enum type_state_kind {
 	TSR_KIND_TYPE,
 	TSR_KIND_PERCPU_BASE,
 	TSR_KIND_CONST,
-	TSR_KIND_POINTER,
+	TSR_KIND_PERCPU_POINTER,
 	TSR_KIND_CANARY,
 };
 
-- 
2.51.0.384.g4c02a37b29-goog


