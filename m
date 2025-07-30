Return-Path: <linux-kernel+bounces-750378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B2B15A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A7E18C16AE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404CE29AB18;
	Wed, 30 Jul 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hrq6dJem"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410629A322
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864121; cv=none; b=f2Dq7RrU+D+wiE6APuhQ2RSQ31seh4T5Nt91doQSHFw0v+vgVx4fcm0iFUfVkGUI5LnymcKbmNWKQ3RrsH7PkKg4Oncs9Nti0X4w8YgaKeP0nMcCS2XE0n6Gn5KU/wH0i+eKtzhSkLfiVQ7wI6I+QT2Z3uuPDcpzsQqYVTvaWdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864121; c=relaxed/simple;
	bh=hZs4sz8oMPEiGhhqApXBtCYQcDxESo4pq1mV1+Z7Z2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMWLfCzHQccMSUT9qArfCgsBqMtBpAUbsF5BnHpEf/ulJ3BsjvZ2hhRSWqSLvDu4CfXJor5KzDDKXA9XgYKM4jqF9u4DcXSF1tRfzH3nsvUCbi9QN65Jjpuq76QMsg+2wDJLpGMrZiI4JDQFXlquTPxA4qkNgX2NoN7BNrOkEh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hrq6dJem; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b794a013bcso1236563f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864117; x=1754468917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epJPa/pBL6IXn229DAd6lGt1WeXWNm9UUZm5IBc/kEc=;
        b=Hrq6dJemGhJ/4LkAhIuLAOzaSgRwTfV3mGeWbRd/UBQqCnZF/3h9/ljYLWDul6vhqn
         zqEXEdMeyrmi0e5llz7IatssXnWHTJ0tsXyaSEZenp3qjI8Y5aqVYUyTpXb5g33H5fJL
         7Hn+TVYySv+QRf/bOta0Imv15ZB8VUs6i4nnnr5rF/Ch/5npqyeQlmt4MJcnBDYDnYPG
         pBBXv+hcnxkX/u9dCYr6UQU8P0xaJnR+bybhIWXcstPkD9tXUm6k2Kc2S9RTR37LVDA6
         EWra4WvNgzD5fucwF7EYmxyoG3Vt+lHwy/SgYxZHDFhjvqNgZQqSzpgnYtdAmLJnL3+0
         4O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864117; x=1754468917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epJPa/pBL6IXn229DAd6lGt1WeXWNm9UUZm5IBc/kEc=;
        b=BTL+oI7AbLxZ7dR8y5MAETXesFk9O60Zj7PNqXinzTlVPIV391FeLrjIFkfPQ9iQTr
         iJR9Pa//2+UL+AePNCXLGWhXjkBuQ4LsXLblJs2P287NpqB69/5ozvgbmaCT+stiiP6c
         Ip1CEhIFcdliEkyGdkItsjNiD8cixLTscJLN4HDPhVfdLwMT+6mz9TvFasrBgTVn0Fco
         D2oKTDk1FUiFkk+shNRkFleP4Be++13J0tLOd0EhyvX7sRqZUZcQUv1s+hGn9YuZVdfc
         9/+a4pZR0IAvcpHOLNgjpVCPgFaf5ZmZy2bgj6uzrI/Et1azWVBCVK6R+zhdlJMN1mgQ
         Yb1g==
X-Forwarded-Encrypted: i=1; AJvYcCVEzM2Zo3Iuud/xVlvPdDquyMj5RGiR4LGuwkNoe49UvJl6qT08xJ/XX3n8d9dzNBNgwvm7eRCG5BdshA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRpKJ1gfOifPj3u7LmPMZESXKuAHJSwJXj20hBQ6FGpH+fyhh7
	O6SNPiRMPxOZe6djk14EzrHHnVMKPYwfuR55twKcjbC2M0e5i0s9RzUx/SynyuJ0syU=
