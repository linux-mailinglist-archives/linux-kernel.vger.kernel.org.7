Return-Path: <linux-kernel+bounces-896202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E22C4FD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EACD3BE1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4DD364045;
	Tue, 11 Nov 2025 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eraNyMGr"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0077364025
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896168; cv=none; b=JuE+XMgkLvJfGwUhJvCboFnID6mQxZvXBThfhOhcxUlLgEOl5kozHCa3b5hwAojHrJqSppCOiLeRp0KIEbSm2U/+R3zJlQbGEkdqxnaSIHDty6hSJACaxwWrKrkNS6s39Cb+XPnLfoufyjHfat4YSmotLdVFzUHCDP14Ml8gPQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896168; c=relaxed/simple;
	bh=NQZLwrJVuAq7AnAGYojD2+FNeBDfMGlmTWdY5sb/Yxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=X/tSz0ZUkVJvjlpdlwAyL4VFdZDlkVTWigAeZFcLj2igKC9O8M8Oxx+w7XkFfTa1rBStdKxBCXfqWMydGE1WC4KPGEnMDsR3w/evuOtBqWX3oyH9APco4TGh4LpUuMweLCHgec9JFc2w7W22fq8LOCsjGyx8Qwi34mF44L3BOew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eraNyMGr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297e1cf9aedso4006565ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896166; x=1763500966; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Snl9m+Gsuclyili9Jia8BWYLwnDqexlNgmsV+/z8jHs=;
        b=eraNyMGrt0jENw4btjGXSMbizAoW25gXWknQzJG6jPMYYQlPobUxdtABZAKAEXe5QJ
         yc/11KgfPYvyccdAZl0jFcoTE0vrXM7QAE9Ln0pDRDHeYVjwYYxe7AXor9kZgPCWnG3N
         DktYLfVuBpnvEYDlmaLErrxJlvAA2nl6gHUS791C7G6vZHfKtjDsxg0pGov/lCfp/K9U
         ohjSQDcO9DdG2yoY4MuvPu3ruqL2Dls6giWHFtHzsNRxikyQaEAwkrnBvMJ+/3luG8kJ
         8h365ydZZHoLrLyRyy4dIp/7p8501ZR3ohfJ7kFpIiwPeq/dqNLq2rYmJ9FheJn+pDti
         QBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896166; x=1763500966;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Snl9m+Gsuclyili9Jia8BWYLwnDqexlNgmsV+/z8jHs=;
        b=l8NlDDHti8XBK7z44ypZX4Ik/W8E5DKIDRU//R/aexTsV5P+knVw+QJ1g6EZqISQkY
         8z/2bF6uGIco+oyhwIm+wicNETFbQtQQfZi/bnKkMcsTw6ViQoVlyYvxnJeqV9x1BHBW
         GoHkCFDP/E98yyywkbBjlwlL10BM3NaTlGzvlZr4qspMtt1uOWJJMwHDGF/TWZyz7Djn
         LYbuOsNZIUemY3ELjxpBJNZRzc8wAmBs2+GODuQBtMRK5iGi5/iDrx8xFCyU5FqKLZBN
         QBLseCXQKOfwk0gwO1kcZddixHeWPG8j1elxv8HCXwHTnTVAkZTr27QyCKKCHKN6qbyE
         o+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4dq2meQ0eYQeLxKFOvHJ4jMgVdQecLiQrqBT0Z3GVnIQzmZXiZhKOiHWwUYjmZlQ3d47BlfFf7sDWJBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD27HM5ckfQ3qdjDGdY92ZR+6L1hVtAm0lRxVRrUTXyUsBgzwN
	LVg9haZRb3bKGa69aFsu1T7GUk/RnrDt0yBaeQ/4qj7yazMRiNGjPTXr5gC8KRrIhu8scCoqVkZ
	4hU6q0NT4wA==
X-Google-Smtp-Source: AGHT+IHoLFxLBvDxnhRtcK5+Rq2f7KF34QNfZroRMzntkHhW+Yb+NDYSMCqhvav079UNNlqZGhM40LZpUquv
X-Received: from dlbvp3.prod.google.com ([2002:a05:7022:ff43:b0:11a:126f:ee80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d544:b0:297:fbff:fab8
 with SMTP id d9443c01a7336-2984ed35b15mr10303485ad.21.1762896166290; Tue, 11
 Nov 2025 13:22:46 -0800 (PST)
Date: Tue, 11 Nov 2025 13:22:03 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-16-irogers@google.com>
Subject: [PATCH v4 15/18] perf test stat: Update shadow test to use metrics
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
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
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
2.51.2.1041.gc1ab5b90ca-goog


