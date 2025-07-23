Return-Path: <linux-kernel+bounces-742142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E008B0EDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918E9542004
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1139B28466A;
	Wed, 23 Jul 2025 08:58:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF121283FCD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261118; cv=none; b=pNHMWfNwTAeURw+dWbPtvwmKnIDKfUa2cdDU2SSjMWmZRWa+6vm8ZWJQHUSHtvPSsCwbQNhWz29VCUuipEabPuWnsq+RSwCDzHEoAtNUws/puCL7a9lwD6zbUX0vu5dMFUdlJIfbkEgJhxpRD9C3lddwRSDMpVIEHUw2wKHZLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261118; c=relaxed/simple;
	bh=NcWEOTDXj6f4kIBljalpFYQyrelfrCFtuzcgHNWiYlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jAaEfLO7PT8kwAxip4A0R4us6+JlyYMCbuj2UREB4IE+Me8/v2dMz52wuGbLMUmy4lZ/4Z8N3JM/VB2RGYzRaTGLoKieFe/Ji7DbVyHI5Vf2hHEmxDI9/Rex+ETfsPxsLZcp0luoEKELOlEZb0cA1s641w21N8DXh+ckUiAPcWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1ueVJ0-0004xI-II; Wed, 23 Jul 2025 10:58:30 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Date: Wed, 23 Jul 2025 10:58:29 +0200
Subject: [PATCH 1/2] media: dt-bindings: add flip properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-fpf-media-dt-flip-v1-1-75b3a938b4be@pengutronix.de>
References: <20250718-fpf-media-dt-flip-v1-0-75b3a938b4be@pengutronix.de>
In-Reply-To: <20250718-fpf-media-dt-flip-v1-0-75b3a938b4be@pengutronix.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jacopo Mondi <jacopo@jmondi.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, entwicklung@pengutronix.de, 
 Fabian Pfitzner <f.pfitzner@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

There are cameras containing a mirror on their optical path e. g. when
mounted upside down.

Introduce two options to change the device's flip property via device tree.

As there is already support for the panel-common driver [1], add it for cameras as well.

[1] commit 3c0ecd83eee9 ("dt-bindings: display: panel: Move flip properties to panel-common")

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---
 .../devicetree/bindings/media/video-interface-devices.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/video-interface-devices.yaml b/Documentation/devicetree/bindings/media/video-interface-devices.yaml
index cf7712ad297c0..36d766992b271 100644
--- a/Documentation/devicetree/bindings/media/video-interface-devices.yaml
+++ b/Documentation/devicetree/bindings/media/video-interface-devices.yaml
@@ -383,6 +383,14 @@ properties:
                         |                    |
                         +--------------------+
 
+  flip-horizontal:
+    description: boolean to flip image horizontally
+    type: boolean
+
+  flip-vertical:
+    description: boolean to flip image vertically
+    type: boolean
+
   orientation:
     description:
       The orientation of a device (typically an image sensor or a flash LED)

-- 
2.39.5


