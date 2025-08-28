Return-Path: <linux-kernel+bounces-789657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCFCB398BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3261C829E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CDD2E03EC;
	Thu, 28 Aug 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ll2yFRkc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XR8J/JzF"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491B26F46F;
	Thu, 28 Aug 2025 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374483; cv=none; b=NN/a0bBYg407fgnnG6azCaMbIgQhkqoILZ6IyVcPrxYELebj3T2wNGSeYIwpetKC3rWjp17cwfDS4U81/6i597Z+C91xsxB/188GZiHhunVkHcPR/T8Ijcf/4M5dLM38goDjPXB91VAUOINggQtZvpK6hsOgJcf0016kYVRof0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374483; c=relaxed/simple;
	bh=m3MMu0hhanBtX1e6y768SAytNhJDMFCxOd6xiN3X6/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvFLpUBWvfCP9u6ILuz9xQ/7uDPUNEpGkN29Bgs2STXgnRew6JFhSKEerLmm2APZ0Sq4jXLEc3HwVQlehhPfUnsaM23HAKagmyIqHu7BrHUcdvStVdCDuaZ7q9FZv8k4ZLpX/MPl95WsiImVYFeKIsktJQj+3LvZqrvOAHqOzTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ll2yFRkc; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XR8J/JzF reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756374481; x=1787910481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D8nQkRvpmKKt09UiqtWevDsmYEzF6a0SS4RoNlY4WkA=;
  b=ll2yFRkcZp7Qj4Pbgx+35xVL0Pq10+GQj9ysn3KmDYfJEdPXNSVKLplc
   qhGoTqzB9wk4NUdMzkTpceRtOB2ebp1dKzjbUbb84ab4nMYaq4UodsHZr
   ybe8eiR1l/KfkLkkhdORMb2sGdYY7CYL15odO5L7MKgJ5MMIceouQkoH4
   oqi5FQREv6UNHcIkvf5+wFvQt22liXZNeF21FxSp0X63UvjJ6OiYme57O
   oFZqMKUjngkPFIqL/xIvJYQ3+NuVyfOh/9GOJiK87dzhL/hUBK+GM8Or3
   /OAAtV228xf3VsCCLRqOv6Ld6UuiK0bb55FSoB5oZcvzmm2avJI7If9SL
   A==;
X-CSE-ConnectionGUID: IVm/NR15SRWLvhrdJFb3YQ==
X-CSE-MsgGUID: ESBlCGXxQ8arFe4RadziYQ==
X-IronPort-AV: E=Sophos;i="6.18,217,1751234400"; 
   d="scan'208";a="45953047"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 Aug 2025 11:47:58 +0200
X-CheckPoint: {68B025CE-17-299FBAB0-EF52EDE7}
X-MAIL-CPID: FB74D8873684AD535BEE68EAC473F561_5
X-Control-Analysis: str=0001.0A002105.68B025CF.0078,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8949C16947D;
	Thu, 28 Aug 2025 11:47:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756374474; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=D8nQkRvpmKKt09UiqtWevDsmYEzF6a0SS4RoNlY4WkA=;
	b=XR8J/JzFiqHhgaXBwzwPipx5NU14j83641gTXAIBTF8tzDAIK1TSFyiRx/bDc/CMPH7Efo
	i5pjIjfItVqw5El3oZQ9qWNXCTJqzJ7kJTPDQNDxaSz/ENmeEqSnfQIzSIflczG9O8vzUH
	QhD3YakaKt3RKfOv6kg/Ps1jRVfkeylOErtpABdSlSTqSpk/atyDQIEcv0DM0rmORjB/XJ
	pqbXcnmt40qzZy7whNZ4VRAc5OQErxBrOfAX/OJsJO8hEkwkJGWrg5VomRKmmW42lwrT2K
	+CkixEhLMb5GiLAoMb/fRvJ8fR9amC0bLmDrG3mXOBaBxd2LklyMd57oYO3VwQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com
Subject: [PATCH 1/2] dt-bindings: arm: fsl: add TQMa91xxLA SOM
Date: Thu, 28 Aug 2025 11:47:42 +0200
Message-ID: <20250828094745.3733533-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828094745.3733533-1-alexander.stein@ew.tq-group.com>
References: <20250828094745.3733533-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

TQMa91xxLA is a SOM variant in the TQ-Systems GmbH TQMa91xx series using
NXP i.MX91 CPU on an LGA type board.
MBa91xxCA is a starterkit base board for TQMa91xxLA on an adapter board.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ebafa6ecbcb64..0843c5e9275be 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1433,6 +1433,24 @@ properties:
               - fsl,imxrt1170-evk         # i.MXRT1170 EVK Board
           - const: fsl,imxrt1170
 
+      - description:
+          TQMa91xxLA and TQMa91xxCA are two series of feature compatible SOM
+          using NXP i.MX91 SOC in 11x11 mm package.
+          TQMa91xxLA is designed to be soldered on different carrier boards.
+          TQMa91xxCA is a compatible variant using board to board connectors.
+          All SOM and CPU variants use the same device tree hence only one
+          compatible is needed. Bootloader disables all features not present
+          in the assembled SOC.
+          MBa91xxCA mainboard can be used as starterkit for the SOM
+          soldered on an adapter board or for the connector variant
+          MBa91xxLA mainboard is a single board computer using the solderable
+          SOM variant
+        items:
+          - enum:
+              - tq,imx91-tqma9131-mba91xxca # TQ-Systems GmbH i.MX91 TQMa91xxCA/LA SOM on MBa91xxCA
+          - const: tq,imx91-tqma9131        # TQ-Systems GmbH i.MX91 TQMa91xxCA/LA SOM
+          - const: fsl,imx91
+
       - description:
           TQMa93xxLA and TQMa93xxCA are two series of feature compatible SOM
           using NXP i.MX93 SOC in 11x11 mm package.
-- 
2.43.0


