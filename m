Return-Path: <linux-kernel+bounces-853063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1152BDA903
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A531F18A3104
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F10302CB1;
	Tue, 14 Oct 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4X0EahX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAEF25487B;
	Tue, 14 Oct 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458053; cv=none; b=gCSmROqP25VRUsDEt4FBQkjqiBO9EjShgPQrIS/zsbLGGFtGbQCAmzmmxCts0wJpojbxVZn7LkoY3S/1h+VJRdLWgGNCOY7hXF2fjZKGIfmq6PhBkI3557kJf4BVLnApwDU0syg3J1yvlKCQAw4YIMhxwTfqssWUhM6b7ycK6JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458053; c=relaxed/simple;
	bh=1jBubh4KbgOHkcgKFedwooTlIiB56NAjgSkhvCjAH7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIIitS5noprkcgJnRzwzTrwEkDVvDADDc8y9neJG/Ei5RyHUHsATNBex+FQ/5n2elad0np9HEnhRnMzTyusSKKluIkizGNJGyI4NDsLMCwbYVeKyknKlxt/JjhljW2LEoMKtLZLq+GR6IcWmjQAIeugDSRPJDbwWs8MxJMoZkZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4X0EahX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3D5C4CEE7;
	Tue, 14 Oct 2025 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760458053;
	bh=1jBubh4KbgOHkcgKFedwooTlIiB56NAjgSkhvCjAH7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k4X0EahX5vxzaBxhcgQbXtYCGvZGzoBm9unwpvyfFFkzq09bWqjHKiU5Jb0rW92ct
	 qBMssPV82DJTk8uPwSf+MIyWsKdyUNTWATS3ookdcKwwEnwJvDiVkWquKmvnRzUQOX
	 6Y4NkKYOYNgkqCcgURNfpRpj6zBurh528fa+tIViZyxyZRlkFKtE0N+cb0vWitCknV
	 leP+ZQHTWPbig3QpCQ3vIVhFWThxl9An1k+fgq2gtVWHXp/Wc6MGmon75+vflotVza
	 vpRCH9N437uScx/jzMeAJamdXtRaoU9uhPExBegRQYTo2kofkUblQNIS4qL00XcH6T
	 j93Cka1qzM84g==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 14 Oct 2025 18:06:47 +0200
Subject: [PATCH 3/3] usb: typec: ps883x: Add USB4 mode and TBT3 altmode
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-topic-ps883x_usb4-v1-3-e6adb1a4296e@oss.qualcomm.com>
References: <20251014-topic-ps883x_usb4-v1-0-e6adb1a4296e@oss.qualcomm.com>
In-Reply-To: <20251014-topic-ps883x_usb4-v1-0-e6adb1a4296e@oss.qualcomm.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, 
 Jack Pham <jack.pham@oss.qualcomm.com>, 
 Raghavendra Thoorpu <rthoorpu@qti.qualcomm.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760458037; l=3510;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=9yQEyyiSxsY8LkSz9hKPBgVq0JFcAAW/MtHb2Out5tw=;
 b=FCpZ2U/ZGEc1lLV4jctKN8Ju/gXhNU9Tc9CMhPL3d7bV+zdpQ1VrLcly156UjryAQ2GfPgMw7
 M7L4CnM3/deCaiJ7Y06g1eNb3U1vu2Ye+Dw6KFxfpzcsKI2CsUVXXlq
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

This chip can do some more than the driver currently describes. Add
support for configuring it for various flavors of TBT3/USB4 operation.

Reviewed-by: Jack Pham <jack.pham@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/usb/typec/mux/ps883x.c | 29 +++++++++++++++++++++++++++++
 include/linux/usb/typec_tbt.h  |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index 72f1e737ca4b..7c61629b36d6 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -14,15 +14,18 @@
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/usb/pd.h>
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
 #include <linux/usb/typec_retimer.h>
+#include <linux/usb/typec_tbt.h>
 
 #define REG_USB_PORT_CONN_STATUS_0		0x00
 
 #define CONN_STATUS_0_CONNECTION_PRESENT	BIT(0)
 #define CONN_STATUS_0_ORIENTATION_REVERSED	BIT(1)
+#define CONN_STATUS_0_ACTIVE_CABLE		BIT(2)
 #define CONN_STATUS_0_USB_3_1_CONNECTED		BIT(5)
 
 #define REG_USB_PORT_CONN_STATUS_1		0x01
@@ -34,6 +37,10 @@
 
 #define REG_USB_PORT_CONN_STATUS_2		0x02
 
+#define CONN_STATUS_2_TBT_CONNECTED		BIT(0)
+#define CONN_STATUS_2_TBT_UNIDIR_LSRX_ACT_LT	BIT(4)
+#define CONN_STATUS_2_USB4_CONNECTED		BIT(7)
+
 struct ps883x_retimer {
 	struct i2c_client *client;
 	struct gpio_desc *reset_gpio;
@@ -95,6 +102,8 @@ static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
 
 static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state *state)
 {
+	struct typec_thunderbolt_data *tb_data;
+	const struct enter_usb_data *eudo_data;
 	int cfg0 = CONN_STATUS_0_CONNECTION_PRESENT;
 	int cfg1 = 0x00;
 	int cfg2 = 0x00;
@@ -120,6 +129,18 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
 				break;
 			}
 			break;
+		case USB_TYPEC_TBT_SID:
+			tb_data = state->data;
+
+			/* Unconditional */
+			cfg2 |= CONN_STATUS_2_TBT_CONNECTED;
+
+			if (tb_data->cable_mode & TBT_CABLE_ACTIVE_PASSIVE)
+				cfg0 |= CONN_STATUS_0_ACTIVE_CABLE;
+
+			if (tb_data->enter_vdo & TBT_ENTER_MODE_UNI_DIR_LSRX)
+				cfg2 |= CONN_STATUS_2_TBT_UNIDIR_LSRX_ACT_LT;
+			break;
 		default:
 			dev_err(&retimer->client->dev, "Got unsupported SID: 0x%x\n",
 				state->alt->svid);
@@ -135,6 +156,14 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
 		case TYPEC_MODE_USB3:
 			cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
 			break;
+		case TYPEC_MODE_USB4:
+			eudo_data = state->data;
+
+			cfg2 |= CONN_STATUS_2_USB4_CONNECTED;
+
+			if (FIELD_GET(EUDO_CABLE_TYPE_MASK, eudo_data->eudo) != EUDO_CABLE_TYPE_PASSIVE)
+				cfg0 |= CONN_STATUS_0_ACTIVE_CABLE;
+			break;
 		default:
 			dev_err(&retimer->client->dev, "Got unsupported mode: %lu\n",
 				state->mode);
diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
index 55dcea12082c..0b570f1b8bc8 100644
--- a/include/linux/usb/typec_tbt.h
+++ b/include/linux/usb/typec_tbt.h
@@ -55,6 +55,7 @@ struct typec_thunderbolt_data {
 
 /* TBT3 Device Enter Mode VDO bits */
 #define TBT_ENTER_MODE_CABLE_SPEED(s)	TBT_SET_CABLE_SPEED(s)
+#define TBT_ENTER_MODE_UNI_DIR_LSRX	BIT(23)
 #define TBT_ENTER_MODE_ACTIVE_CABLE	BIT(24)
 
 #endif /* __USB_TYPEC_TBT_H */

-- 
2.51.0


