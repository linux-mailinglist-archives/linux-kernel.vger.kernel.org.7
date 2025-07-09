Return-Path: <linux-kernel+bounces-724530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A3AFF404
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8FF7B5411
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05184245016;
	Wed,  9 Jul 2025 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0BOpsuU"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80C21FF39
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097240; cv=none; b=PQGPmRlRo0EPPcbM+yskDJNFPw8awvIb1nlW5epBVQrPPxaMj34u3qsRoyCLrKLMVlhYMlgZRXLeKes3Ix02lhutn2Ew9oLLM+cUuGLZuzTSe3A9tDXdaJ1YLl5oJf8FRJNY0AYfyLKoadEr2DrQxB6RswYKWYlPN532oPp4S84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097240; c=relaxed/simple;
	bh=SCSVRXj5DB/cfKYLIvAW2+qqqcd9DzSoDst4X0cpuZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IiE6E76RU/5jbUlTnkoPO95xigOq+espd7p3P1cGeL7+fR+f8hlJqfiaYObgD3CeJJMbdykKMnhYjqq6jzk3LU+kvHS5Fgov1PtiqYjeUb+lIddyiFQoCf9pqzmK95u4J70Uckj/cCblzxnRHLgsFe279GU3NnILTlOcEeRzgvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0BOpsuU; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31f112c90aso229504a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097238; x=1752702038; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uM9b0q174RElAGAUOsRC1+X9nDdEI4t5lPgRji4c5mk=;
        b=Y0BOpsuUIGsy3gWSx0LPqxrT2TyUQqsjK2c0lOykR4xIAxUL/xhYx9WPaxYYYzub8A
         HG/XCuEYV1y5XkuFoNDFLZXw92xkwkLAUsVl6WvwHSnFVeFp0dAGHe2UbCj8V4woTMdp
         v4Ud1Ou5EutbVMQNwqxbcdbhOfG8Z/5I3OsP7Pbve/IDmcLj2ZEgrCEz3OOOcM+pDngg
         o/OxVoozsmb0ny5USi0Qd6Bx1j6qTAgYctyZxRW/kaN5plkBYBGFdT0vmmD1KPUWOVuh
         71ukpZdc9Upb2kAGKKjEnWbFxw15pVYCRpqkTfo+NxAWnOepAu6AHha03q/602aV7ZGY
         u1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097238; x=1752702038;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uM9b0q174RElAGAUOsRC1+X9nDdEI4t5lPgRji4c5mk=;
        b=jevY59wEg6x7u0Essy+xeWFlHvBPukv0QCveJSL7lAD38XMEeaiufUwag1+7VZxCgw
         d4sfLkWev3kIs89LTc4+zGAPvkMX/rRGUsVFyr8IRe+XS8pGmk8PctffK6T776b3s2dH
         GE3dNb/6mX2taG/vGa8OjoNpOcJ9qt/tcVrXrndvvb2meIJJSP6SuFvxxzfQ2gacDzSP
         xh1w171Q4qab1qfZ9R+VgLgkWGpGju9eeqd2tmcz6crLW3lvVmOVxpn34Hro1dmNNqrX
         e7aXYNxisEYoSoy4NAc7yzSTznlgdoXW+3Vmh6CktbRyaH8rXzJQcemsWQXieR9ElIkU
         vZlA==
X-Forwarded-Encrypted: i=1; AJvYcCXxk7Bv9xzL7kR8qARVju/BMtwJD3Fbv1D9S63orFjUyGNcNMp+wodOkkKMa1HuCNjW0i5kEY7kaxeytjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxeRhSGbF0dJlvjkZY6HWbjZ28tMVoDnO9s/BxS6yOwD/19p1j
	oicLW9WjFWOognLN5XWb+sKbaxn6hYzmcrXPJ6bQj2CSBvxwVeL8drxdOzJFxTVvV343fKN9kLI
	gQI7EQ1hDFQ==
X-Google-Smtp-Source: AGHT+IFltfmQBS7U87C0TdDrtf1ntKrR6/OIw7n3Wyza61DuU6qTE108cX1iKXZNifSy30Gaf+LTVp5Ftm1u
X-Received: from pjqq12.prod.google.com ([2002:a17:90b:584c:b0:314:3438:8e79])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d40c:b0:313:d361:73d7
 with SMTP id 98e67ed59e1d1-31c3cf9aaffmr1475713a91.13.1752097237503; Wed, 09
 Jul 2025 14:40:37 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:19 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-3-irogers@google.com>
Subject: [PATCH v1 02/12] perf parse-events: Minor tidy up of event_type helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add missing breakpoint and raw types. Avoid a switch, just use a
lookup array. Switch the type to unsigned to avoid checking negative
values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 31 +++++++++++++------------------
 tools/perf/util/parse-events.h |  2 +-
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4cd64ffa4fcd..a59ae5ca0f89 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -135,26 +135,21 @@ const struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	},
 };
 
-const char *event_type(int type)
-{
-	switch (type) {
-	case PERF_TYPE_HARDWARE:
-		return "hardware";
-
-	case PERF_TYPE_SOFTWARE:
-		return "software";
-
-	case PERF_TYPE_TRACEPOINT:
-		return "tracepoint";
-
-	case PERF_TYPE_HW_CACHE:
-		return "hardware-cache";
+static const char *const event_types[] = {
+	[PERF_TYPE_HARDWARE]	= "hardware",
+	[PERF_TYPE_SOFTWARE]	= "software",
+	[PERF_TYPE_TRACEPOINT]	= "tracepoint",
+	[PERF_TYPE_HW_CACHE]	= "hardware-cache",
+	[PERF_TYPE_RAW]		= "raw",
+	[PERF_TYPE_BREAKPOINT]	= "breakpoint",
+};
 
-	default:
-		break;
-	}
+const char *event_type(size_t type)
+{
+	if (type >= PERF_TYPE_MAX)
+		return "unknown";
 
-	return "unknown";
+	return event_types[type];
 }
 
 static char *get_config_str(const struct parse_events_terms *head_terms,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 1c20ed0879aa..b47bf2810112 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -21,7 +21,7 @@ struct option;
 struct perf_pmu;
 struct strbuf;
 
-const char *event_type(int type);
+const char *event_type(size_t type);
 
 /* Arguments encoded in opt->value. */
 struct parse_events_option_args {
-- 
2.50.0.727.gbf7dc18ff4-goog


