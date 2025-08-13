Return-Path: <linux-kernel+bounces-766929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED18B24CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916961897F23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CAD2F6593;
	Wed, 13 Aug 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o19woiQF"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A52F6576
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097306; cv=none; b=kx1Mbesx1tmMcwHzSw44RWUGDFq95QASiHP+iV+iaebYuRSN+opC/hdz0xEIrB+7CqAG0b/JcJ4qKkQnZ3GTcil/nsI3CEvQntSVX0HFC05mS/HIvV0pX5ns7zhlv8gdt98qhBWUIGBG7L837tALH2tOqFZdcI6YaJh3hmJTQ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097306; c=relaxed/simple;
	bh=W5C4Jb/87TEkHjxZzTAhHGOUm7nNwtwZIRnVcZUesz4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dp+0haqy5dJUnlC4BtU/nNgzk7uaoDbWZZ6d+hkWDBOXOPPLUR0WIYPmUZ6jMdZVpn98tpnbr9L6gr/kNd1hz0tgFkRswR4z3Cq/1X4PGWC08NjjfZjFgLfmURJ8tc1pZIq/iGtySiq3UDR/onTRE4h1yhcZDm7iV13dnN2BneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o19woiQF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b783ea502eso742461f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755097303; x=1755702103; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZjYg8bYZKeQRQQcTg3Cp0VfZeqh6q0mPFPEWR4Ir4Y=;
        b=o19woiQFJH5/yTf8WTZL16j5a8s5PIZOy1EhRpFHlVcrU7XzeVCB+vejDU2fdG9B5o
         Wce+ZRMwNoOmPcHZQo+G0/c4kbF5sWzLG06yk4lxET6FeuRY9Dxt+fqR2vWCTooCWfAF
         7t7xHiLzycLo6ZKZnG/KT6HBc/lzj2jMhN6Uai+MtjCfn+BklgMeEYU+1mhz3A4dYIGC
         iZdfD0O+QiAMeZSVhsQOFbeuQVfKCvRYvPR6Y3PDr5GH9lrLPuRAFMz+wpetnS23mA9H
         Q9qLfNZSf/NHzRMZ+7zOhPI5+GSRyYGS4SEu5+qNPvQ2aUY4RDLUpvzIOnyAqTgP4N4z
         Gi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097303; x=1755702103;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZjYg8bYZKeQRQQcTg3Cp0VfZeqh6q0mPFPEWR4Ir4Y=;
        b=I5vkQqJl3RHYMC/Kdea+cqeL7DCDTZwFeb7oYeFsP1+yccdWCNMaCI/1NFfGiTOOGR
         l0gX3cGKgnTtUINHZBDmfkPWfU9uEqJ3xJxRsCvsEH4TfX7MerS4YkDG1P0k0h4Z0QRz
         a4HZ7g9LV0ecg+E2ERKbE+HHo3jDqiPs9kP3IGSaS8gKKDuvNij8naesdUkYFhuBqBlf
         4SwcyeiufB9Kocc5Qd02DeF61KCLEySRHF8xDN1Zcxz4w4Ashw+U+lxCgijXWnhzdNZe
         EvJqDA46O69pf9OdOhv+AsOsEy9oKVW+Z3oS97QA7EsAAaRv3dJM6Xf81SebyzcFrHJA
         RcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVih6aqKW4gkg6vqVCWXrpIDndNtP8+LO3n0+9tINKtkPgW6TMwEilFg+gjdBNaDWfFsodifREqMOSuKk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6slW9Fm3ujeSudgSCmAxoVCLkoJ4sGYQSzFrsTraPQouypIS2
	OWD+2+XCtVoY2Sa8rFUgsNCJ7iNJMGMRqxf+1PlmXH0h5d+xPWaye2CzLNCAeZ8iqD0=
X-Gm-Gg: ASbGncvELhS3/h/O4QklNnmK2KBJ3xthWhrV2kwInacjegLtzntoJBltxCpogb2j9/Q
	qdxN5K+iO7P3zZolYhyVn0H2Eb5yTCaT2ILKScMkvDNvIfe33yn3oSr7JDcIJbT2qSo2UQEBSYD
	99Sp+Rlrh+SMYTHtkmjDX3ED3b5y0Yktunap5BrHib7OPHV1kIy8XdodeymvXLc4agEkEJxoWWM
	IdsaIoRcBDy865nZx1folCmYgHZjrMtTpk95B2b6dBNjYINTc2MpdRPRRC+0gjQeOKSgwUFY8sA
	7dB+cmSgKaw/CHHk8qczYkuhrzSLKSuqvid7hfcCAR5VtPBlqEGLItz0cREsEKLvIS5fmny4GQ1
	EZEq1nZEfzdlWR9DlzyNbAjXGTMNZZ2RHAp/L0X+qS799s6oVGGt1
