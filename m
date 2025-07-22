Return-Path: <linux-kernel+bounces-740114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E5AB0D024
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CC83A768C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A502528DB5B;
	Tue, 22 Jul 2025 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0fLJEhji"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DDA28C87C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154132; cv=none; b=Z3kr5O46/vuZIo2l6QESv9F6zvgy/bZ44SFnq7He77O2vjiolX0apk8JxfVENOEhVnkgTJ96iz92sLtoMcD1PavN5VRfueZNNSFzMd6WtWbzZB3uGnVCKRHiq7ojfbfgcWv64RCKD6ZHBeqhm+tRCzMdo1GJO+EsPwzsqqOQlkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154132; c=relaxed/simple;
	bh=uYtYjvm/CF8/xHKZUyL9yCAMuXwAK4qREoTrGl5k3v8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Freb+bdqpHSfnkXHQOKq4DnIQWFAfKI4i7wuz7JBPC3etkZ0XOtyDWOx+IRgl6odXoc6LIi/6Ougur9IzrWv4Sm5TVvLFKTeNkgOEbCwFBKBZAMwPHHJArCTgRM7LShcr+j+TPRr+Jn29oCGnaZsCHopoCkjkn36xXpBPX0jXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0fLJEhji; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-75b5be236deso1811997b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753154130; x=1753758930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nz8h60LGers/LCMxx/FZVBLZipiol25W5EeTvz9jgI=;
        b=0fLJEhjiM4wCazJK+2hC3bVI3MHOP3WGEmtIE1iM2a46s6K9WckDz9Zn0QI8sX7z53
         jEhYveUIJT0JgphCs7I90UddDaHVCnbH5LI/WNisQC4uB15HgZsQkvLEcz93gdwVxOoM
         o/T6NjEFrVdF9SwAZ69VzEVutH1JyWJNQFxeYWDuOVPMiMZEv6hiwFrytvQX5YBsgcfB
         kulDHriIkiscNdNf312tPF7gCAky8diPAGWgxwamMaY/XaZvFoaf9/5UruteZY82ff/9
         8FzWrYIt6jbJtqWPYSd1y69g65+Y7KAEtSGemH+0dT45RDhlcZNlzqcPfZasqYk/j2kn
         c6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753154130; x=1753758930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nz8h60LGers/LCMxx/FZVBLZipiol25W5EeTvz9jgI=;
        b=pHTHrLF6Yw0R32u5ZBLgB9dK2k1IH7WGzSifHbjdQl9QGeAV68cwT3p85B7cI7yuQY
         q9GgQCT5nXyem3qrIcYvfyHBw5nlKObzLBQZ2eeJRCw15npCxsHL5FIyHhrwUV+obQwt
         Pakc7JfdBmKhgZxDEuYn+VCUaQo0vVsnu3A0BQFk9i6cdqPfVQXc+1CMQeoWshf98cTN
         GKeYFoRcGhg2IInNaHMBBjm52bCZI4IGmOQ5l31FaDxuuSSX8RLNAR5qvG9Ph/E6bCBX
         LZRpXzhzYaPPO+VEccT8vy0GFYFLhSfw5WPWMCJxcHDvawBJTjWNibOJWWjN4VPcuL9F
         bs9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3zCJUDVGdgkY963H72DqjBadBkQDknIy1OJHJZCqkm194tk2TSzULWekYy4ET+UOzRI5t4NvlBN27pBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw435mYdKA6uJSave8ohBDtO/4P2k2AiHEu9YA8J4X0YbuXQYEd
	UhS8TFIEU0H14pB4/p5BWbeoaZkmm0hLPEqn5KIMPZcvew1IYMHwt56/HKoklHimuYI=