X-Gm-Gg: ASbGncspPw0BgXqcu/AuVBRE6HzJCcR1BOFAXFftgArjotzQsMZgRhGJaUjB64emU6z
	olAMFAAve26LepeoWca67QIfM6HYVK0/bO9EhA7F9FJAF8Tz++Si4deo6lm5wBL7O1KYjE4x9VU
	RKBY3xeIrvOlkY1+nLQWH3/nyKbHu9/+/1qZFe040iRC2Ps5x48JP/s+RARVD7Gj6g6rMqDoyJl
	0spRLg5h8au59iBh97AV9FKRPLnsjHcYZUyaNSVuU7Vfj4wRQmCn8Y4jQRA5g0ApaWGrEipg6gL
	V7yVbFPgNaVjxXDSx2Ek0wPrILWc7+XU0TAOK3oi3lAui1bVQWpbAj3aXu5ZvOClLWXwguBRQ3U
	IzfutUtoVERjPPBJ31uGtG9Om7M68zu0/kgV4+qn19m/akkQi
X-Google-Smtp-Source: AGHT+IFBLGIQIl6Q8ttmrOIfu5mAMjwT7XmQSD1RlgF5BHqKwSKmhIkEKJAmG3IEbqFUQV4xOrX6/w==
X-Received: by 2002:a5d:584b:0:b0:3b7:8338:d219 with SMTP id ffacd0b85a97d-3b794fc1abbmr1966026f8f.3.1753864116848;
        Wed, 30 Jul 2025 01:28:36 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:36 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 18/20] clocksource/drivers/vf-pit: Rename the VF PIT to NXP PIT
Date: Wed, 30 Jul 2025 10:27:20 +0200
Message-ID: <20250730082725.183133-19-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730082725.183133-1-daniel.lezcano@linaro.org>
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PIT acronym stands for Periodic Interrupt Timer which is found on
different NXP platforms not only on the Vybrid Family. Change the name
to be more generic for the NXP platforms in general. That will be
consistent with the NXP STM driver naming convention.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig                             | 9 ++++++---
 drivers/clocksource/Makefile                            | 2 +-
 drivers/clocksource/{timer-vf-pit.c => timer-nxp-pit.c} | 0
 3 files changed, 7 insertions(+), 4 deletions(-)
 rename drivers/clocksource/{timer-vf-pit.c => timer-nxp-pit.c} (100%)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 6f7d371904df..0fd662f67d29 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -474,11 +474,14 @@ config FSL_FTM_TIMER
 	help
 	  Support for Freescale FlexTimer Module (FTM) timer.
 
-config VF_PIT_TIMER
-	bool "Vybrid Family Programmable timer" if COMPILE_TEST
+config NXP_PIT_TIMER
+	bool "NXP Periodic Interrupt Timer" if COMPILE_TEST
 	select CLKSRC_MMIO
 	help
-	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.
+	  Support for Periodic Interrupt Timer on Freescale / NXP
+	  SoCs. This periodic timer is found on the Vybrid Family and
+	  the Automotive S32G2/3 platforms. It contains 4 channels
+	  where two can be coupled to form a 64 bits channel.
 
 config SYS_SUPPORTS_SH_CMT
 	bool
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 205bf3b0a8f3..77a0f08eb43b 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -49,7 +49,7 @@ obj-$(CONFIG_CLKSRC_LPC32XX)	+= timer-lpc32xx.o
 obj-$(CONFIG_CLKSRC_MPS2)	+= mps2-timer.o
 obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+= samsung_pwm_timer.o
 obj-$(CONFIG_FSL_FTM_TIMER)	+= timer-fsl-ftm.o
-obj-$(CONFIG_VF_PIT_TIMER)	+= timer-vf-pit.o
+obj-$(CONFIG_NXP_PIT_TIMER)	+= timer-nxp-pit.o
 obj-$(CONFIG_CLKSRC_QCOM)	+= timer-qcom.o
 obj-$(CONFIG_MTK_TIMER)		+= timer-mediatek.o
 obj-$(CONFIG_MTK_CPUX_TIMER)	+= timer-mediatek-cpux.o
diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-nxp-pit.c
similarity index 100%
rename from drivers/clocksource/timer-vf-pit.c
rename to drivers/clocksource/timer-nxp-pit.c
-- 
2.43.0


