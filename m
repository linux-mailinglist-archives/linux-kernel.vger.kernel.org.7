Return-Path: <linux-kernel+bounces-863292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D92BF77A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 223EE4ECE65
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FA734676D;
	Tue, 21 Oct 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yjr8X3gn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14FA3451A2;
	Tue, 21 Oct 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061677; cv=none; b=NinT8JtRgQO2lmWYcNlDz+EV6lwpV1ZflyLWLTwtdsh4Xxutza2QHioa/bpZY5WBkiJTnyU0RCM3+jl7Ax/5N09pLIwr5ynsOvWHU8b1Hc0IbACR/VQZrGQhq7piv3kkgvfCzSDNZQceOPB8jjYLTVhidzDG0VwHdhmqEtw4n3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061677; c=relaxed/simple;
	bh=KxWfStPCsdAJffcmrXgkN/o73wm2RB31sl71hbd/rIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cgo4x+AIRKqyYbjeZZEM9JXM2AHefceLf7LGGp9IoDi5SKF4nQ6M58KpRJSxV3ySGUg5A+jtjsGy/OzmkJ5ibma9WyrQ7Fd27lo4izkpPkhhX73PsE390yrbBqPlgswE/XAWDXRbahKveRFNomr/D9rXpgHyyxtFyYD05xEcW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yjr8X3gn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EC3C4CEF1;
	Tue, 21 Oct 2025 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061677;
	bh=KxWfStPCsdAJffcmrXgkN/o73wm2RB31sl71hbd/rIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yjr8X3gnrA+d1f4BEDdbVedEJHhAy+Cnd3AW9dMAkBk6/bEFjjVJcWOAD4ykxrrQB
	 JvFGLGfrHkSm69m0Kc/sPu8uxtXKb70LY4elleaYjhl2wVZ+Wee18EzVdlm3HHIcsI
	 nZpSpBgsYxBF2GNLOialKnednEaed3GLq0IwX6XSUI+ec/zI6sS4ZZz5lTK1kixXCw
	 Ne4llz7TUWIiQ/uCepE0G7KyCoixttAPk+EsqLocU0vJNvOOlb1Csv2LEN4hgmTEZl
	 MvJZ/vpseMFL44v3K2lX7gaq09JBYKPSbvwUEN+a2sEdsx7XXnZCkrTM3fGmXgIT1o
	 dg/zcUwNQ/GMQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 21 Oct 2025 17:47:05 +0200
Subject: [PATCH v2 05/10] can: netlink: add CAN_CTRLMODE_XL_TMS flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-canxl-netlink-v2-5-8b8f58257ab6@kernel.org>
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
In-Reply-To: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7104; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=KxWfStPCsdAJffcmrXgkN/o73wm2RB31sl71hbd/rIo=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnfV/MvnWriYrbDXsDm5dv8Ryms3s0ac4xecpQqa335s
 rPwUpBVRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIlML2P4w+0k/vuh5DpTYYXu
 yPN3AsRa1C65BmyJfnL55vMzfGdX6TD8lZ695VnrnzcP/t3dWMb6kdMupuTrwqIO7bJvD5nDU5s
 DeQE=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The Transceiver Mode Switching (TMS) indicates whether the CAN XL
controller shall use the PWM or NRZ encoding during the data phase.

The term "transceiver mode switching" is used in both ISO 11898-1 and
CiA 612-2 (although only the latter one uses the abbreviation TMS). We
adopt the same naming convention here for consistency.

Add the CAN_CTRLMODE_XL_TMS flag to the list of the CAN control modes.

In the netlink interface, each boolean option is in reality a tristate
in disguise: on, off or omitted. For the moment, TMS is implemented as
below:

  - CAN_CTRLMODE_XL_TMS is set to false: TMS is disabled.
  - CAN_CTRLMODE_XL_TMS is set to true: TMS is enabled.
  - CAN_CTRLMODE_XL_TMS is omitted: return -EOPNOTSUPP.

For most of the other control modes, omitting a flag default to the
option turned off. It could also be possible to provide a default
behaviour if the TMS flag is omitted (i.e. either default to TMS off
or on). However, it is not clear for the moment which default
behaviour is preferable. If the usage shows a clear trend (for example
if the vast majority of the users want TMS on by default), it is still
possible to revisit that choice in the future. Whereas once a default
option is provided, we can not change it back without breaking the
interface.

As a corollary, for the moment, the users will be forced to specify
the TMS in the ip tool when using CAN XL.

Add can_validate_xl_flags() to check the coherency of the TMS flag.
That function will be reused in upcoming changes to validate the other
CAN XL flags.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Question:

Is it still possible to send Classical CAN frames when TMS is on? If
not, we need to also add this filter in can_dev_dropped_skb():

	if ((priv->ctrlmode & CAN_CTRLMODE_XL_TMS) && !can_is_canxl_skb(skb)) {
		netdev_info_once(dev,
				 "Classical CAN frames are not allowed under CAN XL's TMS mode\n");
		goto invalid_skb;
	}

