Return-Path: <linux-kernel+bounces-675079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BE8ACF8BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 22:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE34D18961F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 20:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E72827E1AB;
	Thu,  5 Jun 2025 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDmvjUGH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E1427C163;
	Thu,  5 Jun 2025 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749155078; cv=none; b=UUoaJFi0sOuU+V3Wxsscp5b6bxf3N5+1ruYIhiUYHt0lZjW6RApKXqkfBmZrUXD1Ymof7ARl20DHEYfiiQVbNXq+lsYyR5h7QmzmXXiry6CqOz7X0dfSZXsSbXaHYv3YEhD/4lg7LcrewhG5Hyp+ufVKhDz+GdSMF+QMK+OucZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749155078; c=relaxed/simple;
	bh=2xEW5RG5lQq8nfJEmdLnGnTJamYOUI5Rm7JOLsqkuVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKXBvM8nUFRHrCSDKQTmPg1u89YC8FnTOAW+Y0qlpDtkxoPozojO8qMEbJbj6ExlJltGSrLzFKak1NLZMa69wxIW+wyzTE4+JW3ceNei5R5Rtpfa0fR9GoOV/Hnt9nCwRMYjoz3reI1bIzrv4U7zaghKhD9m+DKfKClQ65zgYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDmvjUGH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749155076; x=1780691076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2xEW5RG5lQq8nfJEmdLnGnTJamYOUI5Rm7JOLsqkuVA=;
  b=DDmvjUGHCIDIcFxsBj4EgftCEPHYsbtxD+vd/a8Arfd3WZ2AyOiU9OkJ
   Md/34ChUpeW6bCx8ocX3hx+N2EwLuBbmKzo15OF+ZUfE2+a/nXO/sYABQ
   wBSi72rjkY7gf0O1Jj4qn5FLSV+H0SO2uKR3MMNwqL34hqXWxkgEimBLr
   wopprRv6JDo28PFQK08XOFv2Ce/3a4K9eciQEbQVvokBN510e8c70JGCE
   Md/SVsKL7hoF7fZnujfls/ZjLf78jbGy9dEK8i0wr6QwCKUCXHePeAF0t
   XcfqSrzDt6AHe+1LEMT/Tktv9cNC7Qd6abXe9F/0laVrD8bug8gRZ02Ia
   w==;
X-CSE-ConnectionGUID: DDV4BkxySBOMU+Zpy0VIEQ==
X-CSE-MsgGUID: uTdLCtuoRx6nR6NW54+lmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="62654469"
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="62654469"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 13:24:34 -0700
X-CSE-ConnectionGUID: CC0lPI03R7+ZR0220w9Tqg==
X-CSE-MsgGUID: 6r48t8XDTRGs54qqs0Lk8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="146204263"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 13:24:34 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9A8DE20B5736;
	Thu,  5 Jun 2025 13:24:31 -0700 (PDT)
Message-ID: <3f8b0b58-3b48-470e-b8ff-a71a26370bc3@linux.intel.com>
Date: Thu, 5 Jun 2025 16:24:30 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] perf: Fix the throttle error of some clock events
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Mark Rutland <mark.rutland@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 "linux-perf-use." <linux-perf-users@vger.kernel.org>,
 Stephane Eranian <eranian@google.com>, Chun-Tse Shao <ctshao@google.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Leo Yan <leo.yan@arm.com>,
 Aishwarya TCV <aishwarya.tcv@arm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20250604171554.3909897-1-kan.liang@linux.intel.com>
 <CAADnVQKjyzdNVR_+WCMzORPJAX00tD3HK0vaCz13ZprWaG72Tg@mail.gmail.com>
 <d5fcf34f-63fe-451b-89ad-621c38981709@linux.intel.com>
 <CAADnVQ+N5UaBwLjtLGHAe1PCjpRzxxcFL45gbb0eHMDZD5+X6A@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAADnVQ+N5UaBwLjtLGHAe1PCjpRzxxcFL45gbb0eHMDZD5+X6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-06-05 2:45 p.m., Alexei Starovoitov wrote:
