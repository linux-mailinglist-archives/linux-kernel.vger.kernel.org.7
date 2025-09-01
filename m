Return-Path: <linux-kernel+bounces-793778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14170B3D814
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAFE3B5536
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ECF21A44C;
	Mon,  1 Sep 2025 04:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcjS8hE4"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB212AE77
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 04:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756699565; cv=none; b=bP7eYs0zQf6jyFxxMxfuPwwp2dKUzmLRylbE6gTit94fpKswDzBeItGGh0U7SRqFinwrlb3gJhTvxtdkiEW8HoUPYUSMDLaPDNm66TufepMhOyIn29JZqfOXYfsERDje2nt6A9iXiD6h7zKD97lc/SzwE3i21vLVFUH0ssikVq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756699565; c=relaxed/simple;
	bh=y6kHM+s0TnFzAn6Bl6kSULl8uzcqf2BORPkeik4KbX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWB67mfXgVjOWlPhEiqgm2gRZl+S69cmiGap8k2fteuw16ihFCXam8hBbh7GLpZfUm+vAoSi4KFQMvJYn8I/iX8hgwvSJ4yKx+LaDwAi2A5QVukEwVXNuC2Ugp3TkseiCPAlnsxLucdzjm0hOugOwZSc1dPasE9ifeHjjaV6GB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcjS8hE4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso3445278a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756699562; x=1757304362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhVnddQyo/Wb+5L1xwZUny9QGur8ry8ZcQT+esJ56DQ=;
        b=BcjS8hE4oG8opFp7bWVXQ4DoVZIMV2DHKKQZkHwWRC5EXALmaPvWKJfQBuBUub8fDe
         Pf9/k2r2mU74eXJ/OpXrB69phpAX27ib6XrUKSVeJdtBBmJq8iBIV+jcVAMfRc7xeZmI
         bQiNad8fwsQcm5BzKtzBPVCrvJ8tS33DFBGqJYFUhVh6p6SijtL6p3e2yZLSJ8gHmM+q
         1k8Oi5CdL//rKKPAyYunZJ6NhWOXiJmfU9tWk1NZ/vyC9C7ubhYpUziNh/SuvJT26aoU
         LWVgCrm+5xywsmpWTbgOLuMtnACjYKPNIQIyaQsUIKsCLwyOrEbXPXfTLmPN2wTa1/1I
         2DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756699562; x=1757304362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhVnddQyo/Wb+5L1xwZUny9QGur8ry8ZcQT+esJ56DQ=;
        b=SGMYIplG2fiUwrVl/dGT1VrotXCmHLQsEvCloySCm/sfTWrFdbd7JiCDf9Vjh1Wi1B
         5CfbbYeQo1nV3L8jVm06KUpYASfpolI0eLPJWRwpwZ2yMwC3utpIKqHNwqP/XmHYv5N4
         fi7AdxoFahGTK87TupKloygM9Za/5UNGp6n9DCGW4wy4M1YlHX4Xh0b5qBBvWjr1oX2B
         NFB0degFgu0meycL/vh59wKBxPiBHz58s/4MoCNCqtX2DlAhbCjm9KVhU0Jl6CHW5rWi
         ZHfuUZNA0bFXr9WMYkq1xzLUnoJshpl1YpGZvVdMJI6hPDKiMN/ybsvKszQKXQJ62Qfw
         qJCg==
X-Forwarded-Encrypted: i=1; AJvYcCWGbKPRiN7VImiVdm0NvrdCIXTs22I48zbIUycbYx8/S2W/DhecC1QGoPKyWKAvihjuikw/TL2QGbdy1g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyirkEAjuEtTSzrGte4uRdeZGNEA7eCBeYDSagRUpO0SsSl4Zw8
	abv8WNy4YE64YCyvpVHXyKZw8U/4lGjGyXu7fK1SBRWYKODm1T+71Lyi
X-Gm-Gg: ASbGncuwZYE/3QVCwD5fOI//dmSIruLhrcVmNp4sC4Rc4R7MkooOxGc/b9H1RNCFnm6
	yvlq+6BezCONHLN8W2DxtSkPxB072FpoML70WfhHHSqdF+17q7xkumqFfCGHTKXm8m/b0keP1pA
	17EiM4uWoYEvQ5wxXqoudd9kUT+URMtcbEgU6C8eT63MkR/icAzMVHzS/pIehP+okedkjxHCuOK
	D2Zn0xXo9Ykmwyxb2/8p2Sfu+7xorzmPlsWfmea+Mnu3J2i5mxxC/+Mz36Vfy23gpfyGfrq+n8I
	mr3vu4GrL2v4kjkVGgKpZXbIYd8UOxJSIYBZFOmIzeiP/zopWfBUt6gCFQE9ND1/vNZWrO+BMCu
	3+hxEotgiOpPe9J6LsUkAqEZ9XUJAtKazaZ1XlFn6AtD0al1x9UVSZnTWwFF4PrEA4UmCYZUhFm
	E=
X-Google-Smtp-Source: AGHT+IFq2jLk34VvRWtzlZjCL91aTLS83lxLzIiGeGP0F0Y9Bbn2PLy+Kd8ygAaYNricer1Vq0hRBA==
X-Received: by 2002:a05:6a20:a11e:b0:243:b06a:3d5e with SMTP id adf61e73a8af0-243d6dd0204mr7665309637.1.1756699562333;
        Sun, 31 Aug 2025 21:06:02 -0700 (PDT)
