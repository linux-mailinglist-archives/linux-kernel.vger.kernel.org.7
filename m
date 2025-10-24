Return-Path: <linux-kernel+bounces-869338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 998CDC07A05
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD69D5062EC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AEF34EEF8;
	Fri, 24 Oct 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgVwxfOU"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262634E750
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328786; cv=none; b=ZfBXamIDOQzJqOxPDkM5tYaqsxyIorp1afNgzjCGHGTIORNQJe+ag91e2gnDmtUxiIQMqDW5WWD7gdiwWHYQsgHs8L8w2T7WUOEGQarPYgPrz6Z7kUpYCUIThvfW5cwOq67k75zwzBCdY4AxLpkozBGUjrpYYX+kvUSx3vn4GW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328786; c=relaxed/simple;
	bh=a5JGvMLFyprG6QfL5XnHpkM6fv0A27tSZN8uL+4ANfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WHRg4QFBvy7gKv5TFbVZeKUevyFdPJXl+Eqp3tzT5lQ/F2NGrSqB7acLbTkaNNLlZ9CrsyUzQP9aTh/K+tATQvIJrfDGa8U/5FmOA2ZbKhocR1XHZlRpwtPTFlkqOpEKoCzsMkBfmLH3RRcoSxgMT/taSNqiZpVVzif7tJtXBuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgVwxfOU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bcb779733so2124745a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328784; x=1761933584; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6yI70voK5e+ZzNgu0TYVzbazqhONpuqvIFoYlpIFjbk=;
        b=dgVwxfOU1JIuSrHesNEoYUsn8NO3yM5d5+JQVB36Cu7704m/DIhVMioSnScuiYyZxZ
         IFQO4s8Y5xaNufwJpK0E152xmIx3Auv8pUE9Nx+M6V6BGOwNj4LdkVlVxkO+38tRc48P
         nccHvgopjr4wFY/5VWLqoHNylgm5YbaJUZ0LKkep8DJGwR1Mh5IPcyyIUWa3zVHfIBmG
         h2BxdzyRanKYMhno+YCBDtaRQQEMy/+WYINYD/mpaGA6nhRMl0IAD7nlkG47VDxbslGC
         6yVpdnH6qTHnNS74m+ur/yurQUqgdlYtb6y9CvqvkxT5SlYltDatRDXJ0D2wvCrZ3IWL
         RO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328784; x=1761933584;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yI70voK5e+ZzNgu0TYVzbazqhONpuqvIFoYlpIFjbk=;
        b=nrpswh5xMTRfmOs0ZL6ld9XxSHQiVcIkhv7ZoSEaXGL7YDO/7G81sv8978cRHAV+Lm
         AAC9I7elkaY2QoG/fthn+rO3QWPwjoLzLTNIAEUi7Azd2IIRU/qWBwCBF0mY7ofBK+7v
         Jrk2xkJfQaVIG6J7DNQalN9Mcejn8n21WDpqP888bCgkyXQyrZ+7YzwwX/BcChmTVRTl
         Ksj5IWRzAgvgsZrVsCii+Y2xSDb6oyjY9fIWfZDLqTZ3h0Tygt2ZeZByoBny8UDiXtkV
         vkPbg6XE/Q3fWwQA5QvrFokNZ/2pZ/ZRkbgah8V3kxxnfb5q/E2TObwwhMXc2oRJl/1w
         p7bg==
X-Forwarded-Encrypted: i=1; AJvYcCUu9Q3mHqhdKtvGwwiEJ59K7nTXbSnpKPbp0Xd36Y49U3EL5VrECKGN7IL6cQ7bfGmbvVTRVcd/A02BsD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZC4IgW8ge/wl/2M6HByz26RtinmySRlTbj0/tEyRxmLCHVJJ
	BtzJCYDxvdLTvYiS+bmRUx5wjC5H0WnJVQVbhWzk5oOOZkghYrbvO2uwDIoiokQmGye75Eh1NR5
	6o7y1GxJr0A==
X-Google-Smtp-Source: AGHT+IG02mHYSHgon5GJSvJvSSO7TIhhkQ06xdgDu0aLXCVNpp4zfSMQGEXZc46bfivjxQnjSY9hFD96bbum
X-Received: from pjblm10.prod.google.com ([2002:a17:90b:334a:b0:33d:ee1f:6fb7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c4:b0:327:c0c6:8829
 with SMTP id 98e67ed59e1d1-33bcf8e4f50mr37235277a91.24.1761328784087; Fri, 24
 Oct 2025 10:59:44 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:55 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-21-irogers@google.com>
Subject: [PATCH v1 20/22] perf test stat: Update shadow test to use metrics
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

Previously '-e cycles,instructions' would implicitly create an IPC
metric. This now has to be explicit with '-M insn_per_cycle'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+shadow_stat.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
index 8824f445d343..cabbbf17c662 100755
--- a/tools/perf/tests/shell/stat+shadow_stat.sh
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -14,7 +14,7 @@ perf stat -a -e cycles sleep 1 2>&1 | grep -e cpu_core && exit 2
 
 test_global_aggr()
 {
-	perf stat -a --no-big-num -e cycles,instructions sleep 1  2>&1 | \
+	perf stat -a --no-big-num -M insn_per_cycle sleep 1  2>&1 | \
 	grep -e cycles -e instructions | \
 	while read num evt _ ipc rest
 	do
@@ -53,7 +53,7 @@ test_global_aggr()
 
 test_no_aggr()
 {
-	perf stat -a -A --no-big-num -e cycles,instructions sleep 1  2>&1 | \
+	perf stat -a -A --no-big-num -M insn_per_cycle sleep 1  2>&1 | \
 	grep ^CPU | \
 	while read cpu num evt _ ipc rest
 	do
-- 
2.51.1.821.gb6fe4d2222-goog


