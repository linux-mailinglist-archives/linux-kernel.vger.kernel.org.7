Return-Path: <linux-kernel+bounces-834026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98015BA3A09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 876584E3340
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6062EC0AD;
	Fri, 26 Sep 2025 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkMPfMsU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCC72605;
	Fri, 26 Sep 2025 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889995; cv=none; b=qayYjbFvS5oL4NLMOcG4NTmlsU64S7wgPj+OzwDWxaGpmrqgvC2L/rY/1ZlwQ0p1HpkBL4dCuUUWFc3qBLmndJJw+Gb3/JGopU6nj4xgbjuHMUGF6uKhmgVSa00yC/tlbUE5deKQVNOftuicMzqY+TxdvP/jk43OpImTy7q8r6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889995; c=relaxed/simple;
	bh=4+1tRzVhNQZqZISoH3nF8LUCbcvlSY1x9+Q6tE1np2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZnMMtBVYzxX/BSan2mxyJw7cGAsk01qtd3304AnnMt5BaV6DF6ohPGLTOEMjy2ZLrdEJxVj//2uQQ9p27l5ZDVDUNxaJwCsdNSU6vsRZs4bswpUe70s8MNqrqd994wQZ2aRfb8qMWI4jCgpbE3MEbOAZh75Z4uwwqsrhfOQUEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkMPfMsU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A7DC4CEF4;
	Fri, 26 Sep 2025 12:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758889994;
	bh=4+1tRzVhNQZqZISoH3nF8LUCbcvlSY1x9+Q6tE1np2k=;
	h=From:Date:Subject:To:Cc:From;
	b=kkMPfMsUY3lcLlxllk7Lw/Donl/KYvLwtpQ7sgYXxp6XHpWMo6+xXNcNseBn20Hx7
	 e4aLwC5mKXSZRBFYZApYTDT34fuBsIvkfK0nZMdX5X5EMIvz7vzh/g27g/KEIZQosL
	 b2+7iOhebL/hgDaLC9oOeJBgzLlNUdlZu4g8V9a8HqOWcBY3jeSgR91J4ofldGR+lt
	 qCVhtQevz8s8jV6I8SeSNBUVrMN/M1FMs8Ed9ejfLMyFW1siDEfYe+GjmXm34EQ/eD
	 u6kARTzHP72rF5OrTbVlOVEoMut2aMKNzlqwLDpKSUQZVzKpSQZLqVtSx+qXnJaWtM
	 1fIxXbfWx5ukA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 26 Sep 2025 14:32:57 +0200
Subject: [PATCH RFC] usb: typec: thunderbolt: Fix Thunderbolt adapter type
 bitfield values
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-topic-tbt_header_bit_fix-v1-1-122238af5c82@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPiH1mgC/x2MQQqAIBAAvxJ7Tkixor4SIZpb7UVFJQLx70nHG
 ZgpkDASJli7AhEfSuRdA953cNzaXcjINgYxiHFYxMSyD3SwbLK6UVuMylBWJ72MzxrNKKQ9pYa
 Wh4hN/+ttr/UDVrM3iGoAAAA=
X-Change-ID: 20250926-topic-tbt_header_bit_fix-17aeb524df4a
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benson Leung <bleung@chromium.org>, 
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
 Jameson Thies <jthies@google.com>, 
 Andrei Kuchynski <akuchynski@chromium.org>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758889991; l=2215;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=7QpLWLu8PgrjfZxEBjFQ8NKZwrs8cAsuf9WxFheZyp4=;
 b=6IqfbgXRii2rc0AO2UTTgQJaI6ZjgZRdS1Ln5HFf2o0bymWbUHBMbb4XO06y1OnoKeDqrOxrG
 NZsN0xu6B4bC1t2UTrM4DQRaUialVf1JaVUA0ENjbK7W3Uc7D5bH5zL
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The value has been amended with the release of the USB Type-C
Specification v2.1, reportedly as an erratum.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
I bundled a change to the CrOS EC driver based on the assumption that
it worked around the faulty definition. I see the Intel PMC mux driver
also checks for this bit, but it seems like that driver assumes that
the value is in-spec (i.e. it may be buggy as of right now).

Adding the respective maintainers to make sure everyone can see this.
---
 drivers/platform/chrome/cros_ec_typec.c | 2 +-
 include/linux/usb/typec_tbt.h           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index b712bcff6fb2674ec79286159090df6d79b32e9a..d80f3de1b87c362a2825bd19f826c5be077583aa 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -585,7 +585,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
 	data.device_mode = TBT_MODE;
 
 	if (pd_ctrl->control_flags & USB_PD_CTRL_TBT_LEGACY_ADAPTER)
-		data.device_mode = TBT_SET_ADAPTER(TBT_ADAPTER_TBT3);
+		data.device_mode = TBT_SET_ADAPTER(TBT_ADAPTER_LEGACY);
 
 	/* Cable Discover Mode VDO */
 	data.cable_mode = TBT_MODE;
diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
index 55dcea12082c80defeb6f199ad333279b58adcd7..6bf208c9dd5037f162678bc0be5be7ae1ca0deca 100644
--- a/include/linux/usb/typec_tbt.h
+++ b/include/linux/usb/typec_tbt.h
@@ -27,8 +27,8 @@ struct typec_thunderbolt_data {
 /* TBT3 Device Discover Mode VDO bits */
 #define TBT_MODE			BIT(0)
 #define TBT_ADAPTER(_vdo_)		FIELD_GET(BIT(16), _vdo_)
-#define   TBT_ADAPTER_LEGACY		0
-#define   TBT_ADAPTER_TBT3		1
+#define   TBT_ADAPTER_TBT3		0
+#define   TBT_ADAPTER_LEGACY		1
 #define TBT_INTEL_SPECIFIC_B0		BIT(26)
 #define TBT_VENDOR_SPECIFIC_B0		BIT(30)
 #define TBT_VENDOR_SPECIFIC_B1		BIT(31)

---
base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
change-id: 20250926-topic-tbt_header_bit_fix-17aeb524df4a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


