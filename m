Return-Path: <linux-kernel+bounces-889279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21532C3D249
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93654188DCA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27E86353;
	Thu,  6 Nov 2025 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="endXWJF9"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C033291D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456091; cv=none; b=cEX/KMjdWnxqYKuO8uavVqP4AL+qTPHP9AKvOL8NDI/oMttN8bWs0LZcB1xxpxtBI7d7EmLgRmWOArUn0cmrspLUPfaCIGObFAO8ySgUV5SG7jr4lZI7dgsuhetAMeKInnc8BTxKGMoEAHicfAacTH2+Iy76J4nH372Ag2dCAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456091; c=relaxed/simple;
	bh=0/jEOxtSFPK0PmIemOfKHGwBErRDUi05GZgJASgkD0U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SJCF43RAN45xxDIgdOQjlZvUi2i1yJ2MWLjQOm+CIQZOuD8UBNqoyR8A04JKlJKZTvP3Xpn2SSYdbPS1JJ8ixRDgYeL8xCxY80Gyh1N5clXvFe+7FI1qEhRFwr2CVpCh1lqymTbhTjFU5uvRvlF7BG/6hsuMmKDQqBPmJqoI4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=endXWJF9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b70b338426fso22728266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762456088; x=1763060888; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TOmMRtW5FXW0MAi6xEIHqEbujsChcuuW9+3rNb6Efhc=;
        b=endXWJF9xcQC0qfiou69PkWTY5x/2hS9s+O8kGB9yyZM1joqCEym2VuuBtyKZqVd/R
         OcgjZ5LvV4mRGsdCN6hH3Rg1IhcYkkKYAxEKwGe5y1e08bDlbQPPuyEZ6s3IOH+bjDg5
         7zG22JJVIZwDcBrHbWVsZmLgTAT1MjkhiRReAn01JsrEOKPFKLzol5pbaaTWaWkBZwLU
         0AI9Lkd6GVjq90NCTejZ2zq6xM0RXRRZ7VDWpnG9hDXUbqwLypBG+YzHmwEN5o9m6ElY
         ow2PPt66IzX+Xu/Weqvx0/UTGPm9hvUx2QzoQQcq8xxzbRAdlhGzt+fHv2c3Zy+Cjho9
         TmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456088; x=1763060888;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOmMRtW5FXW0MAi6xEIHqEbujsChcuuW9+3rNb6Efhc=;
        b=O8sxZq5ZiW6BmtGGfneHB3d/9em9vNCY0YZwMhsNakXBCRYW0l43ecBBwTkcoM6I+s
         ZmyRyC5qnY9acycD1NcDY7GVqsCCIgjNg5zUAtjPDaMLzsfcHjPv/mFujCN2Ri21w7+B
         3svoZGEW0ay60kAO8fq+QMxC6BKu9lE2+WrAsWBRuCoK70i1aGjzpFAw1mBBp0Pi6M+T
         W0PT79tiQ8hyPY9+gqtYFPu+Wt7ka7WDB9DmO2oYHCZLIc2zaz4GRPraTWPR1B4fPQe2
         csJ4xf8WDf2hhVZ74R44RgUG50XMH1z7P3PXqVC2F34Atbwm5Aq63cjmeGZf7vEZ1yRJ
         Xxzw==
X-Forwarded-Encrypted: i=1; AJvYcCXJx6DE01x9cSWlKV61JwUMvrwJ8CIZISn9avmxha3NcTyksHOtJ+kfVhy7z9WGUVKtmX+O2mGERgidyTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr5mbTciXCiIO7hXblU1XLJ+LehjCzSLROOU4sNyIgxs/UW71Q
	E0TZ8akfIE125Jzp+VoaVR5skmf/1JOOqH8K2U8mfvE0NtTrCvslTCpW3XFUfeGsbTo=
X-Gm-Gg: ASbGncsId3uqB2gkWG+LHcyYkiO1hFgXpQJkWEo6DSSdbNqelzwqk0wbOd+KwqKnW76
	IJDYIK0F7bvWW4ViwRZQw5B2A0bvM50QMCO3PN3+e51ZkxRa5RVl1h7MrOOgUxDKP8q6McjCONL
	R0HZEFXCkXpAAmHeI8S3s/OVw8sky2gfRvMmrhs1TawdtET6kOJzjYBeA6sNT7KWy6te9iDoUhy
	EoReFN/USsKnBTjW9rlbfIJPnPfMAyX7kwJifBH0i7EdvD8jgWlyHlhpyvhosI0QYYj42n6Df5S
	K6ewfR4mYPvE/E4MyLiBMtfByoQGO0+KzVeDmn945E3L85WklHLNZ6M5seJ5KrRINcLJTKNBN1y
	/mWcqjqlZMJIjApvJgTJRtIL2z2h2trCDHx9LgAcjO5VIv5mwsP/lmYoGmZbfK4qWIUlRG3XQmz
	W000M2yP9Xj310EwVbNrPr77UQFow=
X-Google-Smtp-Source: AGHT+IFGWzZTlk6Pep5z9JJh/2iQFwbYfqTOhkd0VSyzz3YH59510NL660TZKF8rj5tPeiZrlMyDNQ==
X-Received: by 2002:a17:907:3f24:b0:b65:c8b8:144f with SMTP id a640c23a62f3a-b72c0996c95mr16124866b.6.1762456087865;
        Thu, 06 Nov 2025 11:08:07 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa2510esm26739566b.72.2025.11.06.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:08:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/13] of: Add wrappers to match root node with OF device
 ID tables
