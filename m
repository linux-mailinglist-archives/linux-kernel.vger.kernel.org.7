Return-Path: <linux-kernel+bounces-745326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CBCB11878
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F46A17003F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83CA2882CD;
	Fri, 25 Jul 2025 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="X+/adXWb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KBTgTsAU"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E91E47AD;
	Fri, 25 Jul 2025 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424710; cv=none; b=UXxZtbnd23TlGtZGup/hu+3V0CXcuuYHGZ3MHBBCe4o+6ms6NdXiM1XSHZJ5qxIGsiYFS4nj8MQXfbXUbV+N2myZJygrUYVmp+xxqUo6iu1MHdBZni3hxyaVambOTJJV+M/ig3HZdUx/2L22xCbKx0JGyz9MrFqRUiRauAKxphI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424710; c=relaxed/simple;
	bh=Z8g+/3DNT01an5sTkSJ8I8j31e4KkHQQd1/NRR00ss8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EK9yyekP30xGgdzIzrTZNjk1jTMjM/mC2DFLeYB7MJapBZ4MC7PAI6uioy09A2rJuBTSkbSynFgf7zJEr0/Hj9AJOFEdvrWNSUiSZlz288umGsoy7iawmDI+SEjKZ5dbKsREUBQF9G5Fp4U8zUqIInlD4kZ9CTDS8iN8uQiZTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=X+/adXWb; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=KBTgTsAU reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424707; x=1784960707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HxGeV7xXFc6W+ct7dDtCqUAFCsNs4UQAyALJopA12VI=;
  b=X+/adXWbV85wOUfj5OBHqMRhn/QcnUNYIYirQVEs8CELJTtxVDPy2Evn
   G0tG+kbCaKsCWbvbEugr3SIrsnIqDoR8UzT6D7e8V2rHrxF6ESCK5o9P7
   LpV0UAdsM1jle0QAsq3oaAL5/dqvWKYQk1bx96tEv8YMlWt0/YoWOkbl1
   6cYltGwu6qA2SshKEb3VHr2nzW6Fe0dtvG6tAYyflIJKSIyFvgDQRIsl7
   vXj+vvxJo/jBFo5wyZ1djO+fc5kf6T7KX8RIYS7fT2ijXuugB0hm3DH8n
   UwK7WCrxA322ttC/3o4GBYj/wU87tsNvtrllhE678mhBpmUdkAJWtqr9h
   g==;
X-CSE-ConnectionGUID: tSmPr5WFRHCP/nj6HNiRsQ==
X-CSE-MsgGUID: lhp5tWKnTm60LG0pYPBxjg==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413371"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:25:04 +0200
X-CheckPoint: {68832340-2-4FC15ADB-CD71293B}
X-MAIL-CPID: 3FAB2EC1BECB98B599CA3BBB1032025C_0
X-Control-Analysis: str=0001.0A002102.68832340.005F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B6B517358C;
	Fri, 25 Jul 2025 08:24:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HxGeV7xXFc6W+ct7dDtCqUAFCsNs4UQAyALJopA12VI=;
	b=KBTgTsAUx2sSzETp81sZBYUzxzWBRIBR5IN/cknk9cvgsWSFG1BY4vQffATPggHfXFMPaM
	DeBdBN4ctIELnt2gdxZe1f7eEx+RZEZ7MD8pg5l1VgEo+V33Z42MrQhssq1KE3SJp4Il7u
	pqkImbzYseEzOAwN3OCHVgyvckshU/5RHMktzAgNmFFBYuDcdMcHuyDifFwRJuiYipOeyl
	fDEIfeGhy7Jj3nvh+av/9eona1/umPQDfsatVVafvTE1Cu4izoZ45Ady52g8a3oEb4MA4u
	ZLD3OW2BAZTiGY0AgC1WT2A5Gcg9RQIot0S05ePbtfJA9emxUvGeFIrq/JqwlA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Matthias Schiffer <matthias.schiffer@tq-group.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: add TQMLS1012AL
Date: Fri, 25 Jul 2025 08:24:50 +0200
Message-ID: <20250725062454.271191-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Matthias Schiffer <matthias.schiffer@tq-group.com>

TQMLS1012AL is a SOM using NXP LS1012A CPU. MBLS1012AL is a carrier
reference design.

[1] https://www.tq-group.com/en/products/tq-embedded/qoriq-layerscape/tqmls1012al

Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Fixed commit message subject

Changes in v3:
* None

Changes in v2:
* Collected Conor's A-b

 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f494ada0c1966..0beb0040a7d34 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1571,6 +1571,12 @@ properties:
               - fsl,ls1012a-qds
           - const: fsl,ls1012a
 
+      - description: TQ Systems TQMLS12AL SoM on MBLS1012AL board
+        items:
+          - const: tq,ls1012a-tqmls1012al-mbls1012al
+          - const: tq,ls1012a-tqmls1012al
+          - const: fsl,ls1012a
+
       - description: LS1021A based Boards
         items:
           - enum:
-- 
2.43.0


