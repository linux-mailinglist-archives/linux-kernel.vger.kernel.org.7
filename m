Return-Path: <linux-kernel+bounces-795667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB6DB3F62D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23AA61A87212
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4272E5B2D;
	Tue,  2 Sep 2025 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8sktvqO"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF392E2F05
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796598; cv=none; b=eHoPfZnhm89Q0O/d1EThUHJ18SAoCx/6Kt6xtRmYoLwEfrqGcvwDJGcejPPecaFJ6TGId1dlX7doxp54jsIoxLdHGtQQJ1DTWFfZk/i/MDNcVhof7kkJy0K8FJt8Uqwgamz4r1P6k+qXZdocdvX7oA+oOI49E35yb5oaIOPv/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796598; c=relaxed/simple;
	bh=zfTLdIJcmFFMz1I11TZEdM/lHsyzyxpadlIYbyXfpQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJPkVrI8giuH7a5Ps21URmV3vQminhqbXVUuHUgsqO+uA+uyXBh0MJOfIuIX7+vXopiMLeMbN//4VV9xNMuoE0kzORHcwmv6hYFegap44llqTQsy/GpCdXduy9EcmXR3wfS8JCDzlJ8fsptSfAJzRdcaYvAFblVwkoZrsYLQ1Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8sktvqO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24a9cc916b3so20712325ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756796596; x=1757401396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjN6fz1puhwRkO/DsCAgBce7KYAheDsJqQlff5/9as0=;
        b=k8sktvqOzvTUMNEBOpt3THvlnwue/qx77mWLbLJDk1t5DAq/5IrabbuyCNKHmWjZVx
         mu0fgeW/iaygGB/EUvslFNRUXnhgPOtpZoFlkcbp3k7Jc03ZCQyYzy+8ybZTshdvtVwT
         Jjx40eI1od+VtghjfVkDuhjoBcf6oAW2t00BqAnF55aIBHm0eyzd0szgktmtZYJy0Ikw
         FTSVwcUGlKgNDZaT8DEmS4/M1V/5sXw5GqHGV/5lP+0C76A8rUwXp5CxqsjvbpI8M77W
         OIk1eKtjIFuhq/SRaNSO4n6b0yoTknK2nzU/BrIFlVg3qWE/r/YBFBHPXER4cWhRcXbF
         N3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756796596; x=1757401396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjN6fz1puhwRkO/DsCAgBce7KYAheDsJqQlff5/9as0=;
        b=OcY/NISFQTflibvAyMK5g1ABSeBlDMGM1REYI9/KvIJfcmw15FJHJtUx9w5lMM50d6
         EFyL3ErjD/zPwoGJWK4yWOWz/H1IpB+/bZRK4+AYkFTEp0pDejnK04VaONVCJ5kpNmmL
         VMvPAhphVL8/Xez9k/0Y2A/uuzhnGDIW2vu6YPqE7N5SkW9XnhzJfu6ZmV9HIeZ9dJ4O
         ACVHlAJRDJyk8kh6pQ64O0Ag5YDzfE56ify71D8Cs1w3fRteg0vUY7jiJkozp0obSvAQ
         RV3dkYjjBK3qWwaZZLaPYy8G5/fHycovzJS0qkPpLAcIu/8yZCVVS3LO3nMQSeP0K9Gl
         t0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWlUs0s3hFTR3Uu3jQuQ+lUe1ZY2WHsRW7hclV/TRRvxeqLsjCYv3HU4d+v21yfbCgpH8Kmts/Qws+61Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaPsOmCYBVnC61r4qACRcdmH7rG+d3ZAzAy6fYQxPFEHczIGM/
	wIs6Ybd0qR/tw3gwjb7aIpDVaujfDO1VBecnE8EJeVZQA7k+jLPCkF3KM32IWye8
X-Gm-Gg: ASbGncvK2+e7DsQWDCx8A1ywLLFokNPjQjxfkgAlKgX2wDCDUVYE7JUbrRcAqgVgesh
	DU358EtlT77XDcfC3eN1rOl+aeiZv2WgmiIlCuAWm9jkP1xPrcnkhWFaVo9iB77Va0Pc2K4+ydh
	6wxIq2FTnRW99rpgP4JKf+iYR4emG33EBKZuaZjHawB1fvOMRmJKi+TGfu99DOD2+iVPYfiR2Zz
	emz+QbXt18Ldhy4Nsw/E2cTNMzLX0eb25W41dTZQmKuBH6sUHsIPz2dU4VhH/FWzhhVE0A/HAMB
	Y1I0ZrCUsCv78yumWmUe9i6WKwePUvSxDEOcvHh+W2EJOs9kLPKWeGrBD+xK/2PZLLvFsA9NWUH
	JHLvleoFTKhFVNOzvaP12yWnJ9sgjEsiv380YlNE/SLbM/5ha93B33UGTJnJRwGjz7vQTl6+Mco
	0Pn0pYy+HsUw==
X-Google-Smtp-Source: AGHT+IGWJN+5Nv3M/5bl4i6U+8jbOOzjkDapkuLfiTYn9/7iKshcWpGgJbYsFlVBs7ZMMtWdXG0Rwg==
X-Received: by 2002:a17:903:32d2:b0:249:3ea3:61eb with SMTP id d9443c01a7336-24944870a42mr125000655ad.10.1756796596287;
        Tue, 02 Sep 2025 00:03:16 -0700 (PDT)
Received: from kaiwan-dell-7550.. ([205.254.163.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490375b6d0sm123187085ad.62.2025.09.02.00.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:03:15 -0700 (PDT)
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
Subject: Re: [RFC PATCH] time: introduce BOOT_TIME_TRACKER and minimal boot timestamp
Date: Tue,  2 Sep 2025 12:32:13 +0530
Message-ID: <20250902070253.936687-1-kaiwan.billimoria@gmail.com>
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

Resending, as the Subject was missing...

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