X-Google-Smtp-Source: AGHT+IHGvynWNGnvSA7OYlBBf/7gl/Nh7E2z9kJEbRhnGw3Vbg8mnkSNWKEci8XTra92+d3/1Aer7w==
X-Received: by 2002:a5d:64e8:0:b0:3b8:de54:6e64 with SMTP id ffacd0b85a97d-3b918cf9b79mr2657354f8f.26.1755097302446;
        Wed, 13 Aug 2025 08:01:42 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([145.224.66.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533f1sm48402964f8f.42.2025.08.13.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:01:41 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v3 0/2] Add new phy_notify_state() api
Date: Wed, 13 Aug 2025 16:00:45 +0100
Message-Id: <20250813-phy-notify-pmstate-v3-0-3bda59055dd3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ2onGgC/3WOzQqDMBCEX0Vy7spmY/zpqe9RerA20YU2kSRIR
 Xz3qtBDDz1+A/PNLCKawCaKc7aIYCaO7N0G6pSJbmhdb4AfGwtC0lihgnGYwfnEdobxFVObDFi
 ke6t1TbbUYiuOwVh+H9LrbeOBY/JhPjYmuae7rpCIRCi11rlSiqSqgWA0yYS8D2wtu8uTXRt87
 kMvdtFE3/LfLxMBgu1k2WChGimrH8e6rh8u7y8B8gAAAA==
X-Change-ID: 20250703-phy-notify-pmstate-f02ba5582f65
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 kernel-team@android.com, William Mcvicker <willmcvicker@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, neil.armstrong@linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=W5C4Jb/87TEkHjxZzTAhHGOUm7nNwtwZIRnVcZUesz4=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBonKjT7hPpRY5qXZZedoet2Il5XVhKZC/pOtbKi
 +0CtwW2VqqJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaJyo0wAKCRDO6LjWAjRy
 ut5TD/0TOzju4DzjH2y3pvzRzJijBdv5apB8VHPYifqqj7MLn86Izngf41KZwGwKbazWnZUQsbO
 1EnJFS0eECeObLYmtsuyAvCeTZpzp76buX55s0arQgnrFia742gUzSFLTMckgDZ2kQe7ZfdcB/7
 mVi9suq05k1eFJPKUQJoYbj2L5i7akr6TBQIeZ1XqJnp2OOFr009CI7pRF35hRcQrx4x3TmG5+z
 d4Qwz92t5VIRUB5dJqSJjplMQOthKYpdfc0SdwnGWgJtRtTDvyQdxUprh1rlWzdtbZPhnkFt4pW
 Dd00kxzySCvu8neFuSdVAsC0tSfQXN/eQrTToqzxuWtv8ZCt7zehCBKZbuQOZHMtvYHR3EqmSYZ
 oKn4GhUnCWUWXw/TZ9OAXM1VppLz+XqjeTgHaL/Bj7ewnO1jEe0UaTpa6I9KRHwXjHpiLmqBAG3
 5Bt0FU6QTDoPKejfGLE0nUgNb+5glAK/GASaA/lnyoHYz0fYWIa297yHH08FwXrzf8F7fGcMiui
 jGATUZDHuI6qi2yQ2bgjT7f0OvjDDNWnFEXKjkZfs7uvy2m3N2g6lkmntTC9weJ0WGnCJrtgrRA
 dTbHzxY0pC+tAMc8nkWDbxryoEHc7AqGCwt8o1NUMY4ZPoEquzQHAsq1vHQTuwQXSdm6p79g2ed
 rioz0wrkgrHVGQQ==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

This series adds a new phy_notify_state() API to the phy subsystem. It is
designed to be used when some specific runtime configuration parameters
need to be changed when transitioning to the desired state which can't be
handled by phy_calibrate()or phy_power_{on|off}().

The first user of the new API is phy-samsung-ufs and phy-gs101-ufs which
need to issue some register writes when entering and exiting the hibern8
link state.

A separate patch will be sent for ufs-exynos driver to make use of this new
API in the hibern8 callbacks.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes in v3:
- Rename API to phy_notify_state(). (Mani/Neil)
- Remove inline kerneldoc comment (Mani)
- s/phy/PHY (Mani)
- peripheral specific enums in phy.h (Vinod)

- Link to v2: https://lore.kernel.org/r/20250703-phy-notify-pmstate-v2-0-fc1690439117@linaro.org

Changes in v2:
- Add new phy_notify_pmstate API() instead of using phy_set_mode() (Vinod)
- Link to v1: https://lore.kernel.org/r/20241002201555.3332138-1-peter.griffin@linaro.org

---
Peter Griffin (2):
      phy: add new phy_notify_state() api
      phy: samsung: gs101-ufs: Add .notify_phystate() & hibern8 enter/exit values

 drivers/phy/phy-core.c                | 25 +++++++++++++++++++++++
 drivers/phy/samsung/phy-gs101-ufs.c   | 28 ++++++++++++++++++++++++++
 drivers/phy/samsung/phy-samsung-ufs.c | 38 +++++++++++++++++++++++++++++++++++
 drivers/phy/samsung/phy-samsung-ufs.h |  7 +++++++
 include/linux/phy/phy.h               | 19 ++++++++++++++++++
 5 files changed, 117 insertions(+)
---
base-commit: 43c3c17f0c805882d1b48818b1085747a68c80ec
change-id: 20250703-phy-notify-pmstate-f02ba5582f65

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>


