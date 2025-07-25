Return-Path: <linux-kernel+bounces-745303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654BFB11827
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA871CE1769
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3552926CE26;
	Fri, 25 Jul 2025 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="m/H3hcca";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="VcJKFj3J"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A720776026;
	Fri, 25 Jul 2025 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753423130; cv=none; b=gD0AOYfGZBHYV9kzKzwuU3i2I8emHBHYSh8DFJpqB8KeqgXox5F075AZ7Ba7a4gkJNhioKqaS3OOfnmHA5fro/dVtG9yLr6AT4cS/RA0bjqt1QoLNyuVMFEapqGN2myCujv12KYcquKP4CiptaD79eQY1OTZcjvn8EurZTk9JrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753423130; c=relaxed/simple;
	bh=dP9lqE9tnTDHnVKWZ/4rmClkZJYmsCHdlyzQTedxWZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/n2Khn9eql88l83t896Ud2ILHbGBLjXUgYVEzMs4Kj4H2qHZWchtsw9lMc1D/wzW/B98781zrqSDT3RQAHeyde7j3RAnfJM2tM9UPlSM41zdM9Sa6czwTBHAPQvTpwnN8IJGSxQsXP++xIxU57h0XV/oDTYWQOpDfqAKhPYS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=m/H3hcca; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=VcJKFj3J reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753423128; x=1784959128;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V4QdjaSb9cXI8p01nmDA+/A+YYF9fy6Z2O8CYR9WSVM=;
  b=m/H3hccaW1ipivCygqFcLeHDFwxItQ28aIBAxs6V49Mc8JL/hGc7Pvf6
   p14xJuUYgc0Pqdc8wunrJVFCIcezFqZ7JUnNWuw6wwDFg0uvECfYEG9m/
   3rqTc5PjrxENaUgT1HZtMyo0tizEyncPHOk9NnoT13JCduXjBlRShR2Gn
   is7z2l0nDsCDKeFqfp3DDwB0Q7D/Fs4uK29Vip9MbjhJV5ViTCHsHOu0T
   UAFWeOBjefmElj7Umy7AVzB6cj/8E9YSLjP8TpxC1XmzfwyBfyycb/S80
   g9vgHq4bgrmbpFOM8TbgYLOHSk0OVvjD6D+kS/jU5Bm9TAwWziQmwJ1rW
   g==;
X-CSE-ConnectionGUID: tgE28l+3ShaV1TiRICoAlA==
X-CSE-MsgGUID: /HnVzqXOSEqWo7EWgSOZ1A==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45412596"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 07:58:43 +0200
X-CheckPoint: {68831D13-65-BB1FFBB0-EB2CC75E}
X-MAIL-CPID: D84144F887B9A33A50C0C2DD131BC566_2
X-Control-Analysis: str=0001.0A002106.68831D1B.0056,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F258B173583;
	Fri, 25 Jul 2025 07:58:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753423119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V4QdjaSb9cXI8p01nmDA+/A+YYF9fy6Z2O8CYR9WSVM=;
	b=VcJKFj3JkwShCaE0hIBZ0CmU43T7HFnPTHYwbM0zUpZDWX2UJ3ADKUHTO9eefxIfAhm2H0
	oNqo9NnM5PJE+eHA71PJFrVoU+qiUCHQ8lcPovRU58mw+RjI5MOaBndnfeS4OEVL3eYYoO
	qIWAqNj935NKJ7RFBQYtzz6YTIqDatPi+aN6S3HxVsvXhCOaOXEPvwYsmg53XFnAHIPBtG
	yaOXH904wNfesQQbKSa8QicQ26VY4Ao6y+ygYAJBz4Zsq6iykreT/w0Tg8FDZ5P/T+lFh4
	tMvr+wYKMqvkquNODQBMz0sGNTE6chb2bEg7Tx9R5lCTAREhhji0yAfLQE5kag==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dt-bindings: fsl: fsl,rcpm: reference power-domains.yaml
Date: Fri, 25 Jul 2025 07:58:34 +0200
Message-ID: <20250725055835.260930-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

dtbs_check for ls1021.dtsi warns about unsupported property:
 power-controller@1ee2140 (fsl,ls1021a-rcpm): '#power-domain-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'

But if removed the check warns about missing property:
 power-controller@1ee2140 (fsl,ls1021a-rcpm): '#power-domain-cells' is a required property

Given commit 8bcf67b8d893b ("ARM: dts: ls1021a: add #power-domain-cells
for power-controller node") explicitly added that property, add a
reference to the common bindings to fix the warning.

Fixes: ad21e3840a88 ("dt-bindings: soc: fsl: Convert rcpm to yaml format")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
index 03d71ab930d79..5b7c0a1905545 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
@@ -13,6 +13,9 @@ description:
 maintainers:
   - Frank Li <Frank.Li@nxp.com>
 
+allOf:
+  - $ref: /schemas/power/power-domain.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -75,7 +78,7 @@ properties:
       RCPM register block is Little Endian. Without it RCPM
       will be Big Endian (default case).
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.43.0


