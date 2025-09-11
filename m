Return-Path: <linux-kernel+bounces-812845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD03B53D83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10AD87ABC1F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A022D948D;
	Thu, 11 Sep 2025 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrqpqmFW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7627467D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624957; cv=none; b=Sg6/e7Ar5Jaf9zg0003I1XAtwjhRaygokiGpmHRhiJ/PGAjdLpJR1i/87hJqJy0A5wSSAWPlB+ugVrE6NlYsnKjfCeT0PlCwPFEAI/JI+q480iC4TBVP4109p3VLddR9K4NvHmDII5qWyFxi3+1udWemR3I8qDUc1Xyo1LRx+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624957; c=relaxed/simple;
	bh=nk92iUHXHLl9+X/G+xxjOm9e/y8ujb8AE9Vm+yQqX1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGa3geSLug+0FdG25o8g+Y4pBLgezaIqBS6dnTgn1erfmlLGo59biQ2GPSkJEBLo/rJHuzTLnYC0r0xyh3kN36IqY6FyfIdoMkgwlByVT65mx1WwuOX91Kgh1G0jvxIbGYAfD4qhmuw7fmelYeMv8RRB3hz2N/pWwnvF5MWtNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrqpqmFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6170FC4CEF0;
	Thu, 11 Sep 2025 21:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757624956;
	bh=nk92iUHXHLl9+X/G+xxjOm9e/y8ujb8AE9Vm+yQqX1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LrqpqmFW4Mf82A64NqhM1AwDE2UE/zKxtzStT9wiNk4WslvgSCP7SFGzRTlKoFxmw
	 r0iwyW1jyIUaoAMn2jtes/iaSp0Ma7N9z/L5t9OjSU5nNiAsajToGAOZWwaPQka4SJ
	 o+mwFHFDpkuAWhpj07wkJWX8Ju1tcYIc8Xd8EC5A3NEYp71X2nb+5uND3+BiN+50Ob
	 aEqgZ8XzfO8XspK3yprndGVRNPeg+4CzLgnIpDvjc5hdOHKv6t+EQn+nZyu3ut7ckT
	 +8ee4+Z0vYSmA7LlPo6WmQd4lmhrn1V8ek4F55JMrUyX2hqPcObeqkVhBE0gS/+oI1
	 FVhLarZbWiiNw==
Date: Thu, 11 Sep 2025 14:09:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: hupu <hupu.gm@gmail.com>
Cc: irogers@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] perf subcmd: avoid crash in exclude_cmds when excludes is
 empty
Message-ID: <aMM6ejbed7s7_2t1@google.com>
References: <20250910081655.355971-1-hupu.gm@gmail.com>
 <CADHxFxSBKuKUWDvki9QDqc5jf1Y+k2EpvOnDsg8O09pZ10n2NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADHxFxSBKuKUWDvki9QDqc5jf1Y+k2EpvOnDsg8O09pZ10n2NA@mail.gmail.com>

Hello,

On Wed, Sep 10, 2025 at 04:27:05PM +0800, hupu wrote:
> Dear Maintainers,
> 
> When cross-compiling perf tool for ARM64 (though the issue is actually
> platform-independent), I encountered a crash when running `perf help`
> if the perf binary name is not exactly "perf" or if multiple "perf-*"
> binaries exist in the same directory.
> 
> This patch is an attempt to fix the issue. I would like to discuss its
> reasonableness with you and see if this is the right direction.
> 
> 
> 1. Problem Reproduction
> =======================
> 
> Case 1: Binary named "perf-master"
> ----------------------------------
>   # /mnt/perf-master help
>   perf-master: help.c:122: exclude_cmds: Assertion `cmds->names[ci] ==
> NULL' failed.
>   Aborted
> 
> Case 2: Renaming to "perf"
> --------------------------
>   # mv perf-master perf
>   # /mnt/perf help
>   -> works as expected
>   usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]
> 
>   The most commonly used perf commands are:
>     annotate        Read perf.data (created by perf record) and
> display annotated code
>     archive         Create archive with object files with build-ids
> found in perf.data file
>     bench           General framework for benchmark suites
>     buildid-cache   Manage build-id cache.
>     buildid-list    List the buildids in a perf.data file
>     c2c             Shared Data C2C/HITM Analyzer.
>     config          Get and set variables in a configuration file.
>     daemon          Run record sessions on background
>     data            Data file related processing
>     diff            Read perf.data files and display the differential profile
>     evlist          List the event names in a perf.data file
>     ftrace          simple wrapper for kernel's ftrace functionality
>     inject          Filter to augment the events stream with
> additional information
>     iostat          Show I/O performance metrics
>     kallsyms        Searches running kernel for symbols
>     kvm             Tool to trace/measure kvm guest os
>     list            List all symbolic event types
>     mem             Profile memory accesses
>     record          Run a command and record its profile into perf.data
>     report          Read perf.data (created by perf record) and
> display the profile
>     script          Read perf.data (created by perf record) and
> display trace output
>     stat            Run a command and gather performance counter statistics
>     test            Runs sanity tests.
>     top             System profiling tool.
>     version         display the version of perf binary
>     probe           Define new dynamic tracepoints
>     trace           strace inspired tool
>     kmem            Tool to trace/measure kernel memory properties
>     kwork           Tool to trace/measure kernel work properties (latencies)
>     lock            Analyze lock events
>     sched           Tool to trace/measure scheduler properties (latencies)
>     timechart       Tool to visualize total system behavior during a workload
> 
>   See 'perf help COMMAND' for more information on a specific command.
> 
> Case 3: Copying to "perf-backup"
> --------------------------------
>   # cp perf perf-backup
>   # /mnt/perf help
>   perf: help.c:122: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
>   Aborted
> 
>   # /mnt/perf-backup help
>   perf-backup: help.c:122: exclude_cmds: Assertion `cmds->names[ci] ==
> NULL' failed.
>   Aborted
> 
> 
> 
> 2. Root Cause
> =============
> 
> In `exclude_cmds()`, `cmds` represents commands found in the current
> binary directory and PATH, while `excludes` comes from the
> `~/libexec/perf-core/` directory.
> 
> The function attempts to remove commands from `cmds` that already
> exist in `excludes`. However, when `excludes->cnt == 0`, the final
> `assert(cmds->names[ci] == NULL)` may fail, leading to an abort.
> 
> 
> 
> 3. Fix
> ======
> 
> Add a simple guard at the beginning of `exclude_cmds()` to return
> early if `excludes->cnt == 0`.
> 
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index 9ef569492560..ddaeb4eb3e24 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -75,6 +75,9 @@ void exclude_cmds(struct cmdnames *cmds, struct
> cmdnames *excludes)
>         size_t ci, cj, ei;
>         int cmp;
> 
> +       if (!excludes->cnt)
> +               return;
> +
>         ci = cj = ei = 0;
>         while (ci < cmds->cnt && ei < excludes->cnt) {
>                 cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
> 
> 
> 
> 4.Verification
> ===============
> 
> With this patch applied, running perf help works correctly even when
> the binary is named perf, perf-master, or perf-backup:
> 
> /mnt/perf help
> /mnt/perf-master help
> /mnt/perf-backup help
> 
> All of them now display the expected help information without aborting.

Thanks for the detailed report and the fix.  Looks good to me we don't
need to look up the cmdnames when there's nothing to exclude.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


