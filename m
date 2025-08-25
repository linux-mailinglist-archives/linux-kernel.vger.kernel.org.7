Return-Path: <linux-kernel+bounces-785475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6094FB34B41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E611B2444C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF6B286898;
	Mon, 25 Aug 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JcPKebOF"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B4A41
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151880; cv=none; b=orS3CGDGSYJ2MJm3u0sOmVn19M+yuq0Dxso31jKFGQRx58UDNyuVXiKnrrZwIHbCNS2JvlBNzeZ63Lg2u7ekhWsuN044KSmBq5RhnmS6gu8wkMsD/b3Fpn46w5xAS44ExwEq5DBU57Q5u8He8gdIcADkH4mvShupJ1Ru+79Rc/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151880; c=relaxed/simple;
	bh=KYZlwoGa5vbIQE/Fb7QwYBnfnpW4ntT0hmF6r0Mz8BI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GOrK0OfF8PNaN+NuInml2RanWajtKk9WoiAtt5pQQw0GELriIgwMSaWY8fhrR4A3IMlnrpeJDqi95FsMrmFaiFX9Bhep6S1GxhSajqD4c9ikDkKOtdR1Y0OxpjucdCxyPubistacSQKR0zqO5ZZYJ3780MChKqTvlgYW1poWuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JcPKebOF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e96dc23e87aso383811276.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151876; x=1756756676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=08dXmPghU0JnpjE+T8fIsEuZwVOSefbIYQFBh5AwU3k=;
        b=JcPKebOFge+0MHBFR+6fpZPendn2HWfARdfjL9upH9aUMyo7yDOSWDiqD2/lcO+tmu
         uXKpKtlAWkVe7KHCCsMMnVeRGNP6sEr92R9mGEejEeHbWXDjOm6bU6H4t6MnRQkKbYPs
         8R7GLwVd/N4sbzP8tKfzwX/O3clmuUYY7V4bHKkkbH6etRQWrEo3w3PXCVzq2OW67lQJ
         9Wc8wfac7wNZyw6ZyrDqBrSLv7iJUMcyI6J0c7Rz40WXtpELtF6caBe9SNthViqk0Vul
         U2aBOovn4UYES880v9I6dbm4tPK5DiOHzJRkyupR1GnVHQ7U0gChF+Da8MpdJGdoPSzK
         Qz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151876; x=1756756676;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08dXmPghU0JnpjE+T8fIsEuZwVOSefbIYQFBh5AwU3k=;
        b=Ysbkx9FOPCCfPCn+HkfCL40PqX2a6wIw8FN1s8XlC+141HDOnsGeLu/FDqnH3te8je
         khY6eteNsASQ2les21p+Y4YcDwbIX5ecDI+t19Zes9eaNr+armxc3NZv6XhJyAT6MqGa
         +NXjkVrbsWuyLfuTzutqQ/8bW3iTxeWBiuaEFm7cTjkt1edgpYoE9Sev1QcrcubFJZ+D
         UQ/2yW1g2aV/WMWNcLyQEhbrBgm+lRKF5CdGZkZ6dTlLNNRnxqopfddHSgN+C++rqAP3
         dN0oYQj0vUEOxattkKYdmqcGC6bqy+yYHKELExzXDy8K3Rr/hdm82aSJ3mAqNjsIitmx
         FDNA==
X-Forwarded-Encrypted: i=1; AJvYcCVI9MhmiyeZaYUwsKfgWSzsy7l44A8q2nGW2GIBoOQAf+kI7bLg7jg0M/UFtv/t2cgLSDMpU+c6SgsFiMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2QCZ3JZlg/yavEFM8dKXG+gJPx5AEP/QaO67705HcyOHl/noa
	uoRx9temygrihggGndJeD90PxmLfVeuir+BDaBRMfYUxH3wYe0HOu7eo3J/uxoVkyOQEq90rvb/
	J/YmMoqEH0Q==
X-Google-Smtp-Source: AGHT+IE9h0wFaOrKq20+90BthWPtHEhHk8f0cNSEDfB0Ct7aebwLRpU9TQbWHL7KK18wcHahRhdmPzgdCybD
X-Received: from ybji33.prod.google.com ([2002:a25:b221:0:b0:e93:4d62:5f9b])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:120e:b0:e96:c67d:c61c
 with SMTP id 3f1490d57ef6-e96c67dcbafmr3656988276.8.1756151876619; Mon, 25
 Aug 2025 12:57:56 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:57:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195748.226052-1-zecheng@google.com>
Subject: [PATCH v2 07/10] perf annotate: Invalidate register states for
 unsupported instructions
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

Invalidate register states when encountering unsupported instructions
that modify pointers, to prevent propagating incorrect pointer types.

On x86, the 'xor' instruction may appear in a predecessor basic block
and zero out a register that invalidates the target register state. This
sometimes relates to tagged pointers and normal programs should not
dereference NULL pointers, so we assume such execution paths are invalid
and do not invalidate states for 'xor' instructions.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/arch/x86/annotate/instructions.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 540b4d0a01af..03df52a5266d 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -413,6 +413,23 @@ static void update_insn_state_x86(struct type_state *state,
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
+	}
+
 	if (strncmp(dl->ins.name, "mov", 3))
 		return;
 
-- 
2.51.0.261.g7ce5a0a67e-goog


