Return-Path: <linux-kernel+bounces-886185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26381C34EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88D1B3435A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CB730BB80;
	Wed,  5 Nov 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zxw4vUVq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4983043DA;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336005; cv=none; b=uZtfw4HzL2pZh8Cm+AMcmc9KD2ApJ+Q19T5gUxdN7BF0ZQPs4c5E2FIykwGoY2qiUvUBCtB9GpTHviRA75Zuvi8YyF38tMThwgbrKu8MWTYQP0Whfj9+45v5Sw+BULXd12AbINlq7cM5vuao1GSQPV3F6LK63t6HeC38gOW9q8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336005; c=relaxed/simple;
	bh=sBbijhHOp7oCs6GEaRJPgWgOKT9wxzc+e84cgJVXGks=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fAkZd4hO/BVRzf0kaOqgq/douXoTS37IFXRmAuZsxCReOFeU59uPZViRCTGtRkSFLaxpeMhPuipuyd8pH9b/o2m2sKBJnW4qEMNC+adNCA8gmpkrmgzceTsSIWnDUwsDAAIOK8rXmX0XPMYSfUICCiCO5S5d1DyArXNNsVj+kTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zxw4vUVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62E6BC116B1;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762336005;
	bh=sBbijhHOp7oCs6GEaRJPgWgOKT9wxzc+e84cgJVXGks=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Zxw4vUVqTBSt3FCa/oQKoFUJGDmq5sir/ipMJvHg/ijClKxT6uvSg6aI71KYkmWEb
	 2P1YA3dI6PVaovLr49SJRX87yU0HOb70hLnHEQ4UihQP6DP1SbSvShIktizmfBkqI1
	 U8c/e4UrpGgwCPjuxUydBhdu1eYNRJBxsKKDl5Cv2rjZx3DIn6tdk1CMPDgP0pxIxq
	 9JZTudEjoLkrVmqy2rkIEifc9kISLkyha5ikFflXLnU/bm6ft/JGOSE+VTuif7VVwp
	 3M/2gFWdWqXV/5oskRWVmRSRyWT5z9wG0el2P69Vtn+bA+kIS8gLCZWRfILByoR3V/
	 eq3AX7tUPmhWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5044BCCFA04;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/5] Add GPIO interrupt support for Amlogic S6 S7 and S7D
Date: Wed, 05 Nov 2025 17:45:31 +0800
Message-Id: <20251105-irqchip-gpio-s6-s7-s7d-v1-0-b4d1fe4781c1@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALscC2kC/x2MMQqAMAwAv1IyG7AFFf2KOGiMmqWtDYhQ+neLc
 MsNdxmUk7DCZDIkfkQl+Cq2MUDX6k9G2auDa11nbduhpJsuiXhGCag96lDZceTNEQ8HEfVQ45j
 4kPcfz0spH7UkiwFoAAAA
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762336003; l=1085;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=sBbijhHOp7oCs6GEaRJPgWgOKT9wxzc+e84cgJVXGks=;
 b=UuVuyQFMIsQ/oSHSwOOpFHXycXVt9jeIo5LDQY86D6wNsX39oK3t12F0Q/VZRCTt4n0bXV7N1
 3mKDqs1TIz1D9OIfcbbLOYnmPLW+O2PRBqPqz+vPmG5fj356OCEol4g
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

This patch adds GPIO interrupt support for Amlogic S6 S7 and S7D SoCs.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Xianwei Zhao (5):
      dt-bindings: interrupt-controller: Add support for Amlogic S6 S7 and S7D SoCs
      irqchip: Add support for Amlogic S6 S7 and S7D SoCs
      arm64: dts: Add gpio_intc node for Amlogic S6 SoCs
      arm64: dts: Add gpio_intc node for Amlogic S7 SoCs
      arm64: dts: Add gpio_intc node for Amlogic S7D SoCs

 .../interrupt-controller/amlogic,meson-gpio-intc.yaml         |  3 +++
 arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi                   | 10 ++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi                   | 10 ++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi                  | 10 ++++++++++
 drivers/irqchip/irq-meson-gpio.c                              | 11 +++++++++++
 5 files changed, 44 insertions(+)
---
base-commit: cb718411c4c05a4a424c2b73790a1648be97a4af
change-id: 20251105-irqchip-gpio-s6-s7-s7d-9eb2ce7fccc6

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



