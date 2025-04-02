Return-Path: <linux-kernel+bounces-585706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E56A79658
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 22:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94F53B3C8F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715881C860E;
	Wed,  2 Apr 2025 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgjMtkGi"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92C1C862C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743624975; cv=none; b=txlk8lTjgKx+TfyKUJ69I9hP2+/xavK4obKbKjveFW4tDODT5O5U4Ixwch3rsgFgy8+vaoClTnMuRDsV1TD5xeuplK8ob1BsAvDJnaUr7ZeEKr9TxxNrE17aVfwQPT1BmuWvMQI++NB6UhOIUbaOda8Nu5AgH6obJ3nubpGMcFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743624975; c=relaxed/simple;
	bh=XiNzOkcuL27Of2YZ2wREz4qh6lg6mlM41Gl2KllA77o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=gE83GL7iIIgQ533UP+jmH87ZHSCmQobalapUBu/PW7XHU9fcMGUqZBq9swTIwIOdHueU7cQ6pqwx39i9/oyfVP5jFtJjgtJPgipj9+xZgDVJzzeHC+mcjOt2xkoD4WFzEvodG9v2Th5f3oomyB6bKLItbzY0TJ8mVLowpw3gFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgjMtkGi; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af8a4410816so179381a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743624974; x=1744229774; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xA11cEKLBoE/I2FkZk3fZol8WVBntbIlFE0q5Xw7ieY=;
        b=bgjMtkGij/fQJi/WzoAWw6awx1kDgWVLY4FOBXiG8/Q6pIO/WELILR4Stuke0EqjU/
         3+Vn48zMjmE8mst9mOwIiBTORXgWqDJ/0AjevXHJ/nCTWnNBar9iXh5bPpxKSJRNwBTU
         1tFASMBOspNC7GjKS/kRpyWJv0SI7anKO4fwRn2MkEISJz/e2GGizct8YmEXN8Qc2PFx
         ieo6/Flm5pJRP6unfEjLuD2WDq2yRVhgydbgS2vLJuCtPD/v9vqjf8JjKydhJVTYDs8W
         ojfRvroEHUaC/R2ubLG9h7C5T6F6cErz8yPjgd2hjhhrx4ED5heJ06oeZl0E52rDKv2Y
         PH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743624974; x=1744229774;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xA11cEKLBoE/I2FkZk3fZol8WVBntbIlFE0q5Xw7ieY=;
        b=NQKbCG9VEyOhHWu/SFMa2AR3Uylu1aOHjsyXQCwQVSw8FHIGCPtwlU3XgX5OwdK2WO
         k4MI6239xV+1Ueyn+Ew0zIr720rdxFAUjmRtCpb9ZpSso30iUfAk55WxTx9LsJQmpPki
         PTNNOeNNRDm6ohy0+WurMUKDu3b3XSpdML+xI6DrMtMj4FKN7UPzp54J+l3xPkvWGJWR
         b+YParOqj4/rgDdfPZasDg4duqzMA2dC8gCsRnGTr5DF6DU5J8wh50tIldqfb7fGgxVN
         ZZUbWMrL+QXjUpoc2WlS5XSGZdc14XAfEcxTL1wyoATYt2fgkP7Z7n+l1+je1/Hhkw/V
         iFug==
X-Forwarded-Encrypted: i=1; AJvYcCWNVct2ppSRQC3z4TEQw+Z9GDtQAlKwaij+HbLPxRG9F/IgseyYG9KOYxDPDfJVsd54cteHJZWunjRVydU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEEeEjGI9+leYTzNofQ70aao6w4MspGxPNZJIwy9LYyglUjXj3
	OzoTsPkE1G4k49Ng8uIucUXQzBLawcqVBz61y4rzKTYys/0cJf19Rxpt5pCuh5CjW3UNvZdeCsE
	5ueSZ6w==
X-Google-Smtp-Source: AGHT+IEexTbyUHPfcFP5lpCY6NqYlWjc/RejffZeu7Cq6Tgm5hJFtoshbco9fNR7tOy+ZWHLyp2ZERtDUIPc
X-Received: from pllj7.prod.google.com ([2002:a17:902:7587:b0:223:5a6e:b17])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b6b:b0:224:76f:9e44
 with SMTP id d9443c01a7336-2296c603969mr40244805ad.8.1743624973776; Wed, 02
 Apr 2025 13:16:13 -0700 (PDT)
Date: Wed,  2 Apr 2025 13:15:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402201549.4090305-1-irogers@google.com>
Subject: [PATCH v3 0/5] NMI warning and debug improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The NMI warning wouldn't fire even if all the events were for one PMU
type. Remove a nearby, and no longer useful, mixed hardware event
group function. Improve the evlist to string function and dump it in
verbose mode after the reordered events warning.

As commonly happens legacy events like instructions will be uniquified
to hybrid events like cpu_core/instructions/, even though the
encodings differ. To make this correct either:
https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@google.com/
or:
https://lore.kernel.org/linux-perf-users/20250109222109.567031-1-irogers@google.com/
needs merging.

v3: Increase the verbose dump length from 1024 to 2048 as requested by
    Kan Liang.

v2: Rename evlist__has_hybrid to evlist__has_hybrid_pmus and add a
    max_length parameter to evlist__format_evsels as suggested by Kan
    Liang.

Ian Rogers (5):
  perf stat: Better hybrid support for the NMI watchdog warning
  perf stat: Remove print_mixed_hw_group_error
  perf evlist: Refactor evlist__scnprintf_evsels
  perf evlist: Add groups to evlist__format_evsels
  perf parse-events: Add debug dump of evlist if reordered

 tools/perf/builtin-record.c    |  9 ++++---
 tools/perf/util/evlist.c       | 34 ++++++++++++++++-------
 tools/perf/util/evlist.h       |  3 ++-
 tools/perf/util/parse-events.c | 16 ++++++++---
 tools/perf/util/stat-display.c | 49 +++++++++++-----------------------
 tools/perf/util/stat.h         |  1 -
 6 files changed, 60 insertions(+), 52 deletions(-)

-- 
2.49.0.504.g3bcea36a83-goog


