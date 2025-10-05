Return-Path: <linux-kernel+bounces-842413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499F9BB9B05
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5721895D43
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E672BD5BC;
	Sun,  5 Oct 2025 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQf5RxTW"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35829E114
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688720; cv=none; b=SGmU6y7Rqb+lWxGMP3K02XbvvuztXGiWwxQLVOBDWQ7rzcngXB6sexgibllwrTB44hCDj2Nxnyte1ywH8cYrVk9rMgWkTLoKYK59NDugH7fb9ESSu/DFuv7Ufa2vE6cbAGojtLDptrWQeZyz8JzpSwe4R3lJB/47+tExY8O/PoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688720; c=relaxed/simple;
	bh=SEzAsSMoNsTTgZvnVHYt1VizCcHn2xa9s9a+H5Ek3tE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NSKwHdjEnIxxxsphiJnJ4T5q5SqwE3XC/ngsU65Y727VSLV0kI/WHgCF1x5SB3c3qf2ilk5xT4hFHXQGoX4OePjXFteXzsWjQ/XJhSajPzgUmoCWzAXP8D+hpf6pcDIx+8hFfFHoJd5+RjkoD90ascLx/BnIwQtcuIOTQqo6ZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQf5RxTW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-335276a711cso4144939a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688718; x=1760293518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1sEyHn6hnyRLAXWdXc6uX+CUu0Ko58Z/kC+AsHj6Ww=;
        b=pQf5RxTWSojrJdT2kGzpQtOTkTOm2NUQBRNY76xIJYNtt1Lu+5MI9fGsHdsv2apLfS
         qwgPMLAzC8CbJSaW1KMw5hQkIUWcRxQ07dxBb6kPMPQZ2lEL9VtvWjlXTMJdqVbK9D4U
         rlpho86FlY2JlzL0t7Y0pEOjC96uyMBwNG+4UIsdWEtsQKiNYk20z3KZhRRTQy4i0Bxj
         85JtblP9vU8DB3yPSDOmzoHM6uI8cFJQpy1y8Bh80i25lteIbC5n3DRoSC/RsF9JJVBc
         0X/K51aT/hKZSaO1m57m4+eRkX2gmLpPZtscDlHRSd0sWsmWw3ukylnx1emmA8GiyZJj
         UxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688718; x=1760293518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1sEyHn6hnyRLAXWdXc6uX+CUu0Ko58Z/kC+AsHj6Ww=;
        b=amjKeNA1qUDPXs6LZP/mcthjgStjpYyWfNpAR4gRsRWxkd/yNb+XuofZVDoqgygzYu
         a2T9zuwvUe75XDQMcdCebae4zmZMPt494AjrRQqyUfFdRTFXQvnGoh3u7ZKplCGT5eaR
         VKJT+6XU2zy1a5uGajS2V+tA2a6WT7JVftFntrrh88O3wLmYU0xoM1R03gbHacdJG2rI
         88zWbiGd7p0XsOBQPHcEaQ7PWME32L8Gg/Ck9K6iWw+RhIVAfzJVA0js9tZE8lf/OlqK
         CjRUo5jZecXDjSEoFHrN+Dep+BOi2I/NGown1OMMq46tiKv+nDYnkWH8PzNPlEjbor6n
         WQmw==
X-Forwarded-Encrypted: i=1; AJvYcCX4utnB+k2rts4QSe3ypGDDJ7zOKDk2w3XObk+38/Y48vztjiE/R3mpjbg3qUWkLKOr3yXnwEtb4QqAD2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLxc+A3Tgq/0C8iS/UW4AcfZgYL0fBnBiQ73cmJXlMttTc+oft
	lgNS7T2x4c4vDFtsaXk2eHRL/xVCzeiE+y9MAWuQRjcY8lj9NWkZ02HGjuJt9tVtBKO7BfoT+E5
	1jPZAjN84Bw==
X-Google-Smtp-Source: AGHT+IEJqSApSHd1BhmFoZKe2640Ivz+C2UbgeEfegtwFFBeBPC1PG9Tw96g0Q/q521daG/+L6gEoibM/mJ3
X-Received: from pjbnl7.prod.google.com ([2002:a17:90b:3847:b0:332:8246:26ae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac4:b0:32b:dfdb:b27f
 with SMTP id 98e67ed59e1d1-339c2797420mr12552222a91.17.1759688717803; Sun, 05
 Oct 2025 11:25:17 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:23 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-21-irogers@google.com>
Subject: [PATCH v7 20/27] perf evsel: Improvements to __evsel__match
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure both the perf_event_attr and alternate_hw_config are checked in
the match. Don't mask the config if the perf_event_attr isn't a
HARDWARE or HW_CACHE event. Add common early exit cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 56ebefd075f2..ad11cbfcbff1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1940,16 +1940,19 @@ bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
 	u32 e_type = evsel->core.attr.type;
 	u64 e_config = evsel->core.attr.config;
 
-	if (e_type != type) {
-		return type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
-			evsel->alternate_hw_config == config;
-	}
-
-	if ((type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) &&
-	    perf_pmus__supports_extended_type())
+	if (e_type == type && e_config == config)
+		return true;
+	if (type != PERF_TYPE_HARDWARE && type != PERF_TYPE_HW_CACHE)
+		return false;
+	if ((e_type == PERF_TYPE_HARDWARE || e_type == PERF_TYPE_HW_CACHE) &&
+		perf_pmus__supports_extended_type())
 		e_config &= PERF_HW_EVENT_MASK;
-
-	return e_config == config;
+	if (e_type == type && e_config == config)
+		return true;
+	if (type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
+	    evsel->alternate_hw_config == config)
+		return true;
+	return false;
 }
 
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
-- 
2.51.0.618.g983fd99d29-goog


