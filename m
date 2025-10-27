Return-Path: <linux-kernel+bounces-872604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8023DC118F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D1B5652D4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7AD32B9BC;
	Mon, 27 Oct 2025 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guz3NgtE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFC32BF52
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761600449; cv=none; b=lib81CnTSmgMeosLjRvIweznBCF/7CFrSxTGFQkDfMwZoVYr1rFqYQyBuJTbCstZ6os6irfWFH4mS9WSWDEUSrKOQY+4PEz5hdz4QTUD9g/QpSSn5PLdK5/uRI+lVsGnkgRISiHE6jaXswgKvuwyyIgCctNI4wKUtK2q1ybH8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761600449; c=relaxed/simple;
	bh=rJmpBhphHSptl95TDH/dae2eMlNxWhpC8hhG3/uYt5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhuGejyJZKw+MnQ7nqxhmj2X67R7/estKxOUep43cTPc9PSxFhATy0hZgrD+nRD+KE1M1kLeUYQDjZmDnvKFoYiGtgSb/aAwWr77G8ULKja8xh3Gy+aRZHBbc7vqWwn1QuxGQJWvW5caOIQmEP/XgyJlLnLvSJOh6Ps5x75RVeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guz3NgtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CA8C4CEF1;
	Mon, 27 Oct 2025 21:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761600449;
	bh=rJmpBhphHSptl95TDH/dae2eMlNxWhpC8hhG3/uYt5w=;
	h=From:To:Cc:Subject:Date:From;
	b=guz3NgtEKPxrwSuVUnGxlSKzkZenoZRgUpWAW23aZZjFuDazUFrpjwpiMdlBBDCxr
	 5p6y0csv1i3ZGg7I/l6iVkLYYbefCJtcaGbwkSyyjeR7+tJ39SRSzFNb2ZbSPoCs5x
	 C2jEBmt2tDhcGR+yiRF0A3BNri0hOZgTv4HAxmAMjfMxz8LQjN4x4pIDGnDVW3CvF/
	 Cq5kgULyi++GzVJIR6vLyYc3FjJLGy9QtALMrt+ASMMLKRUO7C1Szj7trQMWbLoC8J
	 Jf+iAkJwzCCIO+BQbtLqA77XtjZccCujMmNd8/MW3mt2a1kBB+GNPV97T5unJJC7+J
	 GdToRbldKBbsw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH] perf/x86: Add cond_resched() when allocate/release DS buffers
Date: Mon, 27 Oct 2025 14:27:24 -0700
Message-ID: <20251027212724.1759322-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On large systems, it's possible to trigger sched latency warning during
the DS buffer allocation or release.  Add cond_resched() to avoid it.

Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/intel/ds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0b7ac1c7594ea92..c8e90c5a8d3390ab 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -754,6 +754,7 @@ void release_ds_buffers(void)
 		if (x86_pmu.ds_pebs)
 			release_pebs_buffer(cpu);
 		release_bts_buffer(cpu);
+		cond_resched();
 	}
 }
 
@@ -791,6 +792,8 @@ void reserve_ds_buffers(void)
 
 		if (bts_err && pebs_err)
 			break;
+
+		cond_resched();
 	}
 
 	if (bts_err) {
-- 
2.51.1.838.g19442a804e-goog


