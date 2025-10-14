Return-Path: <linux-kernel+bounces-852910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 200C4BDA37E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02E5B500453
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D322BEFF3;
	Tue, 14 Oct 2025 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHCLoTVd"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBAA296BBC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454261; cv=none; b=adJbdqxVeaR+mk9TC8AOdKnXZSHZDoifEtSYJb4Bkax1CCPiNnW1tWDyshs/z9ALqcx5PkNmS9V9Hmk5l+L97yZYo1V+RvjD9VgV3fmiHTuz1BXytZc5LZAecnej9BdY0d98CKXuUK/ajTE58cLnMunrJhVqgxs7iQesjAnrb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454261; c=relaxed/simple;
	bh=+LAKu174f1xhSbC2VdiHkWIZYXz3wYKQPJAQC4FzNig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iBB5rME9Avzskvb26q4fe7n54R4X3T8XC9dar8+2aY5z/bf3Drs/xnaYitjo8y2W3Fh0JgDje/44K7ZiFIN/mmz7nNhyFtVSW1Rhvb33ioGgZbHg6dPEPdIu2uhEIp+0Z9dJHYJOLjiIn7Rl01HLS+VC7m1m2mMPskSvs1CAZ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHCLoTVd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-330b4739538so5152799a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454259; x=1761059059; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8imCO2VyYcb1j5phQLrLVVRIepCgCLAAPrEPMDTG34Y=;
        b=lHCLoTVdBmP/TO9m1TKUnVzTHfBsiPw6R/UGBzrvBugpVKaAH6DxiIyMHfwqyYSScj
         RENIadvNptvD5j+LUv0TKPpuX8U7uYlPcDVkrYTIPh3uX2nUnGfvHIw1JUQxoj9EcugM
         JRznVuI/G7SqtKPDgyxXKFXSsmgqtAYdvNfuEu1iBKZaBf5beolovMeAGmQaJ2Jlb7uX
         J5TEuOrEQqEqjAHFw4slvVchzQOKTGCnNOacYR3RXF9ZihkfYq+GfF0iq23/7rI5jM4d
         b4w36ln2WfOv4ekk/rlr/rvuz5L0eyuLgE+tlra+qdMPR50O/CEfPfIgVcN2GPhXyynx
         tqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454259; x=1761059059;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8imCO2VyYcb1j5phQLrLVVRIepCgCLAAPrEPMDTG34Y=;
        b=Q8e7nb+qHDINjLGP/5N1oLFC2E+da0IL/pFt3MHFhD/cKxROZMaLqAlgeNBikFNxJs
         tUZJq6hDmhRohlJg0oY49osOJ+DOkoHbsRWd0ULiPgaMRCMl1Jwiy4YTKAojubeNrOQu
         EQfuwBiggWTrDLvDrnxI/UNOD7brVhEwZzudubt1cRY+B6yS/d7fKiUHw6o8VqTlS35d
         cUcsbcLRMrCbjmIl4ezLVytE+rNOsqx3QxgbnXm88ykfSNej4fouEngucvc2MjZa27Xy
         hI8fZfnV+pO3jM1eMHQwwpKFf85FcUwrat4nlXY0AigCm8v/ckULw43fWGfTbUg959OG
         F4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiBLQ0vyHgnK2UvOOAlz0suCXJ9Y9mu5miz5o+TKEv0Igu8pd0bIqI9m2x/UnuKtvrcbd5OuCpMxHZpwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKhDojg8U/2y1qIfSEvDPAmdERjW2/sWq1/EVbssSXgCc+vQx
	QYZ/ZJ2fW8+LTolqNJSBlRbx8tsAvNjAYjm/PMngNcm+xF3b+T+cJK+r
