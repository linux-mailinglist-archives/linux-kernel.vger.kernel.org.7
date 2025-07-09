Return-Path: <linux-kernel+bounces-724540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747C4AFF40E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA5B640F85
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D841A267732;
	Wed,  9 Jul 2025 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yixeryP8"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BC6265284
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097261; cv=none; b=CrS7LhG0/xcjXeIZ+8mzmStyg8+GOHQ6lE8esx+D4zTp+itZQ93Dz+sPCYGjbi7HYjrHI2bZhIpOor9nMzvWHiVMWQjXz8ttdB4/fGfppdwjbkaSx+r8vFbbl5wlDABtMHf/UnKXyBvI84iqZ3pJfFFmO4JXGI9tt2Hc1besOsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097261; c=relaxed/simple;
	bh=taguiAu+XCAIQfq0Yy35oTrHyGgNZ8BMVFBK/i0b2/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VP6Qn4jDn47I1BqAn9zFyxnPKZ3yZduxi1XA3JIsDBR/XEmaKd82KKVhiB1UPibpBRkd6wzm5x/UD0bncbyEL4u7WPFkFkggZczdDS51a+9IQ5RN6B6j9VXeXyB8llOrBbY+aOD9SA9loiWw1ejrJA6YjgDSe6C9XesRrZq9tdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yixeryP8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b34abbcdcf3so233489a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097258; x=1752702058; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yn07du8/mYddRoeb96O+tFsLyXiFjIJK2Jw/FgUbdtQ=;
        b=yixeryP8KEElgnO/5DnaiqjdeQtzhRymHgTjENkdbpBZzNGkBimW1/iNNZEeJFbsoR
         LRICQT4YK36+rEuFFQtkhzsfI1pk1/jsmCLZbaw+e1WVj/YkXLARynsJjNVJZGKbDrHc
         mQzVuH42MwFUZ8ANUXfBNXYdiLOOkRJeOTQqJJzB6h9Tak0PvKjoWkS6tnwau/O3d7A1
         /2cFfgYMelORqntP2R6w1xeWb1Ea4zXh/mTWqDfKX1tfre5WDIP3LUFtdmOgWMN7qka3
         uEzlbVVIM8NHKvXtwMlm7fDbKUlsPY8L2ipojzedlSqGUrZkrohCBZUdW7js23w3qF9M
         +tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097258; x=1752702058;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yn07du8/mYddRoeb96O+tFsLyXiFjIJK2Jw/FgUbdtQ=;
        b=iANmZPqLhvZNyikjXa+hOOxk2zSpQCeRbqpVoZs75YlxcXeL7UnhYXSihGGC6MFahO
         kdAHqTb/VCRwXRTM4fIJEPkc519TLUXjEMNuOyxShem8yTh3pqLXeMfoRolwhmJBSUEW
         It9ZRWu6mw4QLzIjsYWJwEBa5gKbQXx99i2oPLujE60Z6V4YY0Ja0HSdgZoPs5RGydYX
         Jh4QCQ/KkJbB5kK0N9H/cBTpjlg1C9vyxstlAeeHkXuCs4JUSkXedL9BBkgZT8MT7VXJ
         NSx8pLFJdPJNQ6+pxr4QYF8lWGOElA8yfcuZfOQLX4yL02YyLhJwFr87zVFnyPPF5/L9
         wHyg==
X-Forwarded-Encrypted: i=1; AJvYcCVsEGXj/T4LVRUxsvXKds22Z/vsmkS5Zr6BN3ZgvFdxspCuXrefMN4Qvx6As8O6We24/vOo0G5gh0YR4MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywof0PvjUVlmCw0/s9Iiil6U+xTYY2vCkbcHhq8JFgFvKf0DO6C
	HJ5AM/0xzhopfslytZi/rQZtMyTt/jmHnqaYXkLHusmv0xzhIwshSQG+QVlcHfyyK8tjdannerb
	1bUxwt1C0SA==
X-Google-Smtp-Source: AGHT+IFpZES2b6ONLtzlMFYm7NFl1lVqMzCjtuWVqhSi7IKE8r7O3xr8e2sxXbNipHUDbPKriS5aVIZ1HZ5Y
X-Received: from pjbsw6.prod.google.com ([2002:a17:90b:2c86:b0:313:245:8921])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:568e:b0:2ee:d371:3227
 with SMTP id 98e67ed59e1d1-31c2fdba404mr8152456a91.17.1752097258649; Wed, 09
 Jul 2025 14:40:58 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:29 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-13-irogers@google.com>
Subject: [PATCH v1 12/12] perf python: Improve leader copying from evlist
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

The struct pyrf_evlist embeds the evlist requiring the copying from
things like parsed events. The copying logic handles the leader being
the event itself, but if the leader group event is a different in the
list it will cause an evsel to point to the evsel in the list that was
copied from which is bad. Fix this by adding another pass over the
evlist rewriting leaders, simplified by the introductin of two evlist
helpers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f689560192f4..ad2437d132f3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1568,6 +1568,32 @@ static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
 	return (PyObject *)pevsel;
 }
 
+static int evlist__leader_pos(struct evlist *evlist, struct evsel *leader)
+{
+	struct evsel *pos;
+	int idx = 0;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (leader == evsel__leader(pos))
+			return idx;
+		idx++;
+	}
+	return -1;
+}
+
+static struct evsel *evlist__at(struct evlist *evlist, int idx)
+{
+	struct evsel *pos;
+	int idx2 = 0;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (idx == idx2)
+			return pos;
+		idx++;
+	}
+	return NULL;
+}
+
 static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
 {
 	struct pyrf_evlist *pevlist = PyObject_New(struct pyrf_evlist, &pyrf_evlist__type);
@@ -1583,6 +1609,13 @@ static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
 
 		evlist__add(&pevlist->evlist, &pevsel->evsel);
 	}
+	evlist__for_each_entry(&pevlist->evlist, pos) {
+		struct evsel *leader = evsel__leader(pos);
+		int idx = evlist__leader_pos(evlist, leader);
+
+		if (idx >= 0)
+			evsel__set_leader(pos, evlist__at(&pevlist->evlist, idx));
+	}
 	metricgroup__copy_metric_events(&pevlist->evlist, /*cgrp=*/NULL,
 					&pevlist->evlist.metric_events,
 					&evlist->metric_events);
-- 
2.50.0.727.gbf7dc18ff4-goog


