Return-Path: <linux-kernel+bounces-746221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7ECB1244C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE49189776F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61517253B73;
	Fri, 25 Jul 2025 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nVL9MYlq"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4E252917
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469534; cv=none; b=C7j+F2jI47l/Vm3wlGfyvao7TpiycUoayh0ThfC5YYjAQLuZFPS7HPrhEej8ujKPMpFCMI6eKGHz9eFbt7Kpj6XlT23Li5VapymN6QMemMCTT43KU8VfUmyI27ygojHudrg10WaUInw/wOd79+kdZ/Bm6lK2OTB8MAMItOaUuok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469534; c=relaxed/simple;
	bh=x1oDUvRWtnxx2zf7jV9K/bE1vHUJygLj2ln3EI9Q0Jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rdRYt3M0OPjo188cFRNSFDx/g0EPCCrEvxfYnmIx/kTS7gLABCtWfAcBAH8X3beh7pDEyk+td5m63EL/2u+uvJFBfGRvHwDDVg8YuYulrtTkGkvtTwBZOHKsn75+ncWuaZIjcEmGu5mthYLP4bbiSiLofslzZvMyl0K/q1CPRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nVL9MYlq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2354ba59eb6so38066035ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469533; x=1754074333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vKrQy9jWlpHmx2H86IY6nleA9kDjYzDczHYTDNV4vRQ=;
        b=nVL9MYlqJi6xorZInpp/tVYZkEHHvIC76bgnoDOPbtliEGHUsvYONkGsSDPZRrkz0f
         KqaknYEku+9pTBlLYffzBmnLhwVdOICpWIUQ03wtDz02m4b0ywwaRHOzwHnkXLV7FlLI
         7CP1rOcH3qBkIko9NkR4kvVC31XZI9JP6eW19LhRI+Rcq3z6Ddz0wDHzEh3tw1LuUXrg
         jF0mRQdpFR7htzlpYMqWsUWEiUwYLPQjOr+i7dK1BLnTqfQIIp8YjN0T+VpT8h9HMq9X
         H4fxNytp0mRq8rTS+t406fAsxrsiNhm6SA6eaNntxq+mQEQj/WZBjW1/Zm4npQ9Nqo8G
         zWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469533; x=1754074333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKrQy9jWlpHmx2H86IY6nleA9kDjYzDczHYTDNV4vRQ=;
        b=ErfUmNxdcS6Gk3RqRMrxT0msURdgJF5KvMM5DbOnccSItraYoeuPqdAwYWk0dcVZG2
         eZxPan41bN2TUJL/L+qtoiqtv7Vn+nkRTo50K8U5RrP+rHFK9vMejb3Q5e/XqaOBRXr1
         ABj/oWpFHahNqYt8+gXKvYfS0Io1aad7I2reM3AxrDbG+sjnZLkzGb2ac8rLFODbajv6
         SEmW/W5YUrrI4p1htqDXoz9Jjr78nbA9R8hWAucHZVC6mpUR6CWKLsJhNeGfIeQAbooD
         Id9qN4/cmkvm6gQpzw/pgF3BR6DLh6fPQwZCsUisRs739eFTj0kpz+VDgJmZ7KCWsM7+
         nYXg==
X-Forwarded-Encrypted: i=1; AJvYcCWMY9GGpxdbErDDQQvoVZPKvNpxH0fNQIHhXzVDcGnII5CkL7heQTtIHqEZEsf7OJW+G/C8H7A955qWcs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxaMvZ0X2fE5V6PQEebIXbvWo5ieo4K5ILoh7ROVeAJU72PESp
	PClGDIIUlxFyM60XsOAiALnwSz0xvrkfZY9nDGTdB/HpoLbUSRrvbj0qwl2CVvHdNlXmA5pAQAs
	jyrw2UE0K5Q==
X-Google-Smtp-Source: AGHT+IGQ0CPUNqlhaiW8IDbXCE7+NjYhca9/C2ns6zlxUx4mQY8Djx0wiDfuNEGDwS2LlHAe8uJR+5CuVj6w
X-Received: from pjbsl3.prod.google.com ([2002:a17:90b:2e03:b0:312:1e70:e233])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:292:b0:234:f182:a754
 with SMTP id d9443c01a7336-23fb3118d1dmr47509925ad.47.1753469532754; Fri, 25
 Jul 2025 11:52:12 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:51:47 -0700
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725185202.68671-2-irogers@google.com>
Subject: [PATCH v9 01/16] perf python: Add more exceptions on error paths
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
2.50.1.552.g942d659e1b-goog


