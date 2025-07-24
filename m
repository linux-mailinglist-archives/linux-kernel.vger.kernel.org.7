Return-Path: <linux-kernel+bounces-744989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC76B1134F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9FB581349
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D023C512;
	Thu, 24 Jul 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX6CIi6K"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039CB23AB8F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394046; cv=none; b=rdeVTQVIo0qEB/hWn5+8d8l1UzCk+/a+RYF/K+lZEEN+0WmSrV1CQSJ2n3USYaER4wViqd/obwB14wfTF5HZitwpmBcvnCCjNpMQmlHnRCwbrtl1keW6iX7zMpfDb3cFOIRYdt126jFaAp2NoKgT5mNDW7wwuiuSjH1wgREXdmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394046; c=relaxed/simple;
	bh=KaGVfMXJroiAAaIqZdCS4h+cRnaEAyj04DqTZ6ZuhHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Neuhs7pFreG0IcLPKLKxPjTnpQYURkWFxLElgltj7I5U68KZlvOavK9vN633jM6gdh+sISLGZDKg46Y0y55HdTapfUMoTLmEtgMpabcg/auibYHWAAEZW+fFCVSQtqr1QASLO/aZELj3Ve71lsUZK7uGb319Ft4E/9QacHeL/qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HX6CIi6K; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-75ce8f8a3a1so1007584b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753394044; x=1753998844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=toWeuCffowX+9fpDVpMkxMxQflhMt8H2bVSUF2S2NKU=;
        b=HX6CIi6KQYH6PwcScxq2KNTmTRuGOYDEUjGKPNH92FMPtEzd0+tyl6t8Y1WNPL/KcU
         1fjaYggSxdvgOTASomA86sbG/yFk4lDxhUgElQRRs9dWmEovGrTe9J0GlkAOjXI7FNb5
         j/AL4OlEEZ1OtNWf73oK3qvwJ8tqQ779Ul5mf+WhQT2Z3rQrZ8+n0eh4d+OCUyBiO2jK
         8Ehs2TA9bh8tu9Zj1hKTurns6Oq0KgF4OsKTpQnNHbs4gwX2vNFw++ZWmznKgEh1AZ62
         DI0PtsHkSdgqlYzlPi7uOGxyN7a0ykbg0ONzVGQKbSBmkzKKS2YnllXf2x8lAGeIPVEV
         hN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753394044; x=1753998844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toWeuCffowX+9fpDVpMkxMxQflhMt8H2bVSUF2S2NKU=;
        b=i8t0lZHDCEzuIt5OwWj7aGaZqLePpwe4pmtBAHl+VP7uW4TBpEdSQ4hyjGfWmBOOYU
         MA7PzMuFftjIx8WsSxIWCdDlbUx4Y581JE40vGT/hOlHt+bS13VP0zI3SL64O4a8o8+g
         ylz7N5kDDDyr/HDkjQF4J1zrfr+3eFi8oxgQtVV166vwb6p+Q8KIz0boFiMR765OPELe
         NY3Ofx0jlyxgLW/R2oJhYvbfMyds7rkTEeC0lX7MoUt8tvDFTOMyXtSWkrfbNlnBz+WQ
         I6xh9Xrq3JpL0go4cXNq1frQWkhwa3qFMHB+1Gk+jazXI7US0uE9EXpMGALdp5XXC8zE
         Pjeg==
X-Forwarded-Encrypted: i=1; AJvYcCUKWLQu36UY3Na1LYCtmIsZKFEHBXVwQfYFE+QJVxd587zs4WahHvykkOKdl018Tt6y24hC6HY4ShTQUNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FvNzlJWajZFRaU36lYn2m/F6pekY21fJGP8X3XcDl4fM0dD+
	WmDU7Nu551E4eRzJg/Un/CU8B8U2pApTQAYfXGyvT5cl7n6KXqSkgngB
