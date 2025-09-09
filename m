Return-Path: <linux-kernel+bounces-808818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF5AB50519
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A794E8359
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB3435AAC9;
	Tue,  9 Sep 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKqMaMZo"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDA2F747B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757441929; cv=none; b=toDJcAqTL/fVvmNWpH9ve/5GHSY49j+vIkmUpc/NmG7lcejVuUvy9RMKTrQ1pPf2n2eC6RMfVP3BB7i78hOa8Ju1PKTjqljhbtr2yegTD2nM2dhIjLzqM/jdR/9AWubvsAlkea+GsYeZ15XxLm0w+I/Glu7yrcQkWjXCy81EoKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757441929; c=relaxed/simple;
	bh=QKAZhgwl8C9a3pJ24Kw/6R/+17cXSST9anu6lQ+Gwzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2PXBThRoMHyG//eqCcbDT1WP1kS7/o+xCSkP28Fop0k3M+YYB/UmasHYlN9iVRg1yNDdMi4s4wQldeht8o+tfr40ncTg6hQ/zxlMim5lg7sOXJEILVaEECiv77ERAA2vRrK4wmcxGYfu5aUsqrSTpLC+e2UcKZ4jyIufp8IWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MKqMaMZo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61cb4348ac4so786877a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757441925; x=1758046725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3SZVEt5zs+XMpyDtIWhZjJMWmB8ACyyA+oaZqN6VC4=;
        b=MKqMaMZoZ4d7lgtPtbwaqPCbSNjf0mpcNTmvSmH7+SUEfbKmL1inPwnYX0N0K6UxjH
         63OCD397YAu0sVz6T2S+ceGElAPL7xhuAvk80L5hmrBMl6oXNSVUZ3qZgJ9ppRa4qqp/
         OTT5IxpfBofxEm8Aa4OCziQku8nDtSJnhUElckdpYhUSy6jRyVg0THfLaM0xg1w9kj39
         rjL3mgrVSyO7lsoVqMmRzPijYg5nkdOZzqA+0Y9GPqeAbQgGUKH6+P9N86j/pcmPEoif
         r+BCjufiZznlPfDJwPSUH1Acx/HjGpeWNeC31llBxUJZPX+9AzBMMU+B6voybs0Pp9mV
         ysNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757441925; x=1758046725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3SZVEt5zs+XMpyDtIWhZjJMWmB8ACyyA+oaZqN6VC4=;
        b=OcKwA0LAhEnoizI93PqXQHNkFty4rhjJAzWwArVHl1ErYO1Ncj2CGoQPTZOLgc1Zu9
         NtsiWJTUrTLv5zNKWBQWQ42AO98NQkAAZ3hi11HGMgnMOUuH1Z9Kpf68cXWeimmMPUk3
         mRhbpj9LxdSICHU4hrX88QNRxwCkaSPCo1TB1fnKHaq5gHpXuCfpqBtyBgPXwSop9SXz
         FNdUPayXouCt7TmqkKbzE4AZlrLRoizP+kvaJcJpMkZnATIk5eNuvkl0GxFqRJBaNe5K
         rUm5a0Rhnwm4MVPEWfW0L0+RteSe9CvpHwNHqeXQ625bK7pmLyNy26S1FvB15hQD9rTt
         0vVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyra7dC9xwtOEn9J6IrsOS+f7JqAvOxDmLa3JyTuBGGny+ve2N7Cgqflgx0jTxhTq5XJ1xxdAFfCf1HUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJi8lBwSz50rFh59CaJJ6FZnMapHB9U4okd34BhI3xfh10XL50
	0kzZmOLhHZKOdJPJ4nzk9CNBnaSynjqcmvzpzVLxRm57A1eBkqiCbH6xg6x5oVX1HQk=
X-Gm-Gg: ASbGncs7dVSIMF93ggEp6C35geXMYAr4HHu+O0y+wfaqzVJXdA18CE8F62kWx4dBUaY
	6t/l6jNtDhkUaHHp9I+XVZg246+abchse7JgXOBTJWU/cGzF5WI5bRrVU+JbSQZYyZdZcIhk9Mf
	K8RiJDx/4aQoGUsPb/ORFZ0j+xQbm4mZpgbrU8X/qUqBWgI6/1q2twX3qKP7MrM8DTiKtii3Q+t
	knIZINX9HjL0fcm4ck5hrAQCLbDsB2ZMLOyrnviPy+8bcfSd7HiQjgprVwsq9ueiQ9MBmddwyqL
	7SBrx+9HI6QOpFBpVNHXyRKRC0VMXSFVBtGeifjxo8cAlFLjYTS4U9bOhfIooNjBGu6q0TCr6Tb
	JSZdqzSkqVexuknkw7ErXQvbJud01/BZmTGGkkpvN7h4k
