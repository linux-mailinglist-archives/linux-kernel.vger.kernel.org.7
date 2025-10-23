Return-Path: <linux-kernel+bounces-867231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A2CC01F62
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC733A307E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA233373B;
	Thu, 23 Oct 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp3E+lrE"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B0331A7D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231550; cv=none; b=DMySujfPvXRsdb3wrimIf2aJLw4NDJ9UEc/VyomDX8tg6g0uavpVMFYlIrArHq8I73bml+ZWBqIxqSza6Sva9yWGbV/km8J26KkrDIjZCPRaITIlRXVqTUh/+MrfcCvtOPaYdCU3Vb18zcgkPl4fSo2OL8e02RqmCC8c6BPdDf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231550; c=relaxed/simple;
	bh=GWncG2Nrp5wbjJ9YlqbO5+Je+RzL8KJvhc7zQ2NAfZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoTgceCEDUz4z8NhPaIDOpV9+odv8OIW4rETgE1tb8a4QEsuy6JvhDZa4A9Usk4curVX5EHwOpiLtpaw5ku+HVrD9KGE3EBwkD9tibphpF7BwB+ROBwonlyrcutDNqJJ7oh+tXrRk95+XovdTUBU2zOO14g41cXCieioFl2Ymzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp3E+lrE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471b80b994bso13073115e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231546; x=1761836346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whAejHEzxjcYOcZ1D1ZZzNRHZW4qI8QgkbdfkGYPH3w=;
        b=cp3E+lrEqxgFjyCFji2BFWr4pD03Zkxx25KStKSKbrIGt5wamva+IKkVUDTUqpBqGZ
         K40uf/vqgwDjBemoM4vSCwH7sl4XP10ryOd0gN7os0uD8rSjUBW038Tr/ie7Di9dpWKR
         TC8vVMhDNAN+seRc+6+Dc39mmAiWM+d1fUtJxQ9oRvPhCuVjayA2HMxwhJEidCyru27E
         VhfLnAtzcaES1bugffLF59OSaAPBEHPPuFCVNZzpGTxeKO0rwSfuCg/RiseGHevEbxO/
         yXevRCdDPwWj9IzB3mCsjkw37wqVzCPaz52LlYy53ZdUWFMHld/HWgC24qtuOgF7x1QX
         PLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231546; x=1761836346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whAejHEzxjcYOcZ1D1ZZzNRHZW4qI8QgkbdfkGYPH3w=;
        b=uNJdTD0kOOpv8z9O/nWJxO7DaRRVIBEdt6YKTSurwxMdZhJ/DVxgKEk6ymIfaOx9YB
         NyOBkQnqOSU4/zygTe5xeiHovSM3WSVdFgF+r8AjNPD/FKuJFgSR++pr1e3wjie8PVjK
         4bHRWi7kBav6/fzVIuikrjBS3ttV6VqDCSf27wVr18okGqD8IQDYqM/WJ594SfI2gIuu
         2BgW0WrT8Jxd+aEaFeRuryaFmXOA0iGzayMWWuW9IvjMnJurFxqK2m1HhnzB30HXALiZ
         ylPSIzrdUx5I0Rn7GN+mIGz/T4qZDCWZOxHQMFDllJuBsOV7kx6ajvNH9Kq86kzw5d97
         ti0g==
X-Forwarded-Encrypted: i=1; AJvYcCXjTQ85iAFQNJHny6REmPHeJaQu7RV+ukGLamq/rXbY7DWp/qnyc/3rG/RAWeYCtqOi0XnkJiqplXS22tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1u4msigiMdG5JUAueWLZ/fP3/sTXeJ0sSg5/tvO7PXP/rubGH
	yWVKLvks6yPlB2XD22CBToSvAQjocnCgWRmfA9msGzZH/NKsHTjhee62i9fX9g==
X-Gm-Gg: ASbGncuvzut26gXiU7P5ij6A0PRYH1XIuc6JU632K6IVo1KnlRfLfMuqsfSxDOSj/kI
	rPs4OzCtH+n3UPmjU3zukVTYTbqOL4xii9LRw3aC2nibr5nYtkK+3eZAu0lNcsaAnVw3h0GwcxT
	7zrG71FXUPyRdjKT71U5YlnMJhgCg48cZ5sNmE9lsFRWqoY7siCwedw2wUMGaZ+cbdLeWBqeBKi
	k1/mHJISyvhTkzEjwd06waEH41N5dDMBhhbLGdqmeUo78m0ZoPq3yXOPo/hCWT7mO+7ll3kuvV9
	fy352ueklkiaexuGllQ2u6Z4Jjlr0e738bfGBV6G05o8dIesXkJSMIycceHgTF9qHU++cJ+QHhB
	VW8gVYlsdqKyAOBEKhi2VBcLwwB8XuKjfgoWjCibfXplJlkZqlV2GesEOqwBqeCuHHY9WjnuIJw
	YKzT6ZZN1G6ngbKlNWmKTBqF//VG74r6Th44wTnxLc
X-Google-Smtp-Source: AGHT+IFok8sHCYOpJa+r8lDaMXz2YO2SGlpSOMs1N7JK0iL61rgsPdp1b9Qo/9ADG3bA8aBrW1Chgg==
X-Received: by 2002:a05:600c:45c9:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-4711791c601mr171938455e9.26.1761231546476;
        Thu, 23 Oct 2025 07:59:06 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-475cae9f292sm39822325e9.5.2025.10.23.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:59:05 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 2/2] net: airoha: add phylink support for GDM1
