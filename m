Return-Path: <linux-kernel+bounces-896200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C0DC4FD64
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5E518994E2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927493624D4;
	Tue, 11 Nov 2025 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x593KzL6"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3F33624AD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896164; cv=none; b=thR79kSUs3NTUIlvGYknqh1fPHXjIzsnjCNX5BtBGqprxpWL8UETlfYXIQwXDFlOYrO9VCFJdZ5IMnbGFnVRSgFM7cjelp4/lVAtzBbrKa8YMCi5ErjxiCmS+yX8pSIHyDhHDJRVQ8TVaSlYYe0kuoIo9oHDft4SywzmZaoHhzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896164; c=relaxed/simple;
	bh=7NP/VCWcDtaQ9ddY1vDzUSspDiDop3c4KIH6lorm7/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EgglAgbvGxX2nabDPNq9xtQXL+odDMJL16Fkho8UggUHuGuIu5Y3CQvvn8kAoxIVFhi5gURxDUYb/9FkiiVMw4+SZNtpcHN94NYXv5VcsGBEQHOLxFHjmKL1z1ywd308R+NbOaaUcuEqftTbIoh07UEnRO581rDVfTG1cyLbIX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x593KzL6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297df52c960so3142745ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896163; x=1763500963; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bf2tG0VSbGuTREXl21iJqSVPQmFIFuxPe8RAulQFiSU=;
        b=x593KzL6g0E/L2txD3DiR07Czu44ihT4HEu0m+644SwPVeUF67hG8l7t8ZeWJ92kTg
         l/JsonecYHqa1lM4h3spcBNWXn7rV/L06Wb6xrTaWvsIpdqiKG1ofjPVel8TddJP/ygC
         wIhxe5vz5FAdz0ZhKWJzICm6EksFD7d65zb7m0xOBPzyZZB3OnKFNmu6dQk1G5rOh0AD
         +ZkX56FbitMdaCgdcy1tJmi8VQEq00uJ35qCgf4SUp/IPnoq0bZg/6k9KwKth39jv7l+
         f5g0/qao80KHSojTP7j7fnf7mhdWOhcHZuKbRG36UTxrPxkS0DRiMApuyQlOI6oS/opx
         P20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896163; x=1763500963;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bf2tG0VSbGuTREXl21iJqSVPQmFIFuxPe8RAulQFiSU=;
        b=oAE2ERQLRb8jjmsae+8o9gXTF2+5u1qYvgPPt/t5v65nLIPVBrbc+hQ8OLbG6FlpnB
         0kzbSFno62TtRK+yWeyRL4VkZ7Ua/NVaMfWvxGc6VRsXvCARUepbVolf4ww8XRykhMLT
         RD+/zxzPWm4Wg9ggvG2UgG4hFRvAzfQsw/boyWNSk+CWinauL9bRyuo0XTUl68swdRhQ
         dBJtYxSgTtXN6p1RcDJbfcYAK89twsf9yBdZ+XyZQFTSlhc2mY1KIA8wUjOS3EssZnTb
         JueRAHbM9iWzhMvKFxQ5ClJwHCLBABnz8Q1FMcRpVPTroGFlQb3Iqmbqu5I0bG7VZX9b
         GQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlDWnuVVF38Ui+JP5fz8U+yo/vZ4Qx+2RqL19y8OOUp99VGO+mlFb5wcSgXmKDhDbexMeWA1tCi7KqGIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUvgj2D+EO7MMQitNO11ROBxAmXqf8sfqRUh8fpQE9DXUWmEgW
	XGNO0XyjN8DNnzd5WDEX79qwE+Y6cCFP1Z0OTEIHFWlqRbIqDPcLh9sN58TGiAL/3JUFC1cf21R
	1lsuvmP8BEA==
X-Google-Smtp-Source: AGHT+IEaAfbGuKuXofcRBR7ZE0Z8YVSclMV+mGctbsfRk2ZunUgoxJ/7KN6O7H2y2FLf5EBuyNzYuRgphVjY
X-Received: from dycoz6.prod.google.com ([2002:a05:7301:fc86:b0:2a2:47b6:b541])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0d:b0:290:9332:eebd
 with SMTP id d9443c01a7336-2984ed79e33mr8797715ad.10.1762896162843; Tue, 11
 Nov 2025 13:22:42 -0800 (PST)
Date: Tue, 11 Nov 2025 13:22:01 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-14-irogers@google.com>
Subject: [PATCH v4 13/18] perf test stat: Update std_output testing metric expectations
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

Make the expectations match json metrics rather than the previous hard
coded ones.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index ec41f24299d9..9c4b92ecf448 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -12,8 +12,8 @@ set -e
 stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
 
 event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
-event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
-skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound" "TopdownL1" "percent of slots")
+event_metric=("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/sec" "faults/sec" "frontend_cycles_idle" "backend_cycles_idle" "GHz" "insn_per_cycle" "/sec" "branch_miss_rate")
+skip_metric=("tma_" "TopdownL1")
 
 cleanup() {
   rm -f "${stat_output}"
-- 
2.51.2.1041.gc1ab5b90ca-goog


