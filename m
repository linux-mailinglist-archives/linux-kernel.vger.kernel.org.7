Return-Path: <linux-kernel+bounces-890594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E56C406D4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DE03BC7FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24032B98D;
	Fri,  7 Nov 2025 14:50:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7BB329C68
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527003; cv=none; b=sExCS1WOSWxsDEi6K2hvRgXECxI8AmXCdHJhEIEczrwGR/2i1FD/ovSACinHz8D7Q0r97NVcDVhCz5H3sCiQW5QkVCzx67hHlcZU5o6zVjJpctBMEfgniSfPBhwJ3ZTCS5ahkjJd5eAT51OTET1IuzYRjw6jYQNOp47gtNLWDpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527003; c=relaxed/simple;
	bh=vzKm2p4MviI4lDoGMFe4Ed+dY1YvFZ53T4yAgfC8NlY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jZB2en8f0U3Ze9dehwhRZt6PXliSkEX2AmUB594AQZ7IBFTiYYx2AfxageW4tlAWRiLMpcemyBV3MW8FAgSipQKNYPn3OO8eIdlVeymcnlepuDnu0E5hYxnAm4AynOrRMTk+FPmJpF+JqHISYjbUDyYYVgdSyM+zxhITku7sOZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1vHNmh-0001Tb-GO; Fri, 07 Nov 2025 15:49:51 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH 0/2] Add support for Skov Rev.C HDMI variant
Date: Fri, 07 Nov 2025 15:49:50 +0100
Message-Id: <20251107-v6-18-skov-revc-hdmi-v1-0-595549e5b496@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA4HDmkC/x2MSQqAMAwAvyI5G2iKG35FPHSJGsSFFoog/bvF4
 8DMvBA5CEcYqxcCJ4lynQWorsBt5lwZxRcGrXRLpHpMHdKAcb8SFt/h5g9B4sE31hqnOwMlvQM
 v8vzbac75A2dpewdmAAAA
X-Change-ID: 20251107-v6-18-skov-revc-hdmi-1e8d4bbac26a
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

this small patchset adds the support for the Rev.C HDMI board variant.

Regards,
  Marco

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Marco Felsch (2):
      dt-bindings: arm: fsl: add Skov Rev.C HDMI support
      arm64: dts: imx8mp-skov: add Rev.C HDMI support

 Documentation/devicetree/bindings/arm/fsl.yaml          | 1 +
 arch/arm64/boot/dts/freescale/Makefile                  | 1 +
 arch/arm64/boot/dts/freescale/imx8mp-skov-revc-hdmi.dts | 8 ++++++++
 3 files changed, 10 insertions(+)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251107-v6-18-skov-revc-hdmi-1e8d4bbac26a

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>


