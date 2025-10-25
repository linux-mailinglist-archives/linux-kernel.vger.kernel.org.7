Return-Path: <linux-kernel+bounces-870072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB56C09DB6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D70D4F22D6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49680303A19;
	Sat, 25 Oct 2025 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqEvj78h"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7A30277D
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761411984; cv=none; b=Rbxl2PndFIJpp1kCwlF4JP7Emg3/RzD48qu4AN1kdpjtyqm/oN0eQbwOMsDVLbRvUJvYSLOFuyhwJi5Nyd9B5oOW0ylTvhSsn8oPma5M5PRFiM0raDqc1mdPuukH9wwdw6INoyNMb1qXp/OU2CDPOWNaMv7CdNjnTsZHKvyXBhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761411984; c=relaxed/simple;
	bh=XRkMRUGH9V3HDx/c29ZXYZjBq54Z3qgFCBYSabyIUzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OP5pOD6UwpzO39HiFk9mAx8T0vAhbSQ8ZcCkeSm+BvraBl3/l1mMumkpmTYBgsGqEk3W8YHJ0hykK3ZJ9wacR9bCAWgqYF05O7LtqvZuXeFXwbxNjvg/9zClqnuL2QXFv6INzl74uWUMBqyDXWrjv9ffVDXJVL+LkF6YqORcOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqEvj78h; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so4091441a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761411982; x=1762016782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wBGvtFNZNrLnbX9anfT2JnksQ+oUMM7fEuquROnTOM=;
        b=LqEvj78hH/G718T8Q18xiEClpOvas+pqBDjcUPCk4fIco7/TWToQG2aBosUAMJ7f6h
         43edh0KqvTjsdgEzoLWBbGKVS5VnkqypawlMNvg4Zvlkbbb1sM7n9UanQRMoWKXuctFq
         af+NTpXxXUdcD2Fpx/Gwm+Zo5pKjTSn1Y4a6f8OrNpIH50/sbZw5tM6ODbyrnXPhTFuI
         5tmeI+SqP1puGZi2j3LWChV4YXv62sLaIs8xN+nIYv6G9MIrpekNEmt0gNnPe9m0s515
         dx7LcHIFu+lsKy7w9MVbtRXHLf7PHJ9fI74WveVwQiunbHKn/ZFCVagG995MXepGq4tk
         SYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761411982; x=1762016782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wBGvtFNZNrLnbX9anfT2JnksQ+oUMM7fEuquROnTOM=;
        b=YK8AMMvVcT9Xkel5RaBxtztzEEgZZ/Ma1itVN0LWhiHa+oJuGG/c5Y1DOhP7Xs071b
         JNhVpgZRar7cUM6N/RWluIyv8pE+vNtBxbXaVNiF/iHFgKZRJiGEfbrW2fPmqYo7hlCw
         Z1SP2DCjE7/0wfNqucqSE0FM3nXQAz17fxV+3otnrp873ymg4a71KeSckdwokl2Z1WlR
         gxmCTMLMecDbSzQxQ+41TDwKj69dn7gKmeDEhAH6Yki2xaG8NFj3884C7qyUD57kGT7y
         9/mIq/6va8xb4iSt0JxV2Vb2G+TXUYMNLq6EFEBuVuwLkiQ9ZKdmjJsLKgI4s6fOFPiB
         AZnA==
X-Forwarded-Encrypted: i=1; AJvYcCV2o2bv03pR56l8eU6sL95tAVaR18Z3KcUHtnWsMMxCOJ49+SuYCiSFwEv7FiIrqtJdqc5YaL9WqYKwkr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgxwryO0bcZiWBEFcHMDvSwX7v5t7SPBkHhd6MtMfGFd7Rn1cH
	YMI/DjTFqto2xS5SJXdGW77TkbDpFzpDQ3T3x7EQOG8qzoC9smXwJnHr
X-Gm-Gg: ASbGncvxDmYvLqq3YcQFZn0OQtH98uA3VcaeDSB3ktgj9xz36GzZs4H2F4VeBvihT+U
	b4hQEcW6kfXTMABTtkxFcq4JD5A5UcOGDOWjDj4u9Kjkw8htiE4n9HmE4ATX+mE0TfVbD89UVZ5
	VEJlNVG+CAS69wz1MDP8SScLXX/uSt2YUdSNCN/g6dN7+4vl9UVYB4kOkZ5jYG0gKGMBhYR5sqV
	L641Ur8KTc/U7oJc+GMX6AYOAjxZ9sNbGOpOizmhzVDtUZ8wMi3n/W81uA+f4MC4O6RxN/JwTLk
	Atj4aEfvrhcv7VKcQ3tVHm0Z5dnkfEOBIa+fkySsT+Q6sqa0Law5OJqhyFllLhomejHxIJhLh1o
	r3htSEIEjTQ4kY3/qbUa+rAjC0g4X1miO5RU3TymKzBBaJfT0X7N1C0f1OtMbmq9FOVCEYWN+eM
	A46Jyc7KQ=
X-Google-Smtp-Source: AGHT+IH54DraoDa/f6KZkO4YDbs2eop+rkDoWJ/MneLBsZXLaDppl5Ep0rna4fs7M2rMhR5EUVEIhw==
X-Received: by 2002:a17:90b:2692:b0:338:3221:9dc0 with SMTP id 98e67ed59e1d1-33bcf91f1dcmr39131198a91.37.1761411982073;
        Sat, 25 Oct 2025 10:06:22 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e70d1sm2857842a91.11.2025.10.25.10.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:06:21 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/4] net: dsa: yt921x: Add STP/MST support