X-Gm-Gg: ASbGnct++L4fKpuTFMhC+PondFR7/mHPIL+RlaxbmJPvoHLFo6DQM2eWBuTfWcGgaFT
	FTVvzaxBUaRqNIRMVQtQNaqFwANoHtoCx+VkcS8H0xzM1ahE5TwAxKMFLPqIS+IwBdhRfwlC8aG
	X3jAvO28URYQkNZ8ExNBUat7wY34L2oztM8H9coRzKxu8Rb02smXeulBzUr2BUIkc+5tXophdi4
	MqCbwvdsxlnjP0BV24WUlnyxVG3T7y5ZX59njFwqsS/WBTXZ22sHakTTFFczghNbiRhdmJ9Q6sM
	dXY2lyQj8oZYuNge5X+q/Ky+DQ4HsW8AI6NrUKTW9YiRYAXdjCUZPlUBP26fPy27cpUpwcs0A5b
	3PCSDP1MjpBgCd2SSa0+VMThmKlb+cEqkPdBAqr411M42ukOvT6OVeg==
X-Google-Smtp-Source: AGHT+IE+ErcXbwTZcmHrpt9vXdMDhxxBi8n4fGgsjBr4Oe2R65kjMNzjkJiv6etQPJqpr8mgUcHrpg==
X-Received: by 2002:a17:90b:4fcc:b0:33b:6612:67ee with SMTP id 98e67ed59e1d1-33b6612716fmr19725254a91.26.1760454259092;
        Tue, 14 Oct 2025 08:04:19 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:04:18 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH RESEND v8 00/21] drivers/perf: apple_m1: Add Apple A7-A11,
 T2 SoC support
Date: Tue, 14 Oct 2025 23:02:33 +0800
Message-Id: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4373; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=+LAKu174f1xhSbC2VdiHkWIZYXz3wYKQPJAQC4FzNig=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZpudLIC0ztBCR7veCzHpSumy3IXrkXmK+WF
 shTYDMipyeJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5maQAKCRABygi3psUI
 JBpbD/9zBv/huVKZJ8IpyeFgjJjZmiHx/3KJRuMcQFwhivibfox60KC8x+1heW/D3HwX4LW/Czj
 xQugtm39kAArMmFQc+zz+yKSM+HdmHS5ay3cgBiL/MZngarp6b2NtWJkPrbTrphEMWpJGRGFKNy
 H7k8Pq09SArzR2ByrdW5JsZeg3Y1t9LFozaTKcS5TxxjN2/14UGlH72Cdi2t4m90ejluBVqJAWm
 llDdiqoz42+8ws6PE5JIW9/oo3J5MbE82arkjAwoVSnamu6uG4OM3zdrYRFk3e6VLrgx5PxVlIq
 EKf2LP/Ei9QKvoF2Eg458VIOTHWeXeqrcIwlFl6Xnc7Ohq7SKVe+Sif2xRrHDsV4fDKsagSL93B
 XTGEdpjbFus7FPdei2OZWjr5CK8d22frrttrMPd52UBR7Ln0C83jI9oJpwKpYIm9grGe/Lvy5h5
 CqPcKEOiI/qoGK5jR63J61ZRgEtnHxbGXvtSY831JqpndFQbeBnfbAjvA7N/dG4BWbxn7Rzj+lT
 sy/eQB1W12OfV/bW3Kt7PLCHGF+42BGc2/Xt07HFVpPQLriHeWlF0AbhCPp+HOLnwzKSET8JSZF
 0gu5+lTvn/Wo2B9JazUvGpS0FMpQVizhOoBtWdNceYsYcGQRuhxL1IEFS1AIxI4mw/0Y8OQtoc2
 QyxW5EWmFHVV3WQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

This series adds support for the CPU PMU in the older Apple A7-A11, T2
SoCs. These PMUs may have a different event layout, less counters, or
deliver their interrupts via IRQ instead of a FIQ. Since some of those
older SoCs support 32-bit EL0, counting for 32-bit EL0 also need to
be enabled by the driver where applicable.

Patch 1 adds the DT bindings.
Patch 2-7 prepares the driver to allow adding support for those
older SoCs.
Patch 8-12 adds support for the older SoCs.
Patch 13-21 are the DT changes.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v8:
- Rebased on top of v6.17-rc1
- Collect Ivaylo's Tested-by
- Drop #define PMCR1_COUNT_A64_EL3_0_7
- Reword reason to not initialize PMUv3 remap in EL1
- Link to v7: https://lore.kernel.org/r/20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com

