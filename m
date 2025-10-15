Return-Path: <linux-kernel+bounces-854806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4AABDF735
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F5A19C820E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E385C32ED3C;
	Wed, 15 Oct 2025 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJKinHNk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AAD326D77;
	Wed, 15 Oct 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542870; cv=none; b=iLWTdO69DB40dI4ZBiCyHiaJrC0itmu7u9iouI86DA+Xs19BnO/ySRRoIAkuTPSMGCoAPDoPPusyffy013vw2+KNsU4xOoiBjhq5xSrfPbc4JaJJlwRtkxUSaKBrDLoCWXURiUnc6UxRkiQCq2BRoU4tevGXzo6LM/BCO+IDeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542870; c=relaxed/simple;
	bh=DMGFEJn/13K8pCwgFfOu2qPEs9uFdthFJZx/jrrxzCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ccUcioJfNn1UBScyk7Ah1jKGRpxTDA0XKH1kI2AW/YmyUwQM4r4jB+RLBrmjeiOB9Jr35PcPKzg0vNd5bnps7KmXT+/aUT68OtoxV3XsDfj98pSjyWWCqcMC/wzvSNQveJB3bar6+wo8X8Yb/It7cyYc8NKJO7go6J8XsGtG6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJKinHNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BC6FC16AAE;
	Wed, 15 Oct 2025 15:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760542869;
	bh=DMGFEJn/13K8pCwgFfOu2qPEs9uFdthFJZx/jrrxzCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UJKinHNkHuv/YhT9h/SGrKXTNHeypMG7qbLqNxoX0fSrT7IuLhQTp0nXMAEaUpRDH
	 NKfhqiRX/PQmMR9iGrO7DII6VsPDc1nrmZbNxVi2mLgS2WUbHa5W2WVvpKsp4RWEf4
	 X0J5PLWZKhoz0wO6/L3DsNqg+QJX0PxIZmTurWRpRn/AJ3JE6r0oV7jn7E8QJWqUMi
	 ZCHJvZC3domSXaVe8SFs6cIoNF5Uzu6vE7eo9p2guRXeOzWtJFxThLjL73Wh549D6+
	 Ea0Llu0HQGY30AC8Xp87Od31o2YcuF4jF59pcqjJbbiUgCZfcHTo3m6PigI9ealc8t
	 V7q/t+apbVjzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AE4CCD19D;
	Wed, 15 Oct 2025 15:41:09 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Wed, 15 Oct 2025 15:40:43 +0000
Subject: [PATCH usb-next v2 3/5] usb: dwc3: glue: Add documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-b4-aplpe-dwc3-v2-3-cbd65a2d511a@kernel.org>
References: <20251015-b4-aplpe-dwc3-v2-0-cbd65a2d511a@kernel.org>
In-Reply-To: <20251015-b4-aplpe-dwc3-v2-0-cbd65a2d511a@kernel.org>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2162; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=DMGFEJn/13K8pCwgFfOu2qPEs9uFdthFJZx/jrrxzCc=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8b7AxN27CuRbuBSvboh5cUa/m7xUK/kymuzX22YsPO2S
 PY8rfS3HaUsDGIcDLJiiizb99ubPnn4RnDppkvvYeawMoEMYeDiFICJ7PJkZJh7crHvoRfbJvLK
 Ts7JCK01Spd4G1ipwDij7rP/HlbBsAhGhjlvXxvVZnCWHE7kCr7OohSv/1JYjSntzOnLVwL2GHg
 ycwEA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

We're about to add more exported functions to be used inside glue
driver which will need more detailed documentation explaining how
they must be used. Let's also add documentation for the functions
already available.

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/dwc3/glue.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/usb/dwc3/glue.h b/drivers/usb/dwc3/glue.h
index cc6e138bd9ef2500215aba665300e7638f3d5214..bef4d9d68558f130f36a9088d7bb3b1220e4c048 100644
--- a/drivers/usb/dwc3/glue.h
+++ b/drivers/usb/dwc3/glue.h
@@ -36,9 +36,36 @@ struct dwc3_probe_data {
 	struct dwc3_properties properties;
 };
 
+/**
+ * dwc3_core_probe - Initialize the core dwc3 driver
+ * @data: Initialization and configuration parameters for the controller
+ *
+ * Initializes the DesignWare USB3 core driver by setting up resources,
+ * registering interrupts, performing hardware setup, and preparing
+ * the controller for operation in the appropriate mode (host, gadget,
+ * or OTG). This is the main initialization function called by glue
+ * layer drivers to set up the core controller.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
 int dwc3_core_probe(const struct dwc3_probe_data *data);
+
+/**
+ * dwc3_core_remove - Deinitialize and remove the core dwc3 driver
+ * @dwc: Pointer to DWC3 controller context
+ *
+ * Cleans up resources and disables the dwc3 core driver. This should be called
+ * during driver removal or when the glue layer needs to shut down the
+ * controller completely.
+ */
 void dwc3_core_remove(struct dwc3 *dwc);
 
+/*
+ * The following callbacks are provided for glue drivers to call from their
+ * own pm callbacks provided in struct dev_pm_ops. Glue drivers can perform
+ * platform-specific work before or after calling these functions and delegate
+ * the core suspend/resume operations to the core driver.
+ */
 int dwc3_runtime_suspend(struct dwc3 *dwc);
 int dwc3_runtime_resume(struct dwc3 *dwc);
 int dwc3_runtime_idle(struct dwc3 *dwc);

-- 
2.34.1



