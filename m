Return-Path: <linux-kernel+bounces-680871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C42AD4B11
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 08:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48481898423
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 06:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611F622A7EB;
	Wed, 11 Jun 2025 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fac+vam4"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F1228CA9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749622459; cv=none; b=oHitVk3DsrAqJ4u0iDBZI27LjXNSxEn/2SPE9PU28DiQWPruqgEF+9IVZgb8DKsaqWwTcB/YtQGtgFLPFDRTZtL9ENWmFTp+J91CFLB4uTYCAxgzClIn9tyR0OukeP7M/aJ0modMM4ZlRCU5x1kmZD8ygyHP9GmCp902OIbI78U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749622459; c=relaxed/simple;
	bh=uGHDfIA31YKh5ahk8efaA6IVYuJLI6m+zDCouPPq644=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mo3+TXIQHTrypcLnNh7s+do98hhzW8qthYm7GZWGOGLBtwCLzHYSHlcRYA7u4R/LBe//VKRpJHmAc+32F6gk4stbDpw/ZfWN2h9h5h7mwuXbkTU2zqy24Ezu0s6sl5gVKScF+qqxojOc7P7VyHYJfXsFWL+QQwLZR6dK7UtQv9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fac+vam4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a528e301b0so26330f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 23:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749622456; x=1750227256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmGTr9Avtp+9E1jrxJpsP4+QY45B/matmjkDOASukCY=;
        b=Fac+vam4oc8RdfoM42T4WhQ9GbiEkekKkPdEux9SMdo014+A7g51g8KD2/RwaXQ+9P
         QgJ8cyMwhY1sVptE6bkMBo+eALrd1xN0DLW3jrBaelCYiFDsAlyD+RNERmWcLGHD6xp/
         kkAfMz/O9grwA6ZubNmDicyCp4VOwntnZx0B+zvWzYY7Run4YiCLNP5IAMnJymGnGJhH
         5lU1SutesNifWeSdHorE6/qH6Z0h/EbMx8goPtABL6jkL4fHqAN10mFUaAXN+8ul+58l
         rBKlL/xGsk4S/kAboIJKYVOjCfcgXpcJiWjjx8bxTl3tz8qtQpaApRt8F6gCPfbzO5Qt
         jQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749622456; x=1750227256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmGTr9Avtp+9E1jrxJpsP4+QY45B/matmjkDOASukCY=;
        b=Vj6CSVSdr0FCr20vzvDBm/fenLhU3H50JbyW2vB3oPCTBU96tp8N/SldVG13T5cs/7
         ep5LoHbZ/wAHWKcEcQ+SuiTW9iEnw48bFrRl1zTEkLdvVW5Bo7EvCislfRYu1OyyJY1V
         8W89w+J9bFlhvFhuSaA84WTN8qoOs/O62Ymcf8RlQ/1WDKzAx/5f3qEHjMrvwuS/x6mz
         KubTgUoFvkT9F64sixpwVyGwzst9p6cc5cjX8z4O6/qmE1n2UGoFmfXD0W+LeAmdY7aS
         C+9MTKT8eL39l18ACmQE93eARq44vBc8LhnoWAEORx5DxqfSQQchYms+N5DON4qsDs9X
         hApA==
X-Forwarded-Encrypted: i=1; AJvYcCUIF4zJXvHlzZisgrM3tHnfb4PazN46ORlR/ZIX5WS5urH6+IVI4YeclofFBiolfaQPyV/WOEhgwzedOgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhWOFrGhWsLWXRbReEpthJ9c4hxcDTMso4O3IX6WNtvfS4LjR
	7+e1DqeUHlpOWyMeWxGw+2NQt2iK5qUpz1LxhqCSBOuSxnsQ5hCy/GaY/cOZKqpxpdk=
X-Gm-Gg: ASbGncuNXQCyeZXSRerJQPA5he+ZS5jMFSnB/8QST8nD+iVfWYi3GQkqz9Y1jewRr99
	2eLA/V8ifux1YwgVR1iucWLCryVmjvlstRwEDx38let0iYSmE5V1HBs3GYDC7Tg2EE56BadR37t
	qUobzbU6suAMEagycdqBvLgjwv5itcuXUDrQjCUfE5zjP3HkRch+oU/aLsRlNwHR48D1iTl82pO
	AuGU8S86n/DK4oJ1Jc9KyQ0HeryZs7Hc1iZHfuZWsuBv4QfvkzsG0hHYaT2PpTTk7yK+V2yAiP/
	J3JvWsf+Fu3DPEdDuYMXjFB/Q9hylyGJH2onNIXBRUlBqJhyG5KGo8tWYN4d1wB0rAPi1s1jHSP
	o6mmXP8U=
