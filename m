Return-Path: <linux-kernel+bounces-774345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F81B2B131
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B801967407
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284EB3451C5;
	Mon, 18 Aug 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PtNZ7AZQ"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE9274B3E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543937; cv=none; b=ZsTOaVwv9jqKywFvqYIOjT58ANqPqYfKdZbED21WwAYk9BzxaRgP86MrjKpNFNpDqu3OUpTVNv18An555PTAIbiYyLeywSiVV4IIKHkhjWGlsFU0gpGdpatwkBqBSHBCRj4JxJvCJXCV6WqgH2ZLu0ob/xrOofarzsTEkRgTLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543937; c=relaxed/simple;
	bh=ww9Q0rfna78fAU99esFpam0P534jDoCqqbxjRdH29Iw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hBRNcg/w6qLn6LutGsDOYZh2rq2nHTwEDcd9LHdzEB/KW4X09tfSF2tjjDp1EQ5q35pRDGdgJW7t4CU43aE9sD8SZvhir9CgdJIjk86XLuYafGpU/hyuKmEX5pcnpEGVSFctZJ/uXzw7lV+TVSl0O7Wea0tctEZVIf3Ph1KMfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PtNZ7AZQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244582c20e7so50037145ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755543935; x=1756148735; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+eIk1qwwNZcnpEsHTorla2tdySVvzWiJvuj6iHcoNgg=;
        b=PtNZ7AZQA08cQMc606UdJ7G1UrbThVmCPfItUjfmU02W42yNG6O74ejAE29d/i2ATZ
         dA3ezw2MaW2MJkvEzuefbapQPf/lhqruIinNKPfF30Knb4xPhAoeBKC5LnvfbEWQVENr
         5lk1BSrytB6i5H2lS2C3Da7tIXuX5fb9QXe0dzsS71jOw0CfqptuT88M/h1qWg9MWZNw
         upLsTHJkw2rMMK/OMFL8JInSD3qFNfgB1B9rRZW0DilqE4gWiJ48jVCsqzidSLeSWnnt
         HVDzxHoEbo1uFtw2wQ5kUfydmSmJqB6KAj31c1BAFU7fy6agvVFSMXhIjohtlTdzI6o+
         B3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543935; x=1756148735;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+eIk1qwwNZcnpEsHTorla2tdySVvzWiJvuj6iHcoNgg=;
        b=sBCZBx5AQMKxX4Jab1zVqXIJXkjsVDBtUBnyF2UPGA6LHCN7MmIee3S0y/L2U7CkMa
         bqk5BrXIciLH10y2FzhFDb8oCgBucWf/pUjjsev88i1iCSOSXQhys5aAfeV3Dh1CqkgZ
         7yy8G6TU4t6Y/IUL+hENPYeKD9kHKBkISmAF9rMc71nigRktRY/34HmAB03jeNTFJOPr
         EV74e2lGbftUEsWPHFE+1eiHC1s15Wd/uXldkzrxkSeX48ezOb67tVNAp2IOqK7AAbeq
         KIQHC5DrqK0yvFTwoCtvu17HqHg7W4sVCITOlUbUWVz2D5+92kbGUknLh9YzjFXF3FUe
         SKYg==
X-Forwarded-Encrypted: i=1; AJvYcCV3vE/0F9WZ9KNrsYlu1AU2BZywx1QBI6p5TyHpY+FozYeklGM11pOpp/EKFyV9ndDhOzg9yjVF/NhzGok=@vger.kernel.org
X-Gm-Message-State: AOJu0YySJwWn52WLuFOxcD0Fg6TWQb+igJ1uHpH4boF618sqKouiqFtX
	jXIMApJjYEVL/g1cAtsgdBE+Gq7BlhRBOD8RvJXABWbhjuhfknuOUrA9WPm2/C2T0HXv7gYvTcB
	pPhApXvbCTQ==
X-Google-Smtp-Source: AGHT+IGbDCrtn11FI9qIqnMtpYaF1f2zJGkcokKTjC6Dy8WTN9il8adARJvIz66InwVw1948BwzUwWlb6YDq
X-Received: from pjc7.prod.google.com ([2002:a17:90b:2f47:b0:313:274d:3007])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec81:b0:242:460f:e4a2
 with SMTP id d9443c01a7336-2449cf4ebb0mr5922215ad.23.1755543934649; Mon, 18
 Aug 2025 12:05:34 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:04:03 -0700
In-Reply-To: <20250818190416.145274-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818190416.145274-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818190416.145274-8-irogers@google.com>
Subject: [PATCH v2 07/20] perf vendor events: Update grandridge metrics
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
 .../arch/x86/grandridge/grr-metrics.json      | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json b/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
index 878b1caf12de..a0d637a24c1b 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
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
@@ -633,7 +633,7 @@
     },
     {
         "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricName": "tma_info_system_cpu_utilization"
     },
     {
@@ -645,7 +645,7 @@
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


