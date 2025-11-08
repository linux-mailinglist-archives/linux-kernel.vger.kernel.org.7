Return-Path: <linux-kernel+bounces-891512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 583D5C42D26
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 14:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91F253493ED
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 13:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DF5199E94;
	Sat,  8 Nov 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf6BGuuW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30DA19005E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762607291; cv=none; b=Ss6iyXOpLzmnI+j8nfWZcvm6QciMYIxBYGbEv2c09LJkLm8mcT5yR1qOY8lNEedi72mfqjZo+0VEGqA02OXCOLh3JN3DXDrIr/cgcxIUrio+s2nUKadIvlTPwPtRjloxzqQd4vXSJ5MlD6ZdOElVTZ0LotOWmk/iP5TcjhP/jJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762607291; c=relaxed/simple;
	bh=OQni4Y657hkwe/ivscLuJNRMjj9kfBkHaqK7Whu40Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rl2hhrQwtU7XP0GhPTu+YOR0BhgOMj1JR5kO8sXR5hlGXBMadkyWfh8k7e6aTHyrFTHvsy4X51SW10Cjdgehvioyth5Lxnsd7k8Cx26GwwBQUjRDbKCMWFiAuHFL9h+asQo5CzX14Sg+k1RotHYf4JpMAbRO/qjGnBKwuWtGtxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf6BGuuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03824C116C6;
	Sat,  8 Nov 2025 13:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762607290;
	bh=OQni4Y657hkwe/ivscLuJNRMjj9kfBkHaqK7Whu40Zs=;
	h=Date:From:To:Cc:Subject:From;
	b=Cf6BGuuWpZVM7Sr/7oRDoJAo5AcYgUBA6G53T4/U5okkpy1mgd7LEu3rtOTyzJmsg
	 ohnxdjHuT3ssp3YG8vRGLC6RxwqdVJxKsTeUdqPDcDRBxM839HT9R7LZBdIR7nzou3
	 C3U+qJZpkTZF/3YeKkbyU7SGyz5eyrh4OF4EUEzrIj8VJlIZcYIB2ha6YqNbTmGq5n
	 Eyrx8E752ktJA+33QSBZZ9cprQrdlgnBGNzdZbN4Vnf3pVzWkowV5cWn7vRhFr4yZg
	 9CaxORydrFefvAPG+3w9Rlksh768EQhPTTPoBKqbCEgfH+VACx7ueHHVsLN4bAS4W5
	 zZ1XpuJ/+tk8g==
Date: Sat, 8 Nov 2025 14:07:58 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] perf events fix
Message-ID: <aQ9ArnO-84XJlCVB@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-11-08

   # HEAD: eb3182ef0405ff2f6668fd3e5ff9883f60ce8801 perf/core: Fix system hang caused by cpu-clock usage

Fix a system hang caused by cpu-clock events.

 Thanks,

	Ingo

------------------>
Dapeng Mi (1):
      perf/core: Fix system hang caused by cpu-clock usage


 kernel/events/core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 177e57c1a362..1fd347da9026 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11773,7 +11773,8 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 
 	event = container_of(hrtimer, struct perf_event, hw.hrtimer);
 
-	if (event->state != PERF_EVENT_STATE_ACTIVE)
+	if (event->state != PERF_EVENT_STATE_ACTIVE ||
+	    event->hw.state & PERF_HES_STOPPED)
 		return HRTIMER_NORESTART;
 
 	event->pmu->read(event);
@@ -11819,15 +11820,20 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 
 	/*
-	 * The throttle can be triggered in the hrtimer handler.
-	 * The HRTIMER_NORESTART should be used to stop the timer,
-	 * rather than hrtimer_cancel(). See perf_swevent_hrtimer()
+	 * Careful: this function can be triggered in the hrtimer handler,
+	 * for cpu-clock events, so hrtimer_cancel() would cause a
+	 * deadlock.
+	 *
+	 * So use hrtimer_try_to_cancel() to try to stop the hrtimer,
+	 * and the cpu-clock handler also sets the PERF_HES_STOPPED flag,
+	 * which guarantees that perf_swevent_hrtimer() will stop the
+	 * hrtimer once it sees the PERF_HES_STOPPED flag.
 	 */
 	if (is_sampling_event(event) && (hwc->interrupts != MAX_INTERRUPTS)) {
 		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
 		local64_set(&hwc->period_left, ktime_to_ns(remaining));
 
-		hrtimer_cancel(&hwc->hrtimer);
+		hrtimer_try_to_cancel(&hwc->hrtimer);
 	}
 }
 
@@ -11871,12 +11877,14 @@ static void cpu_clock_event_update(struct perf_event *event)
 
 static void cpu_clock_event_start(struct perf_event *event, int flags)
 {
+	event->hw.state = 0;
 	local64_set(&event->hw.prev_count, local_clock());
 	perf_swevent_start_hrtimer(event);
 }
 
 static void cpu_clock_event_stop(struct perf_event *event, int flags)
 {
+	event->hw.state = PERF_HES_STOPPED;
 	perf_swevent_cancel_hrtimer(event);
 	if (flags & PERF_EF_UPDATE)
 		cpu_clock_event_update(event);
@@ -11950,12 +11958,14 @@ static void task_clock_event_update(struct perf_event *event, u64 now)
 
 static void task_clock_event_start(struct perf_event *event, int flags)
 {
+	event->hw.state = 0;
 	local64_set(&event->hw.prev_count, event->ctx->time);
 	perf_swevent_start_hrtimer(event);
 }
 
 static void task_clock_event_stop(struct perf_event *event, int flags)
 {
+	event->hw.state = PERF_HES_STOPPED;
 	perf_swevent_cancel_hrtimer(event);
 	if (flags & PERF_EF_UPDATE)
 		task_clock_event_update(event, event->ctx->time);

