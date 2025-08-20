Return-Path: <linux-kernel+bounces-777709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EB8B2DCF8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9133BF697
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080CD31DDA2;
	Wed, 20 Aug 2025 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ost3O2TR"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0743331AF20
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693789; cv=none; b=W5qaY0OH2B+6MaG/GpW4Mxxw22MArZ7PrP0IKF2IqVQdbltVmemiwy5tNJiuI86qsGYsZHp5q7kwglkQJ8XvE+bCIefcqzYFanLG5viFaS7XELOe5XQzZCZ1n5tRAUAzlPv63DWjjabEED6ozZiVR8/9JUKyWgJhChGwr5gbG+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693789; c=relaxed/simple;
	bh=TOwm5GeDltyW8g1BjUNaPqKx7lJuDWRSNxQq9ddG4no=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YYasaktfZfLlZyKaSXc5y1kIouR6c1vnyIhRonHcHk/34lDz7/1wdB0afG19IxB3jTMSPCCw4F+x8PxA5aWrDDRwlbRnXfh7L8xKSmv/vAPoZAlXF4o5qCvVhv6Tim8/+xLyyD2wreMUvLNWMZpBmEgFoyp+facRJQ0hW6oSzSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ost3O2TR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-618b62dbb21so9361512a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755693786; x=1756298586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKnmG36C30GxSH3hoRhxWEid53U24Ul1qCYrbUJ7ElQ=;
        b=Ost3O2TRpGGBmPMBD198Cn7YK/Si6nJl4lpovW6HKq1EgWja+vtQh+0pNnsokojX9M
         7r/jFLs937fTD6hTdWkqG1YTYGAudv7GCh6iGQ8gqfyZlwDqBYvs5n7jo4aqm1sljNbT
         djSPF3GMd3CPQ0pXl3UQtTfXrf4aLJ8iyx2mRQIeBM1w86wd+W3vTPYih2GLLfVfyOrS
         maLTOn8EOH36PssYKQe/mTzdNu5OuEqB+KMscANJ0IrFq9griAixu5p8TTvBj1uI/Q8D
         98HUMCaT3bEsWGI4e8BWXKhollqqGzcGv3vF9vxAO2l/QsfecDBAr+HzPcrR3RwlYULl
         wjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755693786; x=1756298586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKnmG36C30GxSH3hoRhxWEid53U24Ul1qCYrbUJ7ElQ=;
        b=uTVTxQ4A7/7isy12umVCyMPI4A3ja7aqXBo7nExQkD6U4KOOwmAQZ53hjQBU7aYNaS
         IaeT6N0JFs9yEhqGMKYyoiWHVgBT+lTuHZot39/HHsGb8UBAKYpc9gB8Usjh6PCfMM93
         ++5iyeVk/w4qJfCPT0wyBonJIhgvGIIs7g6DEDyD8V+7ooOm+Z6n6MpKHumsW2cVkxpY
         3yqfmyu1oPbXc10ccHdMSQFx590aFmXviKbWsZKKCGQ20V8lW9LdBf59+oELhhEmiJPi
         hV+EItvzw9STJq7LZKla+MrEZQ7ZvxMBAOKcMSYnFlo0iHQB9x+WuqByTkG/FSeX3vAs
         zGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/QvyKRgBYKprykAGkM7kwrPcVhNpjYLNd7ON46NuQJqekFiEsJnQkKixMmBG/pNDR7M0Sl+P5lRsjyMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZzKJoydS7ockVUJMMD2Y/odeKWgqNokzLLRZaKwgX/jwm7fEU
	PTIJ9iU+fbAOQ29eHJNQ8kGGk+kNVMZye0Y4jv03uLGTc8MuVT7HoaYD7f4UqmklHwE=
X-Gm-Gg: ASbGnctp4v1oDifQieNA6Zp8HpuT5IxvWd2U21ZXEQWyMSJMUvn0MtlxdxuDKOXSbDX
	imfJ2H+hrQlRfHgFHOLK057yBLv/y/Kj+MmIiJybxJ9VyryzMwtdV+O+L6rbBLgYGQjHpZQ7JKT
	H2yeOCyG+EMgi6/EkUYU6Ept4he76uekcgDxKpEBbsny/LDkWGOtLpCQ1VQbGG3n227Nig5qpNO
	UGbczu7CHMfqT9W5UcvB/xSF9hrDry2a+G52W3OTFyD6RFj9lxrz8hubfaJRa3jMZxb/qZxrKqi
	Q93aoSs40vfxvxIpICtsXVkUnt37zS8iKiv6NyI+lxwf+kg31b0LTDNduQ86ks02EkAc5h5wCSq
	rKazIL0nJEInKerofWg==
X-Google-Smtp-Source: AGHT+IGoF4BJJCHM7/WMYV9s2DobB8jP5J4pI3kHVya7qPry9NoCLTUd881tRnbGuOS3zY4hXBMZ5A==
X-Received: by 2002:a05:6402:46d4:b0:618:af06:a7ce with SMTP id 4fb4d7f45d1cf-61a9752ba07mr2379696a12.1.1755693786433;
        Wed, 20 Aug 2025 05:43:06 -0700 (PDT)
