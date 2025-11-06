Return-Path: <linux-kernel+bounces-887539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B73C38796
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B86C34F79B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C61E9B0D;
	Thu,  6 Nov 2025 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elcd4RZY"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E019DF4D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388776; cv=none; b=RY3SGgnCZkizfGtljKRJp7zGkYk9jecSiksvh+ovgOA4IyHD6lRLVhMP6t7uxXVxOO7MnNHYBcfQA3Gnlm05NRxFHK8VUSHly7OOyb5k1bbnDZcmcfGyRS3mI0+jgMMC+5yHTugde6uZsniR/RecfBtiIPzhSM/DKNxK0PD5iEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388776; c=relaxed/simple;
	bh=1vagyyZCCWaC322iPJ0jzikTtv7ZxpGVPgoAR86lLxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4qC0xu5DAPyk4JTM+ioSkWGwec4woL0A5sWkhPhGPyfTCVlHAobGE+b+vXXKFGJ5avCfz9/O+TdRt0/FapF1RiTxEs5k/P0dKcKiIkXr3RDVoSoL+D++XgiEGzhBtcOD5mrBQnYqVzceSj8h232P5QJTI/RbGSolAa5GvYYjCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elcd4RZY; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7866e9e62e1so4057287b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762388773; x=1762993573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TevgQTeoZLcNkHLCnCTiMLpnQ43etaT1P8DpvGUggw=;
        b=elcd4RZYccCwWSOMErwujlMCP18ztwDuT5IftS4a7zQqTJhGwtnnRI2NtH4XpnRVuR
         /6q5j9qp0FahStGPq2ffJUGjdA65yzKOToUiI708boeKyv5l+8sVQ8oB4hYbzF9cAAyq
         RNMIS8efMWXBXlHozx6Fv9C23hgdVLvYuHBbY7J3XFe1BqstPzxkD4TSioXvOafXY1Hh
         L2eB6P1hnGxYUPaBfkff9fv511XIjFDXXgdWHq1z7UHfrLu95C2xfLiNyuw/GLNJlGwz
         m7Nv5/rJY9L7cI1XadMPDfPeO6XM2k/IGsj5oJYHHpNDxRqjf6upCWnvoZ1wxY+jTvQi
         GnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762388773; x=1762993573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TevgQTeoZLcNkHLCnCTiMLpnQ43etaT1P8DpvGUggw=;
        b=GucpNULN5IuN+yALqaDIUYO0Trylyk1CxrueFq0Vke9IqCJrEwOGnPqtR6hWMf//OR
         ZIWfsplFKFqgScWGU4XFKYfXTNr95UoUusUy/UOMVSiDVYCj+u/5OsYhHdhJrv2PinI2
         jyj8gxeX50azKdVoma966NP+Pzc9+ORW10AEyAKSGSK13+2na0S67S+x/QHKeQ83JC9y
         glkN4TBhTlK2Nr7xCm4KEuodB8Uyk/hEzBBfilOnNJhWvUYFHx4S/pFtBY+QJSbkR/Kn
         WZ+p9NgJ68AbfkLhgShqte7p3H8ip8d62XlNbeVEYKGTyu5LcjyM4c4NomyXYIEgeMKF
         ZPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdW9jPbBZcVYzt9ZvQozNhqWisn8inmT7MqW0aT8UyRbI+/bvt1+y/6kq1cUZrzRXtP8Knhq4cjQZJbfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE/ukrsd1OO7SUkL5BVkHG/BTuWpeIZ3uGQX2Kuvxt6nucD9Rw
	psuBJrKjIo2msbKicTPCu8GiK9+RCnVl7Mx+6Z27izq1F29l4ZhXrMlQ
X-Gm-Gg: ASbGncuqtB99xq+sPpR2CJ6kuuE8rByrFg2n56gi/e4QsLEfs/rwqI9eHR+BIQs2rWS
	dzDFsAtdvr19GwPrqOCTmJ8xQd0bLVTteyvv0CpWwF1a/8+e4ULEzdTvDEBkoog78GrrGU021yg
	TsXYSwmUvM330c7Bv6uU21sN1iCgngwzUb2Jca2D7a+5Wzm97jox0R8nOMuSOldRMFMnhjQ7eBH
	3cSEXR2C0qgxm063L15PviucKpu11/p97dWnqYHJNOzrX/v8OdOh8D1lkRcxeGWf6AwzHudJEbg
	uA1vUJhaOq/AgqGGMgQlwiYVUDE2wy5vNr+UxsUsJCbNJ1sXZL1cL+KRbAS9mJDv1/mEXnCuFLZ
	Iz9bbA7VNrwAaooH4GuSroU1b5CY/ZKHLvKgNDLnSr9BrL6qXDU5123sq2jUuXwf6S+QhGz/NLy
	V2L21F1fnXiQ==
