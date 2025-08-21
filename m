Return-Path: <linux-kernel+bounces-780211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9391DB2FF31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C800178DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7DB343D62;
	Thu, 21 Aug 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHGYyTDw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0B2D29A9;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790804; cv=none; b=IvUgSRgjIyfe6tvfkxnL5dtfEX+zedbidLaQlEPJHlTZ8XLGWG0lWRnfqfSWsl61VtG/U2JkEZHa//T9UgyX9/8VPAz39VYzqJuXIzNHgQ3TsK4dYLtaRoWLaCU5wAt3EkCzoUNTjSarq4zaYCLNt6nLyOA5Ve0QFJJGiuJeJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790804; c=relaxed/simple;
	bh=hnmuUFqvGZNU4NKGWfmLAcmVh08iHpPd45mdU/kARqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHZAki/s6wwxac6N6emJuwTSamLCnd/PfyYOf5zIjtl/aycpMVt/lTiWDYlGTPZBzmgJC1TisXILN3VhVwnpdixJBlvp2LU00YYu9FRwc9hKP3/GYJBKXgw7F4gVJh76JJcxnTmCdAxxB8d6oq36fCFTs141k3tTILOiBcH2kZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHGYyTDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF511C4CEF4;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790803;
	bh=hnmuUFqvGZNU4NKGWfmLAcmVh08iHpPd45mdU/kARqM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LHGYyTDwseZPPxq6NTjO2HZYyvPceFJRDj04oLsbDvyQH+PZYI7Yae88FVBmsrCul
	 y2JtJdrj82S0k5Ity3s/AIJ9r+XIq4ov5lzuEGTMH7jDmd+Nb2cu5An0cDNOznJ6OE
	 Dx2E/wwLOwtHyBWITeEhNTwyydsNvVfcCWdOrnHh6BVpOMB3GeSlOFhqEVQ30pNEi4
	 1gkYKOdRdQsrtdb1wUUInRd02zNZYFTB+0F3rxYWy4cxsL/cwlnwRso8OMAIU4cgD6
	 Wo78UMUOtZ8L/9tC8OiZje2rAxVHvymg0xxVtouDdp8se2yzIb+973XiXhv44FwHbn
	 /d79tUDl5l5cQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4796CA0FE2;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 21 Aug 2025 15:39:03 +0000
Subject: [PATCH RFC 11/22] usb: typec: tipd: Trace data status for CD321x
 correctly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-atcphy-6-17-v1-11-172beda182b8@kernel.org>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
In-Reply-To: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5633; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=hnmuUFqvGZNU4NKGWfmLAcmVh08iHpPd45mdU/kARqM=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Zy23VF8/w3PllneCuQ+7KGito92bP6Hzawe7LaXf195
 XiffidjRykLgxgHg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAit1IY/intd3+398bSg7Vf
 LijtuCP5J+dK/ezfS+2XCOTpbNPe9vMYwz+L3cW3CmJifCt61hTavg31yPuspvKVU3ivU6BCxun
 WtawA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Some bits inside the CD321x TPS_DATA_STATUS register have a different
function compared to the original tipd chip. Add these and introduce a
separate trace function to show them correctly.

Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c     |  8 +++++++-
 drivers/usb/typec/tipd/tps6598x.h |  5 +++++
 drivers/usb/typec/tipd/trace.h    | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 4815c5c462837865a5f9d37bbc139249c82c2f75..19d713937870304e68325a441b0de63eb5db3b80 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -114,6 +114,7 @@ struct tipd_data {
 	irq_handler_t irq_handler;
 	u64 irq_mask1;
 	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
+	void (*trace_data_status)(u32 status);
 	void (*trace_power_status)(u16 status);
 	void (*trace_status)(u32 status);
 	int (*apply_patch)(struct tps6598x *tps);
@@ -492,7 +493,9 @@ static bool tps6598x_read_data_status(struct tps6598x *tps)
 		dev_err(tps->dev, "failed to read data status: %d\n", ret);
 		return false;
 	}
-	trace_tps6598x_data_status(data_status);
+
+	if (tps->data->trace_data_status)
+		tps->data->trace_data_status(data_status);
 
 	return true;
 }
