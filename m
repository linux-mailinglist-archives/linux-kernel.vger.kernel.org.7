Return-Path: <linux-kernel+bounces-802789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FC7B45706
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 754644E4CF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBAB34A32E;
	Fri,  5 Sep 2025 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9zkEjHr"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2B72615;
	Fri,  5 Sep 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073526; cv=none; b=LjB3V8J7MfnBTkndHsiHMyeR8ITTYf2jEADbFdAT9M3+MaaK0VYamHS50xDKJ6dcVeLR6RofN5acDna+FhkpvdJkOem1WqEhTYdybOQiBR7rEEdgXMH2WwTu7RReXAZokdvjPK/71BBBvY2fgV0kXixDTyotsQLhmhkrb37dQh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073526; c=relaxed/simple;
	bh=ncsLVatG2gU8Cn6EQVGjgzlpUBwb8hewdPM8dcwcU3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d9QHoSWtDOSnsBhjQQRuf1D8ECWTxtvJi3+c3wOc+3mLwBEchRtW4glJi7lXgi/75aR0F/6H1M0r4QuPxiyC/pfxym2kYx3AXK1U9JWnMRD2HmddtW34kTjuBJOkbDlk8idj9T2vRs0ZIE3gQkiaTQLSaZ79Ob0gO1i/iQxn7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9zkEjHr; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso2307178b3a.1;
        Fri, 05 Sep 2025 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757073524; x=1757678324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3bWvwmIfZ1QK2lN+pd29Nat7eqHMsah2RpM/tEgMvg=;
        b=N9zkEjHr0F+ntyac+EyG6U7l6bJenL4GMdsgn4xaDdIAk16OWoea70cXAa2Ph1wjdT
         FCh0h59akeo5QqZhCHFS+nv+gI15dxYuWFIvyBuD1qr8DrC6DWRMCscCvGDRs5vFsqpn
         z80NemVDRszJedaq7QYPgwaZxtRJQTVpo6/mnxHYmzo9MYWQ0/BnLoFrP1I2+OK8jzOx
         lT92d2tr+25SuHIGQA2IkSkiMjdB6HzUDIDvFc81Sjwdjg/TR57+ILcUZkye36d75ohd
         v9wyO28niKFKI+uETRIXGMNn4NteJPM3XXWws38KJ4HHVvo3eE9S6VBD3Alvx47VQS1z
         FnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073524; x=1757678324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3bWvwmIfZ1QK2lN+pd29Nat7eqHMsah2RpM/tEgMvg=;
        b=fXQ8oxrFhrdVF57dIyLEHaRUWzvNCs3Yq+ZSnKumxdoAgNaR6LpTVTIFB17hgRwH6d
         fTfgI/cyM0fchzxw2To7eJq/Vsbs3xLttU7THFfKf9S1QEnx15dwjJ93uj2QPmD3QHWL
         vjV4Cxnd3YRETiDwadD9b3g8W1WKBy+QjgDCOdkiGBEiIKqSJSv8FeF+bsFIFYVR7NT6
         tryERX7Rw2BJ/UmaOTqGw5EBC+7OAirM6bLt4F0/SRYfbY0O04/uQEY7y0P5Ia4U66aK
         zea1WwqBOtSoutZxyrLOmV5+W33ORmXk6qkY7OxmeNJrflhjMnWn4SSMsbjMf+GgSfuY
         qJ2g==
X-Forwarded-Encrypted: i=1; AJvYcCU8I/SlyAWXAsyPGwxS3R/hBmcmycsh0NCVmO3OjlAvfwDESbQidDetvQY8awLISaxGl9vKSmF7q4LXgUfD@vger.kernel.org, AJvYcCWtczFj/cMe8R/yNMUywLeS+mRM+CFSfRt/Ga0c9NpQ5vVV3k7wM/coaZ2PtY59Ajc+aektjyGl0XNM@vger.kernel.org
X-Gm-Message-State: AOJu0Yywr5HmLkuRW5qQm7kfcCFBpxXIycIIV9razvWYOVCKSNuzi/5y
	/aGWIeesOvBniYjepq2IuMDpDNAxGoiWH6qISlQZqtteGjpUrd+ho9n1