Date: Thu, 06 Nov 2025 20:07:07 +0100
Message-Id: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANzxDGkC/yWMMQqAMAwAvyKZDbQSi/gVcYiaagartCKC+HeLL
 gc33N2QJKokaIsbopyadAtZbFnAuHCYBXXKDpWpamuNw4Fw87jyMS4/NQhOfDASOxq8IddYgtz
 vUbxe37vrn+cFIRAvI2sAAAA=
X-Change-ID: 20251106-b4-of-match-matchine-data-4a64bf046814
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2925;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=0/jEOxtSFPK0PmIemOfKHGwBErRDUi05GZgJASgkD0U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDPIG5LkF6rev9ukV/+9Qtp68gNcluS7tTEY5b
 xPa3VIbKtCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzyBgAKCRDBN2bmhouD
 12G3D/9mfBQ7HGLDU/SZRXrLmtiPXCTDREluXdWUYAg8kpONNNEE75+x3up7wKYhs7S49bz7J27
 LN8BPJka1h7vYjEBYECOIAX9bwtTdR1QgpU+tJJRaN37ZNfdhdTG0SRuIbUpU5ONVnCTVbD+yzf
 7zBhrdKxAlht4mclM1I6Gnv97bmFqpGq/Pp5p4YJBGUrlBvuzoL8u9W9CA+xxXjW93uVjGixBu8
 omyiKyhRMdLgPamka6AttrpGLvvpFJVQChi30yQdAEQVdbp+zHnz4jkteGLGPjH6jy4+PLURMgC
 9FJfaviKGJDnBQYR1Vd/kpu9tnP/tW69frilBMHYt5kyIHvL5H31PJaQ+iBNmpavlBaLTjuylT+
 5sTnNNeO2R2ewpIY2kWOYuIrjiGSYc+zeHjf8l/zFKVa3zpvFMpjcomXpu0vHESDLc9qBRt8EG5
 oRhuhAqACjuTy33Nt3xExzTEAmOENK7qDzWl2xWbiFO1sLRbMA2auneH6jgY+Vb9yIqwNUv2zJA
 /jZShiOwmSnJMha7tiydbA6xvwNQhNMBW1Rs5WJzcEmzRwCWNGTqmhZHOSAQsES3xDV/pFdvbJY
 81lzvN3L/XYxoZ0HV75pW19zvzOuwUG+sbhLwIDHO5mlCNQ4qN/lssv+82nTDl+i971szhjo8Kd
 Jzhgda147d1CC0A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Dependency/merging
==================
All patches depend on the first patch, thus everything could go via
Rob's tree with people's acks.

Description
===========
Several drivers duplicate same code for getting reference to the root
node, matching it against 'struct of_device_id' table and getting out
the match data from the table entry.

There is a of_machine_compatible_match() wrapper but it takes array of
strings, which is not suitable for many drivers since they want the
driver data associated with each compatible.

Add two wrappers, similar to existing of_device_get_match_data():
1. of_machine_device_match() doing only matching against 'struct
   of_device_id' and returning bool.
2. of_machine_get_match_data() doing the matching and returning
   associated driver data for found compatible.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (13):
      of: Add wrappers to match root node with OF device ID tables
      cpufreq: dt-platdev: Simplify with of_machine_get_match_data()
      cpufreq: mediatek: Simplify with of_machine_get_match_data()
      cpufreq: sun50i: Simplify with of_machine_device_match()
      cpufreq: ti: Simplify with of_machine_device_match()
      cpuidle: big_little: Simplify with of_machine_device_match()
      firmware: qcom: scm: Simplify with of_machine_device_match()
      irqchip/atmel-aic: Simplify with of_machine_get_match_data()
      platform: surface: Simplify with of_machine_get_match_data()
      powercap: dtpm: Simplify with of_machine_get_match_data()
      soc: qcom: Simplify with of_machine_get_match_data()
      soc: qcom: ubwc: Simplify with of_machine_get_match_data()
      soc: tegra: Simplify with of_machine_device_match()

 drivers/cpufreq/cpufreq-dt-platdev.c               | 15 ++-----
 drivers/cpufreq/mediatek-cpufreq.c                 | 12 +-----
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             | 11 +----
 drivers/cpufreq/ti-cpufreq.c                       | 13 +-----
 drivers/cpuidle/cpuidle-big_little.c               | 11 +----
 drivers/firmware/qcom/qcom_scm.c                   | 17 +-------
 drivers/irqchip/irq-atmel-aic-common.c             | 15 ++-----
 drivers/of/base.c                                  | 47 ++++++++++++++++++++++
 .../platform/surface/surface_aggregator_registry.c | 13 +-----
 drivers/powercap/dtpm.c                            | 16 +-------
 drivers/soc/qcom/qcom_pd_mapper.c                  | 17 +-------
 drivers/soc/qcom/ubwc_config.c                     | 14 ++-----
 drivers/soc/tegra/common.c                         | 12 +-----
 include/linux/of.h                                 | 13 ++++++
 14 files changed, 82 insertions(+), 144 deletions(-)
---
base-commit: e5efebeef746a24f45b98dbdfcf334285848b32a
change-id: 20251106-b4-of-match-matchine-data-4a64bf046814

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


