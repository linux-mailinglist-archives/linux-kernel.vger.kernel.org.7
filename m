Return-Path: <linux-kernel+bounces-739318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4424CB0C4C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065E41892E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05A12D8DA9;
	Mon, 21 Jul 2025 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kuv2jShs"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F902D8784
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103112; cv=none; b=rAmO1Hr470rMBEjXMGWqFftqF/ttm20+2Fm6UwuljiAljUc4xvSbKZlqTFICXNzyt8AnkPkrGMszF6c/2WBmNJgxALKg+KvZ0tHFe59+oWCvScou4+ZMh3pV6e9D0wc4J7aiKbW//h4VVwZqltFhJ9G1sYnXDl9aAcer+xagWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103112; c=relaxed/simple;
	bh=ry0kx3kENC8esVaLonHweRVq6aJ9sMvhgF+NrHgtoBQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hjldmw7eW73ROv88V6Cr6Ndr638ADsPAcNiFc43NdHgEDz44CpWh48Pt4N06mpuAJkq/J+EgYhVeakpOQNkK0SnZoUG0AkOdQd5RBPZSdommeRsWlA4WiOOle2z3rqWiy5iBBnbPUH+edKM4JNgVz5li5nAln9vC0c5/czTQ/YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kuv2jShs; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso3038000f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103109; x=1753707909; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=58/apG919MzAEhvuWxJriNjU0gqcpf1GWX4IKunwUcM=;
        b=Kuv2jShsuvl+HqdClFBeEF7lQgIymMqG8rPML8AEXOqbMEL1Q7HONpqSIsjQgWP9d1
         QDc4GrIjbi/Htfdx7tpL1g9InWXUNhFDNcsWguy41VCRzv4x1PPYw4+ba9EugYGVQSI3
         37+2QJJwIPIbMS7ILoZ8tZLkRdEeySuDxOTNAW8GLXlIDb4F4TotfdWv+MiJ65zYQ+0s
         4ZqNTTqAeyngu/RrkFeJG8Bal2UoWn0b7XfRiPC3uj0JHbtOUern7P4+qMqwRGIpXOD3
         hN/MmKxWACat+6O2O1tjGgkgTM9Y5N6jQDGV834GpJ0vvZd/nGHQROjWfS5hOkgc07/W
         X/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103109; x=1753707909;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58/apG919MzAEhvuWxJriNjU0gqcpf1GWX4IKunwUcM=;
        b=G8p+ML6i0+yR89iJgfvndulfVdXmtXRWGh8VTlBYN89qmLW7pEK4t4B+sxYbp7i5nu
         oyt+BuzM5S+kiVdDVKgutbByka3H0gL7v73vOu+Bj8hHzsBCw61/fU1bjanjmeeFsMlS
         acif6z8oXPor/FdyK4giabJTmSz986TwMKPJfE/50glKYIvum+GaxYZigm9ObO0T2LWB
         vIoYMpPA7P23jpn9gtbT8Br7l1CMlBFC1Vn6Lc62LW3cPSlxB31aTDuUVaE+RV69LLHe
         nvq/UFQ786/Pr8wrJQlB8lW472p9lWIH42WTsT6yl8/BKN495qOorCPhF1n4uh7SJ42U
         5Aww==
X-Forwarded-Encrypted: i=1; AJvYcCU+nLJiqQ6LPPiyUonHkCr2u7K/Zit0Tgb3GdqIuveUIU89Itrrm/pdoWQ4va/oZE6DsdF6LAH/sE+k8DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxijrbLRTb1fB9TBd4aBWllBiGP2IalkCsq+nL58qEmdvX4oGXR
	LpBB9yS1PPYEkfokV3VG00VHuxMfBDuQtozusUFsSwURmSR00B7CfVHuONjJroxtk5k=
X-Gm-Gg: ASbGnctgUo3GaizPvrjO8F3j7YHViwgD83XbWNwlJmEe4VQoqPV4tUu+JOnxHJ/NcSn
	OkPeOL1oJ7Lsn3FDLKDrJLIJKwyWngRply4VzxY1DMBg6ksLTdval6WkCIlgTIGsX7zHI5vOnrH
	n5b6vF66kCrbsCfhal1Hdb1dP5pUeLoopFG6LhI2lCHNvFT+TCzMth3BdA8irDwmQlJQF41N6xd
	l45cg9ImAV3h43DxE1fTgmlygJtjZoXThJawtz2R2WZA8EdaSoUrwkC3GEoIRKVTrJqy9oo/Bx+
	yCxzVXklQbc0U5H0M4BMETV1gy0uOfPCtu94W/ZO1bHsgQR8oZshM+EWB0euMGOH+aLGeQCAG1d
	3Jm2xm5fN5PqNOaN56NcKfFosh5EKgjE=
