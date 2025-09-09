Return-Path: <linux-kernel+bounces-807311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DAFB4A2DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E7A171AC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0DE307494;
	Tue,  9 Sep 2025 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="TLkVAUIi"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917A30505E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401408; cv=none; b=aAmRxwPNO671bE8IYcgb4M8OgHnBCnWH06vCULmrHDmJjrY50fr2YWJ9tFdagsDx8A2Xacs8BglC3qP/2CQnHMIJD2MW4dmY/De725Ol1n55VcRCV5a+9hEVOIflwCGJBPgE3Cnkyw7DSZXjZOstbkZTrF3o/zL93btygfourvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401408; c=relaxed/simple;
	bh=GrmWjsHjJE1tKkgqTBfGMNOmAW/o67tHqaBrQuxr/k0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jobDTaJJHGmSgTKw5TIeTf9sstDAHUbjsy2cMHt7Cq/kpOQg5N7OpZ4rKQeavPeeNZIMZitW4FBmOHxqdbKVhKQnSftkG4XF/V+0pw3TtJSfKMaIe8Vx1prPBWz9VwsaF0MaXDEPZamJxBpun+kKRvuwd1Mkz+XWlwEzU+gnq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=TLkVAUIi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso4622580b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757401407; x=1758006207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnmZ8NkUlTZK5sUaPCJm86+BW+WwmmyvWnWnb0ftr9I=;
        b=TLkVAUIi1+x9BEXNzSdEt8kYgATGJ+86iH46LXHJ/DmRkTvpCoU145FLhEXGoYjKOA
         /ocUCzgyuKKSlXyeNtlvqj8MpaiTXmWSW7IQEyjd0pyGmXEWaX3edLyqBkIuVPy22Hev
         Iwa1JdQej0g3M6c2DUngCkvQfJQF5xMLKZW+/MHEqGzHALIHuFbK/NOYPskE0LueRsBR
         I18+zNcTGQtr4vMIEuFQQXWr76pTAiYLS9U9/yCdDhU8nFWA13DD9ga3i9EEWR8cf8JY
         yFwdiK51uoAEFeQXwpGrYc/sz9AHVA8JfX4Hot1M+6f+5MoNRtOIFYve70fdyclk8Wjj
         0b+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401407; x=1758006207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnmZ8NkUlTZK5sUaPCJm86+BW+WwmmyvWnWnb0ftr9I=;
        b=P67ztkmNc7+SEJPtS09fRpn4zavsypniwg9gShPFKl1HkB1/FS/ZHVrAjG7ExlpIKm
         I7MpkUxcSn7GrnixBUZ2HAhLod+WnH3eQgYFMy43O0VJUmFS8OliZtr5obC9BppY6f5p
         Kma7lDDnU8y8VsFOP9BVHOgIquGWRL3Jkx8cIPA4Kd/Gs2OPyDCtbzOmlMu1Tck3tkiR
         i596FmagN6Rn7kL3OurLkEIrmCuMWAst2ATGh9BMSj0VArKaIEwZ/fbQUSLgUCh1jphr
         MKJ90L7L1TFqFxc7yBVCEJUkV6pq694y1N1YHdGGAlb/4XHzgV6Ho3ihpPSOS2sxkK9z
         AdYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqIC3qWnAeEHAaVsCtH6ROxKoln4yAfe3EwBHKoHfQ/PBDDKNu3L4t+kgm/qU1hrllf2IZ53P6qgLtREE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxynzYOU9Enad8ncVlMC4m6vtYkUGo3iQnkOdzSeKnxkCY9Vw2+
	wimTxGPbgdkqegqRvMfTbrD16hI3z6tVUev/TND+e9jzT8U8KaK5ebBjfu17C7sgaXw=
X-Gm-Gg: ASbGnctkIDBuavPViY+/aT5z7sMAUEe6mE5Fg8JDZW2yxn4xL4Vr2LbvZhO27/K0tUQ
	cwVF5lP7Tj3yDEvs5/u9g3T2Zd28mMyZWAoTElxWiGqyonAnSZHCrvZ2IeR5t3fkTLVIsiVTKcb
	Ug0PFqCUgPn18RuTC7ZeCD04Onj9xOBqOQZ9CBPjJd+RKJC2K/mjN5TuAP3prscOK9fLFE9j2oR
	K4vT5EidUX2X+YtTR98g9pGf/MNIGKZZU/9sEPW1qwQ5taYoKmzq52y+6TN2tX7MsW3ufNhaKlv
	pIdBYmfuLCmrvSE1StcJgNJGcVHn8/ZMpNEMP+haCu03jjNFUBoGEZrirmQqxN9PvyEfCniHaOY
	j5PY1n++2ROf/IRWS1tUVvvy6TylVymNgLQM=
X-Google-Smtp-Source: AGHT+IFiF52xK3MSeJlrfdLEf2QXk0FrME34XTCcy1LZr3L0VGDJ3dsrdXofGTbO3mimC4eb9yJmOw==
X-Received: by 2002:a05:6a00:1793:b0:76e:99fc:db8d with SMTP id d2e1a72fcca58-7742dd1252emr12562314b3a.3.1757401406596;
        Tue, 09 Sep 2025 00:03:26 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7158sm1025535b3a.72.2025.09.09.00.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:03:26 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 09 Sep 2025 00:03:21 -0700
Subject: [PATCH v6 2/8] drivers/perf: riscv: Add raw event v2 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-pmu_event_info-v6-2-d8f80cacb884@rivosinc.com>
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

SBI v3.0 introduced a new raw event type that allows wider
mhpmeventX width to be programmed via CFG_MATCH.

Use the raw event v2 if SBI v3.0 is available.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h |  4 ++++
 drivers/perf/riscv_pmu_sbi.c | 16 +++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

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
index cfd6946fca42..3644bed4c8ab 100644
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
@@ -537,8 +539,12 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 
 		switch (config >> 62) {
 		case 0:
-			/* Return error any bits [48-63] is set  as it is not allowed by the spec */
-			if (!(config & ~RISCV_PMU_RAW_EVENT_MASK)) {
+			if (sbi_v3_available) {
+				if (!(config & ~RISCV_PMU_RAW_EVENT_V2_MASK)) {
+					*econfig = config & RISCV_PMU_RAW_EVENT_V2_MASK;
+					ret = RISCV_PMU_RAW_EVENT_V2_IDX;
+				}
+			} else if (!(config & ~RISCV_PMU_RAW_EVENT_MASK)) {
 				*econfig = config & RISCV_PMU_RAW_EVENT_MASK;
 				ret = RISCV_PMU_RAW_EVENT_IDX;
 			}

-- 
2.43.0


