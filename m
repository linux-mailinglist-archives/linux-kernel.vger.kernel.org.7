Return-Path: <linux-kernel+bounces-889512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A75C3DCCE
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0410E1891BF2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C133596E0;
	Thu,  6 Nov 2025 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1NLcQ74E"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B68635A93C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470972; cv=none; b=ZE9NMKhs6LPUqKzT4MN0NYPY43ZtuEj4FC//klqxZYXyxtBBzmRX4sw0Z3kNthcC9j4Xd2n54Digcuw/MitkyKNVg8d7F5ABFde9DWenwsn+/IW8BP2o6uBRArv9VwbA3Z0m6GzunurvSbBSLJHrLvGNj6aoJ18ZCYfapLsmz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470972; c=relaxed/simple;
	bh=LLn9FDAlPcwSWZjUFvp9EB4XY1jJAmyC35CaM/eue2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MNEfsCC1V2C6L08zby1w3Y0c8+JUA4ieJHsPq7LzOpv7B7cGgdjjxSH/8EOGzNFNPn2MLilA4kl88Rxa1tVT4o+yasYXGlkcVlefJfqJPmuHFKaFHlMJv5Or2cYzgmnsWwRVJZuGAgU9UuNpkxQrkZ/YANJ0dXNWtPFdRVi5gxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1NLcQ74E; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297b355d33eso2093055ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470970; x=1763075770; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Et4hjqXaxJjcCbzTA1Cjej6Oy43GlvxgQk6XgvQSd0=;
        b=1NLcQ74EZgycn3kNOtoGOgJIIjzLWz/BF7TUsHn9xcXkoq7AzNkTY6Wng8zgvJTDph
         uVw4D7ZP2mhh3r5Z04VJ11X7mjfKTc+ZOv0EDwEXvmExAPKkvT0SZekY8BmrqxTRnhd3
         UT71wtsvrrmF7sWrHxT++6ILcNA4DP+auE6wUnO5GzZRqRiItMWQOuY66IEwrW/rew7z
         9shjHLeqJ616FO2goCvdQHQtJEGKe8yWDKbnjsdI2unpZABp6GsmaZ0eUuV2B+v5ciC0
         P5tPCgz4WU2yw58mJVdIkMI6Tap2cHmoepDwilC1qyD4c5GBaL8evrK0yqJMmes06XLv
         6Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470970; x=1763075770;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Et4hjqXaxJjcCbzTA1Cjej6Oy43GlvxgQk6XgvQSd0=;
        b=X0XBgoC0WzCSUxMYBZULNJGjTeWxUlplyRtPH2GYtc/MuqMl8lYoDjZJZsy01kLEbc
         HYTf3BmoJAkkmApmcgh94GbHClwqycD12bWxhVpbxp9KZuMOJYxvQt8IWQjBohJ0l4DR
         Do1d1mIWm0cAbGBvdy3H2EpzNsos8lLzyPbOaKFb6M1tmG02CPlXe7bTWfF6kQWQM4gd
         PwPtr9Nwre1dkCnw4zArRaAjWDadPUXzYazkat8/02mLDJwaWOHFIoPHWBUCLPd/KwWB
         Fht+QvL1Js/eQ+h8W6u1tC381b0QtTGZhMLiagQLoJJtOepdrIFGry0oDNzmQlz/68xh
         TieA==
X-Forwarded-Encrypted: i=1; AJvYcCXhC6Jkh8MKsG3dWjMWNR7XJ0r+Kqxj1zNm+OzQ58XD9fwrG8hgW2hs5I5ABhcybsrEFQ+C65MzWpf8ChE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5Kru7X2PbduHcTlMxHF2JwKOZWhiZgc5dKwG2X56nwIhujpS
	R9hxnar1DXqZTBli8QucOVS5hrmBB06NTG7reqJ0UpS5vo4sOVlrpKwmzxx3baGc1tj1ryT3w9t
	gthYNPtfM3g==
X-Google-Smtp-Source: AGHT+IFCzEWuu8E6wOVwBRXCBSsioiFshS7Q4FDnLNqnIcuUiZKmhlPwpMmYDVVdcfSiH6o8aL2K6ccpLJe+
X-Received: from dlbqs13.prod.google.com ([2002:a05:7023:d0d:b0:119:b185:ea75])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dacf:b0:27e:ee83:fc80
 with SMTP id d9443c01a7336-297c04aaa05mr14080615ad.57.1762470969776; Thu, 06
 Nov 2025 15:16:09 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:06 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-17-irogers@google.com>
Subject: [PATCH v2 16/18] perf test stat: Update test expectations and events
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

test_stat_record_report and test_stat_record_script used default
output which triggers a bug when sending metrics. As this isn't
relevant to the test switch to using named software events.

Update the match in test_hybrid as the cycles event is now cpu-cycles
to workaround potential ARM issues.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 8a100a7f2dc1..985adc02749e 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -18,7 +18,7 @@ test_default_stat() {
 
 test_stat_record_report() {
   echo "stat record and report test"
-  if ! perf stat record -o - true | perf stat report -i - 2>&1 | \
+  if ! perf stat record -e task-clock -o - true | perf stat report -i - 2>&1 | \
     grep -E -q "Performance counter stats for 'pipe':"
   then
     echo "stat record and report test [Failed]"
@@ -30,7 +30,7 @@ test_stat_record_report() {
 
 test_stat_record_script() {
   echo "stat record and script test"
-  if ! perf stat record -o - true | perf script -i - 2>&1 | \
+  if ! perf stat record -e task-clock -o - true | perf script -i - 2>&1 | \
     grep -E -q "CPU[[:space:]]+THREAD[[:space:]]+VAL[[:space:]]+ENA[[:space:]]+RUN[[:space:]]+TIME[[:space:]]+EVENT"
   then
     echo "stat record and script test [Failed]"
@@ -196,7 +196,7 @@ test_hybrid() {
   fi
 
   # Run default Perf stat
-  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/[uH]*|  cycles[:uH]*  " -c)
+  cycles_events=$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]*  " -c)
 
   # The expectation is that default output will have a cycles events on each
   # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
-- 
2.51.2.1041.gc1ab5b90ca-goog


