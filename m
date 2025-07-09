Return-Path: <linux-kernel+bounces-724538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD47BAFF40C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DB14E13F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65868262FEC;
	Wed,  9 Jul 2025 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JB+lxBE+"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE1725DB0B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097256; cv=none; b=SI8/qaroQjKQdKaQWOOejYuSFHTwvG5RJ3fFikrEdK6yMJJ3NucHQog4Ti+Hzfdv2Hmw7WEyd9tBykylXrNnshiVmWLTZktYd3VhVit6wSbMAHvsLXT3BgUyHz/KdyGh2rgyHq9OTwduz0CciR1Qdgeh/IDnwrC4gh+z/MAXAOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097256; c=relaxed/simple;
	bh=vOwZDvr9Vl8FEdFAuVf8wVoxDa4D0UfmaiOanE6AyxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ToFSCeATDI2wLpmwXJGPcIwecIT8Q7c64klh7jtMEYw/YsRlspw0PmIhw26v0e/LSQ5HkLMOQBDksV52qnlA4fL4teRRWuX8m4L9f+SCGGorO15l0zdT1RRhONAXrNyrLgGXsnar6stgKbgh2zbF+OmB9p0P8cOc5Bn8sQGsWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JB+lxBE+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31c38d4063so217074a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097255; x=1752702055; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9BHuR06NtQbT/Ectw1+ZMQbL3vfn86FK+37sdptByE=;
        b=JB+lxBE+QAjc9IcWC4+sFfYgrhR2/aNgWL3GIBL4nGni824czDlDqcbDp9+5766wZy
         xd4XaOaefbDNw4IvagVuNEhebBe/jiyxFK7kSu9epAh87LHR/1cYXf4o4JejtQzDyteZ
         eM+PdGE7ruquAtg6kS1Ji+9IcD+UjHqKf06gvbQD3ZdQLGQznKQzpQXVXdvY8gD6Nk9r
         jaKKqTsGz6isqaC7CWvQKpoBoBWxOmwlMbzDB7KUMzW3hP/Yjha6b2Do5qh+4y8p5Q41
         abR5lf7TGDlnbA+218rnMjOWabUyb3HoBC0HM1GAxQWjdeVC9S1nYCDMj0L1bTdGkUvk
         gHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097255; x=1752702055;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9BHuR06NtQbT/Ectw1+ZMQbL3vfn86FK+37sdptByE=;
        b=p2t3RILLt+my2rsYebXiAbgbQ0+QjMlkcfmWhiRiFAaH1wcHF6JKen9HvTR6YSyew6
         SuKXNS+UNTr+AC5Ln++zCMC1Zpm/se1ZGmHhLZIwjYZoS+LPbUJDXWHqueq6eN1anB3V
         0gnf3OEwib52JvYk6pkMqyR67KiWjWqreWVvBdQ5sUIEj8zhHkFDDnSI/HZ8b/VFcnZI
         R1/vUDVoQPAywqD/0pYApNdoqepjDEwain0KNb6ojW127DF6FmaZO4y+Ygj6ijqeLTra
         l2tVt8bVmJNfyEbGYmfBrjKgADHHsH+sC+jBsC1cY3ekkCZBrd9rA5J82GiqQ5SO6/Gu
         zTrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPsyD7o7HPHg3y+1NyV8onXQFFzrekuaUEtO9zndBosfmM5aTXUpFPYXqTJbISPbbZz4zBnA8Op0fiESs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuWad7mFasDVyoyZKBdmy95KfYAyZlP4hPEDL7HTmVRT1yj5D9
	kBIWqJrrpBnKkw1FUDMVFX86sXbOU9UC8s7kzjOY86bhsYoL2MENSjBQIA/Uv7Fv5ugKx28ISYX
	mO0AD0celyQ==
X-Google-Smtp-Source: AGHT+IET4wDIl8RWHQ92JBgsF3e1FcY+s+Ox/E3fRRO5h6tw2hx4TVcghr6OXM4+cGpdN8tZCfY3Osn5sSmw
X-Received: from pjbqd13.prod.google.com ([2002:a17:90b:3ccd:b0:312:26c4:236])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3512:b0:311:c1ec:7d0a
 with SMTP id 98e67ed59e1d1-31c3f03f810mr234327a91.25.1752097254579; Wed, 09
 Jul 2025 14:40:54 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:27 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-11-irogers@google.com>
Subject: [PATCH v1 10/12] perf python: Fix thread check in pyrf_evsel__read
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

The CPU index is incorrectly checked rather than the thread index.

Fixes: 739621f65702 ("perf python: Add evsel read method")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0821205b1aaa..4a3c2b4dd79f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -910,7 +910,7 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 		return NULL;
 	}
 	thread_idx = perf_thread_map__idx(evsel->core.threads, thread);
-	if (cpu_idx < 0) {
+	if (thread_idx < 0) {
 		PyErr_Format(PyExc_TypeError, "Thread %d is not part of evsel's threads",
 			     thread);
 		return NULL;
-- 
2.50.0.727.gbf7dc18ff4-goog


