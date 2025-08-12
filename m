Return-Path: <linux-kernel+bounces-764400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE94B2227F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641D81649C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEE72E889C;
	Tue, 12 Aug 2025 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kPmeDhD5"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BBD2E7BD8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989885; cv=none; b=dYkUqs+1ZHca5WiGbBp98MtKObcYXbgE4KqvBmMTN4WYb2sbenOo4Rg0mwRdB52Vq8+AGBDUG/ptls/3vTuqBkZJ1NIXRqi056FgrNMGCv9o1iShIRsH0fjdGgJ/KANsCzgk8ujyDnjbpgRxRc4Y//RZ+5LUqhyYj0WTJvnA8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989885; c=relaxed/simple;
	bh=7HeBaIxl7KiuIAyKpj+m8oswjIWs+2EP4qDg/8DlPJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/sma1AZ1SVQ8u4DUPuNvYCRQokRlBEBjo88AUvUrg9v1ukEVKoY77jJZq1P8ympWD0UMGyjkrh+zLE4fRtLCvGtThKCHwQ607ff44oTVRM5ZhMIGtaU+ESWnFkxxX1NTp58tOFy3RoJOve42ab8bA0CrN7IVDXGaokpeG5Nk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kPmeDhD5; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-615460d9897so5973387a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754989881; x=1755594681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tab2Hleppcwxq/kGW4SqXuYxShPYsb+FlXIHcmWLRu0=;
        b=kPmeDhD5FAxvjALjP4tGoGB+inNdAqfdaLdfBPbMUOGp/dxJdgboB4yRt6BmVRKO+j
         tOLgurwZKIXc9VJ1fqTM4K+D+F/j/HsK5MEVQjO1zFUg293IRMuBMbkafxiuDQ1/dSEa
         NqW/Jyo8rYMfR+0y/08YarRec8IbEm+a5JMmafJw1fxiQPLcPiYW7RISVxrkE3lYYGrt
         YkVi3+h9UtQ0NVF+1yWmtbMvkzkqciKU+y1fcD1Jq7eF9fLMl45N0qCz4/DWgYFi6cql
         TaTOwYxw9tQwUUtKXSgaYBqfGntM/F4kTfBgeFxDkp40hO2+Q+RO2Icgit5bfD7ZOToO
         VdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989881; x=1755594681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tab2Hleppcwxq/kGW4SqXuYxShPYsb+FlXIHcmWLRu0=;
        b=d3zUnXcIdrqJLg6amaLiAjaA1hEez6Wnsq8Yu06ssbIbtVAt6IynChzKQGdbFOS1OG
         8eAA/0/v+mYSyBBDv4PkCHF0OvvL+yR8h41HSsMN/o58WhGGHhmjZfcd2p2rIO3fxkho
         PDlVodHoQu7/ujS8+QbLSrYXq6wMkkGctcaqhK6V/AFN637FpoJ+D2HfgkIcnrLdGfXH
         b11jZQ+VzE/S0aFZ2lUldTyiLn7MfgHsScqvIT/b2pARSJHwFkLV9pzvq35hfeD4zbtj
         03Jtxe/SQPxOZUDSgOJKQZl3097knLpolD1YcZs5ErOc8K5zbnmblmLLy9SR6IgcW66R
         NtjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcowMgkFXsXVhsMnaQjv8b9HfU7xSve/ISIs/IRk3RWo0w69n1/iJ0yBGP+zYc22kx4CtMJlVz6o3FHp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsaqOxz32T24IDhop+tDgg1eJkDXE59frBZBHOTRIykf8j4Id
	wA65IbhXMadREdPwo+cDrGQno/dWS+bTSU4f+3V9xLaV6IibAfeIUAchdSliMpBzYQQ=
X-Gm-Gg: ASbGncvlEzYT3PFHhmIwS8q18PgwM5gl6jC/e/34uI+b/9FmIL6dV9rT5GIrS5edp/9
	CkXkzWe8pntkzcoMYJ+NGPgQwp3A9k8sE9jZ2WPEf8Xukr9g9ieJx1kG0xUs2fnYbB3U/blhuGr
	/CJpuyh6z8Q9aizPqZfFnruoU8L3h5u9s9P9hinBgSI1VfrXOucSFKQpT2zjjwbYAL2HqBNMqgq
	Gnu/J4n84qW1iRv37zk3i4AGwTwzuAu/CeskfZPNDMoC7p9Bum3Q4Br3qQbBCVx0ZsYQidlFi9R
	yZsCtGJxq0Sl48MYeWtUeRu6tcPsq/OBRji+Beao81+/TmHKmNriiukN8SFinjb3dj3VmkCTsOo
	WGQQkF/ASzxbyiMwulQ==
X-Google-Smtp-Source: AGHT+IHPxUGsYIldlBjy9IVCUNneJwav173jkk+gv6YRSlxVsAj3puThJVXHvEdhCSuARsmrxJk5iQ==
X-Received: by 2002:aa7:da54:0:b0:617:b662:2272 with SMTP id 4fb4d7f45d1cf-6184ed1586dmr1577163a12.33.1754989881450;
        Tue, 12 Aug 2025 02:11:21 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-615a911567fsm19426350a12.61.2025.08.12.02.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:11:21 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 12 Aug 2025 11:10:23 +0200
Subject: [PATCH v8 2/4] can: m_can: Map WoL to device_set_wakeup_enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-topic-mcan-wakeup-source-v6-12-v8-2-6972a810d63b@baylibre.com>
References: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com>
In-Reply-To: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZrGq86g0F39UZxP33+m1/FPp9RqS6aFJV371zPY7nN
 p37+HB/RykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExk4ntGhoXcjd2y5hWFbQ09
 HG1JD0y2lWR+61RRyXS/Z3nrfu6auwz/9F1XrZ19y0BS7vL2opz9YaY682MmR7u/15zudtji+/E
 +fgA=
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