@@ -1519,6 +1522,7 @@ static const struct tipd_data cd321x_data = {
 		     APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
 		     APPLE_CD_REG_INT_PLUG_EVENT,
 	.register_port = tps6598x_register_port,
+	.trace_data_status = trace_cd321x_data_status,
 	.trace_power_status = trace_tps6598x_power_status,
 	.trace_status = trace_tps6598x_status,
 	.init = cd321x_init,
@@ -1532,6 +1536,7 @@ static const struct tipd_data tps6598x_data = {
 		     TPS_REG_INT_DATA_STATUS_UPDATE |
 		     TPS_REG_INT_PLUG_EVENT,
 	.register_port = tps6598x_register_port,
+	.trace_data_status = trace_tps6598x_data_status,
 	.trace_power_status = trace_tps6598x_power_status,
 	.trace_status = trace_tps6598x_status,
 	.apply_patch = tps6598x_apply_patch,
@@ -1545,6 +1550,7 @@ static const struct tipd_data tps25750_data = {
 		     TPS_REG_INT_DATA_STATUS_UPDATE |
 		     TPS_REG_INT_PLUG_EVENT,
 	.register_port = tps25750_register_port,
+	.trace_data_status = trace_tps6598x_data_status,
 	.trace_power_status = trace_tps25750_power_status,
 	.trace_status = trace_tps25750_status,
 	.apply_patch = tps25750_apply_patch,
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index cecb8d11d23972dab0d8c15458b4052af7510b03..03edbb77bbd6d8093b2560db83e5913e25d06154 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -197,6 +197,11 @@
 #define TPS_DATA_STATUS_FORCE_LSX	     BIT(23)
 #define TPS_DATA_STATUS_POWER_MISMATCH	     BIT(24)
 
+/* modified TPS_REG_DATA_STATUS bits for CD321x (and likely also TPS65987DDK) */
+#define CD321X_DATA_STATUS_HPD_IRQ	     BIT(14)
+#define CD321X_DATA_STATUS_HPD_LEVEL	     BIT(15)
+#define CD321X_DATA_STATUS_USB4_CONNECTION   BIT(23)
+
 #define TPS_DATA_STATUS_DP_PIN_ASSIGNMENT_MASK GENMASK(11, 10)
 #define TPS_DATA_STATUS_DP_PIN_ASSIGNMENT(x) \
 	TPS_FIELD_GET(TPS_DATA_STATUS_DP_PIN_ASSIGNMENT_MASK, (x))
diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
index bea383f2db9de5bbf1804fbad9ee6b134407b932..e9e40425138a01f15e35867f38f62e13623dbcec 100644
--- a/drivers/usb/typec/tipd/trace.h
+++ b/drivers/usb/typec/tipd/trace.h
@@ -217,6 +217,26 @@
 		{ TPS_DATA_STATUS_FORCE_LSX,		"FORCE_LSX" }, \
 		{ TPS_DATA_STATUS_POWER_MISMATCH,	"POWER_MISMATCH" })
 
+#define show_cd321x_data_status_flags(data_status) \
+	__print_flags(data_status & TPS_DATA_STATUS_FLAGS_MASK, "|", \
+		{ TPS_DATA_STATUS_DATA_CONNECTION,	"DATA_CONNECTION" }, \
+		{ TPS_DATA_STATUS_UPSIDE_DOWN,		"DATA_UPSIDE_DOWN" }, \
+		{ TPS_DATA_STATUS_ACTIVE_CABLE,		"ACTIVE_CABLE" }, \
+		{ TPS_DATA_STATUS_USB2_CONNECTION,	"USB2_CONNECTION" }, \
+		{ TPS_DATA_STATUS_USB3_CONNECTION,	"USB3_CONNECTION" }, \
+		{ TPS_DATA_STATUS_USB3_GEN2,		"USB3_GEN2" }, \
+		{ TPS_DATA_STATUS_USB_DATA_ROLE,	"USB_DATA_ROLE" }, \
+		{ TPS_DATA_STATUS_DP_CONNECTION,	"DP_CONNECTION" }, \
+		{ TPS_DATA_STATUS_DP_SINK,		"DP_SINK" }, \
+		{ CD321X_DATA_STATUS_HPD_IRQ,		"HPD_IRQ" }, \
+		{ CD321X_DATA_STATUS_HPD_LEVEL,		"HPD_LEVEL" }, \
+		{ TPS_DATA_STATUS_TBT_CONNECTION,	"TBT_CONNECTION" }, \
+		{ TPS_DATA_STATUS_TBT_TYPE,		"TBT_TYPE" }, \
+		{ TPS_DATA_STATUS_OPTICAL_CABLE,	"OPTICAL_CABLE" }, \
+		{ TPS_DATA_STATUS_ACTIVE_LINK_TRAIN,	"ACTIVE_LINK_TRAIN" }, \
+		{ CD321X_DATA_STATUS_USB4_CONNECTION,	"USB4" }, \
+		{ TPS_DATA_STATUS_POWER_MISMATCH,	"POWER_MISMATCH" })
+
 #define show_data_status_dp_pin_assignment(data_status) \
 	__print_symbolic(TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT(data_status), \
 		{ TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_E, "E" }, \
@@ -388,6 +408,25 @@ TRACE_EVENT(tps6598x_data_status,
 		    )
 );
 
+TRACE_EVENT(cd321x_data_status,
+	TP_PROTO(u32 data_status),
+	TP_ARGS(data_status),
+
+	TP_STRUCT__entry(
+			 __field(u32, data_status)
+			 ),
+
+	TP_fast_assign(
+		       __entry->data_status = data_status;
+		       ),
+
+	TP_printk("%s%s%s",
+		  show_cd321x_data_status_flags(__entry->data_status),
+		  __entry->data_status & TPS_DATA_STATUS_DP_CONNECTION ? ", DP pinout " : "",
+		  maybe_show_data_status_dp_pin_assignment(__entry->data_status)
+		)
+);
+
 #endif /* _TPS6598X_TRACE_H_ */
 
 /* This part must be outside protection */

-- 
2.34.1