X-Gm-Gg: ASbGnctU70RfhDdpu2RvM4QOdUCNmkMLg5sSqlC4d5sjVYjuLm+ysQ0JClHq8xrNnHB
	4lobTwkKQI6eASuieUckrzI81l/ylAS06YwbAh++ggPk9Ip/vcFg9Hh/GAuPswA6MK33wX8F33b
	8kcjZ1mrfq7m5OyuLdpSzMr47qCDmjfR9X7+oRYZ2UpRkT78jx8LnANcHHsxt43NX1ry//nLGcl
	hmdStoPxRC8oxsOa+HYzMdFq9XVye4Tt9lpyWBqKJP3aG0rE85c9th+90jcJviCp7aykUqhNCir
	iA2iu/gf9V905z4PEoIqiFCxB19VnzP3jdAO2b6DUCeME2YWEB2sxmlsp2arnTsN2GCxbgrP5NX
	OoYusinW1Gmswu2GgFBUkmHbiz5ltYCuiaEH5p3Ah
X-Google-Smtp-Source: AGHT+IGOX261eCO3OKAALgDpSl0lSElJyKVjSgvezitzfhJsTEGH3uvIxWprF40ugrfl9jkKddlBGA==
X-Received: by 2002:aa7:88c8:0:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-76034c56938mr12528912b3a.7.1753394044262;
        Thu, 24 Jul 2025 14:54:04 -0700 (PDT)
Received: from dev-machine ([2607:fb90:33af:1e63:f0a9:3023:5b5f:ebde])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7622833c9e2sm1804679b3a.21.2025.07.24.14.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 14:54:03 -0700 (PDT)
From: Niko Nikolov <nikolay.niko.nikolov@gmail.com>
To: shuah@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niko Nikolov <nikolay.niko.nikolov@gmail.com>
Subject: [PATCH] x86/tsc: Replace do_div() with div64_u64()/div64_ul()
Date: Thu, 24 Jul 2025 14:53:39 -0700
Message-ID: <20250724215339.11390-1-nikolay.niko.nikolov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace do_div() with the recommended division helpers to avoid
truncation and follow kernel best practices, as flagged by static
analysis.

./arch/x86/kernel/tsc.c:409:1-7:
WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
./arch/x86/kernel/tsc.c:492:1-7:
WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead.
./arch/x86/kernel/tsc.c:831:2-8:
WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead.

Signed-off-by: Niko Nikolov <nikolay.niko.nikolov@gmail.com>
---
 arch/x86/kernel/tsc.c | 185 +++++++++++++++++++++---------------------
 1 file changed, 91 insertions(+), 94 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 87e749106dda..96f40759340e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -34,13 +34,13 @@
 #include <asm/uv/uv.h>
 #include <asm/sev.h>
 
-unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
+unsigned int __read_mostly cpu_khz; /* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
 
 unsigned int __read_mostly tsc_khz;
 EXPORT_SYMBOL(tsc_khz);
 
-#define KHZ	1000
+#define KHZ 1000
 
 /*
  * TSC can be unstable due to cpufreq or due to unsynced TSCs
@@ -55,13 +55,13 @@ int tsc_clocksource_reliable;
 static int __read_mostly tsc_force_recalibrate;
 
 static struct clocksource_base art_base_clk = {
-	.id    = CSID_X86_ART,
+	.id = CSID_X86_ART,
 };
 static bool have_art;
 
 struct cyc2ns {
-	struct cyc2ns_data data[2];	/*  0 + 2*16 = 32 */
-	seqcount_latch_t   seq;		/* 32 + 4    = 36 */
+	struct cyc2ns_data data[2]; /*  0 + 2*16 = 32 */
+	seqcount_latch_t seq; /* 32 + 4    = 36 */
 
 }; /* fits one cacheline */
 
@@ -81,9 +81,11 @@ __always_inline void __cyc2ns_read(struct cyc2ns_data *data)
 		seq = this_cpu_read(cyc2ns.seq.seqcount.sequence);
 		idx = seq & 1;
 
-		data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
-		data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
-		data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);
+		data->cyc2ns_offset =
+			this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
+		data->cyc2ns_mul = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
+		data->cyc2ns_shift =
+			this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);
 
 	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.seqcount.sequence)));
 }
@@ -145,7 +147,8 @@ static __always_inline unsigned long long cycles_2_ns(unsigned long long cyc)
 	return ns;
 }
 
