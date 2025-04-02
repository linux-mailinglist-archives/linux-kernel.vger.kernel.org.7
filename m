Return-Path: <linux-kernel+bounces-585441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57747A79372
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 18:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6261889BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 16:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A61ADC98;
	Wed,  2 Apr 2025 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dE+dlHNT"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B571A3156
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612455; cv=none; b=XH03teiUXhjoHGKLp/AjSiJUa/GXB7wu/GXX+TL3UCSlJ7fxL67arLRyTHDrNFm9Sq2+M3moGaKOu2qQn9sSmgte2X/v6TS0yZRZQFUHBc/MxrKkxn4Kynn3NBmGqG2MICbZTIO3Vo9yWx4h8ZgweDH1jiFFDrhEFdU9XKDZkak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612455; c=relaxed/simple;
	bh=WStuIdPt8lRJg1FWf8KPFEILp1PnsGADoTb7+XPTPCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CYF6qFUt16WXf2NHy0mj6g/g5sOSBLAWDEwgFXONCog5jDQQcrctC4xasXaPazRbLguf7kugRiRHT8OtnQWkA0p2l6jBBsInxkeeAJ/snnJHDVd8v0qiu6LpE93zoIsZqFR13VNtz0L7GXDV5z6AJk+UaFw0LlBuFaf7GRWGnWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dE+dlHNT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224364f2492so421705ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743612453; x=1744217253; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tDmbLrtoU9NWl61/Y1ycLMfPN40NbRlPLTERdTcD4c=;
        b=dE+dlHNTq3YirW3NFy8clKeJAAOzOtUAdAhbtce5yzaZJTvgjX5G+u1xdKrO2jpK7S
         0/M5kPyQ9j9ghKkWLl9AnLV4vsR3Zku1iSZA+VpbtDtshEUnR6yaGaVo5KMMwr+uJeie
         SpGlWNfJLAv/PPeMZbu4sCqDAP2xW/Ch8vlApvsetWJANTrMZ1x63FhRD3E8EnWxVqOV
         QiYLzKW5pl2qLvvua07bwx4bUj1jvQio4aFi3oXxqxcjxg/wRXlU/XRKfgLKsqxigxG2
         xMB1aUrzqL8PkC50c0TaqvmLz0JsukIjgLTC3GkK/17na6ppGUr4gNjZkn3eQ4b05YMy
         GrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743612453; x=1744217253;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tDmbLrtoU9NWl61/Y1ycLMfPN40NbRlPLTERdTcD4c=;
        b=fvF5kdkBM1/Yl/pCiYH0MxwL2ZIrD+TFg/MuHVQN+ZGiKAEUMm4Ql3y/OZgVyYFpPI
         BBvSZIzIYW6Zl9qs80bizzwkkZeznP595XZ/DFoYV13ucY/3Jow2riRqehG5AKUwGG8o
         YNNGjATpIGIMOwmdsieZNgYZNdx7Pqp5OeEXE36Nb4FYZcGV1SMlanzec/ZBi/YCHOMf
         nW6r3jgUjoyR/2khkKsesNnjg5SnkMzTlQ3eM3IOpZElw5nlavnVZLWznHo6fPGFS6rt
         M8g6i7l0SuC5nBuksQlC6icvFT6+uaX6QmfcaUhmw4AV8bjWJTO+nPTQARaNxTDmkLb/
         VX5A==
X-Forwarded-Encrypted: i=1; AJvYcCUDM+NSUDQniI9C+q8vpRA2PyPENQT/O5t/EbNN7gnnvUxyp2AVWm5xZxlpm5NiaXXaYGBBnQpq3S47wiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/KVKo8ev4YlOg2kr+Y17j4JAE2VRQa4VpRAJ6ivy4BpC60Jg
	y4DxjEgzQoksX47lrh9sELY0hMrUJZLjfFPAKMVCUdjxbNYnB79+hgoBa0l5MjdKLgcMhTjTfVB
	HXt8pZQ==
X-Google-Smtp-Source: AGHT+IGIMigwhhEQhcpTdE67GN3lzf59G15dcpWYK309Deu8nT4TCreokRGg9L3IKZhgBwbjjUECr6htPw05
X-Received: from plsa4.prod.google.com ([2002:a17:902:b584:b0:223:432c:56d4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce81:b0:224:584:6eef
 with SMTP id d9443c01a7336-2292f9e8275mr302417375ad.41.1743612453276; Wed, 02
 Apr 2025 09:47:33 -0700 (PDT)
Date: Wed,  2 Apr 2025 09:47:19 -0700
In-Reply-To: <20250402164720.3847573-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402164720.3847573-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402164720.3847573-5-irogers@google.com>
Subject: [PATCH v2 4/5] perf evlist: Add groups to evlist__format_evsels
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make groups visible in output:

Before:
{cycles,instructions} ->
cpu_atom/cycles/,cpu_atom/instructions/,cpu_core/cycles/,cpu_core/instructions/

After:
{cycles,instructions} ->
{cpu_atom/cycles/,cpu_atom/instructions/},{cpu_core/cycles/,cpu_core/instructions/}

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ffb5be41a465..6ebe0795e1c9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2471,13 +2471,18 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 
 void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb, size_t max_length)
 {
-	struct evsel *evsel;
+	struct evsel *evsel, *leader = NULL;
 	bool first = true;
 
 	evlist__for_each_entry(evlist, evsel) {
+		struct evsel *new_leader = evsel__leader(evsel);
+
 		if (evsel__is_dummy_event(evsel))
 			continue;
 
+		if (leader != new_leader && leader && leader->core.nr_members > 1)
+			strbuf_addch(sb, '}');
+
 		if (!first)
 			strbuf_addch(sb, ',');
 
@@ -2485,9 +2490,15 @@ void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb, size_t max_
 			strbuf_addstr(sb, "...");
 			return;
 		}
+		if (leader != new_leader && new_leader->core.nr_members > 1)
+			strbuf_addch(sb, '{');
+
 		strbuf_addstr(sb, evsel__name(evsel));
 		first = false;
+		leader = new_leader;
 	}
+	if (leader && leader->core.nr_members > 1)
+		strbuf_addch(sb, '}');
 }
 
 void evlist__check_mem_load_aux(struct evlist *evlist)
-- 
2.49.0.504.g3bcea36a83-goog


