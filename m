Return-Path: <linux-kernel+bounces-773347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F23B29EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7264E2B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D43310633;
	Mon, 18 Aug 2025 10:00:27 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C73101CC;
	Mon, 18 Aug 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511227; cv=none; b=KE41M0fIm/3MqUU8G5Xh690QNurkeitfBMUvk7ppgSOKyKfLzCf8YwJNZWbH6gMI5C/xto12YpSIKRt9kP6+YZJIo8p7lF6c+nVzdQeWZnKaMoSL7uT2igU0fTTKUOq5RhpJtk/W6H9Y99VrAbg+4GByF6zUNh7t5wSTXmqxGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511227; c=relaxed/simple;
	bh=jxVKyxAjf9HWYFNSKIZVKMYd59Fj2HC/k7Bjp0ZX1l0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ko93VYg+OkCusd2TLBcFfwUr0FJ2cPHESfRzdRC8p32Fcgvq7Yn0VD9IzjL2xx+pyzZcFGp16ftqdREno9K2t89dfX29Qy6VfVzViIBCdkJ6wC0X9A6c+JAgPRU1ADTz74aUO5khtRxWVqpBW9N2sb7/3KJJnwD3KuUEOtcAm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.154])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fbaa9cfa;
	Mon, 18 Aug 2025 18:00:14 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chukun Pan <amadeus@jmu.edu.cn>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/4] arm64: dts: rockchip: Add HINLINK H66K/H68K
Date: Mon, 18 Aug 2025 18:00:05 +0800
Message-Id: <20250818100009.170202-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98bc9f502103a2kunm3d9619f636a214
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTUlJVhlOSxhJQ0lNGhlJGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVKTk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++

The HINLINK H66K and H68K are development boards with the Rockchip
RK3568 SoC. These boards are all SoM plus expansion board structures.

Both boards can be booted from eMMC or SD-card using the
U-Boot 2025.07 generic-rk3568 target.

The SoM board has CPU, RAM, eMMC and RK809 PMIC.
There is no schematic for this part.

The rest of the schematic can be found here:
https://www.hinlink.cn/wp-content/uploads/2024/03/20250329151432672651.pdf
https://files.seeedstudio.com/wiki/LinkStar_V2/H68K_V2_Schematic.pdf

It should be noted that there is a version of SeeedStudio called
LinkStar H68K, which is different from HINLINK H68K only in the shell.

The HINLINK H68K has two versions distinguished by the shell, and there
is no actual difference. This series is tested on H68K and H68K-V2.

difference |      H66K/H68K    |  H66K/H68K-V2
           | 1x USB 3.0 Type-A | 1x USB 3.0 Type-A
    USB    | 2x USB 2.0 Type-A | 1x USB 2.0 Type-A
           |                   | 1x USB 2.0 (M.2 slot)

Chukun Pan (4):
  dt-bindings: vendor-prefixes: Add HINLINK
  dt-bindings: arm: rockchip: Add HINLINK H66K / H68K
  arm64: dts: rockchip: Add HINLINK H68K
  arm64: dts: rockchip: Add HINLINK H66K

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../boot/dts/rockchip/rk3568-hinlink-h66k.dts |  10 +
 .../boot/dts/rockchip/rk3568-hinlink-h68k.dts |  83 +++
 .../boot/dts/rockchip/rk3568-hinlink-opc.dtsi | 666 ++++++++++++++++++
 6 files changed, 770 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-hinlink-h66k.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-hinlink-h68k.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-hinlink-opc.dtsi

-- 
2.25.1