-static void __set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
+static void __set_cyc2ns_scale(unsigned long khz, int cpu,
+			       unsigned long long tsc_now)
 {
 	unsigned long long ns_now;
 	struct cyc2ns_data data;
@@ -172,8 +175,8 @@ static void __set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long ts
 		data.cyc2ns_mul >>= 1;
 	}
 
-	data.cyc2ns_offset = ns_now -
-		mul_u64_u32_shr(tsc_now, data.cyc2ns_mul, data.cyc2ns_shift);
+	data.cyc2ns_offset = ns_now - mul_u64_u32_shr(tsc_now, data.cyc2ns_mul,
+						      data.cyc2ns_shift);
 
 	c2n = per_cpu_ptr(&cyc2ns, cpu);
 
@@ -184,7 +187,8 @@ static void __set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long ts
 	write_seqcount_latch_end(&c2n->seq);
 }
 
-static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
+static void set_cyc2ns_scale(unsigned long khz, int cpu,
+			     unsigned long long tsc_now)
 {
 	unsigned long flags;
 
@@ -278,7 +282,10 @@ bool using_native_sched_clock(void)
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
 
-bool using_native_sched_clock(void) { return true; }
+bool using_native_sched_clock(void)
+{
+	return true;
+}
 #endif
 
 notrace u64 sched_clock(void)
@@ -331,16 +338,18 @@ static int __init tsc_setup(char *str)
 	if (!strcmp(str, "nowatchdog")) {
 		no_tsc_watchdog = 1;
 		if (tsc_as_watchdog)
-			pr_alert("%s: Overriding earlier tsc=watchdog with tsc=nowatchdog\n",
-				 __func__);
+			pr_alert(
+				"%s: Overriding earlier tsc=watchdog with tsc=nowatchdog\n",
+				__func__);
 		tsc_as_watchdog = 0;
 	}
 	if (!strcmp(str, "recalibrate"))
 		tsc_force_recalibrate = 1;
 	if (!strcmp(str, "watchdog")) {
 		if (no_tsc_watchdog)
-			pr_alert("%s: tsc=watchdog overridden by earlier tsc=nowatchdog\n",
-				 __func__);
+			pr_alert(
+				"%s: tsc=watchdog overridden by earlier tsc=nowatchdog\n",
+				__func__);
 		else
 			tsc_as_watchdog = 1;
 	}
@@ -349,8 +358,8 @@ static int __init tsc_setup(char *str)
 
 __setup("tsc=", tsc_setup);
 
-#define MAX_RETRIES		5
-#define TSC_DEFAULT_THRESHOLD	0x20000
+#define MAX_RETRIES 5
+#define TSC_DEFAULT_THRESHOLD 0x20000
 
 /*
  * Read TSC and the reference counters. Take care of any disturbances
@@ -388,7 +397,7 @@ static unsigned long calc_hpet_ref(u64 deltatsc, u64 hpet1, u64 hpet2)
 	do_div(tmp, 1000000);
 	deltatsc = div64_u64(deltatsc, tmp);
 
-	return (unsigned long) deltatsc;
+	return (unsigned long)deltatsc;
 }
 
 /*
@@ -406,19 +415,18 @@ static unsigned long calc_pmtimer_ref(u64 deltatsc, u64 pm1, u64 pm2)
 	pm2 -= pm1;
 	tmp = pm2 * 1000000000LL;
 	do_div(tmp, PMTMR_TICKS_PER_SEC);
-	do_div(deltatsc, tmp);
+	div64_u64(deltatsc, tmp);
 
-	return (unsigned long) deltatsc;
+	return (unsigned long)deltatsc;
 }
 
-#define CAL_MS		10
-#define CAL_LATCH	(PIT_TICK_RATE / (1000 / CAL_MS))
-#define CAL_PIT_LOOPS	1000
-
-#define CAL2_MS		50
-#define CAL2_LATCH	(PIT_TICK_RATE / (1000 / CAL2_MS))
-#define CAL2_PIT_LOOPS	5000
+#define CAL_MS 10
+#define CAL_LATCH (PIT_TICK_RATE / (1000 / CAL_MS))
+#define CAL_PIT_LOOPS 1000
 
+#define CAL2_MS 50
+#define CAL2_LATCH (PIT_TICK_RATE / (1000 / CAL2_MS))
+#define CAL2_PIT_LOOPS 5000
 
 /*
  * Try to calibrate the TSC against the Programmable
@@ -468,10 +476,10 @@ static unsigned long pit_calibrate_tsc(u32 latch, unsigned long ms, int loopmin)
 		t2 = get_cycles();
 		delta = t2 - tsc;
 		tsc = t2;
-		if ((unsigned long) delta < tscmin)
-			tscmin = (unsigned int) delta;
-		if ((unsigned long) delta > tscmax)
-			tscmax = (unsigned int) delta;
+		if ((unsigned long)delta < tscmin)
+			tscmin = (unsigned int)delta;
+		if ((unsigned long)delta > tscmax)
+			tscmax = (unsigned int)delta;
 		pitcnt++;
 	}
 
@@ -489,7 +497,7 @@ static unsigned long pit_calibrate_tsc(u32 latch, unsigned long ms, int loopmin)
 
 	/* Calculate the PIT value */
 	delta = t2 - t1;
-	do_div(delta, ms);
+	div64_ul(delta, ms);
 	return delta;
 }
 
