Return-Path: <linux-kernel+bounces-869335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776C7C07A08
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A67D1C818CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746E234D933;
	Fri, 24 Oct 2025 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/mN+PzK"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B034CFD9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328779; cv=none; b=ItlhVtBh9E1QyUKOtAb4P6+l5HxgzP+cnEoGmaLnnU/zPrhXG5ALOJFEuSkRfT78tciJ5WqCAxmnq87mnn21XAXwtBFvRoMzxvzg0qCO3h5eZw53hMpoGnQMXwEmi94wCommO5ORPYxTHs08JkBGhSlTLURBl4XoHI+BMM9mNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328779; c=relaxed/simple;
	bh=EMIWmYJk4oxcW+eMiucvxkG58MQPnGfjcYpNvnxtnSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SkL4eWvIwYKSfBkOq97uL7O4V7rFtrh05OmLPMI8JKmTaGV6yhPeKQQbYNJA3d5X+yg7ktoyNPK9k3shaIDAsQs5kNbj2aKs2BlH/ik8Lbw9phyiPZLFW/YUIAMlPf8nsWIUaqeRpJMByCK1dUO83+d39F5ajE1uh31aftg4tGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o/mN+PzK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33c6140336eso4646872a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328778; x=1761933578; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=525kLDCVrY5SIxBE3vSN6xCvavPC8e8IS2zf2hpQNrs=;
        b=o/mN+PzKPGvM8722WDK191XTJSxNdNxMt8lnEZzNjCaPB64/ATLo8uBvha0Ia8CCqg
         0/Z09t8J53U0NUotaXvDeD0XUrElwolyeTzsyNbDBWxIQOdeNcoy8x99bk1jShuI6ZRS
         FscfaoH6YZYtsRK0sf2barSmu5mVMM3V6nTWg11a59Y5twH2jTNoad10vYJnB3q/uOE+
         uPHqQhYxOdLiWtP+k4KCamdVggtVWNLjipAncVZ+VHJflKy5MuzWW6YtklDPt+YO7YfC
         4qZETNpSDVvu1kKMEUbd+CDD10q3BU+9I9PkzdH37IAjr1M51jCqkJZj6N0bx+qD+ih6
         wMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328778; x=1761933578;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=525kLDCVrY5SIxBE3vSN6xCvavPC8e8IS2zf2hpQNrs=;
        b=OXWdUzy2e8IdzY/FrpDclpDB35qiEzjldC5EdQDbkFaBkylUG/zcAMJmu2wK4o1T3/
         vWYQf0EsmLQfV+0Vq2uEUqtTOeAtZdyK3q6nS1LEdzqeV987RA+xWqE7idHHca5xEIJn
         eaw0EfASe9CCyWrsLQabbxcF0hISVRxLYfGLZbG1FmDt8d6A9QAefRHBbn/NTt/d63kL
         41+FCo770Q5kwCXFV8O9F96YX8eoQZkE2I582g6aQ9z4QZr6hpYTyCK/FliojbU8YRKR
         LVZekfqHqivirTEG1uG7Y0LLCb1ZUq6X4w/Vhcgf4GSQcSgyLT3qgyJ4q4vq5Ks02c2L
         Wxqg==
X-Forwarded-Encrypted: i=1; AJvYcCUkxnumxXbDl8Y0+1CiK9G2JxsKp4+dI8KppXFpKe9lVVNaf8dah7/MxRe3h1sF+uIe7Suv/6fjZfFqSLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhTTu8Fu82yLad7t9SxBEc5Ls26EYlMY3YPIc47sKOQIT8pOOH
	xzNnLQho2cVY8yC4OHua7pRrwabF7RTzg9/s081MWQlneFBCTl7ENKkFcYASeRaZP5UrSzXGnsl
	gABKMCBcWmQ==
X-Google-Smtp-Source: AGHT+IHVz7Q7RAEZzhshyfJcovdGc3s06xzAx0puc4rSHrN8CtieQtGcdRPJE/r2iwPYmz/WJ6vmtqApfEDm
X-Received: from pjot4.prod.google.com ([2002:a17:90a:9504:b0:33b:c327:1273])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a46:b0:335:28e3:81cd
 with SMTP id 98e67ed59e1d1-33fd65ed34emr3787766a91.18.1761328777584; Fri, 24
 Oct 2025 10:59:37 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:52 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-18-irogers@google.com>
Subject: [PATCH v1 17/22] perf test stat: Ignore failures in Default[234] metricgroups
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

The Default[234] metric groups may contain unsupported legacy
events. Allow those metric groups to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metricgroups.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index c6d61a4ac3e7..1400880ec01f 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -37,6 +37,9 @@ do
       then
         err=2 # Skip
       fi
+    elif [[ "$m" == @(Default2|Default3|Default4) ]]
+    then
+      echo "Ignoring failures in $m that may contain unsupported legacy events"
     else
       echo "Metric group $m failed"
       echo $result
-- 
2.51.1.821.gb6fe4d2222-goog


