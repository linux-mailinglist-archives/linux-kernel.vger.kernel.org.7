Return-Path: <linux-kernel+bounces-832952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B696BA0D57
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA3C384B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F030430DEA4;
	Thu, 25 Sep 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hldYki0x"
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0D35940
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821264; cv=none; b=t3k4MvT/xy6f0Bx/d7XkVmm4+fYECZinRKvz7QZt+KT9IGSF19ag2BlVDRbsb9R8bhEmOCP0cL2yfKHOoxYljOdsmVQgtBpJJTKdeJjzbgO3Qlk592KxmIVegmXmu8k9NbE9m9+cqM/1YHGOcgvaLiMTGr06wlhDOafq10nZrdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821264; c=relaxed/simple;
	bh=1aMzbPXXTV6s8shnpFeoB2BqIpLtvMoCfxhUmtdjiSg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Q351G/tFcFnx6N7RptkrWn7nZK6qdRdMZDHgjgbfbtq9pPcSP5rfQ5dqfsyQ1hMkOQZ0d/Kh1rrdo2VGdIn1JeH0ZONlQAL86FsZS54eQpE2KdnIdmutUU1GB6tUgp13n6HfLL0q943z1GmtHy2CJ5mTUViPe2nqzn6zn5qCkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hldYki0x; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-60f47bc771aso1233341d50.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821262; x=1759426062; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=twFyA4eORy0F+hKQH+6fcNvXcelQ6Qor5Ir75U2uMhA=;
        b=hldYki0xAh0kLV2buZRLd4DEzu/phrTs5+rJVtPFjk0nmFPWPjb8clAWQ7LCrj4E8R
         F2tn92KC/4rcmavTzvLjNeMN7pjyE3ZFnArjUFN2kxhZ+YuqTWRpcWzbssghYhO6U3Wb
         5Eq5mxFX7XN1Xe5X9Wdm0CpMIruVbWnsOLidhHs2Y+WgW8Jip8FatKFjCapFiYRx/key
         txVHpCbxAcpbuOijQ+URMbQZLrkxzKOq86O/P9lgMQ8hpjYVACqvjil6YDXP9Uiau4i0
         Sbh5PjWfxtI7AJ7VBRWczEgzJt3HTp3+/vpfGnKzPfRBDo85OXtf1VlLr62uqPqSY4i9
         rdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821262; x=1759426062;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twFyA4eORy0F+hKQH+6fcNvXcelQ6Qor5Ir75U2uMhA=;
        b=eG3ebk0pOx+KsUsvgTcpbGmUP969gRv6LQsK6Fnr9yH6jbMIwpGH+ca1b30zJVQoN3
         out+0sQS1jB5zkvoBFB0ZfxjNmAVPs3XNT2BVGxBNmJE1yNy4V6vFfGXcyxMskkVq7qp
         u0pzZD1nnbCOSX+YeYZU6JEIvw3ye7eW1wWIvvlOOSDdjzuTj7kn/PiaTvTxH/O0VI0c
         1JJzRdE7R/62V8udWRmZNwq2QoykLB9OVTdPJh/EbvsMnEBMV7Kp9L3DOgQDlKL6VJbR
         eiEAgQtPy1rHFtstb6V9oERgJD7w8Z9BUj4KUGJuWroF+urHtbswT4MKhflcdp3jC3mT
         BL+w==
X-Forwarded-Encrypted: i=1; AJvYcCUaVApp+JIEDpV/PnTI77F4AqosTxnFPBvT3uNkJcd8y7RLMyeDAbAXPgztIMyPGyRxHn8L0BwJc+/jBMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsuLM/OnHOzlG71nbJenEI99M1FdhIVHpTlrB5JgYzUMldiECT
	F65X7hlPywa3jHtkL6/xzkDrc0VhbFygJMeVlhNDI9X56O7fZFfD2MU4cG6MmI3ifGTJEiFkN3P
	npspjfu6Zgw==
X-Google-Smtp-Source: AGHT+IEcnlGjcYu4VtKAKyC7RJYe5WejLIMJSsrrgsndDXTrAUuZ4rOx79HSoDfyUmL7gjjARwRaPPXheIUc
X-Received: from ybcs3.prod.google.com ([2002:a05:6902:5083:b0:eb3:8782:dcea])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:1a0c:b0:633:bf80:8b2a
 with SMTP id 956f58d0204a3-6361a7b96eamr2604704d50.29.1758821261600; Thu, 25
 Sep 2025 10:27:41 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:27:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172736.960368-1-irogers@google.com>
Subject: [PATCH v2 00/10] perf vendor events intel update
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
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

v2: EMR/SPR cpu_cstate metric fixes.

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
2.51.0.536.g15c5d4f767-goog


