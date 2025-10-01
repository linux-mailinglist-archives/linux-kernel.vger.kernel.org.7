Return-Path: <linux-kernel+bounces-839050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED40ABB0B60
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDD3A4E26B6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06C7278E63;
	Wed,  1 Oct 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bMFxxVxV"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD072263C8F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329081; cv=none; b=R5Cuj7DgIEJEZdnumoKJW/FUrYhCnZCwG/RPfPagwhu0OoCSiddZGeB1b4S1p6HMILrUtlL7x8A3B9eUBse5I+cHnKB/qKdB7BgOEMMmbGsq/lxxdS2lTstkFwAWpQXK8etjd8VZB5jNIcGsVEc5kYtc60UVMEl2JOFmCtCJ+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329081; c=relaxed/simple;
	bh=dGNKUYyd1GcPkcAeE2bAQ6pVMh8WKK5GW2+M2rPmnUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UjwNk+AgqjvWueOgIlr3OvL4PtP2VcC8rOVXX8XyEYxAXhDwoZ8/Vrj9Qm/kLZanTzKwOQkxF8Txl0uEJzyz4MFCRc57rEcG4HMcwrDrECoZ7W9/dg1wnHVscFbK0jJAKefVQ1ZvXZxppTCU1KxAiJA8oW69XHM+smrNR7081WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bMFxxVxV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3d50882cc2so729533666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329078; x=1759933878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jREFPccbCelJ72h80iGG7hSrznfTVGMEZeaHF1+Ijw=;
        b=bMFxxVxVHJ9a1tjRfF5Z0wbyhuTt/SZzezx4TKS5cfUrGJpwrOw3N4+GTuOeqiUAR5
         fj3w1F+zWG3qgPneGujKS2hg7w5GRp8H7KuuqPVaV1ExL09ASkZ0x4HCFbagXe+S+iH+
         rIW0MLcC9dSgndA+ySfpUZ7JH/mVX1HNGUiGMCdO0oS3Z1Mmtvq8iwfqJHa2d/xg+bHz
         ZfX5D8yzghb9eV1Wq2XJVLSkO54rbdMknFJdQVdylzIJMn8MVjRX0COZ+Wt8Dhk03GWr
         aP2gaehL00aV/pl9uCjKaqfk4wi50wEF6M5dTAZ1ZqyFLwMs8hWRreRVMe3qKlkojdk4
         mq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329078; x=1759933878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jREFPccbCelJ72h80iGG7hSrznfTVGMEZeaHF1+Ijw=;
        b=Qb152ITUhmTW/gP71fVtdwCB/y9suYGVkkyqgd1LhdNXWMKf18oiRyva2TaJkuHG7F
         6P5LPKVIWnJDW7/JqFh6cPawQkB2jtY2Ejhbg/MlM8dI1u0kcT8vgM5Qt3Xk8DNa6zVV
         OgcWmt+AteU9zm8u41/LI6/Pky+J2Rm90KjwWMqaqRV1GFIsmmpgNuu4nNw2xie0cTb6
         LU5mh5xFOaYuQZ75b6xuIDdWMtCQjJzvqfVGVZMkessWNEQzn7z1KtfP0nZCcq9pztyq
         ozcGegx7dZtZf+LymPoyNRhEcOcxyN9ATZk9ca0MeR5qPh+k8/dmeK0AdsJfh9Yu4ApL
         Xd6w==
X-Forwarded-Encrypted: i=1; AJvYcCWtgTGLuWbRMBf0XOAaG0Dkyo/tbkjJj62dfdV87qv6XLB8rM7Nl6OE77xtZX7KU+D2GNkixJFdMCbcHYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJap+drWXbCz83HvImUgdqqpSDMvFuFor3be0/iutZ9NAMhZKv
	wQcloxoSWA7NZdfbnlaq3xKPU/8ecC12Ma2qCPP/Na4fZYG9LzmU34CgqypVS08pNu4=
