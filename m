Return-Path: <linux-kernel+bounces-760153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1BCB1E726
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA360188EBC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8127602B;
	Fri,  8 Aug 2025 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/Gs44vQ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBDE275865
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652237; cv=none; b=pkogg72ILSGTWT+JvYud6ZAdhHqf1vhE/V3XP3bDq8+kkjfy2/4z2YHSR3DSupS+bUHshfnA2wd5Y+ZtsV0/fF5eWH+pr+1kTk/Er7TVbZ+uvJKyU1CbbzuPbW63C4HO0LP9s8E0tA9OTuytFT+DPxF6XPUTeyfYXuQgeyTYLIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652237; c=relaxed/simple;
	bh=+2GYlOZHwCZ0lRFJU17Kz/6XYFxNBVKE33Il+Q5Ltpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHrDBrc3b0+4B2MHGyyyuNNtruZYBj4rUERtfqeycMsnMbwy7Oet3uzTr5avKvj4Opb2pll3OI0YhAmWXSu2zwvAqzcrEOSppTOzi2tSan2eBeTlo5qU5h8uGlCqcLPz5a1sn+x99f7416sXXI35EshzQpKvnt5UipnOXTpPGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e/Gs44vQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b7961cf660so1650515f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754652234; x=1755257034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCkPGBMU9cuxNuxHQvLapYjmFGObKhPk55g8w7OjRxY=;
        b=e/Gs44vQS6XqDUlpse74/TptHOfjxJxFtj2RcxZmdmXKFiJRK55dsddDwgQiJzhkuT
         znEsLZFnlXrgSsGF6HEBUWS8/DR1k3y0eA97HLXElduQxWBMS46X/J+D4B9MjmA2lbIH
         wlr81QJj4nUjy0AKmvHRmK30Fwa471gprd4fZPIYH2MBCHIqUucy/yqoirr7+SZ+EBjF
         91dSxhjXI8h2wX6A5g/mqJzYhMleeUidLu9weuDEQ5fJYB8dZeK4IDdIGmM23wjy1a+t
         P769y3srJpmZU0Met5M6M1YiUU4ZmHSgJXcDeAtNXfErMeulfqOvjsIYCfgBfFNMJ082
         FwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652234; x=1755257034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCkPGBMU9cuxNuxHQvLapYjmFGObKhPk55g8w7OjRxY=;
        b=I2FWTdGT2C3/bRqfeA2GuvL++Cn1raFGng/T9CypaMd0oZHOJly7NHqGEvh0fjzCq5
         giJQPhBnq5vEpWAA7nUgv+zyrFQNYgK9s0lDoL9yUbPdZc4YiGEs3HdHWOFipuv6xoGy
         yGlOSWR2zevvCbKE0XRkPc91RqD9tKI73hjhH+7HCGJdY6RRcEiahwNU5yA7Z4xIFliL
         BH9nJaWp5ZZKiYkhHQgR3blMJ4ZNr+yHXX6Z4PhveE0yk2iOXdjoQJrwf2dPhxBWzsTl
         RSy2MP9GHWAbYi3EDSjwO1rvpWV5h4WCTvaZVI5mSGvdXv/dShjCj7me2IYgyqDDQiYi
         ypAw==
X-Forwarded-Encrypted: i=1; AJvYcCWRAVfl6VHcCs8QcEWzBADFRN9EEWzUvjjsDp9J/8lagCM69KMIeCycbpP0+bhJeQQeY3RMFnSNeW6uQHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb7MdckCCTOlZ75TldBb3vTzCtjbQPk3P6kLXO+FNqy7siO4tR
	08fvZLYirRG5j7MdGwDWnu3GjNH48KeB6O9YVqe3D+cDw2+Ztq3WxuQ3qZB3HS8bzzk=
X-Gm-Gg: ASbGncukQyUBOEnEdHlQHlFOMyCCd/aDFKieJvNREpKkeBPZZYvvb9U5rEt0kWZ6F/A
	AdJyffAEyuibwa71tz8b4YUHB2471Dhyzqw9o+uUrfVOIPu1+7ZNLfA82S/ViuP9nnKv/9Kuscr
	53zAMPJtS4bnXoKSEWbvvvsZAmenbKrNVRMn1EyF+eQO9NADmkBW5Z4HNW/2+SqCb13Rb5UyyVj
	W9XJ1h1X5KrMCl0DUX1Aiu8RLbe8pEwpsl/c5ljnQ3UFCvtVV6wEhL+kfD5ZSVDte+tfmD4p/o6
	HEjEOBc8ugQO/moyDk6+nBzx85HRpSMFGymCfuFWExz1mHfivvMuhhgtHuln2VBL48/kk4g/TeR
	GGf0vs/u3T0+bK9h3OWIKXP3vj+aNrNA=
X-Google-Smtp-Source: AGHT+IHbD1rxZ+hael7UI+V4nWIH1JBGIhGROdLFUhD8+vK/+XpzNrjCzw2lcwqBQ5oIfEeaFLVqCQ==
X-Received: by 2002:a05:6000:288b:b0:3b5:f0aa:b1e5 with SMTP id ffacd0b85a97d-3b900b4dac6mr1921081f8f.19.1754652233967;
        Fri, 08 Aug 2025 04:23:53 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm233482635e9.24.2025.08.08.04.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:23:53 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 Aug 2025 12:23:04 +0100
Subject: [PATCH v6 07/12] KVM: arm64: Add trap configs for PMSDSFR_EL1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-james-perf-feat_spe_eft-v6-7-6daf498578c8@linaro.org>
References: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
In-Reply-To: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
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


