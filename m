Return-Path: <linux-kernel+bounces-871377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D09C0D0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BFC3B9F60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42AD2FAC09;
	Mon, 27 Oct 2025 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Qi40IZdV"
Received: from mx-relay170-hz1.antispameurope.com (mx-relay170-hz1.antispameurope.com [94.100.132.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF42FB0AA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563168; cv=pass; b=Y0O0lGqRHu/7Zi+e/8/KI1j/oOQiHidyy+tSpSLLAd2nL4cE18leJsMs9owbzn5DmEzHO0YcQ1+HvVIKfYNSnhu9C12TA7qXQPp9p1wAoLslzB8eDsWuM3OICKV0BLB2URJ8XUYkQkP4K0cpcMs+F9ZnOwpHM9yXfnFPuW4uHXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563168; c=relaxed/simple;
	bh=YZGQd8jI9Vellkzt/s6sS4bgFKhEBKH1fIQjG2qUnFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSDNGefN4xgzDAbI4YJ5j4vyaORVDAVk/1zbApG2g3JWGH2GYpFT1z0CN1ROUqgT5xVgxJl1aXIFwGvrt3fz8wrDIKEh0CQbTZ3aXpV8ZtFWGzvsnwoWIN4c0x0bynFuohuqgdPdAu07DQmew0ZrqT51Eq2U8Jxhw+UpKkC2yY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Qi40IZdV; arc=pass smtp.client-ip=94.100.132.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate170-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=87X5R6vjtDdJY60KYPFY+Q7PYLNtQIh/pXfTLhBqd68=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761563133;
 b=CbtORbrQtsMo1EepCF9/6fhiwdQgu47ailNKx4gVu6EsbnRSR3onKTDvhKR2TlKIYUldqfU0
 tbsLZKzqSECQOkb5qGPj3QXYrIB+0DUjX6Ar/H15nLkjiMk9EYsG0qmpdw2jpuwE9pFPiXQb+7t
 0Hzb26dmqwg/D11fxJRD+SrVMl80jRzl3Bx7QP6gCZlaV/+e6pwAtyIWHE9KICkFISag4PYMes0
 9+J5wH+86I/x9mICdb3SvNdOJD/w0xtQY8OP0j2qzaps9QTZduZe/NqOZJnspkd7NBDYtJrxsP/
 wJSw9+jSpj+fluTlZ8sgOsqG1zB7v1RcbxTH6pqD4vIQw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761563133;
 b=Iplbw7iUx8Bl/zFeSYYtzM+5PeYs/zcSV73xmaowQtS+VfKgvHYMAcL0K8rra0vLVX5E9dHd
 yUzmfcsFnTFUUmdMOq6xr7JEqZqeLcX0JJNuqjQYlNgDvyG9XyON/Ar44Rt8YqeZp/Joo66sPs6
 jE8XdoYTPVpasbDQlWPcOcbxH0KAe7oqBdsoHtcLKBMBGr+iXizxiHTd1Z7rJgH5HTG3iSIE7zB
 BEevrSnst1XX0BNr1eeKPvNUTpzU1V+NKS4qTm06ahNRLFoik/o2EIeWghEl9Kk+RYEqcr0fYgw
 /DfM3QuAFItura+tDi5XBsgYlFyrkiBEqGC2dEsk08Xlw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay170-hz1.antispameurope.com;
 Mon, 27 Oct 2025 12:05:33 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 5FCB6A4127F;
	Mon, 27 Oct 2025 12:05:10 +0100 (CET)
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
	Frank Li <Frank.Li@nxp.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: fsl: add TQ-Systems boards MBLS1028A and MBLS1028A-IND
Date: Mon, 27 Oct 2025 12:04:55 +0100
Message-ID: <20251027110459.420857-1-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay170-hz1.antispameurope.com with 4cw9dg19t5z3WpYc
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:f3fe413255b5fec6c4a2399235bbca65
X-cloud-security:scantime:2.082
DKIM-Signature: a=rsa-sha256;
 bh=87X5R6vjtDdJY60KYPFY+Q7PYLNtQIh/pXfTLhBqd68=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761563132; v=1;
 b=Qi40IZdVa1J/X3XKQ1zCYtx8YzrnYA3FEHtKfncE/cS3tdOSHTU3ARPlr2e86qyFCdHoJaZm
 faBkp24gLLWJtEhjXBLzufhPLEOEP0BQsBVRU33e/JBYonEqEg3DJ3h87qaQGXj141PIZDGf4l9
 hDhDAENJ9HrSnnSJHQJBkcqHCDcGYL79o3MemeJAD2g5Ga24t3ZFSfT8KW8rifn+vjKHNc3BNRA
 qp5AjRv3FZjUCBMwSikRM0QOnDUcr4UGn6aXA8sn9rsDbAWiR9oaBnGG5jc2x6s+grrYf+0Rwz0
 ZTtRtZ45xDrUewzaywSatqk5CvonggZN8XIWKS92FhruQ==

From: Matthias Schiffer <matthias.schiffer@tq-group.com>

Add two mainboards for the TQ-Systems TQMLS1028A SoM, based on the NXP
Layerscape LS1028A.

Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v3:
* Add Frank's R-b

Changes in v2:
* Fix indentation

 Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index c5d81e3f8bd17..fbffb1a536ba3 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1656,6 +1656,15 @@ properties:
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


