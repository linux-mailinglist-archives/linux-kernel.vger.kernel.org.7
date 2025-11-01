Return-Path: <linux-kernel+bounces-881332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B278C2807A
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E97254E9627
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8825C22A7E5;
	Sat,  1 Nov 2025 14:01:16 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C1225D6;
	Sat,  1 Nov 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762005676; cv=none; b=sotvdxsYpDec0o3+msaIRmq1OBYpW7SC3gNl+IWy3vU6LzhHUrrk6KqlpSxLWnnf2cwcgzNZKCwmBScK/WZDYiJSHp3tJoPLcjDfPptOFv1OtW4WRTVWYCOKe86HlclZV/nNITn9WQR+ZAlKX/01y/APOjuCkBzGxVrOzPrUmdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762005676; c=relaxed/simple;
	bh=HmLDqZjPh71HViCKLV+TWEt6q822ASQnQS3XE4kj9bE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EK5a7IoPDgKhdJ+dcsjsIZBecMQtoFSx4bjPzEr9uYOtQ5/5HeDV6rDguSqYY/ejRZC/e6zQQIOOeDfEmlwdcQf3KpRmR3UrWjRwSohHC85YCsfqYoLg0BVPLSrimkT2EGH+fXlpnG56KfcM677rqAWkWKCELXevle6bJvoGuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [58.61.140.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2802e7076;
	Sat, 1 Nov 2025 22:01:07 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] arm64: dts: rockchip: drop reset from rk3576 i2c9 node
Date: Sat,  1 Nov 2025 22:01:01 +0800
Message-Id: <20251101140101.302229-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a3fb8ce2803a2kunm744b76102df25f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZThpCVkpOGUJOSh4YSBoaH1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VNSlVKT0tVSkhPWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+

The reset property is not part of the binding, so drop it.
It is also not used by the driver, so it was likely copied
from some vendor-kernel node.

Fixes: 57b1ce903966 ("arm64: dts: rockchip: Add rk3576 SoC base DT")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index f0c3ab00a7f3..a86fc6b4e8c4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -2549,8 +2549,6 @@ i2c9: i2c@2ae80000 {
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c9m0_xfer>;
-			resets = <&cru SRST_I2C9>, <&cru SRST_P_I2C9>;
-			reset-names = "i2c", "apb";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-- 
2.25.1


