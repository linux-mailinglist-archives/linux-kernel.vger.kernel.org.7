Return-Path: <linux-kernel+bounces-755405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED4FB1A5E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898133A928C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCA32777F9;
	Mon,  4 Aug 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ciHaP/1e"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6E27604B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321055; cv=none; b=C+9rD6zei8GowBNuA3JRlNG2cvTl2tcjN3ztccep/yRctd6mj4MF1Od89cGLLZr+Bd4kpp9zHqQhJRJTcdKmCJsnPPSeSYEDYa4ysFdt26I3Y+2Z3j9bzMBakhUtNLjbO6K4BUTJrTjUuvCXw/mhi5MqrLprMgKfDG1E84r/r7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321055; c=relaxed/simple;
	bh=hZs4sz8oMPEiGhhqApXBtCYQcDxESo4pq1mV1+Z7Z2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQlKxEZBt5NdSGWUYQqdpmjyoci6oWEfkxu+zVXL8amEvBgn2eXRIFScMOV3BsaZNN1BIswGVtGQ8d0B4ZptE87aRzL0txY8wF8JUWW5IYxTbR0APyFgyVHURQwhasEAjvpgqvBBzhRhshff77TeaqDJImo5s90DF4MXs9bWGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ciHaP/1e; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b78310b296so2757804f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321052; x=1754925852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epJPa/pBL6IXn229DAd6lGt1WeXWNm9UUZm5IBc/kEc=;
        b=ciHaP/1ee2ApYZA1BkL5GV/UyHaoSXHEdgR1yCE4+oqJycambTOZUZddV7lRiGGNdx
         Uwn6h55WIqiPFP6t7guMY0KpEMO9spaeVYS6exot2B+KGQWIISm41355t2ItZ7TlZA1h
         aJyLSL7BFjnKLqtD8uToMJdWJVXjko1T+XtdProD9sFx1gAQmR2vO+WX0/o4QLAGe0Jh
         DsagjgtQTKWGanvS4U5tPJd59WORxV6aOkLf9uqVWKYXnCFJgoSDmoFNDGDkQi26MA7Y
         2jdcp0UKxHBRZ+WaQ+8SpHmipJs7lGfti7qdGRKK3ze2/dlAvSmQB3CwTN9CKSbLcVub
         RQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321052; x=1754925852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epJPa/pBL6IXn229DAd6lGt1WeXWNm9UUZm5IBc/kEc=;
        b=p1WkEZJ36dqRt5zc26pwfuABKxsbo3CZLq68Lu+XdYHEjmIBd8aon3YDm+rAWJUZno
         C7cxRHnvFLPE9OMgOD6uAnX+Tg2fdXXN3oLKe6o1nWjRi2jjLG2tritGvF/J9OvFqSn8
         dwcANVPjk/2leaFAkvL7yexq0x85LTzPida34s46AJEvja8NgNfDvRr04svTkREg9yyA
         LbMdvFrLxkQpmpcI0GJI25+PkspQPW0IWhGtU0I+pm4u1Pp/XzNLfTHqUMT3hSENSjg8
         KMkgSnOr3vw7vzWLBsjzDVH4eIKNKgK07qnl5bAcxMZnSkh597HV6NP2H+rIxyk4Hv6Z
         HukA==
X-Forwarded-Encrypted: i=1; AJvYcCUxw4zQwww5uoIrM6/vgkiJ9rbmNX6FN+Tf9kvKwgXTwS80zQw2Db3+d7hhLtAf5TUTO1bOkBhdLrEB3kI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1qX+YzyM29/7H0+nd1n0JdSTB1fRIbXPUQei/5X8k1StonHND
	MsaotSihgyGmh+y9fMLiI0CWmdsCahvsSkpfqygAD7v1kqAorctzlODqbWnmBPuwibE=
X-Gm-Gg: ASbGncuzuJsmB/Ux/8FBiSpqOOWoE82J82Eqa4BB6Yp2RGuc6u3pbYCppZtvsdimVBK
	gPwVA6loWtePLFk221eQk6fPZX71TJb/i07lng+s0rPsJkKD/zzpCjtAq9p0DH45fouWhn79Gm+
	MPATODGjdVKfCW+nOl0kLlUOTCx54mpr/bnfVj6TdiPyT/gB3Lpca/Lxfj5K4cme2UC8cytMPVQ
	E6chXATNP7kELdiJs5ElLOnelDk1Osoh8byRrIPmAz5DFFDe/QICsJez9pmadwA8IUGRzfV+OQD
	wEQfS/unsk+mc3di8kHcT9grVIa1Xz5fx72TIsQIOrSGOValdYbRoyvxBzGPLVapCT7xMeXVUEb
	k7MSAC44wb/b+EXlVmkq0ugWxYQzs1OHmhpxjhzLVEKci/kZ4
X-Google-Smtp-Source: AGHT+IFibEWqFegvsCz6rZMliZ7HJUvwpm/Ifdy3spX/uA3z9andkaQ/IQkKbXAJrvckO5Sf1K1pLA==
X-Received: by 2002:a05:6000:2289:b0:3b7:8d80:e382 with SMTP id ffacd0b85a97d-3b8d94698f1mr6918659f8f.4.1754321051978;
        Mon, 04 Aug 2025 08:24:11 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:24:11 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 18/20] clocksource/drivers/vf-pit: Rename the VF PIT to NXP PIT
Date: Mon,  4 Aug 2025 17:23:36 +0200
Message-ID: <20250804152344.1109310-19-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
References: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
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


