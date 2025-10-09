Return-Path: <linux-kernel+bounces-846474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EADBC81BA
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04221A60CA9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA72D29AC;
	Thu,  9 Oct 2025 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf62WloO"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53FD38D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999548; cv=none; b=J9GT23eXyizWrc4u/philk4BH/i/mfKYAR9wDTA4FvJkEU/CHZOjKH/IWKPMVeNgJTuzHWLrLKcHSiYtNzKDwUQpQmaUPmgBD2D8mfcpfJ96op/azroiOOiX6cwj/LBdweczObD8arBO85HBKJkS0rNkDLekgyQzP3/tZbxbmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999548; c=relaxed/simple;
	bh=d2vQOMGTX0vpO0tM8PhhjLHne5Jkj28uJLGWrKm8x8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRROSNPVC9RxlPX0upQeyJ4iaOMs4tPMsfz51WbZjE8dn893alH23yqbErG8jPW6W8s8LVwT7iWhUzjW5nVZ1v+33qgFa8RC2NQJ2+zn4kzn9G/iKynlzXOqxuAIZKtGwNFK6NjGqDxtaixAY3Hy29ZRAwFYCqz7uOGn1nkRXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gf62WloO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7800ff158d5so666958b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759999546; x=1760604346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UFxKPtmjjPmsPSDnSGoXW+doirX8MuPaFEG2TG4+iXU=;
        b=Gf62WloOtlL41N0qDrhyum+HVBqQKX+NAHVDPyR4AkmH297k2ZtMx2eM9e0s2TAhhh
         2mrPhVpTxUWc3kzIbXjueq0V6K3+MMDQokjmWBSVtetFVsVVWBJ2be0WABJE1M9cvkcL
         VQ9vRI5PYkauWpbdyfVcMjGRKpvFIuHkLQKtI/uTGhZtbUEMR6UnLQeT0uyNmN7NEtxs
         04tAxKiuu0jfak1yMG48terA1Z1kK8bU88mLsLF67Yrj+KlqippstxBdl6i9GxzQUytA
         keQQpY51vQOG4yG30eh8WeVYDdMDRZiKrHPAQWH3Z0tFPMngxVO09nSaLgNNZHl//H4Z
         +UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999546; x=1760604346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFxKPtmjjPmsPSDnSGoXW+doirX8MuPaFEG2TG4+iXU=;
        b=dnDvXUEd7gmx7JsRzLbmfFRK08ekLNIBcS59D/py597e+FbfTia4Xo2KvfxojY443C
         jSfgWW/ovBprxKFbSIkNOgIAuM27Vjtz/KwDcHQHknwc1Fz72hjJ57zRYlKXJR0iNbJf
         jU+EDN/agTEpbqhLBxJPyMezc2o3JI529jO5RS9ujEiDmh4bApqWEbXT5Znbd6XGiot7
         asQ3mXIJgjNwXBHtS6mm+UdbmSc3Z8gGujzXRP8xlL8UXLETwSmv5K+w9HldBQL53Cnk
         3wVXIVNctIOGG/hODfxUJ4GVkv/D3QwmxSYdaSjSleG4RSWgsw4mryrxTfSk2Nwe/3SY
         Y1Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUS1f65WJwDOFK/yAtd/oS84DtI3E6B7NpiQnPJHsX3Sd4qbxw13umNveaOShS6Ehsb1VqlfrGacwKNgzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW3wcs1HzkgROhxqig0JczH+H3ApCYX6QcIlvBtD6e5uwxj2zy
	g/xAGz5o7c2u+EjLSSvo8sYKvOs7MvxU5RFD1zNRAAJyKU4BcCqddfcM
X-Gm-Gg: ASbGncsYPO/ndDuwpL1nu6SgoKZ7HBHzgn+8qBgNUb7IR9HvrX2bNd0gQp1VWio88bw
	j5x6zAAQ0t5TWjp+A+vD7CBTZwj1p0yjSa4mjvrCNAs1y1sGPz8navJi+pYCmLAEOrGQlNmbLEi
	E2oBTb/4/yH/Lf/3FJpZZVrZwSL6Ilg8Mrjabe+FIXr2OVDDGbSZ3J4uVm5nSSWGeyq9xfTsvLK
	DsUvlN95eN9MIQ6oV/ib6jBzAZ8D0R6spE9d6rYUr+9Y5S3SAWwn3zqMGw3RDtFQGkk5LPYaWc9
	uQdvQhFzp7W9mJ/TOHK12eC7dwPnTQ7fVKJ9pIFJgHfx3qAHqWQH6RnZH8q09J7qyWJ5VuI2Qcj
	GYGPiZt3puOnX0uXkezNZf26yt3P73ILDV89K5zccYYr7mRykXXEJPDyWsCdxi7atTA==
X-Google-Smtp-Source: AGHT+IEVp0sgA10BvrRwBHxoUMhCzRyjJK1eNd6qK3tx+tcCEvpD74MNSsa4zglDlT5r0XodRH8KuQ==
X-Received: by 2002:a05:6a00:2443:b0:781:4f6:a409 with SMTP id d2e1a72fcca58-793858fb715mr7279720b3a.11.1759999545797;
        Thu, 09 Oct 2025 01:45:45 -0700 (PDT)
Received: from localhost.localdomain ([223.74.108.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e1bf7604sm2130924b3a.55.2025.10.09.01.45.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Oct 2025 01:45:45 -0700 (PDT)
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
Subject: [PATCH v5 0/3] arm64: dts: rockchip: introduce LinkEase EasePi R1
Date: Thu,  9 Oct 2025 16:44:13 +0800
Message-ID: <20251009084416.45542-1-jjm2473@gmail.com>
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

---

Liangbin Lian (3):
  dt-bindings: vendor-prefixes: Document LinkEase
  dt-bindings: arm: rockchip: Add LinkEase EasePi R1
  arm64: dts: rockchip: add LinkEase EasePi R1

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-easepi-r1.dts    | 686 ++++++++++++++++++
 4 files changed, 694 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-easepi-r1.dts


base-commit: 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f
-- 
2.51.0


