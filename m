Return-Path: <linux-kernel+bounces-862581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081DBBF5ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C41188D49B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB2E302175;
	Tue, 21 Oct 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="EBgSp+SD"
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750C27B343;
	Tue, 21 Oct 2025 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040851; cv=none; b=oSOV2PFlZqDJWwzek6/0aNeKjTrTCdVcturbdlTOIv1NmiNQPSib8/eZQoJW6TIKlLsBL8i1H9pME9FhtcWmPQQDb7zHQQyHMVhMYiunq/sieKQ0Vqlqi9szb3nk3oIKy4TbB41NOoU7g8rBUgQgAOb1EatN0LjmKP03ZBRdWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040851; c=relaxed/simple;
	bh=BtLHn47NTynnC08D4Q2LcDFp/qF9Eoh5BJk8U0M6hGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J30a3ZJwxSQDkrpPIhzoe+HNuV/btRwevYdEhDH6+io2pgPOdLnasOU802ErAcQnEdANp7jHa9dJf2UzWhluBgGbtdqt8F6HuRDSoqW+9FpATllkdxcXF+21P0n9lNlF89/PxJ2MRmeCD5h83+5x3FyGfw1eWryJ71J0vZQX2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=EBgSp+SD; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tDz0f2R3tGpvLkGflsBmqNS32m6oAsYJKUrh43zMpXM=; b=EBgSp+SD0ksBsqcrSFEiokgrfx
	vfwMneoBjTw9qjnWWvhIoWxzKb6a54R56936EKe3v3m4Br2eOMS/hGX2J5vUDoTx0zWhYOabokSKI
	Yo8PWvchfkAjz+HxoyDLnVv8CvFEuDNUKPcrVfGcMJmgGSLvWQ5xBw6t8Ys7akcbgQD4jL1q8bG+o
	O1d8/lUfFpALOK3jQsmlGyoaHVE6kp0VULqPqzo9n4yj6l48xlMYbzEJ+SY7qVS23R+ZR356wdGl8
	QF84xPwMlZvC9mIiMu+vfZMUr/w89dQ6G1+HfwoKyjThs14TC8a3wRODN8wwQnqRclZJgWiK8AhtX
	pFCPQEqA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:33124 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1vB8nj-00000004LXL-3X5C;
	Tue, 21 Oct 2025 11:37:05 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add PHYTEC phyBOARD-Segin-i.MX91 board
Date: Tue, 21 Oct 2025 11:37:03 +0200
Message-Id: <20251021093704.690410-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add device-tree bindings for PHYTEC phyBOARD-Segin-i.MX91 board based on
the PHYTEC phyCORE-i.MX91 SoM (System-on-Module).

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 00cdf490b062..73987ba1d16a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1492,6 +1492,13 @@ properties:
           - const: tq,imx93-tqma9352        # TQ-Systems GmbH i.MX93 TQMa93xxCA/LA SOM
           - const: fsl,imx93
 
+      - description: PHYTEC phyCORE-i.MX91 SoM based boards
+        items:
+          - enum:
+              - phytec,imx91-phyboard-segin # phyBOARD-Segin with i.MX91
+          - const: phytec,imx91-phycore-som # phyCORE-i.MX91 SoM
+          - const: fsl,imx91
+
       - description: PHYTEC phyCORE-i.MX93 SoM based boards
         items:
           - enum:
-- 
2.34.1