X-Gm-Gg: ASbGncuhWQM7qr+XyRqn140GJdZnBwlnLDRnntS+YEUrH0vlrsiQ2yiObyk0yAdYE3e
	so33GhmBw72qY3EU1mfJqukYTz9G7u8cTiOTKUS3OaZ1VTNqEDrIR9wtN6WI0AjAUJfPj6ucOao
	UV8oh/vhSmBqszFrqZS6A1SQZ/YnsL9Z+jvyrwe7lMM58b5+7KYy2vsb7GlPplWxdp+cASjjrwJ
	eiBG7yh/Dcyaifv+FpJN3vE1mVrFtxZEXIU7vDmNqqI5p8KGT7JW3kmAuT5QbiFtXAJsSwVqIgq
	QDKpgxoFPcP5mdX3tS2Fuqdb2ti4gFMP+ZauH5Ms5CrK5nB/W5W3IWlfMsN01aZWJTowbaKBexq
	W8U2Vj7u2Xh4lQ1G0ZH8Bq6bTA3skJd8=
X-Google-Smtp-Source: AGHT+IFQen2mf5QG/q6Ic53cG1cbjqTJcglHGfWctLC+WYLJqugGhRSQG6HHJOMsIWHguIzFn2k88g==
X-Received: by 2002:a05:6a00:21c9:b0:771:e179:343a with SMTP id d2e1a72fcca58-7723e3386afmr32227880b3a.17.1757073524442;
        Fri, 05 Sep 2025 04:58:44 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm19633049b3a.67.2025.09.05.04.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:58:43 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC support),
	linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC support),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 00/11] Add cache information to Amlogic SoC
Date: Fri,  5 Sep 2025 17:27:31 +0530
Message-ID: <20250905115836.7549-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Most publicly available Amlogic datasheets mention that the CPU employs
a architecture, quad-core ARM Cortex-A53 and ARM Cortex A55 and
Cortex-A73 and Cortex-A53 cluster, sharing a unified L2 cache to enhance
overall system performance.

However, these documents typically omit details regarding the sizes of the
L1 data cache, L1 instruction cache, and L2 cache.

The patches in question align with the cache specifications provided by
ARM TRM for the respective CPU cores.

ARM Cortex-A53
L1: 32KB instruction + 32KB data cache
L2: Unified 512KB cache
L1 cache details, L2 cache details

[1] https://developer.arm.com/documentation/ddi0500/j/Level-1-Memory-System/About-the-L1-memory-system?lang=en
[2] https://developer.arm.com/documentation/ddi0500/j/Level-2-Memory-System/About-the-L2-memory-system?lang=en

ARM Cortex-A55
Cache sizes are implementation-dependent; refer to ARM documentation for configuration options.

[3] https://developer.arm.com/documentation/100442/0200/Functional-description/Introduction-to-the-Cortex-A55-core/Implementation-options

ARM Cortex-A73 (as used in Amlogic S922X and T7)
L1: Configurable, typically 64KB instruction + 64KB data
L2: Unified cache, configurable up to 1MB or more
L2 cache details,
4× Cortex-A73 cores (up to 1.8GHz) with 1MB shared L2 cache
2× Cortex-A53 cores with 256KB shared L2 cache

[4] https://developer.arm.com/documentation/100048/0100/level-1-memory-system/about-the-l1-memory-system?lang=enL2
[5] https://developer.arm.com/documentation/100048/0100/level-2-memory-system/about-the-l2-memory-system?lang=en
[6] https://androidpctv.com/comparative-amlogic-s922x/

Changes:
v3: Drop the commit message as per Krzysztof feedback.
v2: Modified the commit message and added cache information few more SoC.
v1: https://lists.infradead.org/pipermail/linux-arm-kernel/2024-February/901497.html

Thanks
-Anand

Anand Moon (11):
  arm64: dts: amlogic: Add cache information to the Amlogic GXBB and GXL
    SoC
  arm64: dts: amlogic: Add cache information to the Amlogic SM1 SoC
  arm64: dts: amlogic: Add cache information to the Amlogic G12A SoCS
  arm64: dts: amlogic: Add cache information to the Amlogic AXG SoCS
  arm64: dts: amlogic: Add cache information to the Amlogic GXM SoCS
  arm64: dts: amlogic: Add cache information to the Amlogic A1 SoC
  arm64: dts: amlogic: Add cache information to the Amlogic A4 SoC
  arm64: dts: amlogic: Add cache information to the Amlogic C3 SoC
  arm64: dts: amlogic: Add cache information to the Amlogic S7 SoC
  arm64: dts: amlogic: Add cache information to the Amlogic S922X SoC
  arm64: dts: amlogic: Add cache information to the Amlogic T7 SoC

 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 37 +++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 23 +++++++
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi | 36 ++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 74 +++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi   | 15 +++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 21 ++++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 27 ++++++++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 62 +++++++++++++++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 27 ++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi  | 24 +++++++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi  | 27 ++++++++
 11 files changed, 366 insertions(+), 7 deletions(-)


base-commit: d69eb204c255c35abd9e8cb621484e8074c75eaa
-- 
2.50.1


