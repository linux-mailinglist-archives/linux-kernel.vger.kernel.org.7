Return-Path: <linux-kernel+bounces-804330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7B5B47248
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0A65A0E18
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3F42F60B6;
	Sat,  6 Sep 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thU1Yi3U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6F28488F;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173420; cv=none; b=uZOoE9WTkzHgP3yzEv9l7jzsezZtpsK2C5QJJPQiwSyQkTPfbz9juzoj5cPvgKVVVjixKo987rxLvGDc/UufgjPmRL7rAwxNRSE8gPEp8NWdwcIyfq6fgQ+AzL8JdH/p5cUtTd87IXWHmZks9cAWIU/eAV/+cJ2w/4EWXTR3A08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173420; c=relaxed/simple;
	bh=Xg9QJiSBBIwd6sYFd4P5Er5AJf6QTVlzXtTmrm9L9YQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XICzTxhau49Pvig0xt7aRdFkA2uLghcPC95aiQ8MILrPLSI0tgtCIouHVxeooYCqQnG6WDxBgygU7130/iLgPvATwftrIjspsr+Orzu3scQwiYfQuyjK43KQmJ9kx0txgIjx1x63stxKCgUm8TGppr+ypP4ZIdyJEQZXARwYw5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thU1Yi3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8D12C2BCAF;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173419;
	bh=Xg9QJiSBBIwd6sYFd4P5Er5AJf6QTVlzXtTmrm9L9YQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=thU1Yi3U5IIXEBXKBA7HcqyHHBfCkMPqXRl/zO2eZlH/6r6txATifLn8InixYei1X
	 8pfYGLonQ+83/F3NRMTvBnDFJiwts3Ze5vs/sOBeDyS1KvuzGG0VFEeNKDr8BaI9WR
	 JIKq8gRMAZ+62r6AanhJVE5Uf4SrQ/P9ktXs1nCyY5txlqNbuhR1RDOkCWAvS8hfJ4
	 9Y9rmPxFDYXFdKDGk5m031TTwbDrgl1wwuJXr4IAtRpWdyX/2uJpTf/v0+XGFhhF74
	 VGvN/jer9YI0F8NNlbqEEBFWggXn053YSGwrjMQrARzomD4oy27IOiHihzvS58FU2/
	 xyEIQOp8TzUYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F48FCA1012;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 06 Sep 2025 15:43:21 +0000
Subject: [PATCH v2 08/22] usb: typec: tipd: Trace data status for CD321x
 correctly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-atcphy-6-17-v2-8-52c348623ef6@kernel.org>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
In-Reply-To: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5697; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=Xg9QJiSBBIwd6sYFd4P5Er5AJf6QTVlzXtTmrm9L9YQ=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8aesPnbv/qwGHjIlK87sXONUYreKd8fK89yixpk/Xtz/
 PcF+blCHaUsDGIcDLJiiizb99ubPnn4RnDppkvvYeawMoEMYeDiFICJ/GFhZLj954lK5UbBYouu
 mvJv/iXdh9Zrx2f8vcA5L8TTa8vJo2yMDMvCds4zvKW3Kl5w0QK1Jsn2tIPNH9YlHroj9u9V+rM
 KdX4A
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Some bits inside the CD321x TPS_DATA_STATUS register have a different
function compared to the original tipd chip. Add these and introduce a
separate trace function to show them correctly.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
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