> On Thu, Jun 5, 2025 at 6:46 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2025-06-04 7:21 p.m., Alexei Starovoitov wrote:
>>> On Wed, Jun 4, 2025 at 10:16 AM <kan.liang@linux.intel.com> wrote:
>>>>
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> Both ARM and IBM CI reports RCU stall, which can be reproduced by the
>>>> below perf command.
>>>>   perf record -a -e cpu-clock -- sleep 2
>>>>
>>>> The issue is introduced by the generic throttle patch set, which
>>>> unconditionally invoke the event_stop() when throttle is triggered.
>>>>
>>>> The cpu-clock and task-clock are two special SW events, which rely on
>>>> the hrtimer. The throttle is invoked in the hrtimer handler. The
>>>> event_stop()->hrtimer_cancel() waits for the handler to finish, which is
>>>> a deadlock. Instead of invoking the stop(), the HRTIMER_NORESTART should
>>>> be used to stop the timer.
>>>>
>>>> There may be two ways to fix it.
>>>> - Introduce a PMU flag to track the case. Avoid the event_stop in
>>>>   perf_event_throttle() if the flag is detected.
>>>>   It has been implemented in the
>>>>   https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.intel.com/
>>>>   The new flag was thought to be an overkill for the issue.
>>>> - Add a check in the event_stop. Return immediately if the throttle is
>>>>   invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTART
>>>>   method to stop the timer.
>>>>
>>>> The latter is implemented here.
>>>>
>>>> Move event->hw.interrupts = MAX_INTERRUPTS before the stop(). It makes
>>>> the order the same as perf_event_unthrottle(). Except the patch, no one
>>>> checks the hw.interrupts in the stop(). There is no impact from the
>>>> order change.
>>>>
>>>> Reported-by: Leo Yan <leo.yan@arm.com>
>>>> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
>>>> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
>>>> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>>> Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw/
>>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>>> Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131293@linux.ibm.com/
>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> It seems the patch fixes one issue and introduces another ?
>>>
>>> Looks like the throttle event is sticky.
>>> Once it's reached the perf_event no longer works ?
>>
>> No. It should still work even the throttle is triggered.
>>
>> sdp@d404e6bce080:~$ sudo bash -c 'echo 10 >
>> /proc/sys/kernel/perf_event_max_sample_rate'
>> sdp@d404e6bce080:~$ sudo perf record -a -e cpu-clock -c10000 -- sleep 1
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.559 MB perf.data (584 samples) ]
> 
> With the patch applied above command hangs in my VM:
> 
> # perf record -a -e cpu-clock -c10000 -- sleep 1
> [   43.656855] hrtimer: interrupt took 21640 ns
> [   68.561052] watchdog: BUG: soft lockup - CPU#0 stuck for 41s! [perf:2253]
> [   68.561056] Modules linked in: bpf_preload
> [   68.561060] CPU: 0 UID: 0 PID: 2253 Comm: perf Not tainted
> 6.15.0-12294-gc89e5202e569 #1172 PREEMPT
> [   68.561062] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   68.561063] RIP: 0010:handle_softirqs+0x77/0x2a0
> [   68.561070] Code: 6b 96 02 00 01 00 00 bd 0a 00 00 00 44 89 64 24
> 14 89 6c 24 10 40 88 7c 24 04 31 c0 65 66 89 05 5f 6b 96 02 fb bb ff
> ff ff ff <48> c7 c0 c0 f
> [   68.561071] RSP: 0018:ffa0000000003fa0 EFLAGS: 00000246
> [   68.561072] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 00000000000006e0
> [   68.561073] RDX: 0000000000000007 RSI: ff1100010212e100 RDI: 0000000000000000
> [   68.561074] RBP: 000000000000000a R08: 0000000000000000 R09: 7fffffffffffffff
> [   68.561074] R10: 00000005a3af2140 R11: 0000000000004601 R12: 0000000000400100
> [   68.561075] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000
> [   68.561111] FS:  00007fa1b536f780(0000) GS:ff110004abe26000(0000)
> knlGS:0000000000000000
> [   68.561112] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   68.561113] CR2: 0000000001c67a30 CR3: 000000010f2f3003 CR4: 00000000003716f0
> [   68.561113] Call Trace:
> [   68.561170]  <IRQ>
> [   68.561174]  irq_exit_rcu+0x91/0xb0
> [   68.561176]  sysvec_apic_timer_interrupt+0x71/0x90
> [   68.561181]  </IRQ>
> [   68.561181]  <TASK>
> [   68.561182]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [   68.561184] RIP: 0010:generic_exec_single+0x33/0x120
> [   68.561188] Code: 65 39 3d 5c 4d 89 02 74 28 3b 3d b8 f5 17 02 0f
> 83 de 00 00 00 89 f8 48 0f a3 05 d8 f1 17 02 0f 83 ce 00 00 00 e8 bd
> fe ff ff <31> c0 5b 5d 9
> [   68.561189] RSP: 0018:ffa00000025a3cc0 EFLAGS: 00000206
> [   68.561190] RAX: 0000000000000000 RBX: ffffffff8145b310 RCX: ff110004abe26000
> [   68.561190] RDX: 0000000000000007 RSI: 0000000000000000 RDI: ff1100042fa26540
> [   68.561191] RBP: 0000000000000202 R08: 0000000000000000 R09: 0000000000000000
> [   68.561191] R10: ffa00000025a3ee0 R11: 0000000000000000 R12: ffa00000025a3d40
> [   68.561192] R13: ff11000100881220 R14: ff11000100880fc0 R15: 0000000000000000
> [   68.561192]  ? sw_perf_event_destroy+0x70/0x70
> [   68.561197]  smp_call_function_single+0xc4/0x110
> [   68.561199]  ? sw_perf_event_destroy+0x70/0x70
> [   68.561200]  event_function_call+0x160/0x170
> [   68.561202]  ? ctx_resched+0x2d0/0x2d0
> [   68.561205]  ? perf_event_set_state+0x60/0x60
> [   68.561206]  ? _perf_event_disable+0x50/0x50
> [   68.561208]  perf_event_for_each_child+0x37/0x80
> [   68.561209]  ? _perf_event_disable+0x50/0x50
> [   68.561211]  _perf_ioctl+0x1df/0xad0
> [   68.561213]  ? __set_cpus_allowed_ptr+0x71/0x80
> [   68.561216]  ? avc_has_perm+0x72/0x160
> [   68.561219]  ? ldsem_down_write+0x1bb/0x1fc
> [   68.561222]  perf_ioctl+0x42/0x70
> [   68.561224]  __x64_sys_ioctl+0x8f/0xd0
> [   68.561226]  do_syscall_64+0x46/0x160
> [   68.561228]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> but only after a fresh boot.
> 
> If I run bpf selftests before that it works.
> Like test_progs -t stacktrace_build_id_nmi
> followed by the same
> perf record -a -e cpu-clock ..
> it works fine.
> 

