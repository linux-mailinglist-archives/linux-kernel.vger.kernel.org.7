Return-Path: <linux-kernel+bounces-735978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBADB09638
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7034A1889
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BC124502C;
	Thu, 17 Jul 2025 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZHe7fu0z"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0223A22D9E9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786175; cv=none; b=BMqFGG7PpmYYEFVLG8pHPysTHKTowZxDWt5JH79wGjNEieo/77xM5C3HzRbgPCjHPUyX8U3pUXm6MywqW5A2B6uWyXhLLqcjFKGoNnnxI+x6ig3tiM1IjBV9rj2jJNY1hfAm2BEqbI5+QRtJR4gcxEGRdniaeQsF8NHvac02bBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786175; c=relaxed/simple;
	bh=wXa1SCmjfrA/iYrTIx3xkr7OdsM/urYyoLsdv3r5x70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=A262ihNtI4oPXY2EVd5YCKazVNO6Cqo7jMpEWXYiaKjgapZXqUJfi+g2ALjHUVzO4mBxVKdY2p1J/2qNDLRUIwa7VTxbTx8KrZ6lcF+X7yuMh7VEwNarvFDYfYqru5EVi0WL2zbONf8dgOvFgjziwEySaqrdHQBIES66A0C0/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZHe7fu0z; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138f5e8ff5so1477155a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786173; x=1753390973; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZM3pCSwYMC0xtzhmcoaS56jTJWwNHuIZbVeellQWzo=;
        b=ZHe7fu0z586wTm8v48ZV9Iqw6nHOctzMHHrN4I5o/0/ed8VM3RiPIiBcnB6rtrLRjt
         sW7J/p/KZ+Ympi9Lkhtv7r9IM3GBIpnbiCVnqCVVHAzS6L5u3+u3jHh003nijm0i5SL/
         /X7rgahy0ICkTPV5W+PF6XVWUce2/CVs3YCoHTrBRfJxfh+igFbWY0XcmXkX5wnjL+NY
         Q3T4taDmea3oSZd4OFY1JuCvmAXW7eXORs7GSr+RhwHdy4LEO45xa5YxZlIeSK4WpCHx
         dW3SHvhE+q2hxDCtlQLq78SsTY5L/YoMQkXyo08Ho+TLXPx88za+d8RFtk+R6us2EfnY
         BvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786173; x=1753390973;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZM3pCSwYMC0xtzhmcoaS56jTJWwNHuIZbVeellQWzo=;
        b=w7dcC6kM2e00UtzYqoXZ0ZiJfMpQw/alzZsRqlh0Y2qGDTIWQi+OwGB8pvv2HJ2WBY
         M7iekQ8YYHiz9QF34ATAbDZdhsrM9wAGeBxMg3BdPhOL7hF96qzXlFOicacYGyiy33E9
         K2bsKK08qc7dE03yjOB6ah5rJRV064TxhZ/ISj3h2CymaLaKgOGknESZ1WRG1rL3pmJC
         W0v/2ebc1C90zStUc2RKWbvLnAtzo/5tpb4RRZC39H/eAgyoTa0q5zFj3NXWFZlGAD1V
         imtCrzcoRQeeGOIoQ3P8sJkLz8mWKa9juiukN8kOIU2xvXVWN/oTqDgQP8sxUmsQqJtj
         zBRg==
X-Forwarded-Encrypted: i=1; AJvYcCVDBbFmaN0/6cPbcNWx75iP58hU/vXY/qwfQutxcH9IEvPugGVhlaF04Fmrsw8H8ZBgyyAhsLL8ITh0lik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5JBoDe9n4unAtqeBPrkQfXQbCzxhwUbPgJNMBFNIJ8GNCqNBP
	yARlagpe7+nReScHC/iQmavZg+QyDgd6vmaaDZa/J9okv4+BsSV5C0/l2PAg3UoiLaQ93Ry4VGj
	TbtUiRioL+Q==
X-Google-Smtp-Source: AGHT+IHUu3zgtgmAaVp6ifFETkP1mzQNAhWfaE9t/IlHqPOCXxgmX4IzE1WxtYzCaCEmo6bbXbyj/Om1yeyA
X-Received: from pjbst15.prod.google.com ([2002:a17:90b:1fcf:b0:313:221f:6571])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58ec:b0:311:c5d9:2c79
 with SMTP id 98e67ed59e1d1-31c9f42e84dmr12055444a91.21.1752786173521; Thu, 17
 Jul 2025 14:02:53 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:29 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-9-irogers@google.com>
Subject: [PATCH v2 08/12] perf evsel: Use libperf perf_evsel__exit
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid the duplicated code and better enable perf_evsel to change.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ba0c9799928b..af2b26c6456a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1679,9 +1679,7 @@ void evsel__exit(struct evsel *evsel)
 	perf_evsel__free_id(&evsel->core);
 	evsel__free_config_terms(evsel);
 	cgroup__put(evsel->cgrp);
-	perf_cpu_map__put(evsel->core.cpus);
-	perf_cpu_map__put(evsel->core.pmu_cpus);
-	perf_thread_map__put(evsel->core.threads);
+	perf_evsel__exit(&evsel->core);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 #ifdef HAVE_LIBTRACEEVENT
-- 
2.50.0.727.gbf7dc18ff4-goog


