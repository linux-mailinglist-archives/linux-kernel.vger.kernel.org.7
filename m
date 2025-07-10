Return-Path: <linux-kernel+bounces-726660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171F4B00FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC361C48565
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1806307498;
	Thu, 10 Jul 2025 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbK4XSok"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB9530749D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191516; cv=none; b=izFFra/Ku/Qh0g8a+YK+16o1wmTteXmBAUL/1Pwqu3AfX2bLRptBGauV6cBaFX4VuJS0Er8V4mY8W9k0YtE7mwIgBljknbYhVDFk2lQvqNnyKrQysXd2Q0XwcUk78//y36kV6Xl3Jzv6c4VyUajXLPxUIfwdjzO7cT+QW00+n84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191516; c=relaxed/simple;
	bh=8+fzwKbYyh0HgEc4+oNZYk8ZhmbZCi8quzaYQRyDMRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Kdon57wBiZeS2fN1gCNixLnNSFLNjVoa1dLL9JkWfXpv/HOyVQhzKoka2lqTRmdl58F8bkZ8+Z9V0Jm+Y4Ex0QXB2oKIEDGmcsl4/mwZkSr4m32qlDKB/42oV7gZtthUoKtX05Odfdktrs8PpOiOnj6QtLmmjUQK9m8YveRQBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbK4XSok; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31315427249so1388902a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191514; x=1752796314; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jB43BWOgr1OVnJk/vG7v3SNwpLjEdqHnInxVydle4NQ=;
        b=kbK4XSokMMpOfu3C4NT75FrWVKyi907FrU6rUGqmKYh0g/o6sXiRe79oZi1+fARaaM
         JPBmGIbhYA2uQ03JwhgCoEBgHuwn38O2viANakUw5MekoAQNk/yTbrMzv2DFNA6aKebq
         EBHpd7jiNDoyNMGoORYaMgVAgz21RpLv3VVIsIGQdkXsVTLqYBFbRlWFZAEMgvRFMcHI
         Cd9/cjEnvCg5Gu6t2vquEFvcIvKYHv6hprBlcZOpYXs20yJZ7S79sAX93mfoZ52MqilW
         erc44ptiPys+KiEcjWwot+Mht8yz2ynurfKplrYzmz2hChgNdaC4xfO5mFyXVfk7CISl
         8jhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191514; x=1752796314;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jB43BWOgr1OVnJk/vG7v3SNwpLjEdqHnInxVydle4NQ=;
        b=t1ndOd3KL7bZ5E22vdeBPvKNsDQylCohWr9mcijbxzDL+VGmu+whUKKUpIylP4wMy+
         gEWdjbsz4DHGDnidXaBiXUgVqbNeeE2Que4xpCeUBiTI3Clm4qCj2jDhLGLEoSEiIavH
         46+1NBiz94AUsRoHHydVkFm3omUQvJNY8uOVtx6rYDHHRl/KFldCIvlNxXt36xLkdIu+
         LaGHEzzlw1EPeMc8q3gRhDdymPoTIkAgbSuocpsb1Mu04StytWf8bmOzdhutQUlLTfmz
         I79ZEBtjJ8NQgoqoAFIfshB5luDo8TniExynPfL26OMCUI43eltWQMMDUcCWIbmK+GUM
         NEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH+zzfm4mh6LceRAyskelPXoPtNndZvSBFBGQ+OhcE7vG5sdUBRc/e3jTN8m4MYciIhRmoFJIF1fvCtTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnY4xXjy1F3pljbuXxm+IU2bdvad/hN1EG5rxtNQXUr0cMUK/W
	W9/OvrsYkMMv6l/XqDkvJCdEEDwJn8lL3I7vN2KVa2qAKSeYk66kSg17heO1Hn0ZrHBZHEQ70uS
	FAyO1TtmfgQ==
X-Google-Smtp-Source: AGHT+IFHzoDdAVLiVt9wqChVcdmJwG5lwune8sMQ5I/kskubztWTyZMq3w6w/iqjpi5C0lsgndQnJd7FY+BX
X-Received: from pjbqi10.prod.google.com ([2002:a17:90b:274a:b0:311:a4ee:7c3d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c0d:b0:315:af43:12ee
 with SMTP id 98e67ed59e1d1-31c50e1763cmr185604a91.16.1752191514187; Thu, 10
 Jul 2025 16:51:54 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:17 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-5-irogers@google.com>
Subject: [PATCH v2 04/13] perf pmu: Tolerate failure to read the type for
 wellknown PMUs
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

If sysfs isn't mounted then we may fail to read a PMU's type. In this
situation resort to lookup of wellknown types. Only applies to
software, tracepoint and breakpoint PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f795883c233f..23666883049d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1182,6 +1182,32 @@ int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
 	return 0;
 }
 
+static __u32 wellknown_pmu_type(const char *pmu_name)
+{
+	struct {
+		const char *pmu_name;
+		__u32 type;
+	} wellknown_pmus[] = {
+		{
+			"software",
+			PERF_TYPE_SOFTWARE
+		},
+		{
+			"tracepoint",
+			PERF_TYPE_TRACEPOINT
+		},
+		{
+			"breakpoint",
+			PERF_TYPE_BREAKPOINT
+		},
+	};
+	for (size_t i = 0; i < ARRAY_SIZE(wellknown_pmus); i++) {
+		if (!strcmp(wellknown_pmus[i].pmu_name, pmu_name))
+			return wellknown_pmus[i].type;
+	}
+	return PERF_TYPE_MAX;
+}
+
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name,
 				  bool eager_load)
 {
@@ -1201,8 +1227,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	 * that type value is successfully assigned (return 1).
 	 */
 	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &pmu->type) != 1) {
-		perf_pmu__delete(pmu);
-		return NULL;
+		/* Double check the PMU's name isn't wellknown. */
+		pmu->type = wellknown_pmu_type(name);
+		if (pmu->type == PERF_TYPE_MAX) {
+			perf_pmu__delete(pmu);
+			return NULL;
+		}
 	}
 
 	/*
-- 
2.50.0.727.gbf7dc18ff4-goog


