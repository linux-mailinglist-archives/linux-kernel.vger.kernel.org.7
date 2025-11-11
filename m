Return-Path: <linux-kernel+bounces-894616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D33C4B69F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1FA74F39F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070A434DCF9;
	Tue, 11 Nov 2025 04:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xbx1Ui41"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23434DB72
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833898; cv=none; b=uEMY1jzuUWxZXoxuCz2xvJ/xCBBEtBUKZ76NuZMDXdd9cP+brS01PSjfvQ1GJQa5wGA4SuNEqQLVLGTG9fPolRvajDb3ufzuRcNgf17cq8ySHwhvkJAtcCk/RnWWE2apKZ1LPm9ROsoNwZ2U3dESeZzkgtirrdpghf3w/u/3m1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833898; c=relaxed/simple;
	bh=LLn9FDAlPcwSWZjUFvp9EB4XY1jJAmyC35CaM/eue2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=a7WfztanP8d8naEce28vEoaGsJ8v4HueFyaKa3O5orQcis3C3UVuvYeeJtYuQYM/WEQ/qxsv/fwJPOvPZzvkEnacvT8upOZLqpqGeB/CbRViSgIx4wmKX7sjMshADblJe+IQHIhDvbogxzbjvoHdBzPnp6pZ8sfabs/rqeZlRH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xbx1Ui41; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso2820321a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833896; x=1763438696; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Et4hjqXaxJjcCbzTA1Cjej6Oy43GlvxgQk6XgvQSd0=;
        b=Xbx1Ui41dRNN7nunAER/3qwKYd9Z8U9S5EE6pnP2LTyMEkYcn4Wx7uOZsHWu3J7Suh
         GYr/OcWmoId7WFFP9qbbDMT/hAZHZ1IGf5D77dOkzasaLTXRPgb2BCUWHn98xomb3yY5
         UI02dJBU6I8ogRxKdosCaZ/D5P5dhNR5og8IwnjJG6fR96KEzPWVECq1C39ifrgVzfOr
         SX6DcozH1YLuTNnly4wX4FpnDUZpoh6Byqh64jQUllmUpkFdf0OcYkomCUvp8A0ratIR
         g4EzObhm0BcHI74DDixZ4uZbtanutLch8r3zx848u/SwtR1jcZN9htCoYPUhQ6ajDXDQ
         07mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833896; x=1763438696;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Et4hjqXaxJjcCbzTA1Cjej6Oy43GlvxgQk6XgvQSd0=;
        b=VA3mogfRUNXO0SOUMpEVRmZizU8PLDaTght/jE3dKZrJaL7s25Hgy+4dJvPJXNi6aN
         f8jk//v1OjWRWVY1K5tLVNlpjCA8waaPsq57Lgly8IsT4KTqutPbCgeTCcIeBFT6W7xU
         xYhsF1t52gahQ75+vgQysdkJBlrNe1dLNbB/QMqnNuv2fKwBIEKLXLZyX4d6hr/QygzG
         w6s7aKrI8CsROKAW6BJbt6TTQv2lxFp3H0fwT3Zcfgb6+8AvZZOz0xZUfvzAboDsz898
         jCK8ZqcKYB7HbBi4l/UoyCObcdSe9QYEcr5saLsoeSmI5FQYtv/NFtSr+ZxlyfxBSIE7
         LzXw==
X-Forwarded-Encrypted: i=1; AJvYcCXBJrFKNkCt1/Cu2a85wHyhpL5oCf0L/9uvjZM1NCnof6JEFSoJ0m6EYU6CVxS3SaboEfmP5VdeDlhGsU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKUM6NNTFBLxCEatFmSYBLdPPpXPNtbV6M+VKSlXqnK8ZDbDSe
	F73oVfYQ1u5V/jGAuCs3zXYIdYZIE6divv5LkE+w5+qGlTxzVUYD/bRRw8SodBTUaAuB/e7My+l
	m98UAgCN+Pw==
X-Google-Smtp-Source: AGHT+IGn0tBeyvmCXlP0g5sTiUGrIOYaiPwsUS9X8uiEM3cJe2lhyUnPrjTMn+mtiKy1m8WpFhJu4/X5j5P7
X-Received: from dlbbo21.prod.google.com ([2002:a05:7022:4395:b0:119:78ff:fe16])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aad:b0:295:615d:f1d2
 with SMTP id d9443c01a7336-297e56ca36emr130639925ad.48.1762833895913; Mon, 10
 Nov 2025 20:04:55 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:15 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-17-irogers@google.com>
Subject: [PATCH v3 16/18] perf test stat: Update test expectations and events
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