My current assumption is that this is possible. But the standard being
not crystal clear on that point, I want to double check this with you!
---
 drivers/net/can/dev/dev.c        |  2 ++
 drivers/net/can/dev/netlink.c    | 52 +++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/can/netlink.h |  1 +
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 32f11db88295..1de5babcc4f3 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -123,6 +123,8 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
 		return "xl-tdc-auto";
 	case CAN_CTRLMODE_XL_TDC_MANUAL:
 		return "xl-tdc-manual";
+	case CAN_CTRLMODE_XL_TMS:
+		return "xl-tms";
 	default:
 		return "<unknown>";
 	}
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 2405f1265488..8afd2baa03cf 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -181,6 +181,36 @@ static int can_validate_databittiming(struct nlattr *data[],
 	return 0;
 }
 
+static int can_validate_xl_flags(struct netlink_ext_ack *extack,
+				 u32 masked_flags, u32 mask)
+{
+	if (masked_flags & CAN_CTRLMODE_XL) {
+		if (!(mask & CAN_CTRLMODE_XL_TMS)) {
+			NL_SET_ERR_MSG(extack, "Specify whether TMS is on or off");
+			return -EOPNOTSUPP;
+		}
+		if (masked_flags & CAN_CTRLMODE_XL_TMS) {
+			const u32 tms_conflicts_mask = CAN_CTRLMODE_FD |
+				CAN_CTRLMODE_XL_TDC_MASK;
+			u32 tms_conflicts = masked_flags & tms_conflicts_mask;
+
+			if (tms_conflicts) {
+				NL_SET_ERR_MSG_FMT(extack,
+						   "TMS and %s are mutually exclusive",
+						   can_get_ctrlmode_str(tms_conflicts));
+				return -EOPNOTSUPP;
+			}
+		}
+	} else {
+		if (mask & CAN_CTRLMODE_XL_TMS) {
+			NL_SET_ERR_MSG(extack, "TMS requires CAN XL");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
@@ -201,6 +231,10 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 				       "Listen-only and restricted modes are mutually exclusive");
 			return -EOPNOTSUPP;
 		}
+
+		err = can_validate_xl_flags(extack, flags, cm->mask);
+		if (err)
+			return err;
 	}
 
 	err = can_validate_bittiming(data, extack, IFLA_CAN_BITTIMING);
@@ -227,7 +261,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 	struct can_priv *priv = netdev_priv(dev);
 	struct can_ctrlmode *cm;
 	const u32 xl_mandatory = CAN_CTRLMODE_RESTRICTED;
-	u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing, xl_missing;
+	u32 ctrlstatic, maskedflags, deactivated, notsupp, ctrlstatic_missing, xl_missing;
 
 	if (!data[IFLA_CAN_CTRLMODE])
 		return 0;
@@ -239,6 +273,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 	cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 	ctrlstatic = can_get_static_ctrlmode(priv);
 	maskedflags = cm->flags & cm->mask;
+	deactivated = ~cm->flags & cm->mask;
 	notsupp = maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);
 	ctrlstatic_missing = (maskedflags & ctrlstatic) ^ ctrlstatic;
 	xl_missing = (priv->ctrlmode_supported & xl_mandatory) ^ xl_mandatory;
@@ -268,11 +303,21 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 		return -EOPNOTSUPP;
 	}
 
+	/* If FD was active and is not turned off, check for XL conflicts */
+	if (priv->ctrlmode & CAN_CTRLMODE_FD & ~deactivated) {
+		if (maskedflags & CAN_CTRLMODE_XL_TMS) {
+			NL_SET_ERR_MSG(extack,
+				       "TMS can not be activated while CAN FD is on");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	/* If a top dependency flag is provided, reset all its dependencies */
 	if (cm->mask & CAN_CTRLMODE_FD)
 		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 	if (cm->mask & CAN_CTRLMODE_XL)
-		priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK);
+		priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK |
+				    CAN_CTRLMODE_XL_TMS);
 
 	/* clear bits to be modified and copy the flag values */
 	priv->ctrlmode &= ~cm->mask;
@@ -404,7 +449,8 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 
-		need_tdc_calc = !(cm->mask & tdc_mask);
+		if (fd || !(priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
+			need_tdc_calc = !(cm->mask & tdc_mask);
 	}
 	if (data_tdc) {
 		/* TDC parameters are provided: use them */
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index c2c96c5978a8..ebafb091d80f 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -107,6 +107,7 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_XL			0x1000	/* CAN XL mode */
 #define CAN_CTRLMODE_XL_TDC_AUTO	0x2000	/* XL transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_XL_TDC_MANUAL	0x4000	/* XL TDCV is manually set up by user */
+#define CAN_CTRLMODE_XL_TMS		0x8000	/* Transceiver Mode Switching */
 
 /*
  * CAN device statistics

-- 
2.51.0


