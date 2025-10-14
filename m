Return-Path: <linux-kernel+bounces-851822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BCABD75E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 394954E4FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C13245023;
	Tue, 14 Oct 2025 05:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQgxxf/a"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF323B62C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760418794; cv=none; b=p2dHRhH6e1RI4H/V4AzQJFoGgixdXlWSdcYj9r6FK1/ZFtdVeuSc8woR15NTPj/iVaMvRQG3uMbLBneRSqUdmizRdc55lHAaJcmzgbHZ14nLQ5LEGGFgnSyvmFSTKqK+iDvf3woxy4GJlUe3L5ERR8LJaSIBvqnJXKImMV10Muo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760418794; c=relaxed/simple;
	bh=kkP81OwrDwwpNB554IClMEqQ/2h8j/7xBTxZHmkdRbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6TB172zZYtV6YWt1BSbG0/2XkpxBjn5wdZRBI99MNDr7YaJfbWhXDkai8qvk4k7TIpM17dfHpFNFULxdKzvRmD6IpBvvdRqhS0fucnt9i3VXvI+5uQUjJu708i6BOoc5fHoPZVJpwP17pbN2T3dK0mxdvICNx2vphYYuPv0jUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQgxxf/a; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4701916b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760418791; x=1761023591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h5pJYct9yVXw0oCIW3UzRkZKmjOaGJ9oUwhyyYxVEys=;
        b=MQgxxf/aCXF36ECgwXg/LASIg2TNTn9p4vrWJZWCJ3x5N1bGsw/tLddrBA3zBmcmO1
         ubfNGyTJSu27IMglf6tpj8TgVcj4eueEHqX8y5PqpnAJMhC0hvYx61WbJ0baGYPRhFjg
         qfki3PYkEuv1qgNzGQG39R27jFbK3TlOkdz79se5KExw3m7xZoo/ED4VVgGxMDT3MCtE
         2277H79KIotgRL3+D4wddGKvkYevwPmDLaGhW6TXLooVbRgUK9kYtjh4d5kxu/4yOWUD
         61Etm7Ng02RCAV8BHfKgkcq1AqCZXuYCDE6mII8gibxQ1xtJT/9MOKzUzO9QHEWP9TIQ
         gPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760418791; x=1761023591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5pJYct9yVXw0oCIW3UzRkZKmjOaGJ9oUwhyyYxVEys=;
        b=rHG1OdBZKLe9rUIvoveo00D/eOVYPekxXwEsXMqKfidHOaYyOmr58L7RJg3esGsUEy
         KD3QjxsRR8UdCxY/JyRlgqbQici+Edh15s+bdySsM9xiHwB7J+HL1NxEalaVRk2MTxma
         wc+6gTakSAtiBX4CMZE+Uy+CQNwheL+qQGvzHo6nusgeFSMC5KnnJnAS7/v6EbTUwa/A
         +dPe+jTk5oXzpv1E70+hp1z0BFiUezm8XLe9Pplig9JurEolPImaMqPyy1Dh4IWz+l33
         MT6qXev0qAM7Lm+2lzVpH4urnGy8/tBJjT9a3DBywv9C3oGe3X4k/qKZUwpQM7Cr1P1q
         7VZg==
X-Forwarded-Encrypted: i=1; AJvYcCUf/Cccfm93mfPXuNYJc6Kr2qDDj97z4qJg1rd+LWQw1qsf2Skst7bwo0ZkPtKFJkZcmN+9HDuNDPzrpps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfiz0/rmvttz9OpOofvLSmwWAcE+uwbblt4UixjmBPNjkI1wLh
	aiG4UGSLv9Z5iMf0P3tEHEIBXl3e0cLRQd4rqoI6fFqCPkFicWHxZDdt
X-Gm-Gg: ASbGncsZVhHGOAwZnOBudn3vvd3/qRMPWCJgYwgEjl5Er30Rxez+fjGTkoMjLkyivNI
	13PY4Dj3DKfhuuYhBoIxbU8BwrOek5izieK8mUu6YXnDTN9XkR2doLw6nrkQiZxBIOMWCWb5t5d
	8i5mpL0/sQ1TRIzSVUgj9NpRyuFIe/XPtMdEC1iajdysAeK/bhasQT7kDeA5soLe/wPk7vaML5a
	0BxyOC81w5K3+BFuwyKuw8PUvibOnGW4brv2jWcBM/4i8WsRTP8Sp6iAgvT+r6LLN9gkp+Acjxf
	Wh8YQJ9Jykpf1qSLZYmz+/iTrgJdCVQtzAc0EomKOrJFh0K0tJfhHCwhK3IfgQym3Z7UfbTNgZw
	so4wnBTlrujAw393diCvZISghpW3j5jPQnmaYhSDv7nYpvUMr7uWABCPiLq7Wy9+ixg==
