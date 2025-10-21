Return-Path: <linux-kernel+bounces-863599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AD7BF8457
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C15054577F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB827466A;
	Tue, 21 Oct 2025 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fswu2ulj"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB2264A76
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075212; cv=none; b=iGTXZYf2R9noSVMGuc8V+xGIP9XF2rV95hHlNw26Ys9ghDFHVwojxxDfhRAO9rx3njGjHRGSCS+mvmG+unIrpUm4wCCZ3FNWfIPfnwjRlYffFMAZSWRk7xpbqEhScMc6Frje8kgA9N/XlNeHq3KGcjB7g65f9VyznfwkiwaDTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075212; c=relaxed/simple;
	bh=ytzHVf3HtkaUkecNTvEeEXKk9CuPwb3tyEpnW7Jotog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gz3HllB+12aEqVLLbwQ6uZw+wrqFyXVCvG0VNQPZcxl1unHQk4QoJvAlpUq3bwUFkQJy8bggLztMPXAwGwX+0m0HiQPlVenbZsMlUa1YmnEl5Ot0s2D87T91LvGa+HK1EAGY9SSoW9DwNIHAu5EFZH+nPj/jGofziIrODxX+TXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fswu2ulj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42557c5cedcso3455591f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761075209; x=1761680009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39TYCjslUWZvszjsRXmpGak+arWZ5M/6BDn3chbsEM8=;
        b=fswu2uljwjQNDamHagWnTXKM4SUI7bWG40UPIZaXmHWTn9VBWbcFUYUMBZuyfTD8+F
         neWqXHSCrA8zXDEN9KoObHNdY3QhYIcwkBAMcMvff1FG0q4N1XLC0C6nn8Zdfs+UeO3p
         S0l+if6as8ze5hmA1w/duZlLN1af+UcHmXCzJU4zy14zcL3+OWBJrnr378Lxv4E4P6Is
         1DpArCrO1PXKJjGXUmsObXzpZ+NZsS4ilHpwAbp//mhzYGluT+F6s0dbdeNlEpjENrYf
         LURFOjLkOev7VVGInt0YWxZwVBF2YHkieVh9BemfAz25/Z2gXAX08vnxhb3dUVqqmzAf
         bkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761075209; x=1761680009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39TYCjslUWZvszjsRXmpGak+arWZ5M/6BDn3chbsEM8=;
        b=ODSR8bE0dz5KbcSWvFEjKNmRxUaWYWZHEn1DIV1KFR7M7SqDw/LO5iuFhHYgMF1soJ
         uCBl2NNa7gFHuygACFefIEvBipTG5Si/EcmnP1IDlBot7I5SKE23J5SKaMMUnQ6pHMsq
         ZZBI55RFVghZkLKpSlroc+W/STUxb3HDW3BZPeHJ9lw21jwKAF46m1EVg7jr0qyzsZE6
         a39XoiWW12Ya0F313d9PWbWI2RmGuhGPgsilxMKhlmZdN/poiOlTJa/EQ0OxMdEpTOV7
         I9owE+Bzjza+uPnb7y+7oHzMjiONzEnjuENrexyGrCjVZRLkPmvjJnv1fBF3nhmLUlXK
         eBoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlo/ZYSMmh97HEC91yUXH9J7iKKm9sgyTnOXNFv85N08QY6g/BviR8fcIgi77X5KUSaVIW706cF7Xc71Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQKOqQRIbZTpWxEMpk6+AhBIJP36dp7alKjHPp7O8+SGshWKE
	yncFIvOhWrH0IgWAnOJq7wkmBdoCRUiZKEgjDV2+ANjeBJchfmxnrU5d
X-Gm-Gg: ASbGnct1r7+j1EjEc9fO4Etb/DGtdnqdH9Wx29FaGYsN+/zVA1gYVuZR4kpwoNMx40S
	YQA5gdf830IgKaKPtaXogv/IDCppnFulFDLMxGgNuuIvNHz5lvuFM0fLDJUB40k8XQpgIj9/JFM
	hQR2B7AJn67Ucbiv3PtdjVuhaTA/g4qeN0kTmT4MVQ9cPyArZ8HEm+TktzJbdwp8662JXGspFH+
	HWSj1R3r0bxaPz4hYmPiSaCFKgamMEPULBvpYi/9dCYEGqSb1NeeHR0j5wHdyiEQ1lO7IyykcP3
	FO2FEK/cuHXYwsmk5HJnYqHQ8MGruJ+73+9bRlgGKPgFUE47d6xjSUfT4ZecUVXgKtr3ika6raL
	lVMLlc3wr/f/m/vIVZ34ChwXX7B0iG7jCLksdtSr1/eEl/qRzFM1/zN5rG1wFaFqAXAOgb6dvKX
	e3ArRhG6iRTh67HPuTq1AZBlpOpleDbZfQ0WdGIOvZIaQ=