X-Google-Smtp-Source: AGHT+IHvp1gFuqtFzy10m9mJFmg4rE1anfKt+5H7osce0MlN6ZYPG5ynTMrbUc2Tbt/egPhenlcaeQ==
X-Received: by 2002:a05:690c:a089:20b0:786:6f81:eb37 with SMTP id 00721157ae682-786a402d456mr47363307b3.0.1762388772799;
        Wed, 05 Nov 2025 16:26:12 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b13ec33dsm3577997b3.17.2025.11.05.16.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:26:12 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 3/5] psp: add stats from psp spec to driver facing api
Date: Wed,  5 Nov 2025 16:26:04 -0800
Message-ID: <20251106002608.1578518-4-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106002608.1578518-1-daniel.zahka@gmail.com>
References: <20251106002608.1578518-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Provide a driver api for reporting device statistics required by the
"Implementation Requirements" section of the PSP Architecture
Specification. Use a warning to ensure drivers report stats required
by the spec.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v3:
    - remove zero length array from psp_dev_stats

 Documentation/netlink/specs/psp.yaml | 55 ++++++++++++++++++++++++++++
 include/net/psp/types.h              | 23 ++++++++++++
 include/uapi/linux/psp.h             |  8 ++++
 net/psp/psp_main.c                   |  3 +-
 net/psp/psp_nl.c                     | 21 ++++++++++-
 5 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index 914148221384..f3a57782d2cf 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -98,6 +98,61 @@ attribute-sets:
           Number of times a socket's Rx got shut down due to using
           a key which went stale (fully rotated out).
           Kernel statistic.
+      -
+        name: rx-packets
+        type: uint
+        doc: |
+          Number of successfully processed and authenticated PSP packets.
+          Device statistic (from the PSP spec).
+      -
+        name: rx-bytes
+        type: uint
+        doc: |
+          Number of successfully authenticated PSP bytes received, counting from
+          the first byte after the IV through the last byte of payload.
+          The fixed initial portion of the PSP header (16 bytes)
+          and the PSP trailer/ICV (16 bytes) are not included in this count.
+          Device statistic (from the PSP spec).
+      -
+        name: rx-auth-fail
+        type: uint
+        doc: |
+          Number of received PSP packets with unsuccessful authentication.
+          Device statistic (from the PSP spec).
+      -
+        name: rx-error
+        type: uint
+        doc: |
+          Number of received PSP packets with length/framing errors.
+          Device statistic (from the PSP spec).
+      -
+        name: rx-bad
+        type: uint
+        doc: |
+          Number of received PSP packets with miscellaneous errors
+          (invalid master key indicated by SPI, unsupported version, etc.)
+          Device statistic (from the PSP spec).
+      -
+        name: tx-packets
+        type: uint
+        doc: |
+          Number of successfully processed PSP packets for transmission.
+          Device statistic (from the PSP spec).
+      -
+        name: tx-bytes
+        type: uint
+        doc: |
+          Number of successfully processed PSP bytes for transmit, counting from
+          the first byte after the IV through the last byte of payload.
+          The fixed initial portion of the PSP header (16 bytes)
+          and the PSP trailer/ICV (16 bytes) are not included in this count.
+          Device statistic (from the PSP spec).
+      -
+        name: tx-error
+        type: uint
+        doc: |
+          Number of PSP packets for transmission with errors.
+          Device statistic (from the PSP spec).
 
 operations:
   list:
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 5b0ccaac3882..25a9096d4e7d 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -150,6 +150,22 @@ struct psp_assoc {
 	u8 drv_data[] __aligned(8);
 };
 
+struct psp_dev_stats {
+	union {
+		struct {
+			u64 rx_packets;
+			u64 rx_bytes;
+			u64 rx_auth_fail;
+			u64 rx_error;
+			u64 rx_bad;
+			u64 tx_packets;
+			u64 tx_bytes;
+			u64 tx_error;
+		};
+		DECLARE_FLEX_ARRAY(u64, required);
+	};
+};
+
 /**
  * struct psp_dev_ops - netdev driver facing PSP callbacks
  */
