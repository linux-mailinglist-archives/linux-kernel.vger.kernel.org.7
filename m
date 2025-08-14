Return-Path: <linux-kernel+bounces-768433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A13B26103
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 426997A65B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A45E2F1FCF;
	Thu, 14 Aug 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loRxQ2Ta"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967FD2F39BC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163647; cv=none; b=VrxvH5zMV7j8gma896pnOpYxd+hXxvnyBOzpX+Aly4WUBqgh8oJYC7wwoeVg8wmIYUcDqS3A4KSLsQZI/p0T8n88Ix4sOTck7ErBh/qW8BfAiVYF3xySTTNOspVoVc1eHi3qJoD2mfgw6SqA9QJi7SVivLxb6oLEwulTdZoSBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163647; c=relaxed/simple;
	bh=YdEsh9QrnxVUJ6j5Jg4QecwD0EyZRBdHjXrYunFZiEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N9ohpHz5dgapN/W+NA6kE0Q0g6uAf6smIyW7kYWXJqdU3BmksZu4r+x38rQ3667G8YCgdIIOQq2q8ut+aAJjPwGXgJNgOWLYSOF3f5Lgt20i6docu1EvG+JhagieGncGB0esGGZrN3OvE6I5T0ogaZDsbzQwHf+x/fucTqj0BUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=loRxQ2Ta; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0b2d21so3491135e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163644; x=1755768444; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XqAuWv6c6I6Tmj7XNLmRavDkRG/hDMAr96wkLjEqxuw=;
        b=loRxQ2TafEZPIaUTwYcLzIvL6wEILQ3Pke5dfBq8Ne+NOo5DiRbMF2XDV5Xa43PfcM
         xTCj5zZia6h3rpjlKblcUj8r5wx8bjeXSJWrbNGktpU6ntdj6UJk8XdP1Bcz48ybxNt1
         wxB88/GLt2sqNBObFx1WTk9yW4Ajxdbkeof7XAS5sZnhk9di3CbDGm6Pq/iJWZbZxj9s
         /wDNkpafVIeugAibkRb8qhyNsp5gGzqf8n9jwWVJR0Xc1BiIAHgO2fxk21F3VRwmkrLS
         QOqpvh6OLk7i1sFAeKO/Q1NRsqF/BILifNyxXwAgDznqEN98M7lg6VvfsWVai28asEuY
         lHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163644; x=1755768444;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqAuWv6c6I6Tmj7XNLmRavDkRG/hDMAr96wkLjEqxuw=;
        b=pne3r56UrUoAREFfO2HITATNQSdVK3WUdugXD9H2aJnW+qiB05tSj7GWSAHWjyg3zJ
         g7i+UETxrN8sRIwdUzJhpvhTBalu4KMhOx5k8Phq8h3XFNyoEu7xKTKQQy+BO1nfLo4E
         j+onhz1cQbr3F2JI9Gn4dvbsttG8LbY1dFVZgfpC0/HXa1a7lQly/N/pgCyoj1DDdw3e
         yzFW8lxcmztFD291bdepq6ni/rKwveHMP9OONX/NTmh05U1lJCAfQ619ZikSfT0MzMsm
         wpoNaZM+ws8O4M+KM1jRDqqnfctvBDdKR/LQYtOFbrWDqh4Sgw0Esa1/QDYXAQEs+W8X
         r3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEzY5RMVWgLMT5Ls6o1o9jljb8VIlVIZYR54EyLIqjHbg/onyg6hZ3iPwkFgrGU6M9UHCCql73e5c1j4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhV1z2Plle6waGG4vCwYWuugOHnBa+913oVZ8N3q6OcUyf0TNc
	JoeovOP77hWFsmgb0dXwT5ZMgjdJ2PaxDmXTYb1KmOy+t9HLiUVXDv9u4AFUvVsqXbYgl4NcKFN
	sKGea
X-Gm-Gg: ASbGncvaxflIT6AuhxitvYE51qEVB5QRx1dmx8r1nsEYoAHdRGJYnHgHAR5eCJ505dt
	9jiJmJhgIPm+wAamkce6Ukygv8OnQMfymmelv/7vpXX3+uNhvD58bzpHGBv6sJT89RkyqAoPPtC
	K+I4JK6MGo+zNtNCGYCjkc7QYNQ7MaAGDiteW5ATHIzJCt6hEUvrHLh5ghUsQT/Q4Hgt2dEaANa
	gAq3CjDiuGLRgpljaCdI5UR35v5Q0FtqYNEEPtkop3cKmkIMKk1sIMqDcEmzcyUiVvwfYj7O5Ng
	9OHJJVXdDJQ6nKZQzkKCl5t/U6hFVj41zXu0YLv0suGLiuM/rzoZqVGcilqKIgpzjEM6AUUl897
	FSMQMMBj9P1r09TqCiRbBgruDF8EzYHSMq9n/
