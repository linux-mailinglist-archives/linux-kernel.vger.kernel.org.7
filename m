Return-Path: <linux-kernel+bounces-676269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F43AD09BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 23:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B426D189E6CB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 21:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC0A23A578;
	Fri,  6 Jun 2025 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HSHC/aNz"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784523BF9F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246773; cv=none; b=dmBBaLcLhXNq13qqmd8ty9/Gb5w1Q6C8O1psyFEfHZOhfGupgjFVwn7fEET5dNImZy92posu+/UzFcARBxfeTWq5KCCacdttnVjvdISKF5dvwwPtDHaEoSsFOyN6dZswvrIPchJ5Q3S6CP/YbNPG3gyCN+3h3OEx9TXfXDGDhSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246773; c=relaxed/simple;
	bh=DrzXWiPuCmbk7FJS7JCekeQvqnlzYqzj17AkfJe1vpU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fygxSzuyWA2jGelTbXsMdTt4qcd5tySGbaXe+UlGH0idSbCHN01Ji0e/JNXBAXNB0kX5rGIMaVt5EdoE06YqkfWG9RDNG8gmDA9SHOAuXfSNwrX47a1uuQ/ipmvOQnjjmGCBZHyYUdo6KJfLEjE1kNpepIR6FOmkaFSV19R2U2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HSHC/aNz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26e0fee459so1887966a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jun 2025 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749246771; x=1749851571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cJCp9bhXIYOrZprd5csWtnV312LuqeYykGnUBhaYz2k=;
        b=HSHC/aNz28ICZZDCa/1D9+4IC9PRfamCGEjsMY6te6LeEQcaaPwqOeYVlTeEwuEcUM
         qmgH8KSL4hfLhOt6fSz9fBNHOyEVKJnxW2Q5f3fB29Un05e+2z/fPLH04yy3BLjcxusX
         0S4KD6UxBtEAFpEuPXLO4maEFaH2p3RJkBV4Qs3a6VOCy40TYDQ3tI9Ng7i/MACo2OdT
         mUOcx537DOqlV3UZ/QHEVObwOAVcHtcMU0/9kEn67msQt+y92UaSisuRE9TFFz/9K4x2
         kdaki8H86XMip+vPI5QGK9yP0+IKdYE+ctPxP3wKTwLYQiBHI7E9SpkMn742jPEatY2/
         TGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246771; x=1749851571;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJCp9bhXIYOrZprd5csWtnV312LuqeYykGnUBhaYz2k=;
        b=GmcS7I4nHfwnhE5JRcS6T4szsDBGsPekvMDoK1B9/Zj0ZnZBn7lF89x7/LN7Fe0Rxp
         bsxNX9exG0/sN7Xub+rt5P8+x85hOIV0faZWwcBbkFMb0N0InhBngCa8mI0dEEkMJCEb
         +1lMbPixAoYOtEAKLV/Jdw8qhO4k0NIIcQKPlAzTZ9Pl0zboVaRm9BNPxA61/tjKP3Lq
         1WmxuInArmPEa7x4fYO7rzAgtB6Da4rQ+wXNA77KaEM2V9IA/42hsj6aoufAzKGDHXmM
         v3280u9O/8mghdYsuR/QNjsqeLN+WJdLiWlUGx2tqYnRa8AwSXwps+v6VhjgaLAPqoCR
         J47Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtxy+Ac8wIHx1rXIhyZAZiAwiGWUlOHeAezaUM52tds7hvKpKrAaHcLhbz9xjao0jORV9PIKS5tmOar5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoaewP3fT6InjYaiMOCwoT6f/OLYWmII35eHpjYCKd0LJFMf3y
	TDiiou5BkQbPvpUIJNoO5cBuJheYhkxpRF3v5F4w0pZQuFk4/cZZhBP1t+pzP4NOzp7LRX5R1fO
	OWNalIiOzU/poqCkTX/r9DA==
X-Google-Smtp-Source: AGHT+IHtAou0XK/BoD58er+yz9x+egUh/LuWKeft+0QX/UE/N3mLSX/t4UT7aHt0qw+XiS+FEn1+jFIFWWYT0jW+
X-Received: from pgg20.prod.google.com ([2002:a05:6a02:4d94:b0:b2f:795e:379a])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:22c4:b0:234:5ea1:6041 with SMTP id d9443c01a7336-236136095camr4698875ad.10.1749246771234;
 Fri, 06 Jun 2025 14:52:51 -0700 (PDT)
