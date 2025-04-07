Return-Path: <linux-kernel+bounces-592637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FF8A7EF9D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 23:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DF81894C09
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 21:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEAA25485C;
	Mon,  7 Apr 2025 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7u+bNNu"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA22222D4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060233; cv=none; b=g+zkTR1ToHwAIZggVzgkv79nqBffQOocmB8IHg6Xlm6PbAaIBb/O46H3nQjPfc1POorrGAhwZBcIhwubzkIHIn8ciTU9ME3ssNb0Z+HldKAWz3jjCseQjg7iz59Ai8w8l19mErocMT7unct1hZvOqdyudQeYTrvP9e0GfpkBp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060233; c=relaxed/simple;
	bh=uzrqNAXM/KeEjp8qWr6xTf3VLWW7e0MNaK/cvBjUNjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=frueuE+Qt2SVhRDCd03wiwBRgOMTXMBD42zFye/UtAP0sEaK/LtSlZOrFQw/vj/NvBd2rK0hJcISLfBpjeMXKYInEkQPayeUqdSvcnlMKb+SXsatH7xFRMmb3dJy0YnpFvQahlHw9cWBzz4dENgt/J0io5vwZcfkJo+XTJa8pBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7u+bNNu; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af9b25da540so3169859a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744060231; x=1744665031; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqf5UWKI2N4Og32+0x3lkK0y6IoadYAF1NX3nVy0tDA=;
        b=S7u+bNNus/tPoNXhTSKRhC+Sewg5Y/tYbsTzKD/8IQI1lI7yZwC7ulFuQwGpLYRKqC
         hmjabGSyIrBNeyVH+iYBpGvwzvXC7wOc1KAvmSCIPxHd9Nnx/P7xL0hug9fUCYAww2oW
         fjUpuGwD/seQJNtaUsvayoXvntCRIKsjbW5itS6v9aG3FpXzBkK7uGcp5EdSUqctJ2Vg
         r71lKvWDmmArpj2x77X9qTCPx4jLjrYXn+lr02qm9twz5KwUsyxn1tftoEYFCEUjHWtc
         ek/PrrU3FknCmLBxMO1hhmkNxLCS+LldEsWo0EIORwEoEW46RsAg9HnJDontq4v7EMmf
         M0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060231; x=1744665031;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqf5UWKI2N4Og32+0x3lkK0y6IoadYAF1NX3nVy0tDA=;
        b=uvznW2045vfmeUcU9QbcCo6fdrfkK9Cuzu9SbqRA8/Su+pqdzPfZZiTCh32kYo5+nf
         6qLIWTA5XKYVB7AyDqJfp1/kcCXU853z6RnbLMiHKKiN5BSCV2BBT+HL10XYxb9JsQ6d
         kDGIPL0QmGZ1QdWp2Btc1HicHlZbizsGXZeOEvEHz12k7cKTE9gFKtZ88wvbjda7Eevc
         AyyZAuV4zRJhfjmhjHij+h+KHDkvZeRGz4h6BXwbbRueWzIBwxyhIOiLtLTIGqzZ5q2p
         hLUwz58gc/D4YaVdJrYjX/ldRbbRyECfAtFh/ECrV9ysc0RrLicWL1oyAnxygt5Ff8zf
         ZKgA==
X-Forwarded-Encrypted: i=1; AJvYcCVdoFBXBstJzX8HMlbpx6i8V3FJO1PEpY3B0r4nbozuWmWkQa34XUrWdZUZ8sGfzChyho8EuTzEdVMfEqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhsOS6E3n+xF/I+vBhODGfqZlazOWHnYVLn2JhjJqSeSinX28w
	+JPrC3DHtvF+t462SNIgAhXwNzA/gKWLYJuCG8zan7+mGojQaXF13FPc5Q71zjCqrjD8dxn62uK
	IC4ANdA==
X-Google-Smtp-Source: AGHT+IG2k9E2FGZOV6UOH2nAXBeyLI9TdPuQtWFKKCrGUOPFaJAXJTcOzcwDaP2Hq/2jrPZ9jTd9BB9ksEtQ
X-Received: from pjd8.prod.google.com ([2002:a17:90b:54c8:b0:2e9:ee22:8881])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2398:b0:306:b6f7:58ba
 with SMTP id 98e67ed59e1d1-306b6f75902mr6667474a91.6.1744060231030; Mon, 07
 Apr 2025 14:10:31 -0700 (PDT)
Date: Mon,  7 Apr 2025 14:09:27 -0700
In-Reply-To: <20250407210937.131681-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407210937.131681-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407210937.131681-7-irogers@google.com>
Subject: [PATCH v3 06/16] perf intel-tpebs: Reduce scope of tpebs_events_size
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Moved to record argument computation rather than being global.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 2b04deaf66ff..e3bed86145b9 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -29,7 +29,6 @@
 #define PERF_DATA		"-"
 
 bool tpebs_recording;
-static size_t tpebs_event_size;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
@@ -86,15 +85,20 @@ static int get_perf_record_args(const char **record_argv, char buf[],
 static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
 {
 	const char **record_argv;
+	size_t tpebs_event_size = 0;
 	int ret;
 	char buf[32];
 	char cpumap_buf[50];
+	struct tpebs_retire_lat *t;
 
 	cpu_map__snprint(evsel->evlist->core.user_requested_cpus, cpumap_buf,
 			 sizeof(cpumap_buf));
 
 	scnprintf(buf, sizeof(buf), "--control=fd:%d,%d", control_fd[0], ack_fd[1]);
 
+	list_for_each_entry(t, &tpebs_results, nd)
+		tpebs_event_size++;
+
 	record_argv = calloc(12 + 2 * tpebs_event_size, sizeof(char *));
 	if (!record_argv)
 		return -ENOMEM;
@@ -226,7 +230,6 @@ static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
 		return NULL;
 	}
 	list_add_tail(&result->nd, &tpebs_results);
-	tpebs_event_size++;
 	return result;
 }
 
@@ -289,7 +292,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 	if (ret)
 		return ret;
 
-	if (tpebs_event_size > 0) {
+	if (!list_empty(&tpebs_results)) {
 		struct pollfd pollfd = { .events = POLLIN, };
 		int control_fd[2], ack_fd[2], len;
 		char ack_buf[8];
-- 
2.49.0.504.g3bcea36a83-goog


