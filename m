Return-Path: <linux-kernel+bounces-829960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC417B98551
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D284818953CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DD723D7EE;
	Wed, 24 Sep 2025 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+bee02u"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE231D6DB5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693763; cv=none; b=F9v4WSjlDUiOKb/i/rmwQMG0AQjtslE1iAf5f3ryk7TMpcxWtBG593hgU7VNplYl2eKFuMnmP1a3MSqvdL9ywj3gZnqf06fS0vjMuZUotZyWNJCQfjcyn7vlW3TqnqJU4xGPPg17IcBvDho54cWlW/i5wQjA2jYteq6Vu03Cu/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693763; c=relaxed/simple;
	bh=Vt9MfymYDQwEvit0KVgc2ClANbmnauv0q5tPcOx97N8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=sF4gtghOLnvbe1id5jsrXwhaeUK94HHD8dKE2ucIvnwDpZd7EQ3lqeC7lVXsVRtnc6Ska7khOWrlaK2StdkNmHnNf/hHgP8APD1ikG36FjIcluWlZOBvRMIRltvScN68h+QaF8hv3vEu0/EBBiIWzo7zE6Izg47nEqPXhMg+3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g+bee02u; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ecab3865dso9472737a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758693762; x=1759298562; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XD1WIzYiMatnlzgDrUYCZrBYkmo/k2ltaCjRnSuYXHQ=;
        b=g+bee02uuZQwV13yywMc7eeb2pGv32IMXeB9DNbFlUprEFJBN41IniEXPV3Jhn0uIY
         xbwlCkeYi29m8fLgrNYNYpY0cU4yQHNH63ZMtZtd4ugAhInRFIS7ygCcT5R/vozfLrPM
         Ny/SQ4c7h/LYr+56JlcfaZgx2fTNV9aBeGl9p3l8aQGyg9Qf8GdgfzOcwBEqSr2KSCIt
         OhiuhYNUR3HyynsAZalDxcTzIf39kg4C+CLYPkgpXECr7iqhMtZs+bvqVkH00GbA8t1J
         7HVhHYlXlTz1BLxhLyUEARQQMJkHKtpRwenVskcUYB79nykpO+K4ovolHESreoA+1lnO
         3RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758693762; x=1759298562;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XD1WIzYiMatnlzgDrUYCZrBYkmo/k2ltaCjRnSuYXHQ=;
        b=PSRK3qt4aIwNxmdx3EQJp7P5eNkHcvd9XZFGdz/JVPRUpeOXwxlsA2Xuto8JkzTBSA
         t/kMgw5IcGpxt7dQ22VcviaVTvLALDY1eDIcqRtSq5d4hxQ6tM5K7WYI4tAMwuEHyIi4
         sJPQ8pRV7NTUzitP/fvnkO010EZXBKnDT5YMHNpRNZwk+MP+9ZtY10Dtev6OODuJlGx5
         f4nndSEtgurbYU2dCAvLM/RcC87+Y7TjNVFF8U2c6bhqCw9HG4PkY1goR/5Xm4UbHz4k
         9D3rNcfAlf3IIq8dUrNfmIraeZq7uTxbxuPGEIsI6giEmWwrNRgwyyqsCLNHeqrJ5P+G
         CL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXLvu4AsZf6mwrBTb5wtsIHHr1bFUs5FJf+JAlQXhT7DjNiJ/mWaSxJQoSeQx3fYA0KNmgmXq/MUnwsYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWHtqKaaGR2OGlMDbRjyayst0P56f3ieN5b9eXHaU/Dco+svl2
	gWR/P4SLCpHkPLthXsjPgyg9KDlb/Lg/uQLMXqDodhWBlBkRn6pvljEhTOBIdWcB0CrLogs3m5d
	PIKhnFZuUyQ==