Date: Fri,  6 Jun 2025 14:52:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250606215246.2419387-1-blakejones@google.com>
Subject: [PATCH v3 0/5] perf: generate events for BPF metadata
From: Blake Jones <blakejones@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit ffa915f46193 ("Merge branch 'bpf_metadata'"), from September 2020,
added support to the kernel, libbpf, and bpftool to treat read-only BPF
variables that have names starting with 'bpf_metadata_' specially. This
patch series updates perf to handle these variables similarly, allowing a
perf.data file to capture relevant information about BPF programs on the
system being profiled.

When it encounters a BPF program, it reads the program's maps to find an
'.rodata' map with 'bpf_metadata_' variables. If it finds one, it extracts
their values as strings, and creates a new PERF_RECORD_BPF_METADATA
synthetic event using that data. It does this both for BPF programs that
were loaded when a 'perf record' starts, as well as for programs that are
loaded while the profile is running. For the latter case, it stores the
metadata for the duration of the profile, and then dumps it at the end of
the profile, where it's in a better context to do so.

The PERF_RECORD_BPF_METADATA event holds an array of key-value pairs, where
the key is the variable name (minus the "bpf_metadata_" prefix) and the
value is the variable's value, formatted as a string. There is one such
event generated for each BPF subprogram. Generating it per subprogram
rather than per program allows it to be correlated with PERF_RECORD_KSYMBOL
events; the metadata event's "prog_name" is designed to be identical to the
"name" field of a perf_record_ksymbol. This allows specific BPF metadata to
be associated with each BPF address range in the collection.

Changes:

* v2 -> v3:
  - Split out event collection from event display.
  - Resync with tmp.perf-tools-next.
  - Link to v2:
    https://lore.kernel.org/linux-perf-users/20250605233934.1881839-1-blakejones@google.com/T/#t

* v1 -> v2:
  - Split out libbpf change and send it to the bpf tree.
  - Add feature detection to perf to detect the libbpf change.
  - Allow the feature to be skipped if the libbpf support is not found.
  - Add an example of a PERF_RECORD_BPF_METADATA record.
  - Change calloc() calls to zalloc().
  - Don't check for NULL before calling free().
  - Update the perf_event header when it is created, rather than
    storing the event size and updating it later.
  - Add a BPF metadata variable (with the perf version) to all
    perf BPF programs.
  - Update the selftest to look for the new perf_version variable.
  - Split out the selftest into its own patch.
  - Link to v1:
    https://lore.kernel.org/linux-perf-users/20250521222725.3895192-1-blakejones@google.com/T/#t

Blake Jones (5):
  perf: detect support for libbpf's emit_strings option
  perf: collect BPF metadata from existing BPF programs
  perf: collect BPF metadata from new programs
  perf: display the new PERF_RECORD_BPF_METADATA event
  perf: add test for PERF_RECORD_BPF_METADATA collection

 tools/build/Makefile.feature                |   1 +
 tools/build/feature/Makefile                |   4 +
 tools/build/feature/test-libbpf-strings.c   |  10 +
 tools/lib/perf/include/perf/event.h         |  18 +
 tools/perf/Documentation/perf-check.txt     |   1 +
 tools/perf/Makefile.config                  |  12 +
 tools/perf/Makefile.perf                    |   3 +-
 tools/perf/builtin-check.c                  |   1 +
 tools/perf/builtin-inject.c                 |   1 +
 tools/perf/builtin-record.c                 |   8 +
 tools/perf/builtin-script.c                 |  15 +-
 tools/perf/tests/shell/test_bpf_metadata.sh |  76 ++++
 tools/perf/util/bpf-event.c                 | 378 ++++++++++++++++++++
 tools/perf/util/bpf-event.h                 |  13 +
 tools/perf/util/bpf_skel/perf_version.h     |  17 +
 tools/perf/util/env.c                       |  19 +-
 tools/perf/util/env.h                       |   4 +
 tools/perf/util/event.c                     |  21 ++
 tools/perf/util/event.h                     |   1 +
 tools/perf/util/header.c                    |   1 +
 tools/perf/util/session.c                   |   4 +
 tools/perf/util/synthetic-events.h          |   2 +
 tools/perf/util/tool.c                      |  14 +
 tools/perf/util/tool.h                      |   3 +-
 24 files changed, 622 insertions(+), 5 deletions(-)
 create mode 100644 tools/build/feature/test-libbpf-strings.c
 create mode 100755 tools/perf/tests/shell/test_bpf_metadata.sh
 create mode 100644 tools/perf/util/bpf_skel/perf_version.h

-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


