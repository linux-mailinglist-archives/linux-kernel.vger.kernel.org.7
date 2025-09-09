Return-Path: <linux-kernel+bounces-807314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A39FFB4A2E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782364E4A65
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA4F3090C2;
	Tue,  9 Sep 2025 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="chRy63U4"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E70306B3A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401412; cv=none; b=aKXjZq+U9AMNxRjj3RJgVmbx/HQNwiMYcXLxQaIXL+V2devsZCkkKwLxO+yJT9jiyuNtdgcSfQd15EjN2kQiH8eGxLNPKGpHuyd7PaU06j3a91iKaXGKZoR6roxSL1y5z+S31pRml2zeMVrFzYgdzkX7Vse5mvj4HIhysjv9ARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401412; c=relaxed/simple;
	bh=svw1+F/QSAWZ266yLbotWzuw0G4qZyFOk7WzXnoCDRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=inmA4OJkv3egKblYi3ZH2vOFsw0jarxUUm4S8MSaLcwcydLvgmlGINbGUehdSbSDZCiFKRvqnt43289HqlAzvDBSYLzm10OxADWCUVoPd+tse46WSNVxVQbhwzO2vpHAChdBvX4xfWt0cPUkGzT1mBYCcfUire8YoYoDfuxBpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=chRy63U4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326e8005bso4794999a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757401409; x=1758006209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhZMcUxsy6JYqWOC3or2cXZEhT1Fgv3FiewmctcehUQ=;
        b=chRy63U4hT4O294JzbmTsp3/ha9/3hHro++0aX5QsvD4NT5OVa7IFzLTlcgi0x+f+3
         XajxYiIcAYZwQ+G/DTjQgNdPPdGLQ4BjKQ9C1xaz7wrC/mlb7K0wFk8j0bSL++9k+Wqf
         Ki28nVoBqHHSGFbEFShu9OKv/uf8DbXR6vpe8l7C7kyiP7cT216Cpc44hzSgioeGXuhs
         +A9N0XgM+5U6qhGyd8V+4wJvPbtCYBSy4jWQYz6dX4DdLJ1nWUfhtIBDOTC+MPYrqpQm
         iZjpp107V0oLCnHcNO4HVxjRHKvLKHr3welLjaouy/bYpCV/UnwFCrBRa/B0fXImr7j7
         X/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401409; x=1758006209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhZMcUxsy6JYqWOC3or2cXZEhT1Fgv3FiewmctcehUQ=;
        b=qo8WDhCMGiNFle2sLam30qVCOZkI1GsVD0y80EOIXRdKF3SaNvsWQdZSOMoM0H/60c
         2hmEPjELa+ddUwAKx33bLW2QuTHqTZzHG4KJ5l00beqYRxx29iLm08WctGf+n+6GQ9BC
         RXgsiXDXxZ1cv/j/LaHATqOtMQYerEf055NsErdcopwydgEnddDUNWeZsWGbc+f63QyY
         cVcAr/SoQsYeaQ+aLppYafM5E1e/KvZTfkKZhRefigVEmqG6zYig/ETB/QGPDhOmhS4e
         epiFPJHVeqWykE+nicYhaoCpP0mDeJ+hVOPWO64aA8d90nl6Vqp8fCxMr3rYMwGBeheN
         /CeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYiAdZmcHk4sNjlNc2fx8MyOoS/EhNyx+BcLfvJK8hN2GgqhUyJV4vIft1vOmLGr6VNAGKqp0Duv/Nhzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzddjAlbp2DDs6f56AwbDUDgC/Vx4gzlY3JBm/xEVL+lG+kyW
	O5KKmiwnZEMlcb21Zs2UJv7RBz1d4Vp90cUEO72UtQPsKYEOH5xJR1m+vuTTBp8XROk=
X-Gm-Gg: ASbGnct7Bvypr4c12cQKd7Wvw9GgZWSbfN/9yWXO/vejejNgxQE+HXs+jdwdJ/u5KB4
	WQPGn/XtCyTyyvCRLoFO34GF9tyGYjzHZmnF1xyohj9+0I9xUUFj8QF1bqbBRc0PDYdRW4CvXi6
	sUQnwFB+Cu5HD8A85DGZzXkibSbxxGneNZsybWRG0vqLFEN6nrZQ69/3b8MGw/tsNRc+DorTnVu
	vEoa6u7SRgpGTMoFRcictue0mTOmmm1vx4sMdgCWb8x8WSZ0gGEaioQ4TMcTLEKOkFXF+G8Yc+Z
	uhoZHL1A2p1NFQN3CjlmJXEB0q+/bqIbAx4k/TXnu+LA/xW42EUCS2kIv1DvGxo6CvDlNXRT2il
	1Y57qEYSWHD9p4I7EnPrtsil4mT/DVkybnGYoNSpVtQEvAg==
X-Google-Smtp-Source: AGHT+IFakW9GI3X7KiwSZ6TB6r+qigeRh7zHPYJe3gZqGJm1TvXIR0iLLkZpUst0NZABNZYOk/hzVA==
X-Received: by 2002:a17:90b:3f4c:b0:32b:6132:5f8c with SMTP id 98e67ed59e1d1-32d43f772c9mr13153440a91.18.1757401409453;
        Tue, 09 Sep 2025 00:03:29 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7158sm1025535b3a.72.2025.09.09.00.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:03:29 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 09 Sep 2025 00:03:24 -0700
Subject: [PATCH v6 5/8] drivers/perf: riscv: Export PMU event info function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-pmu_event_info-v6-5-d8f80cacb884@rivosinc.com>
References: <20250909-pmu_event_info-v6-0-d8f80cacb884@rivosinc.com>
In-Reply-To: <20250909-pmu_event_info-v6-0-d8f80cacb884@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-50721

The event mapping function can be used in event info function to find out
the corresponding SBI PMU event encoding during the get_event_info function
as well. Refactor and export it so that it can be invoked from kvm and
internal driver.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 drivers/perf/riscv_pmu_sbi.c   | 122 ++++++++++++++++++++++-------------------
 include/linux/perf/riscv_pmu.h |   1 +
 2 files changed, 68 insertions(+), 55 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index a6c479f853e1..0392900d828e 100644
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
@@ -585,60 +650,7 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
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
-				if (!(config & ~RISCV_PMU_RAW_EVENT_V2_MASK)) {
-					*econfig = config & RISCV_PMU_RAW_EVENT_V2_MASK;
-					ret = RISCV_PMU_RAW_EVENT_V2_IDX;
-				}
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