@@ -188,6 +204,13 @@ struct psp_dev_ops {
 	 * Remove an association from the device.
 	 */
 	void (*tx_key_del)(struct psp_dev *psd, struct psp_assoc *pas);
+
+	/**
+	 * @get_stats: get statistics from the device
+	 * Stats required by the spec must be maintained and filled in.
+	 * Stats must be filled in member-by-member, never memset the struct.
+	 */
+	void (*get_stats)(struct psp_dev *psd, struct psp_dev_stats *stats);
 };
 
 #endif /* __NET_PSP_H */
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index 31592760ad79..d8449c043ba1 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -49,6 +49,14 @@ enum {
 	PSP_A_STATS_DEV_ID = 1,
 	PSP_A_STATS_KEY_ROTATIONS,
 	PSP_A_STATS_STALE_EVENTS,
+	PSP_A_STATS_RX_PACKETS,
+	PSP_A_STATS_RX_BYTES,
+	PSP_A_STATS_RX_AUTH_FAIL,
+	PSP_A_STATS_RX_ERROR,
+	PSP_A_STATS_RX_BAD,
+	PSP_A_STATS_TX_PACKETS,
+	PSP_A_STATS_TX_BYTES,
+	PSP_A_STATS_TX_ERROR,
 
 	__PSP_A_STATS_MAX,
 	PSP_A_STATS_MAX = (__PSP_A_STATS_MAX - 1)
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 481aaf0fc9fc..a8534124f626 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -60,7 +60,8 @@ psp_dev_create(struct net_device *netdev,
 		    !psd_ops->key_rotate ||
 		    !psd_ops->rx_spi_alloc ||
 		    !psd_ops->tx_key_add ||
-		    !psd_ops->tx_key_del))
+		    !psd_ops->tx_key_del ||
+		    !psd_ops->get_stats))
 		return ERR_PTR(-EINVAL);
 
 	psd = kzalloc(sizeof(*psd), GFP_KERNEL);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index f990cccbe99c..6afd7707ec12 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/ethtool.h>
 #include <linux/skbuff.h>
 #include <linux/xarray.h>
 #include <net/genetlink.h>
@@ -509,7 +510,17 @@ static int
 psp_nl_stats_fill(struct psp_dev *psd, struct sk_buff *rsp,
 		  const struct genl_info *info)
 {
+	unsigned int required_cnt = sizeof(struct psp_dev_stats) / sizeof(u64);
+	struct psp_dev_stats stats;
 	void *hdr;
+	int i;
+
+	memset(&stats, 0xff, sizeof(stats));
+	psd->ops->get_stats(psd, &stats);
+
+	for (i = 0; i < required_cnt; i++)
+		if (WARN_ON_ONCE(stats.required[i] == ETHTOOL_STAT_NOT_SET))
+			return -EOPNOTSUPP;
 
 	hdr = genlmsg_iput(rsp, info);
 	if (!hdr)
@@ -518,7 +529,15 @@ psp_nl_stats_fill(struct psp_dev *psd, struct sk_buff *rsp,
 	if (nla_put_u32(rsp, PSP_A_STATS_DEV_ID, psd->id) ||
 	    nla_put_uint(rsp, PSP_A_STATS_KEY_ROTATIONS,
 			 psd->stats.rotations) ||
-	    nla_put_uint(rsp, PSP_A_STATS_STALE_EVENTS, psd->stats.stales))
+	    nla_put_uint(rsp, PSP_A_STATS_STALE_EVENTS, psd->stats.stales) ||
+	    nla_put_uint(rsp, PSP_A_STATS_RX_PACKETS, stats.rx_packets) ||
+	    nla_put_uint(rsp, PSP_A_STATS_RX_BYTES, stats.rx_bytes) ||
+	    nla_put_uint(rsp, PSP_A_STATS_RX_AUTH_FAIL, stats.rx_auth_fail) ||
+	    nla_put_uint(rsp, PSP_A_STATS_RX_ERROR, stats.rx_error) ||
+	    nla_put_uint(rsp, PSP_A_STATS_RX_BAD, stats.rx_bad) ||
+	    nla_put_uint(rsp, PSP_A_STATS_TX_PACKETS, stats.tx_packets) ||
+	    nla_put_uint(rsp, PSP_A_STATS_TX_BYTES, stats.tx_bytes) ||
+	    nla_put_uint(rsp, PSP_A_STATS_TX_ERROR, stats.tx_error))
 		goto err_cancel_msg;
 
 	genlmsg_end(rsp, hdr);
-- 
2.47.3


