Return-Path: <linux-kernel+bounces-777707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C852B2DCED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64E24E6CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D71B31B11D;
	Wed, 20 Aug 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hkCtMmJz"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5E311C0C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693787; cv=none; b=Z6b7VzvNFbZAulA+gTcllPIx18hLYwvy6C0VBAaygOvlQ/4Wimxx1jb+Ui6KHuwrYktqiPTwuOj1325wO+fd6MYEY+DHQZZyChRFReV4vHWxqVjm+wFfGpS+ruscjhpPGa0xBiIIKbOPzrxrsOJHGUSi5ZUpJIdtxvgZ4UqNVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693787; c=relaxed/simple;
	bh=7HeBaIxl7KiuIAyKpj+m8oswjIWs+2EP4qDg/8DlPJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=buyM9fHVQKx34MmvEx3yYqE5Tzm8LSZuEIe7gC7tynFWq/6mQC1Zy4DrYX9ihkhewl2nSElPg2uWvlkf9So4t2P5bq5VdL4z6xJf2G16S9NJjzXR4wSrLsouTfBSaecNcyR8Wzf8KcM9FQ+y6dJmJldwimkbgIIKbfElGeuN7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hkCtMmJz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb78f5df4so1063190566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755693784; x=1756298584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tab2Hleppcwxq/kGW4SqXuYxShPYsb+FlXIHcmWLRu0=;
        b=hkCtMmJz8yvPv573ABp+YnLK2ty+XjI78ruLfih6MaDDRggqw7eor5ZvjiP1UoXS/m
         3wtEsSxTsi8EMac3GTI4+f0Exvv8Tr9BoI5Ncn3P1bZANPgD/TJ0lDj6LIHnzGmWszn0
         tp6QyZKT70ucq69Az04iLIQ08BV+C4JJRNRqUpCZ9zRB95d1cA+t9a2p3PhOGOHidwex
         5ROgBiaYP9VlMmJlxnLKqvTR2/MgtVz2VbtmKkhlIWWl9fegdoDlkNi39toV5frG9bfD
         Aw1n3PezANTlATAd6Z4CAQbXowxT42QUif23lMb2ZHDXAeMImeEV6aFvnDNZ8q0ahdts
         9vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755693784; x=1756298584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tab2Hleppcwxq/kGW4SqXuYxShPYsb+FlXIHcmWLRu0=;
        b=INwmqCGtKflPR4685O+27rDsNDsfvgPBz8w/pamITxT0WTU28dK5uj3ItgU/Xl4Wzk
         Qa1/svpcKwHSeHQ2uXGB6x7hX33r37gYgDUcY0NQ44di+ayp2TZGdGNUmXuHuyK7grzE
         GHTrsuH6j/kVVsmXl8OGEzPrFHcAaC7FG15Pne/gPH8XPRu8NcHLSfVy5LDW2H+1PwlG
         8hocC0A5EkfRBUU8g9uTAfQP6UgVXwL3zNMvlcHmXB0ZFsmDEOgfGNcclbfcQ+AvHgfQ
         RkBMvZ8sNZMOztC3yKTV4Ck2hNR9Up1/ctYHpt2v2TGUQti1drWOzc/piYfGY/tzbFVN
         1Jdw==
X-Forwarded-Encrypted: i=1; AJvYcCV3jO87xpEEy13SzSGFhB77V0WvsitPmNCyvuUx0FsDkw6VtRThVW32fd7lH0VgbsukpP4w3j7Of/DSi0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCFN/gNWWQOorMOv3PHmVTo73+MJHP1soZgOcF0xcyQJ9zTiyj
	2wbaF7YYO7wYAR78r/+OWnAL7R9HsF//zabiYD+EbBPQ29THN3aPa+F1CQv181lJr3g=
