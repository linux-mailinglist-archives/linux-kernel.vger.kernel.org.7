Return-Path: <linux-kernel+bounces-758667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D31EB1D254
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C00218A0C40
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FABB21CC55;
	Thu,  7 Aug 2025 06:09:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48D2147E5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754546989; cv=none; b=diU+rWUWTCTZbxV8JDPCjuzOOo0VkUCkJ07R6y0f6mQ8WeVzjIClt0x1LknZsWmMp3a56sFcRBh2e2BHlJyegbAqaK/RwUjbg4ZdwGMtKuOpvvH0wcDlJ+RiBEvwgGccoaL0NEhkF63yGlQB47eL/NoquZdQnnHWN1iOU9/GDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754546989; c=relaxed/simple;
	bh=iej0cdjc27k6Bz33u+4F6cGRHPmWzI4nQIndAd+/u4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0uQI7Ssh6ibPTbGVDP9sQED4bEr+AJmQIUS/ECfsXvwS6w7/1tFdRhdAjDfwHr3OOfrugu5cL8feCz3COMtf6qEhCqPX34K4rTg9ycgt2kayxOaFSjuWBJgFO6OaCzFjfpsyRHlBlRL14E8Hom0wrDNgH6uAoyn+WYUYPN4dtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ujtov-0001Wq-VY
	for linux-kernel@vger.kernel.org; Thu, 07 Aug 2025 08:09:45 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ujtov-00CKXw-1E
	for linux-kernel@vger.kernel.org;
	Thu, 07 Aug 2025 08:09:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 17908452516
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:09:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D72C74524EF;
	Thu, 07 Aug 2025 06:09:41 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0258dc56;
	Thu, 7 Aug 2025 06:09:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 07 Aug 2025 08:09:30 +0200
Subject: [PATCH v2 1/2] dt-binding: can: m_can: add optional resets
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-stm32mp15-m_can-add-reset-v2-1-f69ebbfced1f@pengutronix.de>
References: <20250807-stm32mp15-m_can-add-reset-v2-0-f69ebbfced1f@pengutronix.de>
In-Reply-To: <20250807-stm32mp15-m_can-add-reset-v2-0-f69ebbfced1f@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=767; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=iej0cdjc27k6Bz33u+4F6cGRHPmWzI4nQIndAd+/u4o=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBolEMeg2lxWTBq3MMvHt25j9u6XXC9I/VkjDdGX
 k/6brPbb9eJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaJRDHgAKCRAMdGXf+ZCR
 nDcfB/46rZcF18AjrXct7AOwzpzUrbFpJPu1JY0dGrhO/g5HBMLJSzpesMYyGxb563gu1Zmh1mR
 xx4xFP3yX7WGilhlxg6wBNSLjoTcMZPy9Tkjuzp55DukC9ZzGJ9DZupfM5ShEykfDIX5VhkkHsM
 mkxUjouLtJt7nt7+M5B9ce0TVLayuf+7BA+cfz4rF9gSdosCXLp5iAwSzxvuvS298zbX2SNxVOX
 M/sqxqPmllLpRIRXKHLiDsvzlEoOSX9dTon8FZZU7PMdz/k7heI8SAOfNBvKg2zJpphKQjSUNLj
 EUwxPLtVM1zI3NvftYu2DsX3zRjSFdknETy1ahWklUxW2Ie6
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The m_can IP core has an external reset line. Add it to the bindings
documentation.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index c4887522e8fe..61ef60d8f1c7 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -50,6 +50,9 @@ properties:
       - const: hclk
       - const: cclk
 
+  resets:
+    maxItems: 1
+
   bosch,mram-cfg:
     description: |
       Message RAM configuration data.

-- 
2.47.2



