Return-Path: <linux-kernel+bounces-785471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC4AB34B33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22B61B2455F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5302F3C2D;
	Mon, 25 Aug 2025 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giY7T5nI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF328C03B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151667; cv=none; b=XUsTlwCJMtVRrbJX6+8IVXl/WyDtLOfoiNjF8vFTRIohHnrzeKcyQW2TFL/ENvNd5/hpd1+VG2cOqBJVFJbKR/5o5WhbcqDxGo9X4oHjKayjXtXOPs7ZcVyMe70CkpVGBU8PxS8RfdK+Igb3ec1+zRUWYxLbgt1slf3teTlLVtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151667; c=relaxed/simple;
	bh=yCJvAggFCJJNC9nbnVFyHV3KVWhVQ38QF5ysxVxbOPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e1U8/OPO+WMlq9hniRzxDRjCo227K+HNhylLJXyD1AbelkTAHIccPqNpHQTGmGKiXMAhel+QpY2XTI4wi15j4EJZ8VY0OrUyNriBssbMDQQQ+rN4CYJNm/UfdqzHpiIjAmML6fJr2/02Nj3kCZrRpFOzEYeFW6ahfzz53GkjGbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=giY7T5nI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e931cac8a57so8041335276.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151665; x=1756756465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoM6nT3UO5EedJZHVwloK+jqpWtKjC5piiS+X92tOnc=;
        b=giY7T5nIngJGwqcfs05jBGM/cUwdddCegxLEWPbCpWWQ9A6KZWqzFhzGigEN6KpgS2
         82PNS3P/f2qyWzXOj3C5GkalXRR69a1sJFvGJpJNYCPLT0FKZ4CzYWIeyW5T1m4qN7XB
         l8RYfzSd7YfQ4TFk6V1MTB/b3kgtAEXF/T5J26b9flVH1NllqE9LQM4k6BR4wHEcDm9B
         Cmd6FyMjbsXjv0QLfXc4N9T0gsP0EKriXVCxImanADbQSOzlRzMEUgIoQ8wUDwX4mv64
         ECMSZWDwIZWOILL5C7BC3719ekKrbY3xYx5qDjbQ6lsd3IZYL8FxQopJSXWmXGDzxdZ/
         yZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151665; x=1756756465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoM6nT3UO5EedJZHVwloK+jqpWtKjC5piiS+X92tOnc=;
        b=sSYDTY0k/UXBPoFxi1kku329LV7pvm5oJRrY30FyMQGdx86Kaq6gVRiVm/PIBZ1hLW
         cLSNgjhoziB8cN0vLqtXVYLkj6UpSnQesdHUGxs7xz4YOFXj6ffwlyD/NWGKYwOZeFgU
         d+7NIY83XZBsGMjt8wAOKGbFfKC0sJ7xN73DGLjFyCwAP0F06hhFzKaoysaYwRxTy7Q2
         kfpU3u8sBhg79iA/dzyfBYlWfHtPporH5RZJIJT6o39f658oDZDSwaadWNLA/qK+sFyx
         mE6lSB1zgtJbhf3skuJiQrn2O1fvFzcoD9B4kUkkEOxEPB4MhqCpNkgJasSMbEDPPVke
         N14Q==
X-Forwarded-Encrypted: i=1; AJvYcCURTIMKBSwRL0RP+yhKIB6JT1tTKfaDYPr//FeIn5KfJBUzPjo+G/OovPg2LvEt301yWt2g6B/cR00MXVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wvQrDRkZhy+8L1zRf3eqDBcGYSFD7/ve8lWLbnSu/KFJkELk
	rdG3bqXaToUPsOQgxHLGSGHtmoKylGZdd3n0+nGSuQVrhUsCSd43zBc+0Q2o/pqWUbSVpvBVDB4
	iPQllqW/H0w==
X-Google-Smtp-Source: AGHT+IFEVL/t0+NA3GgEpnyUuTPb/XWpdqcnoWTaJVDACO5F85Shp3J5tuzA0ZM+O9sK/3WiXnKfkhpEydMM
X-Received: from ybbfp2.prod.google.com ([2002:a05:6902:2d42:b0:e94:ddd5:ab7f])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:6c10:b0:e95:3946:b46
 with SMTP id 3f1490d57ef6-e9539460df7mr6781780276.38.1756151665206; Mon, 25
 Aug 2025 12:54:25 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:54:06 +0000
In-Reply-To: <20250825195412.223077-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825195412.223077-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195412.223077-5-zecheng@google.com>
Subject: [PATCH v2 04/10] perf annotate: Skip annotating data types to lea instructions
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

Introduce a helper function is_address_gen_insn() to check
arch-dependent address generation instructions like lea in x86. Remove
type annotation on these instructions since they are not accessing
memory. It should be counted as `no_mem_ops`.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/annotate.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0dd475a744b6..9d36709d867d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2621,6 +2621,19 @@ static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *loc)
 	return false;
 }
 
+/**
+ * Returns true if the instruction has a memory operand without
+ * performing a load/store
+ */
+static bool is_address_gen_insn(struct arch *arch, struct disasm_line *dl)
+{
+	if (arch__is(arch, "x86"))
+		if (!strncmp(dl->ins.name, "lea", 3))
+			return true;
+
+	return false;
+}
+
 static struct disasm_line *
 annotation__prev_asm_line(struct annotation *notes, struct disasm_line *curr)
 {
@@ -2729,6 +2742,11 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
 		return &stackop_type;
 	}
 
+	if (is_address_gen_insn(arch, dl)) {
+		istat->bad++;
+		return NULL;
+	}
+
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		struct data_loc_info dloc = {
 			.arch = arch,
-- 
2.51.0.261.g7ce5a0a67e-goog


