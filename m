Return-Path: <linux-kernel+bounces-851163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C458BD5ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6740F4EFD9C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2402D6E7A;
	Mon, 13 Oct 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cn00r3Or"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E812D540D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379385; cv=none; b=bNBXyw+U8mNifPohntuYwVYDZqxh7K609bfQ9IbyyI3OO0zMvd9RhO/jrOpG19BhHOJsujLlTWmjWHIvpATnujaHW9d4t349BWQ8VgZpsvDDxXcL8LTBvcGrKlG7zOExhL9A70louFWd5PqqQoXG/fr4P1AubMJEK+BAudTDYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379385; c=relaxed/simple;
	bh=ToPviQ3pz8O+6ktaQwLB74UbmlwvmLMLepaXaXplunU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SCHvSyMF4Pk9JGbWXVvOxN/6cc5x1vfT3BaeRF9CJCoGC+fXhHodjKtDAhqGnYDmZOYSRZv2R3dBnqCYRWvlc1eRRQtHdt0m8rS0PxcAGMbFDPAzEaXUbnQ+RrtJTi6Z358wQIKieDoIxK6WT8NmwAGVlZXpZzL4w9dAcl5YCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cn00r3Or; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8589058c6d1so1013430485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760379382; x=1760984182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Rfb8JCowzLJ5r2jCLPuYLaJw/PBH58RHTWh8vQaR8g=;
        b=cn00r3Or+0DYv/REVUn5NuRLRLwT5E1ymHfl7z/XY7qQ52TCopi3bM7ZEgoxW+4R8h
         FYsAo9YP1G7iT/Rh1Zc+o4VmLfA2XxHZ21dWgphikCNf6XEoWxIZkP0HH4Dy1ol0tDtA
         gSWgh67ldQUMES5QV0KCrzpc3dg8mjNefHWn73kQDwENyvvX6nmpkWUQ7z4bIhd3EZLP
         AIKhZbenXwve6UK77VesEMI5DB4ad/eAC/Jti/RWUEQOZp++WWzepku66seg01Tfw9QM
         nZ+PpE7nMTx0QzaJhgeEYLfoJRH0Jdurq1fjw9LbEApLhpfcTaKaPYKAzMZXZpQx9h0z
         eHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379382; x=1760984182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Rfb8JCowzLJ5r2jCLPuYLaJw/PBH58RHTWh8vQaR8g=;
        b=R3agtiPj6rLI1R6d6jLEeZ4YA5DHlXefSqWOAQkbn2DA6ZhTkPcXAAHw8ZYgAkcMmk
         evJ0D2CcwNrqgth8+mkIGW71E9PLD4oj5kq4/w3hMvAURkGp/sQPXNy/3UyTx64RS9A6
         /4vv3jwrAT7BF64fFh2Szua12VyYmM8rFyJasNRnf0CgFhMH5oN0iLvJ/0AxyFqtC6n3
         UsXPFgV0cmCwz6K1bBBB8eUyOVSANdKa07B+8oQcpPltJnmEbM80F5XHzABVBGWbIRWF
         T16LTe7XFK2dWRO6iXiOWSIEdYYlcASU8wHrd1XmCz0e/YX/JApopRd9HHlvJJ1xfsrY
         86Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVqAuG9Y8DBOHPIh1utr/qHhIBpLiocQxQCYPt/Fvnj+IyLM4JGbcjMAEa7mhqc+Vx36FdUsqyONvYJSvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgaxdnX4/3ChMHsHpsGudQXkUxhqTL7Nw7fBMzWxeUan/maJgc
	CaiG4qZ5i8Kr3Ve7Fqwl/8BaITrRDuRS6siYmlIgV5z4+QiFFJmrYv828cHlTYyDhJzbRBhVHte
	TDxY1t8QkjQ==
X-Google-Smtp-Source: AGHT+IE0IBOLOB58QpKoosKX/MQwaFpEjAcCa4XOBgT+8H584tpOOlLyfMkLMZuMbnVqng4IDrVLjAwL8Qam
X-Received: from qknvl4.prod.google.com ([2002:a05:620a:7104:b0:828:a22b:ec45])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:1a90:b0:827:d83e:a64d
 with SMTP id af79cd13be357-88354ac524cmr2715680985a.27.1760379382489; Mon, 13
 Oct 2025 11:16:22 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:16:02 +0000
In-Reply-To: <20251013181607.2745653-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013181607.2745653-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251013181607.2745653-6-zecheng@google.com>
Subject: [PATCH v4 5/9] perf annotate: Invalidate register states for
 untracked instructions
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

When tracking variable types, instructions that modify a pointer value
in an untracked way can lead to incorrect type propagation. To prevent
this, invalidate the register state when encountering such instructions.

This change invalidates pointer types for various arithmetic and bitwise
operations that current pointer offset tracking doesn't support, like
imul, shl, and, inc, etc.

A special case is added for 'xor reg, reg', which is a common idiom for
zeroing a register. For this, the register state is updated to be a
constant with a value of 0.

This could introduce slight regressions if a variable is zeroed and then
reused. This can be addressed in the future by using all DWARF locations
for instruction tracking instead of only the first one.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/arch/x86/annotate/instructions.c | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 0c87e42ca3dc..803f9351a3fb 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -427,6 +427,35 @@ static void update_insn_state_x86(struct type_state *state,
 		return;
 	}
 
+	/* Invalidate register states for other ops which may change pointers */
+	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
+	    dwarf_tag(&state->regs[dst->reg1].type) == DW_TAG_pointer_type) {
+		if (!strncmp(dl->ins.name, "imul", 4) || !strncmp(dl->ins.name, "mul", 3) ||
+		    !strncmp(dl->ins.name, "idiv", 4) || !strncmp(dl->ins.name, "div", 3) ||
+		    !strncmp(dl->ins.name, "shl", 3)  || !strncmp(dl->ins.name, "shr", 3) ||
+		    !strncmp(dl->ins.name, "sar", 3)  || !strncmp(dl->ins.name, "and", 3) ||
+		    !strncmp(dl->ins.name, "or", 2)   || !strncmp(dl->ins.name, "neg", 3) ||
+		    !strncmp(dl->ins.name, "inc", 3)  || !strncmp(dl->ins.name, "dec", 3)) {
+			pr_debug_dtp("%s [%x] invalidate reg%d\n",
+						dl->ins.name, insn_offset, dst->reg1);
+			state->regs[dst->reg1].ok = false;
+			state->regs[dst->reg1].copied_from = -1;
+			return;
+		}
+
+		if (!strncmp(dl->ins.name, "xor", 3) && dst->reg1 == src->reg1) {
+			/* xor reg, reg clears the register */
+			pr_debug_dtp("xor [%x] clear reg%d\n",
+				     insn_offset, dst->reg1);
+
+			state->regs[dst->reg1].kind = TSR_KIND_CONST;
+			state->regs[dst->reg1].imm_value = 0;
+			state->regs[dst->reg1].ok = true;
+			state->regs[dst->reg1].copied_from = -1;
+			return;
+		}
+	}
+
 	if (strncmp(dl->ins.name, "mov", 3))
 		return;
 
-- 
2.51.0.788.g6d19910ace-goog