Received: from kaiwan-dell-7550.. ([205.254.163.218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8cc9091csm68457a12.19.2025.08.31.21.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 21:06:01 -0700 (PDT)
From: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
To: tglx@linutronix.de
Cc: Llillian@star-ark.net,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alexander.shishkin@linux.intel.com,
	anna-maria@linutronix.de,
	bigeasy@linutronix.de,
	catalin.marinas@arm.com,
	chenhuacai@kernel.org,
	francesco@valla.it,
	frederic@kernel.org,
	guoweikang.kernel@gmail.com,
	jstultz@google.com,
	kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	mingo@kernel.org,
	pmladek@suse.com,
	rrangel@chromium.org,
	sboyd@kernel.org,
	urezki@gmail.com,
	v-singh1@ti.com,
	will@kernel.org,
	Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Subject: 
Date: Mon,  1 Sep 2025 09:35:25 +0530
Message-ID: <20250901040538.381976-1-kaiwan.billimoria@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <871pp14pkr.ffs@tglx>
References: <871pp14pkr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> What the heck is BOOT SIG Initiative?
Very, very briefly: it's an initiative that plans to measure the complete or
unified boot time, i.e., the time it takes to boot the system completely. This
includes (or plans to) track the time taken for:
- Boot from CPU power-on, ROM code execution
- 1st, 2nd, (and possibly) 3rd stage bootloader(s)
- Linux kernel upto running the PID 1 process
- Include time taken for onboard MCUs (and their apps to come up).

The plan is to be able to show the cumulative and individual times taken across
all of these. Then report it via ASCII text and a GUI system (as of now, a HTML
file).
For anyone interested, here's the PDF of a super presentation on this topic by
Vishnu P Singh (OP) this August at the OSS EU:
https://static.sched.com/hosted_files/osseu2025/a2/EOSS_2025_Unified%20Boot%20Time%20log%20based%20measurement.pdf
As mentioned by Vishnu, the work is in the very early dev stages.

> -	pr_info("sched_clock: %u bits at %lu%cHz, resolution %lluns, wraps every %lluns\n",
> -		bits, r, r_unit, res, wrap);
> +	pr_info("sched_clock: %pS: %u bits at %lu%cHz, resolution %lluns, wraps every %lluns hwcnt: %llu\n",
> +		read, bits, r, r_unit, res, wrap, read());
--snip--
> So let's assume this give you
>
> [    0.000008] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps
>                             every 3579139424256ns hwcnt: 19000000
>
> Which means that the counter accumulated 19000000 increments since the
> hardware was powered up, no?
I agree with your approach Thomas (tglx)! (eye-roll)... So, following this
approach, here's the resulting tiny patch:

From 1e687ab12269f5f129b17eb7e9c3c5c2cec441b7 Mon Sep 17 00:00:00 2001
From: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date: Mon, 1 Sep 2025 09:17:57 +0530
Subject: [PATCH] [sched-clock] Extend printk to show h/w counter in a
 parseable manner

Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
---
 kernel/time/sched_clock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index cc15fe293719..e4fe900d6b60 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -236,16 +236,14 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 	/* Calculate the ns resolution of this counter */
 	res = cyc_to_ns(1ULL, new_mult, new_shift);

-	pr_info("sched_clock: %u bits at %lu%cHz, resolution %lluns, wraps every %lluns\n",
-		bits, r, r_unit, res, wrap);
+	pr_info("sched_clock: %pS: bits=%u,freq=%lu %cHz,resolution=%llu ns,wraps every=%llu ns,hwcnt=%llu\n",
+                read, bits, r, r_unit, res, wrap, read());

 	/* Enable IRQ time accounting if we have a fast enough sched_clock() */
 	if (irqtime > 0 || (irqtime == -1 && rate >= 1000000))
 		enable_sched_clock_irqtime();

 	local_irq_restore(flags);
-
-	pr_debug("Registered %pS as sched_clock source\n", read);
 }

 void __init generic_sched_clock_init(void)
--
2.43.0

Of course, this is almost identical to what Thomas has already shown. I've
added some formatting to make for easier parsing. A sample output obtained with
this code on a patched kernel for the BeaglePlay k3 am625 board:
[    0.000001] sched_clock: arch_counter_get_cntpct+0x0/0x18: bits=58,freq=200 MHz,resolution=5 ns,wraps every=4398046511102 ns,hwcnt=1409443611

This printk format allows us to easily parse it; f.e. to obtain the hwcnt value:
debian@BeagleBone:~$ dmesg |grep sched_clock |awk -F, '{print $5}'
hwcnt=1409443611

So, just confirming: here 1409443611 divided by 200 MHz gives us 7.047218055s
since boot, and thus the actual timestamp here is that plus 0.000001s yes?
(Over 7s here? yes, it's just that I haven't yet setup U-Boot properly for uSD
card boot, thus am manually loading commands in U-Boot to boot up, that's all).

A question (perhaps very stupid): will the hwcnt - the output of the read() -
be guaranteed to be (close to) the number of increments since processor
power-up (or reset)? Meaning, it's simply a hardware feature and agnostic to
what code the core was executing (ROM/BL/kernel), yes?
If so, I guess we can move forward with this approach... Else, or otherwise,
suggestions are welcome,

Regards,
Kaiwan.

