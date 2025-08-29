Return-Path: <linux-kernel+bounces-791932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A872B3BE1A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4541C26ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A789321446;
	Fri, 29 Aug 2025 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="LlHbSHF0"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D135314A91
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478472; cv=none; b=Dr+UT6gpTPyqllL+2wS6H+PaENZZKdHeyRF4m81grmkcFVziuzCIrPUC88TppBGAzIgSraewPbHF8sEGjE7RSdoQEWN3GYB5ZO6cIn0RbjSCoOPdCw4gts5LO4LOJQqfwzS8czq5tdCqpP5agSXziX3nYHsF76UAYQcnQkeEpVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478472; c=relaxed/simple;
	bh=5a42n+9lUYW8j8nzv38kypGGaOUyfv0cna4E1TQCaGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hOaBBY6BDAbNOkqx4cXSIvIMa2VFgVgpjXX3BFcoeD3R6FFDVEzNTWHODR+Vh4EPVpmdWTpHNq6bq9VzmblZp34EC8KssKefm3UQz/4OAGXGQ1EtSfko7Kn/3HVp0yE/ie4AYKXjQzNXa92ZJ+00fQIHKAdN8Jv6Yh2ns7oIzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=LlHbSHF0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-772301f8a4cso712842b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756478470; x=1757083270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tI741R36HWDh2RhVHZyQphWWAJjaxVoQsq24GTtFdYc=;
        b=LlHbSHF0cBJquMcepqNY3+jppsv6CidYIcqxQz0r9YMPkBJ3wdim7gEVjfmGmOceVN
         JaFetMALYtbQ+3pzwd4M4D4cwI71yzShhUlRS5SooWrY0XM+Nxx8FtEwB0zmyiHYnl4u
         n60j+wVWRE/wPV30Dt7EG2kwbGU8gkE2A3ab1o1A/ZOx0+xst3N3obU02G0k4HCrYk+Y
         q4dhUhUFnXgwZdTk0WGHaJ7zL1ev6hwbDRvINEIKgghSH6V6eY52TyVks++B/qixAoh4
         1HR8N/ac7BYD3jgaAgdWfpCg84iq9GkO0ZjQCHYElWb/KHhSczud9qIY+lDhcUcu/qgP
         miAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756478470; x=1757083270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI741R36HWDh2RhVHZyQphWWAJjaxVoQsq24GTtFdYc=;
        b=NyOg6TC/ZG4klujoeYsxMb5eXimprMilftQg6iGSK+mr5EH1V8JhVOXLsG+LFnefaX
         TpR/JwZXcAim+Qe9254udhfioJhGEqrf7hfpABgKTFrm9/RI26U9IXEmAS7JkBZawpu2
         7McGfX22hzkc+u3bBOYIDt077jMZzVhKK+MAk3ZAuq3Ds0k2SnL4g/k39dbnj7pVJdYD
         Ivx9c9k6Rdb0cuTBJBszvbb9rFhxmYkNBk1EQlJrq1KnRUQ4PFijUCSyLfjVwe/wpVfx
         2Hdjg32QET7eXAL4HM8Poai1vf+bTAN7fufSqCD1nXzk3e0uTxVJQagGaEzh/3BX48Bt
         TH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1tSfKMi6oQpQG6l/QajDQLQAtkLf1/cqirsgR1SIFUJGgdPpWN9YCXqTBz9rvX1zNgIQvGSEtThPdovk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6nSyKGivkPl5+fHfN/ETQgU8c+qD14UUbftRkR38HogPedYXP
	T355TX9ypijl0ZWUMx8rSSCFbJgYEM94PUel3jkLnmQlWrpuvfTHUV3SKRevx5WWM9I=
X-Gm-Gg: ASbGncspsRcWl1zkgcdmVa6y30Zu09+q36MxYyu8JjIOkZgBLhjlwCC05LhY9saMkDJ
	+/zXUZIB17FHzwwOaRI+5mVUoMdgK+pseXXaXOd7u0IyQWU73cVGVNeDE6AKGYYuP7lHYEpJ2Cz
	PvidrxRLoN+jNJ9GtJ6b7Pxajl6FtnuZsdjELE7bXJEzfio+QBErSTkqi0gcwpZYEONTJgczcGh
	4h0bw5PI+8yFHUYi7RporM9Bc5dIGVVz11IFdKvx4SvQPZe5k9nvYrYAv/vFkZuI2+/YmVG8gZf
	MLSFdmDq3mtp7EHpESqzXlxnk4kCErS0P78MdNPWXisFGvt5ozXwqPxr4QS/4FeHPSVlbv8yk/n
	BGuNScdb6ad65b/f4raakm/2o5r3D405m/3th7B6Iib58ig==
