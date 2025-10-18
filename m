Return-Path: <linux-kernel+bounces-859021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFC4BEC7EC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 06:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16E864E2411
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FBD155389;
	Sat, 18 Oct 2025 04:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4Xkd0iH"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE51A255C
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 04:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760763566; cv=none; b=hVnclveMjrRszYEbuuUOh9FZLvzJJ9hlocfZQ8th8y4q7EJBO1B/DhP2u+Mb2uodhMGciOyULVcrrZgTaHHvRAtlukBTAr9tHRkIxtb+AkolnAjMpEuN6YH/Enx4Luz4zw++qgwTJdczU7LTuwhbEpiGVmSAHGe9TDokRAwTVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760763566; c=relaxed/simple;
	bh=IUZFOQeuI3yCpqc7n7wK2+nBiCoxcsO0N/ZUQHofi9A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=FiKc/1jnJiFL+s8zioKDPOL4upWA6t7D5Qu+3MSYghsEdm9bGiJzRy4zA1eCkXuKy/LxxRPCP+ccti4vJhjf0QaKGm4z3IzE//k/AM9CPIXgCMuGbQJEni8I8KF0d5gjSA/HRTi6BIsjOjfL2I4pQgty/6tjJer6cIlzJUpNfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4Xkd0iH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso1746412a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760763564; x=1761368364; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vkcjNV+lg/qMB7XR1dlSgtqiUT8Il7EIrwR559XmCkM=;
        b=t4Xkd0iHTmOOstZf4rOp16HLVWC7AGe016AowcVFa57VJfCYqeUoF64BgAjJXUgC4F
         Q4t7sdQcCgcfwKX1hA4GOTZ6NJVeDsqazSnEoWR6HoWKXZgh2CWB0IykbWaoHM/gepbF
         oeSnww6pY+ucVVvJfiFW4EbWADkR4xq5yIwgEtBtHGF7wH42VHjzaocVgk06Bhp0AncU
         lHf4XVYSjHJ3LUNU8+FpE/zMduls6imZeUa5lpB7sSGmeJ496Scxbp1PHB1zBRuScaAr
         jccQjKVpeDI7S5sL+CDbve0oTsjLej3CEqxtSbDD2P6pIvJ0VWC9u61M9AGEPnE5W4nn
         h4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760763564; x=1761368364;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vkcjNV+lg/qMB7XR1dlSgtqiUT8Il7EIrwR559XmCkM=;
        b=qyD+yccrTWh6u7zQXv+6cpviX6Fvfi3C08+rENpKGpAXn7epk6v3B7J6twIOm3/MxQ
         KoEujB+nWIksbB9X60OTzlyLvupqPuU+VX93FFd2bB6KR8vbsrGaMVh6zZQV6aO71x99
         ozpMptqb3/uDK1AF1ubTDIfOE/cTrorXhd0keduzHDFlX26NtT0WhbgJjwFrqPwwUrMY
         4ijkmVU7w3bLyV/34XhByH3MYGDqIdA3miAzMve6mbhMAHGwyOcT43L9hfJ+/K+cYRsF
         UNRways3Q4DvLT8N472hmzNvloN1TkfRTNxI70NoSxtxX7pN33Ao+Sb+wLEtrUgrgofj
         cafA==
X-Forwarded-Encrypted: i=1; AJvYcCVNCM/RNzWNX586bIdsmuDz7JbPQ6Eumm9pDgBnIvvEqcUIxDKE5jcLW1a4DhZmmefl7v662d7B96jP7qA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2vc3d6ERI3EkgVDqrfyyRnRHGJBEm/DkmHZAxtnXcidUgSo64
	H8udrgKHY3C9RGzBB9FxJj9R/rsQB9yUQMsW/S+HF/RTwq667MJx8urGXJcEyYwvBIVpQHCXvcr
	NwZ+a6oTmNQ==
X-Google-Smtp-Source: AGHT+IFbctGvWW7cWWpUbK4gP5ZmVYuUzv9u9IHygP/MBkIa+mrhQm2gwwrDgcf5CKToet4IvqfjzNTA+2/v
X-Received: from pgbcm13.prod.google.com ([2002:a05:6a02:a0d:b0:b55:135:7cb9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12cb:b0:334:a322:f326
 with SMTP id adf61e73a8af0-334a86070cdmr8832156637.28.1760763564485; Fri, 17
 Oct 2025 21:59:24 -0700 (PDT)
Date: Fri, 17 Oct 2025 21:59:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018045902.21665-1-irogers@google.com>
Subject: [PATCH v1] perf trace: Don't synthesize mmaps unless callchains are enabled
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Synthesizing mmaps in perf trace is unnecessary unless call chains are
being generated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c607f39b8c8b..a743bda294bd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2005,7 +2005,9 @@ static int trace__symbols_init(struct trace *trace, int argc, const char **argv,
 
 	err = __machine__synthesize_threads(trace->host, &trace->tool, &trace->opts.target,
 					    evlist->core.threads, trace__tool_process,
-					    true, false, 1);
+					    /*needs_mmap=*/callchain_param.enabled,
+					    /*mmap_data=*/false,
+					    /*nr_threads_synthesize=*/1);
 out:
 	if (err) {
 		perf_env__exit(&trace->host_env);
-- 
2.51.0.858.gf9c4a03a3a-goog


