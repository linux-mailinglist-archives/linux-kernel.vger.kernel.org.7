Return-Path: <linux-kernel+bounces-868062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01963C04431
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 732F035300F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088A027EFE9;
	Fri, 24 Oct 2025 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW3WuWI0"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C43279DCD
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276795; cv=none; b=gMscovhNRCQTksz9aazfJryNonC3Obv1YVVVk64eizfO+f4xGbWCr4wzB9uEXMQLTDCFDbclEv6MsTY5UBxPtgUma0N7fh1ORe4ceJQx9o3jFMWDtA3TtVOKebJs/rthi7xddqz5iYuH2MWZqu0HocaSr8UgRtM1r+bdE0Wb+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276795; c=relaxed/simple;
	bh=Y4/7kxOvf+Po4ZQ5WfwfaUNB9yGYyDH1l93lR+I4MvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jY/XIv4JXePBcbVIV5nj8WudvYnV8xvvDs9967e9rSrNqeta3WoxjTKDHFwSOAUJgZ1vuCgu0L14SxcTVQqg0v1nLiPfmGjy6WOlYk9d5RBPnKdvJ6eduzbuGGnwxLaR4KMBI5hYTMhBe86bFU1L7KDP2SmCV6LRMNdySciY/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW3WuWI0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6ceb3b68feso1280330a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761276792; x=1761881592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqGjoL6ZxqRuvTgBTFhR7XlvSN01n0xXPYNgq1DkmvE=;
        b=aW3WuWI0NUPfR9YlELKW2iINtEi9XYNs0i4Y9fLgvCypp+m2sjps9MdXGxMROBWn2m
         nzXAf8BUg8Y0aW+WIKHiCt3gdHFSi9znKpOQAGyYGmuh1jeOWX0vHCKGHeZQSS5fMG7c
         oNjoZ1oSIUALqe/SZvu846/2MG0CUywpqMTjFBDHsk12BKZceZMTjzzzfEZJFCLJLVxE
         QGvOoC3fju57Gb25FbqcHwOmHPbhUE6kaSOTEoR7qzNT4L6EDqRUs1Mm8x+HT3Hmo4ZD
         RBbnm6OhwaD3wYYlXwNmLoSFTQH766zujxsdLTBOY3DEf2yj1YZdMZ/8LebMQdgEyFee
         oDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761276792; x=1761881592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqGjoL6ZxqRuvTgBTFhR7XlvSN01n0xXPYNgq1DkmvE=;
        b=cQ520V4u9I74UXwWlsrjF2suKAJrUfY7INbQFoxe3JALITKixN+jAKVwOyaowA+3cD
         14hHtbWdDE9b5a+pXl1c3b0nbIjVm4xzsfCAZn6pHs4i56x1gunscGn9wCjzzS0Php8P
         zgpoXkRGR3xJmZPGjwIIywr+C5GEYJjofPaC3p++dye3XqTge6KOrBt/+MkzglRzyc3t
         CwgAO/RbyJD211L7ncerbSlUdINET799X5rjFTe4l0Ge7orxm83uAugGof1g+unITCmd
         Kfiz376SO+bluPR+qAAp5gUhUgdx+g9mUiGW9OFIn9/1fm0lUNqBrv3hM4kQWHq0d/ft
         K8tA==
X-Forwarded-Encrypted: i=1; AJvYcCVLkC1Sdtl49J4cLTpdxFeIWPQXV+U3B5x3mhOq9ErcJXgmcnFEwakhfQja2NPUo3ZLELVUwVeQgGa4hag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyudgNO/pmhpkfg+02iNg/M6QguLj4sRX4LcWP2Pl85B1MXZBdS
	+HQMg0qkhnfwc1/ovvTgClTWdOjltKJM5RRn106dfJ42Y11n0c7Xpa19