Received: from localhost ([2001:4090:a245:849b:bc8d:b969:7631:815])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a756095f1sm3318213a12.22.2025.08.20.05.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:43:06 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 20 Aug 2025 14:42:28 +0200
Subject: [PATCH v9 4/4] can: m_can: Support pinctrl wakeup state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-topic-mcan-wakeup-source-v6-12-v9-4-0ac13f2ddd67@baylibre.com>
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
In-Reply-To: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4131; i=msp@baylibre.com;
 h=from:subject:message-id; bh=TOwm5GeDltyW8g1BjUNaPqKx7lJuDWRSNxQq9ddG4no=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoylh86+OiobeGfvDpXjW8R8HoS8fDTRSJrt8aXJbl8jV
 E1vTy9m7ChlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJfM1m+MMbI8x5PbFa4yGH
 ww15hutqPv4LhBWMFE9MyhdkD+x8dYOR4fDGbQ5dfnVndtYsyj/x9opCB/c1G0W2GdOE1++xN0r
 5wAgA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
a wakeup source. Add support to select the wakeup state if WOL is
enabled.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 69 +++++++++++++++++++++++++++++++++++++++++--
 drivers/net/can/m_can/m_can.h |  3 ++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e08fae5ddf5efa8345670dd50d50954ec5d52b29..a1fa4b2f6b6cc94e5e10259cca53bd931ab238c8 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2249,7 +2249,26 @@ static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 		return ret;
 	}
 
+	if (!IS_ERR_OR_NULL(cdev->pinctrl_state_wakeup)) {
+		if (wol_enable)
+			ret = pinctrl_select_state(cdev->pinctrl, cdev->pinctrl_state_wakeup);
+		else
+			ret = pinctrl_pm_select_default_state(cdev->dev);
+
+		if (ret) {
+			netdev_err(cdev->net, "Failed to select pinctrl state %pE\n",
+				   ERR_PTR(ret));
+			goto err_wakeup_enable;
+		}
+	}
+
 	return 0;
+
+err_wakeup_enable:
+	/* Revert wakeup enable */
+	device_set_wakeup_enable(cdev->dev, !wol_enable);
+
+	return ret;
 }
 
 static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
@@ -2377,6 +2396,42 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
 
+static bool m_can_class_wakeup_pinctrl_enabled(struct m_can_classdev *class_dev)
+{
+	return device_may_wakeup(class_dev->dev) && class_dev->pinctrl_state_wakeup;
+}
+
+static int m_can_class_setup_optional_pinctrl(struct m_can_classdev *class_dev)
+{
+	struct device *dev = class_dev->dev;
+	int ret;
+
+	class_dev->pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(class_dev->pinctrl)) {
+		ret = PTR_ERR(class_dev->pinctrl);
+		class_dev->pinctrl = NULL;
+
+		if (ret == -ENODEV)
+			return 0;
+
+		return dev_err_probe(dev, ret, "Failed to get pinctrl\n");
+	}
+
+	class_dev->pinctrl_state_wakeup =
+		pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
+	if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
+		ret = PTR_ERR(class_dev->pinctrl_state_wakeup);
+		class_dev->pinctrl_state_wakeup = NULL;
+
+		if (ret == -ENODEV)
+			return 0;
+
+		return dev_err_probe(dev, ret, "Failed to lookup pinctrl wakeup state\n");
+	}
+
+	return 0;
+}
+
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 						int sizeof_priv)
 {
@@ -2418,7 +2473,15 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	m_can_of_parse_mram(class_dev, mram_config_vals);
 	spin_lock_init(&class_dev->tx_handling_spinlock);
 
+	ret = m_can_class_setup_optional_pinctrl(class_dev);
+	if (ret)
+		goto err_free_candev;
+
 	return class_dev;
+
+err_free_candev:
+	free_candev(net_dev);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
 
@@ -2533,7 +2596,8 @@ int m_can_class_suspend(struct device *dev)
 		m_can_clk_stop(cdev);
 	}
 
-	pinctrl_pm_select_sleep_state(dev);
+	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
+		pinctrl_pm_select_sleep_state(dev);
 
 	cdev->can.state = CAN_STATE_SLEEPING;
 
@@ -2547,7 +2611,8 @@ int m_can_class_resume(struct device *dev)
 	struct net_device *ndev = cdev->net;
 	int ret = 0;
 
-	pinctrl_pm_select_default_state(dev);
+	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
+		pinctrl_pm_select_default_state(dev);
 
 	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index bd4746c63af3f0a032910644dfd48a9ebb3a6168..583c7f1d005d61b3fc8587697388522993ff11a8 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -128,6 +128,9 @@ struct m_can_classdev {
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
 	struct hrtimer hrtimer;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_state_wakeup;
 };
 
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);

-- 
2.50.1


