Return-Path: <linux-kernel+bounces-736538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6641FB09E41
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBF21C20569
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C192529552A;
	Fri, 18 Jul 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="WmeL5ltz"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50034293B7E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828271; cv=none; b=HMFy9GJiq36lzlv+x5oBgrGOAFSCzELEruc5ftlK4gKbtrEByntm6xqxPP9Yjlq6nITQ+zP2BRu2jvhzJt6yTqV2s2U15f0aqso78Fj8YG+V1jFFAz61pFV4I9cNTl73gtY+xm1f2Hd7vRBYLSNVQ4yqULLHI4CEwsQOsX+CK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828271; c=relaxed/simple;
	bh=KAk0DmLd1Szc+8RqLN4Q1eSR/knVV6oNPm+weoQTnSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wr6OB2kADg6NSalT62qs14+fyTWpEu/3hOD26FfsR/Zfd79JffXzGQsl9R0ILq0fu9E3aaumwjpLutk7pa+P4u0/n7k7Yp3y6527O2qb7jNmYU8NYHjURzNrf+XZo9GEhMneU7049UQvRozCbFH+ej3ngYfIxe86jx3HhbiiAXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=WmeL5ltz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so1469471f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1752828266; x=1753433066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EQUcoTZuNnVFMQcqVlD/dsEaFXowm3+QSDfAXy+mm2Y=;
        b=WmeL5ltzdinHjQf2EXI9JODM46w8e3K/9omwK4aP1W+7U9Kteu16IDKy5RbLhRuzSZ
         hu6/4929MCrKHpVQm63+DRCUM8wZvl7sRAsRiyVbf6TT1N/rBnVPFXwXRHQmWV4W8bK2
         0RZmhIWMURlQff0pycSmyOb6UWPmxvxnPWHieeDNRRn6dfqDxFrblrB9Tvz6+gflP/Vw
         ej5qnbSef5NtFUkkEr0TtYa3gzdEh7Goei2kQX4gFxRyyhWXhKai9skgK/pHE/RAEjlh
         XVOk7Y++f1+DcFKrGAFsnCGN10g1NOXmXoz0nX1+UfTR59t3u2VbQ9FTZc/xeSi3mcam
         xulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752828266; x=1753433066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQUcoTZuNnVFMQcqVlD/dsEaFXowm3+QSDfAXy+mm2Y=;
        b=sz9kT0Jv2Y2vA4MbrUAgY7+Wf3djvk0dIuQMH441fy9pZkcYQhLumnveU/ZsxRMqg9
         h4UZj0lCaoFKqPa+HDFxNX9mCQZZNKN4ar9Q3vDdXywHYZDNMFy0oUSJz7A2DR1DikDp
         a+ANsRnLIXCnn1qxEJh+2sCgKoxvYiv+E2pdj0AKFM1odqitehtkTC68s7kl68AA24Im
         frE07WdUVtGjMjjwm/BBEPmVwsQrnNJLWJDVLPw7PFcKZJ6e0A84VBUJLycBMb9bhkHY
         637R8KnQ6Q60XoaGFcSnZOSk+5XsY6x3oyV+91+j883Aro9B07QY30rB+8AXao6Dc7Cq
         VWxg==
X-Forwarded-Encrypted: i=1; AJvYcCUq3hdgXw/5reQJ3KEpxS7Cl0wpNMuRCsAVuO3C4i5VpCGvleWoiuUbuY6tPZpYxHsJ5ZmX87APrV8nZtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztWK8/nhmSfTK5qrad+XLGm0xqhJxyOZzxXrmyot0xj7oGlViR
	AwXIeGt1LvkADmA9z130aS9qIA7uSqsq54DsUVf/qMVYO9PhsJ5uU9hBwCu7Bt8/o7Q=
