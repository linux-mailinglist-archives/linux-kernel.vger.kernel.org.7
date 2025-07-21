Return-Path: <linux-kernel+bounces-739325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF6CB0C4D0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94BF16F9F3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3472DC335;
	Mon, 21 Jul 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Edu2Cc9k"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713E2DA77F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103122; cv=none; b=FPGOomtn2wYdqxkkDP+UjM2AVrkF54n8WRfHVCNUBBzTcbPdCxR/3KwXC9X9y+9lN5i+XA//OqcN+oXc5ylK9+JIFBWbhlVwGnZss1WfTvtqNiysJWgp2BzUYS/6vc0vbxodu2Cx6M77AdtS0Xbpb0viwy/wAgPUJfyIRnimdhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103122; c=relaxed/simple;
	bh=+SpNfvIdNfTZltOmSX39gMGmWG5o7oWGDEW8UKH3C24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ll7AUhQllVWYgny50EZ7UVE+jKF6l365FC7mgYjwr0nwj4LNEvhecQE56D1VGIZ3qSkR4Ov7ibucPgqq0MMdRS3+qLZxxLLvPXTEm35vC+0C6OYmLCGaIhAs3kqPlSQFWkgTPy0rbSpC0wmfytELV32xw6aLXbNh2sfcCFxcIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Edu2Cc9k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so44641735e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103119; x=1753707919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZ3PtlOR0m4xvI+xrlOA19tnjKSe6qe5HMQ0ewIzj6Q=;
        b=Edu2Cc9kv/9b5WwwT8A1LTpX0gEVjM9HPg2En43YpX8sfpMfkbkOSyAG8ogBH/U52/
         h/DCsPdWqhbvIvowiy4LNqoatjmLiaeno0T4YoznL0vcnAM4Cl8vfCzpZP75gkYITcrN
         fM8rgSTQ57jfQnmOO0LL9J3a6QL3c/6p0a/ZoJTPFGUjBMCkV04RITMZtC/jM11YGUWe
         HyJIj37PruTxHUSCW+6QS6XLuJ5EF66HXCQv1a6Yf9WM4UujD7+4gc7v/LbL2RygHN0B
         4vyaHACbm30C04Cl9qxYvLWTeYhZknOnrDgLYaUL+FOJ2/g/5f1+x7Xof090m5cvI4pp
         o1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103119; x=1753707919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZ3PtlOR0m4xvI+xrlOA19tnjKSe6qe5HMQ0ewIzj6Q=;
        b=cqB1io2Au3YvQIHdGAC2+3AbRzhLWtgXrYEHmw7KR0qnNERk571fRVcTGeH6SBqxXV
         pJgQn8E9cpeo+xftOZWzQBsDYNFeNduUA/crrysiDcC808j4urZBt1EuuekYMdPXS+k0
         lNgcg6Do1N86w4K8SnXflnSUmJ+k/J5jumkadYCdpWv+QaHiNDaykaxqLcfO/XFNYPT3
         Y2P5A+Z0xqh3l7XXEWK5RQ0QxpwmBj8GTvYuuVn0vk0P0cQd88boqBLoIt3d+LKKsoRl
         85Frun6Bxmj1qnlcGEtYOKBmlkthtZ4vw67j+fMDquv2/lph3m+/m6CYy2I/F3yimdNn
         vFhA==
X-Forwarded-Encrypted: i=1; AJvYcCXig+gZWph/vcKmEGQMI5nJE6Bg6cF2q4l4f0eddPXi79Ez3L8e/1Ki8jzJznepP8noz2NQ/8ermQwkok8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuWQst7XFHqm7blrjd1yRryZ+wcGGlaafW4HIzS2tiWW+F+yiI
	nnzWiWj5buy4Eoig9TxLnB6S0PMUNKjt7GyUHhXZv7Qpk+MCKzSleF6MWHnHAzSsIfw=
X-Gm-Gg: ASbGncvo/+ln8p+hLQeFzLwm6GI/NiFeK0EIiGnJXC+/596Tw5oKuvVbAM6rJz+Rzw1
	h2kWb6IHh1oqMYB4AAeD7f+1xwQwKtnldPdM91ORjW3bhwGxSVaFdITPD2Q4AOz5AgOmM0reWYc
	4PdICxl1abeP6qROKsAVdlPikTYi4jjHBPZn7bGu49dXyAOc6G0ECg0APJLtx/RPFGi2PUVjWsB
	5lbC5mxTjPEz/eqQndsYe2ms045LdH/tcyfy/J+zXHQeHOG/jOBqo40m+JSn1weV/jVCLxMrqTH
	ed6voJht4TTVwMQaARIvvW3OZnzAnQgYdfRAJpnqzSwRQNL7VZHr9Avpm4oItT4WIe9gmuB6jMN
	nWMqxXq4DWAYcZpTvUipSWtHMzfxNCvc=
X-Google-Smtp-Source: AGHT+IH9bw7cU8ns9QQ3mV/+eJ2qDxTwHmxGZEX7vgJMgWIg3L3lpoWH95LxFXy5NofnFtzmG3M36A==
X-Received: by 2002:a05:600c:3589:b0:456:1d34:97a with SMTP id 5b1f17b1804b1-456357faf96mr152094745e9.9.1753103118896;
        Mon, 21 Jul 2025 06:05:18 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:18 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:05:01 +0100
Subject: [PATCH v5 07/12] KVM: arm64: Add trap configs for PMSDSFR_EL1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-7-a7bc533485a1@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>
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
index 6f556e993644..dba0e58a5fac 100644
--- a/arch/arm64/include/asm/vncr_mapping.h
+++ b/arch/arm64/include/asm/vncr_mapping.h
@@ -92,6 +92,8 @@
 #define VNCR_PMSICR_EL1         0x838
 #define VNCR_PMSIRR_EL1         0x840
 #define VNCR_PMSLATFR_EL1       0x848
+#define VNCR_PMSNEVFR_EL1       0x850
+#define VNCR_PMSDSFR_EL1        0x858
 #define VNCR_TRFCR_EL1          0x880
 #define VNCR_MPAM1_EL1          0x900
 #define VNCR_MPAMHCR_EL2        0x930
diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 3a384e9660b8..60bd8b7f0e5b 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -1174,6 +1174,7 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
 	SR_TRAP(SYS_PMSIRR_EL1,		CGT_MDCR_TPMS),
 	SR_TRAP(SYS_PMSLATFR_EL1,	CGT_MDCR_TPMS),
 	SR_TRAP(SYS_PMSNEVFR_EL1,	CGT_MDCR_TPMS),
+	SR_TRAP(SYS_PMSDSFR_EL1,	CGT_MDCR_TPMS),
 	SR_TRAP(SYS_TRFCR_EL1,		CGT_MDCR_TTRF),
 	SR_TRAP(SYS_TRBBASER_EL1,	CGT_MDCR_E2TB),
 	SR_TRAP(SYS_TRBLIMITR_EL1,	CGT_MDCR_E2TB),
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c20bd6f21e60..82bddd631b47 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3010,6 +3010,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_PMBLIMITR_EL1), undef_access },
 	{ SYS_DESC(SYS_PMBPTR_EL1), undef_access },
 	{ SYS_DESC(SYS_PMBSR_EL1), undef_access },
+	{ SYS_DESC(SYS_PMSDSFR_EL1), undef_access },
 	/* PMBIDR_EL1 is not trapped */
 
 	{ PMU_SYS_REG(PMINTENSET_EL1),

-- 
2.34.1


