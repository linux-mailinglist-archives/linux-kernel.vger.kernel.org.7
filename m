Return-Path: <linux-kernel+bounces-726665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4B9B00FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78372565D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0F309DB7;
	Thu, 10 Jul 2025 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpQ1TdXL"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5005F309DB4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191532; cv=none; b=C+aTJimIq3qrV0T1SwS7JzCLilC4mvUSGl9tibmcXbxBIzQsJkJi/3HtXCqgno95Cg9x/55esbfflds9ujNkyA0mKwuRp5R1n5pGfUbGKnFojeJzktQ0gEG9EAXAs2yDFEuWgblytVRCrAByaLkrqdqXsZVm0myE9TmgiYJHqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191532; c=relaxed/simple;
	bh=S3yRMHiJp63Z3sa35dQZZnYodURgDAIos+timRoWgfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fx++2iSnapMm9xb3LI+gcK26kR5QvRg//qhcIZmlri9byGC5iHA/SHgI6eu/oNFikUZEbOC6fSeVKkh8QEfiBS0NqKx3lJWIOXiLAl5i0y0EXoPnZ4vBwKtckedatSvlOsUt5LlWcy90IMiQkOU25DkuOWPV+JZpBPS8YlfpwtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpQ1TdXL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313fb0ec33bso1471516a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191531; x=1752796331; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ah0+wkOLh0SfnYMJxPVvQJg73AT2FFx/KryIhqiVcI4=;
        b=bpQ1TdXLCaa9bK0DJrk04lk8HBZBjA2/mcWf3m07VL05NqjNoEPq4rKRa8+x7jObIk
         ItHQtcWJbc6RIahOUVOYiNn8lpwZkJXDH3uR97Rr3I7+e6fket0jvut0GeZvnjr5Jbo/
         X3S3B2g7OdWTVmclNJ9zg8pNvTII0KQre6qLY/7XhjhygoKBXFWcL1mWg8eDhuxnBwJH
         OIQB2Tq5pEZzLW1JvkcdsvYf8oxPNr6yw2APBdLoB+IxfKWd/2o+IcWzqbie/puFjOq2
         ZLfIlM8Osz0N6Sk679SS14XSJisyMY3I+qHmJRW7uk9CQ/yhRwmq7p1XkMlZqXFQPM7+
         eKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191531; x=1752796331;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah0+wkOLh0SfnYMJxPVvQJg73AT2FFx/KryIhqiVcI4=;
        b=B4q0APqpBAZbG0vQ0XBtg2ewtewmMuJqsrC/UmdxS4U35nZwzdyFkRNlQJH/STYc51
         qZttJOpPuVYuYDv1Y5m4Ai63+P6d3L/EGjO961vOCnT+ZtZfCFCaaEoSVP9oJbPVn0Dr
         af4jVMG9M+ggzcbJ2pXl0IUHVtGyoUhQQYZCxJ+bsI7xRes4ZsoUStpXL/drNQSmpzi9
         ufVq9pStzJv9nM1/7mNSwcjFpjsweRFF3JS9KomRxn7IGYqmwFI2wirv2TCVQ9VD8u5m
         4LrBupIvIflEHfpvUjx2EjgwtrMop2Zv+FLj9bqQN9LApdzVPyxgVFlVBH545jYzayt+
         O9jA==
X-Forwarded-Encrypted: i=1; AJvYcCXh5erPa+3Gbi2yt6Nupz0BpUHQrzYcSnTZAR8/UBiIjjMBF7MxV/xjo34ya9Cwd1ncGWVvDtwAen05F5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRVX4q4XSGwtxPOJrz0FhpewPQpZXDbYAr3nQ38yO1MVyf2rWz
	0Hqio0WDzAANGTsASu+7CvqZCcXHmb8sy0U0t2zfilS7K1uzV0ree8/N0nMPk/LUsSohjfJk121
	Ty+9ickPCrA==
X-Google-Smtp-Source: AGHT+IHuXYQqG8mUduYyNsVRYiw4AnUaYNbBCA0c5zjyQheARQpeOx7R6/xtZBMi4TILoaAcAku0wTI+Ked+
X-Received: from pjbsq16.prod.google.com ([2002:a17:90b:5310:b0:313:221f:6571])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3844:b0:311:df4b:4b93
 with SMTP id 98e67ed59e1d1-31c4cc9c984mr1813908a91.7.1752191530631; Thu, 10
 Jul 2025 16:52:10 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:22 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-10-irogers@google.com>
Subject: [PATCH v2 09/13] perf python: In str(evsel) use the evsel__pmu_name helper
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

The evsel__pmu_name helper will internally use evsel__find_pmu that
handles legacy events, extended types, etc. in determining a PMU and
will provide a better value than just trying to access the PMU's name
directly as the PMU may not have been computed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b5ee9f7a4662..0821205b1aaa 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -925,10 +925,7 @@ static PyObject *pyrf_evsel__str(PyObject *self)
 	struct pyrf_evsel *pevsel = (void *)self;
 	struct evsel *evsel = &pevsel->evsel;
 
-	if (!evsel->pmu)
-		return PyUnicode_FromFormat("evsel(%s)", evsel__name(evsel));
-
-	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel->pmu->name, evsel__name(evsel));
+	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel__pmu_name(evsel), evsel__name(evsel));
 }
 
 static PyMethodDef pyrf_evsel__methods[] = {
-- 
2.50.0.727.gbf7dc18ff4-goog


