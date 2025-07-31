Return-Path: <linux-kernel+bounces-752161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5C3B17201
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5161AA7BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658552C15BD;
	Thu, 31 Jul 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2UHhW/3q"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F238A94A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968415; cv=none; b=Qxcbkxus65F38ZrS/WEQprhAQowsc3KG/SDzVzog/PnNzRxx37d3LswyV5oPf4nU8erZA0QlFgYG1EpAZBjC/T1w3X4wWdsTfix5HZgU+MK2Hk/m8QQGJRNQPr9om/d9iqpMZlv7rWe5QLzCsEL2oDGYUj92g51woOcRJCIwlkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968415; c=relaxed/simple;
	bh=s5K60HuqKi/KQbAabFyUuU+SYNPEWKz7ZtckeT8XJU0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=kpWaZDBdQku9ZzFyGYDVgsuIGQnmReVI9DoLlXV0/GsSEj4YS8ZbFSbyW79tnWY5TAJomaDh5HVCFict5ZqLSWFkeXpAGpT+MOHTWALaLB4F9XA8U18OMj6skYNe7vebhvw4GfA2+EOtWmKr6u4qKFt8zHJheaRYmG1OAHlFobE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2UHhW/3q; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2400499ab2fso7932265ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753968413; x=1754573213; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CZ1BBbI1GI1D/xuoVq0pA5HecVEJHni+Sx/JIlmlZeo=;
        b=2UHhW/3qo+XvNklpx2Zf1cfUe9FQqfhaMUfmHQxTDwO3sf90WFgsZmSNcqd1/T0MZQ
         fLdVeEbDlzhh/gG2sq6RSARPcr5cKL4hgh6jrIuqAJG0ERhcql+PIOjN3iHGcFTE+sWR
         lTF8nfsWL5HdFUwLk4rjKP+VcYNyqu8pfC8dEBXypVaf/5GQiX31vc0ZQJU71zw7IRKw
         9dQwvemEsVf4Qy3m9YUb6E8kh7zto0h9cuRi7bAnkTv6W0bYLdj6/Ylnzj6eVn2nAcyb
         eomdToUfwI+LQzNCyU4rx1Ots75Yllo0YvbUDakVlNC797EB6PN42vJjLpY6dScSS5Yj
         eZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968413; x=1754573213;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZ1BBbI1GI1D/xuoVq0pA5HecVEJHni+Sx/JIlmlZeo=;
        b=GzZOgjsotUX/HsT2Y6YBMYZDeH0Hr+KY6cgffh+HPiXHug8Oxn9QrHujMDuvmM5ehE
         sQjkNQ4sP5g7N3OkrpD6lblaaQPRCes6ldJm0y83bBhFtoAxG4gkAD2PtfCNiZpCdjti
         Usv+ntp0r9nIn5+l9t79ou0I1fp0C4mUfs0j4yG4c7iYa9XPOIavRW9pCJ8+oSdfvkY1
         gmcbuAwVoKQu/VGrMJler9IJ2fbk8E3OHA+u2OVh5wjMPsPIsJVcnbVeJb1q8I0XXW7p
         gLp7G/y01egTZtkQB+TrMkaZUjicXWF18+7OE6oGwmotz0gT/uJgvbPOLNodjghhrmiG
         Sa7g==
X-Forwarded-Encrypted: i=1; AJvYcCUnjqzZjRwXUCC4rSEgfOPPkXZj9MMZF3bqf80O3fqox6wukVORcj90nsH4aHeHJlIWtJVfzFjfnyAh0Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTLxTMjhaSTA69WqgLKoJD+1tW0pLoabQnsp5I+LbgZ9qsIFQO
	nSLt2YRqzrhnAOLh+cEG5L30MV7cgkbsMUsLVq0iC6v0QmHqNt7UUc+mtGiWNnNCK9zs8anx0bP
	cYvgLDw==
X-Google-Smtp-Source: AGHT+IF4XYHD6g0RpVLaPA/Z9xhsLWnh9zkljcdbfUmKINOz5fbgty3pEv0DxmPz+MtPY4xGE8tILDoyq3E=
X-Received: from plsk22.prod.google.com ([2002:a17:902:ba96:b0:23f:ecf6:4649])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eb8b:b0:240:6fd0:25b7
 with SMTP id d9443c01a7336-24096b1fed8mr105313315ad.38.1753968413449; Thu, 31
 Jul 2025 06:26:53 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:26:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731132615.938435-1-yuzhuo@google.com>
Subject: [PATCH v1 0/5] perf bench: Add rcu to the 'bench sync' collection
From: Yuzhuo Jing <yuzhuo@google.com>
To: Davidlohr Bueso <dave@stgolabs.net>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, 
	Yuzhuo Jing <yuzhuo@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add an 'bench sync rcu' benchmark, using the kernel's rcuscale module.

This patch series adds the following features:
  * Automatic rcuscale module load/unload and grace-period statistics.
    (The statistics feature was derived from
    tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh.)
    (patch 1)
  * Simple benchmark specifying a list of parameters supported by
    rcuscale. (patch 1)
  * A feature to execute child process, and automatically replace
    reader/writer threads ID placeholder strings.  This allows child
    process to attach to kernel threads to collect performance
    statistics. (patch 2)
  * Range-based benchmark that enumerates all combinations of parameter
    ranges (patch 3).
  * Ratio-based benchmark that scales between two parameters. (patch 4)
Example usages have been added to each patch commit message.

This patch series depends on the new features of an ongoing patch series
that exposes rcuscale module internal states and experiment results
through debugfs.  That patch series is also required for programmatic
experiment start/finish controls.
Link: https://lore.kernel.org/lkml/20250730022347.71722-1-yuzhuo@google.com/T/

RFCs:
  * This patch series depends on the behavior of rcuscale kernel module.
    In case of interface changes, especially aforementioned
    "experiment results" format changes, this benchmark may break.
  * The tools/testing/selftests/rcutorture suite provides a set of
    scripts to run rcuscale, rcutorture, refscale in KVM, but left out
    bare-metal testing.  This patch series provides direct benchmarking
    without KVM indirection.  However, they reside in different folders.
    Is there a better way to integrate both suites?
  * (Patch 3) What would be a better range format?  The current format
    is defined as start[:end:step], and is only for integers.
    Potentially we may want ranges for non-integers, or relationships
    from expressions.

The patches are based on an ongoing series.  Specifically, the minor
changes in builtin-bench.c may prevent applying change cleanly to
master/HEAD.  Though the sync-rcu.c itself is independent of the lock
benchmarks from previous series.
Link: https://lore.kernel.org/lkml/20250729022640.3134066-1-yuzhuo@google.com/T/
Link: https://lore.kernel.org/lkml/20250729081256.3433892-1-yuzhuo@google.com/T/

Yuzhuo Jing (5):
  perf bench: Add RCU benchmark using rcuscale kernel module
  perf bench: Implement subprocess execution for 'sync rcu'
  perf bench: Add 'range' mode to 'sync rcu'
  perf bench: Add 'ratio' mode to 'sync rcu'
  perf bench: Add documentation for 'sync rcu' suite

 tools/perf/Documentation/perf-bench.txt |  131 +++
 tools/perf/bench/Build                  |    1 +
 tools/perf/bench/bench.h                |    1 +
 tools/perf/bench/sync-rcu.c             | 1319 +++++++++++++++++++++++
 tools/perf/builtin-bench.c              |    1 +
 5 files changed, 1453 insertions(+)
 create mode 100644 tools/perf/bench/sync-rcu.c

-- 
2.50.1.565.gc32cd1483b-goog


