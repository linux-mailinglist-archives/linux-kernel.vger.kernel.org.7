Return-Path: <linux-kernel+bounces-870699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60CFC0B7BD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E1219A034A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D525E30170B;
	Sun, 26 Oct 2025 23:47:14 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC0D257AD1;
	Sun, 26 Oct 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761522434; cv=none; b=Iy/GFMXbpPgibTXOcFXDS52UHaplMtyiM1nlq7uXbNdYp5wtLfwI4mOehGIDO8TphqJ3WesJ5TJMPwKPGtBpWJAeFgjjYWOpOTUlEOte03+wSV+HzurYigDlDzni7z5BT8qWGuq4m9WQXNvlr1dM0SUnpl0BnctP5drmtniryro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761522434; c=relaxed/simple;
	bh=vFyWC1GVePSvWEzCQKJKXZXnLEb/xh0KyV380q64ZBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX9RgaeUJ5ZlFgECNdkebTM9AYB6KmtRNlvFLL8MVX954SqgRvPYabPPmjm0j0XkEi8BOPooZjX82DI30hO6HV2muHcqJCBzt17Od23IRHa/Jd1rNgs5bU6rlgQTAPNs38T9vV1mxTu9tRB8E1uTfhmyEIJk5vdAAOizh/aMN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDAS4-000000007fL-2gT7;
	Sun, 26 Oct 2025 23:47:08 +0000
Date: Sun, 26 Oct 2025 23:47:05 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v3 08/12] dt-bindings: net: dsa: lantiq,gswip: add
 MaxLinear RMII refclk output property
Message-ID: <3900266acab61197fd27359439eb8d4cf25b2c0e.1761521845.git.daniel@makrotopia.org>
References: <cover.1761521845.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761521845.git.daniel@makrotopia.org>

Add support for the maxlinear,rmii-refclk-out boolean property on port
nodes to configure the RMII reference clock to be an output rather than
an input.

This property is only applicable for ports using RMII and allows the
switch to provide the reference clock for RMII-connected PHYs instead
of requiring an external clock source.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index b0227b80716c..dd3858bad8ca 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -29,6 +29,11 @@ patternProperties:
             description:
               RGMII RX Clock Delay defined in pico seconds.
               The delay lines adjust the MII clock vs. data timing.
+          maxlinear,rmii-refclk-out:
+            type: boolean
+            description:
+              Configure the RMII reference clock to be a clock output
+              rather than an input. Only applicable for RMII mode.
 
 maintainers:
   - Hauke Mehrtens <hauke@hauke-m.de>
-- 
2.51.1

