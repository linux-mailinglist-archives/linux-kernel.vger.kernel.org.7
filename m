Return-Path: <linux-kernel+bounces-804345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 129C3B4729A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE411C21530
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567A9302CBF;
	Sat,  6 Sep 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nd5VJLex"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34232F49E6;
	Sat,  6 Sep 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173420; cv=none; b=eAI4VmnwHzdGJxfOz/T6LC6R120KmqMcZ67Vc+MLAp7uLLOelDK3dNC5bfjeoVpQhWJdssDF+mtw4gx+bF0Z6CEBJ+zCsShh2T18d7UpoRpk21LVTnKWCL8w773XGFtyzVaOyff7ejumUHLuHMoZuTo3fpQQoVABzpO3b/VhXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173420; c=relaxed/simple;
	bh=BntybK4ghItAd51ZFEoy/6BXMrI0MX3OXUGh7tlF2wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJF+4p22PGAzeifYUWbK1sGCYZMtwuDElbkB7r8B+NAnt/c+8GpeRKpr+lhA/WedpzF6dbYvv48K9A1jeZ8+dfMha9/eELnlpJxe/vwFZh9JsVDuK6RFEUbSeqa0MXIFRcb0ipggfBylWtIFrrNTzVnRofc/gcFnPADTrEPFvIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nd5VJLex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D3D1C4CEF7;
	Sat,  6 Sep 2025 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173420;
	bh=BntybK4ghItAd51ZFEoy/6BXMrI0MX3OXUGh7tlF2wQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nd5VJLexn/JNO4rQ46wZHaAA2rdXQy4WRFRU83/JHb0FCIdv3m6jJ2NDxaNRost4E
	 PCEEJqy3ZF9tH3znRQjppDMlltPH4XpTjHnzRoMmD6yeJnfzjFSfNakibLeKbXR+ag
	 LndOYU1l2otaKyHEyN1GNBPT02XugtH8rLJgMWfE7caUVvRiT6Wezl8EaLjuccZVgu
	 HWrZhQDbYB3RHOH+7aDKYl6/GGo7pfMICv7A+yF3sEdUAqxwUKJLQhB3HoAg7Gr3hn
	 ltb2kUnEZr4jTpoNieECWl2dT6gxhfA6a2xmOG/tm7/FbL6pofBGiDLZIdNXhBMa8Y
	 WQDGGNao7uQhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C2ECAC581;
	Sat,  6 Sep 2025 15:43:40 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 06 Sep 2025 15:43:32 +0000
Subject: [PATCH v2 19/22] arm64: dts: apple: t8103: Mark ATC USB AON
 domains as always-on
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-atcphy-6-17-v2-19-52c348623ef6@kernel.org>
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
 Sven Peter <sven@kernel.org>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=KlPzmlrett6VZZaPvH7/eARfg+MitLPN79oIzdJZz0w=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8aesKVv25TfrFpgvlCt8mzcumJ9y0ztH/ZTDEKmtq9d+
 JrN7fHhjlIWBjEOBlkxRZbt++1Nnzx8I7h006X3MHNYmUCGMHBxCsBEijYzMlzqWq1rX7rFWLbo
 CqNLej/H3vy0+wfTkpMYojP4V6drTGX471lmNdN+57zemxNlS/z67s02e/uXacWdf5lZh0u388t
 V8QIA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: Hector Martin <marcan@marcan.st>

Shutting these down breaks dwc3 init done by the firmware. We probably
never want to do this anyway. The initialisation done in the ATC phy
driver is not sufficient to bring dwc3 back up after these power-domains
were shutdown for example after suspend to idle.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
index c41c57d63997a59a9fe3c88de31fddb31781398e..4bfe0d2de30ad6f975b31d443b62ef0e74b14324 100644
--- a/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
@@ -1103,6 +1103,7 @@ ps_atc0_usb_aon: power-controller@88 {
 		#power-domain-cells = <0>;
 		#reset-cells = <0>;
 		label = "atc0_usb_aon";
+		apple,always-on; /* Needs to stay on for dwc3 to work */
 	};
 
 	ps_atc1_usb_aon: power-controller@90 {
@@ -1111,6 +1112,7 @@ ps_atc1_usb_aon: power-controller@90 {
 		#power-domain-cells = <0>;
 		#reset-cells = <0>;
 		label = "atc1_usb_aon";
+		apple,always-on; /* Needs to stay on for dwc3 to work */
 	};
 
 	ps_atc0_usb: power-controller@98 {

-- 
2.34.1



