Return-Path: <linux-kernel+bounces-869336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4972C07A18
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206563BB61F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BAD34DB43;
	Fri, 24 Oct 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U23tK7Go"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681634D4E6
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328782; cv=none; b=ZFVTi1UcwgG6c9bYLbZ5sYDYfxk0saZzuFslveHUrXFa+4zRhWdmUbhqW1q2YyFsPSCkL2Ekp80ke+HtftesBK4kke13usDz1QJwsbmQz/0s6F+0AZsSU9m/5pmUXnGlktXTGP6SFMDgUrN6q0OiAnR6wbP2Uhg2ZN5HxNch8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328782; c=relaxed/simple;
	bh=QELkFwUGTrOe0PQw9hkeWCvVtxDO/AoGHdfdb3+Umqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KGdeyvyAng4C2H5usFV16Q7VeIuMR8/Dec3TokN3GMmIvd/9+9qSBtYcT46KPHUHmKu9lgDHpqkFEIu++iOVPP4U5tXbVCK86zc5iAqmL9c2lh7+PegDvSsAM7ZTgnH7kqtk2F1zDp8W8q413FTH1TfCfYg5Puio6iL2PZ8zkR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U23tK7Go; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-785ebbc739bso914647b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328780; x=1761933580; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvP50ZzYw5FWwn1UAQP69vx00l96i82LZhtWn6tukw0=;
        b=U23tK7GoUqMqBQbCORgqs06JHjNCHyc602oXvaetOcUfz7BFqA3kr/A0oUgdHMQpfL
         Z0L9dI1sZn1Ro+WfRt5tPzP76GLLuQLnjbPBt8UpEJEhr8Uf/Y7DHE4pB0baV4EglVL+
         CllJa7DiYkoY5LOg63HMimEIg8JQ3pPn0FSmwN0XikfgdqJZokliWeBiu/ZH1yB4zK97
         srZUSIEjJJNvhNcAm9bSyLtYWNL4zVMliVCWr4CT/51gzWgSoZjP0ub6wBuXgkdLKGEK
         QfO3yiRooymhAQhxAT26/bZoh8lrZtg5urS6BMCXWHd3hBN1Ug9D3Cy8sJjdPMqqwSNG
         tL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328780; x=1761933580;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvP50ZzYw5FWwn1UAQP69vx00l96i82LZhtWn6tukw0=;
        b=IzKgYOWdpyxGCjo2RLFeRmJARcdIEaxtj393n2hH82XgRqJtd7EJL29q1A+rzw4hdN
         5ytPMfOWagA64gLE4Tjcq7yo5jVxJ+VC8uHiBUPomiODfir+Cef6Ndr4sStVUurs1E++
         FAmPG6XwcNAk1j+IKA985LonEnO6pwaloE3NCsO5gKa6/3scaYSIovbjYG3QUOfTmhMd
         w/p3G3xKVsBwF0SdB6lIZQDcypq1kmGEYVOGR5MSnOv2hhomO5bA9dHSEDurIXebXfPt
         bIkojZQPh1+bZ5d/B168Om5EHGnGt0Lo+g9cUDBipFmXVa5H7wtXq36bgvAyLCF8NIRQ
         Lxeg==
X-Forwarded-Encrypted: i=1; AJvYcCVMG8i+gHj5o+s/xG0S/F8TGnaX7lH4tuXUnjYwmsvrgwPrbVi95apT12YWCJF7H4kKedQJFEh7atj1C6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYckWBKk5bl5QQ6t9MgOmMFSM/Roatvm352ld5Xm/QFvVdSdOz
	VPWa7tVhg8RSryTT3eCd/yWnjg5O/JQVmQFwEW6mJKE/295e9tXWGWRmsvcVB0U2x5V31FWf7HH
	FwqolO3+Q0A==
X-Google-Smtp-Source: AGHT+IGEcXvK1E6p1QN6VWO2jx68qSIOrMuAi/BiYCBb8KUHtua6fwqyhsNuspKqCPBH8gZ6xgZ9uefHpOM2
X-Received: from ywbci17.prod.google.com ([2002:a05:690c:a91:b0:784:a970:1a17])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:f93:b0:784:8ed9:e362
 with SMTP id 00721157ae682-7848ed9e887mr172832517b3.40.1761328779968; Fri, 24
 Oct 2025 10:59:39 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:53 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-19-irogers@google.com>
Subject: [PATCH v1 18/22] perf test stat: Update std_output testing metric expectations
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

Make the expectations match json metrics rather than the previous hard
coded ones.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index ec41f24299d9..9c4b92ecf448 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -12,8 +12,8 @@ set -e
 stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
 
 event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
-event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
-skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound" "TopdownL1" "percent of slots")
+event_metric=("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/sec" "faults/sec" "frontend_cycles_idle" "backend_cycles_idle" "GHz" "insn_per_cycle" "/sec" "branch_miss_rate")
+skip_metric=("tma_" "TopdownL1")
 
 cleanup() {
   rm -f "${stat_output}"
-- 
2.51.1.821.gb6fe4d2222-goog


