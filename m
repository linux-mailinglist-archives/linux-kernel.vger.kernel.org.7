Return-Path: <linux-kernel+bounces-791056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E94B3B196
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A80E7AE30B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324971A5B8B;
	Fri, 29 Aug 2025 03:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpGRm0jN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC422940B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438309; cv=none; b=u+Vi9dwHQ75Do+L+yvHeTZ1ip/oiDxHj74LDqXkoEuyVocKEFfIfd+Od0kkBACFjmPWA8xrwP7lYpsDlyfP/C7tndMXXnWvhY4IvJ/rafS7M7sDpZ0sAqLNE00JaJiQsSvY8tw9s2IHFO2zyf5IeaXSTeZkaQosC5IIO1T9aObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438309; c=relaxed/simple;
	bh=Pbjjn0DMDsr4UJIsyA5NmeVJklRb3qZ6fa1FiiHg9TY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=I96DWEhzN7sdC9ia2aMqY0G6/ErqPKm5FxM/51OMuKeTKVMZqZeBjjkm/85YG+gJLi1e1RcuSVWZGA3rrrbgssvhnE4WBuRWQmFU4EIQdpvlsMuej7HODFnpvOrfpfD/F8PB+BRM6Exto8DEmsozzXQWSQMFQz4iykUnDB0vHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mpGRm0jN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e96e9af7ad8so2862426276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438307; x=1757043107; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Igh8wQcHkEb8Eesa8vg0g54cvftBtL9bkZsN4Nn7hfE=;
        b=mpGRm0jNl+QSK71OiA0K3AmKDxsffSg8bwgri8W/KWrIEpIfVOJCU+GnmbJWK+2ZSU
         Xlu5g2+YMwHFWvjpv4nTeybZCXUtZdWOzwvx2puOyOyciZ166f2pokw3Y0hRD+OFKnFn
         4Lkr8USuOBKcNbJR7cnFh1Nhs4VV1nF2GWbYNT0dWz1KlEou9+b+B0++DdgLHsskNTvE
         +JlZZ+VfLRJYpatmvOFyoxb5RjQE9pTE2Tyc4myQFpcuhBBjbgexrkwCwYO5SfLYPIA3
         Uc/UBhRaGe+i/MkwdmEFeM8+s7W1hOEhKgXQ+iY97auUY40dhrb51KMy4Zyp37peqUqt
         3orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438307; x=1757043107;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Igh8wQcHkEb8Eesa8vg0g54cvftBtL9bkZsN4Nn7hfE=;
        b=EPAeI4n0PYbAipLWu+8SWSLQ7MwOAXipfH27lmBxKSEQVhaaeRSS1fz3xIF21NtgJB
         Pp4NoVcwXHc0JboHHPHTBQ9P4GSgDnGElK1Phqgf/W8gAqaYfk4JOPVklbnaMNy07Tbb
         MZ7WHSrmv6UB+UmffR22GY/bgu/CPchZLGIQHLuK8cEacmsneasdvuryLglMzDX4/UJc
         aO5TnlFbtdmzgIjhCReCC8270QwmLIgXN2eqJs96WuuBKfZwCoUdmUkH6W8tNE6CRchX
         T6ug1Wt5Bu6UnhN65tccNiW1cYX7IkExP5ChtdeiQvhT6X1ou/MzXdvk9XLX/49lBi+2
         3mUw==
X-Forwarded-Encrypted: i=1; AJvYcCWMFkDyCSUidOb06niAOggzSwl4k8jG2URJZOUB7yp3y/QEsA5t2MHfQqo2ZdZIIBsnCSQF0L3onzEI4FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7YxrHTmoLo530MLCJjfAYNO6Zd45GI93cMgd58rQ86kIIvFOg
	6ZSQV4wx3VhiVB9qhKt8bDVnXXuHnKPJaJ9Yzf/N2aHGHUXKgfoI3hQY6RZMgtg71iMo08cxI8E
	B7cX73TyrDQ==
X-Google-Smtp-Source: AGHT+IEAqPl/PUmtC3gYt7eLN0CBsJXSLELBytYsBAWO3YREnVqyHQlp4RQeG/vjJn4twfvM09nEds7Abb6T
X-Received: from ybbdo18.prod.google.com ([2002:a05:6902:2312:b0:e96:c754:b4e6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a25:2904:0:b0:e96:c2d2:4af5
 with SMTP id 3f1490d57ef6-e96e4792de0mr9656813276.16.1756438306896; Thu, 28
 Aug 2025 20:31:46 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-1-irogers@google.com>
Subject: [PATCH v5 00/13] Python generated AMD Zen metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Generate thirteen sets of additional metrics for AMD zen.  Rapl and
Idle metrics aren't specific to AMD but are placed here for ease and
convenience. Uncore L3 metrics are added along with the majority of
core metrics.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20250829030727.4159703-1-irogers@google.com/

v5. Rebase. Add uop cache hit/miss rates patch. Prefix all metric
    names with lpm_ (short for Linux Perf Metric) so that python
    generated metrics are clearly namespaced.

v4. Rebase.
    https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google.com/

v3. Some minor code cleanup changes.
    https://lore.kernel.org/lkml/20240314055839.1975063-1-irogers@google.com/

v2. Drop the cycles breakdown in favor of having it as a common
    metric, suggested by Kan Liang <kan.liang@linux.intel.com>.
    https://lore.kernel.org/lkml/20240301184737.2660108-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240229001537.4158049-1-irogers@google.com/

Ian Rogers (13):
  perf jevents: Add RAPL event metric for AMD zen models
  perf jevents: Add idle metric for AMD zen models
  perf jevents: Add upc metric for uops per cycle for AMD
  perf jevents: Add br metric group for branch statistics on AMD
  perf jevents: Add software prefetch (swpf) metric group for AMD
  perf jevents: Add hardware prefetch (hwpf) metric group for AMD
  perf jevents: Add itlb metric group for AMD
  perf jevents: Add dtlb metric group for AMD
  perf jevents: Add uncore l3 metric group for AMD
  perf jevents: Add load store breakdown metrics ldst for AMD
  perf jevents: Add ILP metrics for AMD
  perf jevents: Add context switch metrics for AMD
  perf jevents: Add uop cache hit/miss rates for AMD

 tools/perf/pmu-events/amd_metrics.py | 654 ++++++++++++++++++++++++++-
 1 file changed, 651 insertions(+), 3 deletions(-)

-- 
2.51.0.318.gd7df087d1a-goog


