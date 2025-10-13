Return-Path: <linux-kernel+bounces-851159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE7FBD5ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 218984F1F37
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63A42D46DB;
	Mon, 13 Oct 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZ6putqW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE112D24AB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379381; cv=none; b=mX6Q+90X6XA/fYTwBxQBhG25qoY4ocfrkSZAOee9Y4FFcqnt8JIFAZKbc+0L6ubXXuseyY9mgmnTnNxLYWy2B6/nBazlvnpLK5okduwBeu38ckcsDKwUwQI5/ohzQrBDOMw1xUtzQFOzsFUJV8+q88etmXAuW/UTeaIsLKWiBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379381; c=relaxed/simple;
	bh=yHC8CVWMZLFswZB5BZnl64Jv+qo1EVgYh/6mmRz9jq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mOlYK3eH5SDIkoxFR/IRl4/9inudUwRo2hWLi6jxIPpfgqqCZ9SmT35A9a1S/xd8RmfDqIrakB0PtXfqeO5Wdq84nKphMah3Pc/I5TMHx5cy93FYe7btWzFShqgJBR0pD6KOf22TReOlfdWA831DpXBaG0iP5qHMv0qAZnHf8j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZ6putqW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-77f7181dd64so76662247b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760379378; x=1760984178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hkslBj9QnenKFXYBHLOJRKHFsiaTZNhKphNQFAB+kY=;
        b=WZ6putqWTKCSbTcvBHkjatrKgbaB8Ici1Nnej7W01WrS41WUzlH+X66aaHMQ9gdhX6
         bErECYRJk0WOXnE32A6ebXZZAS2Cx4HrM9Aocjjz5KhPaCA/+MQY+qgCfUAGepXP75qs
         0Yz7IqW2xB23pTSXrqoCbGYTozgevbxS7JuCaU4vKvE5i5pxtdLrqNBR8b5KKBK/tIrS
         4X787CXXLUN4Tk1s6iCMSOkV80ZYxHf1RWgYGK1CQC/XTXuAoJqTrGkMbRZUsKjuvMLl
         jd++CS4wBwHoPZgtuDtXKHPhFn+5okojVQSFKWXPNUUqALC29PkrnmOF1pkZUVEdoKzj
         CO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379378; x=1760984178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hkslBj9QnenKFXYBHLOJRKHFsiaTZNhKphNQFAB+kY=;
        b=mvAYC+XeImdIdLr1lxY55tesroLsZV+qpeprTRZW/fF2jstj5ZF1bnKqfaajj/5pKa
         3sgEZTfjAo5Hbis2Bnk/HN+lgBfgnrLb0444Ez3zIU9EgvAaMUk8khqfO866y/l9m8MM
         ESf5Pjb1zLhNEnp91s7itOzjTyARpdmdA1GNm3FE75Nfiq0s3uA3ioaQ+Xxuyzs6pUJi
         lZqKeznzwM2iHGUUcyda56LpzznSrFM1cbrSrCfT48lhvyRG/zJhIzfV4iUyqLG8JLSb
         sH8CMx+SrJhT6eaJqNPnfe7YCXxMxJ35vYW9bVEom3JfT3zZUPxVI+lkzPGAl+En8QUZ
         SSQw==
X-Forwarded-Encrypted: i=1; AJvYcCXXDvSzRmugjZeCEuKrizVTmXbbzzt3UOpqdxg9DRG5B+eXXKkvHL7JMK9yiZDsm9LEf+MVxI7kWYIdLgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkKPEEtQiUYuZ69fpnCnXkIN8rT/a4XGLMzoUWLdBtQ0X2TXUx
	dDQ+jOOPaUvDs/QJuunU1qmmTFz12frNKiyObCoZPi+Nljs7epRTY+YcX3BS11gSwzogOLgNBbu
	Bt7Rx5qhTKw==
X-Google-Smtp-Source: AGHT+IHNvYc4EnpQJDa/W9ZUqFHuWghaPl58/if45oZ40Yx07rPWgPRHJhoLLoxjiElcUGodjsLfcoxze2r7
X-Received: from ybbfx3.prod.google.com ([2002:a05:6902:2ec3:b0:ea5:d578:cf1d])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:2145:b0:63c:f5a6:f2f6
 with SMTP id 956f58d0204a3-63cf5a706d2mr6966696d50.56.1760379378159; Mon, 13
 Oct 2025 11:16:18 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:15:58 +0000
In-Reply-To: <20251013181607.2745653-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013181607.2745653-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251013181607.2745653-2-zecheng@google.com>
Subject: [PATCH v4 1/9] perf annotate: Skip annotating data types to lea instructions
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

Introduce a helper function is_address_gen_insn() to check
arch-dependent address generation instructions like lea in x86. Remove
type annotation on these instructions since they are not accessing
memory. It should be counted as `no_mem_ops`.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/annotate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a2e34f149a07..fb60467fa877 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2698,6 +2698,20 @@ static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *loc)
 	return false;
 }
 
+/**
+ * Returns true if the instruction has a memory operand without
+ * performing a load/store
+ */
+static bool is_address_gen_insn(struct arch *arch, struct disasm_line *dl)
+{
+	if (arch__is(arch, "x86")) {
+		if (!strncmp(dl->ins.name, "lea", 3))
+			return true;
+	}
+
+	return false;
+}
+
 static struct disasm_line *
 annotation__prev_asm_line(struct annotation *notes, struct disasm_line *curr)
 {
@@ -2806,6 +2820,12 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
 		return &stackop_type;
 	}
 
+	if (is_address_gen_insn(arch, dl)) {
+		istat->bad++;
+		ann_data_stat.no_mem_ops++;
+		return NO_TYPE;
+	}
+
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		struct data_loc_info dloc = {
 			.arch = arch,
-- 
2.51.0.788.g6d19910ace-goog


