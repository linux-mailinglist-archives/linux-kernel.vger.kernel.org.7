Return-Path: <linux-kernel+bounces-835853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F5BA8335
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6763C189BFE5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1AC2BEFE8;
	Mon, 29 Sep 2025 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jALHRIyJ"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749D24E4A8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759129053; cv=none; b=cbUA0GNymzlP82mVo890n/h6xE1B8br66s7Nhwuj8K4q4Bzj96azNUqAWCyIhP+znyZSdFrxLnC9EZQQkKjNIj/Cz+LMEWDVa59AAbwa+iU3FE0nqlb0iVrMWVyf035+9Ncg1W21BWLrFbKMYJI0iIEllf39UTrFtv9eIL4KG3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759129053; c=relaxed/simple;
	bh=oIKmGNauTYw2nxDParCUyfjyCURcTyHm+9W4WVCAPio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h07Gn8/UOMh2hO39i6cPwgG6Q/7m0iRv75qXw5b3a/kYHKL79BMAwThSGWoDyKOFjgCPejUWMQpe78qEh3nFa3JPEpyx/Q0wIINz10s83sxUOxknKgleBTlhZ7Iq/IkIvHDhFRqKTZ4X8u8dKrcNP3lkMXVH67fyM1ecafwRklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jALHRIyJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781206cce18so2321708b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759129051; x=1759733851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uRlIBTJbS5dsUVU9BT5fMMctePqeQfAjKve/Q3RtfIA=;
        b=jALHRIyJJr36kY17XPi2QB+HmKiCcLYua9jIWHMmGP4hjecOetub/ktkIX5tPqVHCd
         RIWbuKtI+dBNyXs8lBTW5LAbJQZHgbKjYSIz+PCHpCgsH3pFC317DI9y2qqJSXwnaSO2
         oKQDjgVxNUBUppNnpklSwUhBweGmlHBLyHuFgn+JOLryGSKnA2X5SOs4wQ5/h3sf5mY5
         H1NyFFmogMlnf5IgLczkARhCfc6jvY5/WQu3vKY2+TH7QC4xj+gUqbvmzXi6QZcAbWq6
         GZeJ2ffdW7ZKCdRHOxPrZvpseiv3rkdaBYmwByHdPIod43NEyy3n2+qTwbnTArUexXqR
         n1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759129051; x=1759733851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRlIBTJbS5dsUVU9BT5fMMctePqeQfAjKve/Q3RtfIA=;
        b=HfhTOLya9gEDPhkEE2LuaQ0chqWiiuFEdg5pvmNj9LL6MtHWnzGHrOsf/nTBE/6B5u
         PdSCOl+f7Axmo9ue5OM+iToLwkKmx1B6snwwUZzXO2dXEgrwd1oE4MxLv/MzosOJLP1q
         AI519Yi+rfVYzOxxEwmDtjXFAX5r067YcOqph8u6wLHDsMu+fS3bXquPqQGaeWwAINi7
         nORYa/7QoJxgAGyeo8Q/yTA3pTfafol8V6EoCkyrH7t8A13l3UgrBzqVZ5+Lf2vSsMOq
         CWdm3JwbNwRl7GAK5eS2IY7uEYEZruR10ahHlT0lhte7wG5I/iiR0incDywswtdEllSX
         nlXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX65UjJnlTuqU8Lr6bp+U+TzUZE1vreTIVbp05Ikn8Zn/QaF1/fs/TRxzhRA8cYblgR/2hIW8y5M2sAy9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLIgMxrWFn5qcvn8LeaJGyT/s/xQ7ohifILNupUbsZTAuGfnVG
	9j7eL67+kj0AXwTZEi6eP6Q3DTGPOok5rML7KKG1Gjo0uvOzB7QvBX6X
X-Gm-Gg: ASbGncuPGfrRoHgX6xzCxi6pwgIxwKB712QYBT0CswQ8kXMlFNVvhZBSXGTg1tGWTX7
	F28wFQXApx4TudpzIQNv/46xNwEyJ3/44taD6D4xdHdqbVy4Mi/VY7bI6Fv2y+HcNTnEcHCTPgR
	g7NZguL2BBCqnBwG+F8MrW4vp8UKl3IR6BuL+1P54ERWW/HsEcGwBNBN6ndfRqYCobpg9TZkFMo
	4DgAftU9MiJGj+yeQnz0E6QbuhIxF9tSeJJtelEqyjBswdn9xjwERW3/QHIx+6kYsV8WeDDsPTZ
	WEHyh46vToErsPnu6t5wvQ/NLrnvsGGkIeu7j3wTiws83PNKRCOlzBYLO/q0uTTjOpA0NYqZ8wu
	kvN3Quym4rkVYDOwaUHUwMl3B60GLc0T7KmNZTivICfY=
X-Google-Smtp-Source: AGHT+IHnOzVUSxV0rdJYyHdNFITwaxFEqSFhQIoUc3A0a+0YDe6RiTgSYuqOECxHlGbYNdZCP3ruxQ==
X-Received: by 2002:a05:6a20:7486:b0:2c4:5793:3419 with SMTP id adf61e73a8af0-2fda3a10507mr8690061637.27.1759129050776;
        Sun, 28 Sep 2025 23:57:30 -0700 (PDT)
Received: from localhost.localdomain ([120.229.16.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53cac77sm10549595a12.17.2025.09.28.23.57.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Sep 2025 23:57:30 -0700 (PDT)
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
	jbx6244@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] arm64: dts: rockchip: introduce LinkEase EasePi R1
Date: Mon, 29 Sep 2025 14:57:11 +0800
Message-ID: <20250929065714.27741-1-jjm2473@gmail.com>
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

---

Liangbin Lian (3):
  dt-bindings: vendor-prefixes: Document LinkEase
  dt-bindings: arm: rockchip: Add LinkEase EasePi R1
  arm64: dts: rockchip: add LinkEase EasePi R1

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-easepi-r1.dts    | 692 ++++++++++++++++++
 4 files changed, 700 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-easepi-r1.dts


base-commit: d0ca0df179c4b21e2a6c4a4fb637aa8fa14575cb
-- 
2.51.0