@@ -535,7 +543,8 @@ static inline int pit_verify_msb(unsigned char val)
 	return inb(0x42) == val;
 }
 
-static inline int pit_expect_msb(unsigned char val, u64 *tscp, unsigned long *deltap)
+static inline int pit_expect_msb(unsigned char val, u64 *tscp,
+				 unsigned long *deltap)
 {
 	int count;
 	u64 tsc = 0, prev_tsc = 0;
@@ -602,7 +611,7 @@ static unsigned long quick_pit_calibrate(void)
 
 	if (pit_expect_msb(0xff, &tsc, &d1)) {
 		for (i = 1; i <= MAX_QUICK_PIT_ITERATIONS; i++) {
-			if (!pit_expect_msb(0xff-i, &delta, &d2))
+			if (!pit_expect_msb(0xff - i, &delta, &d2))
 				break;
 
 			delta -= tsc;
@@ -618,7 +627,7 @@ static unsigned long quick_pit_calibrate(void)
 			/*
 			 * Iterate until the error is less than 500 ppm
 			 */
-			if (d1+d2 >= delta >> 11)
+			if (d1 + d2 >= delta >> 11)
 				continue;
 
 			/*
@@ -651,7 +660,7 @@ static unsigned long quick_pit_calibrate(void)
 	 * kHz = ((t2 - t1) * PIT_TICK_RATE) / (I * 256 * 1000)
 	 */
 	delta *= PIT_TICK_RATE;
-	do_div(delta, i*256*1000);
+	do_div(delta, i * 256 * 1000);
 	pr_info("Fast TSC calibration using PIT\n");
 	return delta;
 }
@@ -686,8 +695,7 @@ unsigned long native_calibrate_tsc(void)
 	 * CPUID_LEAF_FREQ for the calculation below, so hardcode the 25MHz
 	 * crystal clock.
 	 */
-	if (crystal_khz == 0 &&
-			boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
+	if (crystal_khz == 0 && boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
 		crystal_khz = 25000;
 
 	/*
@@ -707,8 +715,8 @@ unsigned long native_calibrate_tsc(void)
 		unsigned int eax_base_mhz, ebx, ecx, edx;
 
 		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		crystal_khz = eax_base_mhz * 1000 *
-			eax_denominator / ebx_numerator;
+		crystal_khz =
+			eax_base_mhz * 1000 * eax_denominator / ebx_numerator;
 	}
 
 	if (crystal_khz == 0)
@@ -824,11 +832,11 @@ static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
 		else
 			tsc2 = calc_pmtimer_ref(tsc2, ref1, ref2);
 
-		tsc_ref_min = min(tsc_ref_min, (unsigned long) tsc2);
+		tsc_ref_min = min(tsc_ref_min, (unsigned long)tsc2);
 
 		/* Check the reference deviation */
-		delta = ((u64) tsc_pit_min) * 100;
-		do_div(delta, tsc_ref_min);
+		delta = ((u64)tsc_pit_min) * 100;
+		div64_ul(delta, tsc_ref_min);
 
 		/*
 		 * If both calibration results are inside a 10% window
@@ -921,7 +929,6 @@ unsigned long native_calibrate_cpu_early(void)
 	return fast_calibrate;
 }
 
-
 /**
  * native_calibrate_cpu - calibrate the cpu
  */
@@ -955,7 +962,6 @@ void recalibrate_cpu_khz(void)
 }
 EXPORT_SYMBOL_GPL(recalibrate_cpu_khz);
 
-
 static unsigned long long cyc2ns_suspend;
 
 void tsc_save_sched_clock_state(void)
@@ -1016,12 +1022,12 @@ void tsc_restore_sched_clock_state(void)
  * first tick after the change will be slightly wrong.
  */
 
-static unsigned int  ref_freq;
+static unsigned int ref_freq;
 static unsigned long loops_per_jiffy_ref;
 static unsigned long tsc_khz_ref;
 
 static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-				void *data)
+				 void *data)
 {
 	struct cpufreq_freqs *freq = data;
 
@@ -1036,7 +1042,7 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 		tsc_khz_ref = tsc_khz;
 	}
 
-	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
+	if ((val == CPUFREQ_PRECHANGE && freq->old < freq->new) ||
 	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
 		boot_cpu_data.loops_per_jiffy =
 			cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
@@ -1052,7 +1058,7 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 }
 
 static struct notifier_block time_cpufreq_notifier_block = {
-	.notifier_call  = time_cpufreq_notifier
+	.notifier_call = time_cpufreq_notifier
 };
 
 static int __init cpufreq_register_tsc_scaling(void)
@@ -1062,7 +1068,7 @@ static int __init cpufreq_register_tsc_scaling(void)
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
 		return 0;
 	cpufreq_register_notifier(&time_cpufreq_notifier_block,
-				CPUFREQ_TRANSITION_NOTIFIER);
+				  CPUFREQ_TRANSITION_NOTIFIER);
 	return 0;
 }
 
