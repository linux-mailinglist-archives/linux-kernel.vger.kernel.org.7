Return-Path: <linux-kernel+bounces-809724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7081EB5112E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5AF1C804B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB85430DD27;
	Wed, 10 Sep 2025 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG/rKdZF"
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4124BCE8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492842; cv=none; b=dmXRBB0AdR3M2ebz7T7Ha6KFPk8WAJQ9yvdf5wh2XkN0jo5Hvps1fZeTPa019UrL24YnrnDuvcSy2R0zM0tp5AFmn7Ajbf+sZfIxBtlmUQeo784esm0EtH658gOWvz8vcPSiOemsQ3b6cljVaxzZhPvX0Xk8qEiFVZ/8qdKkgfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492842; c=relaxed/simple;
	bh=sgjPknbizU3iZLy5JeSJLkKNdVV4LmYBSTvX6iJ9RhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bBgHxVNZ/kqJUq8r+G9P5/oD3ro06gjD+6OBDsAiZsAj0gCp7dSTQrO6R3hi9wCJUWTGjxRd5myhktO8ncYLoS5jQGqwmfTlpYTJDGFNl+Wdu3lnXLZT15I6MXbrTgPyRxQjBa6GgO0ZT2hB9nKuIVEeIeOl6z8qFX1fmgSeh+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG/rKdZF; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-5679dbcf9d8so1566764e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757492839; x=1758097639; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XUlSQgNznsnwxY1v6EpOKiSWDTljMmBk9IvwPlJ174k=;
        b=HG/rKdZFbF3cVhXh+frFDuJbCD2vGeyPYarXgkjiON+4ZppipIHv3yMPxIO18lwVH6
         lY3kacIHfD8GpCxRNYFiTcaYdhU9cJTsR/Th1O0qkEIYGyFDGlG7JobKBJ1njZq1KClG
         sBPLi/pM3rI6RlWz7G5exgAvKDoH+PGIn8gMSM4T97oaE84u2kBXxGJ7+4SY3ld4aO0w
         SH64/5iDU3v7m0l+FpnwEwOzQLU3wogaNPklsQw2aXt1/OKZfKQCUINPLgUFtdV9Inbz
         vV1movZLmhRgIJQOAhgxYMbEO+T9rWfhsx8L8MatxD6scqHOF+7Uzbr7Wxe6o3Cngkhl
         OUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757492839; x=1758097639;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUlSQgNznsnwxY1v6EpOKiSWDTljMmBk9IvwPlJ174k=;
        b=Sur6J0tJlfOCQLJJ6qvmYaTs7gwo6eEb3eKdaWpGhbkmZmkiEL2vzxfPdSnHcCLXHr
         mn9Gzogj5RrZnPe9JwzbWmqNY9qp5IkCMsLgVEWyWNMMGSqAF6h//dzL8rfntfeJ2Ucy
         PW5wBbNmOZN8n/acTysIPBAyi8bEbGrZbB+RdwH6b84ZkFZ9KDZupnf1+NcMJ94JDHub
         O5iZidJFCDTYHR4aGhEmsDnJ/nVgrZqJlnVNdzwAUjf4N6ohS9jG6PU1wmuNnNSOAojF
         Wmmq/JlMD5HYLYtsNHkhExJqItu/NaD5h3sL5iZvF3hTskWdYjay9d8ZY/dw6EfJSOu/
         PmrA==
X-Forwarded-Encrypted: i=1; AJvYcCU0hneDp7Jo2uhj1LJdo0vQWRO/KIV+rns+YH+jC+S/bOcKVbUqtw0Y6dyUxuhPdlt7RhiRwL1KmI+7Szg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTXITu6bLkAxG4eXZrRR7cmNCbzn2NA/WYjlxtmoMO2LggOmxo
	wc84bL66UwLTrhmZRBsDY7FhAbBQGYur2U7S6Toyw3twMbL/f3ZjTWH+CZ0juCi7Nj7WCmyIvEI
	FujjSUlDtzHVSiEkMxjI0m1k/PEC4niw+T/BVgrrk2A==
X-Gm-Gg: ASbGncuoDj7Z3CXz1WmamrUoi1YRUkSj0GCEMIokogOhKrAXN+zVSJ8lf8SWJ7Q5u3C
	nOEMBXBuuZyb6B1fbkUiWi4LM5T+7f67E9LoxWmjkM9hj5zwU/oi/tVDYuPEM8t8FdPydCkAuJm
	XA8Ao6eNG+Lq65hJIZzsjsWUv5Wv0WELOdpDIEWJ6TzzyAlCiCSYRXQyoNKxF9jiB6ld/98bKgR
	YINpjS7+Gaah+GMjQU=
