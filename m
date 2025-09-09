Return-Path: <linux-kernel+bounces-807313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B335EB4A2E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A675C1BC6A86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EF3308F13;
	Tue,  9 Sep 2025 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="BJC5rkY9"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641A6307493
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401411; cv=none; b=teK7lus2/927GgR6EUTPH0U8hMPGTOfjXcMKPWBlOmAyl5/fnZQLHnj0mi8R2zyO5cZrgeKlwOurzdih8nKsDGA07hrZJ5YX2mOgjnCzHfxogCtY8TZi76Uu2ovYtOu4U8I6nDLEDOLioII8daEOxy3Uw6RHsaDswgn1L4I1u2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401411; c=relaxed/simple;
	bh=ENW7GuaIXflZlkamnfI2inEfAQKZtiw6G9K4fh9vW/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ee5SNleCzAVF+/C//349UzyX4OatBNfusAgxvJX1Sph2ZlbWtXDVBrQiGXBH72v3b0ArIh4zlrigdf4bxNH5VxdWO4Dss9CzTOrrb6fGzg63O7m+RFOLr/7Kthr3wafRSQ0f+t3MKHe+Or4YGGWRdJcuW6pSMuWEDaX54iThqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=BJC5rkY9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso4233079b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757401408; x=1758006208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dRa5PaUBeFzVfA0hx3uwaou6s1gEdQIGt2dK1PIyuI=;
        b=BJC5rkY9Tgq1YBzNmEeUmhHrVqTjUidBSSZkJRZDMdNe5FoLV3EdKfm/z+l9F/9VSP
         QlGCHl0kQW5gn6h6lOHCFRIQdH1TURM5XL1QL1XMKUMPL/9i9O/VlzVru4L+yWvH3gXd
         3ssw35ms2R8G4Lwrm11f7wZw3fXWJ4BAQib0x2eFa4A2hTEgXfsh9fGm75pF0DVtOH4D
         u+gsn53Z7iVnV5XivnjCwdiyNKSHRCdhiEKaowHeEuhqSwnHxGkxdOYTzN61PR0aaVuy
         cunZS8OYc3uAvfqnIMOYOvd5UUBvzVdI7En8dExBkMRftvSbuRZ7XQhIpQvpXQQHLWxw
         apUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401408; x=1758006208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dRa5PaUBeFzVfA0hx3uwaou6s1gEdQIGt2dK1PIyuI=;
        b=O0b5Oq0tlJYM8DFHQvm00Hym6m7SMmNTHEZwHKXdh3QH582/T6OM8BT5bXWhQP4BYA
         sTLC4vv9UFRVscImQV/uU+bC/Htc/bICqdMPlqM39iTDTVUAylIj446cAmCzLfbxrqkV
         KU5Pc8Srb05tcCkicMvwYJBTOogQNy6kgorlwT5yAu1daL8EeJmWU2AfoxkcKW8c3xrx
         vMA9TpguFGoqDNHLg20GEKgWxPqDxPCd5iOCu/TZPFof1y/VDw7rNr5RKJfO3STnVb66
         x2yt8w5wXJdvblo1KYf6rR9U3nRVpNM+2xiklobYnqbou89I3AzastmoBfcAEqeYdM8p
         74YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdijsnzKTZk5B0LYPsI7B+ep4Nq3Uis4f+lOOtCRu8oibweXd3qDd6Ij7JEeG6BsrnBXXCN2YR+bAV0ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGXmB2nRCS0GSRlinNndubMI+hcG5JGEdN5K4n5pgXJoVjnfLb
	76tzO3XSovNkzaOElAo/efOzqEuLR+CvDVgcyTq35W1V/M1s8egI2xNtiyEacxuI0lg=
X-Gm-Gg: ASbGncvUfRQ+Bij7QFxxgc2fmAxfnb5A1QQx2QCYL2Sd8I53czOlpJbwRdQsePVys8f
	xi8GH2yH2RgRJpbeONXI5mnVmO+uMCMRT0FfsP6IEtAyH2lcTwFBZG+g1bzxWdlSZg1kopvXFcD
	Iq9iCA/PhqnBckDGELWkTkpDeWzVa+8FY5S7BV8K4/6QRh8OzwURNwnNcnu9RayO30xaX/B7uC6
	Z7fGcQWjlkXPnuJrUoVNVxqr1Fiudywrdi2au4ArAPw7shpYnCRpYmPMPT914vshhiTmN8KgJ2k
	YTvU6TdRuN6YrQxAnnNrKaD5mjSeHyMZOsnl0fKDPrs8r4REeza/iAFKDa05rd7nX5VactbgIXV
	B7s3kWEAuhhofq9Ml+uysGh3eUKW+KV12s7A=
X-Google-Smtp-Source: AGHT+IHQ7m+RNx+VZbx6+x5n6qPiRRjPXoeUDxkNH4USJJaxaAIcWa8rdFoCF9FteEtF09OaqEBqIw==
X-Received: by 2002:a05:6a00:23d3:b0:772:7ddd:3fe0 with SMTP id d2e1a72fcca58-7742dca7ec3mr13266216b3a.2.1757401408326;
        Tue, 09 Sep 2025 00:03:28 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7158sm1025535b3a.72.2025.09.09.00.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:03:28 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 09 Sep 2025 00:03:23 -0700
Subject: [PATCH v6 4/8] drivers/perf: riscv: Implement PMU event info
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-pmu_event_info-v6-4-d8f80cacb884@rivosinc.com>
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
index 3644bed4c8ab..a6c479f853e1 100644
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


