Return-Path: <linux-kernel+bounces-894615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7ABC4B6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3194E3ADF1A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7F34DCC6;
	Tue, 11 Nov 2025 04:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P63sEqHM"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D1034DB61
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833896; cv=none; b=hG2C+crLFkGBiNZ7FPn2uogQKW6FyN1Rbq0JxGGL9UA700mbnSj685AKyZlNpwriMDX59/2EcAH51hph0E5a/u9X/lPJHpZU1DWpgnqyqLcTv5D1YZfVkTuTZ2Mo5L+Dt68VmLwmPacyP13gxQi2n1gvsDss5u6JoZOXdrKULPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833896; c=relaxed/simple;
	bh=NQZLwrJVuAq7AnAGYojD2+FNeBDfMGlmTWdY5sb/Yxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lw8KNctladV+b3He8SogjsaUpVdT39Hd78PvZVRf2rdNjOkfl5pQPlehZPsQ4/pwH68I03dIvpcxWWv1Oq9tFnyCGbbxA9Ft4k1z0Zcw5wFc21KREXOF9ziTq/SB7sgKD8VDY0Jw27EghN8syyBaJVdIKEl5H09crx6hB1Vv8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P63sEqHM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297fbfb4e53so37555405ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833894; x=1763438694; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Snl9m+Gsuclyili9Jia8BWYLwnDqexlNgmsV+/z8jHs=;
        b=P63sEqHMw9XlacbDKf6mDPgjU7FsXKY9lblmrMyPGFAvEmNTRtXHFPO5SD/7sk0BkU
         0cX957J2IXAnu570ernOIDDo9OABskxWXiIe79UJ2rCYvmVIw55eqGONTlLVsLrn407b
         1nV2F3cGo6umTrY9QgLdXbqOXf6FOlcNRMezs9SC24bZ8k6TujI3SKpUbxnBT9UrsTKz
         w7Mqi/zdoUz0LBwUhYFlHgB0WspkzOnxhxSrPK+T5OBPxE+h+Fc0zokYEQ8EKsCagGcz
         mq7G4nKVTpsiF60csRGLRSXCtochhbgArtEmNBsLflj6cjSzNPex0eZbIFEIImAQof9F
         N7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833894; x=1763438694;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Snl9m+Gsuclyili9Jia8BWYLwnDqexlNgmsV+/z8jHs=;
        b=M+6dg/EAo9OYU7jZcIlqCuuMOBs3uUwjWqpLDs0KKk0kdZYyo8vFoJ+nUXYJkJ+B6j
         IJkoYELzlwgXeYM4rIBImwu9AkcD3o0SRRFCylnADMH/QSg0325SvNv9D0ykGDMm4Xhz
         KGx5h7u+lblroAlbiHb5NT7HrB/FuplzQ86m4LUkmtjMA71OndUy56mJ2EPzSCgZkDWt
         r5IbwNpLXX259j+uPv/omZSgyUh7/KzZn+1Qf5dR4Ng1nj+zi1KiFlHiYmgQtix/D3u+
         VkN99z9Qz60yWWSxz36/dmHOiPdPJB+t0ccHfFqlXDaABy4y8DI9sT0iDzp/9MNHcEiY
         nYdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEg2LEFtJ7AKQmyzRp5JuzD9bQUQmGLKoOVAi4Mhx/R6lH5Hga7DFKmJY7EqHsT8VMXFNg8Xj7nxy4xQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz48ICi1qEqFV138lJJiPyhDP1bXJWgKKxA2+dudWQXKsb2BQjH
	ZZ3+8wQA1h/poYw1FmPHyhAtmGGh0gVsl0TZ2N2y+jCAGGh1cm8S8t1r7bPgH52xvJVPiUM8lKJ
	yqJMgGsu71Q==
X-Google-Smtp-Source: AGHT+IEFASiKWqzsDwLv3yb92ygqFV4xil2iBgRJzUJt4a1IPtI16V7BlKTsos1+lpG3Vc0sJ+Qo8umUeilC
X-Received: from dybmh40.prod.google.com ([2002:a05:7301:f28:b0:2a4:6c58:332a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c0c:b0:298:42ba:c422
 with SMTP id d9443c01a7336-29842bac56cmr12840675ad.31.1762833893842; Mon, 10
 Nov 2025 20:04:53 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:14 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-16-irogers@google.com>
Subject: [PATCH v3 15/18] perf test stat: Update shadow test to use metrics
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


