Return-Path: <linux-kernel+bounces-869324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E537C079EA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408441C41F64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E022FBDE4;
	Fri, 24 Oct 2025 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZii0vf4"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6FB348452
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328755; cv=none; b=JQ/dVU+7pXWCxEk2TBr2QIWee1tZ1C4uYKgdqacXghZrLHdNLOVOsA4Fmn9Uhz56kKEsBNG/+SiYpQ6my8J4Zhcc7FLkI+83sjeDOlETty2ngZ+2hP46yskMvnVDib65PVl8Z65C0FpUFBfJIfyk0PwiySvVxf7EK1e2LrR/QxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328755; c=relaxed/simple;
	bh=e4R6AVkXL/b1gApEzWYidv1J/iqwS7GQ4hazLe6UCLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uD27Crape8fs8/yHDNw3ht0KnUtkmQ9AknIsf3ZS87fNQh3NWAs/V/c3fqAwZao1TZ7Pb1ptOu5nJfe8WaaMHblBVjZXRYR+9YxZtT0T2BZPN+eRjVW2yqM4mcxbOndAD4lmlmTd/iRIiJfWhdHje+CjyEHjjvtN5w5WjH+zFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZii0vf4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27356178876so15183325ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328753; x=1761933553; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nG2hV1s5ki9YDnz6tl1mLOAmUldYkmEMzzCVZ1F8mHU=;
        b=qZii0vf4cZqcISjkB2gZFbGRrAdyCZ7zFWbRFMLAMfhLowyYGD5v92Hha0wQpzFLzq
         olGjzLv8Km6yYuh1bKkk4j5NaQVCo1NYUf1Eyss0L3jL8QZvnKkqTVfdiyxjt6PN6okI
         Vb2ZKPGjb9MYujb73/CrHhgOMu94FljpYLK9i+y8v+3lOScwYyf96i0faoc38iuY0mxU
         GaMcfs80S7kQUi/XFeFT8vayWIANUvGAAvkEfD0lXmFj3hRqO61bx+8qU5sqh+93pfiB
         +ecpFhYKaBon3zLpdC1V7EeH8YAfmJOaKO1KekK+DveSw78gvYycgaNwAcUPCnl6fCdN
         59AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328753; x=1761933553;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nG2hV1s5ki9YDnz6tl1mLOAmUldYkmEMzzCVZ1F8mHU=;
        b=U85JQe9ZlcllHgpygx+YMhSoiBYRSP7Ds5xFGmFhLrUN53UW16R6XMFA462w/2F68E
         uDkk0l60Ofpvd8T7vYDcZUnSxV+zre+A0cSR9zHtcgStAGAn3bO+WhmOyjDdLMQigswX
         wvZZHAggf1cUCldKujuv3yA8Xt8efGby9GZYk8Q0qlxi1yXeOwhT8RyPX7Cd1UrxLUfx
         oH/07hwc3azF8LftZfAsGTMWIRjMNpEA9AzScH68v1+GJo/HYd9mKESHBdzx9CJcHQRn
         rscFcJgHwggHOb5PWQdyChwiDNSd0zgMgBHn6RRZEI0mfqL0eKES5rCFH7nSfGUCIUEi
         KLvg==
X-Forwarded-Encrypted: i=1; AJvYcCUl4AHGHUzilNvLtl5UIBNGpEOUsSsUhgM3/uUtk5Z2/ra4eDWaI0gH0y6ErMUHJS1iU2oeR8KyI7SR72U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUJa7Gp4nOwvUeApFpnBSP7hFIJHXi40F9OBYzBylGPRrMA7TB
	plTM4G/pk5IzKeYKd+nxXWEv4DZBpteXgxrEMM+T1D+0KPuaAxpvQVtBo/BlnR0iXnBfFc6bcj+
	o7u0/Y1h3GQ==
X-Google-Smtp-Source: AGHT+IErrc3a+M+Y7idOuC3m/1xAORwpqR28MnITxE1vZU6cFGOIA0Krct48wBGfAWPzIT+JWfWUg52NODQo
X-Received: from pltf1.prod.google.com ([2002:a17:902:74c1:b0:267:ddd1:bc97])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d506:b0:290:c5c8:9412
 with SMTP id d9443c01a7336-290c9cf37demr393918065ad.5.1761328753299; Fri, 24
 Oct 2025 10:59:13 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:41 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-7-irogers@google.com>
Subject: [PATCH v1 06/22] perf jevents: Make all tables static
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

The tables created by jevents.py are only used within the pmu-events.c
file. Change the declarations of those global variables to be static
to encapsulate this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 10 +++++-----
 tools/perf/pmu-events/jevents.py         |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 336e3924ce84..5120fb93690e 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -2585,7 +2585,7 @@ static const struct compact_pmu_event pmu_events__common_tool[] = {
 
 };
 
-const struct pmu_table_entry pmu_events__common[] = {
+static const struct pmu_table_entry pmu_events__common[] = {
 {
      .entries = pmu_events__common_default_core,
      .num_entries = ARRAY_SIZE(pmu_events__common_default_core),
@@ -2630,7 +2630,7 @@ static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_free_r
 
 };
 
-const struct pmu_table_entry pmu_events__test_soc_cpu[] = {
+static const struct pmu_table_entry pmu_events__test_soc_cpu[] = {
 {
      .entries = pmu_events__test_soc_cpu_default_core,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_cpu_default_core),
@@ -2682,7 +2682,7 @@ static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_core[] =
 
 };
 
-const struct pmu_table_entry pmu_metrics__test_soc_cpu[] = {
+static const struct pmu_table_entry pmu_metrics__test_soc_cpu[] = {
 {
      .entries = pmu_metrics__test_soc_cpu_default_core,
      .num_entries = ARRAY_SIZE(pmu_metrics__test_soc_cpu_default_core),
@@ -2701,7 +2701,7 @@ static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_ddr_pm
 
 };
 
-const struct pmu_table_entry pmu_events__test_soc_sys[] = {
+static const struct pmu_table_entry pmu_events__test_soc_sys[] = {
 {
      .entries = pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_pmu),
@@ -2751,7 +2751,7 @@ struct pmu_events_map {
  * Global table mapping each known CPU for the architecture to its
  * table of PMU events.
  */
-const struct pmu_events_map pmu_events_map[] = {
+static const struct pmu_events_map pmu_events_map[] = {
 {
 	.arch = "common",
 	.cpuid = "common",
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 1f3917cbff87..786a7049363f 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -550,7 +550,7 @@ def print_pending_events() -> None:
   _args.output_file.write(f"""
 }};
 
-const struct pmu_table_entry {_pending_events_tblname}[] = {{
+static const struct pmu_table_entry {_pending_events_tblname}[] = {{
 """)
   for (pmu, tbl_pmu) in sorted(pmus):
     pmu_name = f"{pmu}\\000"
@@ -605,7 +605,7 @@ def print_pending_metrics() -> None:
   _args.output_file.write(f"""
 }};
 
-const struct pmu_table_entry {_pending_metrics_tblname}[] = {{
+static const struct pmu_table_entry {_pending_metrics_tblname}[] = {{
 """)
   for (pmu, tbl_pmu) in sorted(pmus):
     pmu_name = f"{pmu}\\000"
@@ -730,7 +730,7 @@ struct pmu_events_map {
  * Global table mapping each known CPU for the architecture to its
  * table of PMU events.
  */
-const struct pmu_events_map pmu_events_map[] = {
+static const struct pmu_events_map pmu_events_map[] = {
 """)
   for arch in archs:
     if arch == 'test':
-- 
2.51.1.821.gb6fe4d2222-goog