X-Gm-Gg: ASbGncv2k1eu05DQhu8qFOuw+yd5FnfNjAmxhwGNXelmsxB8tVLKivuu/BKbx2IttJZ
	kVSVEj2vm6HClFfxUyoqCnAUn2pqTSw83B4ad+hrC5AY9I0L57ExJojmzQYJEMZZ5Yz5bQvxL7b
	eGJG22F3JWKugq9juFpJKAkvo3Zc/+t5OtWFiAtetmlqaTzRTCcRdxrtY2fA70b2qq2JRvKxeZH
	bKJsNPbCrEXVKannb5F6Xn/kGpmZ8xeklPwiBLOcVQJHvjYvIz6ntdISlvyTtrUdDjMEFxOuJPm
	gskTEbHTITKUzf4CL+cEfHXs0oQkutwQs9uWO2fSKhpWd0ABi0nShGx5gt/sha8YGutTaOeabUh
	Ya8wCRh0OPXDZADyrVr8VQBxXLTBoBUJDLCQ=
X-Google-Smtp-Source: AGHT+IHeCYnECMIvVJTGoFI3WdlJXM5+Krq/lzUsH6dPnZ6JduY2zNSHMUmatJU7FYEFS6JUREJreQ==
X-Received: by 2002:a05:6a20:3d8a:b0:21f:5324:340 with SMTP id adf61e73a8af0-2381366444amr37445192637.41.1753154130401;
        Mon, 21 Jul 2025 20:15:30 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feac065sm6027612a12.33.2025.07.21.20.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:15:30 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 21 Jul 2025 20:15:21 -0700
Subject: [PATCH v4 5/9] drivers/perf: riscv: Export PMU event info function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-pmu_event_info-v4-5-ac76758a4269@rivosinc.com>
References: <20250721-pmu_event_info-v4-0-ac76758a4269@rivosinc.com>
In-Reply-To: <20250721-pmu_event_info-v4-0-ac76758a4269@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

The event mapping function can be used in event info function to find out
the corresponding SBI PMU event encoding during the get_event_info function
as well. Refactor and export it so that it can be invoked from kvm and
internal driver.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c   | 124 ++++++++++++++++++++++-------------------
 include/linux/perf/riscv_pmu.h |   1 +
 2 files changed, 68 insertions(+), 57 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 433d122f1f41..0392900d828e 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -100,6 +100,7 @@ static unsigned int riscv_pmu_irq;
 /* Cache the available counters in a bitmask */
 static unsigned long cmask;
 
