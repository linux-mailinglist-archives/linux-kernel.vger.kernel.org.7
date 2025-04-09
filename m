Return-Path: <linux-kernel+bounces-595332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA6AA81CC8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 08:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061B7462CBA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 06:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390002116F2;
	Wed,  9 Apr 2025 06:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9HfJtMr"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39795210F4D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179084; cv=none; b=izxHnfIiEncObjh46yZkWY6qVmOMNz1kISZWW8NF9650wrNpAdIDgexi7eNmFUiaUNJhAvwDvSJlkxRnaBqmfjzCkF9fyEk6NFZ1koDc2Lmb9rXC6vECx4S31oTX+OsM5KrnlEa01pIr8n5FBiXEEK1l1y4JzGJ0w0x5u0TrQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179084; c=relaxed/simple;
	bh=4/dJlTWkcf5FOf5+oh0Up7fh8r5QO82sMonPjvpz42s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=b3echBuGrJOXNF1rz29wgF7+eCAWNBKuswGlCSPnb5WWhsR338vE6+GuSVtqh0gn04EyLjh9HVOo3lityaGXvvBTYEHZsRR2rXQRsrQBJSfR+j3DVmZQ99922ZuI6OA4qSKl1obb+b8S9XSbz2L0k17mGTrp1NfKzPW0HB6+wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9HfJtMr; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22403329f9eso53664155ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 23:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179083; x=1744783883; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtCRHQR2grinPcYBxNOrxZNvf1a5RF1zR0pJL1Q63Gw=;
        b=q9HfJtMrwhKKv9ml7ofKLvmRyApi2OlKDB9l2zT28ORtwuQIAQOjzQCg1F9jUCIEFb
         nc0Hw7QxmPZR0igWkfv1FpIkuuEx9DS4Wi6tpC4U+bJZ8UrO3yYkQbbPQOP6ItQKR+Ef
         VHFYSs2b7QMY0X8QShA9coggzbIfm8GuQvz+Du7nNq3ZpCHfAYnIxjXOZ/EW8AGU60zR
         WQZxteMH8CVk7vxDShjst1DImjVNwIOKGJl0cKdQRNkgROEPX2poi6LYXcrTztP2C3li
         7Hw96XgFteT55uR+i7OyWyIAK3LmK6uQ+I+xOpdpC2RfqjPMcID0vQb3J0y8UtBmUyZ2
         ybFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179083; x=1744783883;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtCRHQR2grinPcYBxNOrxZNvf1a5RF1zR0pJL1Q63Gw=;
        b=fC798AVsSYhDDZyTnTcTiU4myEkIMnaW8IpmWdg+ggE2cybnHbyUy3PeZwnXUriIPF
         VwjpbBFt0fWOKMW8QDrZBpvA9Lp9GkVD6CnJvpY2Bpbn3/BCsJjzf4LWOu9bReEuH5e+
         o3gfnQTv0sHe3WZ0yI7P3/s/+6HGyEKvbDbjkLRKm9WUWZ9x1Lh9SaLj9synTWsVoun1
         i2bB75zln+focEPFS8KIiRIJ+0hvs3KfoQrwl9um2HGGDEJKcoa7sIckstEcjVkFa+6a
         w4XMpYIEobXCaYHSiQW4UsER7Rwbn42dfiYiGDFhDZIthw2tWkvcq0GkrvNm0jv3kI/G
         5A1w==
X-Forwarded-Encrypted: i=1; AJvYcCV63zFdPaUvPBMDO57WgYiQiQMGOTf0kJ1EsZFHHqrdojDCnAwqkTY/3qKV2nr4NpjoCStILY0rCQQg83c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlYj+wCh8M9vGYarzjuvCzh4xiaun5pbzZ9rn4bWFrM0TbQUwH
	4zKkhosIn4bmUhNMUMBUl3pyhvT2cytwNwfl++7485tTfbfi1x2e9yWlgkl44pXnJHo7xeE6K/Y
	pmSSzQQ==
X-Google-Smtp-Source: AGHT+IHYk+LFNBBiynPtVNovcETcZCxDxx0BUOk/LDRrrAx60CkktUGsfjUsusDYp1BB/HyawJ4Su1hVXzId
X-Received: from plhn7.prod.google.com ([2002:a17:903:1107:b0:223:690d:fd84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c1:b0:224:1ec0:8a16
 with SMTP id d9443c01a7336-22ac29938f3mr25480675ad.21.1744179082762; Tue, 08
 Apr 2025 23:11:22 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:43 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-17-irogers@google.com>
Subject: [PATCH v4 16/16] perf record: Retirement latency cleanup in evsel__config
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Perf record will fail with retirement latency events as the open
doesn't do a perf_event_open system call. Use evsel__config to set up
such events for recording by removing the flag and enabling sample
weights - the sample weights containing the retirement latency.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 661a07cbdb25..6a84893e3c58 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1440,9 +1440,10 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		attr->branch_sample_type = opts->branch_stack;
 	}
 
-	if (opts->sample_weight)
+	if (opts->sample_weight || evsel->retire_lat) {
 		arch_evsel__set_sample_weight(evsel);
-
+		evsel->retire_lat = false;
+	}
 	attr->task     = track;
 	attr->mmap     = track;
 	attr->mmap2    = track && !perf_missing_features.mmap2;
-- 
2.49.0.504.g3bcea36a83-goog


