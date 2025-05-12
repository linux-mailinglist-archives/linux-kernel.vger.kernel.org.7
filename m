Return-Path: <linux-kernel+bounces-644975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDC8AB4711
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 00:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AA04682EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 22:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B938299A8F;
	Mon, 12 May 2025 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWfATtUY"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2925C6EB
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087314; cv=none; b=nGxUHzmEWFdnE1QL7c3aMvfJVikYow+TPF8RkzpcD5/8IQx/24+xIgdn4pToBI0Jc9Lv65JDV9sD4y1SNRjyMEgdDx/E3g8PioCmC1S0iG6Oo+AW1KKyUK7Ax0y/rnJzqdGmElmq1Cbuhcx0ouxT2T9fZmt6S4PKnNTVwHVTtOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087314; c=relaxed/simple;
	bh=q7bppKnh9hkPE3BVcGm8BpWNBC/vEE24Ea5etqZ9gAc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KHKUNT6ZVqSglafXje7SO4JH4/lMTRSa/emfwphCYlRByQj5cnR0hQwxn4XK1P8QSEBJTDL1J0emGb+Q+vyyF7EJPsAr6al720MguCbPM3HtVmArTZ+I2naFRLANtOR9E317DGj8I22Bqilur7/UxrNgXrBKzlhE2xFkBcvfwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eWfATtUY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22fb8cfff31so33746695ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747087312; x=1747692112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PLNkpfd9QG+r6EhpWQHxYHkkitesHQCxe3zmaQDF/oA=;
        b=eWfATtUY/2C4M1M9Yi9IE3tIqWViz8R/T2bRbXHxSfAb9avvb80TABYULD8QyVbOMx
         LQybMqvLnRUxr7hTnLVyecw+7QY1CeB+zFabMt9Nyp8ncsZzd9L4NGK9x5uO61TIaucB
         tp1GDxLkmO21JUlWqEzmLkp1fqVbCmwaZNoO8EUuU/dUaBaPXyCuwxR7wQKiaXWvmDaA
         meoukSISXlQ/h8ivJ9M+hV7rI7orDGc7iVdxbeavivG0jGIGQrZM3QT9bvsm0PGr1zlT
         Yxhsl8IMlHEThoxBwTbJOAnKXsLjBCgqoY0Qb/4XA5bkQ1IBROwZ8UYKxBPZh/MR3WAT
         ugHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747087312; x=1747692112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PLNkpfd9QG+r6EhpWQHxYHkkitesHQCxe3zmaQDF/oA=;
        b=isTEc5hDwqgSBtfV541lmopsqv+S5xWRneytvskI0p/R+88K9Je8Rs540aJLAvUGKU
         WyAx7/j4HvpUiimqr0Jm0NS5hQGZKZ5XqJ6K57AfsNcIQqm8O0W5/baHEAEG1SFleKbh
         lA1e4WZ+PTBGpOBKQ8OPK1uVcYenF5TGSNEMziRdL0qTnmxf/VauhPVJyiNoOoa93yxu
         bidfSFjMkN04hMUIzhs3NW3gSHXOKtKf8iCUXuJm4jdSrd+DkW5hK8ElfYG/rmEyuITC
         3NidkLVmKaBBdKHf5eHDwVjS/CKnS7JVj5Z+7nMBgfz7PaMVE2qx+8YE2ytN6Q9Xlkbd
         9YAQ==
X-Gm-Message-State: AOJu0YyU2NsSnJJ+AX7AOF7O5T9HaM5jeYTvS7N+E2a0GAGJjKUdyi3c
	oC3IJFF2KmvfGu3iWyLa3W/GCwZdXXBYr6Tnr7yYNnHINwgDdo4SoZGBYN+7GqCicPRU+ZaQw96
	xi2WPQCA5rRuO0NNCpTl8jeApeG+b8bbBOKvVh9yPgHe2B/1S1Ihs/P6WH0nDKIsvD/aQyQOCQ3
	mUNYfqymG0w/2e0XPyr8zF2eivHDZFdbKqtRlQJvv7
