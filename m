Return-Path: <linux-kernel+bounces-868063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A32C04440
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D019A596C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3E127F017;
	Fri, 24 Oct 2025 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAvBUlXI"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9E227E7EC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276797; cv=none; b=iQFppv0Bc05xKwK6nR54U7jPXNCNp/TN7PU2ZzJ4U0ejP8n3L4IY8ufl0fSi+NwhqZmU7BoZV8jXN1ijCwApCZe767/GvccZp15YnNGgIxehst661vssxTgUg8749TETRVHXsR/kbNcEPgdA3rVKNoa3dmSRLSXukQDeBYAYtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276797; c=relaxed/simple;
	bh=8mNRaktnDZjddf/hiIoTFG8PZJH/DelAI5SfSfgclQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6RSY/MeVIRJmeRHEDR1RBvoX44fOvFDSb+LeqvYTPH7iCtGCeMBXC4iKiV6IL4uq51Y1LXJcNEvzCHZLX4VPg4y4p8rRoA7azzBfOuWGOY/ZRQeFPpOxR7iQXal0d2O9yo7jlseBzO3fZSV6Z51Og24Jp25fVZMB35CSRdONxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAvBUlXI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27c369f898fso24426655ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761276795; x=1761881595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrFID4/+UrIHKrArhdAdtN2WsYEUYH8YfC3PSEJWy08=;
        b=EAvBUlXIbo7Y2qgb0X4aF3PWC56LaBW5Mff89Cb0g4PVseDhwNPSeLeGXU4wReIVhc
         rISojbBT1QZnIvKOtYSuC9a8myv1BSbZFEvAfqNcvmR3qIyynP89op3lyJ07gTelreBx
         Ys0B0yBGSQqgnAXA2v2y18JXONNRBsRx16K/CcUloiy+aVFVBZxT1yMgZlywb1wIBTq+
         psrfE+TAiQZztcgrJq1K+ogb+crDFB/UMqV9OVLPXgG8eGJ8aHAGD23uLmftEZ3WLLmM
         YotrM2VKOF7M7/Q83EkyL1Y2ybuHN7H5NHrWb2CVoJ9WdCNaIo1m+6gQHRRsRkpSxuW6
         ulbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761276795; x=1761881595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrFID4/+UrIHKrArhdAdtN2WsYEUYH8YfC3PSEJWy08=;
        b=fhckYlk4VY5CxcVpBMhCjX0EbyLtLjy1LuXpn7QqgLOr0otOdAf78mGSCOHXS/mRGY
         FH6Ch3tYTixaDMXOnF1m+vHEWD5ugldK+5QMxyDX8CJIXeciPdmJKzhZxyefzQamQ5En
         TAN0YnCFihhkWx+iPpgC2b8STIavNhuKjQ7U/OGhfn4yMUy5SZQTkSB6LXP09gGtmMyM
         nxNiEFW5ifmwzDdEJ3JY2fvvKs0o8KZBObkj1duYQNz4z5ICtTXJ9iOg9HpohcERh6tI
         9W00frTpsx21BzbuPg/+u/kcB4gNJtXTdYZfhlH2zlJ/I1PwUHoWxg07fLv26PKU6ncc
         9aaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNRXjlUMaP7sZaeZGOrQKEXQvkT/9+q6L+wUOWTAE5JK0s6m4gqQfB4ZQt7D8x8w0bcy4KjK3n1KtM4As=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOdVmXvAyrquPPk0VsAEJZyPPL7MG9BvSQ/egOg5fsw/zqjP7f
	o1akDQtEds1vnL26v/i5qJvR44KiBvrQatJtoMYnKaEjY95ls2N+DAjl
X-Gm-Gg: ASbGncu5193sB9VlRKm2TwPEF/x2ZU5lMFX0VGep6vHJua0TVLg3z6Ub/duHUEXTgJE
	Rk31OKiFDG6DYT+C19RZwy3XKeEUzZo+PSxOpkxsduMLejcIsMIBc/LyIL93JWnQpLP/A3c/ul8
	eVvMdukmfNP49/AqLjUQ2ZIzmQ+rFDm6ZLjr6jxQg27WuegxrYXO6+NZEO+IyYawHxUU3XKY2o1
	1cPaos40ni5NipdlaLIq7bNmqq3pkjZNkWmISB/QhSieHRIxlAXtA8j4V4j+OBkhgfrOO+rukQi
	FB0Nj/wa8lSG4hV7H17fJUfeIHXDSq5xIU+Uju6CElcDddm7Ai0wEaRGa5urbrTYWtp+tGEo5o+
	yf9VjcGPIvo8A6rGxzNbhtU+gbGvZFvMcYQ3i5dI/PdcBGA8liT6QFRazRd6B0OU3T1TPXa7vg7
	R20uzxThw=
