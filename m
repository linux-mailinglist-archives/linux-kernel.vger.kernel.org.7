Return-Path: <linux-kernel+bounces-740113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16826B0D021
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C8F1AA1FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CEB28D840;
	Tue, 22 Jul 2025 03:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ghFdOTZG"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043F128C5BC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154131; cv=none; b=gCJ61umv954uVdpV6ZMINXJ0PfzuUS5Ou4pcgHxst5lzTkf4kMmHgxB2Sx/iR1UcH4iqN4UIihGdmBEFeksjOFTw68cnqaDxqHOkmJJIxsEAWsXGJ92lpC76SjU3XdfqGG4VRXQzSSrYYOxZ3NcQh0NmHX8kI6Vxwm+bhs1u2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154131; c=relaxed/simple;
	bh=IzHWWZDhpoWbiCLmY/J2cSfKIfgXeRaJyx31cs9ScgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c2YyISDkrnJZTXjCYd1hC5d/5CuL+rGvP6L/Oc7wr/AP4OPl7vr3uINQ4sPw3vFe4k8bfY6UAbChQwoF6lBkXB6rt5eonQXWdnTLOfTMsCqMxvm9Yt5qXIldzAx3w/8bHgdozU1MA3GAW5DkA58uyLCAadZZln/3V9UP1EngaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ghFdOTZG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74af4af04fdso4186923b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753154129; x=1753758929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOiuLvmg0zyyTxkdzmKKTYBl9SQzDB7q/BZgYmb7rvg=;
        b=ghFdOTZG6l/oi22GK/plQJ29dmS6rMRWBRf/mALNHGkP5eb5gXvd2q0BTDRbKoT6Rv
         UGqp7eWpOITgLIKzaGDodrDyFxf34HNQG2UUfPTFyZ/p/Rb87Lmf0mQmJnqFGXJyEdER
         E72/EbhNHP+KqReQoFSvKwbCGSkfwpp2cBMrXfiMUVmLBWyfaYYAxKAEz5U8m0kj5T1z
         KCs6/CAZ3Sg7jbozjxoZhlMSOwuvxgwXc6WKdDa3PWGFJ2hX+aFfmBIvuJ8ECY+Jp2eJ
         5wOG6cwQUSrfY9qfLhbLDR0JLT2bIFL+nVVLEXIurmMdRWGixT63lMZ4Ew+4rQxgZIh5
         SR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753154129; x=1753758929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOiuLvmg0zyyTxkdzmKKTYBl9SQzDB7q/BZgYmb7rvg=;
        b=kllOzkyNfr6/0BayJPl/0peBvYvH5hfyJdiSmPGrqXpbeIaIAa8tTujiOFjmeOoA2y
         0zFpvBnYE36aAXr0xo4FYohZebLY0SJofWQoZgOQbDDi/mfR6q2EGg47eTFNg5bGOO4I
         e4xpLgm/VHX81Tb7/gUNwtNUDsZwHejrP908DLkprNotlP9lZct4WWgMhS1GmJewqKRD
         Pff0bXimBCybmAXBmiWUXpClANsxTSbczgR+jaRAKLyvD+eBG8BGH/TjrsbsR/tFXSfV
         fwTc6BGC/1xkZt1E9//kKhdBmD2g1uwsb0hAmoin7Rk4c9DSmEQeM+0Zkf/puuTnLsRp
         YNfw==
X-Forwarded-Encrypted: i=1; AJvYcCVVKphxi85TzbNpCRinHcPEEkBui3eSA+8iAhzKxjeWdktHYDxLJn0bsIYHNqpXtnxrYvH/KF3rDTuHvS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtvO0Wq4vhY3JdGNzst3/bAxVlfL+1AgTWlck7i7h5FCoQUg6L
	JLY24BNHtUG9EuF19YdmvHKa901K57N5lii2nhU7dkxnMoi56uO3ylXv/TI58Hx4RtU=
X-Gm-Gg: ASbGncvwPaVRijGtKsVtyRuZUeH6/hYc53Y8kkjsm1v+HR4Oc5cdwJR4byB+uc5GjMw
	TGzpr4yc82B6vhrkgOGhOqBduyDjYzsYE5w4qixHaqlXxLcY9PnrcCGSHh53DUgR+I6uPuOxqFx
	djb+GtrII4jE+k61TI7cAhxrsVEiq0a5OsDCuzIElXGZ3s1h8btmRSwodVTOTYkOE7cf5mGBve4
	GTakWpwil3AYk824bBb07AyXJjDHOLG1b/AuFihbyCWyBl33iOf7+nGWIq53FzKuz4+8ipz7V4d
	GbeJoX1tT4nvJRvyYPW5D181l/Md0H+Geno+N6qgwAi09aWQSYz1MdLId/fBAi6yIH8si4n9Z+O
	ihzBF40QEu0mWL4V6jMMxa9zjHUU6xGHr4Ic=