X-Google-Smtp-Source: AGHT+IFL4L1MIYQhQl9in5iuhGuEVE1aJyAQn07XgjJnmT2SlWg3JCnZlvrYcGnXKswwwax36O9bLO/ZdUsV
X-Received: from pjbfr17.prod.google.com ([2002:a17:90a:e2d1:b0:32b:65c6:661a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2543:b0:32e:7bbc:bf13
 with SMTP id 98e67ed59e1d1-332a96f9bd1mr5398943a91.34.1758693761729; Tue, 23
 Sep 2025 23:02:41 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:02:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924060229.375718-1-irogers@google.com>
Subject: [PATCH v1 00/10] perf vendor events intel update
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update events and some metrics to the latest perfmon versions:
 - alderlake 1.34
 - arrowlake 1.13
 - emeraldrapids 1.20
 - grandridge 1.10
 - graniterapids 1.15
 - lunarlake 1.18
 - meteorlake 1.17
 - sapphirerapids 1.35
 - sierraforest 1.12

Ian Rogers (10):
  perf vendor events intel: Update alderlake events to v1.34
  perf vendor events intel: Update arrowlake events to v1.13
  perf vendor events intel: Update emeraldrapids events to v1.20
  perf vendor events intel: Update grandridge events to v1.10
  perf vendor events intel: Update graniterapids events to v1.15
  perf vendor events intel: Update lunarlake events to v1.18
  perf vendor events intel: Update meteorlake events to v1.17
  perf vendor events intel: Update pantherlake events to v1.00
  perf vendor events intel: Update sapphirerapids events to v1.35
  perf vendor events intel: Update sierraforest events to v1.12

 .../pmu-events/arch/x86/alderlake/cache.json  |   36 +
 .../pmu-events/arch/x86/arrowlake/cache.json  |   46 +-
 .../pmu-events/arch/x86/arrowlake/memory.json |    6 +-
 .../pmu-events/arch/x86/arrowlake/other.json  |    2 +-
 .../arch/x86/emeraldrapids/cache.json         |   63 +
 .../arch/x86/emeraldrapids/emr-metrics.json   |   12 +
 .../arch/x86/emeraldrapids/uncore-cache.json  |   11 +
 .../arch/x86/emeraldrapids/uncore-memory.json |   22 +
 .../arch/x86/emeraldrapids/uncore-power.json  |    2 -
 .../pmu-events/arch/x86/grandridge/cache.json |   20 +-
 .../graniterapids/uncore-interconnect.json    |   10 +-
 .../arch/x86/graniterapids/uncore-memory.json |  112 ++
 .../pmu-events/arch/x86/lunarlake/cache.json  |   46 +-
 .../pmu-events/arch/x86/lunarlake/memory.json |    6 +-
 .../pmu-events/arch/x86/lunarlake/other.json  |    2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   20 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |   36 +
 .../arch/x86/pantherlake/cache.json           | 1207 ++++++++++-
 .../arch/x86/pantherlake/counter.json         |    9 +-
 .../arch/x86/pantherlake/floating-point.json  |  286 +++
 .../arch/x86/pantherlake/frontend.json        |  535 +++++
 .../arch/x86/pantherlake/memory.json          |  106 +-
 .../arch/x86/pantherlake/other.json           |   44 +
 .../arch/x86/pantherlake/pipeline.json        | 1776 ++++++++++++++++-
 .../arch/x86/pantherlake/uncore-memory.json   |   26 +
 .../arch/x86/pantherlake/virtual-memory.json  |  248 +++
 .../arch/x86/sapphirerapids/cache.json        |   63 +
 .../arch/x86/sapphirerapids/spr-metrics.json  |   12 +
 .../arch/x86/sapphirerapids/uncore-cache.json |   11 +
 .../x86/sapphirerapids/uncore-memory.json     |   22 +
 .../arch/x86/sapphirerapids/uncore-power.json |    2 -
 .../arch/x86/sierraforest/cache.json          |   61 +-
 .../x86/sierraforest/uncore-interconnect.json |   10 +-
 .../arch/x86/sierraforest/uncore-io.json      |    1 -
 .../arch/x86/sierraforest/uncore-memory.json  |  103 +-
 35 files changed, 4712 insertions(+), 262 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/uncore-memory.json

-- 
2.51.0.534.gc79095c0ca-goog


