Return-Path: <linux-kernel+bounces-620673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A380EA9CE04
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DE61C00028
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 16:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB8619CD0B;
	Fri, 25 Apr 2025 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0y6lbGq"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE615B543
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598316; cv=none; b=mJ9GPUUobrOn/iASNaFhY+PuUYSuWY7+EVpZ8OcWf38x2lgUVXovS8PNLV8PsF+XWhaMeVOk6pccANMXrMaTLBXQBWiOGfWUHEb/WkSS+gAOicCafqtxEEDKtbkJCHGgTWx1W7Ako++EtqXb0aX32bGfyi0W+gSoutrOOmi6TnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598316; c=relaxed/simple;
	bh=diTZhcocMiW1tt8bMkaTcLnUmNjS+inVml49QG49OLw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FmdeTqSWUkkRO0VHTCClZJDIihI7aoj4/CZ+D340XNyvf6ItoU6CidnVR5bwjJ2bKeEqUiUsFcQ6fqt+yZ/+wUyoNzJzkvXivJS6Ua6iZuc72+2a87VAIMvn6qXyUi9kvQidbUCuMaFApt/UmaPaQ7mQxaVa89zzHiMIthkjOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H0y6lbGq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso11574545e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745598313; x=1746203113; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y1yIb9vlAx6eXZrDbtARLEZKJOAQuRNFkzrMMy/6d4o=;
        b=H0y6lbGqK0PoTX2/GXFhYhjAXUDGlKxv00vOGKItK0gzxTnnasFfL1m+SbZxuCvyjy
         Gf/CdChmQH84dxsp5BbG7mgqant6qUZi4rebxx9KaBmDZ1sg7733IncUgotL74JjElZ6
         MJ8E+8wcN3dKBEdHpiwk19BXZt1dRwfLbUSv1cYu+1I66tbuZlIrAzskM4XOdTdgfFkL
         nBIG4qBzn/rWA2uf8f9nU3Okl/3vkQi3tpD4w1gckswJXS08N3qXOGJTV/uFLuym0mFA
         VHJr2OPTHvO8/ScuxtiodKXHbLxMdBi8L8gUpqnPuXejUuWSvKELUe0I0uqKpoa0637w
         q0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745598313; x=1746203113;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1yIb9vlAx6eXZrDbtARLEZKJOAQuRNFkzrMMy/6d4o=;
        b=gQ6wY0oyfKB0sezUWK3Fscao5u1i+KUlixlG3dulWxFw/pPST9Rp4/sQu32VW90w/j
         VCeK+Cshf0CCDpwznR4IZvjd38RtFvtsNzwIC4tLyUtssD7t5N2UXWPNjbFlB6xr0ftz
         b59Y9Kh1xeMfTTk59dIJ6nFmdzFZ+f01Jk3aVw3tw4Y6jk/nmoVkLXZs9GGbCXC75XNY
         j0pgVNxkxqJA1i8oh7+WJXlUcue6EjM5SzC/rF1NJpNv+01snpCxDDa0QWh/fMYTNct8
         /iySVhd9gIi8pVB9PzVT0G0UOTA6u39jbZpk4/KPuY9Za9tHNoXpw3LUmgjTXk+w/mhF
         kS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgdThddvm20TOPd3u9yRvxLfv6S8PU8nPhllBQtWZZtQokjhYDi+uSLqBS1Udy5wnymhHxqrbu2CSH8t4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1qLiwgwg3pD2jGpE3JmenRFQR4QkmeIxc2z+yV4CTkcfuDasO
	RVZv7oeHm5AF0qkCpUAQJ/WUvn7AxjUbbgIsUbRiEjkjrWruUV+sFt1CgqneZIo=
