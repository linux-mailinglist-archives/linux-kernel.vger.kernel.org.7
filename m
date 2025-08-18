Return-Path: <linux-kernel+bounces-774356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6A9B2B148
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340E51884AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30943451B7;
	Mon, 18 Aug 2025 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irfdp+ep"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574A3314D0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543983; cv=none; b=b+V6uOIQoO5JHENdH1D4VUcOtGd9Eq6msAkK74atPUEQ32/CF8ZiRN5dJJfxJ534LnMIQXSU5iJ2wHtOf/Cvvz1vXyff/OSKKUM3jkZjhpfhdEllEfnRwMNsOZwN4lkmCc5/qnJ34nOViyCyyWCOPclsEg9GFajmpq8r4rB+c68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543983; c=relaxed/simple;
	bh=1jpuuTzjhqz3qDkfKHOu7ocIaPlgM25SmYekDft8Sjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SFKO8iUdnRMz8K77teliAkdgiM8ERO5IDwNvSWU8MUO8PQWGehS6xPq5WfeDTGC5FP0HrX8c+rNR148WhTRfOUxF9TPFBNysRBSDDGqc7AQ7i7unHOKcoDw3nT0KUiHMJOscMw3gt/DpV7RngRDB0d0QIBjcl2uLQq9j8aJaH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irfdp+ep; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323267b6c8eso10010254a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755543980; x=1756148780; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRZrJ83jbIC3fyyYlD8BxhT6pZCcjqxNkMUQZE+n8nk=;
        b=irfdp+epT+yKHB6cEDmrbD9OqllmMJMIfQmoeFxLzX5ZSIVt4MqLls6lM45OqqAQPj
         whO28JGD3/jP1WhZWGkWkNClq2N/DCm/EnjuDgkm95QjoWFHJOeicjzzGqThmjaPAW32
         EMicDUuni+GbBe9dMZc8lHoV5wxygPp8SIr9QAYDkkHgTPxwe99PGqHKdMPUcceO1FhZ
         v/z+NV7sNH7MU90QhaabPPW1MO5fuwPJwZ6ZUQPWmZ9EOhNpE6eKnAjpBHsUdTkWW8sc
         AbK81YOkkn2I0OJYnoXMuiLWj1MAn7RWh77OOmUCLoymHB6lo3MZ29iWwgEEm0ArTvR/
         ZZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543980; x=1756148780;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRZrJ83jbIC3fyyYlD8BxhT6pZCcjqxNkMUQZE+n8nk=;
        b=gt39KS87/4DcGQDLbZn2D3XyuIZ42oWU75QtzdaisrweldzCvOiki50NbJdqE3iyzL
         sRgMTAVfsIFpWESTo4vQcv9A2Yox7cZMth38x3dv77SrR+Adjf9I+ELNAFJK8fBjWagd
         WGwnrWhVakcQcH7oyv2VoEb3aI2dVAiqkWg/Ipk2s3LnunjtieJz8E9qZCTbKwYh4TLW
         5iuXOsPAIkQi5vWVfYIY+yScPiiB0x1yo41EQu8cn27Y091hEh9OEm1thcApEF4MN0i9
         3AaeRjElqYlUbYykWWW7uSvBReD1NK5ZpNlw6/0UFAxdx5pHKGQ8eLBF+CdYFUkHCxV0
         A1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYSSPtag48uSafDLy8U1GMWRfu7t+kCrx+cjI3dzcXL75tefxU0rea9sWeUEWjK2EIvaRy22H+LSMAYLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH2Z2f3C4mRZdHUx3AlLwhkLc12vfMTLcbcLUBWyQf6bD4rGkv
	jUjr51i1bd2VYWY01n79OG75kIWsJvDLeiBCyVDBCYhXoqM1GnFMVG+ZNrDU4LukSPNDJvwNpi4
	rwo9hf7yweA==
X-Google-Smtp-Source: AGHT+IFe8/7n25l71Po2FXD0IXg8qcH8/D48vc/DuUu9lw5pVT8d2sJPZmLb/ZBnhjg6BkFhzwLKX9uN4M30
X-Received: from pjbta5.prod.google.com ([2002:a17:90b:4ec5:b0:2e0:915d:d594])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e0f:b0:31f:42e8:a896
 with SMTP id 98e67ed59e1d1-3237f60d711mr428628a91.34.1755543980004; Mon, 18
 Aug 2025 12:06:20 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:04:14 -0700
In-Reply-To: <20250818190416.145274-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818190416.145274-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818190416.145274-19-irogers@google.com>
Subject: [PATCH v2 18/20] perf vendor events: Update sierraforest metrics
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
 .../arch/x86/sierraforest/srf-metrics.json    | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json b/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
index b9f3c611d87b..ca2c55917e55 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
@@ -1,56 +1,56 @@
 [
     {
         "BriefDescription": "C10 residency percent per package",
-        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c10\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C10_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C1 residency percent per core",
-        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c1\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C1_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency",
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
         "BriefDescription": "C8 residency percent per package",
-        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c8\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C8_Pkg_Residency",
         "ScaleUnit": "100%"
@@ -735,7 +735,7 @@
     },
     {
         "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricName": "tma_info_system_cpu_utilization"
     },
     {
@@ -747,7 +747,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "cpu@CPU_CLK_UNHALTED.CORE_P@k / CPU_CLK_UNHALTED.CORE",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P:k / CPU_CLK_UNHALTED.CORE",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_kernel_utilization"
     },
-- 
2.51.0.rc1.167.g924127e9c0-goog