X-Gm-Gg: ASbGncs5EtPz84mPOqRmga4N0/UsRJjjqHaIpcjORs5MQihmhU0xumvoLEgQq/qQiHO
	RkjbZokHMsWdaEmjtrCw+22DsEtjRw23Gzbb2bF3JG7X8Ipl3P+bANkTMEmTA8KKJwm5mFwaKym
	PfVsHH9Whsp1VO4N9EhSQBa17QEH8RVvAuH//WMXxer4usk/cGtVbGrma0Bn8lHuKLLNrRRosxO
	S8sPx66ukUCUbUmJV+SkOnepm/tzlPlM7F6WmoJTA1E4RrOUiPqFOlluTcwibxdAB1BpwHE9ogc
	e3Hv+02a+pdNu6B7MHitzxXhLhgUjp6mpPxA6piAFlbe7ggIptA0ofY4ZzZrIzKrO3daVZc92KB
	lm+w9jurvtPYSzQE3eQ==
X-Google-Smtp-Source: AGHT+IFm7jH5BGc6rdlbvbZkPnXZ2grgH+UcbaItSluJX1MzgInudyFqKiuw/HXm6Db74/4zVrXUdQ==
X-Received: by 2002:a17:906:4fd1:b0:ae0:ded9:7f31 with SMTP id a640c23a62f3a-afdf0088379mr260077366b.20.1755693783935;
        Wed, 20 Aug 2025 05:43:03 -0700 (PDT)
Received: from localhost ([2001:4090:a245:849b:bc8d:b969:7631:815])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afded479020sm174592466b.74.2025.08.20.05.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:43:03 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 20 Aug 2025 14:42:26 +0200
Subject: [PATCH v9 2/4] can: m_can: Map WoL to device_set_wakeup_enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-topic-mcan-wakeup-source-v6-12-v9-2-0ac13f2ddd67@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; i=msp@baylibre.com;
 h=from:subject:message-id; bh=7HeBaIxl7KiuIAyKpj+m8oswjIWs+2EP4qDg/8DlPJ4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoylhw7XlSiK5HXte7DwRmPdOp/JrYvDE240Tr59ULlth
 nTxX8vPHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjARLVuG/2m/2XpO7cravWSF
 jn8b3668xqeZy6dlLrsmE/EzMy+Faz8jw9TdUto9MiyWAhM/FcQkiVoqy5f/TLnvPN9DXnVjlNg
 JPgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

In some devices the pins of the m_can module can act as a wakeup source.
This patch helps do that by connecting the PHY_WAKE WoL option to
device_set_wakeup_enable. By marking this device as being wakeup
enabled, this setting can be used by platform code to decide which
sleep or poweroff mode to use.

Also this prepares the driver for the next patch in which the pinctrl
settings are changed depending on the desired wakeup source.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index fe74dbd2c9663b7090678ab78318698d50ffb481..c68c95cc97075ddf72dbd2f177a999a09b8a21ca 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2222,6 +2222,36 @@ static int m_can_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
+static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+
+	wol->supported = device_can_wakeup(cdev->dev) ? WAKE_PHY : 0;
+	wol->wolopts = device_may_wakeup(cdev->dev) ? WAKE_PHY : 0;
+}
+
+static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+	bool wol_enable = !!(wol->wolopts & WAKE_PHY);
+	int ret;
+
+	if (wol->wolopts & ~WAKE_PHY)
+		return -EINVAL;
+
+	if (wol_enable == device_may_wakeup(cdev->dev))
+		return 0;
+
+	ret = device_set_wakeup_enable(cdev->dev, wol_enable);
+	if (ret) {
+		netdev_err(cdev->net, "Failed to set wakeup enable %pE\n",
+			   ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
 		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
@@ -2231,10 +2261,14 @@ static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_coalesce = m_can_get_coalesce,
 	.set_coalesce = m_can_set_coalesce,
+	.get_wol = m_can_get_wol,
+	.set_wol = m_can_set_wol,
 };
 
 static const struct ethtool_ops m_can_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
+	.get_wol = m_can_get_wol,
+	.set_wol = m_can_set_wol,
 };
 
 static int register_m_can_dev(struct m_can_classdev *cdev)
@@ -2361,6 +2395,9 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 		goto out;
 	}
 
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+		device_set_wakeup_capable(dev, true);
+
 	/* Get TX FIFO size
 	 * Defines the total amount of echo buffers for loopback
 	 */

-- 
2.50.1