X-Google-Smtp-Source: AGHT+IG/ZZSSGmPsNVQexMKzcuPHKss7RKMQUaah9mPyMa0UDduJclcU1JqFNkLQVSLLfiQ77yxe88oiVbM=
X-Received: from plgm14.prod.google.com ([2002:a17:902:f64e:b0:224:efa:ef21])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e5:b0:224:1935:fb91
 with SMTP id d9443c01a7336-22fc8c861a7mr217194555ad.27.1747087311803; Mon, 12
 May 2025 15:01:51 -0700 (PDT)
Date: Mon, 12 May 2025 14:50:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512215929.2098240-1-ctshao@google.com>
Subject: [PATCH v3 0/3] Fix incorrect counts when count the same uncore event
 multiple times
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, weilin.wang@intel.com, yeoreum.yun@arm.com, 
	linux@treblig.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Let's take a look an example, the machine is SKX with 6 IMC devices.

  perf stat -e clockticks,clockticks -I 1000
  #           time             counts unit events
       1.001127430      6,901,503,174      uncore_imc_0/clockticks/
       1.001127430      3,940,896,301      uncore_imc_0/clockticks/
       2.002649722        988,376,876      uncore_imc_0/clockticks/
       2.002649722        988,376,141      uncore_imc_0/clockticks/
       3.004071319      1,000,292,675      uncore_imc_0/clockticks/
       3.004071319      1,000,294,160      uncore_imc_0/clockticks/

1) The events name should not be uniquified.
2) The initial count for the first `clockticks` is doubled.
3) Subsequent count only report for the first IMC device.

The first patch fixes 1) and 3), and the second patch fixes 2).

After these fix:

  perf stat -e clockticks,clockticks -I 1000
  #           time             counts unit events
       1.001127586      4,126,938,857      clockticks
       1.001127586      4,121,564,277      clockticks
       2.001686014      3,953,806,350      clockticks
       2.001686014      3,953,809,541      clockticks
       3.003121403      4,137,750,252      clockticks
       3.003121403      4,137,749,048      clockticks

I also tested `-A`, `--per-socket`, `--per-die` and `--per-core`, all
looks good.

Ian tested `hybrid-merge` and `hwmon`, all looks good as well.

Chun-Tse Shao (1):
  perf test: Add stat uniquifying test

Ian Rogers (2):
  perf evlist: Make uniquifying counter names consistent
  perf parse-events: Use wildcard processing to set an event to merge
    into

 tools/perf/builtin-record.c                   |   7 +-
 tools/perf/builtin-top.c                      |   7 +-
 .../tests/shell/stat+event_uniquifying.sh     |  69 ++++++++
 tools/perf/util/evlist.c                      |  66 +++++---
 tools/perf/util/evlist.h                      |   3 +-
 tools/perf/util/evsel.c                       | 119 ++++++++++++-
 tools/perf/util/evsel.h                       |  11 +-
 tools/perf/util/parse-events.c                |  90 +++++++---
 tools/perf/util/stat-display.c                | 160 ++----------------
 tools/perf/util/stat.c                        |  40 +----
 10 files changed, 332 insertions(+), 240 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh

--
v3: Rebase with tmp.perf-tools-next. Since most of the conflicts are from
lore.kernel.org/20250403194337.40202-5-irogers@google.com, tested v3
patches with:

  perf stat -A -C 0,4-5,8 -e "instructions/cpu=0/,l1d-misses/cpu=4,cpu=5/,inst_retired.any/cpu=8/,cycles" -a sleep 0.1

   Performance counter stats for 'system wide':

  CPU0              682,860      instructions/cpu=0/              #    0.27  insn per cycle
  CPU4               53,774      l1d-misses
  CPU5               18,725      l1d-misses
  CPU8              608,698      inst_retired.any/cpu=8/
  CPU0            2,574,325      cycles
  CPU4            4,267,115      cycles
  CPU5            1,741,536      cycles
  CPU8            1,969,547      cycles

         0.102746958 seconds time elapsed

v2: lore.kernel.org/20250327225651.642965-1-ctshao@google.com
  - Fixes for `hwmon` and `--hybrid-merge`.
  - Add a test for event uniquifying.

v1: lore.kernel.org/20250326234758.480431-1-ctshao@google.com

2.49.0.1045.g170613ef41-goog