@@ -1088,8 +1094,7 @@ static void __init detect_art(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR) ||
 	    !boot_cpu_has(X86_FEATURE_NONSTOP_TSC) ||
-	    !boot_cpu_has(X86_FEATURE_TSC_ADJUST) ||
-	    tsc_async_resets)
+	    !boot_cpu_has(X86_FEATURE_TSC_ADJUST) || tsc_async_resets)
 		return;
 
 	cpuid(CPUID_LEAF_TSC, &art_base_clk.denominator,
@@ -1105,7 +1110,6 @@ static void __init detect_art(void)
 	setup_force_cpu_cap(X86_FEATURE_ART);
 }
 
-
 /* clocksource code */
 
 static void tsc_resume(struct clocksource *cs)
@@ -1165,20 +1169,19 @@ static int tsc_cs_enable(struct clocksource *cs)
  * .mask MUST be CLOCKSOURCE_MASK(64). See comment above read_tsc()
  */
 static struct clocksource clocksource_tsc_early = {
-	.name			= "tsc-early",
-	.rating			= 299,
-	.uncertainty_margin	= 32 * NSEC_PER_MSEC,
-	.read			= read_tsc,
-	.mask			= CLOCKSOURCE_MASK(64),
-	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
-				  CLOCK_SOURCE_MUST_VERIFY,
-	.id			= CSID_X86_TSC_EARLY,
-	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
-	.enable			= tsc_cs_enable,
-	.resume			= tsc_resume,
-	.mark_unstable		= tsc_cs_mark_unstable,
-	.tick_stable		= tsc_cs_tick_stable,
-	.list			= LIST_HEAD_INIT(clocksource_tsc_early.list),
+	.name = "tsc-early",
+	.rating = 299,
+	.uncertainty_margin = 32 * NSEC_PER_MSEC,
+	.read = read_tsc,
+	.mask = CLOCKSOURCE_MASK(64),
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_MUST_VERIFY,
+	.id = CSID_X86_TSC_EARLY,
+	.vdso_clock_mode = VDSO_CLOCKMODE_TSC,
+	.enable = tsc_cs_enable,
+	.resume = tsc_resume,
+	.mark_unstable = tsc_cs_mark_unstable,
+	.tick_stable = tsc_cs_tick_stable,
+	.list = LIST_HEAD_INIT(clocksource_tsc_early.list),
 };
 
 /*
@@ -1187,21 +1190,19 @@ static struct clocksource clocksource_tsc_early = {
  * been found good.
  */
 static struct clocksource clocksource_tsc = {
-	.name			= "tsc",
-	.rating			= 300,
-	.read			= read_tsc,
-	.mask			= CLOCKSOURCE_MASK(64),
-	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
-				  CLOCK_SOURCE_VALID_FOR_HRES |
-				  CLOCK_SOURCE_MUST_VERIFY |
-				  CLOCK_SOURCE_VERIFY_PERCPU,
-	.id			= CSID_X86_TSC,
-	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
-	.enable			= tsc_cs_enable,
-	.resume			= tsc_resume,
-	.mark_unstable		= tsc_cs_mark_unstable,
-	.tick_stable		= tsc_cs_tick_stable,
-	.list			= LIST_HEAD_INIT(clocksource_tsc.list),
+	.name = "tsc",
+	.rating = 300,
+	.read = read_tsc,
+	.mask = CLOCKSOURCE_MASK(64),
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_VALID_FOR_HRES |
+		 CLOCK_SOURCE_MUST_VERIFY | CLOCK_SOURCE_VERIFY_PERCPU,
+	.id = CSID_X86_TSC,
+	.vdso_clock_mode = VDSO_CLOCKMODE_TSC,
+	.enable = tsc_cs_enable,
+	.resume = tsc_resume,
+	.mark_unstable = tsc_cs_mark_unstable,
+	.tick_stable = tsc_cs_tick_stable,
+	.list = LIST_HEAD_INIT(clocksource_tsc.list),
 };
 
 void mark_tsc_unstable(char *reason)
