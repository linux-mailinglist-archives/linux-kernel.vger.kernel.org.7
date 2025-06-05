Return-Path: <linux-kernel+bounces-674364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A93ACEDFF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 12:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37F0178BDD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 10:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A27221D92;
	Thu,  5 Jun 2025 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5V1T2Hw"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063FC21421A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120606; cv=none; b=WRzmrr4mAj7NuttMWkpwLlktF7wvMtkpdgvtvj1B+Oto3/qM9kjDNvTu0ts3aVvKAfNwiROyM+z5m3X5wkAewm6lor41sDA5PtbAZRxEsUgg3DyZa+5ZAid0ejRp00qMyae8/Pec5KhhSwZj/tfNOLB+pFYCGDNIcsHYjHultxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120606; c=relaxed/simple;
	bh=NVy82iJ/QLGDAl8W6Sh4eSwnTCJwtHJ0GXadcsGR9Xc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d2zYD2/Q0uYdGG+qQNu5BhWMtfmsXasRdtPGL+Shq47/+goTJZr3F7QrAVraNJBQOxwALnC3xCy3YGcHN5qcC0baA40epH63dlswUcC3QxN5Knq3oZXSeFDiPzdHtj+RAWQ37Vlw+7x4Iw/s7ia0T6yzEuBk7iJwraWswyYrk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y5V1T2Hw; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-442f9043f56so4275015e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 03:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749120602; x=1749725402; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MOtEpU/QTXhqeOr4QGO8o+Hgp7yMZJ+Usq43ricq8a4=;
        b=Y5V1T2HwTJEyGCj9ynJ8XzWp2wHgSCHvu766vq+NlfQlOTT1Pue9mizb222k41BZmo
         fHdsW6/ljMMbnoUFOOk+KLe8xT8FQuO5JUmIz3B1zTbyZhuE9mKQUX0eJFM7XXpL+Siv
         0INx8ahm9bEkKxXP29kzQcvc9z0+jp14uWPf4fiNWS4h6ahWVTdLEojdwVUVrlre/UPR
         YaqynaNItOlxVPaLJzjUELrKRbWjbsflwQ/g2vWhK3GVNyl3aG+Oz3B3Jf2HMCCKZU0C
         Sjo1Qy/o+1ifQydAEfZBJH0E5DZfeVKHpsvzWm+4ZU6ViGIiVdwtr6xQNdsyecjiGLUR
         f3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120602; x=1749725402;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOtEpU/QTXhqeOr4QGO8o+Hgp7yMZJ+Usq43ricq8a4=;
        b=LfwxqXt/p9I4qD8GkCQ0xkEEk5Xzp/1uyiiE+Kkrv750ri9K1+Rr0dfJeVCW8g8dWf
         AHjs3uS2zIxyNHFGO1ozzEioQwhroFuWk6XYAs9WsnluvdEK0saBRYtXJOoHk6XvwjMu
         tYRVcOGVB5F+1nC764gCYz55c3dv1MF5++4Dgq4qBVRLeiKdZsQC4pH3ExSWnvat6f/g
         S+v/BEb3r1i8HACL0qlVR22U9/yelohIPKuLjviU6DT2Qd1j4RWXG51mgkYhWoPUnRO/
         lTlkd+UX2WAfa2Z5QOUOAzKcFFJzB53otibfln950eKVDYCZZTs72hahjL0LwWkBP45E
         zkkw==
X-Forwarded-Encrypted: i=1; AJvYcCUU0sA28md7dDnjrKjzprJjkblujidLUf1uZotrMtHw9zpOreRfKq9CsdwFE8+Z1g4Q0Skasj3htq0LaYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WSibVWYJMKUbOcGe/SuUeXW7Hj0JFpCUZqgQd9iqXTMR7Ozc
	eEgqnoaNG30i2hq1jfEecTxMOiisBLTU/CC2Q3bgCY6/eIugtxzQ/W/6lmqmfxvRC8c=
X-Gm-Gg: ASbGncu7xQHpUi1BqbE4fBO7QljhOxjtL+d1T+ByYRH3ARWQeLs3TzgZKa0JE9B/ghj
	bvPr2Rw6brnaom9HwYk6lNPJvZk6LXkQoh1fQgo3lIaSQSdvxQdZBGDmXG9CxCGYHsUvT+pw4JB
	YYvf5yrRDW9M7jNE7NSav2xIWv2S6Ks0bA0crY8xm073IYUvkKUBGCdP/omBpL1fOLyXG3S3HI9
	/9UwCZjt5Zs0nvGYGXHe7kMZaXxirfNZxnaol67ZVKIhRZ+2WOMZ2Se6rtAIPW0H15bo1b9dClR
	BIXA8WZIWuMHdXG821ymmWHjP4Ainj5HrEvH7W6ENmT7nDr1cRb0NjnZ8CJ2
