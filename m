Return-Path: <linux-kernel+bounces-839048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B58B2BB0B51
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AEF1899FBF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF326462E;
	Wed,  1 Oct 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vXVt2X3a"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C0253B52
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329079; cv=none; b=WdpR1gi+8wsCvq95DfGMeIcNFCdHUzm+yVLoFJ7DTzNTTImPZB+VCWMXh+x0uRlc6/J7sRRIz3hbTLX1rNUi72TQLNhtlqUan8OQ9izvHh9nKl6WCGKW7m/su4kHz12MuUNZzjk48NCW/mLTSU7tUM4NtuwC+j7CERXbTWGuPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329079; c=relaxed/simple;
	bh=xZlvLU7Ypb0xKlRYD5iljCSFnDT7FHVy6fNCxwcJyWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVLCz8mQF8cat0mec/NZ7JCqctgXGPeHdOnFdU0IHid4i3pNqHcDEWEndCApDn5f9eVSHCXeTeOZz4x4xoxMC/9IQG66R9PrEsrmLxynLIT4TiO+8uFjm1dG9/n3I6RJ4pypX/xwPMh5rwsutKJXX1b7J/I/dER/JGuBpmqwVGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vXVt2X3a; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so14567781a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329075; x=1759933875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dzk1cyUo2yEMvFwDWljkPdo7pcoK+QmbShr4jxlb2e4=;
        b=vXVt2X3aBfV9Sr2VW6jz97BBtD0orWG6kIfmIPHOqrANqwfjgML0CUfVdfzk0kdCxu
         VO0LTmI5lIUq3lRXgM3FTcK9Zcpibq9tASsF8flKhjEdZNw/tYmXJHn2iNY3PpLxXWt/
         843ICzkhYJ7zL3ywtiIsVLsavec/sVWv5hG4ppt6V9jh5+9Xf4yBuYaPiH9takeEaRxb
         9olio9kEO7jK9ZFgMDLdJiy/gNKwUZB4pggDIbxoMGLiNHCMd/38tP7wFgk+x4owvAOV
         gVK4n64hsjoopuD3eJFzKPURqM8NudgLilvAg9adtql4XB6z7lLjQzllPKEOP3j4NdxD
         o9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329075; x=1759933875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dzk1cyUo2yEMvFwDWljkPdo7pcoK+QmbShr4jxlb2e4=;
        b=gN5KxYPZINMfs1ZV3t61Tfvu5L83zePH4QQNf3gj28Y3kpYuU6Fketl+ymRVqomY8u
         r5MUZHjw99e/jdUhInkaWiPbKceNahCjud1mXgQ5NCPILlOMwH9F/WS0+QbVqYZ/18CR
         JxumPOslxP4tj4FJW+LiLLkezlVF6C9XDaZ9J8OHUkdluYI02LHIzCIgSER7tL5qz7F8
         KSviHxqKrnRpJFDQ1PE9q2uKNWafrZuL2KfX+LvjhYdfyexyK2BHKOJRQGXwHOiQr3Ii
         093ZUovggnPg8wFutUO4ywbDk0mj5ycoqF5LdCOEp1FaZL8+aAOSEYt+W8P5sxoL8TCR
         iZkA==
X-Forwarded-Encrypted: i=1; AJvYcCX/+A5Pdm0jFlYVxIvXC6S3bEYUdUmOKSTu9kX99/rjJQpfWVK2HFYMju8yzOuh011TDIDG5sFOYSGxJmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMxRbj5STsQ9eLQSteHgo2/S6PWpjWN0mtObGKsakqA6U4N4a
	ozFndwfdrTCStvdTUdVvDpi/SasBSCiH1KCJzcXysWA5yQdukev45X358l4onSut/28=
X-Gm-Gg: ASbGncsFglLCC23ogV5ztT+sneU+jsibKIqiN7tT06EmX9GUm4XxobthRVcC2sHUDE1
	m1yXMw1HgaVLb4YoCQSqHiPv1+OjSMqqmH0+Gsj6snWY5JMTwDjN8udzPqk2OOYf91nD9LlrorJ
	Vi9jYxktvL+RNikBsfFCHKyuK2Lljz4NmH8bMwBXG+X0oMj6EH+7py5Ev4Ja7lvQhuHfYZXlS5j
	pJBA3HswqUG0HF6fYIa0QYUff5GdcazB8F8eSZYToixHOLvlK0GP/kAC0ot1SaLTPiUjupnPkIy
	JGbbTBNVnSsbap0Het/aX/DEt33H8tsssGMvfPuTdxAiae0Daedl0G9T7zPFqRA3Uiw6BQwuhfT
	SDcphAewfc8oNzD4gtsy8bGezjzOxpda9bdsyCm9CRVBM
X-Google-Smtp-Source: AGHT+IHrAMb+09uZwyMeIOg5Yw3oASNR/LZNf7+KcvjDZ2MgIgL6Lyu/U/SVL3McQ0r9P6GhOXrzLw==
X-Received: by 2002:a17:907:94d5:b0:b3e:580a:184f with SMTP id a640c23a62f3a-b46e0cb30f8mr499997966b.4.1759329074660;
        Wed, 01 Oct 2025 07:31:14 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b3e89655b09sm683210466b.77.2025.10.01.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:31:14 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 01 Oct 2025 16:30:20 +0200
Subject: [PATCH v10 2/4] can: m_can: Map WoL to device_set_wakeup_enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-topic-mcan-wakeup-source-v6-12-v10-2-4ab508ac5d1e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2895; i=msp@baylibre.com;
 h=from:subject:message-id; bh=xZlvLU7Ypb0xKlRYD5iljCSFnDT7FHVy6fNCxwcJyWU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy71tJMSUE53iVthy5YThN0+73q8y1GK/H8EwWsX2/cE
 J3Hv+xeRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExEbT8jw565j2qrd019MH9N
 HMuW/luP/1xe0hR8fMvPlNxpS4/PO9DK8D9oLTvLHtYfPJ9NmLNdTmSuqpdg19kkd8HMwOOO0IG
 7otwA
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
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e1d725979685ff90bff9957bcf6193265bfbcb55..e5588e2205797be03090a7317e9d3518bc09b054 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2220,6 +2220,36 @@ static int m_can_set_coalesce(struct net_device *dev,
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
@@ -2229,10 +2259,14 @@ static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
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
@@ -2359,6 +2393,9 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 		goto out;
 	}
 
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+		device_set_wakeup_capable(dev, true);
+
 	/* Get TX FIFO size
 	 * Defines the total amount of echo buffers for loopback
 	 */

-- 
2.51.0