X-Google-Smtp-Source: AGHT+IFtNj8MrgvG/LsYODlSSAQ46lqM64GMx+/RV0Bn8QXC0XEC493TooHBnELejzfCCM5qLNSbAghA0XC+YaRso/s=
X-Received: by 2002:a05:6512:2205:b0:55f:64b9:3ab4 with SMTP id
 2adb3069b0e04-5625fce6ee3mr4638441e87.23.1757492838261; Wed, 10 Sep 2025
 01:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910081655.355971-1-hupu.gm@gmail.com>
In-Reply-To: <20250910081655.355971-1-hupu.gm@gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Wed, 10 Sep 2025 16:27:05 +0800
X-Gm-Features: Ac12FXw_aqdKOyln3fC2LqBVD4w1MqeDPmiFouxIaF6z1jfLqdS6ik_JJWCVRlc
Message-ID: <CADHxFxSBKuKUWDvki9QDqc5jf1Y+k2EpvOnDsg8O09pZ10n2NA@mail.gmail.com>
Subject: Re: [RFC] perf subcmd: avoid crash in exclude_cmds when excludes is empty
To: irogers@google.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Maintainers,

When cross-compiling perf tool for ARM64 (though the issue is actually
platform-independent), I encountered a crash when running `perf help`
if the perf binary name is not exactly "perf" or if multiple "perf-*"
binaries exist in the same directory.

This patch is an attempt to fix the issue. I would like to discuss its
reasonableness with you and see if this is the right direction.


1. Problem Reproduction
=======================

Case 1: Binary named "perf-master"
----------------------------------
  # /mnt/perf-master help
  perf-master: help.c:122: exclude_cmds: Assertion `cmds->names[ci] ==
NULL' failed.
  Aborted

Case 2: Renaming to "perf"
--------------------------
  # mv perf-master perf
  # /mnt/perf help
  -> works as expected
  usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

  The most commonly used perf commands are:
    annotate        Read perf.data (created by perf record) and
display annotated code
    archive         Create archive with object files with build-ids
found in perf.data file
    bench           General framework for benchmark suites
    buildid-cache   Manage build-id cache.
    buildid-list    List the buildids in a perf.data file
    c2c             Shared Data C2C/HITM Analyzer.
    config          Get and set variables in a configuration file.
    daemon          Run record sessions on background
    data            Data file related processing
    diff            Read perf.data files and display the differential profile
    evlist          List the event names in a perf.data file
    ftrace          simple wrapper for kernel's ftrace functionality
    inject          Filter to augment the events stream with
additional information
    iostat          Show I/O performance metrics
    kallsyms        Searches running kernel for symbols
    kvm             Tool to trace/measure kvm guest os
    list            List all symbolic event types
    mem             Profile memory accesses
    record          Run a command and record its profile into perf.data
    report          Read perf.data (created by perf record) and
display the profile
    script          Read perf.data (created by perf record) and
display trace output
    stat            Run a command and gather performance counter statistics
    test            Runs sanity tests.
    top             System profiling tool.
    version         display the version of perf binary
    probe           Define new dynamic tracepoints
    trace           strace inspired tool
    kmem            Tool to trace/measure kernel memory properties
    kwork           Tool to trace/measure kernel work properties (latencies)
    lock            Analyze lock events
    sched           Tool to trace/measure scheduler properties (latencies)
    timechart       Tool to visualize total system behavior during a workload

  See 'perf help COMMAND' for more information on a specific command.

Case 3: Copying to "perf-backup"
--------------------------------
  # cp perf perf-backup
  # /mnt/perf help
  perf: help.c:122: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
  Aborted

  # /mnt/perf-backup help
  perf-backup: help.c:122: exclude_cmds: Assertion `cmds->names[ci] ==
NULL' failed.
  Aborted



2. Root Cause
=============

In `exclude_cmds()`, `cmds` represents commands found in the current
binary directory and PATH, while `excludes` comes from the
`~/libexec/perf-core/` directory.

The function attempts to remove commands from `cmds` that already
exist in `excludes`. However, when `excludes->cnt == 0`, the final
`assert(cmds->names[ci] == NULL)` may fail, leading to an abort.



3. Fix
======

Add a simple guard at the beginning of `exclude_cmds()` to return
early if `excludes->cnt == 0`.

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 9ef569492560..ddaeb4eb3e24 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -75,6 +75,9 @@ void exclude_cmds(struct cmdnames *cmds, struct
cmdnames *excludes)
        size_t ci, cj, ei;
        int cmp;

+       if (!excludes->cnt)
+               return;
+
        ci = cj = ei = 0;
        while (ci < cmds->cnt && ei < excludes->cnt) {
                cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);



4.Verification
===============

With this patch applied, running perf help works correctly even when
the binary is named perf, perf-master, or perf-backup:

/mnt/perf help
/mnt/perf-master help
/mnt/perf-backup help

All of them now display the expected help information without aborting.