X-Google-Smtp-Source: AGHT+IGNth9oSerkP6rAYgoEwMoe6KL9F9a2LImFw8iipYkxvb4dQmj4okAnUSdxaK0gh9AuCZGu0w==
X-Received: by 2002:a05:6402:520e:b0:61e:a890:aee6 with SMTP id 4fb4d7f45d1cf-6237a42fb5emr6064679a12.7.1757441925351;
        Tue, 09 Sep 2025 11:18:45 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018007casm1668531a12.35.2025.09.09.11.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:18:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sylwester Nawrocki <snawrocki@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] pinctrl: samsung: drivers for v6.18
Date: Tue,  9 Sep 2025 20:18:41 +0200
Message-ID: <20250909181841.102103-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=QKAZhgwl8C9a3pJ24Kw/6R/+17cXSST9anu6lQ+Gwzc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowG+BZOESL0M4KVTSYey6u54mYycQfsFUzEvyQ
 SgmbY+SFAaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMBvgQAKCRDBN2bmhouD
 13DFEACQ/DzLe8tGD51gCZ2sgoIL8ELCE3e1EmGSt7dS59c0+FRk92zaq9qdbaolAJgqy2GDO9y
 EZ2kcYxMZ/DU+ySaTAvCEJoxmTgf1sOyEEey3UI9mm1P4gxZ2UHuljxuOfWqHKD7PJJbdvQhJa3
 w00oN/TszoQ32k7fd8tK2uGpfuF74tRC8En7Cp2+DX5CEyTTeQ9URb3OUiIj5nVoVVxseFA+EtF
 IQiCrS7moxnrN9KTMEicM2PvpugJLsFwph1UL3oLWYnZYHSYC5DrY1MB6VuEBHTNrf93oct24Az
 6/1fKOgwxdc72ZRGKgM5dqV/espiu7hSsKGqxFFP21DmBqgCz9xTixDjrzAwoywL9xRHbgNVmyC
 /eH7AvrhdH4f0S5dz1kRCS9tJcs40CXOpJ4vaQ+gC/ThZtb+ySbtBhi+lIJ+5WxPQHq60llULSD
 C0mSILK1Btnuilf3BH8HIk/noRZMAWKA+U5mbROxRkyAIMcmMhqb9Ivj9dPXO3vjrRpDrZJv36g
 It+arAkoY8Ba+KaHZ9pDHbdFVsSNQNCgUwaNEHVbw+48bUeLUGcMY8UAF6+U7Vx0vlGmq2k/Yve
 Xj25uLN+NhKvc9syIAjR73z8R9QRhE2w+oSW0HztC9bD5EF3MAiQltNpzYR49mlCKqBZIEPLAaz ACETqPzn7WNXDVg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-6.18

for you to fetch changes up to d37db94b078197ec4be1cadebbfd7bf144e3c5e4:

  dt-bindings: pinctrl: samsung: Drop S3C2410 (2025-09-02 12:31:25 +0200)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v6.18

1. Add pin controller drivers for new Axis ARTPEC-8 SoC.  The SoC shares
   all main blocks, including the pin controller, with Samsung SoC, so
   same drivers and bindings are used.

2. Drop remaining support for Samsung S3C2410 SoC pin controllers.  The
   actual SoC support was removed in January 2023, so this is just
   remaining cleanup.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      pinctrl: samsung: Drop unused S3C24xx driver data
      dt-bindings: pinctrl: samsung: Drop S3C2410

SeonGu Kang (2):
      dt-bindings: pinctrl: samsung: Add compatible for ARTPEC-8 SoC
      pinctrl: samsung: Add ARTPEC-8 SoC specific configuration

 .../pinctrl/samsung,pinctrl-wakeup-interrupt.yaml  | 19 +-------
 .../bindings/pinctrl/samsung,pinctrl.yaml          |  5 +--
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     | 50 ++++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.h           | 10 +++++
 drivers/pinctrl/samsung/pinctrl-samsung.c          |  2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h          |  5 +--
 6 files changed, 65 insertions(+), 26 deletions(-)