X-Google-Smtp-Source: AGHT+IGuARTYLyF3UiF9reCUirhd/Exv3gey0a/FHP4hXPUPwwAH7XeVaLmvzmzisoq7vXGGNYY6fw==
X-Received: by 2002:a05:6000:4205:b0:3a3:7be3:d0f3 with SMTP id ffacd0b85a97d-3a558820e34mr451650f8f.14.1749622456103;
        Tue, 10 Jun 2025 23:14:16 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f516sm14142791f8f.74.2025.06.10.23.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 23:14:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 11 Jun 2025 08:13:34 +0200
Subject: [PATCH v2 02/17] pinctrl: Allow compile testing for K210, TB10X
 and ZYNQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-pinctrl-const-desc-v2-2-b11c1d650384@linaro.org>
References: <20250611-pinctrl-const-desc-v2-0-b11c1d650384@linaro.org>
In-Reply-To: <20250611-pinctrl-const-desc-v2-0-b11c1d650384@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Vladimir Zapolskiy <vz@mleia.com>, Michal Simek <michal.simek@amd.com>, 
 Emil Renner Berthing <kernel@esmil.dk>, 
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@axis.com, 
 linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=uGHDfIA31YKh5ahk8efaA6IVYuJLI6m+zDCouPPq644=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoSR6g8xxyHU0HpiCDaPmzEcUGbG3i/Yo/YG0Wn
 7rcaYbUuOCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEkeoAAKCRDBN2bmhouD
 15vZEACL9S/hnI46RCXgnSdsn6o+epweo7vg2Ve0a0tgPgDpJPr9sxin7UVOYpBd9VSMJJQoLLF
 aeqFMhIemW0RcumAWboyA4gfV7dVt4MPt/v++UUEhPUE9TwivxEkN5kMfkB1dRF4+MjSjHDuvGC
 ZPBUhFjQCXOgwCVHKydx8vmuJV0CXug08L0YllTPL8pXovkyewDPdTKqQaFhukVSfPcO9IOAgtx
 M5yXLQe29xMW0Qyyul/SVfUXoGYtMZqzVJ6W6dzSnw0YNlMlEQg2zyirVpJ5F+/OHhCzmyC/8hL
 vY3Rtcjw+MHY8cI42dcQDzeoAKALlg2/hy1crOMdKh8wSr6O6LFk7rAOTcWChL14XAoUvJpX+zd
 r0YhSuMLTab6mVHTRRgnXKL1v2XuGeY/7QwPQxo0jcTZpaoreoReVm+cJ1biQiLJhRB30IaCe1g
 tpwj/e5Occ6qRtXtGh73XlrINYyxw5OzGdzDUiTSx1Bd8fBfKqn1ojFrBZU6c0EfEOEodfM1L3V
 sIrLevCzW4HtOtGrGg1HFUXnHrJ5DdHAsk/NQrAi6Yy0jFf+hLnI1SRhJfuSoGrStvp5Z4M4RDJ
 lCsyjBjzLRgK6m8GXnTUqaoCeXd9zcxJxwOmrrtEsnEGDuREqGFpURGacr7KDtTH88JLMKCC9g1
 C5kgftvilxEQjiA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Pinctrl drivers for K210, TB10X and ZYNQ do not reference any machine
headers, thus can be compile tested for increased build coverage.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index eb1b37af81fb81175d22018cf4856bfafaea75db..9b93a11c5755d5e1b239b34d5d66d5717b281265 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -269,7 +269,8 @@ config PINCTRL_INGENIC
 
 config PINCTRL_K210
 	bool "Pinctrl driver for the Canaan Kendryte K210 SoC"
-	depends on RISCV && SOC_CANAAN_K210 && OF
+	depends on RISCV && SOC_CANAAN_K210 || COMPILE_TEST
+	depends on OF
 	select GENERIC_PINMUX_FUNCTIONS
 	select GENERIC_PINCONF
 	select GPIOLIB
@@ -554,8 +555,8 @@ config PINCTRL_SX150X
 	  - 16 bits: sx1509q, sx1506q
 
 config PINCTRL_TB10X
-	bool
-	depends on OF && ARC_PLAT_TB10X
+	bool "Pinctrl for TB10X" if COMPILE_TEST
+	depends on OF && ARC_PLAT_TB10X || COMPILE_TEST
 	select GPIOLIB
 
 config PINCTRL_TPS6594
@@ -590,7 +591,7 @@ config PINCTRL_TH1520
 
 config PINCTRL_ZYNQ
 	bool "Pinctrl driver for Xilinx Zynq"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || COMPILE_TEST
 	select PINMUX
 	select GENERIC_PINCONF
 	help

-- 
2.45.2