+static int pmu_event_find_cache(u64 config);
 struct sbi_pmu_event_data {
 	union {
 		union {
@@ -412,6 +413,71 @@ static bool pmu_sbi_ctr_is_fw(int cidx)
 	return (info->type == SBI_PMU_CTR_TYPE_FW) ? true : false;
 }
 
+int riscv_pmu_get_event_info(u32 type, u64 config, u64 *econfig)
+{
+	int ret = -ENOENT;
+
+	switch (type) {
+	case PERF_TYPE_HARDWARE:
+		if (config >= PERF_COUNT_HW_MAX)
+			return -EINVAL;
+		ret = pmu_hw_event_map[config].event_idx;
+		break;
+	case PERF_TYPE_HW_CACHE:
+		ret = pmu_event_find_cache(config);
+		break;
+	case PERF_TYPE_RAW:
+		/*
+		 * As per SBI v0.3 specification,
+		 *  -- the upper 16 bits must be unused for a hardware raw event.
+		 * As per SBI v2.0 specification,
+		 *  -- the upper 8 bits must be unused for a hardware raw event.
+		 * Bits 63:62 are used to distinguish between raw events
+		 * 00 - Hardware raw event
+		 * 10 - SBI firmware events
+		 * 11 - Risc-V platform specific firmware event
+		 */
+		switch (config >> 62) {
+		case 0:
+			if (sbi_v3_available) {
+			/* Return error any bits [56-63] is set  as it is not allowed by the spec */
+				if (!(config & ~RISCV_PMU_RAW_EVENT_V2_MASK)) {
+					if (econfig)
+						*econfig = config & RISCV_PMU_RAW_EVENT_V2_MASK;
+					ret = RISCV_PMU_RAW_EVENT_V2_IDX;
+				}
+			/* Return error any bits [48-63] is set  as it is not allowed by the spec */
+			} else if (!(config & ~RISCV_PMU_RAW_EVENT_MASK)) {
+				if (econfig)
+					*econfig = config & RISCV_PMU_RAW_EVENT_MASK;
+				ret = RISCV_PMU_RAW_EVENT_IDX;
+			}
+			break;
+		case 2:
+			ret = (config & 0xFFFF) | (SBI_PMU_EVENT_TYPE_FW << 16);
+			break;
+		case 3:
+			/*
+			 * For Risc-V platform specific firmware events
+			 * Event code - 0xFFFF
+			 * Event data - raw event encoding
+			 */
+			ret = SBI_PMU_EVENT_TYPE_FW << 16 | RISCV_PLAT_FW_EVENT;
+			if (econfig)
+				*econfig = config & RISCV_PMU_PLAT_FW_EVENT_MASK;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(riscv_pmu_get_event_info);
+
 /*
  * Returns the counter width of a programmable counter and number of hardware
  * counters. As we don't support heterogeneous CPUs yet, it is okay to just
@@ -577,7 +643,6 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 {
 	u32 type = event->attr.type;
 	u64 config = event->attr.config;
-	int ret = -ENOENT;
 
 	/*
 	 * Ensure we are finished checking standard hardware events for
@@ -585,62 +650,7 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 	 */
 	flush_work(&check_std_events_work);
 
-	switch (type) {
-	case PERF_TYPE_HARDWARE:
-		if (config >= PERF_COUNT_HW_MAX)
-			return -EINVAL;
-		ret = pmu_hw_event_map[event->attr.config].event_idx;
-		break;
-	case PERF_TYPE_HW_CACHE:
-		ret = pmu_event_find_cache(config);
-		break;
-	case PERF_TYPE_RAW:
-		/*
-		 * As per SBI v0.3 specification,
-		 *  -- the upper 16 bits must be unused for a hardware raw event.
-		 * As per SBI v2.0 specification,
-		 *  -- the upper 8 bits must be unused for a hardware raw event.
-		 * Bits 63:62 are used to distinguish between raw events
-		 * 00 - Hardware raw event
-		 * 10 - SBI firmware events
-		 * 11 - Risc-V platform specific firmware event
-		 */
-
-		switch (config >> 62) {
-		case 0:
-			if (sbi_v3_available) {
-			/* Return error any bits [56-63] is set  as it is not allowed by the spec */
-				if (!(config & ~RISCV_PMU_RAW_EVENT_V2_MASK)) {
-					*econfig = config & RISCV_PMU_RAW_EVENT_V2_MASK;
-					ret = RISCV_PMU_RAW_EVENT_V2_IDX;
-				}
-			/* Return error any bits [48-63] is set  as it is not allowed by the spec */
-			} else if (!(config & ~RISCV_PMU_RAW_EVENT_MASK)) {
-				*econfig = config & RISCV_PMU_RAW_EVENT_MASK;
-				ret = RISCV_PMU_RAW_EVENT_IDX;
-			}
-			break;
-		case 2:
-			ret = (config & 0xFFFF) | (SBI_PMU_EVENT_TYPE_FW << 16);
-			break;
-		case 3:
-			/*
-			 * For Risc-V platform specific firmware events
-			 * Event code - 0xFFFF
-			 * Event data - raw event encoding
-			 */
-			ret = SBI_PMU_EVENT_TYPE_FW << 16 | RISCV_PLAT_FW_EVENT;
-			*econfig = config & RISCV_PMU_PLAT_FW_EVENT_MASK;
-			break;
-		default:
-			break;
-		}
-		break;
-	default:
-		break;
-	}
-
-	return ret;
+	return riscv_pmu_get_event_info(type, config, econfig);
 }
 
 static void pmu_sbi_snapshot_free(struct riscv_pmu *pmu)
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 701974639ff2..f82a28040594 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -89,6 +89,7 @@ static inline void riscv_pmu_legacy_skip_init(void) {};
 struct riscv_pmu *riscv_pmu_alloc(void);
 #ifdef CONFIG_RISCV_PMU_SBI
 int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr);
+int riscv_pmu_get_event_info(u32 type, u64 config, u64 *econfig);
 #endif
 
 #endif /* CONFIG_RISCV_PMU */

-- 
2.43.0


