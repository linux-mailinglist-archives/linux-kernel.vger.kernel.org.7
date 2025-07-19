Return-Path: <linux-kernel+bounces-737556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83869B0ADD1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE49F587DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361CA216E1B;
	Sat, 19 Jul 2025 03:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Tra2xnY"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6992264B6
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752896756; cv=none; b=V6imPitPFuIorMfo31Wk+8ySR0GfW28ex6x7saeh6pb2kOdC8t9OqeutCXagVGiSEg2z0WzgNypd9N1usTO8PPCsyaEA7tQsV72HT+RZgcBHD/P5d6Ez5zU+/MGhuREDazfnBz2MTWxZBt0c0ehyr6NuXc6tlrIVuO2FvmmFWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752896756; c=relaxed/simple;
	bh=HTgDiHcfpmsB1kpb9qDWCy9sflejE8kAAdvG3nRSZ8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PwxtN3dkUqY4bsx1t2eU490iLl1nNeZR0CnPg6jZYOKBSK4KMvYxIWxvfKbbNRl2HM/MXKT6sDLXcQ3fq+vq+DNkXmS4fU00mY4HhFdd9NGj8LeGcYtzlKM894A8V3g2CX8QI+M+/IdVm0c2EquI421auH2BHWy3Sj2CdbOkGEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Tra2xnY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ce2491c0fso3992890b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752896753; x=1753501553; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wyoHqHO0xSjLFu8zTnBCBlfDgc3kXoP6K9OnCFzAIxc=;
        b=3Tra2xnYi/ja/ZC+Of47KeuGUD+7bdhSJK03xstpx5jYgbHSfELSoa9tbQiGMiHoBz
         8eF6Lve40ji9wrEfQ62PUhP6D8W6CdseZ207U8F4EIfi1D44IZ3o2ssn+YZsV7hjJO4d
         7HseyySxVy9Kk9dXUriCn6COORWmUifJI//toDxcVAVm/XCVscqzmTm4sJ5QzbC/IuXL
         1FI5Dc33QQlV/pRrvP/68cpykNCN+uL88SsTZKE6VYTapVRnwdPywHM68fknrXQvpFRr
         XXt56yq30RN+OwA06Dl28SzDRqnPVEHdEXbeDWog8HgN5Aa3zgMhpnwC5b4rPxKLad7X
         Ze8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752896753; x=1753501553;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyoHqHO0xSjLFu8zTnBCBlfDgc3kXoP6K9OnCFzAIxc=;
        b=LN54GkJKMh8okqItkx4bzZ4OXRHNgZ7EUw64bavpZUme0uEMwFJaSyFWbrMNBsTK47
         qMScUuRDtyF6THudCzNtfDq40HpAeqw7CYjTzPOPw1NCAeJCOnQd+y/5xZA66TVeWQ71
         mMtlU4Rz3QjUZXNZ0SeFzFjoW56Xkp0SqNPxI/Ri5SI0TUPQWXUm9BZb69gmJ7MEUA0y
         sitNau7cuvFFZYkOC3OGj1lDndzCWFKX90VOK8NdoSt0FkuNzpDawNLhIHP7j6dwhCId
         tQmDVMXD4111/2zQSBG2GB9Hdpb7gQxhvUSeBM2EgJPwm3xaz9UWjCMzUgOhDUQQS0bm
         MaJA==
X-Forwarded-Encrypted: i=1; AJvYcCUCRYQWtykHJ5SXNsrvVloNqq54cs3NhWa5Fy1zFZdW11X13W9gs2XJ6I09aM1eWyGwJm5max6/4EkIHf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0g1SaAMuANpnue0hD42j8O9hjb7f3bSY20k2MFMzFPvzhmO70
	VoKXPoJ9E/QEF8bDg/vsysuEcxAhc6E9bKXVpKZo7gWS7FqGzSTXjubFfJjiiqJ0ctzmmAmOBPK
	VlCLNAtvhDQ==
X-Google-Smtp-Source: AGHT+IEvlwMx6OUGmBObZryfm2N5mH9c5xFv7x/kAdQ364gVL3wMAsr/DibD/iPCp5oqD1mn0gDliHeWG5du
X-Received: from pfuv16.prod.google.com ([2002:a05:6a00:1490:b0:74a:cccf:5726])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b45:b0:746:26fe:8cdf
 with SMTP id d2e1a72fcca58-758492e296dmr13889782b3a.7.1752896752680; Fri, 18
 Jul 2025 20:45:52 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:45:11 -0700
In-Reply-To: <20250719034515.2000467-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719034515.2000467-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719034515.2000467-16-irogers@google.com>
Subject: [PATCH v1 15/19] perf vendor events: Update sandybridge metrics
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Update metrics from TMA 5.0 to 5.1.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.50.0.727.gbf7dc18ff4-goog