X-Gm-Gg: ASbGnctinXQujtSvu5w/HehJl45DQCIplUw5XefhN3gX3s/ZmNqzmlm/PyrvPKxAtcf
	YC0HKQOGL+ANtLpNLgFCtRAbNtopB5IPUozKUm6DnIYIUlOHmZ0q6OIjYs1yaA/0KOFE1Pj0d4h
	HuIeH0kI0bUNII3b5SEwF/KYSl5ZNH9oUWcjGacATnL500p0J9bl0CYsUA7L7UJotPIN5mtptSd
	n1t+RdrGlIr5KVF0yKZLBLs1N4U4eYc/wL0Qo3pNAuA1RwUyxdoH6ptF79Y6FAvqiEy0gdDgmg/
	7NTDHryNzbsFWe5eAmpOMwJmssqMxZWZQ+6EmUOF/4MH6iS0Q81YNZPQvhkG0EDh/K0fkGMIDzc
	2CDwRY/HMDAecp0vIYWiZaP1tXQm5Uafcrm4LZqQTG7qsCIZy
X-Google-Smtp-Source: AGHT+IF1DTxp68FxooAN2QX2xUqfuF3c4Mb9kU6Zx0w2YlTbaB6gQlG+uHFwhWQB3m0w5QaqnggY7g==
X-Received: by 2002:a5d:584c:0:b0:3a4:ef33:e60 with SMTP id ffacd0b85a97d-3b60e51844bmr7888727f8f.40.1752828266224;
        Fri, 18 Jul 2025 01:44:26 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:9aa9:dd5c:bad6:e31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45627962384sm58208115e9.2.2025.07.18.01.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:44:25 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	palmer@dabbelt.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH v2 0/2] riscv: dts: spacemit: Add initial support for OrangePi RV2
Date: Fri, 18 Jul 2025 10:43:37 +0200
Message-ID: <20250718084339.471449-1-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds initial device tree support for the OrangePi RV2 board.

The OrangePi RV2 [1] is marketed as using the Ky X1 SoC.
However, after research and testing, it is in fact identical to the 
SpacemiT K1 [2]. This is supported by the following:

- Similar integration in the Banana Pi kernel tree [3], which uses the 
  OrangePi RV2 and identifies it as the SpacemiT K1.
- Comparison of the device tree code showing a match to the OrangePi RV2 
  Linux tree [4].
- Locally tested the OrangePi RV2 with the SpacemiT K1 device tree, 
  confirming it boots and operates correctly.

Patch #1 documents the compatible string for the OrangePi RV2, and 
patch #2 adds its minimal device tree. This enables booting to a serial
console with UART output and blinking a LED, similar to other K1-based 
boards such as the Banana Pi BPI-F3 or the Milk-V Jupiter.

Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-RV2.html [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]
Link: https://github.com/BPI-SINOVOIP/pi-linux/blob/linux-6.6.63-k1/arch/riscv/boot/dts/spacemit/k1-x_orangepi-rv2.dts [3]
Link: https://github.com/orangepi-xunlong/linux-orangepi/tree/orange-pi-6.6-ky [4]

Changes in v2:
Patch 1: no changes.
Patch 2:
- Added aliases section to the device tree.
- Removed the memory section, as it is populated by the bootloader.
- Updated copyright header.

Here is version 1 of this series:
  https://lore.kernel.org/spacemit/20250711183245.256683-1-hendrik.hamerlinck@hammernet.be/
This series is intended for the v6.18 merge window.
I'll follow up after the v6.17-rc1 is released as suggested.

Hendrik Hamerlinck (2):
  dt-bindings: riscv: spacemit: Add OrangePi RV2 board
  riscv: dts: spacemit: Add OrangePi RV2 board device tree

 .../devicetree/bindings/riscv/spacemit.yaml   |  1 +
 arch/riscv/boot/dts/spacemit/Makefile         |  1 +
 .../boot/dts/spacemit/k1-orangepi-rv2.dts     | 40 +++++++++++++++++++
 3 files changed, 42 insertions(+)
 create mode 100644 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts

-- 
2.43.0


