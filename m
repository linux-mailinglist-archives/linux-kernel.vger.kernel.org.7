Return-Path: <linux-kernel+bounces-780311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6FBB3004D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1346028D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894D22E1C6B;
	Thu, 21 Aug 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hNduSHfc"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798382E172B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794316; cv=none; b=k9WTaUzPXH23FTbgtP1Wl/UrNVxNFKw+34iVr6fCZEqoLKWLHDV5II7RyI87QkZxVlMwV+dTF+jdz6uZkeF4llr8st6fDo5RrfGh9TpLhU7leJe6Hjb5+6eU+xYBDsVdBF4UGJKylp40IY7IEDj3ourj2SDdY7Q4+Ro5g2SzndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794316; c=relaxed/simple;
	bh=/XHeoHniz2hBdtYofNudV0JeJY6QjauvRcJwRTYu2UE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VOA2zwikB2Xgk8kW+Or042Q08RnsmU/LVHv1sc3QmEJUFx03wEzMxxQBISt19ItFduwgE0CRrKpgNZaKwdKugonSUQbTmX4krZ3nZsazO+5b66BGNRWPHUCs3l/ugGeLaJvl7JdJUjt8Ev3d44mwLy6YgAzt/hYiEnPmus6JY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hNduSHfc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb47455so2394384b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755794315; x=1756399115; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7qhyTA0zygdF9hzKzi42ziwY4qouIjpoYn63u/5P6Y=;
        b=hNduSHfcpDFXohBpbRAecXoPxwbpSflX2EJpyIwQZSA8VCdT/hnc2n2Ly73mKmKQWF
         6PcU4s3SqPau0p9TeLLPixBWINb6cOj2BIvnTH4QJeE77/5539Gf4bHOEt50iZ2JrwWN
         /LvtRKKFi4jordhuYzdjI1NCCmHujEkkkHahYdYbpLQrgV4oFHspSvvL+KSInxo0b3YM
         sxMo2fe75jSRFqsEmKqwhO6tUwUY9+hGmT4IFeihayK/0Bul2t9O/KzEhRQTid/mQsDx
         QdPHcfYDwfIswxwkqPCsG+jFHNf2yyHRm0emMwpAqT3d7SmD+P/Z2qy43smlq9AnWQSa
         mJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794315; x=1756399115;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7qhyTA0zygdF9hzKzi42ziwY4qouIjpoYn63u/5P6Y=;
        b=L96GbvxW4U1han3ekKEFMtNrgAf4bGN5lskhdLPyfe/8JWnA0IZGv/xlbrV8MgaS7W
         iu7XZX4hsL92n8vWICL2FGXgJNQFHPfyzUZTeaWdVgcfW7lGt0Co1YlWJT9vS8WqmYRZ
         aNBhOGl/QXC8NdIWEkvQqJBXcpZ49VOzsVKRKTcXfYxcjOfcfDOVbJxUxRg3ehXmkcSk
         wZV2ms3SN0gxtgsj5briAAPpLQX9zcJC7T+/mLyIDn2rznvtzn10X8droIPASm6hQcuH
         gBS4qMZfEJBl+dpavO4VIh2YBS68EH2PLT0IKEcQIj7VjHcB3FOmgkTjA14gzHFZwRqt
         /Evg==
X-Forwarded-Encrypted: i=1; AJvYcCUBPVVCVGvBL5deQfg/99c7Iinyk8wLi0buof8qNe8l51/oNgC7z6Ebc2MEVotTQUzytVrjroF8hwjHYbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3i6BDUco1WGQTjf9gxUu82/3EPMNxOpMQUaN8+YfsrChX7jkK
	XXwIoueKQajp3VStYjDnLGdr38wf+7ycXFYkBP1y9HaYsKAAGKKcU8guWa/j2cMmhHHDFwy28OQ
	Se3ePRzOvcA==
X-Google-Smtp-Source: AGHT+IHIkd9mETHe77XFTQ371bKp8jF0bgpsL3CAoJoJulWTHQL0Nn0cdjJMp2YVLIScwYqmgUFadePBjTzM
X-Received: from pfbkx15.prod.google.com ([2002:a05:6a00:6f0f:b0:767:efa:8329])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b0f:b0:76e:8b0e:bfff
 with SMTP id d2e1a72fcca58-7702fa07addmr56400b3a.13.1755794314448; Thu, 21
 Aug 2025 09:38:34 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:38:17 -0700
In-Reply-To: <20250821163820.1132977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821163820.1132977-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821163820.1132977-4-irogers@google.com>
Subject: [PATCH v2 3/5] perf evsel: Avoid container_of on a NULL leader
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Blake Jones <blakejones@google.com>, James Clark <james.clark@linaro.org>, 
	Jan Polensky <japo@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

An evsel should typically have a leader of itself, however, in tests
like 'Sample parsing' a NULL leader may occur and the container_of
will return a corrupt pointer. Avoid this with an explicit NULL test.

Signed-off-by: Ian Rogers <irogers@google.com>
Fixes: fba7c86601e2 ("libperf: Move 'leader' from tools/perf to perf_evsel::leader")
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d264c143b592..496f42434327 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3935,6 +3935,8 @@ bool evsel__is_hybrid(const struct evsel *evsel)
 
 struct evsel *evsel__leader(const struct evsel *evsel)
 {
+	if (evsel->core.leader == NULL)
+		return NULL;
 	return container_of(evsel->core.leader, struct evsel, core);
 }
 
-- 
2.51.0.rc1.193.gad69d77794-goog


