Return-Path: <linux-kernel+bounces-682751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9832DAD6427
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 02:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60239189E1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 00:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D6DDAB;
	Thu, 12 Jun 2025 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nrmYrPNn"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603874A1E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686550; cv=none; b=ioOqiY07B7VhWNYnXMjbSPPqazKpm4JNHumRYRXl51VqYEc3rNhrd85KuuuBH6PAXhInNo3NovkG2uVN/R1pyvDLRuew+VL5x1R/q2ridjYaeLCqibVeNalbFXEJoFi+bLM6oPYoPb+ST/nsYPXpLDl5+AJfNpSdzpXbBHQ/8HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686550; c=relaxed/simple;
	bh=21HJy6pHJV5WagLgzMaxTlQegWvphBrRtG5zAue3yk0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=enpwVpB+iSg1AJPBqqRxJ2nXzJNNHBi5GKOei2ulLVZfFzVW5u+OKmZ2ik5AEOd0gEGDNkBr6b9HNHCdGOFjGxSGPF/j1hYkF37CwsCtvEL2rkgFy5Mdy6wfRJ7MWT7wLdMKpHaPbOJoIFaGQpI81i+/jTd2kmtv4dvBh9d2KJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nrmYrPNn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b1442e039eeso172592a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 17:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749686549; x=1750291349; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=meyCUNHBNmQLCBOG8a8LQaW0WDvhFY6hoN25mEHFE6Q=;
        b=nrmYrPNnCYoIbkk9FmvvowDXpirupYvKbWgBbvORMHF2cJiCwiyW5zJzWys3XYmtSg
         i9+e1xwF1LVEM8RhFjrR1Q3Vl0RXyH7ESkk9wKrcrR7Ot2PfDPifhdVXFweVV/IgF/jL
         MCbOI9UWI2hoex8xq9sgxLsIfNNLbres07lpQ84fYuEGB6752t44gYuRcmAnRhABxOyh
         dLJwMnGJ6NQ4TFBpXUsRjVmaXbq8E2LLBegsifaMbqBkTiijfPp3qqnfruhWmBFX4vNZ
         kmiblyV8jIqdiEaXGyK9FfXvAc+tJ66VO9r30cfSPaqXAwmuSgSIo18YxdxXBNmPn7FT
         +gWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749686549; x=1750291349;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=meyCUNHBNmQLCBOG8a8LQaW0WDvhFY6hoN25mEHFE6Q=;
        b=pQ0ot8uX04m9kAnif8j9mz8ZJPVG2zWuhmVayoUvUj1GYN2F2teAWmtZU+VjaR/4CN
         gZkMjaIZp2cSNXBe1StJnM2GanOB1ut451kPYumRqfhiYGRBBKNYWPqgZ65p0wx7Z8pg
         9hG5QHz/m5KKwwQXhvst9RRG5EzR7hbtKtiNvyH7/v9XbNlqSkAe27JtW3gkJB6nMXre
         SMouM7qSw60ryTyps6vFO8a9TPres5gIo+mr8b3SNgCFNXls2GOxS7m21Q1T4OLhW/oY
         hp2jYPECHKDAUuh3pGT5AyOJ6gxMe1yz7oT04qnxQWhV6pGAZLyBT/mT6JFKAbUFk5ZQ
         xrXg==
X-Forwarded-Encrypted: i=1; AJvYcCVbmo7vvcIw45Pgogd9WEuCPTkYARj0UaRyXM5+TZxynppRGdsd0i9cZv2dK3QVe9EA/5VHqGbK+sqWfqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLiCsMdT3884usoW4JR+vr8o8VYEatRlIDGPXwx9brwiH80wMl
	AKr+bjkgWIfy7mndpmF7NFBxgQI5x/DqTFtXbSHlsYo6T5Xum+OF1ZJZmhCFDNEPtYvHIDy9PCv
	BZUYc2p3nfQ==
X-Google-Smtp-Source: AGHT+IGPoBUQwD6J5W0XDcBFFbPQSGnASywD4GkuYq0S0OYbNX3vrh3RstSBYk1Hel6pM51oqTSPEZP3v5to
X-Received: from plps10.prod.google.com ([2002:a17:902:988a:b0:234:8ec2:bf02])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce02:b0:234:eadc:c0b4
 with SMTP id d9443c01a7336-2364d8f6c5emr15593115ad.44.1749686548715; Wed, 11
 Jun 2025 17:02:28 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:02:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612000224.780337-1-irogers@google.com>
Subject: [PATCH v1 00/15] perf vendor events: Update Intel events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Update:
 - ADL/ADLN v1.29 -> 1.31
 - ARL 1.08 -> 1.09
 - CLX 1.23 -> 1.25
 - EMR 1.11 -> 1.14
 - GRR 1.07 -> 1.09
 - GNR 1.08 -> 1.10
 - ICX 1.27 -> 1.28
 - LNL 1.11 -> 1.14
 - MTL 1.13 -> 1.14
 - PTL new v1.00
 - SPR 1.25 -> 1.28
 - SRF 1.09 -> 1.11
 - SKX 1.36 -> 1.37
 - TGL 1.17 -> 1.18

