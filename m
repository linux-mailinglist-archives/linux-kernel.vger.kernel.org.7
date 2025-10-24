Return-Path: <linux-kernel+bounces-869322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D745AC079E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BFA40785A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4856346E72;
	Fri, 24 Oct 2025 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDuB+VzJ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6600346E76
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328751; cv=none; b=ICa3L5xNCyqPWIgmzVOzeaW9bRc/TTYmLbE983i7S6Oc1CVFmGMETNjyKbcc/dfQwhJP1PxX5wPUp6wlJ2vQeIZmioogvfd7LeZppEfwVfmcBzMM490xIiEhY8tsh/FtQRS6gM6ymyoZDLnuTh38uMRY1yFFu3LaYzJ6N3GWN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328751; c=relaxed/simple;
	bh=y6HnQZia41UtwY0YyvlgW3W6qOJoIv/4XqLTxzvxWN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=c+JFXJD5dVOmiRVWOfSyXh7zrFBx+EavRgUjlAV5FccOIK60Os38TppIqx2OmI8egYG2GlkMMVN9UKJSIG/eQC4zNT4raXX8W31S8EOJXFxfarLXRRFjqlnxs5+ebE6Wc06wnU84Z5lyOVr810mcEec1tlQNTlP8ZpWKmc7TB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDuB+VzJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bcb7796d4so2357459a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328749; x=1761933549; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cokO0Sr9XTu+ExHguyCo1Sd9Y8GFVn9rZjxHL+N1gsY=;
        b=KDuB+VzJfuNUl2ISsqcccc5Z8S3dwFepPPJRJJ+APjLE46jE5s3bBWinFcMYq4RwyO
         cWLJ25qeenTm0LPBSWbP1eynyHa3pHZNhYbbtxZtDfa9sSvlk+F2L+afrufSdF7PzRc0
         E0L5S5D5+jY4N1jngkRhNf4k6nuXJ04627DMeTUf9jcuci6m4sf/ICjK/6RaQZxVk91m
         M9bsAev4QihTYnIBZKb8XbHNQFJLtDXA2PDpd26j5n6vSt+kcfy2ymzJHJ8ht9tijzH0
         8di0qVSp434+opU7N5ngJRDdOw1qaRes1MGy746XeSaGRQv8DNJ01+BnMWeIRiJMpUSB
         DamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328749; x=1761933549;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cokO0Sr9XTu+ExHguyCo1Sd9Y8GFVn9rZjxHL+N1gsY=;
        b=AZxOJjV1HyDNWbVKu41r/BQKbNLciZ/xmnV0lD2gmlM0TwcsTyJ7QzBHiHOin7HhAy
         3a2NM0Igs2nfS1/6d3FE5wbkP/LS0iSZKw9TOtTb5ZfPt0box9cSbRL+KvQrYPiKTaPZ
         eyklXXrsJN5IiajFr8JqMqgWzpLoY7nTm0VzbR5U1trbwuLIP6cIQe0v/3dFCsY7Sl7B
         pRbekphV0phBp3vqHC6+jeny93D84r38RftcDHrndf78qQIEoNqOtYFpa+mTYH2yxobY
         AXjIX/dEgkoEhYJRQyt6580XjRJSIaiSx45p/V1W8ALNz/qYB/qkKBUx8dxFNBXEFWqG
         ltZw==
X-Forwarded-Encrypted: i=1; AJvYcCXEDMlY3aF7ILIPCGhmrIfOGascq05/k2Ag8ip6H/zzf8zRwJxfirXtg6j2XehjZI/wyPVkTYWbaU66Tng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/OrFhLQ1xNP+xzDpYO8VTpcoORsdbqo/Sd+a0JRcKQTvxyRi
	tEqoScBZ0GZ9ar7muscEbBaBSrOYYAQDHl0inPEqDTI2/pnCGKnWfpOZwuuDoLo5cmaCXpwVbeg
	sEECvenaTjQ==
X-Google-Smtp-Source: AGHT+IGI+JqHMiuTh4v84Dx/JIanazWnP/wdgwfnIy5TXQtNZAoVhJ96nHZKWoCgTLxJW1ADY9HnHnWuFdNC
X-Received: from pjzg18.prod.google.com ([2002:a17:90a:e592:b0:33b:9e06:6b9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35cc:b0:33b:ba50:fccc
 with SMTP id 98e67ed59e1d1-33fafc1bc67mr8458246a91.18.1761328748903; Fri, 24
 Oct 2025 10:59:08 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:39 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-5-irogers@google.com>
Subject: [PATCH v1 04/22] perf metricgroup: When copy metrics copy default information
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When copy metrics into a group also copy default information from the
original metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c822cf5da53b..48936e517803 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1608,6 +1608,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 		pr_debug("copying metric event for cgroup '%s': %s (idx=%d)\n",
 			 cgrp ? cgrp->name : "root", evsel->name, evsel->core.idx);
 
+		new_me->is_default = old_me->is_default;
 		list_for_each_entry(old_expr, &old_me->head, nd) {
 			new_expr = malloc(sizeof(*new_expr));
 			if (!new_expr)
@@ -1621,6 +1622,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 
 			new_expr->metric_unit = old_expr->metric_unit;
 			new_expr->runtime = old_expr->runtime;
+			new_expr->default_metricgroup_name = old_expr->default_metricgroup_name;
 
 			if (old_expr->metric_refs) {
 				/* calculate number of metric_events */
-- 
2.51.1.821.gb6fe4d2222-goog