@@ -1235,7 +1236,8 @@ bool tsc_clocksource_watchdog_disabled(void)
 
 static void __init check_system_tsc_reliable(void)
 {
-#if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || defined(CONFIG_X86_GENERIC)
+#if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || \
+	defined(CONFIG_X86_GENERIC)
 	if (is_geode_lx()) {
 		/* RTSC counts during suspend */
 #define RTSC_SUSP 0x100
@@ -1361,7 +1363,6 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 
 	/* Will hit this only if tsc_force_recalibrate has been set */
 	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
-
 		/* Warn if the deviation exceeds 500 ppm */
 		if (abs(tsc_khz - freq) > (tsc_khz >> 11)) {
 			pr_warn("Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!\n");
@@ -1371,21 +1372,19 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 		}
 
 		pr_info("TSC freq recalibrated by [%s]:\t %lu.%03lu MHz\n",
-			hpet ? "HPET" : "PM_TIMER",
-			(unsigned long)freq / 1000,
+			hpet ? "HPET" : "PM_TIMER", (unsigned long)freq / 1000,
 			(unsigned long)freq % 1000);
 
 		return;
 	}
 
 	/* Make sure we're within 1% */
-	if (abs(tsc_khz - freq) > tsc_khz/100)
+	if (abs(tsc_khz - freq) > tsc_khz / 100)
 		goto out;
 
 	tsc_khz = freq;
 	pr_info("Refined TSC clocksource calibration: %lu.%03lu MHz\n",
-		(unsigned long)tsc_khz / 1000,
-		(unsigned long)tsc_khz % 1000);
+		(unsigned long)tsc_khz / 1000, (unsigned long)tsc_khz % 1000);
 
 	/* Inform the TSC deadline clockevent devices about the recalibration */
 	lapic_update_tsc_freq();
@@ -1407,7 +1406,6 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	clocksource_unregister(&clocksource_tsc_early);
 }
 
-
 static int __init init_tsc_clocksource(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_TSC) || !tsc_khz)
@@ -1479,8 +1477,7 @@ static bool __init determine_cpu_tsc_frequencies(bool early)
 		return false;
 
 	pr_info("Detected %lu.%03lu MHz processor\n",
-		(unsigned long)cpu_khz / KHZ,
-		(unsigned long)cpu_khz % KHZ);
+		(unsigned long)cpu_khz / KHZ, (unsigned long)cpu_khz % KHZ);
 
 	if (cpu_khz != tsc_khz) {
 		pr_info("Detected %lu.%03lu MHz TSC",
-- 
2.50.1