X-Google-Smtp-Source: AGHT+IElUppWel9b0RVHM4zvWcmJ3xHtW8J1ioZFPpIwENi2ahFIOIMw6b/9n0+AeyKKg/4kFhaXWQ==
X-Received: by 2002:a05:6000:144a:b0:427:e1bf:13bd with SMTP id ffacd0b85a97d-427e1bf1a74mr9524872f8f.52.1761075208724;
        Tue, 21 Oct 2025 12:33:28 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm21327187f8f.36.2025.10.21.12.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:33:28 -0700 (PDT)
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
Subject: [net-next PATCH 2/2] net: airoha: add phylink support for GDM1
Date: Tue, 21 Oct 2025 21:33:12 +0200
Message-ID: <20251021193315.2192359-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021193315.2192359-1-ansuelsmth@gmail.com>
References: <20251021193315.2192359-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for support of GDM2+ port, fill in phylink OPs for GDM1
that is an INTERNAL port for the Embedded Switch.

Rework the GDM init logic by first preparing the struct with all the
required info and creating the phylink interface and only after the
parsing register the related netdev.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 108 ++++++++++++++++++++---
 drivers/net/ethernet/airoha/airoha_eth.h |   3 +
 2 files changed, 99 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index ce6d13b10e27..fc237775a998 100644
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
 
@@ -2813,6 +2817,17 @@ static const struct ethtool_ops airoha_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 };
 
+static struct phylink_pcs *airoha_phylink_mac_select_pcs(struct phylink_config *config,
+							 phy_interface_t interface)
+{
+	return NULL;
+}
+
+static void airoha_mac_config(struct phylink_config *config, unsigned int mode,
+			      const struct phylink_link_state *state)
+{
+}
+
 static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)
 {
 	int i;
@@ -2857,6 +2872,55 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 	return false;
 }
 
+static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
+			       unsigned int mode, phy_interface_t interface,
+			       int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+}
+
+static void airoha_mac_link_down(struct phylink_config *config, unsigned int mode,
+				 phy_interface_t interface)
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
+	phy_interface_t phy_mode;
+	struct phylink *phylink;
+
+	phy_mode = device_get_phy_mode(dev);
+	if (phy_mode < 0) {
+		dev_err(dev, "incorrect phy-mode\n");
+		return phy_mode;
+	}
+
+	port->phylink_config.dev = dev;
+	port->phylink_config.type = PHYLINK_NETDEV;
+	port->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
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
@@ -2931,19 +2995,30 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	port->id = id;
 	eth->ports[p] = port;
 
-	err = airoha_metadata_dst_alloc(port);
-	if (err)
-		return err;
+	return airoha_metadata_dst_alloc(port);
+}
 
-	err = register_netdev(dev);
-	if (err)
-		goto free_metadata_dst;
+static int airoha_register_gdm_ports(struct airoha_eth *eth)
+{
+	int i;
 
-	return 0;
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+		int err;
 
-free_metadata_dst:
-	airoha_metadata_dst_free(port);
-	return err;
+		if (!port)
+			continue;
+
+		err = airoha_setup_phylink(port->dev);
+		if (err)
+			return err;
+
+		err = register_netdev(port->dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static int airoha_probe(struct platform_device *pdev)
@@ -3034,6 +3109,10 @@ static int airoha_probe(struct platform_device *pdev)
 		}
 	}
 
+	err = airoha_register_gdm_ports(eth);
+	if (err)
+		goto error_napi_stop;
+
 	return 0;
 
 error_napi_stop:
@@ -3047,10 +3126,14 @@ static int airoha_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
 
-		if (port && port->dev->reg_state == NETREG_REGISTERED) {
+		if (!port)
+			continue;
+
+		if (port->dev->reg_state == NETREG_REGISTERED) {
 			unregister_netdev(port->dev);
-			airoha_metadata_dst_free(port);
+			phylink_destroy(port->phylink);
 		}
+		airoha_metadata_dst_free(port);
 	}
 	free_netdev(eth->napi_dev);
 	platform_set_drvdata(pdev, NULL);
@@ -3076,6 +3159,7 @@ static void airoha_remove(struct platform_device *pdev)
 
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


