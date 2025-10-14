Return-Path: <linux-kernel+bounces-852914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC94FBDA3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C59C45034E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE372FFF8F;
	Tue, 14 Oct 2025 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+4gblNf"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D6E29D269
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454276; cv=none; b=XTut0lBfpv8pWeKRuYKSHXx1UVn+lWxBzCzT9piCw+2qnbBfWLKh3AMVUtmLc6i3uxUEshig+vcATjppYwropFjlN15IU2bomVp6dCdiEz/4r7hMOwtdrPQ/I6jOPu3f0iksD7Sz/84DhAATfwmSBI/iYUTvYrpwMxXzdv1m1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454276; c=relaxed/simple;
	bh=e978bWoFjBQgsdNlqdWrRQsmNCkoajFMktc9t6zXMkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sd+Qt//LAOlkww1kCvuHUGFKnBYqcegeQ0+S6RWCGqeTDxc0kdHgXU+ueICHcMadgzocEPQ/m+Ka4RfEbcBiqEwlDSGqfM0Fqem0/60Wcnbm1kxpE7wLRMyVDSiW5hY3tuZGbwpsnrKihICJnhvpnlYVpdlZuaMXustXgK9KKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+4gblNf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so7018160a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454274; x=1761059074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSUQIaWycRWPeDhTmGOQryGYmMnqnnTORM1hSoq/o6g=;
        b=b+4gblNfZiVfacEshgdSjU9uT0/fhBk1hPDaGXiJ1rH+wtjndQBJbEPyvvX7LebKRf
         HM+/SJbA68jR/KP0+fLL5k5CZwaDTH0PTOAT2cG+dt/WsoC+ccXMpVaF5jdCalBNSx/A
         zpHxx4WK22GTRVjtUCq9eb/pYUfrPgyfu1sQ4J+/uecxM18fQi3KXanOpLeHJQ7T19IK
         H46k9cNntHmWpOyRj4xvPqv8FS1umu9v3LlA691Ftd8N1X0QVYktnnFN6tgrOVttvB85
         LB6RvYVaE3vBKppWqPClz9fe6ILFBYvzOArpIywixhIJ0D8CyRZN/bzU8tlHewnVa3FG
         eFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454274; x=1761059074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSUQIaWycRWPeDhTmGOQryGYmMnqnnTORM1hSoq/o6g=;
        b=oytyPg2lg/jE+j2Eo5rN/bkqwUDc5DGMIrARlhYBYwi0XIuvJDWc8bKW/tYfdVmlwK
         ugy2IFPu6IUYqadIatbMWw24a3jUvS4tJ0sIaKYLNvgKPQviP6JtbrNVf/XE3JT19b6u
         jdmMd8zsD/X8O/4Ftmo2G7mPkrx5msJHUd5SE/7k8S+P8okfUdluOnV4IZ4LsBwKWvhr
         EquSADNHfXbEHkFjHP6iafvQTuyrh3NcmkEC323660IoiS1naji7+taVa25PHp2GpytS
         KRXZ1GWimPhgg/VkLV9a33gEllVLiAkEqbgYZ5q+F2lYNyXO9fsjKPYXmw3tYFu64QYf
         r2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVi3s8IFmz2D1Pa5Cy+ARlZXFlfUk++oGVTYoeGoSwoGAuNhKZQ8ZrxmKxoZAupWbkN0/zTtOQPl+xvgQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiWddWFfpEJ72ZiOMtZueYv3gKTYri174KA2s591YiThdRxvB9
	348YZ4zlAAgGXlYLd1yjV4HQ5OCuQizIPFm1m2AL74iAZAarOEID02Mk
X-Gm-Gg: ASbGncvQJrP8d6ylKXNnRg4tUF3A1B91htuk+t0smRqC14+n4ZikxoEbGs16abmPeEn
	j9jhfVJNQuPnub2we3nrV9EOIn9rdU35Ne95Xodw8+/4BBgeLP9++UBQztsEVEESdCE5AannTEt
	RuJ+1Vlp67EhG/T7CDH2metwgn9nqFWmzoECGhbnENM/T+rLSz4w2p0PpEbO1H2uh3C1MLzeS2X
	I/Kvdp1bnVlSS/GP3KPHCx14bbbVeeDDFPEUW/WLywAF2AdVzElFB35IZWrQjZP8VldT9nPKWCi
	pcY2dVFPpSbBUlPFVlFnDZSP2DS8yWd95wFG/yamMquCNGBxRQpqBs9GmPZmU2KDUOq01JyVXCK
	Dvf4MJ0Ze37R7Ih7B3otzJ8zOc7BuQ0JnrZUJkqITsg0QO/8NPfzvjw==
X-Google-Smtp-Source: AGHT+IEoF6lCOjN7CENp+OMe8HdUVTMA65Yq9hlYC7eCiNlOgtVtwVNNnLz/+2DFCjSowB7zKkXu2A==
X-Received: by 2002:a17:90b:1b04:b0:32b:cb05:849a with SMTP id 98e67ed59e1d1-33b513861cdmr32152572a91.29.1760454273320;
        Tue, 14 Oct 2025 08:04:33 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:04:32 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:37 +0800