X-Google-Smtp-Source: AGHT+IEZxYSbFxrrmP7cZP+9xTts1CuqTjmAYcW5ZBGc70QshBzfW0k8oadRGMw1/lOur4xQKdph0w==
X-Received: by 2002:a05:6000:288a:b0:3b2:fe84:a10 with SMTP id ffacd0b85a97d-3b60e440dddmr14665497f8f.0.1753103108852;
        Mon, 21 Jul 2025 06:05:08 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:08 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v5 00/12] perf: arm_spe: Armv8.8 SPE features
Date: Mon, 21 Jul 2025 14:04:54 +0100
Message-Id: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPY6fmgC/33OTWrDMBAF4KsErasy+rOlrnqPEsJEGiUqrW0kY
 1KC717ZUNwS3OUbmO+9OyuUExX2crizTFMqqe9qME8H5q/YXYinUDOTIA0oIfk7flLhA+XII+F
 4KgOdKI68aXyIOthIzrH6PWSK6bbKb8ear6mMff5aiyaxXH9MtWtOggOX6CUEDa339vUjdZj75
 z5flo4VMND8D4SgLZAlbY34DSyrJrktMdLtQ7JCCALdGTFAgw+Q2qAGzD6kKtSKM3gXnQWnHiC
 9Qa0U+5CuEKCRrRYQbQx/oHmevwHl8SAc2wEAAA==
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
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Support 3 new SPE features: FEAT_SPEv1p4 filters, FEAT_SPE_EFT extended
filtering, and SPE_FEAT_FDS data source filtering. The features are
independent can be applied separately:

  * Prerequisite sysreg changes - patch 1
  * FEAT_SPEv1p4 - patches 2 - 3
  * FEAT_SPE_EFT - patch 4
  * FEAT_SPE_FDS - patches 5 - 9
  * FEAT_SPE_FDS Perf tool changes - patches 10 - 12

The first two features will work with old Perfs but a Perf change to
parse the new config4 is required for the last feature.

---
Changes in v5:
- Forgot to pickup tags from v4
- Forgot to drop test and review tags on v4 patches that were
  significantly modified
- Update commit message for data source filtering to mention inversion
- Link to v4: https://lore.kernel.org/r/20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org

Changes in v4:
- Rewrite "const u64 feat_spe_eft_bits" inline
- Invert data source filter so that it's possible to exclude all data
  sources without adding an additional 'enable filter' flag
- Add a macro in el2_setup.h to check for an SPE version
- Probe valid filter bits instead of hardcoding them
- Take in Leo's commit to expose the filter bits as it depends on the
  new filter probing
- Link to v3: https://lore.kernel.org/r/20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org

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
James Clark (11):
      arm64: sysreg: Add new PMSFCR_EL1 fields and PMSDSFR_EL1 register
      perf: arm_spe: Support FEAT_SPEv1p4 filters
      perf: arm_spe: Add support for FEAT_SPE_EFT extended filtering
      arm64/boot: Factor out a macro to check SPE version
      arm64/boot: Enable EL2 requirements for SPE_FEAT_FDS
      KVM: arm64: Add trap configs for PMSDSFR_EL1
      perf: Add perf_event_attr::config4
      perf: arm_spe: Add support for filtering on data source
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      perf tools: Add support for perf_event_attr::config4
      perf docs: arm-spe: Document new SPE filtering features

Leo Yan (1):
      perf: arm_spe: Expose event filter

 Documentation/arch/arm64/booting.rst      |  11 +++
 arch/arm64/include/asm/el2_setup.h        |  28 ++++--
 arch/arm64/include/asm/sysreg.h           |   9 --
 arch/arm64/include/asm/vncr_mapping.h     |   2 +
 arch/arm64/kvm/emulate-nested.c           |   1 +
 arch/arm64/kvm/sys_regs.c                 |   1 +
 arch/arm64/tools/sysreg                   |  13 ++-
 drivers/perf/arm_spe_pmu.c                | 148 ++++++++++++++++++++++++++----
 include/uapi/linux/perf_event.h           |   2 +
 tools/include/uapi/linux/perf_event.h     |   2 +
 tools/perf/Documentation/perf-arm-spe.txt | 104 +++++++++++++++++++--
 tools/perf/tests/parse-events.c           |  14 ++-
 tools/perf/util/parse-events.c            |  11 +++
 tools/perf/util/parse-events.h            |   1 +
 tools/perf/util/parse-events.l            |   1 +
 tools/perf/util/pmu.c                     |   8 ++
 tools/perf/util/pmu.h                     |   1 +
 17 files changed, 312 insertions(+), 45 deletions(-)
---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250312-james-perf-feat_spe_eft-66cdf4d8fe99

Best regards,
-- 
James Clark <james.clark@linaro.org>


