Return-Path: <linux-kernel+bounces-861006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB3BF18F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4467934CD84
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3FA31197C;
	Mon, 20 Oct 2025 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AgwBdY60"
Received: from mx-relay125-hz1.antispameurope.com (mx-relay125-hz1.antispameurope.com [94.100.132.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF141C3306
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.191
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967427; cv=pass; b=cm+cODd7ybIg7VEDosxlLOD3IBuiHR5rRT5rSRVD/c8esiMhncDWYW3s+i+aCESE00P+/C5+BgP3N6eRZPdsKNDCuRIXFP4Pww1k1B+f7FrEUHH0HaMT0X0FvxxiHtDhSq+vTuvJvvwIE7QusClIZl8JRWOpC2hhhyHVi/xmjDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967427; c=relaxed/simple;
	bh=Ju0/wiKUvWYjWHdcAYDMANkjK3Cm/u3Wfd6p2jPfLqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iyWfYparz0TTpSXpAlEFYfXxAq5QWayGyNblbl/AUcfsuwCMdArecqFVQ3gHNsrRhqW6xDyJ7UEhhPo56/Ols0/o6hh4iBDPHWDUHr9rtWsJ+B0ZYT8b7qIIFSyZhZ9U6tDndB/EwO1CW2SFRBvyBI/PUGJZvEJXQr6tnfEyKus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AgwBdY60; arc=pass smtp.client-ip=94.100.132.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate125-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=1W2HGikbIJzfaYIFBM5i8Nyqmn5OY0xo3QvYrQaWSv4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760967372;
 b=bz7JxP9k+r4TTtnLMbGhTGG3dttbulWZlgULS9N6RgPbp/bqm5k0D27wKjQo1G9syWxZbC+h
 FUn4k6xHzbali0Iwr9A14dnrDj7Kz1XFAmhI6dihsPLhOng9Qoja4Aopus/o/sY7q3eFemDeAs2
 pxFFHmN49c7VjvM0hW+w09pLQHOBKwTf4BSyu0Ome/OqGMpkGz+XJ6hiv6zAee74OEb78rLV3ji
 LjmU5GeKRpNT+vkoFKP2oPAa5DtlhEz/UvbieDQDIadDOR8MQkxS4QtT+ZF1rOLfwnr+8E7l9Se
 t156WNFOXL8FsdvKl/yP8bfaiszlUPhqe/NFxKdbncGVQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760967372;
 b=F7CjWAijAEK7Ex9eJ5S3gY6LrUu+KoCwMfKsWu02g94KMsZJSbSitWdGB+xHaPX9BCyH28DT
 4MRUS9dZbYyLszmftLGgd7eDtlzN4DbN3d5G624EfNuCmpZGe55a0eBw/qU49ikI9gVCHIYwxfP
 TOj5GEOln0cxQTMMn7GyFl9qinVzlYaCYg1o/BYh3o2RpmXgmNT4mucT91JjBytdODpQ80FyE4e
 pvx3PkIowGzQMXXwY32bYES3AwtDb5G//gxVCMAPTcQn+4We+GND2gj4V2geCtf/JjBUAjgL/2d
 ocu28PiqOzz3f3wLsNNhKf5v8TqnaQytRPa5eaSwVfqHQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay125-hz1.antispameurope.com;
 Mon, 20 Oct 2025 15:36:11 +0200
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 90AD3A41252;
	Mon, 20 Oct 2025 15:35:37 +0200 (CEST)
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
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: add TQ-Systems boards MBLS1028A and MBLS1028A-IND
Date: Mon, 20 Oct 2025 15:35:32 +0200
Message-ID: <20251020133536.303471-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay125-hz1.antispameurope.com with 4cqxJV37nmz3jhMp
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:130be11a8cc6b50305d6fbf7d7b2b905
X-cloud-security:scantime:3.047
DKIM-Signature: a=rsa-sha256;
 bh=1W2HGikbIJzfaYIFBM5i8Nyqmn5OY0xo3QvYrQaWSv4=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760967370; v=1;
 b=AgwBdY60DGrfKP9C4baxUGAXe3mXD9M4Ldmlhz+qenii1F2PWUReXnWXP8NCDO5oKFs4XRYg
 UzXfNm27eJidhH8Bix1x5vO6s5xhbvasHAlKsEdDPxmR2GBQvpWerMAsR9VXFh1aCqsaCILn1bg
 oHkIbf2ACSoA8FGgl5Bg7bmn8zSnJ3+cWu4FR9aWMkEeIvYcKbzxcFlT27810hLD3I6lfdXbotN
 Ivutup6XMNJlzVVmAB7c/zzbSoxUHOYQLnkUt9XpqdL2EnS4GXpyLkA6h1sUQ0Oz2AbEKNuYrfC
 AOTpxgz5AlA8x7askJfFBbAVc4rqdD204L3/cfcqQoMkA==

From: Matthias Schiffer <matthias.schiffer@tq-group.com>

Add two mainboards for the TQ-Systems TQMLS1028A SoM, based on the NXP
Layerscape LS1028A.

Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Fix indentation

 Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 34c822a52a5e3..12bf25fb0a97a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1665,6 +1665,15 @@ properties:
           - const: kontron,sl28
           - const: fsl,ls1028a
 
+      - description:
+          TQ-Systems TQMLS1028A SoM on MBLS1028A/MBLS1028A-IND board
+        items:
+          - enum:
+              - tq,ls1028a-tqmls1028a-mbls1028a
+              - tq,ls1028a-tqmls1028a-mbls1028a-ind
+          - const: tq,ls1028a-tqmls1028a
+          - const: fsl,ls1028a
+
       - description: LS1043A based Boards
         items:
           - enum:
-- 
2.43.0