X-Gm-Gg: ASbGncvWYfl6NLOQ0T1PFQVzv6RrsUtaNgzGgbws7uDaLFzl3KLSXrjxVEFBxe1H9IC
	JC0HowxxG+CvK/3ILOXFZJ1qCusMiBZBnL4rotWHLuWkR82TRjhbdLFNDjdN/luZrIZ5x0XgJ2Z
	IAiGmF8tArL+PVdj4+SAArfKzo0HnlYDc9J0BYgM5OI+2CcgMhI4y2UdAkviR7CXFE03EwRwgow
	CNuk35ZCQ+TuqyaqzX2KMMs6y2+Maqe8XCE6ezzuhDDacLBOL7Ly1bX8Dy0dpwjstf/n/9/V2I9
	mJnFSPQ2oGvO7w4V9ftkd8LnF1/9MpruHGckfedu5sImE80gNB4DYcUZAA3MYSGAGaz0KEG0KMx
	4jqLkHYF3lUauLySINPFTzsZf6OVBB04ZvpXJnH9QoZq0Cdvd5yr7eBQAFIAD3gQcGEcNwLPnAb
	KEbTRMf40DjBoaK3qU8A==
X-Google-Smtp-Source: AGHT+IEvpsqt6uv0HWRQnHevKvtcDn8gVEGvS5rTwnsQrRLfJgzSufjkPD3j+2HYjJHz0o3hCrw3MQ==
X-Received: by 2002:a17:902:e805:b0:26a:6d5a:944e with SMTP id d9443c01a7336-29489e3e784mr11842035ad.24.1761276791160;
        Thu, 23 Oct 2025 20:33:11 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda7949sm40394265ad.3.2025.10.23.20.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:33:10 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: dsa: yt921x: Add HSR offloading support
Date: Fri, 24 Oct 2025 11:32:28 +0800
Message-ID: <20251024033237.1336249-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024033237.1336249-1-mmyangfl@gmail.com>
References: <20251024033237.1336249-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add offloading for packet duplication supported by the YT921x switches.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 24 ++++++++++++++++++++++++
 net/dsa/tag_yt921x.c     |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 485fec3ac74f..885a63f2b978 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1038,6 +1038,27 @@ static int yt921x_dsa_port_max_mtu(struct dsa_switch *ds, int port)
 	return YT921X_FRAME_SIZE_MAX - ETH_HLEN - ETH_FCS_LEN - YT921X_TAG_LEN;
 }
 
+static int
+yt921x_dsa_port_hsr_leave(struct dsa_switch *ds, int port,
+			  struct net_device *hsr)
+{
+	return 0;
+}
+
+static int
+yt921x_dsa_port_hsr_join(struct dsa_switch *ds, int port,
+			 struct net_device *hsr, struct netlink_ext_ack *extack)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct net_device *user = dp->user;
+
+	/* Nothing special here; we natively support tx packet duplication */
+
+	user->features |= NETIF_F_HW_HSR_DUP;
+
+	return 0;
+}
+
 static int
 yt921x_mirror_del(struct yt921x_priv *priv, int port, bool ingress)
 {
@@ -2879,6 +2900,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* mtu */
 	.port_change_mtu	= yt921x_dsa_port_change_mtu,
 	.port_max_mtu		= yt921x_dsa_port_max_mtu,
+	/* hsr */
+	.port_hsr_leave		= yt921x_dsa_port_hsr_leave,
+	.port_hsr_join		= yt921x_dsa_port_hsr_join,
 	/* mirror */
 	.port_mirror_del	= yt921x_dsa_port_mirror_del,
 	.port_mirror_add	= yt921x_dsa_port_mirror_add,
diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index 995da44f0a2a..0ad83924fda1 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -46,6 +46,7 @@ yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct dsa_port *dp = dsa_user_to_port(netdev);
 	unsigned int port = dp->index;
+	struct dsa_port *partner;
 	__be16 *tag;
 	u16 tx;
 
@@ -59,6 +60,9 @@ yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tag[1] = 0;
 	tag[2] = 0;
 	tx = YT921X_TAG_PORT_EN | YT921X_TAG_TX_PORTn(port);
+	if (dp->hsr_dev)
+		dsa_hsr_foreach_port(partner, dp->ds, dp->hsr_dev)
+			tx |= YT921X_TAG_TX_PORTn(partner->index);
 	tag[3] = htons(tx);
 
 	return skb;
-- 
2.51.0