X-Google-Smtp-Source: AGHT+IFIuwqPu0X5eoCscdhdRejVlPb11XtHePijaNQ8MuQwLUyBUWJS/pTWuyRwgt/m/n/fycau1w==
X-Received: by 2002:a05:6000:4009:b0:3a4:febd:39f2 with SMTP id ffacd0b85a97d-3a51d9661b7mr4769796f8f.37.1749120602299;
        Thu, 05 Jun 2025 03:50:02 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cfe3sm20629965e9.23.2025.06.05.03.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:50:00 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v3 00/10] perf: arm_spe: Armv8.8 SPE features
Date: Thu, 05 Jun 2025 11:48:58 +0100
Message-Id: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABp2QWgC/33OTQrCMBAF4KtI1kYm6Y+pK+8hUsZk0ka0LUkpS
 undTQuiLuryDcz33sgCeUeBHTYj8zS44NomhmS7YbrGpiLuTMxMgswgEZJf8U6Bd+Qtt4R9GTo
 qyfY8z7WxqVGWioLF786TdY9FPp1jrl3oW/9cigYxX99msmoOggOXqCWYFPZaq+PNNejbXeuru
 WMBMsj/A8akCkhRqjLxDcyrBvlZksliHZIRQhBYXBAN5PgDTdP0AtFtJ35JAQAA
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
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Support 3 new SPE features: FEAT_SPEv1p4 filters, FEAT_SPE_EFT extended
filtering, and SPE_FEAT_FDS data source filtering. The features are
independent can be applied separately:

  * Prerequisite sysreg changes - patches 1 - 2
  * FEAT_SPEv1p4 - patch 3
  * FEAT_SPE_EFT - patch 4
  * FEAT_SPE_FDS - patches 5 - 8
  * FEAT_SPE_FDS Perf tool changes - patches 9 - 11

The first two features will work with old Perfs but a Perf change to
parse the new config4 is required for the last feature.

To: 

---
Changes in v3:
- Use PMSIDR_EL1_FDS instead of 1 << PMSIDR_EL1_FDS_SHIFT
- Add VNCR offsets
- Link to v2: https://lore.kernel.org/r/20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org

Changes in v2:
- Fix detection of FEAT_SPE_FDS in el2_setup.h
- Pickup Marc Z's sysreg change instead which matches the json
- Restructure and expand docs changes
- Link to v1: https://lore.kernel.org/r/20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org

---
James Clark (10):
      arm64: sysreg: Add new PMSFCR_EL1 fields and PMSDSFR_EL1 register
      perf: arm_spe: Support FEAT_SPEv1p4 filters
      perf: arm_spe: Add support for FEAT_SPE_EFT extended filtering
      arm64/boot: Enable EL2 requirements for SPE_FEAT_FDS
      KVM: arm64: Add trap configs for PMSDSFR_EL1
      perf: Add perf_event_attr::config4
      perf: arm_spe: Add support for filtering on data source
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      perf tools: Add support for perf_event_attr::config4
      perf docs: arm-spe: Document new SPE filtering features

 Documentation/arch/arm64/booting.rst      |  11 ++++
 arch/arm64/include/asm/el2_setup.h        |  14 +++++
 arch/arm64/include/asm/sysreg.h           |   7 +++
 arch/arm64/include/asm/vncr_mapping.h     |   2 +
 arch/arm64/kvm/emulate-nested.c           |   1 +
 arch/arm64/kvm/sys_regs.c                 |   1 +
 arch/arm64/tools/sysreg                   |  13 +++-
 drivers/perf/arm_spe_pmu.c                | 100 +++++++++++++++++++++++++++++-
 include/uapi/linux/perf_event.h           |   2 +
 tools/include/uapi/linux/perf_event.h     |   2 +
 tools/perf/Documentation/perf-arm-spe.txt |  97 ++++++++++++++++++++++++++---
 tools/perf/tests/parse-events.c           |  14 ++++-
 tools/perf/util/parse-events.c            |  11 ++++
 tools/perf/util/parse-events.h            |   1 +
 tools/perf/util/parse-events.l            |   1 +
 tools/perf/util/pmu.c                     |   8 +++
 tools/perf/util/pmu.h                     |   1 +
 17 files changed, 273 insertions(+), 13 deletions(-)
---
base-commit: ec7714e4947909190ffb3041a03311a975350fe0
change-id: 20250312-james-perf-feat_spe_eft-66cdf4d8fe99

Best regards,
-- 
James Clark <james.clark@linaro.org>


