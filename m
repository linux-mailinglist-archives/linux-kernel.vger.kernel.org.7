Return-Path: <linux-kernel+bounces-735972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DBAB09632
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62F5173E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAAF222575;
	Thu, 17 Jul 2025 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9ilSaMP"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4D22FAC3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786164; cv=none; b=XD1muddReltT3kMxCFQHL4SbPxQYchXd4yu/b618vTWbXYKNM+9yEtHHdw2pOn2WvWGMVIWNV+0LfdIK2kfb+xXGbJInTRduChifLi/eh+wcO0HapHDW7jkjsCLeBlKSYxcG6nD+QjtzEDyaz3nUBzDUPzOeGJGsf2JSElTTDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786164; c=relaxed/simple;
	bh=zejmlYNwgS/OQpMHacoEnWFRqhftHB8onU2Qvy6vpsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qTjSqSiQZbOPut/LSrAxxkAWB3ughdgsqMfwiDdLoeAPnDwb12oBv1f/v+tl7HiPXpGncF/HaD9xHqmRIteKeQMqAMqel33GcuKQa3GgiAsKX/dSZq/q2XcZ5BW9AziBmF5ZzA7ZccNQuEwZ4FC4j/Ewdww+ynPGGYRqgsXJDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9ilSaMP; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2eb887a2109so1427256fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786162; x=1753390962; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dVZGHVi7sQRXRzVKkfTNIiUhn/WdB0GHZb62bnQe1c=;
        b=j9ilSaMPRHB+DZzYb/SMuDIF0UULb6BkWSNUdI+EdT8bPPRKWBXvNbWvzPTCava9C4
         QNWUtVeR7De9Ve/ymmBjvyicp6SLLYSidVcz4SH+HtBAFxO8fK9ubvn3n0b7bZ5D70oU
         o6d0dw6jYk9xsQ4AcBWeoMx9cXuILOulqrARA/3K/krD8eNDFhxwaKd0bzmCnUjbK82u
         Q+SmIvGfWkXi85+SPqnQBjykb+7m4xm9NXwScZ4XdIcQwX3BZb16J4ZoSheQnY2ahtbR
         uNdm5UeRXMkjhM6wuzngNJ1A451VztnwfAe0w0GJt0kYSNZAGd+Qxl6zvON+d4vVT9ob
         sQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786162; x=1753390962;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dVZGHVi7sQRXRzVKkfTNIiUhn/WdB0GHZb62bnQe1c=;
        b=AYLoK3py9u3kiNbHPoDvNEZwUsi7ck76cAS3MMLWrWGOyTkCwo2mdISVJy/B465+uW
         prkJeEX25wPQ2Awk6arwp2QfbzDNOvmauIH6l79k/z+LjbH67/RKju/Tq3guNxwytwzH
         Se5GtkmxodPIavVgX8IIivGxIHU52wEamAdT5gje67fEsA8TragHU/YoWcrTtafk0zvF
         +jo0IRDYGDRLkRVzzR1McYh0VF+34v0KlMQtF2PGf8hLWsFGOjs0i5u9r0EkgkbkQDPP
         0/bX6lUFhjW6Wp0xmH76tq5WmoATgPhVhwl00dil3f4t7ibcEKKVSDj63tUtPXIfKPt3
         5o6g==
X-Forwarded-Encrypted: i=1; AJvYcCUCB0WiS1Q+zjuMId8Fb+G94dFwhC2tdUSuHoI3DcuLp1a8nchrs3Co00ErWboYWyIJNjWU6ZcUiEmcmSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5t+Rviwxj+rI11/bpPRfRYcjmZvPH4hZuSYAWbTNzxqSxhFv0
	BrRXGc9YPwmU+tZg/WIPCDxJl2Ro67HEi5FbZlPabRMTn3jTy28MA/9Vs0qKu13AeHHlryZQNcY
	cBvabd+uo2Q==
X-Google-Smtp-Source: AGHT+IEf3wLginiuFgPMj/KhLeA3Fl3A4TQMyoFRYUZgHRewuT2Nl/mXUfU8dUFzGBWTIush9hwAag7yKgmI
X-Received: from oabna16.prod.google.com ([2002:a05:6870:6c10:b0:2b8:e735:4798])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:3048:b0:2d5:2955:aa58
 with SMTP id 586e51a60fabf-2ffb1eafd4amr5810811fac.0.1752786161596; Thu, 17
 Jul 2025 14:02:41 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:23 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-3-irogers@google.com>
Subject: [PATCH v2 02/12] perf stat: Avoid buffer overflow to the aggregation map
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

CPUs may be created and passed to perf_stat__get_aggr (via
config->aggr_get_id), such as in the stat display
should_skip_zero_counter. There may be no such aggr_id, for example,
if running with a thread. Add a missing bound check and just create
IDs for these cases.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 77e2248fa7fc..73b4521ab8af 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1365,7 +1365,7 @@ static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
 	struct aggr_cpu_id id;
 
 	/* per-process mode - should use global aggr mode */
-	if (cpu.cpu == -1)
+	if (cpu.cpu == -1 || cpu.cpu >= config->cpus_aggr_map->nr)
 		return get_id(config, cpu);
 
 	if (aggr_cpu_id__is_empty(&config->cpus_aggr_map->map[cpu.cpu]))
-- 
2.50.0.727.gbf7dc18ff4-goog


