Return-Path: <linux-kernel+bounces-746317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC4B12567
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0C27B99F0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AFB25EF87;
	Fri, 25 Jul 2025 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxk5IvdU"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD725D1F5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475307; cv=none; b=ZgL9cSni5zuhnDo3L7tTHhFO5VTVFHSp/CHs1z8SiIUcyqQX1OUN5VjlW0KP5yTgT/p6mXKAQ3rPC9B5dbRY9Wz1oU8k2TLWj3FCaGB+52nURpikQGUMFNZwT3PLkvs23uBCvu+tLXgKJgV/kIqWDHZMDDS3KSZapAZO/KroDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475307; c=relaxed/simple;
	bh=RsMdV+T8oKe7okrmOS/sDhgJDG36fgIYtZAj1bhrGk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QjyJr+NySDoDPTEeBt2VWTfKJNzaHhrGKMbr9ea5z6tDnCkzIRJw9X7hf1ORX7qQ1oTupzsJPiD4xogvkDzpSIDsqqmt+JjoMYlVrUq+476Y8wea4MBjNW+QW7VhuUphOd2F1JkuBCJeJqxjCLigNDS+tv9AONqqN08Tf5csWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxk5IvdU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-71838151744so37209687b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753475305; x=1754080105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NH3grKs9mzJDbjLSRQxCfhlTx/fm7fL4sq33ftQ/Ko4=;
        b=pxk5IvdURHQ0RGBdMjYbVRhPNdKXSazeJJfaRrPCdWWy6s9gWfDBNz8DL52i7y+blq
         ylGxVHQ8QZsjYg3Ve6a9yJo1CGxLTkZTqCC4ov4PEDaHAw1z/KJ0yQMUb7olu2RC/s2C
         1f2DyF2+/DJ67j1gYFqS3bXqACrqIYXX4Ak4BPSXhQjlPlRPZXcA3LlggJEsAsv9q1I0
         d/dhLLak+TIYdwc9xK39xzqPbvUT1dfbiIPDfx83HJd7qKuiCrwijZlWFgxJt5vmiP87
         2WcyKBz0aaz/09CEavL4MsyEAoK20yr3rmjhF1dHco1f+rQT6pE77+kKZ/AsVMyirxBr
         urOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753475305; x=1754080105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NH3grKs9mzJDbjLSRQxCfhlTx/fm7fL4sq33ftQ/Ko4=;
        b=LsMYP7NZfWeXCV215QxwIwT3wjU4ltA4gBAVOLMDJ4kfhW1mj/doqyqWYxHqBGx+mM
         wqqC1GBwUvqmJbzfFHeaByaoDxwZZ3eA9ASHrXpI1uAt2iTSdAXGvyNou53wOB0EdTDK
         QnOmlLIT0VG3B4zFUZmHisu32gCzswffEs+ibo4IFI4olO6v9JKM4WFi/hVaYXPN8UCD
         lFuM2OYkEhwcK1nd1MIRkZyAQL5/8Fv9jqKzyY5GXEkXVGZjMkj7SAh9oTGlZdCb9wv7
         bQoC/fiq1y1WtdlBS5Qx7iVLjqxR8Iv34L4bqTLcEe+Ifhngi8NR43RraFLHgu08AY3T
         Snzg==
X-Forwarded-Encrypted: i=1; AJvYcCUPglNh8O6Ti+uqBdOSh3fNImg8schjZ75Ebg9G3xx0ix4JC/RVQ0zWEBG3unG7mhoSv4sMjnmfG39nmfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTL+KMRaEIoa5/WVVoqPuEgek9xXFKEJZ87DudSlaLev+ilBxZ
	Tb8T5BbX2SJc4cNpFm7k+Tcr9hJlmnas3wl89TDxrxfTRduT23SjhAT1QQAxgoRV71ZkjMiXpqq
	9q4y8iNFBXg==
X-Google-Smtp-Source: AGHT+IFA927CeUxwshzc5Vf180U6zjOSOk2doZe+aMZiyiIUWXypDsYJ/hDfFF5wLUe1G7GR4PTltMGsdSel
X-Received: from ywbje8.prod.google.com ([2002:a05:690c:6f88:b0:70e:86e0:e0bd])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:4a01:b0:70e:2c7f:2ed4
 with SMTP id 00721157ae682-719e30b8bccmr46449947b3.0.1753475304908; Fri, 25
 Jul 2025 13:28:24 -0700 (PDT)
Date: Fri, 25 Jul 2025 20:28:07 +0000
In-Reply-To: <20250725202809.1230085-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725202809.1230085-1-zecheng@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725202809.1230085-5-zecheng@google.com>
Subject: [PATCH v1 4/6] perf annotate: Skip annotating data types to lea instructions
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

Remove type annotation on lea instructions since they are not accessing
memory. It should be counted as `no_mem_ops`.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/annotate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0dd475a744b6..0d6f85ab9170 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2729,6 +2729,11 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
 		return &stackop_type;
 	}
 
+	if (!strncmp(dl->ins.name, "lea", 3)) {
+		istat->bad++;
+		return NULL;
+	}
+
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		struct data_loc_info dloc = {
 			.arch = arch,
-- 
2.50.1.470.g6ba607880d-goog