Date: Thu, 23 Oct 2025 16:58:49 +0200
Message-ID: <20251023145850.28459-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023145850.28459-1-ansuelsmth@gmail.com>
References: <20251023145850.28459-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for support of GDM2+ port, fill in phylink OPs for GDM1
that is an INTERNAL port for the Embedded Switch.

Add all the phylink start/stop and fill in the MAC capabilities and the
internal interface as the supported interface.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/airoha/Kconfig      |  1 +
 drivers/net/ethernet/airoha/airoha_eth.c | 77 +++++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_eth.h |  3 +
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
index ad3ce501e7a5..3c74438bc8a0 100644
--- a/drivers/net/ethernet/airoha/Kconfig
+++ b/drivers/net/ethernet/airoha/Kconfig
@@ -2,6 +2,7 @@
 config NET_VENDOR_AIROHA
 	bool "Airoha devices"
 	depends on ARCH_AIROHA || COMPILE_TEST
+	select PHYLIB
 	help
 	  If you have a Airoha SoC with ethernet, say Y.
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index ce6d13b10e27..deba909104bb 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1613,6 +1613,8 @@ static int airoha_dev_open(struct net_device *dev)
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
 
+	phylink_start(port->phylink);
+
 	netif_tx_start_all_queues(dev);
 	err = airoha_set_vip_for_gdm_port(port, true);
 	if (err)
@@ -1665,6 +1667,8 @@ static int airoha_dev_stop(struct net_device *dev)
 		}
 	}
 
+	phylink_stop(port->phylink);
+
 	return 0;
 }
 
@@ -2813,6 +2817,18 @@ static const struct ethtool_ops airoha_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 };
 
+static struct phylink_pcs *airoha_phylink_mac_select_pcs(struct phylink_config *config,
+							 phy_interface_t interface)
+{
+	return NULL;
+}
+
+static void airoha_mac_config(struct phylink_config *config,
+			      unsigned int mode,
+			      const struct phylink_link_state *state)
+{
+}
+
 static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)
 {
 	int i;
@@ -2857,6 +2873,57 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 	return false;
 }
 
+static void airoha_mac_link_up(struct phylink_config *config,
+			       struct phy_device *phy, unsigned int mode,
+			       phy_interface_t interface, int speed,
+			       int duplex, bool tx_pause, bool rx_pause)
+{
+}
+
+static void airoha_mac_link_down(struct phylink_config *config,
+				 unsigned int mode, phy_interface_t interface)
+{
+}
+
+static const struct phylink_mac_ops airoha_phylink_ops = {
+	.mac_select_pcs = airoha_phylink_mac_select_pcs,
+	.mac_config = airoha_mac_config,
+	.mac_link_up = airoha_mac_link_up,
+	.mac_link_down = airoha_mac_link_down,
+};
+
+static int airoha_setup_phylink(struct net_device *netdev)
+{
+	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct device *dev = &netdev->dev;
+	struct phylink *phylink;
+	int phy_mode;
+
+	phy_mode = device_get_phy_mode(dev);
+	if (phy_mode < 0) {
+		dev_err(dev, "incorrect phy-mode\n");
+		return phy_mode;
+	}
+
+	port->phylink_config.dev = dev;
+	port->phylink_config.type = PHYLINK_NETDEV;
+	port->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
+						MAC_SYM_PAUSE |
+						MAC_10000FD;
+
+	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+		  port->phylink_config.supported_interfaces);
+
+	phylink = phylink_create(&port->phylink_config, dev_fwnode(dev),
+				 phy_mode, &airoha_phylink_ops);
+	if (IS_ERR(phylink))
+		return PTR_ERR(phylink);
+
+	port->phylink = phylink;
+
+	return 0;
+}
+
 static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 				 struct device_node *np, int index)
 {
@@ -2935,12 +3002,18 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	if (err)
 		return err;
 
-	err = register_netdev(dev);
+	err = airoha_setup_phylink(port->dev);
 	if (err)
 		goto free_metadata_dst;
 
+	err = register_netdev(dev);
+	if (err)
+		goto free_phylink;
+
 	return 0;
 
+free_phylink:
+	phylink_destroy(port->phylink);
 free_metadata_dst:
 	airoha_metadata_dst_free(port);
 	return err;
@@ -3049,6 +3122,7 @@ static int airoha_probe(struct platform_device *pdev)
 
 		if (port && port->dev->reg_state == NETREG_REGISTERED) {
 			unregister_netdev(port->dev);
+			phylink_destroy(port->phylink);
 			airoha_metadata_dst_free(port);
 		}
 	}
@@ -3076,6 +3150,7 @@ static void airoha_remove(struct platform_device *pdev)
 
 		airoha_dev_stop(port->dev);
 		unregister_netdev(port->dev);
+		phylink_destroy(port->phylink);
 		airoha_metadata_dst_free(port);
 	}
 	free_netdev(eth->napi_dev);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index eb27a4ff5198..c144c1ece23b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -531,6 +531,9 @@ struct airoha_gdm_port {
 	struct net_device *dev;
 	int id;
 
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
+
 	struct airoha_hw_stats stats;
 
 	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
-- 
2.51.0


