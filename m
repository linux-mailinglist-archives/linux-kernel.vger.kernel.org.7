Return-Path: <linux-kernel+bounces-889511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E39DDC3DCC8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6E6188EF21
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5EB35A15C;
	Thu,  6 Nov 2025 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWFOQQUe"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12D35A925
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470970; cv=none; b=EpBpNqFmDyHMmhliSPTRUBq/jJUUphoEQQu3U/Th7TVxoX3MK+Gk/OdB+gxqdg0dPejBMER3PM8V5346hWwzotQirBSRFlo6yFpYsT1XE5UwJETB+VtUHF93vo97vYeymORxcOCi/fRUgFSPymZIv3st3zPfXVNRWwdk+zhWiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470970; c=relaxed/simple;
	bh=NQZLwrJVuAq7AnAGYojD2+FNeBDfMGlmTWdY5sb/Yxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cly64mHsH8DOkbqGyFYsciPccjg1VlyeX0EI2cEvYhk6UvmsMdcCGn/bweICf2dOE5G5U4GlxEgM0+PCR+YIwpcizC0IEoEGGqwuJAAXuUPM4Czi/UWLVOWXTpBuJeMGS+XgtD+i/Us56Za5krrv0M7Tii3IR35Bit0nabFS9bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWFOQQUe; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29085106b99so2982285ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470967; x=1763075767; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Snl9m+Gsuclyili9Jia8BWYLwnDqexlNgmsV+/z8jHs=;
        b=NWFOQQUe8v8/GpDgi/IMW4HZTWq3cryI1Af1I0SHMizuR/ijzlyxSuF768DZnJUQqO
         cvYhwbBoVufnjvwDR2CUP36PWn9FvGL8cLgmnav78K6VJwjCjlZEHVYfBmiEMUGD1Xni
         bT3SJnEDebyWA3nxJDn10CvxMm8aS4Y4wA2jJ8yTU3P16kUBAi2+pvN4sG37W3z6nsJM
         r+uPlKSx9cUUMVL3wvbMtDt3qFxXpkzLpBE53rOZFrqfvQWseTOndBb1vC+4B3ofGRF2
         ZL/2456Lh/nnqg8eNs8Eze1P0F1RIbYO56BAEQm4SN6m6HcLFkHbdhhCLypBGaKLJ/sm
         TeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470967; x=1763075767;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Snl9m+Gsuclyili9Jia8BWYLwnDqexlNgmsV+/z8jHs=;
        b=MZrhijmePPX4JyA7a0gNdptlAyXWmvWZ6nd6CNevgAFdTS+83+Z2JhiCjCvCl/cBeV
         pUyz/gCE0MppxoZczdLs2A0PXBvnMKDLXrv4x18W2uL6GxLFfIRGpvgpZRhcAoVO7f2G
         MYmRzTg6QZ4CCnB/QFvtbKdLjodN70Chj+mvEdWKWL9Z2iE05vQIwPXZqaqMV2Ah8Fuh
         3PRQBk6wn14NJnjXwNOuvaRrBVEsUAo2NqEj2ZvVp3j3Ra2xHylrapePxmz/mXYijaqe
         lGrYGrwOtj8b70WXa5EEpIU263MkKKePHiQUZy0LKm9hOn2zry6og7Hx5aInrlcpv9fY
         CAsw==
X-Forwarded-Encrypted: i=1; AJvYcCUGqnoRCWrCVj4oEsD/A2mLo7T6PTAfkzNk0oiRvubt+wBH2r3Y8XDc1riEvc5YdC395wrlB4Y2R/xC2E4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyymVHGQyFlO70wS6CMacI0+bTHlVbcSJ5Hj8LirXT7wgXU8ohf
	iGV04/C5yaRJGDJXvbuFwOsyLEaaxmEl/RNR6KieobV2M8ly4lPggCDy5fG5yaQAHPqr1SaJZqL
	vubW8N5GEaA==
X-Google-Smtp-Source: AGHT+IFc3t+pl+dtq2Ew3dKGXbYWje+bXWKgsuDNMN96A/1Pua+fxj/lreuHJRndBsoMYTI4pD+iANneYzz2
X-Received: from dlbps9.prod.google.com ([2002:a05:7023:889:b0:119:49ca:6bac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac4:b0:262:2ae8:2517
 with SMTP id d9443c01a7336-297c03936f3mr16182735ad.5.1762470967518; Thu, 06
 Nov 2025 15:16:07 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:05 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-16-irogers@google.com>
Subject: [PATCH v2 15/18] perf test stat: Update shadow test to use metrics
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


