Return-Path: <linux-kernel+bounces-768424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC74AB260F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E9E3ACF73
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D86E2F7454;
	Thu, 14 Aug 2025 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSEkrnGN"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68202F60AE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163570; cv=none; b=joLF/zyhhbckMykf8BuKhNrSGoSaqehFuJk4v6ppeWY/KUQOe1BbaY8XTXxV8WjKc1r1Ivld9Zgqh9fU14Tcnsh3IxY0lL1YVW0LgCntmpwuNVk/Gr3YABnkpB7WPNcbWZZkshWqGAfJnnfGI24DOTMqPbH+KLskvin33S5p9/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163570; c=relaxed/simple;
	bh=UsFp0sErRCl0MxQtdMcp7ORp6c6Qv9zuPqmFhcaNxF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R46bvNT0OCuljOewC/r2ejW7ga/c4344NNbreYttosb7Yw1KXxXuZs4QemEjRGOJbTILlrHJ/Ag4P6V/yrkhPpt1QXZwz5+VD5VTSyYtwVHTwnTcC/nSHm6KliUfM626IjtCjd+10MKnIuR4wrxGSiXbB7ikd8wiNNBhIlpTFT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VSEkrnGN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so4841355e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163567; x=1755768367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGZcvUVCZS8QsvENr66yrxXLduHaz342cTv3n2jzGu0=;
        b=VSEkrnGN49aRP8cwWfmBNS2KfXVemu9PRYgYjG/BbtnK3Geaeb++Y6AL7yDZ6Rrfrg
         wbgQGVGE/PgRowlOjeRl8ONSBQUiDvsn5JeBCIhwN4aPAjgXhXsyWVw/TjY39ExoIsNg
         L35tyQN0DykOwpc9HyVB4bkeY9NS1mh/TeDreW5eLkXQsDmOyIxMcBTeeEs168DZ2y+q
         nza6o80s1iDLTvqZPr9d970rCl+5guEdvlh7P2Q9TWmi/Uj2tzcvGi2djaxICB2oDvz2
         oD5fk1Dk6VT5F+68p9oin87JMxrBtT0e8G+1RelrZi5ms0EJT6dEQ/ECHCrab26B0l7o
         qPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163567; x=1755768367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGZcvUVCZS8QsvENr66yrxXLduHaz342cTv3n2jzGu0=;
        b=K7h2K2y6sOvQ1rnhhCN7T1WuEzkJxuZqJ/Hfloko/3lizcA7aJdSY/v0qkRyOBCTof
         URkfdfrbuqkcr7saijVrNHlMKV0C7Nw/pb082dtm2bF9ShJn/ug4p5ppu0gTdyudYdip
         PRy5ZMXqzYsWMbhaktB7cUDMq5WFKDgMhM0YXnrF8MenMpz2vw4nD/BiTQ92TPqDj7de
         15ASuYNUAP58oHdjPxwmoelPMfJeDJGsY+p7q9y/CPXxPqcpHC81UYAhyIHcHQVv6rpx
         2Ep048ZUIJPQ4JRRXpAHESaSa0zigxRPPttMu36CmWfsQKotqN+t7L1yHlMtFiuX2aLz
         MmAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIf6+uLEHUXBsEdBKGZ/z1uY8XJp7zMq5FY8fDj7YNlunv/6PPzS+dnvsiU1oS5pA7Fy0OVyvJmWA9Ui0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRdMHuh3y24T3BEIOLKjyBQ23s1Apw6jvvrjs8nGYjQp7Hu8/l
	wep/cKpccqwde84+HOTwy3QE6djOE+H8nTY8vZfQwVOXDTeCzEfF71cpzK3B/duZPYU=
