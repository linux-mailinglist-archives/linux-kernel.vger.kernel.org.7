Return-Path: <linux-kernel+bounces-707091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66832AEBFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 21:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF407648422
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7362E8E0D;
	Fri, 27 Jun 2025 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXr3wGkW"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79103217659
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052269; cv=none; b=LD0k5YAmWNKte5zgiRoR1U2x0duoK4A3mC/SrDuvT3yBMuYk3PoSOMTbBGPf7T4b73IRgSDYEckw9rzwkHyD03OwR86PZrFmvTz1nTkCjduKCDqcsJbd3TLbm6SnilVFpf5asNQBej4m0kLGHw+HtOQ7dYxkvzibtcspbMaxGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052269; c=relaxed/simple;
	bh=8cwlAfASgjDaBAw+Dh0fOpNhqH2F4FYnFY1DzsrvDBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=E+ii7qM5VYjOPxVjrk4WlogJ+47y2/nix2naLhfNl3x2EUcqYGz7ZVmVt6MJ087guYjnjJ8TytMyKHC1xRKFdxA5T35u8ZPqG0ycF8yv134ENdEkrzcpYbBPiKfAJcIFtALQGY7NlHuLNxNR6pQRHQhWZ93SCpCVo1s41zgIRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXr3wGkW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2fb347b3e6so2786492a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 12:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052268; x=1751657068; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHyTiYq3fNklZMY+gxa5ISx5FFJqebiuY8EWbLD3ebA=;
        b=SXr3wGkW7Ii+aP8kPhBODPq630KwvzwyksAi+9weSWcuixRVZierLi9sj4SGaawgk9
         VkxFUcxOseNf2OUdyUTWUoGLzRP9MCagTAuAXEFkdqMANg/OM8+nt6XEkXFafuvNbrS6
         McdaRq9Muqi/2ixK9d1pPe/KlxxSu5yK3Xl5DDOujsPiSyuu7EnAbh/z/PHy/+Ww7pUm
         lYsxlzh1stWKKQHA0a1D6aXD3IjRlNGSxlhEY8pJ3v9dJbp3AcDj2GK2Luz/d++/I/LZ
         pMRmoX1AzxbVBOY8qpo+WnSy59AUa2k04qYdTOC5v/0Yr154pgvXCt0MC7rFUylIJScS
         VaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052268; x=1751657068;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHyTiYq3fNklZMY+gxa5ISx5FFJqebiuY8EWbLD3ebA=;
        b=NsgcTSfBmKzoVpSZ4vuvbr4MTsGIxexI5oGaw4SoZJ+cmFlRJtLAJyA63vDRVUTiFN
         TM2mGxXu29VcRhg8OhEUv50zIzUIoDxCad5g8O8m7asc4l0RBLz9kTTc45k0Lq+OVWb7
         LDQQWinZpIUpw5VGfw88yU4z1eCuVhX9Zc3JMZ1TtnUMr4H6tzbl9evdFVygNkQqbFuM
         EAH+pIoalKh3a20waFwBomqqPYLLMFd0vhop2f/0gNsKczzNQDlEvBBW5Q8fCb2hjDxD
         K1q+jUGKD6nPOe+E3PYAm/U3ZYIPjhiVFKTaNQYqTlJjmWe16YOGZa1HNnPDqnxyMLof
         +FcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPLa6YGCE6aWwhyLOV3B/TPf8XSI4CkeY+stMYPHFf8ofWdb73PAZBT0urvVholf8dTZH7SgPFAKgj+QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZzqkOjuAIT3OnudEIONshRoUsGvfUD/+3WAOsm7qwsmwNsxcL
	QABUnhrWD4vv08zM+YwlCqghbWS73Vxyeos13WReAYGThBXS0oypdp4vll46FmPB7g9T8gJsozD
	kgl1mdLS10Q==
X-Google-Smtp-Source: AGHT+IGTxwiUsCQVubSoLszlIZQZgfIIbhwFOc4KJ1lT0sZ+++wmkWp+9wQn4qXcOje47blqHHETLOxC8xbg
X-Received: from plkb7.prod.google.com ([2002:a17:903:fa7:b0:234:c2e4:1df6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e8:b0:238:120:134a
 with SMTP id d9443c01a7336-23ac45c1d67mr84881305ad.22.1751052267794; Fri, 27
 Jun 2025 12:24:27 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:08 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-4-irogers@google.com>
Subject: [PATCH v1 03/12] perf stat: Don't size aggregation ids from user_requested_cpus
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

As evsels may have additional CPU terms, the user_requested_cpus may
not reflect all the CPUs requested. Use evlist->all_cpus to size the
array as that reflects all the CPUs potentially needed by the evlist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 803bdcf89c0d..ff726f3e42ea 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1513,11 +1513,8 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	if (!perf_cpu_map__is_any_cpu_or_is_empty(evsel_list->core.user_requested_cpus))
-		nr = perf_cpu_map__max(evsel_list->core.user_requested_cpus).cpu;
-	else
-		nr = 0;
-	stat_config.cpus_aggr_map = cpu_aggr_map__empty_new(nr + 1);
+	nr = perf_cpu_map__max(evsel_list->core.all_cpus).cpu + 1;
+	stat_config.cpus_aggr_map = cpu_aggr_map__empty_new(nr);
 	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