There should be a bug in V3. When stops in the throttle, the event
should not be updated, stop(event, 0). But the cpu_clock_event_stop()
doesn't handle the flag. That changes the behavior a little bit.

Could you please try the below patch and see if it helps?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cd85b1820e7d..b6c57ba24e78 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2656,8 +2656,8 @@ static void perf_event_unthrottle(struct
perf_event *event, bool start)

 static void perf_event_throttle(struct perf_event *event)
 {
-	event->pmu->stop(event, 0);
 	event->hw.interrupts = MAX_INTERRUPTS;
+	event->pmu->stop(event, 0);
 	if (event == event->group_leader)
 		perf_log_throttle(event, 0);
 }
@@ -11777,7 +11777,12 @@ static void perf_swevent_cancel_hrtimer(struct
perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;

-	if (is_sampling_event(event)) {
+	/*
+	 * The throttle can be triggered in the hrtimer handler.
+	 * The HRTIMER_NORESTART should be used to stop the timer,
+	 * rather than hrtimer_cancel(). See perf_swevent_hrtimer()
+	 */
+	if (is_sampling_event(event) && (hwc->interrupts != MAX_INTERRUPTS)) {
 		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
 		local64_set(&hwc->period_left, ktime_to_ns(remaining));

@@ -11832,7 +11837,8 @@ static void cpu_clock_event_start(struct
perf_event *event, int flags)
 static void cpu_clock_event_stop(struct perf_event *event, int flags)
 {
 	perf_swevent_cancel_hrtimer(event);
-	cpu_clock_event_update(event);
+	if (flags & PERF_EF_UPDATE)
+		cpu_clock_event_update(event);
 }

 static int cpu_clock_event_add(struct perf_event *event, int flags)


Thanks,
Kan


