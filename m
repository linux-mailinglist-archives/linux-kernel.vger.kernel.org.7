Return-Path: <linux-kernel+bounces-646653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A83AB5EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 23:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2C91B45C03
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 21:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C4521B9C6;
	Tue, 13 May 2025 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1m2zxbJ/"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36DE1F8F04
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173248; cv=none; b=rWyFxn12nYZv2K9sxuYCVuqsdGQ9tSG4Yx4UsH3FkRTNKfVyCt3Zw7yptD+eXdFzUbrt5fBsAoMdofy1nEFEUe3WVUeJpOfpx5vivTZj7QJHSMv77U4BWrtBsc3ShYxp8ZgVgUIHySU1Gy4fXWunCajIMbqFqok7KpwjTEhpB+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173248; c=relaxed/simple;
	bh=40QKALZCDAdxC2I4RCUouF79EW48OYte1LNp7ZKNIsQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VKUpdfzg+v3rKmdJUXlB1SdGM9jd9F2ws6w4h3D2GIoJhZ/zC5EmuIibP4dKE6wB/Arl7h9dRQtugOh3eqA0BKcNAbAJ5v5q9UHn3HYxnnZpiASb9aucxgiwAuzdvP1XxtLcdY6RfW1+X4moUR0J4Rl3GPzN95GL48gtjDjp2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1m2zxbJ/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30c50f130d9so3653386a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 14:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747173246; x=1747778046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7fXd3bwKMsVTV58ODLndnal7i9Na64IyoboiGNyHuF8=;
        b=1m2zxbJ/p2cIB7HFnZ149CPnUnuA+7gCUQapIlqENC997yJSw+UecETyVUGDfIiSZS
         Z2FqOi0N3N6NbJ8M8VuemCmKqZOi732pVS/0lSFbod9vXMgQ41CSgujEdDKdZ/Qj0UCM
         jW+R/06rcQoM7qAnonZ3fnz56Dn2Fhojno8gShqMbbIrcaQYMB7mIGUg74jXfpG6sb3Z
         AQzQVFFNWd0AISM3xSz9YSVwhQIBBlW3fEcQ/LziuEWjNi4f9dZ/tJEWYN8Pckcm2oG3
         0wu9Rt1ceoI6OBtodYZ6v6I9XUwFAYr6+Ujfej1qcUYDyUhYW7JFNd/Kwh4l9++xGNK3
         A5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747173246; x=1747778046;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fXd3bwKMsVTV58ODLndnal7i9Na64IyoboiGNyHuF8=;
        b=GfgjJMh9CkQWqUV5wmeGvxew/R6OLxGKydJ+1MaCy2y3uD4DzoRVoIeP2tOtwVJmc5
         9sn644xaafMrrLRUY7jK68hZobM7/C7SQKjMxl7QCFKz2te6bZGpuqUkRjNC1qRVIwGl
         FHK807KW9WMXZk+8S1/AokbiLY6O/9mI4fMxp03QF/nZ+U0WAnLJwKiRyJuTeY2978z6
         7zlZENvYfPr2Fn7XMdpz6kkESFNIR2BFh4zsxc3xIeFiHlH+/Tq4RbU6FrULqnapfecg
         GEitCzbjeFVQSaglbzS7SRf5gGyXnIW0jbs8xGPxamNyLwD6mSJLG8DAYu1+KTp+wv2w
         rhsw==
X-Gm-Message-State: AOJu0YyyOxNcCPQY8FkcF0ONAkoA3Vd2Ay0keSQjYaTA3BZybyxlwUNp
	5lszL4ZUaAHLSImzu5fmp6irkkE15vUx8SvbA//wIv1rCUn+aownVJ5GNYYdA9lB6pV8LBdmh5G
	VeTjFZERWFik0WhGQgKIV8c+tbKwgl7R/MeCl8n6+FFIhb64HURs6ASNjIklCmb1ZOf5uri8ZKE
	nwH7wa0YdInaDVT+96V2+rnCE+eDhbGBr4ZBTSCktU
X-Google-Smtp-Source: AGHT+IF1Pdt3TrLC1JMdQHnUNLYTkgKgYFba33/us5gzSx8qvo238++158+LVN95N/pxvj7wbVmZyRh9Puo=
X-Received: from pjbcz6.prod.google.com ([2002:a17:90a:d446:b0:2fa:2661:76ac])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a86:b0:2ee:8e75:4aeb
 with SMTP id 98e67ed59e1d1-30e2e5dc9f5mr1720334a91.17.1747173246009; Tue, 13
 May 2025 14:54:06 -0700 (PDT)