X-Gm-Gg: ASbGnct1o8kvn5JydZ2jCCDA9yb6IjPfpv+hHDgHY0FF4g1SKyZifSUCJS5vWCGARO7
	fvgmVzkt/CkUYj1y7iRMLiaPlInlwt3aYnnfmifTtNfrwa1ym5S/gjuHweuf32epK0PUv3UokfO
	wPSJ2JHf1+Xx+3GdTCQ628m1FwWnlqwtuttmR7FbS+ngIfKk3JSSkqu786KL4nUbQUyKHtXl2Xb
	1sEsLSO93Tk4RoANfTwAGsQYaz78yVzuubceG6vLJydBsVeHBTqMOmA595pc4pZ6pbTSmHYLHY0
	cuXa8VC6X/INtOcb9MP+sguaaHggAtPt4D6RjoQk99qdds/FXYMxYry19SdQfszyv7IlyZZQRQF
	Mm/iTwGIaFTpWNUMXbH/LbG3Hnt8cK/61br2xdvz7GNRg
X-Google-Smtp-Source: AGHT+IHZXKxH7sl9HXx/f6ZsQ8CTEdKqXA1aGGa4F13HSaz/0//WfPjylBTEEEW/DaVIOAGT2bHTxQ==
X-Received: by 2002:a17:907:9485:b0:b3d:98fa:b3fa with SMTP id a640c23a62f3a-b46e8f7ddbcmr416304066b.50.1759329077998;
        Wed, 01 Oct 2025 07:31:17 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b353e5d0526sm1391484766b.12.2025.10.01.07.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:31:17 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 01 Oct 2025 16:30:22 +0200
Subject: [PATCH v10 4/4] can: m_can: Support pinctrl wakeup state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-topic-mcan-wakeup-source-v6-12-v10-4-4ab508ac5d1e@baylibre.com>
References: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
In-Reply-To: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vincent Mailhol <mailhol@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4129; i=msp@baylibre.com;
 h=from:subject:message-id; bh=dGNKUYyd1GcPkcAeE2bAQ6pVMh8WKK5GW2+M2rPmnUY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy71upMVceUjrXJuti1zW7023yw9Lb/0XWOnIfi5ny9G
 RxttkSso5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZy9wTD/2CtnLQ35+JZ2d6y
 pxivP3ck5+6peKkJiv8WnDw3+XuYjB/D/+qVFlsi3ffr9Dy07uv93KUXP3F5pJN+bNeC8rWGQjU
 mDAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

TI AM62x SoC requires a wakeup flag being set in pinctrl when mcan pins
act as a wakeup source. Add support to select the wakeup state if WOL
is enabled.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 69 +++++++++++++++++++++++++++++++++++++++++--
 drivers/net/can/m_can/m_can.h |  3 ++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 835b03db1003db6ffa21044ac756676fb193f64d..beb79403611b61d0643da960dfe5301e9dba579b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2247,7 +2247,26 @@ static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
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
@@ -2375,6 +2394,42 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
 
+static bool m_can_class_wakeup_pinctrl_enabled(struct m_can_classdev *class_dev)
+{
+	return device_may_wakeup(class_dev->dev) && class_dev->pinctrl_state_wakeup;
+}
+
+static int m_can_class_parse_pinctrl(struct m_can_classdev *class_dev)
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
@@ -2416,7 +2471,15 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	m_can_of_parse_mram(class_dev, mram_config_vals);
 	spin_lock_init(&class_dev->tx_handling_spinlock);
 
+	ret = m_can_class_parse_pinctrl(class_dev);
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
 
@@ -2531,7 +2594,8 @@ int m_can_class_suspend(struct device *dev)
 		m_can_clk_stop(cdev);
 	}
 
-	pinctrl_pm_select_sleep_state(dev);
+	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
+		pinctrl_pm_select_sleep_state(dev);
 
 	cdev->can.state = CAN_STATE_SLEEPING;
 
@@ -2545,7 +2609,8 @@ int m_can_class_resume(struct device *dev)
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
2.51.0


