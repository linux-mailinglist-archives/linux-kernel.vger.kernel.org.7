Return-Path: <linux-kernel+bounces-817102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FA3B57DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C117F1890C53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9C52046BA;
	Mon, 15 Sep 2025 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvz6qrD1"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E86433C4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944208; cv=none; b=Uq9r9lcWB5xR/b+q2r+x801Sxb+1x9QRZ0cEittsgqN9gJgs4oUuqo+NkPcuPSzVo3jTLQO6rWKePXf6XxUDVny2ZufZtivjhyLYKAvY0ctZBy25F9BVV4H1tkZZUG0OwNJlNP/RPvFavePbyFFjK++JIMbBQS3VbeKozy9v8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944208; c=relaxed/simple;
	bh=c7WHqduScyHLDDcMsq9d0TDkDIqfvJa2wH5RuAPMgL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgH7D+emWRfzzC0p8k1c2HtkmW2/ZRSeOo5el9ip9AS0Lr17d9tLhXkAIWyJazY6FZGZtAFHA5KR1X0pB/ijNvPF7ZPGY/kNSmx+DxJOHxsPaSnnj6/FQLGki3UopQEegPSgvsr591RQmXA57aZyWdNOMDJgnzWci8Wz2GOfQhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xvz6qrD1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-80e2c52703bso371932785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757944205; x=1758549005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TTLchl8AB1FHcg0issnijieflGh4JJHnQc0EA5X3mh0=;
        b=Xvz6qrD1lOmUecr9stSqm85+155Xi7DJa4MjUpfu7mRsOR6MQHB+UjftDYuNg7ftkS
         +KB+++WQj7bDVIPpOuWidqzWivt9feo8v7JLTPQ6ll+E2k4Nov6yGocm2kB6G+VxmCba
         KLuEdkAW71MfPR60Uy4EBN0dkd6Co2rKmzocjDD8smTA+WW9HONVj5NGZXpQAiN1qc/S
         roZaCjikUcRqhii8r/eNpzsrhwLkixDVzLr0h4dQf6eJ6y5UrE9GLqqvQeNDXEfsg/9k
         8HC1mKj4d63Y/GKC/K3pTJAqWinWZtO6E4oGzjIU2fwjOEM3OPQXAl+vpYxNvPBh5NRn
         +0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757944205; x=1758549005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTLchl8AB1FHcg0issnijieflGh4JJHnQc0EA5X3mh0=;
        b=fjBdJx+0Y/ROMzz2Mnp4n68Ya3VK485aMHLQDLfcO4TS2lqjPX8PB/n/K2EUOcZ6E3
         B1fWqsGfwulXDw1esSv8V/0tGZKpdZ7adVjNNNtmTqPa6o8twG79PnDNhRp2+JBpIGEP
         O9d9naHRX/pLs/4XufAsd9QBfznU9EAKEV2IyKuQH0FXVslAdxLtrHEgL7toMO3A0Rx9
         jsiI3OUEZlJobMMqyCOeGA58rjgtKE9jf49L2KeAk6Y1fedWjdvtc4JJ06y68JQ9qmW8
         +hK8eSrfnuy1SZ3k0K4N+tzltFFvp+y/piQk57qZ3JaiUi5lSGkuEUIcKIhCKkomjy3y
         hWjw==
X-Forwarded-Encrypted: i=1; AJvYcCXcmoFh4NHTa5k+Y0F2qBKV/okXqyyz2B/BlXg3sj9Cj8hocR8EOxEkSwldXNvuSDQgWkYwOXZDisLwiFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwEcPLCDhfp1v63YDAgVq98fzfNhXLFgXQfE076N8eaXViogmG
	jZhQasBrKRkMrCxBPexeyyKNNWeVh664rF3k3dl+GztYSFB7IxVuSUAx5PCEzColpXI=
X-Gm-Gg: ASbGncsWBpd30AN6wYjhxEZfHTpGM+3NgNPhGAQpuVNO3zSbs80/zAHY6ADAltVqpDb
	IgBq4td3kGjGFF5Sy5GfWgAxZ6JEz9IvuXN6PbG9riXn0k5xQOzo5239o02JGftTvidm+7ecmYh
	pKwwluWvlXNx5qx8tzJpF8CTsW1G2H/twvxjXZtHR9BRsxnWkBLST3Z9cbKwCVundkVmBrGl15+
	vHWkFnjsn01IO7b0T0IZZvs9fWim0WONM3QFp/cjND1otHRKEjcKZDvKyoBKAxQvZE4pH+cZvHN
	8z4WsKerxE5It9uA7Q/FiACLMtOibpTrHUYb1Pu/Aw/HZCohSnMgEn0+R+MfuDV+ebnTd8FJrjk
	eXax+GjasW1p+DymoRo28
X-Google-Smtp-Source: AGHT+IG8T1D2VcobDSUfxZF55EW9JKFw5MqOt+0GKdF65CJsD1ElHprtWEh3DqhVRm63lx6N1nim4Q==
X-Received: by 2002:a05:620a:a493:b0:826:ef9:3346 with SMTP id af79cd13be357-8260ef93386mr1046185685a.18.1757944204974;
        Mon, 15 Sep 2025 06:50:04 -0700 (PDT)
