Return-Path: <linux-kernel+bounces-737559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FA2B0ADD5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7713B04C9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE5522F75E;
	Sat, 19 Jul 2025 03:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdnRu2/y"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6D225A24
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752896762; cv=none; b=rK1XmW1Invn5U+GLkseO2Tr1kBLrqOaHbv3x8ywe6q7EnbpYOeJrGAhUm0Pb8Zke9kO2b9MLes7x5PTX7zBCjIub8nlpd9PtZKJzX2btFuV2qEBXmQRx1Nl1m2spFzXvprLSTDB0ISiZ8HvbSQ5IdS7H6ix5uY5rY4IXSfB8q38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752896762; c=relaxed/simple;
	bh=BImgXBhe8gz9mi2Hr7xZg6e2yMMe4mk6zYrtyywYwVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=J7R0k94HU4BoAOrG6ONbgrLmBFt/4HL8/x89V5bm7qXdffsGHWuUaS2fHqLG/hSgk11Ie2e1cs5p6SDf8A6axRcWZ9hrgNZPxrZTeMJkxcEb7S9su+nbZAa0LT8YdxArU6oqLNu2ouRfvEeJbRzSG1ojwsoeCH074sEBpS4Xf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdnRu2/y; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3642ab4429so1922145a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752896756; x=1753501556; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwbCpczO77l0xiPSlOdCxGpiGz3+duVbPCBhW+nDRFA=;
        b=fdnRu2/yvmaNEHOLkuTzP9siuEjvZb5AVFv0766+GABeiFid7JGkuaL9obAeAFai95
         xeoe+5gxmrFbH/CwpikupZPR/igxVlJqIUn3vJUvrc4x8wvUy7npIrDZC7tG2Z32SPDd
         jBOrIpX2ZSK1YUn7smMyUBYmGSYPe7/ffN6faeloja2342QXlxac7CSVvWF0uNuZlIHo
         Xdy3XB3rkAbQ9Gg1QSVdp3P6e0eMcD1w6GwRkrXThOVI9I8Xuh54SMfvBCbfSffOQfvx
         vrZvLYR7qjK/zRXEzQpKRtFsf8eY8IgEYeF0yFTLWWM+478J2/+vXh3xAuwn18RqsxKS
         Qk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752896756; x=1753501556;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwbCpczO77l0xiPSlOdCxGpiGz3+duVbPCBhW+nDRFA=;
        b=M2g/90QNWLya1DxoKlEjaUpp+HqCkw8khf2TFfHqIKrMcRp4YvRjDYus8SzmQ0C0Ih
         PuWz7iLSEZRAXEZhkXD4SaHkZT9OYjA1zpXy/u7K0PU8nOv8u28DI57qDrVX4Cc7G2T3
         KFMlEqFm3xttco0xStMDPv6bB4Eg+rS1eUoFgV3cztUwCHKqRhe3ge13RxGEHVrDLq8k
         CQsaGkRCF10a2yuPaCTwHe1S9hDZ9VIvP3Ch6R/sb77rtJtYOnFZIqYjBLRRaoq/7MWy
         d6PjlMHARBQQFwIGhXdYc4nHRH+DrQAbBzXyogXjHTrkW427ZdDmsK2GmvyFaCIFWt4u
         lByQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO5YEQnswlPdArcbR/doIQykd1DMliBqQmcRq7dQzUc5RB7jr618goQnBrfdGCPqmxYkhkQfW+PBVUt7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmD5UfrBfNuhFIZ/yMaLYm9V/RQDOEXH6EdVMjPRGDRd8pvH3
	ghT8+GGUQfocTjrzaNqZSeMKAu9OxnD6evQkP6fJljOaVQW47LSIPq5tuKFAGfL4iHk0sLy5dQD
	uarIUOdZ2TA==
X-Google-Smtp-Source: AGHT+IG9zb3O4YDYA+FzRpT+cFBELwmC1bv45iR6dsLUNQDetbmplXcLS/ZYZ/XjTEEAd3LxKlhmIjMpuHwi
X-Received: from pjbnc8.prod.google.com ([2002:a17:90b:37c8:b0:312:26c4:236])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50ce:b0:312:f2ee:a895
 with SMTP id 98e67ed59e1d1-31c9f45b0abmr17336572a91.31.1752896756497; Fri, 18
 Jul 2025 20:45:56 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:45:13 -0700
In-Reply-To: <20250719034515.2000467-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719034515.2000467-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719034515.2000467-18-irogers@google.com>
Subject: [PATCH v1 17/19] perf vendor events: Update sierraforest metrics
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
2.50.0.727.gbf7dc18ff4-goog