Updates from:
https://github.com/intel/perfmon
with:
https://github.com/intel/perfmon/pull/312
Running the script:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Ian Rogers (15):
  perf vendor events: Update Alderlake events
  perf vendor events: Update AlderlakeN events
  perf vendor events: Update Arrowlake events
  perf vendor events: Update CascadelakeX events
  perf vendor events: Update EmeraldRapids events
  perf vendor events: Update GrandRidge events
  perf vendor events: Update GraniteRapids events
  perf vendor events: Update IcelakeX events
  perf vendor events: Update LunarLake events
  perf vendor events: Update MeteorLake events
  perf vendor events: Add PantherLake events
  perf vendor events: Update SapphireRapids events
  perf vendor events: Update SierraForest events
  perf vendor events: Update SkylakeX events
  perf vendor events: Update TigerLake events

 .../pmu-events/arch/x86/alderlake/cache.json  |  56 ++-
 .../arch/x86/alderlake/floating-point.json    |   1 -
 .../pmu-events/arch/x86/alderlake/other.json  |   1 -
 .../arch/x86/alderlake/pipeline.json          |  44 +--
 .../arch/x86/alderlake/virtual-memory.json    |   3 -
 .../pmu-events/arch/x86/alderlaken/cache.json |  52 +--
 .../arch/x86/alderlaken/floating-point.json   |   1 -
 .../pmu-events/arch/x86/alderlaken/other.json |   1 -
 .../arch/x86/alderlaken/pipeline.json         |  42 +--
 .../arch/x86/alderlaken/virtual-memory.json   |   3 -
 .../pmu-events/arch/x86/arrowlake/cache.json  |  13 +-
 .../arch/x86/arrowlake/frontend.json          | 135 ++++++++
 .../arch/x86/cascadelakex/floating-point.json |   6 +-
 .../arch/x86/cascadelakex/pipeline.json       |   2 +-
 .../arch/x86/emeraldrapids/pipeline.json      |   2 +-
 .../arch/x86/emeraldrapids/uncore-io.json     |  12 +
 .../arch/x86/emeraldrapids/uncore-memory.json |  20 ++
 .../arch/x86/grandridge/grr-metrics.json      |  30 +-
 .../x86/grandridge/uncore-interconnect.json   |  10 +
 .../arch/x86/grandridge/uncore-io.json        |  12 +
 .../arch/x86/graniterapids/cache.json         |   9 +
 .../arch/x86/graniterapids/counter.json       |  10 +-
 .../arch/x86/graniterapids/gnr-metrics.json   |  36 ++
 .../arch/x86/graniterapids/pipeline.json      |   2 +-
 .../graniterapids/uncore-interconnect.json    |  19 -
 .../arch/x86/graniterapids/uncore-io.json     |  27 +-
 .../arch/x86/icelakex/pipeline.json           |   2 +-
 .../arch/x86/icelakex/uncore-cache.json       |   2 -
 .../pmu-events/arch/x86/lunarlake/cache.json  |  11 +
 .../arch/x86/lunarlake/pipeline.json          |  18 +-
 .../arch/x86/lunarlake/virtual-memory.json    |  18 -
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  29 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |   2 +-
 .../arch/x86/meteorlake/frontend.json         |  72 ++++
 .../arch/x86/meteorlake/pipeline.json         |   2 +-
 .../arch/x86/pantherlake/cache.json           | 278 +++++++++++++++
 .../arch/x86/pantherlake/counter.json         |  12 +
 .../arch/x86/pantherlake/frontend.json        |  30 ++
 .../arch/x86/pantherlake/memory.json          | 215 ++++++++++++
 .../arch/x86/pantherlake/pipeline.json        | 325 ++++++++++++++++++
 .../arch/x86/pantherlake/virtual-memory.json  |  62 ++++
 .../arch/x86/sapphirerapids/pipeline.json     |   2 +-
 .../arch/x86/sapphirerapids/uncore-io.json    |  12 +
 .../x86/sapphirerapids/uncore-memory.json     |  20 ++
 .../arch/x86/sierraforest/frontend.json       |  64 ++++
 .../arch/x86/sierraforest/pipeline.json       |   8 +
 .../arch/x86/sierraforest/srf-metrics.json    |  48 +++
 .../arch/x86/sierraforest/uncore-cache.json   |   6 +-
 .../x86/sierraforest/uncore-interconnect.json |  53 ++-
 .../arch/x86/sierraforest/uncore-io.json      |  27 +-
 .../arch/x86/skylakex/pipeline.json           |   2 +-
 .../arch/x86/tigerlake/pipeline.json          |   2 +-
 52 files changed, 1623 insertions(+), 248 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/virtual-memory.json

-- 
2.50.0.rc1.591.g9c95f17f64-goog