Changes in v7:
- Fix a W=1 compile warning in apple_pmu_get_event_idx() as appearently using GENMASK()
in a function prototype causes a warning in GCC.
- Link to v6: https://lore.kernel.org/r/20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com

Changes in v6:
- Rebased on top of v6.15-rc1 (Conflict with FEAT_PMUv3 support for KVM on Apple Hardware)
- Add patch to skip initialization of PMUv3 remap in EL1 even though not strictly needed
- Include DT patches
- Link to v5: https://lore.kernel.org/r/20250228-apple-cpmu-v5-0-9e124cd28ed4@gmail.com

Changes in v5:
- Slightly change "drivers/perf: apple_m1: Add Apple A11 Support", to keep things in
chronological order.
- Link to v4: https://lore.kernel.org/r/20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com

Changes in v4:
- Support per-implementation event attr group
- Fix Apple A7 event attr groups
- Link to v3: https://lore.kernel.org/r/20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com

Changes in v3:
- Configure PMC8 and PMC9 for 32-bit EL0
- Remove redundant _common suffix from shared functions
- Link to v2: https://lore.kernel.org/r/20250213-apple-cpmu-v2-0-87b361932e88@gmail.com

Changes in v2:
- Remove unused flags parameter from apple_pmu_init_common()
- Link to v1: https://lore.kernel.org/r/20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com

---
Nick Chan (21):
      dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU PMU compatibles
      drivers/perf: apple_m1: Only init PMUv3 remap when EL2 is available
      drivers/perf: apple_m1: Support per-implementation event tables
      drivers/perf: apple_m1: Support a per-implementation number of counters
      drivers/perf: apple_m1: Support configuring counters for 32-bit EL0
      drivers/perf: apple_m1: Support per-implementation PMU startup
      drivers/perf: apple_m1: Support per-implementation event attr group
      drivers/perf: apple_m1: Add Apple A7 support
      drivers/perf: apple_m1: Add Apple A8/A8X support
      drivers/perf: apple_m1: Add A9/A9X support
      drivers/perf: apple_m1: Add Apple A10/A10X/T2 Support
      drivers/perf: apple_m1: Add Apple A11 Support
      arm64: dts: apple: s5l8960x: Add CPU PMU nodes
      arm64: dts: apple: t7000: Add CPU PMU nodes
      arm64: dts: apple: t7001: Add CPU PMU nodes
      arm64: dts: apple: s800-0-3: Add CPU PMU nodes
      arm64: dts: apple: s8001: Add CPU PMU nodes
      arm64: dts: apple: t8010: Add CPU PMU nodes
      arm64: dts: apple: t8011: Add CPU PMU nodes
      arm64: dts: apple: t8012: Add CPU PMU nodes
      arm64: dts: apple: t8015: Add CPU PMU nodes

 Documentation/devicetree/bindings/arm/pmu.yaml |   6 +
 arch/arm64/boot/dts/apple/s5l8960x.dtsi        |   8 +
 arch/arm64/boot/dts/apple/s800-0-3.dtsi        |   8 +
 arch/arm64/boot/dts/apple/s8001.dtsi           |   8 +
 arch/arm64/boot/dts/apple/t7000.dtsi           |   8 +
 arch/arm64/boot/dts/apple/t7001.dtsi           |   9 +
 arch/arm64/boot/dts/apple/t8010.dtsi           |   8 +
 arch/arm64/boot/dts/apple/t8011.dtsi           |   9 +
 arch/arm64/boot/dts/apple/t8012.dtsi           |   8 +
 arch/arm64/boot/dts/apple/t8015.dtsi           |  24 +
 arch/arm64/include/asm/apple_m1_pmu.h          |   2 +
 drivers/perf/apple_m1_cpu_pmu.c                | 807 +++++++++++++++++++++++--
 12 files changed, 870 insertions(+), 35 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250211-apple-cpmu-5a5a3da39483

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


