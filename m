Return-Path: <linux-kernel+bounces-784106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17102B336C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99A818948B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE9286436;
	Mon, 25 Aug 2025 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnBrQKDk"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35541F19A;
	Mon, 25 Aug 2025 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104770; cv=none; b=BDhAkYaBBShRqi0zK1vNQQzQkAnIANrJYW1xHATCq7nc4nAnNIxUB3AAV3Ec2c8OWxSIjPQZ+CbRMdHxUaGDudPq2VAznBVJ7Q+c9Mfsw+6tT3PL5FEfSy0sywNcXmp+3nDFgkEItYeS9LBum2tSyPtITSyuzu/4FQPGloSQFC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104770; c=relaxed/simple;
	bh=K2v7R1fnPC1qc+/kMHnDAkvIsRAF1Md1L+qAzrjsaXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uJ2O0+RK2S8CHs3RiSMTdCesjFlHdoduEBNLK5p4sraLL7sk/m/e2AkzE4m12srjs4Z3nBqAML/P9Pmdw9TG0GBJLYwniRnmWqojYynA8Qwe4Q7whuNjKn6S4RFymK3i7HXSV5Q2sMUveZd+S8gk0SGLCavzHPpHYuqyWYhHNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnBrQKDk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-770305d333aso2302863b3a.0;
        Sun, 24 Aug 2025 23:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104768; x=1756709568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nPSWsDoAmy8PQ775XW5/42G5LT1wuElB0TP9BhSo2b4=;
        b=GnBrQKDknZ4pX5LLI5IOrVowM7sF/cwld99AnIyU/PDTOO61IVozhE6MtJrgqvuHOA
         0T5H5X2yjuPkUcBXv7rJLv5g6O6GG2gBj+yrZ/F6WZyLDMgEHoM1XQxmVUyqaFe5U4+X
         ZlJYIayLyNYLbLM/TjFrNnzoxmEAahs0P+zBCaEH5tOTukxoJSccYFf/9QPTVep/ITIY
         q9Ww1YpdDpd3ijuIlFrn5aDEvYBGzVuc0MGQG6ryjTe0gt/ljGDU8K6foBTN+LQnVF4w
         ypByChB15Mwzmjao4TuF+URiCMBertVwz6SR4zLFSVSJNdadLAPdPnqzK4z1ZjgvM42d
         hRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104768; x=1756709568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPSWsDoAmy8PQ775XW5/42G5LT1wuElB0TP9BhSo2b4=;
        b=NCJuFylK7gscwSAxUZhUh+FoWQyd/zXxXe0xtmjQB0ykcAwOF3W8YGCLoLlvPLCZUD
         oq0WM+ujnI901vA/GHbcotAMST5wW3SkZa1NYTmZB1vCOjdejZ8dLcQozrbtDzsEFZiq
         8SHefvgcNjYKUlRyIRx0XPwiwKyuplo1d4B2a/z22yjsZa3C1rf2FODCTyLKreNssVgS
         5j6hnLMOdylXdUKCbhKZTHfLV/84nZli3+tVbtPJJjZzWHB/AkDAgwHAHvYav1oDy/RV
         vRjRM+xTwXS5BGN/Og7d/0ZK3q2vKF24QB/vjjzRs5jV8Jsd3awPpbld95RDduwRZhqV
         71RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnSNIiDS/NjTw8ShPuy8nk3miXsKiUx4R/+MrBymamfINsMg3MMH9Y5IheWslxx2ZRCwugj5Z6uwtageLc@vger.kernel.org, AJvYcCW5MIQeZWFoUbsYoJsxIj6/36lr3QcdIuPUKFox1rsj0TfWZdXnsLa/g4NdSuQqYax4tNEkbZrKsnQw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3R7xMT5oMMZLSxtB/QsNWImcvtmjhFetvuxnVkAesLSo0tXQv
	WweJsfkAnG/SUXNWbRQmVpDiSXzNSSBPGuG8W4heZeKHGKsirvQrYj6G
X-Gm-Gg: ASbGncuQ//x5Teue0VLpubmU03n8Q0QzwHqvwKgGY2dPo6lHqSgJZveFDJ4DBBNb3DP
	BO3f5l2nJzsFBANpa0My08njbjWzsA+JJFYQt1jBJd1hKGHOQ3UGo5M2wR8RZfHAMqFwg8ZO4jO
	MGJYNEHgPiWO+Rov9254XYRgSB0Az0vGqPh+ZSie0lq7sU4z+1lOHP4M1u3/NVxFKhnQvRFLyeI
	n4vhvWAVBKRfLF7nDZ7xLBTK/6pYqfqN1RuEvl8gl1Qb4AFuxdowdzdfVIPQXIsA3xdBtkaXR1W
	r8FgnKpc9pLRxjrtdSOGK7uLkLFpeNUmQE+84Bz4SUlLKZSut8LiePEs90tW1a++kXMcCNmNeTn
	blqdH2i/chnpIfoA6vFby
X-Google-Smtp-Source: AGHT+IH0PqNjC6PoFYiYSzlQkFiRl1br9OBwRTA+P1HjLnfy+GnCt9CSGYrubD44ufk3hcYJLcLUDw==
X-Received: by 2002:a05:6a21:33a0:b0:240:1a3a:d7ed with SMTP id adf61e73a8af0-24340d59ba3mr14443254637.41.1756104768135;
        Sun, 24 Aug 2025 23:52:48 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm6604072b3a.75.2025.08.24.23.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:52:46 -0700 (PDT)
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
Subject: [PATCH v2 00/11] Add cache information to Amlogic SoC
Date: Mon, 25 Aug 2025 12:21:40 +0530
Message-ID: <20250825065240.22577-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.50.1