X-Google-Smtp-Source: AGHT+IHd8S//p6vOsVTG4x5VxdE8TgAqYiOfk7VAHWwTIJ/ja0G7fBRZA7iqBF/C2V/BVdk/rCDUYQ==
X-Received: by 2002:a05:600c:3507:b0:458:ba04:fe6d with SMTP id 5b1f17b1804b1-45a1b60ce04mr17300535e9.14.1755163643794;
        Thu, 14 Aug 2025 02:27:23 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:ea13:2485:4711:708])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c790689sm14706025e9.28.2025.08.14.02.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:27:23 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 14 Aug 2025 11:27:10 +0200
Subject: [PATCH v2] phy: qcom: qmp-pcie: Fix PHY initialization when
 powered down by firmware
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-phy-qcom-qmp-pcie-nocsr-fix-v2-1-fe562b5d02a1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO2rnWgC/42NQQ6CMBAAv0L27Jq2Aoon/2E41LbCJtKWrSES0
 r9beYHHmcPMBskxuQTXagN2CyUKvoA6VGBG7QeHZAuDEqoRF6kwjivOJkw4TxGjIYc+mMT4pA/
 KVpykaFVXGwulENkVvdfvfeGR0jvwus8W+bP/dReJEjt9tkI3Vj3q9vYirzkcAw/Q55y/t94P3
 ccAAAA=
X-Change-ID: 20250812-phy-qcom-qmp-pcie-nocsr-fix-1603106294cd
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Wenbin Yao <quic_wenbyao@quicinc.com>, Qiang Yu <qiang.yu@oss.qualcomm.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2

Commit 0cc22f5a861c ("phy: qcom: qmp-pcie: Add PHY register retention
support") added support for using the "no_csr" reset to skip configuration
of the PHY if the init sequence was already applied by the boot firmware.
The expectation is that the PHY is only turned on/off by using the "no_csr"
reset, instead of powering it down and re-programming it after a full
reset.

The boot firmware on X1E does not fully conform to this expectation: If the
PCIe3 link fails to come up (e.g. because no PCIe card is inserted), the
firmware powers down the PHY using the QPHY_PCS_POWER_DOWN_CONTROL
register. The QPHY_START_CTRL register is kept as-is, so the driver assumes
the PHY is already initialized and skips the configuration/power up
sequence. The PHY won't come up again without clearing the
QPHY_PCS_POWER_DOWN_CONTROL, so eventually initialization fails:

  qcom-qmp-pcie-phy 1be0000.phy: phy initialization timed-out
  phy phy-1be0000.phy.0: phy poweron failed --> -110
  qcom-pcie 1bd0000.pcie: cannot initialize host
  qcom-pcie 1bd0000.pcie: probe with driver qcom-pcie failed with error -110

This can be reliably reproduced on the X1E CRD, QCP and Devkit when no card
is inserted for PCIe3.

Fix this by checking the QPHY_PCS_POWER_DOWN_CONTROL register in addition
to QPHY_START_CTRL. If the PHY is powered down with the register, it
doesn't conform to the expectations for using the "no_csr" reset, so we
fully re-initialize with the normal reset sequence.

Also check the register more carefully to ensure all of the bits we expect
are actually set. A simple !!(readl()) is not enough, because the PHY might
be only partially set up with some of the expected bits set.

Cc: stable@vger.kernel.org
Fixes: 0cc22f5a861c ("phy: qcom: qmp-pcie: Add PHY register retention support")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Changes in v2:
- Ensure that all expected bits are set (Konrad)
- Link to v1: https://lore.kernel.org/r/20250812-phy-qcom-qmp-pcie-nocsr-fix-v1-1-9a7d0a5d2b46@linaro.org
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 95830dcfdec9b1f68fd55d1cc3c102985cfafcc1..80973527fafcb294273dff1864828532dab738db 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -3067,6 +3067,14 @@ struct qmp_pcie {
 	struct clk_fixed_rate aux_clk_fixed;
 };
 
+static bool qphy_checkbits(const void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	return (reg & val) == val;
+}
+
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
 {
 	u32 reg;
@@ -4339,10 +4347,12 @@ static int qmp_pcie_init(struct phy *phy)
 	struct qmp_pcie *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *pcs = qmp->pcs;
-	bool phy_initialized = !!(readl(pcs + cfg->regs[QPHY_START_CTRL]));
 	int ret;
 
-	qmp->skip_init = qmp->nocsr_reset && phy_initialized;
+	qmp->skip_init = qmp->nocsr_reset &&
+		qphy_checkbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START) &&
+		qphy_checkbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], cfg->pwrdn_ctrl);
+
 	/*
 	 * We need to check the existence of init sequences in two cases:
 	 * 1. The PHY doesn't support no_csr reset.

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250812-phy-qcom-qmp-pcie-nocsr-fix-1603106294cd

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