X-Gm-Gg: ASbGncs+WHERYLpB7iUzJ3AhmCqT5lV7MZfhKn+Q2Rr71x36/hPLVZcGK3Vbty+cGHy
	cGdQEtayb4vXyG3dxHxnqzvfqxtuserz1jqmPn7eUoUIbBxkeiEhJb9kDA4tzl4GJSiQwq+mv0Z
	QyvEy4V+e6L+y7Jzxp020OrK9ROUBBgNgp8mTum9r9hTovyituNfw/JPZ3c7HKRgHQlL4VNjR3e
	oi2HIWGhxgGkIQsRn5CG3bCebQ8sn/yHpxdlpRhFBapX+A6ELIRR0OCNSHnuL/ITMUgu5MSVUfi
	sfRhUbcniicSWrJ5KuAyZNeW8orVZyse20JdF4nXL/KfDwiJCzY/hOFS2gbPOhaS6dVI3v08
X-Google-Smtp-Source: AGHT+IFGbF/3oKoTkhJNSQEnm844Jh4uGGPVOVNnWUuScpNORw4BsrTufYm+XeqAIsbp86SS7E0SGQ==
X-Received: by 2002:a05:600c:1e29:b0:440:6a1a:d8a0 with SMTP id 5b1f17b1804b1-440ab7827f3mr293955e9.7.1745598312604;
        Fri, 25 Apr 2025 09:25:12 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([209.198.129.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2d8976sm61263715e9.27.2025.04.25.09.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 09:25:12 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 0/5] Fix gs101 CPU hotplug support
Date: Fri, 25 Apr 2025 17:25:04 +0100
Message-Id: <20250425-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v2-0-f1530de9da42@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGC3C2gC/52NQQ6CMBBFr0K6dgxT0Aor72FY1FLKJNg2UyAaw
 t2tHMHkb97/yfubSJbJJtEWm2C7UqLgM8hTIcyovbNAfWYhS1mjxApM8DPTE6IDExcYwxynxUF
 aUrS+l6xfMNDbJlgRcFC6r019aUoU2RjZHlsWPrrMI6U58Oc4X/HX/veTU4JRslG34VoprO4Te
 c3hHNiJbt/3L161k57nAAAA
X-Change-ID: 20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-1f7ad4c45901
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3894;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=diTZhcocMiW1tt8bMkaTcLnUmNjS+inVml49QG49OLw=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBoC7dksEBKjkuUDUowN+BhMHpZceFtZmK9pBOBv
 qjxR2YRyHGJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaAu3ZAAKCRDO6LjWAjRy
 uk5gEACD1s+Y324au/PR1s0PTfS0YlTi0cPocZRyxuIYsWdK1y5Sf8I7yBMghwecoa2EfRebeKO
 MS/bJ+BrSjSOEDcF+QTgBlBdxziWT5XTO3zsPrOzuIb5JkAxSB17bgkHE804iWGClr8cSCkkgyw
 OiHbuLDTwtw3bLhmdLpTehe+AHQneMInLoQ1Cgh6MHRuTbOMSJC7aE0i5KyKVGeouQ17tSDGVPh
 v6b+lXmMw3JWx1rgCTYeMR3qXhdEZGupa3oWCA8o+HdrGBSqD8JHXUR4hjJbbppoRO2CX27DXqZ
 WjhDN3F4rFkAGK3XOoc6dMgLrxlKSPBPsp2i2yA42/i+i5nfCmt7YkLncu//PD2bG+n3I3HvM7U
 BeAwEyZDg7jNSeaCLgyVsMTbLHQ5LwqlQ4y0AphuG9sNAgmqjsgRT64YgrOAEQqa3DrX6XYGPpk
 0n79FJolcZjM7asBGGS2zAL9rjncZDyJMsZC7DkOGQz/iYXUdSy+/QNSjLN5Rz9bPOBerkysdjf
 YB25WkitwBya4wErXK1X58MyYZbH3ONbcYI0vuFFU3Eg4Qr38aNhcZ/voRs87D0Cf9kVYOLV12T
 GddZJMSeMZnbFlkVmG3l9gq40fQroIEG50VAJxMq6BHDgdEB0TQLlljEFeZTZXvNmOrb66F4vAr
 J+zJ+crBbQPI3BA==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Hi folks,

As part of an effort to make suspend to RAM functional upstream on
Pixel 6 I noticed that CPU hotplug leads to a system hang.

After debugging and comparing with downstream drivers it became clear
that some extra register writes are required to make CPU hotplug
functional on these older devices which use a el3mon firmware.

This series adds support for that programming the CPU_INFORM register
hint required by the firmware and also adds support for the pmu-intr-gen
register region which is now modelled as it's own syscon. With these
changes CPU hotplug is now functional.

It can be tested with commands such as

echo 0 > /sys/devices/system/cpu/cpu6/online
echo 1 > /sys/devices/system/cpu/cpu6/online
[   15.880597][    T0] Detected PIPT I-cache on CPU6
[   15.880638][    T0] GICv3: CPU6: found redistributor 600 region 0:0x0000000010500000
[   15.880685][    T0] CPU6: Booted secondary processor 0x0000000600 [0x411fd440]

This would (prior to this series) hang the system.

As more of a stress test, I ran a script hotplugging CPUs 1 to 7 in a
loop 200 times which also completed suucessfully. In addition using the
recent fuel gauge series from Thomas we can also verify that the power
reduces once the CPU's are offlined.

Note 1: It is highly likely that similar changes are required for other
Exynos based SoCs using el3mon. For anyone following along who is
accustomed to looking at downstream Exynos based drivers this replaces
register writes defined in

drivers/soc/<google|samsung>/cal-if/<socname>/flexpmu_cal_cpu_<socname>.h

Which are used by files in the cal-if folder and exynos-cpupm.c driver.

For the moment I've used the GS101 CPU inform register offsets directly
but these can be moved to driver data once we've established other SoCs
benefit from this.

Note 2: To ensure older DTs which don't specify google,pmu-intr-gen-syscon
phandle still work. The driver only issues a warning if the syscon can't
be obtained, and the behaviour remains the same as today (system boots, but
CPU hotplug will not be functional).

Note 3: I've added the bindings doc google,gs101-pmu-intr-gen.yaml in a new
google folder as it seemed odd to have it in the soc/samsung directory, but
it's likely this may be re-used by other Exynos SoCs that use APM/ACPM.

kind regards,

Peter

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes in v2:
* Use BIT macro (Kryzstof)
* Use gs101_ prefix for cpuhp functions (Kryzstof)
* Model pmu-intr-gen SFR region as it's own syscon (Kryzstof)
* Use regmap_update_bits() API (Kryzstof)
* Program hint on current processor (Peter)
- Link to v1: https://lore.kernel.org/r/20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v1-0-c72978f63713@linaro.org

---
Peter Griffin (5):
      dt-bindings: soc: google: Add gs101-pmu-intr-gen binding documentation
      dt-bindings: soc: samsung: exynos-pmu: gs101: add google,pmu-intr-gen phandle
      MAINTAINERS: Add google,gs101-pmu-intr-gen.yaml binding file
      arm64: dts: exynos: gs101: add pmu-intr-gen syscon node
      soc: samsung: exynos-pmu: enable CPU hotplug support for gs101

 .../soc/google/google,gs101-pmu-intr-gen.yaml      | 35 ++++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           | 15 ++++
 MAINTAINERS                                        |  1 +
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  6 ++
 drivers/soc/samsung/exynos-pmu.c                   | 80 +++++++++++++++++++++-
 drivers/soc/samsung/exynos-pmu.h                   |  1 +
 include/linux/soc/samsung/exynos-regs-pmu.h        | 11 +++
 7 files changed, 148 insertions(+), 1 deletion(-)
---
base-commit: 393d0c54cae31317deaa9043320c5fd9454deabc
change-id: 20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-1f7ad4c45901

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>


