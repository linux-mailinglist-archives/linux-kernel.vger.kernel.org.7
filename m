Return-Path: <linux-kernel+bounces-746314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C7AB12562
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4695604B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4020F25B31C;
	Fri, 25 Jul 2025 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQZJ18q7"
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED872259CBE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475303; cv=none; b=WvumlR2jfR2SS8grRmdtSedoCy6Y6UUdPhL2kyjEl20FsEz7bc0HyDlWcDjyJZidX6F15p0kP+odLIwwAtZj86qgVSfNQsG6VLXYb9+tWT5YtV8PkoQczh+i0xT/cQzrrl4DIGWIJIaUQhlfDIIak1kM/DmatDYmmGnlrwIAp8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475303; c=relaxed/simple;
	bh=gXTJnen5/k7cpoZ23BuEhZhJsM3pfjzHd8tKam8f0t0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BpbHMJxC81nCPcQfzmATcJwLK19Sxdb+C1667YH5e4lffQG2a8AsRXvX0Rfm9p3An7J8dKAZHTqoLp4pGILO/SGxjwGIBQHrJkIkc8KX3lk593dzsZB5keX2ZLunaArqzYSO+D65ZQWBiOeNJcfn1cWwQ5ocnyj/KwaGghRuJ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQZJ18q7; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ab801d931cso49530821cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753475300; x=1754080100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DDk9iD/I/15mfC7z2yZd+qqbmK63SyY3qkF61lMO7hw=;
        b=QQZJ18q71Swn3pn1i+Rxe4kyr4ifU70cZoNXfZx4nppzyaXlkn9HHNkRvBhpjzkyBd
         MjCELuAKoFziwzwk16CJrFgPcifgqsPnQ6TpcUehkCWiSpxeNsZIZ5ipqZ2SCaFmKE5a
         Joj4wE7ulu9aHYczwY1SAf4eLZr1KNRp1PLmNLeiet/5cH9owYhHbOSu6/rFnQXzpG0P
         DWpOBjkytPV+dUcTZ3GjKjxy/kiw1V/VE2RSnznpcLDutkxlvUp+y/kv9K3caDVm2THW
         djNyanHBrOT2ZeLzLrom5COxtMJxSredNvktV5xA1z2GbF+2bQzOjUgY1+tWrBaHTIhQ
         2t0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753475300; x=1754080100;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDk9iD/I/15mfC7z2yZd+qqbmK63SyY3qkF61lMO7hw=;
        b=s2RhswgNqv01ymUpwQZIFoYDa6Zt/lCBCUl8M2mB9jXrKC4l8awGLGTwAveq++Y0Zp
         jUnYv0xOcW1s5JRDFJNzeyFK2B/qit6KHyl6V+3xx0MrTdGsuES3CEllMaN4Q4vv2fUE
         hP7DaYp0iCMJZk5Zkz43KzPFGACBFvbd2X1MM3pB2HAqYQV8yr1QC1kQCgy1tS9EOCvb
         vD42gCB+P+1+cQM80RsxqZZmvJblhkRhgGvpmHepkZqCNW9C5IqPmJTeDyzuEJaHC7/b
         42ozGYMOyoTXmRfjX9AssL1pT6u11K/Uf7Bzjqsg2MjjEMx/mVlVZ1DBkoB6rlrW+vy2
         cGnA==
X-Forwarded-Encrypted: i=1; AJvYcCVeM+rm0Kpb63raXrofaLDK26Q9E6PeNRnJkJCnA2EsNGhS9EPviXsxJhS7k4RhkE7hEWR+R2k7GHIOTuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPzzGvljxQJpSvEfUDIlY3BZoZ3YeIbefrKzaJYMb8HgndrG+
	y16KlsZOxbUIAo1c7dHpJ6RPpBH+MsayOUuQu6/HoPe87OsHFW7YUrcli0CqbdZy0IEZG4G7k1G
	nsHglpbNgCA==
X-Google-Smtp-Source: AGHT+IGoW369nQimnMdyOQv3l2inVS2nmeFQHd5UQmHCGbQIndLINbr8efAQFTdyc+N3SnK/40By8NreEylV
X-Received: from qtei9.prod.google.com ([2002:a05:622a:8c9:b0:4ab:cacc:4c68])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:570a:0:b0:4ab:6b08:9dc1
 with SMTP id d75a77b69052e-4ae8ef9bea7mr50798341cf.19.1753475299804; Fri, 25
 Jul 2025 13:28:19 -0700 (PDT)
Date: Fri, 25 Jul 2025 20:28:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725202809.1230085-1-zecheng@google.com>
Subject: [PATCH v1 0/6] perf tools: Some improvements on data type profiler
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I've identified several missing data type annotations within the perf
tools when annotating the Linux kernel. This patch series improves the
coverage and correctness of data type annotations.

Here's a breakdown of the changes:

Patches 1 and 2 fixes direct type matching from DWARF. They fix cases
with intrusive linked lists (e.g, sched_balance_update_blocked_averages)
where type information was previously missed.

Patch 3 utilizes this to better determine the types of stack
variables for instruction tracking.

Patch 4 skips annotations for lea instructions, as these do not involve
memory access.

Patches 5 and 6 implement a basic idea for register offset tracking
based on arithmetic operations. While this feature has known limitations
and may regress in rare cases compared to the original, it generally
improves offset tracking in most scenarios.

Note: I will be communicating from a new email address, zli94@ncsu.edu,
as I will soon lose access to my current email account.

Thanks,
Zecheng

Zecheng Li (6):
  perf dwarf-aux: Use signed comparison in match_var_offset
  perf dwarf-aux: More accurate variable type match for breg
  perf dwarf-aux: Better type matching for stack variables
  perf annotate: Skip annotating data types to lea instructions
  perf dwarf-aux: Find pointer type to a type
  perf annotate: Track arithmetic instructions on pointers

 tools/perf/arch/x86/annotate/instructions.c | 109 ++++++++++++++++-
 tools/perf/util/annotate-data.c             |  14 ++-
 tools/perf/util/annotate-data.h             |   6 +
 tools/perf/util/annotate.c                  |   5 +
 tools/perf/util/dwarf-aux.c                 | 125 ++++++++++++++++++--
 tools/perf/util/dwarf-aux.h                 |   4 +
 6 files changed, 247 insertions(+), 16 deletions(-)

-- 
2.50.1.470.g6ba607880d-goog


