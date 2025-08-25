Return-Path: <linux-kernel+bounces-785560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9201B34DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96133AE593
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E95029ACC6;
	Mon, 25 Aug 2025 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2BzXmn2w"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F6248F7D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156333; cv=none; b=EXaEXroKliRih47uDHraSVy3SVb6oD8rsR+uX8zioEq5sByak7xvNeeW0pL1hx2mniF8q4FWJCsTPeHyz8c1lcV2e21mLLf9FIv3oK0I94EVPS43P0px6R9gEZHie5MFwh2q9UTVv6+9AHR+KaOhrwWX9KdH0en3hYAYX9gI8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156333; c=relaxed/simple;
	bh=PmWAfAWt560F/LSSwylVCN+pU1OCNd/QiSSAU1IsN+U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=NqH/21qPQVjiJeP8r3bbPEblKc96IX7cG9gIAWqO+6xuary9nqL+4ZOR5hfJcSTbneUhjk2lXITj1sEKrI22S0Ksrrkb18gGOhL/ocJVoiFiUnarJXQ1W5XCW51isrZ0VHIe+K630EFn18UV8rVFF1EKVHxk+UjUFTQm6VFMUNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2BzXmn2w; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-325ce1082bcso1159415a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756156331; x=1756761131; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=//Wml+s18khKI0fnCy0lgv2axz1YAV/tsPqpSLjoo8s=;
        b=2BzXmn2wEQ3RAUnY/n+zTj/CoCbRyklh8b5mny8sSfXrQhYgQSAHVdJ3ouaYFPhv56
         yHubyC22W85Zyn+uLLwOq8YAGBf4shvb3I9HHQEZxMUDOjjZhFxsgjtL0/H93tBZBmnZ
         jx1WnA+TmLexlSYXYa++j4E602decsjMZpG4MmAM/QWvFR9wDiIkiGyT6Dau0/HblQqk
         SfUSoP/7FVD/A6h6jPbk0FPGPIaf+FPqsk5p/nNJLhT2BiirDJG4D3riNnHn9c5iP/e/
         xqXKr3NGv4wt3qGp9lluRJjDZlfnfNc4r1961veB7jOTiJQcytlTs1ry3BiVJOJkwOSK
         1Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756156331; x=1756761131;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=//Wml+s18khKI0fnCy0lgv2axz1YAV/tsPqpSLjoo8s=;
        b=v9FCPGG116TZ0u+4Hq+tet0vSTwqXaOwDGFgfkXCF0L+FV7k0SJRfSVr4NFbyf3ZVu
         GrloxJ756fVcCh61XblsgRv5d6MkHVaFurPyQ5jB4PRyjlklu50VVXBd8uqulJL4tVYj
         bBrBZ2Se1COqrUgsan9tqgkYukEY/42qwN8Yq6JmGNBf6Xs1M+H7TeFeLmMea2q7H15Z
         s/pf4qUe/fxvKFdnTB7Wj8XqQMrQKilcl96p4yLYZWTTwQPt/jPVXcRxPdmEQDk0QamS
         VMJo+vsciZRxzuhOgTisCJuc+vObfHxNtAxHl1m3eNTvRERYMRgZK/IS9xONROju2w0f
         k8qA==
X-Forwarded-Encrypted: i=1; AJvYcCWCsyk1nQ/N50lovfVJDctDzzjI2Mzu+w3pwcyXM4AG1wq6K25PuG9GqhP/w0jGaSMTeOFqdHxL+Qk1ffs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1eIiYqCfiph7EYkZ6BEFpX+cI3moP2EGNOv0HOtjT2onsXha
	7qWKSXn4Wy4Z1iYQraGJkPdXf84XWqaq9cdVZytbtwjcSTlM6Kkkze+GVXgklEIfDMeXLNBqtKg
	FsW7J75A5SQ==
X-Google-Smtp-Source: AGHT+IFoltTPt9WrzKnoenSRXk+zHpOr/FhgQajId0XWETJtniibka7dvFVOXaQFGUucWcEtUMRr0wcJtQbA
X-Received: from pjbpm5.prod.google.com ([2002:a17:90b:3c45:b0:31f:6ddd:ef5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3842:b0:321:75c1:65b2
 with SMTP id 98e67ed59e1d1-32515eabbb3mr17580447a91.18.1756156331472; Mon, 25
 Aug 2025 14:12:11 -0700 (PDT)
Date: Mon, 25 Aug 2025 14:12:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825211204.2784695-1-irogers@google.com>
Subject: [PATCH v1 0/3] Improve event groups for topdown, add X event modifier
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In:
https://lore.kernel.org/lkml/20250822082233.1850417-1-dapeng1.mi@linux.intel.com/#t
Dapeng Mi and Xudong Hao reported that Intel topdown events have
issues with parsing when events are duplicated. While some of that is
intended, things could be better. These patches:

1) give error messages specific to topdown event grouping constraints,
2) fail groups if non-leaders fail to open (this appears to be old tech debt),
3) adds an 'X' event modifier to allow events to opt-out of being regrouped.

The 'X' modifier should also give a means to side-step future issues
in parse_events__sort_events_and_fix_groups should they come up.

Ian Rogers (3):
  perf evsel: Give warning for broken Intel topdown event grouping
  perf stat: Don't skip failing group events
  perf parse-events: Add 'X' modifier to exclude an event from being
    regrouped

 tools/perf/Documentation/perf-list.txt |  1 +
 tools/perf/arch/x86/util/evsel.c       | 62 ++++++++++++++++++++++++--
 tools/perf/builtin-stat.c              | 48 +++++++++-----------
 tools/perf/util/evsel.c                |  7 ++-
 tools/perf/util/evsel.h                |  3 +-
 tools/perf/util/parse-events.c         |  5 ++-
 tools/perf/util/parse-events.h         |  1 +
 tools/perf/util/parse-events.l         |  5 ++-
 8 files changed, 94 insertions(+), 38 deletions(-)

-- 
2.51.0.261.g7ce5a0a67e-goog