X-Google-Smtp-Source: AGHT+IEFCzkkgshVwSNP2mRUNWEuhHD3ijpyLH4r7whNKouoX3vJnv6qHBbE3m/mtSLuTYRMhWSgqw==
X-Received: by 2002:a05:6a20:72a5:b0:2af:65aa:4efa with SMTP id adf61e73a8af0-32d96db58d4mr34629174637.8.1760418791214;
        Mon, 13 Oct 2025 22:13:11 -0700 (PDT)
Received: from localhost.localdomain ([223.74.108.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678ddce4b6sm10902353a12.13.2025.10.13.22.13.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 22:13:10 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	kever.yang@rock-chips.com,
	naoki@radxa.com,
	honyuenkwun@gmail.com,
	inindev@gmail.com,
	ivan8215145640@gmail.com,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	dsimic@manjaro.org,
	pbrobinson@gmail.com,
	alchark@gmail.com,
	didi.debian@cknow.org,
	jjm2473@gmail.com,
	jbx6244@gmail.com,
	andrew@lunn.ch
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] arm64: dts: rockchip: introduce LinkEase EasePi R1
Date: Tue, 14 Oct 2025 13:12:23 +0800
Message-ID: <20251014051226.64255-1-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase EasePi R1 [1] is a high-performance mini router.

Specification:
- Rockchip RK3568
- 2GB/4GB LPDDR4 RAM
- 16GB on-board eMMC
- 1x M.2 key for 2280 NVMe (PCIe 3.0)
- 1x USB 3.0 Type-A
- 1x USB 2.0 Type-C (for USB flashing)
- 2x 1000 Base-T (native, RTL8211F)
- 2x 2500 Base-T (PCIe, RTL8125B)
- 1x HDMI 2.0 Output
- 12v DC Jack
- 1x Power key connected to PMIC
- 2x LEDs (one static power supplied, one GPIO controlled)

[1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---

Changes in v2:
- Change deprecated "rockchip,system-power-controller" to "system-power-controller"
- Link to v1: https://lore.kernel.org/r/20250925055906.83375-1-jjm2473@gmail.com/

Changes in v3:
- Fix typo ('status = "disable"' -> 'status = "disabled"') found by kernel test robot https://lore.kernel.org/all/202509261328.Grjhp029-lkp@intel.com/
- Link to v2: https://lore.kernel.org/r/20250925092037.13582-1-jjm2473@gmail.com/

Changes in v4:
- Fix missing "Acked-by" message in patch 1/3 and 2/3
- Link to v3: https://lore.kernel.org/r/20250929065714.27741-1-jjm2473@gmail.com/

Changes in v5:
- Change gmac phy-mode to 'rgmii-id' and remove {tx|rx}_delay as suggested by Andrew Lunn <andrew@lunn.ch>
- Fix comments ('not mounted' -> 'not populated') for unpopulated devices as suggested by Andrew Lunn <andrew@lunn.ch>
- Link to v4: https://lore.kernel.org/r/20250930055017.67610-1-jjm2473@gmail.com/

Changes in v6:
- Fix missing 'vpcie3v3-supply' property for PCIe nodes found by Chukun Pan <amadeus@jmu.edu.cn>
- Nodes and properties are sorted alphabetically as requested by Chukun Pan <amadeus@jmu.edu.cn>
- Remove unpopulated devices (sdmmc0, sdmmc2) as suggested by Chukun Pan <amadeus@jmu.edu.cn> and Andrew Lunn <andrew@lunn.ch>
- Remove 'combphy0' node which is unused
- Remove 'clock_in_out' property in gmac nodes as suggested by Russell King (Oracle) <linux@armlinux.org.uk>
- Remove deprecated 'label' property in gpio-leds node as requested by Chukun Pan <amadeus@jmu.edu.cn>
- Link to v5: https://lore.kernel.org/r/20251009084416.45542-1-jjm2473@gmail.com/

---

Liangbin Lian (3):
  dt-bindings: vendor-prefixes: Document LinkEase
  dt-bindings: arm: rockchip: Add LinkEase EasePi R1
  arm64: dts: rockchip: add LinkEase EasePi R1

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-easepi-r1.dts    | 624 ++++++++++++++++++
 4 files changed, 632 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-easepi-r1.dts


base-commit: 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f
-- 
2.51.0