Received: from cachyos-x8664 ([185.221.23.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-82a0d349ca3sm167578685a.64.2025.09.15.06.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:50:04 -0700 (PDT)
From: Jia Qingtong <jiaqingtong97@gmail.com>
X-Google-Original-From: Jia Qingtong
To: oliver.upton@linux.dev,
	maz@kernel.org
Cc: will@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	cohuck@redhat.com,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	jiaqingtong@huawei.com,
	jiaqingtong97@gmail.com,
	yuzenghui@huawei.com,
	jiangkunkun@huawei.com
Subject: [RFC RESEND PATCH] arm64: Rename is_midr_in_range_list and add is_midr_subset_of_range_list
Date: Mon, 15 Sep 2025 21:49:29 +0800
Message-ID: <20250915134932.8137-1-jiaqingtong@huawei.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Qingtong <jiaqingtong@huawei.com>

Regarding the is_midr_in_range_list function, from the early discussions
during submission [1][2], we know:
1. The VMM must ensure the correctness of the target impl CPU set.
2. For errata-related fixes, if any target impl CPU is affected,
then all CPUs are considered affected.

However, in commit e403e8538359 ("arm64: errata: Assume that unknown CPUs
_are_ vulnerable to Spectre BHB")
and commit d4647f0a2ad7 ("arm64: Rewrite Spectre-v2 mitigation code"),
the functions is_spectre_bhb_safe and
spectre_v2_get_cpu_hw_mitigation_state use is_midr_in_range_list
to determine whether the current chip is not affected by the issue
(rather than, as we might expect, whether it is affected by the erratum).

Therefore, for the arg ranges of is_midr_in_range_list being tested,
as long as there is one MIDR present in the target impl CPUs,
the current VM (and the target impl CPUs) are considered not affected by
the issue.

This seems somewhat contrary to the original idea, since the VMM does not
know whether KVM implements positive or negative logic.

Hence, we may need to rename is_midr_in_range_list to
is_any_midr_in_range_listto explicitly mean "if any target impl CPU is
in range_list" and additionally introduce is_midr_subset_of_range_list
for someone like is_spectre_bhb_safe to use.

This patch just show is_midr_subset_of_range_list and it's example usage.

[1] https://lore.kernel.org/kvmarm/86cyftty9q.wl-maz@kernel.org/
[2] https://lore.kernel.org/kvmarm/ZyG3FiUiyOi4t3rQ@linux.dev/

Fixes: 86edf6bdcf05 ("smccc/kvm_guest: Enable errata based on implementation CPUs")
Signed-off-by: Jia Qingtong <jiaqingtong@huawei.com>
---
 arch/arm64/include/asm/cputype.h |  1 +
 arch/arm64/kernel/cpu_errata.c   | 41 +++++++++++++++++++++++++++++++-
 arch/arm64/kernel/proton-pack.c  |  4 ++--
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 661735616787..1339a2e37104 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -304,6 +304,7 @@ struct target_impl_cpu {
 
 bool cpu_errata_set_target_impl(u64 num, void *impl_cpus);
 bool is_midr_in_range_list(struct midr_range const *ranges);
+bool is_midr_subset_of_range_list(struct midr_range const *ranges);
 
 static inline u64 __attribute_const__ read_cpuid_mpidr(void)
 {
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 59d723c9ab8f..30cc91f875d9 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -53,6 +53,45 @@ bool is_midr_in_range_list(struct midr_range const *ranges)
 }
 EXPORT_SYMBOL_GPL(is_midr_in_range_list);
 
+bool is_midr_subset_of_range_list(struct midr_range const *ranges)
+{
+	int i;
+	unsigned long midr;
+	struct midr_range const *range_ptr;
+
+	if (!target_impl_cpu_num) {
+		midr = read_cpuid_id();
+		range_ptr = ranges;
+		while (range_ptr->model) {
+			if (midr_is_cpu_model_range(midr, range_ptr->model,
+					range_ptr->rv_min, range_ptr->rv_max))
+				break;
+			range_ptr++;
+		}
+		return range_ptr->model != 0;
+	}
+
+	for (i = 0; i < target_impl_cpu_num; i++) {
+		bool found = false;
+
+		midr = target_impl_cpus[i].midr;
+		range_ptr = ranges;
+
+		while (range_ptr->model) {
+			if (midr_is_cpu_model_range(midr, range_ptr->model,
+					range_ptr->rv_min, range_ptr->rv_max)) {
+				found = true;
+				break;
+			}
+			range_ptr++;
+		}
+		if (!found)
+			return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(is_midr_subset_of_range_list);
+
 static bool __maybe_unused
 __is_affected_midr_range(const struct arm64_cpu_capabilities *entry,
 			 u32 midr, u32 revidr)
@@ -276,7 +315,7 @@ static bool has_impdef_pmuv3(const struct arm64_cpu_capabilities *entry, int sco
 	if (pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF)
 		return false;
 
-	return is_midr_in_range_list(impdef_pmuv3_cpus);
+	return is_midr_subset_of_range_list(impdef_pmuv3_cpus);
 }
 
 static void cpu_enable_impdef_pmuv3_traps(const struct arm64_cpu_capabilities *__unused)
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index edf1783ffc81..ce3660625743 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -172,7 +172,7 @@ static enum mitigation_state spectre_v2_get_cpu_hw_mitigation_state(void)
 		return SPECTRE_UNAFFECTED;
 
 	/* Alternatively, we have a list of unaffected CPUs */
-	if (is_midr_in_range_list(spectre_v2_safe_list))
+	if (is_midr_subset_of_range_list(spectre_v2_safe_list))
 		return SPECTRE_UNAFFECTED;
 
 	return SPECTRE_VULNERABLE;
@@ -864,7 +864,7 @@ static bool is_spectre_bhb_safe(int scope)
 	if (scope != SCOPE_LOCAL_CPU)
 		return all_safe;
 
-	if (is_midr_in_range_list(spectre_bhb_safe_list))
+	if (is_midr_subset_of_range_list(spectre_bhb_safe_list))
 		return true;
 
 	all_safe = false;

base-commit: d69eb204c255c35abd9e8cb621484e8074c75eaa
-- 
2.51.0


