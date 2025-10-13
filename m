Return-Path: <linux-kernel+bounces-850991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F61BD4E19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3210C189AC06
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360F030DEC4;
	Mon, 13 Oct 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psItepZl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A24330CD9C;
	Mon, 13 Oct 2025 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371438; cv=none; b=bBbrPx1Ca8bl7PFgeQjI5QrXX4xbf2Knas7pO6YH4R5IT4UeOCIc1I9uG/ghShtmWMT3+Epk4rvDMvDX5BsS3kDw/tToYq1zsoMotS41YtwAhb3Ui/AE14MlQj1EW/j4L8lNotlgO7zbSaoi6FHIpHs+UwkO0fvOF9w8vn8v7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371438; c=relaxed/simple;
	bh=b88sn5mMVCk/oe5CLT9hyAX+U6n1DTFMv6pGutiyXM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2WN2zc2UetgMbtffUdqEJlhtRrI25++eirKN1ni5EohJGZsIz3GWbiRSfKXdOaMdDwu1x2Mpduf9fOkDHMVOuL0DyqCHjwugoQh/FD/5cYnHkDYcuMb5PwQjlBy4qJS8H4oTEb1v3RleDVezU5s1O3GgiT/ldUoKlR3Z+Z2ack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psItepZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1584BC116C6;
	Mon, 13 Oct 2025 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760371438;
	bh=b88sn5mMVCk/oe5CLT9hyAX+U6n1DTFMv6pGutiyXM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=psItepZlr5BidPnhnrXeKzfcN+bhsV8zT7H/KZogbgEXuuPLi0JHfn5v+/FJkOFtp
	 UNhZM36g7Kcou49QDr6dv38inMPlAIz7SZWGKbvStunUBf4Q6lM09rNUYyy39wQP5R
	 wZV9eXOWLQjSEI4ujbumA9+KXK89nQ7JGYFZqoZqEQVDFIeWzCq9cLOUH6wrBOFiNA
	 O2JnKt2xUOdWXGwJcZ4qgPMW3cJHywdKBZaank+2mnIqLITsgyq0f+6Q9cKDcIeIep
	 rxncTFTbHKrN0TH8fXWG/NQUa0LAanJjIaCsxgriO2CBfoSDsQ2um5nDoWvkQCk1EU
	 wDg/zPtfMCsqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07735CCD183;
	Mon, 13 Oct 2025 16:03:58 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Mon, 13 Oct 2025 16:03:27 +0000
Subject: [PATCH 3/5] usb: dwc3: glue: Add documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-b4-aplpe-dwc3-v1-3-12a78000c014@kernel.org>
References: <20251013-b4-aplpe-dwc3-v1-0-12a78000c014@kernel.org>
In-Reply-To: <20251013-b4-aplpe-dwc3-v1-0-12a78000c014@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2106; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=b88sn5mMVCk/oe5CLT9hyAX+U6n1DTFMv6pGutiyXM0=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Zbpeez9SvfLDxyJURQn3vStN9Rsh5lJ2ZkP9//cuWvO
 YEbd25g7ShlYRDjYJAVU2TZvt/e9MnDN4JLN116DzOHlQlkCAMXpwBM5HUrw/+EnzNf9P47v+js
 /+//tFbfE5wZdqUi5ojfU+XvpeYO13oiGRme73yzLqXW7vGi1OxAvaxkhYrCEDNxnhXXPDIOKUj
 2B/IDAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

We're about to add more exported functions to be used inside glue
driver which will need more detailed documentation explaining how
they must be used. Let's also add documentation for the functions
already available.

Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/dwc3/glue.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/usb/dwc3/glue.h b/drivers/usb/dwc3/glue.h
index 2efd00e763be4fc51911f32d43054059e61fb43a..7f326cff12458901904d4c32f62ed9357d0f6e3b 100644
--- a/drivers/usb/dwc3/glue.h
+++ b/drivers/usb/dwc3/glue.h
@@ -22,9 +22,36 @@ struct dwc3_probe_data {
 	bool ignore_clocks_and_resets;
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



