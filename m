Return-Path: <linux-kernel+bounces-687648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF28ADA770
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 07:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2CE188FFB9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 05:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB5C1D5CE0;
	Mon, 16 Jun 2025 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0qDcivQb"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEEC1C1F2F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050930; cv=none; b=pTAMMB5FsbmOJoQ9nVWQL9SzdljmZG74ezkmLXj2YkEk7XU2HZDWT7h10qnCTFC04wu/w183ImazOYJKzwiIqB4P4Cf9uAQArX6i9iYhthxnSTasvrFBtlWzocYKmU7S/kEdIAErFotrKmrEx2i5hpsUiQQZ5ercQWmG1pdvJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050930; c=relaxed/simple;
	bh=t/FRxYTG+D54BYUz0KeUNeKNi7Xmml5aAZJln458g4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=H1wbFj4d9jFMlTKQCPq82nGXFs/EVILMC4h35fU3Lj99vvo69BwO+d7zOAehLGWhr4T6cHRqVa/lZQynbaHKRhEwGuLIi1zw5MNW9Wid0kYm647w2KQA+SdBla9oYXbGDTY8BqQtjVh8rWUs0B7YRkcIkDFHDTnGLF/nHWXRWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0qDcivQb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so3583470a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jun 2025 22:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750050928; x=1750655728; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j/FsflWYTCgAT92JI9ObGbeoiqi07FQ5gkzYOBlamRE=;
        b=0qDcivQb+0eab7hVfdscWlq97nlwuT/QpHRjjXYIUMUSTN6DgkboDAPGqsUgbV3pgD
         niWcK/93L/+UGXMJhiNyznzG6e0Cte1PitezlFobfXeFHZMCCAUUds618qpChNp1xVFN
         Ddju8dzd0yfcTIPoOcrjvaCvc8vzvWfZxc4sspigPJmK2Tl1F6xPb7jWC4/iqDv+4Ibr
         tVjc7dLoWHAaBq3QGPuqi8sM7ShqM1YosF6sFUikbJRqjQzcE9MtZoTszVxvWJJrOyzl
         xQ65QxtY+LzfQO9yaHZeNxLPuvG/DXFFhcLsBHZovwLteXM55Pww3KyFstxP7A94jeJW
         zJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750050928; x=1750655728;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/FsflWYTCgAT92JI9ObGbeoiqi07FQ5gkzYOBlamRE=;
        b=k98jTBQxrG3eoq8P9GRcxi80K/Jvqb6lFYMo0wAKYQyDL0DQx7NGjoJkyGk5WfcvlN
         +n9iTGQhMjtQu3JHHKk3YdpSDIXj0wVI94Kuj1tl4v7LVwB2b3zyPD60yhokSXffU2SC
         BIbJ5+rSgxZI603Gtnj7ZDe2VF3NfKIjLjEdS1ysY8zEsoAhZojnEqTOJfvzJJ51LgXM
         l8hUgo5jI8QtrW/PmHBE4jboEVwNMp8sohpqawrk2LQDWsTBQCCbRJBUueuTCS8REW0r
         j4MEnYxB0LVAdDjopKviWf7NmQgaywUs86ItFt62CHbiHWf0sOphgMLqbipemlBc2IaP
         wpfg==
X-Forwarded-Encrypted: i=1; AJvYcCUKK4b0RyPYGoLU3BfALFUyrv32G232u3lpZ3nzveNOxPSZgd36MjMpnKoT6DdFAs7fTJMSM8uAJec5X8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOXcrMPoWnk/hI6N8PY3EWZrqwUvCnQkUdfAGK/MxH0pat/3Z2
	Efpe4Px6oCYX0w++PZqm0+4oNUs3HoCiS2bMLEGG3r11Djn1sRyeutSfcB5tAlE4MBPgaPhumo4
	dgBNHFwIM3w==
X-Google-Smtp-Source: AGHT+IEgHMJj4LWgi+OvKWFekCaf1ai+6sfMoZu7Eri7YtGVBDQExF7fJeRMENT/jO8QAfgNdpvjMlYg7nwg
X-Received: from pjbqo16.prod.google.com ([2002:a17:90b:3dd0:b0:312:ea08:fa64])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da90:b0:312:daf3:bac9
 with SMTP id 98e67ed59e1d1-313f1d07b65mr10747037a91.34.1750050928324; Sun, 15
 Jun 2025 22:15:28 -0700 (PDT)
Date: Sun, 15 Jun 2025 22:14:46 -0700
In-Reply-To: <20250616051500.1047173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250616051500.1047173-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250616051500.1047173-2-irogers@google.com>
Subject: [PATCH v3 01/15] perf hwmon_pmu: Avoid shortening hwmon PMU name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Long names like ucsi_source_psy_USBC000:001 when prefixed with hwmon_
exceed the buffer size and the last digit is lost. This causes
confusion with similar names like ucsi_source_psy_USBC000:002. Extend
the buffer size to avoid this.

Fixes: 53cc0b351ec9 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hwmon_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index c25e7296f1c1..75683c543994 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -344,7 +344,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 
 struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir, const char *sysfs_name, const char *name)
 {
-	char buf[32];
+	char buf[64];
 	struct hwmon_pmu *hwm;
 	__u32 type = PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name + 5, NULL, 10);
 
-- 
2.50.0.rc2.696.g1fc2a0284f-goog


