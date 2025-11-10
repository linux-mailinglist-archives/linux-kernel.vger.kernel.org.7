Return-Path: <linux-kernel+bounces-893821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C32E4C48702
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C0FF4E880B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710F12E6CAF;
	Mon, 10 Nov 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FaKRlyES"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B52D8393
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797364; cv=none; b=NToHqvgDH2NEwjVEgLT9UdUYml9FQcYzY+AKh/MDOhYjwiWONFtpPkmEVZ/7uOeNgxW1BO+h1jkcg5bAM/KV250Xt9FxUx5n4YuhGbbaeliaDnIlojNkGiP1m0gnlCKC0PClryN1Fnx85vWDx5wPiDoCp4SJ2PeROUAL7ySLEAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797364; c=relaxed/simple;
	bh=AZPkb/7jkVQ65GMJXdoTdsWp0WFNQv9BH8xC3IUHJMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/H6D7zksMdwlt176owgMakYJEmhp6Y003RuhDaE/GEfuicjRvFXZ0Odz6C+S78d77dynxiY4hCPaKB1nZY4ChL+5ktJyP+2Jwy5HLg/2lUtVYR8fRmdaaiVD8pWxcMbQ/lRsBLkxzChVuIWzesoLxkNXRUlF+ctQkUPc7sfxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FaKRlyES; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b72db05e50fso516020866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762797360; x=1763402160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=87oo0NjzU5gVBElPXv51xM5CWxLbNXP1OAbLCeiVmXA=;
        b=FaKRlyESFSwpKnTraYV0au2JMnJQTMw0NQcxQvWDvfPLqb+BOdZr3g8ksDla8J24aM
         lhqViLSL4fOoQ0dMzOw12x5GQ5Qt9waHz+PnvdSCxqD9KcgqzirAhaV7EH2vuh1mBHNL
         nijPUMiOXb08WSY9HSE4ip8FmH1YmVD0eEfZyjSnMtEGG09G2/OruTXLVRNE3Dz5x93A
         kpl43n7l5SDzhdkbdEWBxHt0zXvnaj3N/3V9r/v37HcBquAKdoLdwSwlUbVbgz1CveTI
         ZVYjq9pX1AYTkPbH8bDcFIZD6dbw4YYVYrrfdPzDo1DFIovbnMbVQIU43WYXxAJ9blyN
         SRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762797360; x=1763402160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87oo0NjzU5gVBElPXv51xM5CWxLbNXP1OAbLCeiVmXA=;
        b=cK+hnF1hm79OmkzLWvEYq33uOtlwnzrnCKmlWgipiifvAXmcbv2E869g4yXCYf1gfG
         uUrM5hsSYYFDLPgzOolT161GzETUlNMU5Vho1Uwru6l5OqML2kMfLvLeIAPh9KRu3z8Q
         OMAg7OZ3CPsaAi5D1qwCsvFWlPh30MQhh+U4UWuubPDiGIoifiUQ2gV9nhojnJUql3DF
         ZtpTR5BbzPF1/Rgb/1W8yBpyOyFPNkoZddIPO/ZUR9PVRQB4NgGdyDP2/YCIu8JOmCVZ
         GZiNbjW7ct116Y8GCSUiiuwRQdMulFnnvzCL88NAWuNkY+0/dyoAbKjsS3Gk8TcviW0Y
         5u0w==
X-Forwarded-Encrypted: i=1; AJvYcCVgkBPk7Uh7KszYyjqOMkR3BCo/YiDw+3oSyShnoVgnE0/H2/KI8JDDxp+90kYhCwYTe8MCYS3Ymt9JKp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvtv+IRkfYiBXuXyzeaY6DTOesv0ypN7gQ0ES5GHtVlZN7R6ve
	8mGRbregvEcM4SVGW1MPUWygQhDOamYIiFy1XjZrH8V/zI2OamvXis5j0K8SLt1uKjA=
X-Gm-Gg: ASbGncsfPM53Z4yG7hbuF0JyXVi8Xgt71+0TFN/8q0bwpd2Z21/Rqtq64QJsF2xz47M
	cRWNvx49gsonEwDFHLpeHI8peS/tC3xtb5dClHBYAgmTUKdz0/JG34gmwqMfN6X/lxSo2ppmFXx
	kJUjiJS7zitON6+28nL6RG3ke8Zpbnvh+7Wl3gEQZXDNf/F0weKE3gMP73dnWFW23jUdMILjR3/
	pGkdCitHRxjI1LrjO+v8khU3rtsaeAJbzAGBm0khGfY8bxJ/R+64cDyAsft1Yb/H7WS/N06jKPN
	A70wfgQX7DbHY3t+a2psvoMXAarqhm559p1yCRHyQQDLqtcI+S7/CO+LB+gFWBDZ3cKfHV8Ho11
	k5rxk8WBCqLO3P6Q7mYT0iHfWsecF5tgdX8IxW9Z7a+cg3yyKGClbRt1Rm0sA7OBvTyAJ0mDnXH
	j5lUOMLHLdEf8SHw==
X-Google-Smtp-Source: AGHT+IEOHSm+DTRNh96tdtDTv4rBUx6JMJ7FM0MMopRhHwQGm3OHMwuo1WzwWCW/YMe+fw14jqJSnw==
X-Received: by 2002:a17:907:2d91:b0:b72:9961:dc04 with SMTP id a640c23a62f3a-b72e0377a59mr954305166b.28.1762797360037;
        Mon, 10 Nov 2025 09:56:00 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d43bsm1189365066b.45.2025.11.10.09.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:55:59 -0800 (PST)