X-Google-Smtp-Source: AGHT+IHI7r04yzhwK69K8rpawCPYb5WS526gHAvbUvZIVfklkumt4Vvr9D4Cs5WO1JuhFqNs0o/mig==
X-Received: by 2002:a17:902:cece:b0:292:fc65:3579 with SMTP id d9443c01a7336-292fc65380cmr132461465ad.17.1761276795074;
        Thu, 23 Oct 2025 20:33:15 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda7949sm40394265ad.3.2025.10.23.20.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:33:14 -0700 (PDT)
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
Subject: [PATCH net-next 3/3] net: dsa: yt921x: Add LAG offloading support
Date: Fri, 24 Oct 2025 11:32:29 +0800
Message-ID: <20251024033237.1336249-4-mmyangfl@gmail.com>
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

Add offloading for a link aggregation group supported by the YT921x
switches.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 184 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  20 +++++
 2 files changed, 204 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 885a63f2b978..406e972c4cfb 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1143,6 +1143,187 @@ yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_dsa_port_lag_check(struct dsa_switch *ds, struct dsa_lag lag,
+			  struct netdev_lag_upper_info *info,
+			  struct netlink_ext_ack *extack)
+{
+	struct dsa_port *dp;
+	unsigned int members;
+
+	if (lag.id <= 0)
+		return -EINVAL;
+
+	members = 0;
+	dsa_lag_foreach_port(dp, ds->dst, &lag)
+		/* Includes the port joining the LAG */
+		members++;
+
+	if (members > YT921X_LAG_PORT_NUM) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload more than 4 LAG ports");
+		return -EOPNOTSUPP;
+	}
+
+	if (info->tx_type != NETDEV_LAG_TX_TYPE_HASH) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can only offload LAG using hash TX type");
+		return -EOPNOTSUPP;
+	}
+
+	if (info->hash_type != NETDEV_LAG_HASH_L2 &&
+	    info->hash_type != NETDEV_LAG_HASH_L23 &&
+	    info->hash_type != NETDEV_LAG_HASH_L34) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can only offload L2 or L2+L3 or L3+L4 TX hash");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int yt921x_lag_hash(struct yt921x_priv *priv, u32 ctrl, bool unique_lag)
+{
+	struct device *dev = to_device(priv);
+	u32 val;
+	int res;
+
+	/* Hash Mode is global. Make sure the same Hash Mode is set to all the
+	 * 2 possible lags.
+	 * If we are the unique LAG we can set whatever hash mode we want.
+	 * To change hash mode it's needed to remove all LAG and change the mode
+	 * with the latest.
+	 */
+	if (unique_lag) {
+		res = yt921x_reg_write(priv, YT921X_LAG_HASH, ctrl);
+		if (res)
+			return res;
+	} else {
+		res = yt921x_reg_read(priv, YT921X_LAG_HASH, &val);
+		if (res)
+			return res;
+
+		if (val != ctrl) {
+			dev_err(dev,
+				"Mismatched Hash Mode across different lag is not supported\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static int yt921x_lag_leave(struct yt921x_priv *priv, u8 index)
+{
+	return yt921x_reg_write(priv, YT921X_LAG_GROUPn(index), 0);
+}
+
+static int yt921x_lag_join(struct yt921x_priv *priv, u8 index, u16 ports_mask)
+{
+	unsigned long targets_mask = ports_mask;
+	unsigned int cnt;
+	u32 ctrl;
+	int port;
+	int res;
+
+	cnt = 0;
+	for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
+		ctrl = YT921X_LAG_MEMBER_PORT(port);
+		res = yt921x_reg_write(priv, YT921X_LAG_MEMBERnm(index, cnt),
+				       ctrl);
+		if (res)
+			return res;
+
+		cnt++;
+	}
+
+	ctrl = YT921X_LAG_GROUP_PORTS(ports_mask) |
+	       YT921X_LAG_GROUP_MEMBER_NUM(cnt);
+	return yt921x_reg_write(priv, YT921X_LAG_GROUPn(index), ctrl);
+}
+
+static int
+yt921x_dsa_port_lag_leave(struct dsa_switch *ds, int port, struct dsa_lag lag)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	if (lag.id <= 0)
+		return -EINVAL;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_lag_leave(priv, lag.id - 1);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_dsa_port_lag_join(struct dsa_switch *ds, int port, struct dsa_lag lag,
+			 struct netdev_lag_upper_info *info,
+			 struct netlink_ext_ack *extack)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct dsa_port *dp;
+	bool unique_lag;
+	unsigned int i;
+	u32 ctrl;
+	int res;
+
+	res = yt921x_dsa_port_lag_check(ds, lag, info, extack);
+	if (res)
+		return res;
+
+	ctrl = 0;
+	switch (info->hash_type) {
+	case NETDEV_LAG_HASH_L34:
+		ctrl |= YT921X_LAG_HASH_IP_DST;
+		ctrl |= YT921X_LAG_HASH_IP_SRC;
+		ctrl |= YT921X_LAG_HASH_IP_PROTO;
+
+		ctrl |= YT921X_LAG_HASH_L4_DPORT;
+		ctrl |= YT921X_LAG_HASH_L4_SPORT;
+		break;
+	case NETDEV_LAG_HASH_L23:
+		ctrl |= YT921X_LAG_HASH_MAC_DA;
+		ctrl |= YT921X_LAG_HASH_MAC_SA;
+
+		ctrl |= YT921X_LAG_HASH_IP_DST;
+		ctrl |= YT921X_LAG_HASH_IP_SRC;
+		ctrl |= YT921X_LAG_HASH_IP_PROTO;
+		break;
+	case NETDEV_LAG_HASH_L2:
+		ctrl |= YT921X_LAG_HASH_MAC_DA;
+		ctrl |= YT921X_LAG_HASH_MAC_SA;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	/* Check if we are the unique configured LAG */
+	unique_lag = true;
+	dsa_lags_foreach_id(i, ds->dst)
+		if (i != lag.id && dsa_lag_by_id(ds->dst, i)) {
+			unique_lag = false;
+			break;
+		}
+
+	mutex_lock(&priv->reg_lock);
+	do {
+		res = yt921x_lag_hash(priv, ctrl, unique_lag);
+		if (res)
+			break;
+
+		ctrl = 0;
+		dsa_lag_foreach_port(dp, ds->dst, &lag)
+			ctrl |= BIT(dp->index);
+		res = yt921x_lag_join(priv, lag.id - 1, ctrl);
+	} while (0);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int yt921x_fdb_wait(struct yt921x_priv *priv, u32 *valp)
 {
 	struct device *dev = to_device(priv);
@@ -2906,6 +3087,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* mirror */
 	.port_mirror_del	= yt921x_dsa_port_mirror_del,
 	.port_mirror_add	= yt921x_dsa_port_mirror_add,
+	/* lag */
+	.port_lag_leave		= yt921x_dsa_port_lag_leave,
+	.port_lag_join		= yt921x_dsa_port_lag_join,
 	/* fdb */
 	.port_fdb_dump		= yt921x_dsa_port_fdb_dump,
 	.port_fast_age		= yt921x_dsa_port_fast_age,
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 3546a94f380e..5e6dcf741e31 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -316,6 +316,14 @@
 #define  YT921X_FILTER_PORTn(port)		BIT(port)
 #define YT921X_VLAN_EGR_FILTER		0x180598
 #define  YT921X_VLAN_EGR_FILTER_PORTn(port)	BIT(port)
+#define YT921X_LAG_GROUPn(n)		(0x1805a8 + 4 * (n))
+#define  YT921X_LAG_GROUP_PORTS_M		GENMASK(13, 3)
+#define   YT921X_LAG_GROUP_PORTS(x)			FIELD_PREP(YT921X_LAG_GROUP_PORTS_M, (x))
+#define  YT921X_LAG_GROUP_MEMBER_NUM_M		GENMASK(2, 0)
+#define   YT921X_LAG_GROUP_MEMBER_NUM(x)		FIELD_PREP(YT921X_LAG_GROUP_MEMBER_NUM_M, (x))
+#define YT921X_LAG_MEMBERnm(n, m)	(0x1805b0 + 4 * (4 * (n) + (m)))
+#define  YT921X_LAG_MEMBER_PORT_M		GENMASK(3, 0)
+#define   YT921X_LAG_MEMBER_PORT(x)			FIELD_PREP(YT921X_LAG_MEMBER_PORT_M, (x))
 #define YT921X_CPU_COPY			0x180690
 #define  YT921X_CPU_COPY_FORCE_INT_PORT		BIT(2)
 #define  YT921X_CPU_COPY_TO_INT_CPU		BIT(1)
@@ -360,6 +368,15 @@
 #define  YT921X_PORT_IGR_TPIDn_STAG(x)		BIT((x) + 4)
 #define  YT921X_PORT_IGR_TPIDn_CTAG_M		GENMASK(3, 0)
 #define  YT921X_PORT_IGR_TPIDn_CTAG(x)		BIT(x)
+#define YT921X_LAG_HASH			0x210090
+#define  YT921X_LAG_HASH_L4_SPORT		BIT(7)
+#define  YT921X_LAG_HASH_L4_DPORT		BIT(6)
+#define  YT921X_LAG_HASH_IP_PROTO		BIT(5)
+#define  YT921X_LAG_HASH_IP_SRC			BIT(4)
+#define  YT921X_LAG_HASH_IP_DST			BIT(3)
+#define  YT921X_LAG_HASH_MAC_SA			BIT(2)
+#define  YT921X_LAG_HASH_MAC_DA			BIT(1)
+#define  YT921X_LAG_HASH_SRC_PORT		BIT(0)
 
 #define YT921X_PORTn_VLAN_CTRL(port)	(0x230010 + 4 * (port))
 #define  YT921X_PORT_VLAN_CTRL_SVLAN_PRI_EN	BIT(31)
@@ -404,6 +421,9 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_MSTI_NUM		16
 
+#define YT921X_LAG_NUM		2
+#define YT921X_LAG_PORT_NUM	4
+
 #define YT9215_MAJOR	0x9002
 #define YT9218_MAJOR	0x9001
 
-- 
2.51.0