X-Gm-Gg: ASbGncuJUsvGjqruw8wzuuPujzYVcG8JXLlkSQUzOeP7JtljbC1v5EapF3DQ6OaUVVi
	xfUdU16GrNgZpBxGhYFV0XfuTk47CvUXrDHnXSe7iP92oIxWrgu+mSI23QimdhRodSu0zwR5CtQ
	Q0sM2VAtu5ipYLGme+YbAAxeu6n0izvyuo8+x6QPA7J1APiQpTHOavPtVsjI19zBI65sq9W8F7H
	FVB8wEuOgCAxea+2gITbXUcL9JyFtbYjbrsFzBIE4WuUMOCirStJhtOuE1PVY0IBVE6ImzTW7Nx
	n37o1vZG3tu58RWchV20aWvmNxKiZNyqEuPsVkKTLUGvoAim2ZBJG35HwvLtWqZDLifb/P1UTSr
	V9Y6J3IlBVHSbv6tD4QG1Q5mnwSdQgZQ=
X-Google-Smtp-Source: AGHT+IEOkVLtv4LKb277h/Y6u80yjiTAO7bDjmFHcIn9yFqBWPJOT++6KQmTGEGyq1SqLmRRRDPzJA==
X-Received: by 2002:a05:600c:470d:b0:456:214f:f78d with SMTP id 5b1f17b1804b1-45a1b65f96cmr14249085e9.22.1755163566832;
        Thu, 14 Aug 2025 02:26:06 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76e9basm14536775e9.21.2025.08.14.02.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:26:06 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 10:25:29 +0100
Subject: [PATCH v7 07/12] KVM: arm64: Add trap configs for PMSDSFR_EL1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-perf-feat_spe_eft-v7-7-6a743f7fa259@linaro.org>
References: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
In-Reply-To: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

SPE data source filtering (SPE_FEAT_FDS) adds a new register
PMSDSFR_EL1, add the trap configs for it. PMSNEVFR_EL1 was also missing
its VNCR offset so add it along with PMSDSFR_EL1.

Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/vncr_mapping.h | 2 ++
 arch/arm64/kvm/emulate-nested.c       | 1 +
 arch/arm64/kvm/sys_regs.c             | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index f6ec500ad3fa..c2485a862e69 100644
--- a/arch/arm64/include/asm/vncr_mapping.h
+++ b/arch/arm64/include/asm/vncr_mapping.h
@@ -94,6 +94,8 @@
 #define VNCR_PMSICR_EL1         0x838
 #define VNCR_PMSIRR_EL1         0x840
 #define VNCR_PMSLATFR_EL1       0x848
+#define VNCR_PMSNEVFR_EL1       0x850
+#define VNCR_PMSDSFR_EL1        0x858
 #define VNCR_TRFCR_EL1          0x880
 #define VNCR_MPAM1_EL1          0x900
 #define VNCR_MPAMHCR_EL2        0x930
diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 90cb4b7ae0ff..aeaba7813275 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -1185,6 +1185,7 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
 	SR_TRAP(SYS_PMSIRR_EL1,		CGT_MDCR_TPMS),
 	SR_TRAP(SYS_PMSLATFR_EL1,	CGT_MDCR_TPMS),
 	SR_TRAP(SYS_PMSNEVFR_EL1,	CGT_MDCR_TPMS),
+	SR_TRAP(SYS_PMSDSFR_EL1,	CGT_MDCR_TPMS),
 	SR_TRAP(SYS_TRFCR_EL1,		CGT_MDCR_TTRF),
 	SR_TRAP(SYS_TRBBASER_EL1,	CGT_MDCR_E2TB),
 	SR_TRAP(SYS_TRBLIMITR_EL1,	CGT_MDCR_E2TB),
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 82ffb3b3b3cf..d1a55cf589b7 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3083,6 +3083,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_PMBLIMITR_EL1), undef_access },
 	{ SYS_DESC(SYS_PMBPTR_EL1), undef_access },
 	{ SYS_DESC(SYS_PMBSR_EL1), undef_access },
+	{ SYS_DESC(SYS_PMSDSFR_EL1), undef_access },
 	/* PMBIDR_EL1 is not trapped */
 
 	{ PMU_SYS_REG(PMINTENSET_EL1),

-- 
2.34.1


