Return-Path: <linux-kernel+bounces-737553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA60B0ADCF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A0A3B5822
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C942264AA;
	Sat, 19 Jul 2025 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmFjf0Qi"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CD221F26
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752896750; cv=none; b=W5rT7xJqyaiclEjRbt/owT2QNfz/j51JxRvBvEqisImtd4aym40/l6VnUmSpxTJYXdVDY47i+/QwKiC+V3trybTkmn1bQCU39ArG7YoFsQEgZ1Yj0VReukQNfHLPE3w0e8LrQVcOSpJpVoFY+OMjxoqIoApzDYpB6n1FTBxd5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752896750; c=relaxed/simple;
	bh=/8ru69dmq9Cq2iRfp0MBXeJovmB8oB+19cJs9x6jK08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iO4I2pI2c7IJ1nPEr+NWYJT+hzmTtZKdMc1ScOpIsJz+OHE5hLXCAbFlUG6oS1D4k9YgnPU6MAOPJqnjAowqV29kI3SAPDHVlfFHHnXiN28TdRh0Boi9cBwcNct0MCxhlgqpSXtWh2eMZ2P118QoVMSGsUvytyiRUMW/48SfHJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kmFjf0Qi; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-234f1acc707so25853755ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752896746; x=1753501546; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ahStHSrVpuKQhFyGWBebgfTyDgnCYq3IKD5gtRO66co=;
        b=kmFjf0Qirtq0hFyIEtNdmGZtdxBnI8RU3PjQxJToq6//QskipRna8C3kpMBbcyyOF0
         f7bdlZdTbmO7mYS9DVYmCJT+DGVJOU3dIafMp434UjLHlPBcGxK0+tRZLoPl6SvrGuVJ
         ddlGEOX/wy2pBj+sKszTlrYEYStdRWbWWDba5h5lk4kTAsSBpBe3P6ZQwPhEC4Pt99Z3
         iYhp/K9/6QOsd5PHutx/g2/kileXq94DNme64gnBU0I+4SBEjHu+gQTQ63gQ6rj/UKII
         gJXXNUJd5jyA/gnh7NWnqRwtFv8E+RebYzb0PqdhIVx9be5XF2yfNj+kLr+qHxgi5rg0
         54tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752896746; x=1753501546;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahStHSrVpuKQhFyGWBebgfTyDgnCYq3IKD5gtRO66co=;
        b=iomPhmvwpf3tnBJCVi8R9wWKwVZ6+xqf5gr8x0BMeNtoWhCLCjuofp5Cm7D2c+xtCg
         EyCyY4BRAKYikKN1EMz+QF7yZFFJamQjTNK4W1lZsCz9tJM1lSSE/c0IfEWkPAxxABWu
         YOuQ47f5rT3cZUUQ9phu3mVQ3qiupFQREpqBoTRkGE8X55yt3yol8X3FSi4py89S9Alb
         BwBlAddQQBELQM7RbMKpk/2sAPtggRqUyumKgh0iuVBRZ/aP9M8SQs29YHEp6Rf6FvKl
         RqMh2vV9DbbBf1v2ptGGU3SIbBWQFau2AdrvwOSJipKD+CmOAAp+wBHUWfODSSLKfJyn
         Ac8w==
X-Forwarded-Encrypted: i=1; AJvYcCUEpV6hF0UVkuWMkCM82o61aQKxqlPcpjiSgHHGEnGptJdfhRl2hDXesc5X9XSXkcpSydhv55GUGVoI0D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVtSxweIT6B2F4y8szIKaOJB/4PFr/HS3HOQ9uXjIQgDT5ACoX
	mNUXTOIVVq/dwEMPViqKH5HQW3lwsHwkLYBfXosXU4VRZcBNHSJDWu6qslBprzEyZeZ01PztC/m
	nTHNvEtHZdQ==
X-Google-Smtp-Source: AGHT+IGv0sffouYqm1gOpRs6Jr1vqe1c28k9q/lC5/fr4WrVy4M79yj4O+gHrSlforNmYAwEPqNVcHwwUXyz
X-Received: from pjbsj2.prod.google.com ([2002:a17:90b:2d82:b0:31c:15c8:4c80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48f:b0:234:a734:4ab1
 with SMTP id d9443c01a7336-23e2566b004mr175340085ad.3.1752896745919; Fri, 18
 Jul 2025 20:45:45 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:45:07 -0700
In-Reply-To: <20250719034515.2000467-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719034515.2000467-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719034515.2000467-12-irogers@google.com>
Subject: [PATCH v1 11/19] perf vendor events: Update jaketown metrics
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
 .../arch/x86/jaketown/jkt-metrics.json        | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index 6f636ea0f216..250c73b21385 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
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
@@ -348,6 +347,7 @@
     },
     {
         "BriefDescription": "Average number of parallel data read requests to external memory",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=0x182@ / UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=0x182\\,thresh\\=1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
-- 
2.50.0.727.gbf7dc18ff4-goog