X-Google-Smtp-Source: AGHT+IFF8VEo1uPvNaAIFv8C/+fiPXouMqAeY9Jx+FQMbKLtAKcRvd4Ch7pGF/LiqKMh1EOfkolHEw==
X-Received: by 2002:a05:6a00:148e:b0:771:f4d4:24fa with SMTP id d2e1a72fcca58-771f4d4290bmr21272864b3a.18.1756478470351;
        Fri, 29 Aug 2025 07:41:10 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1f86sm2560999b3a.72.2025.08.29.07.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 07:41:10 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 29 Aug 2025 07:41:03 -0700
Subject: [PATCH v5 2/9] drivers/perf: riscv: Add raw event v2 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-pmu_event_info-v5-2-9dca26139a33@rivosinc.com>
References: <20250829-pmu_event_info-v5-0-9dca26139a33@rivosinc.com>
In-Reply-To: <20250829-pmu_event_info-v5-0-9dca26139a33@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-50721

SBI v3.0 introduced a new raw event type that allows wider
mhpmeventX width to be programmed via CFG_MATCH.

Use the raw event v2 if SBI v3.0 is available.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h |  4 ++++
 drivers/perf/riscv_pmu_sbi.c | 18 +++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 341e74238aa0..b0c41ef56968 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -161,7 +161,10 @@ struct riscv_pmu_snapshot_data {
 
 #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
 #define RISCV_PMU_PLAT_FW_EVENT_MASK GENMASK_ULL(61, 0)
+/* SBI v3.0 allows extended hpmeventX width value */
+#define RISCV_PMU_RAW_EVENT_V2_MASK GENMASK_ULL(55, 0)
 #define RISCV_PMU_RAW_EVENT_IDX 0x20000
+#define RISCV_PMU_RAW_EVENT_V2_IDX 0x30000
 #define RISCV_PLAT_FW_EVENT	0xFFFF
 
 /** General pmu event codes specified in SBI PMU extension */
@@ -219,6 +222,7 @@ enum sbi_pmu_event_type {
 	SBI_PMU_EVENT_TYPE_HW = 0x0,
 	SBI_PMU_EVENT_TYPE_CACHE = 0x1,
 	SBI_PMU_EVENT_TYPE_RAW = 0x2,
+	SBI_PMU_EVENT_TYPE_RAW_V2 = 0x3,
 	SBI_PMU_EVENT_TYPE_FW = 0xf,
 };
 
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index cfd6946fca42..7e984ab717c6 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -59,7 +59,7 @@ asm volatile(ALTERNATIVE(						\
 #define PERF_EVENT_FLAG_USER_ACCESS	BIT(SYSCTL_USER_ACCESS)
 #define PERF_EVENT_FLAG_LEGACY		BIT(SYSCTL_LEGACY)
 
-PMU_FORMAT_ATTR(event, "config:0-47");
+PMU_FORMAT_ATTR(event, "config:0-55");
 PMU_FORMAT_ATTR(firmware, "config:62-63");
 
 static bool sbi_v2_available;
@@ -527,8 +527,10 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 		break;
 	case PERF_TYPE_RAW:
 		/*
-		 * As per SBI specification, the upper 16 bits must be unused
-		 * for a hardware raw event.
+		 * As per SBI v0.3 specification,
+		 *  -- the upper 16 bits must be unused for a hardware raw event.
+		 * As per SBI v2.0 specification,
+		 *  -- the upper 8 bits must be unused for a hardware raw event.
 		 * Bits 63:62 are used to distinguish between raw events
 		 * 00 - Hardware raw event
 		 * 10 - SBI firmware events
@@ -537,8 +539,14 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 
 		switch (config >> 62) {
 		case 0:
-			/* Return error any bits [48-63] is set  as it is not allowed by the spec */
-			if (!(config & ~RISCV_PMU_RAW_EVENT_MASK)) {
+			if (sbi_v3_available) {
+			/* Return error if any bits [56-63] is set  as it is not allowed by the spec */
+				if (!(config & ~RISCV_PMU_RAW_EVENT_V2_MASK)) {
+					*econfig = config & RISCV_PMU_RAW_EVENT_V2_MASK;
+					ret = RISCV_PMU_RAW_EVENT_V2_IDX;
+				}
+			/* Return error if any bits [48-63] is set  as it is not allowed by the spec */
+			} else if (!(config & ~RISCV_PMU_RAW_EVENT_MASK)) {
 				*econfig = config & RISCV_PMU_RAW_EVENT_MASK;
 				ret = RISCV_PMU_RAW_EVENT_IDX;
 			}

-- 
2.43.0


