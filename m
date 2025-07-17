Return-Path: <linux-kernel+bounces-735501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2397B09035
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 176F57B9561
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5805A2F8C4E;
	Thu, 17 Jul 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBrG9y6l"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0702F85F5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764950; cv=none; b=kAYF6oOe93oNr3DB7ZxOecffZev5QRDxK9NOA9ZEkNcH8gLYdqSu0tUyZ/v4/VIHNeY3LrvM93acHOZs7VMFfhbQcRlMr9ctwbnj6WgGdk1KO3XHJgQqfBDtFKJlozOE46zCTLyHiu2jyiXM7RCfx4x8rYJA6XWYrJPsKKBdQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764950; c=relaxed/simple;
	bh=e2N7oTY2cgHu2RKJ+FKHz780v8w7gc4fcXnxguLDIU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eKpTBIDtJ4kAFxPi8x6+ussO/NJXBzve/lqjCdvCrX7/F5wna1a8D+C/FJSuv791JwpMy+WS8fV1k5yR28bY9V969iWzJaGIi47mWZd7Fh0m3eXXc4gy/kO9fJV7Q8XiH+GihzveHu5GDW71BfgkcGhRAEkaHlkkI+GFHWRI6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBrG9y6l; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b38fc4d8dbaso1167466a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752764949; x=1753369749; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcRx1AnfVIz4234lB8ggVFO+piASilvu9GQSG89S72I=;
        b=UBrG9y6lYnAedbQ3p/oTigAY9QrKH2HvNL0gGipfOor6eZ7RCPfsoZNff1WYsoMPrl
         UP/nSW2ijLnOrq/b81OkOPUNmNBfkWQeYxnBX9qnyEcsd438kIlgDF33vQzPAFQ2Fqqt
         VmVGIjpksyFUcmGKu7TRrcnyWut8qFUBEDXPPcWHMNlKof7xwJIKk3jjuVNiGhYiT0Ot
         9D6I0eHVvvz/fmK00xOodsgd8717IzPL6fa3tkQScoGwEcEZ4S6zplm3P3s2K6yIMTB5
         48CKD7kEP43ZIZVxjCjxFox4f5psYCrQ0jDqY1U9LbS1Zl+ba/sxZWPzhTx415GZq0wF
         u0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764949; x=1753369749;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcRx1AnfVIz4234lB8ggVFO+piASilvu9GQSG89S72I=;
        b=VgF9lf4kOQAhnLXVXthQblLnLzv6RcmEhNRNoKi5g5q2CeKxRgPDonYYbw7YrCzutw
         gGV6aUr0wlsX1KFwArbgNscj2HbOj+ELwTUgrhS315bSSXhDLrgaTd8saalA8ZuzY0O3
         wziy5mkvnk6i9SqF+a4u2506KfuLxeuOIwOZbDlHtXVYwoq39WjiV/kaNt9ISbKlOOID
         DRDKjK7dAm0cJF5+GPKAULXOYOb9+xOVG1z+x+kQYizufEhTU/JeQCkPgABCicO7xF0X
         xPtHTnrS+HeWXEJ6FuKsefpM8Rz96VgJxq3aUMNI/4G+VOBkzPnJ899Uj/RCQdfSUILF
         cTEA==
X-Forwarded-Encrypted: i=1; AJvYcCWXjsPUGcFE9Of21qH9qImvsO/q3B3dyG4sWdnanrqda8xwM6FnI6Lrxvq04ToRjtBmwvnrUQYOr8f4Fk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKZDJ0usJUQk+h4rr8Xb0pll64cwdlgMoglxo2ewL0zZdl0Oq
	OsfmMeqgUtjF0vfinSWflTfEizfaupUq8YrZ9ejf26cCmKJdboNLQTPEtcUyeUjsvG9yVEqt5p0
	T8Az+LvcFpQ==
X-Google-Smtp-Source: AGHT+IHSj8dNhtoUR+ln6GApAc1Wa0LZ6OyasRb6Nd6ZtNENLFtcT6z3cMDUavEA6p5ZusIU4xoikFN8aOn4
X-Received: from pjff6.prod.google.com ([2002:a17:90b:5626:b0:311:d79d:e432])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:184d:b0:311:f684:d3cd
 with SMTP id 98e67ed59e1d1-31c9f3c6068mr9597668a91.12.1752764948730; Thu, 17
 Jul 2025 08:09:08 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:08:54 -0700
In-Reply-To: <20250717150855.1032526-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717150855.1032526-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717150855.1032526-2-irogers@google.com>
Subject: [PATCH v2 2/3] perf pmu: Switch FILENAME_MAX to NAME_MAX
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

FILENAME_MAX is the same as PATH_MAX (4kb) in glibc rather than
NAME_MAX's 255. Switch to using NAME_MAX and ensure the '\0' is
accounted for in the path's buffer size.

Fixes: 754baf426e09 ("perf pmu: Change aliases from list to hashmap")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b09b2ea2407a..f3da6e27bfcb 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -453,7 +453,7 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 {
 	struct perf_pmu_alias *alias;
 	bool has_sysfs_event;
-	char event_file_name[FILENAME_MAX + 8];
+	char event_file_name[NAME_MAX + 8];
 
 	if (hashmap__find(pmu->aliases, name, &alias))
 		return alias;
@@ -752,7 +752,7 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 
 static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
 {
-	char path[FILENAME_MAX + 7];
+	char path[NAME_MAX + 8];
 	int ret, events_dir_fd;
 
 	scnprintf(path, sizeof(path), "%s/events", pmu->name);
-- 
2.50.0.727.gbf7dc18ff4-goog