Date: Tue, 13 May 2025 14:45:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513215401.2315949-1-ctshao@google.com>
Subject: [PATCH v4 0/3] Fix incorrect counts when count the same uncore event
 multiple time
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, ak@linux.intel.com, 
	howardchu95@gmail.com, yeoreum.yun@arm.com, linux@treblig.org, 
	james.clark@linaro.org, weilin.wang@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Let's take a look an example, the machine is SKX with 6 IMC devices.

  perf stat -e clockticks,clockticks -I 1000
  #           time             counts unit events
       1.001127430      6,901,503,174      uncore_imc_0/clockticks/
       1.001127430      3,940,896,301      uncore_imc_0/clockticks/
       2.002649722        988,376,876      uncore_imc_0/clockticks/
       2.002649722        988,376,141      uncore_imc_0/clockticks/
       3.004071319      1,000,292,675      uncore_imc_0/clockticks/
       3.004071319      1,000,294,160      uncore_imc_0/clockticks/

1) The events name should not be uniquified.
2) The initial count for the first `clockticks` is doubled.
3) Subsequent count only report for the first IMC device.

The first patch fixes 1) and 3), and the second patch fixes 2).

After these fix:

  perf stat -e clockticks,clockticks -I 1000
  #           time             counts unit events
       1.001127586      4,126,938,857      clockticks
       1.001127586      4,121,564,277      clockticks
       2.001686014      3,953,806,350      clockticks
       2.001686014      3,953,809,541      clockticks
       3.003121403      4,137,750,252      clockticks
       3.003121403      4,137,749,048      clockticks

I also tested `-A`, `--per-socket`, `--per-die` and `--per-core`, all
looks good.

Ian tested `hybrid-merge` and `hwmon`, all looks good as well.

Chun-Tse Shao (1):
  perf test: Add stat uniquifying test

Ian Rogers (2):
  perf evlist: Make uniquifying counter names consistent
  perf parse-events: Use wildcard processing to set an event to merge
    into

 tools/perf/builtin-record.c                   |   7 +-
 tools/perf/builtin-top.c                      |   7 +-
 .../tests/shell/stat+event_uniquifying.sh     |  69 ++++++++
 tools/perf/util/evlist.c                      |  66 +++++---
 tools/perf/util/evlist.h                      |   3 +-
 tools/perf/util/evsel.c                       | 119 ++++++++++++-
 tools/perf/util/evsel.h                       |  11 +-
 tools/perf/util/parse-events.c                |  90 +++++++---
 tools/perf/util/stat-display.c                | 160 ++----------------
 tools/perf/util/stat.c                        |  40 +----
 10 files changed, 332 insertions(+), 240 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh

Chun-Tse Shao (1):
  perf test: Add stat uniquifying test

Ian Rogers (2):
  perf evlist: Make uniquifying counter names consistent
  perf parse-events: Use wildcard processing to set an event to merge
    into

 tools/perf/builtin-record.c                   |   7 +-
 tools/perf/builtin-top.c                      |   7 +-
 .../tests/shell/stat+event_uniquifying.sh     |  69 ++++++++
 tools/perf/util/evlist.c                      |  66 +++++---
 tools/perf/util/evlist.h                      |   3 +-
 tools/perf/util/evsel.c                       | 119 ++++++++++++-
 tools/perf/util/evsel.h                       |  11 +-
 tools/perf/util/parse-events.c                |  86 +++++++---
 tools/perf/util/stat-display.c                | 160 ++----------------
 tools/perf/util/stat.c                        |  40 +----
 10 files changed, 328 insertions(+), 240 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh

--
v4: Fix a compiling error on patch v3 1/3.

v3: lore.kernel.org/20250512215929.2098240-1-ctshao@google.com
  Rebase with tmp.perf-tools-next. Since most of the conflicts are from
  lore.kernel.org/20250403194337.40202-5-irogers@google.com, tested v3
  patches with:

  perf stat -A -C 0,4-5,8 -e "instructions/cpu=0/,l1d-misses/cpu=4,cpu=5/,inst_retired.any/cpu=8/,cycles" -a sleep 0.1

   Performance counter stats for 'system wide':

  CPU0              682,860      instructions/cpu=0/              #    0.27  insn per cycle
  CPU4               53,774      l1d-misses
  CPU5               18,725      l1d-misses
  CPU8              608,698      inst_retired.any/cpu=8/
  CPU0            2,574,325      cycles
  CPU4            4,267,115      cycles
  CPU5            1,741,536      cycles
  CPU8            1,969,547      cycles

         0.102746958 seconds time elapsed

v2: lore.kernel.org/20250327225651.642965-1-ctshao@google.com
  - Fixes for `hwmon` and `--hybrid-merge`.
  - Add a test for event uniquifying.

v1: lore.kernel.org/20250326234758.480431-1-ctshao@google.com

2.49.0.1045.g170613ef41-goog