Date: Sun, 26 Oct 2025 01:05:25 +0800
Message-ID: <20251025170606.1937327-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025170606.1937327-1-mmyangfl@gmail.com>
References: <20251025170606.1937327-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for STP/MST was deferred from the initial submission of the
driver.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 115 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |   9 +++
 2 files changed, 124 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index ab762ffc4661..485fec3ac74f 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -2103,6 +2103,117 @@ yt921x_dsa_port_bridge_join(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_dsa_port_mst_state_set(struct dsa_switch *ds, int port,
+			      const struct switchdev_mst_state *st)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	mask = YT921X_STP_PORTn_M(port);
+	switch (st->state) {
+	case BR_STATE_DISABLED:
+		ctrl = YT921X_STP_PORTn_DISABLED(port);
+		break;
+	case BR_STATE_LISTENING:
+	case BR_STATE_LEARNING:
+		ctrl = YT921X_STP_PORTn_LEARNING(port);
+		break;
+	case BR_STATE_FORWARDING:
+	default:
+		ctrl = YT921X_STP_PORTn_FORWARD(port);
+		break;
+	case BR_STATE_BLOCKING:
+		ctrl = YT921X_STP_PORTn_BLOCKING(port);
+		break;
+	}
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_update_bits(priv, YT921X_STPn(st->msti), mask, ctrl);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
+			 const struct switchdev_vlan_msti *msti)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u64 mask64;
+	u64 ctrl64;
+	int res;
+
+	if (!msti->vid)
+		return -EINVAL;
+	if (msti->msti <= 0 || msti->msti >= YT921X_MSTI_NUM)
+		return -EINVAL;
+
+	mask64 = YT921X_VLAN_CTRL_STP_ID_M;
+	ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(msti->vid),
+				       mask64, ctrl64);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static void
+yt921x_dsa_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct device *dev = to_device(priv);
+	bool learning;
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	mask = YT921X_STP_PORTn_M(port);
+	learning = false;
+	switch (state) {
+	case BR_STATE_DISABLED:
+		ctrl = YT921X_STP_PORTn_DISABLED(port);
+		break;
+	case BR_STATE_LISTENING:
+		ctrl = YT921X_STP_PORTn_LEARNING(port);
+		break;
+	case BR_STATE_LEARNING:
+		ctrl = YT921X_STP_PORTn_LEARNING(port);
+		learning = dp->learning;
+		break;
+	case BR_STATE_FORWARDING:
+	default:
+		ctrl = YT921X_STP_PORTn_FORWARD(port);
+		learning = dp->learning;
+		break;
+	case BR_STATE_BLOCKING:
+		ctrl = YT921X_STP_PORTn_BLOCKING(port);
+		break;
+	}
+
+	mutex_lock(&priv->reg_lock);
+	do {
+		res = yt921x_reg_update_bits(priv, YT921X_STPn(0), mask, ctrl);
+		if (res)
+			break;
+
+		mask = YT921X_PORT_LEARN_DIS;
+		ctrl = !learning ? YT921X_PORT_LEARN_DIS : 0;
+		res = yt921x_reg_update_bits(priv, YT921X_PORTn_LEARN(port),
+					     mask, ctrl);
+	} while (0);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		dev_err(dev, "Failed to %s port %d: %i\n", "set STP state for",
+			port, res);
+}
+
 static int yt921x_port_down(struct yt921x_priv *priv, int port)
 {
 	u32 mask;
@@ -2788,6 +2899,10 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_bridge_flags	= yt921x_dsa_port_bridge_flags,
 	.port_bridge_leave	= yt921x_dsa_port_bridge_leave,
 	.port_bridge_join	= yt921x_dsa_port_bridge_join,
+	/* mst */
+	.port_mst_state_set	= yt921x_dsa_port_mst_state_set,
+	.vlan_msti_set		= yt921x_dsa_vlan_msti_set,
+	.port_stp_state_set	= yt921x_dsa_port_stp_state_set,
 	/* port */
 	.get_tag_protocol	= yt921x_dsa_get_tag_protocol,
 	.phylink_get_caps	= yt921x_dsa_phylink_get_caps,
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 85d995cdb7c5..2a986b219080 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -220,6 +220,13 @@
 #define  YT921X_VLAN_IGR_FILTER_PORTn(port)	BIT(port)
 #define YT921X_PORTn_ISOLATION(port)	(0x180294 + 4 * (port))
 #define  YT921X_PORT_ISOLATION_BLOCKn(port)	BIT(port)
+#define YT921X_STPn(n)			(0x18038c + 4 * (n))
+#define  YT921X_STP_PORTn_M(port)		GENMASK(2 * (port) + 1, 2 * (port))
+#define   YT921X_STP_PORTn(port, x)			((x) << (2 * (port)))
+#define   YT921X_STP_PORTn_DISABLED(port)		YT921X_STP_PORTn(port, 0)
+#define   YT921X_STP_PORTn_LEARNING(port)		YT921X_STP_PORTn(port, 1)
+#define   YT921X_STP_PORTn_BLOCKING(port)		YT921X_STP_PORTn(port, 2)
+#define   YT921X_STP_PORTn_FORWARD(port)		YT921X_STP_PORTn(port, 3)
 #define YT921X_PORTn_LEARN(port)	(0x1803d0 + 4 * (port))
 #define  YT921X_PORT_LEARN_VID_LEARN_MULTI_EN	BIT(22)
 #define  YT921X_PORT_LEARN_VID_LEARN_MODE	BIT(21)
@@ -395,6 +402,8 @@ enum yt921x_fdb_entry_status {
 	YT921X_FDB_ENTRY_STATUS_STATIC = 7,
 };
 
+#define YT921X_MSTI_NUM		16
+
 #define YT9215_MAJOR	0x9002
 #define YT9218_MAJOR	0x9001
 
-- 
2.51.0


