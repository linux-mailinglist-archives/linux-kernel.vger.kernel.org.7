Return-Path: <linux-kernel+bounces-788083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F5B37F86
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E77F7A5154
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19018346A15;
	Wed, 27 Aug 2025 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EnSH9XQv"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EE9346A10
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289441; cv=none; b=CQkm/vBjdtXfjJ5H/bCCOngbfdzMU9lk+99TepxoR3WzdgGaI2FBdtnegoEhNjY3j+SVixyeL5B6UAiSQOo77ni/1yBSfsrPgab2pyIAec1tQAWHyT+aYFstrTkrqNRf5v5iNhUNpUZTJFEFbW0vOKR8YPw9dF3Wb7o9xAw9V6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289441; c=relaxed/simple;
	bh=ob1mm/QZIvYurNgvoNKtvTajPGjDoJT+DigHtqvCg5Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iy5uT5StYNV/7+30vBOvU/FtPPil7/+ZWz02AeyH8s0K45+YBy5GsNx8vnJVE9dykQhB7Hjg0Qi3iBFDAMLg4ZxJMelmRFvyZkKYETevyYln32yURntB6P82d7TxvZQBkEp6E8sFzpb5uBXwGNGEbu96CHza3CvD3lY77wKxqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EnSH9XQv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-771f3f89952so652017b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756289439; x=1756894239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JM7gSlpkCi+0kyKyklIFOqWTnKhlvxmA1qdlwzNde30=;
        b=EnSH9XQv1YMXQhBFHrLfMGiqI4mEKdKdB2aK7vuZKSXuXARtQT7rpozk7vMehNT3dw
         XH+6zuUNxpUWFVe/K7OA4TnJpKwjqgSXuyhHXyLs/0geC3Ten9Y+BKQTq3Oh56kMODS4
         vp0lU37WyqKWdV+0uNhKhpU0voBOS6ex1188NKesv3U1Z18fmyE07TdZd4NK89T/Odic
         ZYKEqP2NaEzc4axYmwifp9bEAMo9K9E1CvojpXBvEo8apgqBveW284aD2CtCnuzSOdhK
         G3TSnReuYAQv9g1Oq0BxIY8JfbZbTWDwcYoGrVv6gSXZPfr8yvQZgXVCoXKuc5EzUXdd
         QETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289439; x=1756894239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM7gSlpkCi+0kyKyklIFOqWTnKhlvxmA1qdlwzNde30=;
        b=Z/c+AzjkZjEF8zDrFX+agKtsIN+M5JTZ3VwH6Vyq6puggHVP2Z8ctUp5DQW/38Q3PV
         h5HVqFJq4wIajrFfYBTU1bLlsi64Js3xgs7cPZD77+qaj+7mCuUAER63jxHTs3gLSkyY
         8jb8Q+WfXfaCqnkkbV3YQ7/JJYNGKkVouWBu17R1owFjpRQloXuSefZOPXbwoH7mNEcx
         O4Eg/36OBBuMblTMPLndiws6nj/bR6qUNv4MAH68BEMPt1541NZ0IEgZ9CE+nvBPqFO3
         3q/8T2Tx3lf4/db57ji9//5r895K8TTi3FZGW+dFCgoPF/Lptktd9uff2gcBKctT0PTR
         Yv/A==
X-Forwarded-Encrypted: i=1; AJvYcCWfHN7uDaTH8LfD9Wt1YB3DHLXLuAI5pUr6zDaOKK1YebmBaDHeInoXRsoU4C3A6W4tiUqsrVhw3TX1fZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVgKttdBzA82a1Mj/ik0vqmBnBnt3mEqq/MhOUCD74QrIAJJ5
	rFQA8zOppaK4kTWtWEKMdlTmkJ995iP4WrpKrwmUOkW5mMJmhQp3gjQOH1E4MtwBj7I=
X-Gm-Gg: ASbGnctTm/hZpfmYJKO/oL3qajlKk0A/OfLzwNlYt+sJ1rdJsQyooU6xB66PKGaJ79d
	ZEXTHEpy7CVYXVTc+QwzriCL+LcNaYaRwKOuqOPTdwswhnX7ML2EmwKBoM+Ko+UyeEKN0vtimNs
	hnoahmnzKae9EQy0Kr3wT+4ChKAurU2jZAnAyXoxecu+6uaKMdeBZv/89EWo1FxKUsXCDdIuJWy
	MDe2/XHImuBDdkk9aMXdiCy7klmddSGSoO58mnjsA55M64XL/QZ1sqNvoixoHSIEs3zrBe18urH
	4SuSWzwif/8Y/0IflWXbYHVegcuDAHn+bmdRnDfiUTBYTdIWlw6hQoLL2IIeuT3uYfBzu1nnFsZ
	W0lzYZ6ic6jJUS2OJOKYA2WPA/n/HvHGn839XQB7+6NNrj1dE8p25WCjHXAjVxkc=
X-Google-Smtp-Source: AGHT+IGdtKUBscgA9xYMmV3962XLu6gCj63wXPK/4bKpP1nVTjXzqxHi4UVk2L8ckDMtXKsc3B7ldA==
X-Received: by 2002:aa7:88c2:0:b0:771:e341:ce68 with SMTP id d2e1a72fcca58-771fc292e89mr6337778b3a.5.1756289439091;
        Wed, 27 Aug 2025 03:10:39 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm12813462b3a.79.2025.08.27.03.10.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Aug 2025 03:10:38 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	atish.patra@linux.dev,
	anup@brainfault.org,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	catalin.marinas@arm.com,
	masahiroy@kernel.org,
	suzuki.poulose@arm.com,
	cuiyunhui@bytedance.com,
	maz@kernel.org,
	zhanjie9@hisilicon.com,
	yangyicong@hisilicon.com,
	dianders@chromium.org,
	mingo@kernel.org,
	lihuafei1@huawei.com,
	akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	rppt@kernel.org,
	kees@kernel.org,
	thomas.weissschuh@linutronix.de
Subject: [PATCH 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
Date: Wed, 27 Aug 2025 18:09:59 +0800
Message-Id: <20250827100959.83023-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250827100959.83023-1-cuiyunhui@bytedance.com>
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reuse watchdog_hld.c to enable HARDLOCKUP_DETECTOR_PERF and
add Kconfig selections for RISC-V.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/Kconfig           | 3 +++
 drivers/perf/riscv_pmu_sbi.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 451eb23d86c96..214b1ead5781a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -184,6 +184,9 @@ config RISCV
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
+	select PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if RISCV_SSE && RISCV_PMU_SSE
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8c1ac7985df6c..c5423a046d016 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -22,6 +22,7 @@
 #include <linux/sched/clock.h>
 #include <linux/soc/andes/irq.h>
 #include <linux/workqueue.h>
+#include <linux/nmi.h>
 
 #include <asm/errata_list.h>
 #include <asm/sbi.h>
@@ -1102,6 +1103,11 @@ static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
 }
 #endif
 
+bool arch_pmu_irq_is_nmi(void)
+{
+	return IS_ENABLED(CONFIG_RISCV_PMU_SSE);
+}
+
 static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
@@ -1525,6 +1531,8 @@ static int __init pmu_sbi_devinit(void)
 	/* Notify legacy implementation that SBI pmu is available*/
 	riscv_pmu_legacy_skip_init();
 
+	lockup_detector_retry_init();
+
 	return ret;
 }
 device_initcall(pmu_sbi_devinit)
-- 
2.39.5