X-Google-Smtp-Source: AGHT+IE4m/tGD4iWa8+mTThA0s1cqsabkUVocojZBeVv2a32z+xQKzcohOpb05G+cpoLAKrGJbuRZA==
X-Received: by 2002:a05:6a21:99a1:b0:233:aec3:ce69 with SMTP id adf61e73a8af0-23d37ccbf52mr3181460637.3.1753154129335;
        Mon, 21 Jul 2025 20:15:29 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feac065sm6027612a12.33.2025.07.21.20.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:15:29 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 21 Jul 2025 20:15:20 -0700
Subject: [PATCH v4 4/9] drivers/perf: riscv: Implement PMU event info
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-pmu_event_info-v4-4-ac76758a4269@rivosinc.com>
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

With the new SBI PMU event info function, we can query the availability
of the all standard SBI PMU events at boot time with a single ecall.
This improves the bootime by avoiding making an SBI call for each
standard PMU event. Since this function is defined only in SBI v3.0,
invoke this only if the underlying SBI implementation is v3.0 or higher.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h |  9 ++++++
 drivers/perf/riscv_pmu_sbi.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index b0c41ef56968..5ca7cebc13cc 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -136,6 +136,7 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_FW_READ,
 	SBI_EXT_PMU_COUNTER_FW_READ_HI,
 	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
+	SBI_EXT_PMU_EVENT_GET_INFO,
 };
 
 union sbi_pmu_ctr_info {
@@ -159,6 +160,14 @@ struct riscv_pmu_snapshot_data {
 	u64 reserved[447];
 };
 
+struct riscv_pmu_event_info {
+	u32 event_idx;
+	u32 output;
+	u64 event_data;
+};
+
+#define RISCV_PMU_EVENT_INFO_OUTPUT_MASK 0x01
+
 #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
 #define RISCV_PMU_PLAT_FW_EVENT_MASK GENMASK_ULL(61, 0)
 /* SBI v3.0 allows extended hpmeventX width value */
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 7331808b1192..433d122f1f41 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -299,6 +299,66 @@ static struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
 	},
 };
 
+static int pmu_sbi_check_event_info(void)
+{
+	int num_events = ARRAY_SIZE(pmu_hw_event_map) + PERF_COUNT_HW_CACHE_MAX *
+			 PERF_COUNT_HW_CACHE_OP_MAX * PERF_COUNT_HW_CACHE_RESULT_MAX;
+	struct riscv_pmu_event_info *event_info_shmem;
+	phys_addr_t base_addr;
+	int i, j, k, result = 0, count = 0;
+	struct sbiret ret;
+
+	event_info_shmem = kcalloc(num_events, sizeof(*event_info_shmem), GFP_KERNEL);
+	if (!event_info_shmem)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
+		event_info_shmem[count++].event_idx = pmu_hw_event_map[i].event_idx;
+
+	for (i = 0; i < ARRAY_SIZE(pmu_cache_event_map); i++) {
+		for (j = 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++) {
+			for (k = 0; k < ARRAY_SIZE(pmu_cache_event_map[i][j]); k++)
+				event_info_shmem[count++].event_idx =
+							pmu_cache_event_map[i][j][k].event_idx;
+		}
+	}
+
+	base_addr = __pa(event_info_shmem);
+	if (IS_ENABLED(CONFIG_32BIT))
+		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_EVENT_GET_INFO, lower_32_bits(base_addr),
+				upper_32_bits(base_addr), count, 0, 0, 0);
+	else
+		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_EVENT_GET_INFO, base_addr, 0,
+				count, 0, 0, 0);
+	if (ret.error) {
+		result = -EOPNOTSUPP;
+		goto free_mem;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++) {
+		if (!(event_info_shmem[i].output & RISCV_PMU_EVENT_INFO_OUTPUT_MASK))
+			pmu_hw_event_map[i].event_idx = -ENOENT;
+	}
+
+	count = ARRAY_SIZE(pmu_hw_event_map);
+
+	for (i = 0; i < ARRAY_SIZE(pmu_cache_event_map); i++) {
+		for (j = 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++) {
+			for (k = 0; k < ARRAY_SIZE(pmu_cache_event_map[i][j]); k++) {
+				if (!(event_info_shmem[count].output &
+				      RISCV_PMU_EVENT_INFO_OUTPUT_MASK))
+					pmu_cache_event_map[i][j][k].event_idx = -ENOENT;
+				count++;
+			}
+		}
+	}
+
+free_mem:
+	kfree(event_info_shmem);
+
+	return result;
+}
+
 static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
 {
 	struct sbiret ret;
@@ -316,6 +376,15 @@ static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
 
 static void pmu_sbi_check_std_events(struct work_struct *work)
 {
+	int ret;
+
+	if (sbi_v3_available) {
+		ret = pmu_sbi_check_event_info();
+		if (ret)
+			pr_err("pmu_sbi_check_event_info failed with error %d\n", ret);
+		return;
+	}
+
 	for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
 		pmu_sbi_check_event(&pmu_hw_event_map[i]);
 

-- 
2.43.0


