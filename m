Return-Path: <linux-kernel+bounces-743322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A87B0FD4B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792E11C86BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FF52550A3;
	Wed, 23 Jul 2025 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B//FDOYp"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CE3272E7C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312962; cv=none; b=beI4A6Aegpeu5bTDnvvUEM/AqQf1i8SehkdxyAE9enc9zDAV2R3o0Ap1epotwbrvyLh5NReYp02NN+KS1qGLOfcrcGS9n8ks9pXvgAWd6gVvT1p3+Gr59CnDNJZGR807Aobk8tplv7gX70PxaHYsPETo4LKYzPDe64Ju5EBf+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312962; c=relaxed/simple;
	bh=3Usi47lyrFc7iDjBhSmmHShAGxmn1mYkiehUSL8mUbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KJofh2rQwqhtLjEzZIxpi6lLdrT+YpvRSgX/KddODB2DJQts5AAw3cfaG/rSGzQ1sxSDnsLTgQ6X/H0BIfBBU8v9qmmWt3ruBjlvP9yLENxhjt1+c94VJ3mbPcMmQwF6iTI3t0FE5OQAldS0aZb1qbAiAZu/edDrnvYrQK0zQ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B//FDOYp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso649436a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753312960; x=1753917760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1sWxfNe34Mj6t3LasBAGDQyCtGclSZeWUJ5gZiRJafk=;
        b=B//FDOYpCkT9Dk2t67Fa6vWCBCqPfOEnw7TTebnLzl4d83ITVwcrCMBrnzpHlPaKQk
         D5eOepm6xE+0Yy9tNhl9+lI7u4sePzRArXDVOW3BrbsLiv02obZz0omVZ7mvhN1YSu11
         30857hjvRDM/5fTNjz1SkNDALtaf0caY7SthyhU5Yrrorex+M9Oh4ndv+ymAxHYTB8F1
         BFe+QJ6FW7wMiAN3O5S6bje5kPlrd/Q+aqsPXtQRhsfJUED02/ND+uHC5NqwLrI5xE7E
         MPVNvABn6V+fTvwwbvAoMMrSnchZFBcVOdqet1XXOg6LZCQniMYiSH2OMjQaEtae3YKY
         xkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753312960; x=1753917760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sWxfNe34Mj6t3LasBAGDQyCtGclSZeWUJ5gZiRJafk=;
        b=KgUpmKGHWSlnC2gCu+87DejQNBbRysJocK3lIpknYQBSUw59uYhN4lfFYFLCPUobXP
         XKq2vq7juoV+nC+ZBG+asLvJQ8kXhesM9bF6xf+50kGC9fIUuOzyjfpD/AO8gUnRdVAv
         sSD9FrqOQmHEpXsW2SPcHSxHq2sEb6W6fxHJppyEvGXGjluxQfvcPmjSnYu+DFCOgc6h
         yMbzdIxQttBJJv380MekpEukEkk1X3w8KbAfL30UTmopKEQlApvaY1jPJmZBsTf9PqkD
         g9qPwxJxRDly2orxXuw+rq6hK2RKHRZntuuIwUR/4xYjvbGaDFTmCxJlWOPNYE6dx/9h
         SHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxVvzoS2WLHIyebNZJlCTIYEpF4ekqLLxHiLJov/JEuanJ2fMg8VbVTjqaDO9PcIHgGiNgUo+KoAjmQ7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQsnQjLIk0Hf3PsAhMqDpsCNx8Thkcjd7c8JboMQhu5WWbPWgJ
	vHYDWebeFnBpdXuPK6ktyVsj6oZvivawMYsk6hnO3tH7RovFm2C86FfEUzcseqQaUY75b4X7Zz9
	YEIhAZW4khg==
X-Google-Smtp-Source: AGHT+IFWa0zKJu+AEViGjzLR3s2/1byxoKTTG4pnA24NhEV84SVs/Viqot4b6OxDZoOhF3OhrOpnC1ftLj5u
X-Received: from pgl12.prod.google.com ([2002:a63:b0c:0:b0:b2e:c3f7:2536])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e92:b0:21f:5324:340
 with SMTP id adf61e73a8af0-23d491f56femr7200323637.41.1753312960046; Wed, 23
 Jul 2025 16:22:40 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:02 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-2-irogers@google.com>
Subject: [PATCH v8 01/16] perf python: Add more exceptions on error paths
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Returning NULL will cause the python interpreter to fail but not
report an error. If none wants to be returned then Py_None needs
returning. Set the error for the cases returning NULL so that more
meaningful interpreter behavior is had.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2f28f71325a8..3affde0ad15a 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -475,13 +475,19 @@ static PyObject *pyrf_event__new(const union perf_event *event)
 	if ((event->header.type < PERF_RECORD_MMAP ||
 	     event->header.type > PERF_RECORD_SAMPLE) &&
 	    !(event->header.type == PERF_RECORD_SWITCH ||
-	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE))
+	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)) {
+		PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
+			     event->header.type);
 		return NULL;
+	}
 
 	// FIXME this better be dynamic or we need to parse everything
 	// before calling perf_mmap__consume(), including tracepoint fields.
-	if (sizeof(pevent->event) < event->header.size)
+	if (sizeof(pevent->event) < event->header.size) {
+		PyErr_Format(PyExc_TypeError, "Unexpected event size: %zd < %u",
+			     sizeof(pevent->event), event->header.size);
 		return NULL;
+	}
 
 	ptype = pyrf_event__type[event->header.type];
 	pevent = PyObject_New(struct pyrf_event, ptype);
@@ -1199,8 +1205,10 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		return NULL;
 
 	md = get_md(evlist, cpu);
-	if (!md)
+	if (!md) {
+		PyErr_Format(PyExc_TypeError, "Unknown CPU '%d'", cpu);
 		return NULL;
+	}
 
 	if (perf_mmap__read_init(&md->core) < 0)
 		goto end;
-- 
2.50.0.727.gbf7dc18ff4-goog


