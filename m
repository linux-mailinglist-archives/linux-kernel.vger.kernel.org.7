Return-Path: <linux-kernel+bounces-726668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FD9B00FED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F90E645002
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29418315500;
	Thu, 10 Jul 2025 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvbv/yun"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAF30E833
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191541; cv=none; b=JPXPBe2yExVBuoqpbbXss0aSwKa4VHFLxlGFFAouGun+mWcK6r7s4bGZ+Lwz8YYSH6vCCiQ5W9yEDJ7l9Mrwj6gA/KLMNrmu7eMCQXqpzCJ20BieldpHlqOBIlfvUzrbAEyEtl7cWDcX05M002tnZ+ajwbH6FJ40NhtmUb+S1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191541; c=relaxed/simple;
	bh=5zleGua1Zw/ZaEwM7EA6L7ilWgpRL02HZYzo8k822ac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jzmnse0/YAZ/YF0lbDs9MC+uJnXT9D7FChmIOJ7H05jwoglYiLUGzxXC01DvSQ3K7MsaxAONO0Df1+pKY9coib79d4y0ZyTuzcoLiKgSwZDGP8JH5CsSCOGcMXSvJWUdM80H7fmy9SNRyTbI8SsYndC57tB8+twEziFuRpBsyIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvbv/yun; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso2177754a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191539; x=1752796339; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqFyL3Z59+3lc3ZxktOSwyrKwJmku2CJiAkRKO+qTP0=;
        b=dvbv/yunjigfYqhzfmnCndg2YP3+son+gV+3tRWIxEIhhQD6rjVPDS2VI83qhx0wk+
         pl+0o1dd8WPSQJ310wx6m/iuNAY8kUQAXEuOImTtloP5Jm0eFMpSeDPlklvXxHkdzVKs
         lhbQbvJ80wYNF0nu0TgQPXwdR6Mp8YX6T2Ns1MLsEAiX6qv7SZR64aNpWkb2nXc3GqBo
         DoG6gPMmpAotJ8CvKCc4SnINHN+x88oCzPJu0BexD2GOzJ/V1DtLpxDtmLh0HDLCQszH
         FZLXE4KhXoBjHvbvdE/0UtsV5O/HGu+Tlko4iA9Nl+MshXoqCyV+9LZyTIek9hzJtF6Y
         8cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191539; x=1752796339;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqFyL3Z59+3lc3ZxktOSwyrKwJmku2CJiAkRKO+qTP0=;
        b=kUc451qMuv8H4Q8Vn4pLgIBkJzFm9AoefOtzGJ+LMr6LCTYBpR20IapvUozm1NECcX
         VPybi98QUhuKhUeBU6f8c/oJBIFbmiOCPzaAUPdjK3YlSa0rEa0a/sB9yhM5vercQ4AC
         vs3dzoxksGMICiAPxLtvX7FwJUz23Bvg1I+cv0ffZ8JAJHGPp7FKOxEO+eRqj8g4YE0G
         D/ffXdooWbWPxNo8KH1aiegXGK509QnBJAnLd41qWUyrcoLPz3CbS8zai8II0tCV4enI
         PQ/v1X7V1RJuTK8PcaokjSheMw2v6+RFwPserUgZFYhKFJmxRG1JHkyPNfbPMWxzh7K4
         qg6w==
X-Forwarded-Encrypted: i=1; AJvYcCXl6C5SGMEoSeuejXQ74REbIhYIASiGCS+wjEJ57rnAcvPanUfKxafk9r3dP7B7RowQ9GL1idP2B2kuooE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjwlfDC8fXlOssN+wosecwQ8ohtqK+2qvCFNsXrPinmy1a2pE2
	PeX6taQj61YCXtVrkTrL0IYhjFXovwWWS0ig0lhalU/CDFG6iLGwCL5/NohmXQeIbKeKdiwtr56
	Oe9CTNWnIQg==
X-Google-Smtp-Source: AGHT+IGh/C/5InyJG63p8fKWBtjZwpODL6P7kzvpQrT88GcQmbobXyDzMu/1DHri/G4w4+OvP8s17U8z5mwx
X-Received: from pjtu14.prod.google.com ([2002:a17:90a:c88e:b0:2fa:1803:2f9f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5444:b0:311:fde5:c4b6
 with SMTP id 98e67ed59e1d1-31c4ca64d1dmr1855436a91.6.1752191539105; Thu, 10
 Jul 2025 16:52:19 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:25 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-13-irogers@google.com>
Subject: [PATCH v2 12/13] perf python: Improve leader copying from evlist
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
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
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
 tools/perf/util/python.c | 57 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f689560192f4..1d9fa33d377a 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1568,10 +1568,37 @@ static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
 	return (PyObject *)pevsel;
 }
 
+static int evlist__pos(struct evlist *evlist, struct evsel *evsel)
+{
+	struct evsel *pos;
+	int idx = 0;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (evsel == pos)
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
+		idx2++;
+	}
+	return NULL;
+}
+
 static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
 {
 	struct pyrf_evlist *pevlist = PyObject_New(struct pyrf_evlist, &pyrf_evlist__type);
 	struct evsel *pos;
+	struct rb_node *node;
 
 	if (!pevlist)
 		return NULL;
@@ -1583,9 +1610,39 @@ static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
 
 		evlist__add(&pevlist->evlist, &pevsel->evsel);
 	}
+	evlist__for_each_entry(&pevlist->evlist, pos) {
+		struct evsel *leader = evsel__leader(pos);
+
+		if (pos != leader) {
+			int idx = evlist__pos(evlist, leader);
+
+			if (idx >= 0)
+				evsel__set_leader(pos, evlist__at(&pevlist->evlist, idx));
+			else if (leader == NULL)
+				evsel__set_leader(pos, pos);
+		}
+	}
 	metricgroup__copy_metric_events(&pevlist->evlist, /*cgrp=*/NULL,
 					&pevlist->evlist.metric_events,
 					&evlist->metric_events);
+	for (node = rb_first_cached(&pevlist->evlist.metric_events.entries); node;
+	     node = rb_next(node)) {
+		struct metric_event *me = container_of(node, struct metric_event, nd);
+		struct list_head *mpos;
+		int idx = evlist__pos(evlist, me->evsel);
+
+		if (idx >= 0)
+			me->evsel = evlist__at(&pevlist->evlist, idx);
+		list_for_each(mpos, &me->head) {
+			struct metric_expr *e = container_of(mpos, struct metric_expr, nd);
+
+			for (int j = 0; e->metric_events[j]; j++) {
+				idx = evlist__pos(evlist, e->metric_events[j]);
+				if (idx >= 0)
+					e->metric_events[j] = evlist__at(&pevlist->evlist, idx);
+			}
+		}
+	}
 	return (PyObject *)pevlist;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