Subject: [PATCH RESEND v8 04/21] drivers/perf: apple_m1: Support a
 per-implementation number of counters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-4-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4845; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=e978bWoFjBQgsdNlqdWrRQsmNCkoajFMktc9t6zXMkE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZsrkM+DTU4+ennTxw+fzNUfJ9SwPdeIDOW9
 KOaOTHEIsiJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbAAKCRABygi3psUI
 JOfSD/9lLAvN0+5kZ7WZhC2c29OhNbFQ3jzCr4QfopyMWk9PI9okEb+pDwYako8qTkrWMJTfa3J
 4M+hha4zgsIN5xtINN7QpT19s80g93wxOvjjg7TrvBs5iDeKKDmswgC9X0wvkHQzG5+RuWddbKf
 tl2HsjK0hbHCGyjKByFRSiNZQWBTpBHO/W/azKnC4oIkM/8fyMKLd/9N3wukPUP1UyJGThODncm
 GlnJ+rOoJd3Ab/U8ixWuefAZRHbFR0ob1eqJZ25xwaA9WdExRjOjzq62bX54UEy0BNwS/C5UfdY
 mu4fxj0ZO6X+8lqIpZk8z8mg9oa7iAlVxv3yT+rJqbEaSUX40V/WFI4kAnnrfYOsxhPytg/Efs2
 EKmsfPpiwOZi9u6aZ2btITnM9LIeIPoATmfx/lhkY+3QqGheoCwzAIXBfCamYVBuWjv2eqzXfct
 Tj+xsQhtbD2gwwXwqKbCgvS0UxxYNjS92LGFpjlo+fGZN27Xav1dDqCYXT9YheOi4RsdS6ysAAM
 5VKJg/3Wz1WA3FqddwIjrHtCfDsebbUwjts/VqdSXNpZ14zXHnlOSQsI12zusztPfp6tFt4wMNp
 DnqDyxDgCVl+/qScBN7bwnLC8EhrxFyJLot6uD2xR2cw4hb0kMFeRl1dzRV6DKz7v8okNB/G2Y+
 gD67Rf6jer2UBJQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support a per-implementation number of counters to allow adding support
for implementations with less counters.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index b4ab6a3e5df965b7ef450d7e533995f3cc8633fd..b5fe04ef186f04b4af32524fe433afb79979b791 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -20,6 +20,7 @@
 #include <asm/perf_event.h>
 
 #define M1_PMU_NR_COUNTERS		10
+#define APPLE_PMU_MAX_NR_COUNTERS	10
 
 #define M1_PMU_CFG_EVENT		GENMASK(7, 0)
 
@@ -459,7 +460,7 @@ static irqreturn_t m1_pmu_handle_irq(struct arm_pmu *cpu_pmu)
 
 	regs = get_irq_regs();
 
-	for_each_set_bit(idx, cpu_pmu->cntr_mask, M1_PMU_NR_COUNTERS) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, APPLE_PMU_MAX_NR_COUNTERS) {
 		struct perf_event *event = cpuc->events[idx];
 		struct perf_sample_data data;
 
@@ -506,7 +507,7 @@ static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * counting on the PMU at any given time, and by placing the
 	 * most constraining events first.
 	 */
-	for_each_set_bit(idx, &affinity, M1_PMU_NR_COUNTERS) {
+	for_each_set_bit(idx, &affinity, APPLE_PMU_MAX_NR_COUNTERS) {
 		if (!test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
 	}
@@ -601,13 +602,13 @@ static void m1_pmu_init_pmceid(struct arm_pmu *pmu)
 	}
 }
 
-static void m1_pmu_reset(void *info)
+static void apple_pmu_reset(void *info, u32 counters)
 {
 	int i;
 
 	__m1_pmu_set_mode(PMCR0_IMODE_OFF);
 
-	for (i = 0; i < M1_PMU_NR_COUNTERS; i++) {
+	for (i = 0; i < counters; i++) {
 		m1_pmu_disable_counter(i);
 		m1_pmu_disable_counter_interrupt(i);
 		m1_pmu_write_hw_counter(0, i);
@@ -616,6 +617,11 @@ static void m1_pmu_reset(void *info)
 	isb();
 }
 
+static void m1_pmu_reset(void *info)
+{
+	apple_pmu_reset(info, M1_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 				   struct perf_event_attr *attr)
 {
@@ -639,7 +645,7 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 	return 0;
 }
 
-static int apple_pmu_init(struct arm_pmu *cpu_pmu)
+static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 {
 	cpu_pmu->handle_irq	  = m1_pmu_handle_irq;
 	cpu_pmu->enable		  = m1_pmu_enable_event;
@@ -649,7 +655,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
 	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
-	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
 	if (is_hyp_mode_available()) {
@@ -657,7 +662,7 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu)
 		m1_pmu_init_pmceid(cpu_pmu);
 	}
 
-	bitmap_set(cpu_pmu->cntr_mask, 0, M1_PMU_NR_COUNTERS);
+	bitmap_set(cpu_pmu->cntr_mask, 0, counters);
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return 0;
@@ -669,7 +674,8 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_icestorm_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
@@ -677,7 +683,8 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_firestorm_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
@@ -685,7 +692,8 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_avalanche_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
@@ -693,7 +701,8 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_blizzard_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static const struct of_device_id m1_pmu_of_device_ids[] = {

-- 
2.51.0