Date: Mon, 10 Nov 2025 18:55:57 +0100
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <ioworker0@gmail.com>, paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hung_task: Add hung_task_sys_info sysctl to dump sys
 info on task-hung
Message-ID: <aRInLdgKCzaVeyG0@pathway.suse.cz>
References: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
 <20251106023032.25875-3-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106023032.25875-3-feng.tang@linux.alibaba.com>

On Thu 2025-11-06 10:30:31, Feng Tang wrote:
> When task-hung happens, developers may need different kinds of system
> information (call-stacks, memory info, locks, etc.) to help debugging.
> 
> Add 'hung_task_sys_info' sysctl knob to take human readable string like
> "tasks,mem,timers,locks,ftrace,...", and when task-hung happens, all
> requested information will be dumped. (refer kernel/sys_info.c for more
> details).
> 
> Meanwhile, the newly introduced sys_info() call is used to unify some
> existing info-dumping knobs.
> 
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -60,12 +61,23 @@ static unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
>  static int __read_mostly sysctl_hung_task_warnings = 10;
>  
>  static int __read_mostly did_panic;
> -static bool hung_task_show_lock;
>  static bool hung_task_call_panic;
> -static bool hung_task_show_all_bt;
>  
>  static struct task_struct *watchdog_task;
>  
> +/*
> + * A bitmask to control what kinds of system info to be printed when
> + * a hung task is detected, it could be task, memory, lock etc. Refer
> + * include/linux/sys_info.h for detailed bit definition.
> + */
> +static unsigned long hung_task_si_mask;
> +
> +/*
> + * There are several sysctl knobs, and this serves as the runtime
> + * effective sys_info knob
> + */
> +static unsigned long cur_si_mask;

It seems that this variable is used to pass information between
check_hung_task() and check_hung_uninterruptible_tasks().

And "hung_task_show_lock" and "hung_task_show_all_bt" had the same
purpose.

If I get it correctly, we could move these decisions to
check_hung_uninterruptible_tasks() and avoid the global
variable.

I think that it even makes the code a bit cleaner.

Something like this on top of this patch:

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 5f0275b2c742..c2a0dfce1e56 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -71,12 +71,6 @@ static struct task_struct *watchdog_task;
  */
 static unsigned long hung_task_si_mask;
 
-/*
- * There are several sysctl knobs, and this serves as the runtime
- * effective sys_info knob
- */
-static unsigned long cur_si_mask;
-
 #ifdef CONFIG_SMP
 /*
  * Should we dump all CPUs backtraces in a hung task event?
@@ -229,11 +223,8 @@ static inline void debug_show_blocker(struct task_struct *task, unsigned long ti
 }
 #endif
 
-static void check_hung_task(struct task_struct *t, unsigned long timeout,
-		unsigned long prev_detect_count)
+static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
-	unsigned long total_hung_task;
-
 	if (!task_is_hung(t, timeout))
 		return;
 
@@ -243,16 +234,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout,
 	 */
 	sysctl_hung_task_detect_count++;
 
-	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
 	trace_sched_process_hang(t);
 
-	cur_si_mask = hung_task_si_mask;
-	if (sysctl_hung_task_panic && total_hung_task >= sysctl_hung_task_panic) {
-		console_verbose();
-		cur_si_mask |= SYS_INFO_LOCKS;
-		hung_task_call_panic = true;
-	}
-
 	/*
 	 * Ok, the task did not get scheduled for more than 2 minutes,
 	 * complain:
@@ -272,10 +255,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout,
 			" disables this message.\n");
 		sched_show_task(t);
 		debug_show_blocker(t, timeout);
-		cur_si_mask |= SYS_INFO_LOCKS;
 
-		if (sysctl_hung_task_all_cpu_backtrace)
-			cur_si_mask |= SYS_INFO_ALL_BT;
 		if (!sysctl_hung_task_warnings)
 			pr_info("Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings\n");
 	}
@@ -315,8 +295,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 {
 	int max_count = sysctl_hung_task_check_count;
 	unsigned long last_break = jiffies;
+	unsigned long total_hung_task;
 	struct task_struct *g, *t;
 	unsigned long prev_detect_count = sysctl_hung_task_detect_count;
+	unsigned long si_mask;
 
 	/*
 	 * If the system crashed already then all bets are off,
@@ -325,6 +307,14 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	if (test_taint(TAINT_DIE) || did_panic)
 		return;
 
+	si_mask = hung_task_si_mask;
+	if (sysctl_hung_task_warnings || hung_task_call_panic) {
+		si_mask |= SYS_INFO_LOCKS;
+
+		if (sysctl_hung_task_all_cpu_backtrace)
+			si_mask |= SYS_INFO_ALL_BT;
+	}
+
 	rcu_read_lock();
 	for_each_process_thread(g, t) {
 
@@ -336,16 +326,20 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 			last_break = jiffies;
 		}
 
-		check_hung_task(t, timeout, prev_detect_count);
+		check_hung_task(t, timeout);
 	}
  unlock:
 	rcu_read_unlock();
 
-	if (unlikely(cur_si_mask)) {
-		sys_info(cur_si_mask);
-		cur_si_mask = 0;
+	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
+	if (sysctl_hung_task_panic && total_hung_task >= sysctl_hung_task_panic) {
+		console_verbose();
+		hung_task_call_panic = true;
 	}
 
+	if (unlikely(si_mask))
+		sys_info(si_mask);
+
 	if (hung_task_call_panic)
 		panic("hung_task: blocked tasks");
 }

What do you think?

Hmm, maybe, we might still need to pass "prev_detect_count" and
keep "console_verbose()" in check_hung_task().

Best Regards,
Petr

