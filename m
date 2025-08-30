Return-Path: <linux-kernel+bounces-792741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9C6B3C857
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 07:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A6716A782
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 05:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134DD23C506;
	Sat, 30 Aug 2025 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhBQFXuv"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED220C004
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532157; cv=none; b=dnLBsHm68rsh70np/3tlmibrooSNgNlfLHpangdYur5K+6j3KChjA1knMauWJGoP6wRXes5b26l0N4o5MjRCL/z3XweJbZZnAvdIWK8XPieVALhRcHeOZLTyKWE2bTsmJp6348Up4wu9K+YukH40foUuClh8a2/mFnY/W4LoTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532157; c=relaxed/simple;
	bh=QmYI0zj/X4Kwrmbx/4/heNHuxCp9kC0znQJ9RD/CgSs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=LtaIMyhNtncUP4qtc4ISq7ZRUX3tl5vXcsBxg90ksfF1OpkoDhgbLYcsFoJhWKSLxc0iIADK3DK20CfQjdLa5r8v6BocpVqxk9Ppzux6lNx6iqMnvnT458lURW1igEV8Y2sm9Oxxeb1YbnPtMYLgeFAg9DLPqJChGzljhmnYCtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhBQFXuv; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-31598225bc5so2293079fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532154; x=1757136954; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X5nOW4iK3c1eBL10WZVuLjDvECTNyCoJ5GM8pDiglm8=;
        b=PhBQFXuvxA3KAHag+m2TwTpGX79feG7rVRS+R+DD8+aMClmE9IC58XfoKbsTo8Tgw1
         r6uiaDAFCf75P7yOwrHs3Khv9yyHnm70n7Np52MOZbTosLy/dKpyemrypZmL15hAQNRX
         bHfXo70f9aiIbMM1jGWqqlCE2gyCKBT7cFXtNUM3jPfcaokld/2L71JXRN5bLX+AQJSq
         Xjn0hmUIlZjLSdoj26E6QeJvkA5om2frsvQauGL7ASG3A7ZYhVfI+eKna/F0eB0PMCZF
         SBA+zoOE0GOZReUFpeqXyXYSfT+eRUUuaU+V2yGZ4R58ruT9jT7J2VWdbB298MUyPNDG
         1NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532154; x=1757136954;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5nOW4iK3c1eBL10WZVuLjDvECTNyCoJ5GM8pDiglm8=;
        b=tWnW2+NL8f6NPJSZ4mvnK1YZbT+ohdc6eiaSWldKvKl8XsjRyV/hOgFGeID6MRGQzJ
         FJyirKSORRjm2Zmkee88aVT+F7aVKH0abjST2cD2qEkqMYwYjpe3szz4iQB5DoqyAP+a
         Lumaoxu0XPta+D3bSbe6AGjcj3JgXaXEXY2fznovFADZep8TxydmrQLPIrby4iVqCBpH
         NIJAA2YUXM+yydm/S4p04+pZ6z3urFi/ZBt7Y6dVCmvneO0xnwK0l4ZEJfWAIN6q8YCK
         35jV55xafHD+ypPWgXfeKSwXnwAaeGtbB9aLuPgMGMWoPSPxCLK3Me+AnBMq44ef6vu6
         OSxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW220IJpz8X2XAoPeoBzSgUi0aaTVgX7FOPn3UNIz4kDclr8gjO4HZTyJkex4O3lHxhtHQ0W243kkzdEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6/S9JpSnanmExw3R1U8ll7PiQoSVslS57L1vrlywDITjpnNTk
	b3DPtgEiu3hwgfhAx0V5AVbeIwNWPuyKfs70+m9/8dRtUpefVyQvTFG+Y5B2GuKrK84pSygdFGq
	ykN1Zbi9sIQ==
X-Google-Smtp-Source: AGHT+IEc1GIA49XbBalZevG878g4TPyrLDAk/JyZXXK/zHcAZRkDvhFlv5+yj3+9nhHnmcLmNFb4G7tNK70h
X-Received: from oabhi24.prod.google.com ([2002:a05:6870:c998:b0:315:aed6:7f83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:171a:b0:315:b768:bd1d
 with SMTP id 586e51a60fabf-3196307eeb4mr441687fac.6.1756532154143; Fri, 29
 Aug 2025 22:35:54 -0700 (PDT)
Date: Fri, 29 Aug 2025 22:35:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053549.1966520-1-irogers@google.com>
Subject: [PATCH v1] perf bpf-filter: Fix opts declaration on older libbpfs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Hao Ge <gehao@kylinos.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Building perf with LIBBPF_DYNAMIC (ie not the default static linking
of libbpf with perf) is breaking as the libbpf isn't version 1.7 or
newer, where dont_enable is added to bpf_perf_event_opts. To avoid
this breakage add a compile time version check and don't declare the
variable when not present.

Fixes: 5e2ac8e8571d ("perf bpf-filter: Enable events manually")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-filter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index a0b11f35395f..92308c38fbb5 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -443,6 +443,10 @@ static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
 	return -1;
 }
 
+#define LIBBPF_CURRENT_VERSION_GEQ(major, minor)			\
+	(LIBBPF_MAJOR_VERSION > (major) ||				\
+	 (LIBBPF_MAJOR_VERSION == (major) && LIBBPF_MINOR_VERSION >= (minor)))
+
 int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 {
 	int i, x, y, fd, ret;
@@ -451,8 +455,12 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct bpf_link *link;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
+#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
 			    .dont_enable = true);
+#else
+	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
+#endif
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
-- 
2.51.0.318.gd7df087d1a-goog


