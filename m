Return-Path: <linux-kernel+bounces-656815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BBBABEB35
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 07:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160C71890EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 05:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5344122B8D5;
	Wed, 21 May 2025 05:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLX+5gXo"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB81459EA
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 05:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747804841; cv=none; b=CESNZRvYKGUvigp0tfd3hJr43dIhFBt8Bnyh4//PU5lLsvOzAX9DNDlD+WyvcqpYGv27kQMz6ajRgVYGvAG1lfLxFBS5ygdwyO6vlWqv9UHDaty8Ng+4oYkLdePM89mE0yvyEXS+nbve91eeTvby/sfPwXlN4Dcjs5y0kvsW/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747804841; c=relaxed/simple;
	bh=DbjNRHAddfYswahlJ5OlrQs2EuQdDjt4sx3QNUqNnmM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=TslDTos89TpMcINGVL/KoyH04wNqFHTVs1zvBeB4mbminfftMLDvx2v+i99tJjr4eXV06HdhcNf/SZEcLgJCio4gO/TuyqVePmEqznx/I9M9wSDbWlyc1803tr+KJqLHxZGeLdVGsf8OdrXCqNzPb5qXQ//3N6pEmtecKHZ2YUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLX+5gXo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23201f062afso31070105ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 22:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747804839; x=1748409639; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ILcaj/2kHUB6wUpDHcSBb10ICw09s8EvCijtgSr1pxg=;
        b=mLX+5gXoJGvvmPjAO5zpU/tmnpCjbesAiqWHjkazdpQebGDDdrxyI0AszwCR6ErnK6
         a2mkepE7LrRndqxelODaJzqxq2k7ALV4DcCzBS4YLOHfl7ILaAZv/T7TTkRO4BvaYOuI
         GASfmALAgT1hmwL37C2YaXSgSWymI1qyKOfxYQvDrw6xRW7jmD7GknSNsdzQ+XZW4jpK
         mCMKZ5Z72JKk7L9LFD3e7B+7Wwj16aL7urID+Cqu10X+A0sZmndKRP9ILflfdHPYiMV5
         6FRCkKPS9gZHyzBaqLNySbakXsogO3ALgjwq7rsxu/QNLqcW7vkkVQJgKKsBc5I/7SiU
         JgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747804839; x=1748409639;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILcaj/2kHUB6wUpDHcSBb10ICw09s8EvCijtgSr1pxg=;
        b=JHqmR8FuWi0nAkYMD3JGUapvTIRfAayrAW0swFf8TwMyTkqRD0gYmm+k6pGVJFOPQ9
         QgpObg+bUry12GPE6DjhYJiu14Dr0JQ5mW/Ix9xeAQ+K8YgRNF3vmZfd88aEcFDbKfP5
         0mVO1Gtd+xU98Uh1MqqNFfsj8HMFCWumpTZUlTT+ShtJ8mo/snNRKWHZO/MO8MtGMRuD
         ZAirJ3m17BnspYBdb8Yoe83jheyjuLqdh62Ye+bjxj8KwM8L9pb0L1t1yCf24Wcc/D0+
         jW7Z6QdFza2CsQdr/OKaSlGQuraXtlopep+MNTl7X8o7XTpxKWhC1Oc5KE681rOYfcCX
         Rd/A==
X-Forwarded-Encrypted: i=1; AJvYcCU1LkzKsc6SSGkdNyw48CGojtryjtTl1nB9C1CoAXlFdwVvva6OB81nSliZS4QArxY1kR5ceixG+WDmlH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyesaifyTxmW++dWpAPg3RO/QG+M5C9Agjvxpv6MjRpU/2hxu5+
	1pJQLJS2eXYtq9q5d9QTXo+Yi8H51E5GmtgTsOVJXY6qw/QyrUIiT6Oz3wGh1FaOYRtukfB2+B6
	NAlLdRlDNjw==
X-Google-Smtp-Source: AGHT+IG9Ixfpj3XKJogkh2nfyoZjlb8nZ1aI7qy9/NwWxDmzSKqAaYJwTSLXXoP3KEgTZGW2tm4v9GuAk3Zf
X-Received: from plblm4.prod.google.com ([2002:a17:903:2984:b0:22f:b333:1bd9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c2:b0:232:59b:5923
 with SMTP id d9443c01a7336-232059b5ca8mr218231555ad.23.1747804839452; Tue, 20
 May 2025 22:20:39 -0700 (PDT)
Date: Tue, 20 May 2025 22:20:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250521052029.658800-1-irogers@google.com>
Subject: [PATCH v1 0/3] Generic weight struct, use env for sort key and header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The arch directory is a barrier to cross-platform development as files
and behaviors within it are inherently platform specific. Sample
parsing should be generic but the PERF_SAMPLE_WEIGHT_STRUCT handling
was only present if building for x86 or powerpc. The sort key and
headers should be specific to the session that is being executed and
not to the machine perf is being run upon. These patches clean this
and associated code up.

Ian Rogers (3):
  perf sample: Remove arch notion of sample parsing
  perf test: Move PERF_SAMPLE_WEIGHT_STRUCT parsing to common test
  perf sort: Use perf_env to set arch sort keys and header

 tools/perf/arch/powerpc/util/Build         |   1 -
 tools/perf/arch/powerpc/util/event.c       |  60 ----------
 tools/perf/arch/x86/include/arch-tests.h   |   1 -
 tools/perf/arch/x86/tests/Build            |   1 -
 tools/perf/arch/x86/tests/arch-tests.c     |   2 -
 tools/perf/arch/x86/tests/sample-parsing.c | 125 ---------------------
 tools/perf/arch/x86/util/event.c           |  46 --------
 tools/perf/builtin-annotate.c              |   2 +-
 tools/perf/builtin-c2c.c                   |  53 +++++----
 tools/perf/builtin-diff.c                  |   2 +-
 tools/perf/builtin-report.c                |   2 +-
 tools/perf/builtin-script.c                |   2 +-
 tools/perf/builtin-top.c                   |  16 +--
 tools/perf/include/perf/perf_dlfilter.h    |   2 +-
 tools/perf/tests/hists_cumulate.c          |   8 +-
 tools/perf/tests/hists_filter.c            |   8 +-
 tools/perf/tests/hists_link.c              |   8 +-
 tools/perf/tests/hists_output.c            |  10 +-
 tools/perf/tests/sample-parsing.c          |  14 +++
 tools/perf/util/dlfilter.c                 |   2 +-
 tools/perf/util/event.h                    |   5 -
 tools/perf/util/evsel.c                    |  17 ++-
 tools/perf/util/hist.c                     |   4 +-
 tools/perf/util/hist.h                     |   2 +-
 tools/perf/util/intel-tpebs.c              |   4 +-
 tools/perf/util/sample.h                   |   5 +-
 tools/perf/util/session.c                  |   2 +-
 tools/perf/util/sort.c                     |  67 +++++++----
 tools/perf/util/sort.h                     |   5 +-
 tools/perf/util/synthetic-events.c         |  10 +-
 30 files changed, 151 insertions(+), 335 deletions(-)
 delete mode 100644 tools/perf/arch/powerpc/util/event.c
 delete mode 100644 tools/perf/arch/x86/tests/sample-parsing.c

-- 
2.49.0.1112.g889b7c5bd8-goog


