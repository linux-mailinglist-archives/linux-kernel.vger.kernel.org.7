Return-Path: <linux-kernel+bounces-791934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2844EB3BE22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56D3687E85
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4F2322A2D;
	Fri, 29 Aug 2025 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="NfZAxqw5"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD9321F22
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478475; cv=none; b=XXLRbGn0Fa8L9UL2Cyie4LJisq3zTgO/fvINLmxAc9D8RS8vq0GczaLCnNSoGegA18GSqytCAiEU5GM41+fXqLiGI1KQkAEFi7WZ3mbgR3KIdhPhh/8UigZVsooQsB465X6GoWrq8VnjW9bG7sdzlBZcO1FivLj/s1Vg2ZDNegQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478475; c=relaxed/simple;
	bh=MdulXEOUM7UKpN/Xgy+wJxXxlFoIIiYmV/qS25UDGvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+RtGGU7nGyObuSetMszborfEI34eMfpq4vXfI8ZWdMir0PbXz1K4xysW50exJ9LVK9Q3jDtGNMhWZWhKhNSeAmWK9XNAJ7/JoQV5wbtBKaa4NRb3hnfWRb573w3l9Pir6pdNtDhXad+m3iQTg4+uQPNGtA23wQtys8Dtf6RTkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=NfZAxqw5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-772301f8ae2so551138b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756478472; x=1757083272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxbAHn2gu8hPzgAv8AKJJWeRS0gDiHkMgaOyBvCoSlM=;
        b=NfZAxqw5Ckn9nmjBeNoVPmXgPi2paoprNMbdkJ+vJD36DuPyk3fx4+4KhzmKP538M7
         tj0BHcdROamfUqXf8XC4u1eznOo+v+h5YLqr2ZmqZKSnQbdGDPJTfb9LSXF4oM9G1b54
         tyUvu335hr+ywuelWTPZPjpWJ6aolOHOe4pvCVs4ZlYj/y4Uy5+ELGHG/cTjRRsNUiiC
         dsBdxN6wem8pthYfgRMC6RjHalcL9KjEy8U9QHDel/EsmrfketyqWLWMVYU2l92IRVil
         laaAZ8ufrX3CgKSMvffNvu9oMamDKql4sqSXKD402lJPVjhHg6pznhkJpH2rV4dDW9zc
         +3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756478472; x=1757083272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxbAHn2gu8hPzgAv8AKJJWeRS0gDiHkMgaOyBvCoSlM=;
        b=j8VAGt7F9Gn4vm9YZU9IcrB85Ya3pQh9IyxGSx0GQY+e72iu8T/5c1WtcG36JnHen7
         LL7ALTO39hXHS9XRkr8D8Y67+0g2d5EfO6xQxcJLR13m5vcV/e4+nLgOScXFPkbrr3Aj
         72/4tCsNyO6GWCki0ueTofZhA+aOsvJawCXgxthfrZceW2UEJ0damuuxy0GmPRrk7pGX
         4/Vp+R9+3O1yvZyGQjvbJGEtfNwTLDskcZ4Q8O9kLcubrQUVUt537JvsgRhoeMlJcMJ6
         wSO//obvR4IhXnH6vMw0myIiO4ZOlCfVruJ22vhFs5ntVvg7Gk6FqYg0STKygEk3hxvn
         +1qw==
X-Forwarded-Encrypted: i=1; AJvYcCUwgxpLdvikNjy2FdDdrSj9cjM30gaElKD6a3ZBJsizqEelqBu21bZOr5/GkaFH2bWzUnaepsS3TtuvbaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+GR9USv4D+/LemY7O0xWho5OcgXJybOhZeDus0G7TW0NIh8At
	bFaE4YMkwz1hsso0NCZqiew7XdyyTeAWaMm1H6R6UrR9wNoEIKgcD6JN1XV/82PPHPI=
X-Gm-Gg: ASbGncvoh35KJR6Q6BnFtFsURZ6Tqqj7Il2aU1CqC8OHaypNfBGEmzDq8/lUt15GPaj
	ja+UbKYfTxqnaPfqJeILfUdvgSjS6fzzWKEhjKnguxON46Cdzs4nGeWdjV9KT2YfraZvjGAr0H+
	F3x9q7LGNPBmjQc0fKJ+I3Ec/hH3odvZfaLyMbEE53/OhAYKmIbRcMjvUUwVHCpw+DSWednFOjM
	XYRx50EApqFxUoRmAkOOqJqkvb7GefEuQBXyn+lFV/o+aLkZfYdcn15YpK2sm+iyvDUhF8MYFdA
	g+g4/PySg6AlOltoVaH7rVCCTOhTzV4vM/KIbRGsqEfaLufzWaUo8sqNJjDcoXeeGCFb0xHaRzB
	2ICuzMDffObys4JqT2JXCAS1WgIIfNzdDPpR/qfUpudXHNw==
X-Google-Smtp-Source: AGHT+IEcRaNRwLVZvQ0+PFDpEZBl5TqywmCgn+6HMV79ElMQ8KBIAJHpCBhlQym1EiHDUaUbZ/iP1A==
X-Received: by 2002:a05:6a20:6a26:b0:243:c36f:6a7c with SMTP id adf61e73a8af0-243c36f6f4dmr3879485637.18.1756478472441;
        Fri, 29 Aug 2025 07:41:12 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1f86sm2560999b3a.72.2025.08.29.07.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 07:41:11 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 29 Aug 2025 07:41:05 -0700
Subject: [PATCH v5 4/9] drivers/perf: riscv: Implement PMU event info
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-pmu_event_info-v5-4-9dca26139a33@rivosinc.com>
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
index 7e984ab717c6..0800ade1d0d5 100644
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


