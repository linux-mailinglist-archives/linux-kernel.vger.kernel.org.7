Return-Path: <linux-kernel+bounces-758666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF7B1D253
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BBF624647
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435EF21C9E5;
	Thu,  7 Aug 2025 06:09:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BD8214228
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754546988; cv=none; b=uXkvrSiH3ShvsH3KNRgHCrpWNW269fKrFPBQ/YacmgHCmXnxikR4F99JFGUluK9bwg/dhcdnLUSADFSz6jhxueRS6l2Ja2UZuquY78lJAakuHQXJ41FP5PrAqG0KMXtlZT8rfdj3tHij//BYKJNbl+1nChkNT9JzyrFbUEQZmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754546988; c=relaxed/simple;
	bh=dBTy/8+JrxokQ4xSHmojU5rylaxcvQQGcenu7LFj3ss=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K/T/SiHoC+J6QK15Y5cXTdR4oxsPH+ym8jBk4ZD9Y0eFrG84kptt8APO2DNNMsNZKLK9eb5LXrM5q5XxJqb8CrXBhsDo5qjeRORJS4tr6KAN5vTpY6tI/JI5SlJ8S4b2bXoBYVL22ijLfbWxoGrwde+rQahFzUK+aGOhhIwTNMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ujtov-0001Wd-Nc
	for linux-kernel@vger.kernel.org; Thu, 07 Aug 2025 08:09:45 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ujtov-00CKXr-0z
	for linux-kernel@vger.kernel.org;
	Thu, 07 Aug 2025 08:09:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id F34BF452515
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:09:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B6DFC4524EE;
	Thu, 07 Aug 2025 06:09:41 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b287dab0;
	Thu, 7 Aug 2025 06:09:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 0/2] can: m_can: document and add external reset
Date: Thu, 07 Aug 2025 08:09:29 +0200
Message-Id: <20250807-stm32mp15-m_can-add-reset-v2-0-f69ebbfced1f@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABlDlGgC/42NQQ6CMBBFr0Jm7RhaLIIr72GIqe0UZkEhbSUYw
 t2tnMDle8l/f4NIgSnCrdgg0MKRJ59Bngowg/Y9IdvMIEupyqasMaaxkuMsFI5Poz1qazFQpIT
 GOHO5SlG9dAV5PwdyvB7tR5d54Jim8DmuFvGz/1QXgQJb2wjXGtnaWt1n8v07hcnzerYE3b7vX
 52D6/3HAAAA
X-Change-ID: 20250806-stm32mp15-m_can-add-reset-ccfc47213ba3
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=dBTy/8+JrxokQ4xSHmojU5rylaxcvQQGcenu7LFj3ss=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBolEMbBIwx6KTVCmP4+ZFkh+ZEXOfVGQsPsSk9e
 1NTWpn+9HWJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaJRDGwAKCRAMdGXf+ZCR
 nAzLB/4xr+zbeYmKkhfYMQD6E2ANXZMEPkDKdmNqom6qvgZYi0qOEmKhoZZR5W37ozkQnS0ZmLn
 iKTOvy8wBaYFn+Dy7pgSAuO5BX5U/98rf65NjFFrb8WxXKJJxPND+qPZqDlp2+RD3zI06RVvIw8
 z5I8XcF/CGyzGCz6GVnYXcWof5cUQAn//BqJ5zPUHR73TYoLHjLCPMHDeVw6Pqfy7/7dbVcna/i
 7JoC3puZ1dvpou6HkEyzDm4dudhdhi/yAc0oypJVZrw7YnibPZxLuVfOP+tgKRtiEO5KgAv/NZV
 oXc2y239HSTb8zQPSj5+alBkj5y2UFZWmX/Zwtsk6EDGz2tX
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The m_can IP core has an external reset line. Update the DT bindings
documentation accordingly and add it to the stm32mp153 device tree.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- add dt-bindings update as 1st patch
- move stm32mp153.dtsi update to 2nd patch
- Link to v1: https://patch.msgid.link/20250806-stm32mp15-m_can-add-reset-v1-1-9d81f9c29d65@pengutronix.de

---
Marc Kleine-Budde (2):
      dt-binding: can: m_can: add optional resets property
      ARM: dts: stm32: add resets property to m_can nodes in the stm32mp153

 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 3 +++
 arch/arm/boot/dts/st/stm32mp153.dtsi                       | 2 ++
 2 files changed, 5 insertions(+)
---
base-commit: 1a32f7427eb3d1248bc64cd745b93f88cc838933
change-id: 20250806-stm32mp15-m_can-add-reset-ccfc47213ba3

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>



