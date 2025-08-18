Return-Path: <linux-kernel+bounces-774353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA929B2B149
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB2D3AB12F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B315B32BF50;
	Mon, 18 Aug 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zHjzcCKT"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05962273D8F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543975; cv=none; b=rh3NfloEeY9bRtbFw/iV5veyM90ui6lqFzO5qFYluoOBw4lj69pHRsZ7mjNl/oZ3NR5Qv7L0E9s2QhVAD631n+ezjqvH48mPUZXk++gn2ESMox1X589dM7OsTmbXAQleeGZWK07WSe7XPWtHaxkPMwBuwNlxyRzbLVYasbcI6Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543975; c=relaxed/simple;
	bh=LcmzKh8MxKe7S2JdMF2i56oqJa5WycnupoSJN/TemBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jEYWQcos+c4r9k3X8RACoF++VifDLbQBNDPzKCH/tEygkcWeqTZyACgm++GwLSnz+8BQXCuW2M1Y8vlvhuK5TMiTb3iVjYE8QjXSfwYDo9uOHHlaWIG3YGpgRAu8XAOiAyvEqL6nPvIn5S5ogbZ6tBvyEchEmFcsUYx5BgMzaY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zHjzcCKT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457fe8844so51612015ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755543973; x=1756148773; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Oh45/+Kol4/Ff6MHQPrzumdu5r/WMLLUjenm77C2bc=;
        b=zHjzcCKTge2ZI8k73TEuNUVWI7U+zOzK2CkEfJ4GgZeayd4UVmQjhdChD12Lko8aHV
         e4d61tPdf+bG0S1Zx5+UDj024+OElfV8LgQ6QFNVQtOIQGjPz54+VVz+hT2cwmsyDfYR
         L+ZPtR+h3/ro8aLcu2dsxnz1VyqYSX0AaiOBS3IDqwXP3sjrgSTAmJIgAxEC2o44Usd9
         iwhELy/SefCqBENbI7fII/1KACNfVhG1AUbT4Ujs7D9zEsyVP4dU283UcJbrn5KcFE+g
         h0RHepgzmaRs2+diy2YCM62LCct9LalVYjWf1k+FflBsuoORj2ggiUG2j11lnwowyJik
         wtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543973; x=1756148773;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Oh45/+Kol4/Ff6MHQPrzumdu5r/WMLLUjenm77C2bc=;
        b=HfJ5FG/zbrnjnAuopmZ5h3uRT2182wje2t0b+jjZBPReFhk5EirGFSivVBeagHv7BX
         pDwNrHsZITTU4rzrHylQ7dFCLFTGTCsoWteiWQWNA/y9XGzGtJwwRXrE2GGJNbTCnB8y
         FdBKl57BhvvzxgseLHfceR8S+M4T/SudrLUcDlQAH4ogV0NUSO/NEXOAcnGuiY9L3+7b
         cch1EDjAwSQzmFBD7jLyKwdv4Ig45jPXafQ/nASuVCwOD4NhU/GrxvDrSvxsinNVuCG5
         fsdECWRfOIai3R3WOFpu97a8qglzKZ7URA9/T3DVYA01lFuc7x6rsYh6jTz5ZeUVnXWP
         HOUg==
X-Forwarded-Encrypted: i=1; AJvYcCXGWh426b38Gp60papBI9nc0m/MiqWY9PIdg4dAkrjc0AVyOZOFqEueUt81qMR1wI/pffCDozZnwmnhiiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBzOfEEdka3tiJZLc9OHTJuEo1qO2lujI0OKTuy0BBPHi7q5GP
	lzPPGJvIBDSs4XnwRuRZzj8rkzGG6i/k7tw1oDeZ5gW+LWGMIOvi5ENgBsx3nkMNkRU1tk8kZCU
	Uvrse6oKXGg==
X-Google-Smtp-Source: AGHT+IHTGaTTiW/uZLksoxGLFmmaMCpk22DofrBNoAabsB3kcFxlVjkcIJyuzq08E+2twTPTPd3iYeDDlNTi
X-Received: from pjbqx14.prod.google.com ([2002:a17:90b:3e4e:b0:321:9285:be8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f83:b0:321:87fa:e1f6
 with SMTP id 98e67ed59e1d1-3245e562016mr15244a91.1.1755543973327; Mon, 18 Aug
 2025 12:06:13 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:04:12 -0700
In-Reply-To: <20250818190416.145274-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818190416.145274-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818190416.145274-17-irogers@google.com>
Subject: [PATCH v2 16/20] perf vendor events: Update sandybridge metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Update metrics from TMA 5.0 to 5.1.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 .../arch/x86/sandybridge/snb-metrics.json     | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
index 823d8b7c4224..d40761903429 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
@@ -1,49 +1,49 @@
 [
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency",
         "ScaleUnit": "100%"
@@ -71,7 +71,6 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma_retiring)",
         "MetricGroup": "BvOB;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
@@ -296,7 +295,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma_info_system_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * msr@tsc@ / 1e9 / tma_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -308,7 +307,7 @@
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized"
     },
-- 
2.51.0.rc1.167.g924127e9c0-goog


