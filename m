Return-Path: <linux-kernel+bounces-842411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DD1BB9AFF
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D6AA4E6707
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314F229D260;
	Sun,  5 Oct 2025 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QitbECAc"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0472E29B8E6
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688715; cv=none; b=Ctsm2/1ZLnD20BTQQ/hkvOuko5cuE4yV+mpAEyHZrdoJ5o6l4PMW5FUtrq2UqHEaMLhywlA/KpFtqXZR7HLPqtK5+Bq//KUQGf9bZ+gMoNVXVgkIzeJdLmw9F7OVvxIGU3AuVC4TuTihZaDf5iLvA2kD8jHnWwWIFlz9vLFxqtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688715; c=relaxed/simple;
	bh=hdoCQdAbtsUWh5ZmAMAISE0mVBpYI+EBEkd3D2mOABY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T7knRiINX82l45DF8ttZr2hP6PoKi1ZnJfn4hxcNg/ELKyA0+Qg2iigsW+7ZaicV2ZxUc9oxPa6dFS/F7FzkRUH/TG+JeTFCEN3sY5pos6HiUi5N7hzswVPAcy/ENjPbaey67GyRNW0Mqtp5b6tz+u7eQqxdFkkxswK6ttukWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QitbECAc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so3357375a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688713; x=1760293513; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmHQ9jUxY2dsC0Ng49EzdCtxcjpPoOc0ALb07dGw4cA=;
        b=QitbECAcy00f9B+2FI94ZmBCi38POKxdIruWgupGB+tBdISiwwV1e07Vgec7gOA+D9
         a/Wm9irvkFilrvZ+Wk6vN25vrSkDRjmjRkwdQJLgsmKB4iFnTHGFg0KOues8j11EBpLr
         n/G07/xnSIwPVr5hCLq+HIJvu/qT4IFNtjw5hRGmBXjusqsRlXhKAWqd4px9SueZ7dhB
         vLQ98mfCBZBdl2s3gmt2Niw4nXTX6iwHEU9Vc1HQUBo1PSjo0Ze4jegjvqRYin/kQpHQ
         OBucvs0TP0ktWRvlF2mj4W/uVfFdINf4l7u2VLnDA+OgvLQpzbunmAWsOk01V6aOweqs
         dv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688713; x=1760293513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmHQ9jUxY2dsC0Ng49EzdCtxcjpPoOc0ALb07dGw4cA=;
        b=XXJeQ+0V/64xcXUUj+NOjR3OSOi6qmZ9c+1IdXaOokAYgKN+nYujIyWISgUd6XmCzP
         EMBhfjsFfh42h71INBv1eloiJJcZ6P3IACXootVhhtYQ6DULmx/ko7xZxbPUFe3qTjcF
         mhojM2dCDS96hfvhR7FF3HeOLyVjh1+LSvq8eRelm2klYk5xSgpHMlXnND4/0dsanVGL
         beNmqwmk3USzIOwbTh7t6xvOiaImcWubU8ql0hWRQsAgFZJDYR4eEz7QFw4UQvV+9mAx
         EJpQEwUt6mjOcmzBRCg4tzX8Q/pbXHNyLcRKJxlJJNiPQ/jB6eXt052aRmSm6ERTPQnz
         DgkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5dlaKAXiQVLZV5vWtKH24Pyv/PJXjxKLyEobe3lz74sMMQ94STpv1NkTWzi4CankwTNqaQoQpYQ4+Rlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRPAOnTslV3nvcZGcuQNzQ4ffAtwkK0ISzP52Q/HCwV7l1RhU
	ciicic00QYzsikV1gC9oAFroULwBF7cpmv6LFzTT3Xlqj3LIhU/aqrrP9Am/jl+GshIjpS5VbEB
	zaPEfWTw1gA==
X-Google-Smtp-Source: AGHT+IGxfBHBtAfDVShxnkdfD4AX6csx/jar1g5lis37MLHrFEcPg8BXzuFbbyHPvfJr+Z8jNe1tOat4HX9C
X-Received: from pjbfr15.prod.google.com ([2002:a17:90a:e2cf:b0:335:2897:47c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a91:b0:332:1edf:a694
 with SMTP id 98e67ed59e1d1-339c279e567mr11876520a91.31.1759688713326; Sun, 05
 Oct 2025 11:25:13 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:21 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-19-irogers@google.com>
Subject: [PATCH v7 18/27] perf top: Use evlist__new_default when no events specified
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Rather than distributing the code doing similar things to
evlist__new_default, use the one implementation so that paranoia and
wildcard scanning can be optimized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a11f629c7d76..710604c4f6f6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1695,11 +1695,13 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 
 	if (!top.evlist->core.nr_entries) {
-		bool can_profile_kernel = perf_event_paranoid_check(1);
-		int err = parse_event(top.evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		struct evlist *def_evlist = evlist__new_default();
 
-		if (err)
+		if (!def_evlist)
 			goto out_delete_evlist;
+
+		evlist__splice_list_tail(top.evlist, &def_evlist->core.entries);
+		evlist__delete(def_evlist);
 	}
 
 	status = evswitch__init(&top.evswitch, top.evlist, stderr);
-- 
2.51.0.618.g983fd99d29-goog


