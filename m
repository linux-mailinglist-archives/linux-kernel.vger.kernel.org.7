Return-Path: <linux-kernel+bounces-751642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD04B16BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4610582B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E6242D63;
	Thu, 31 Jul 2025 05:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="kRxiwXyv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fYaC+P1x"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17604323D;
	Thu, 31 Jul 2025 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753941511; cv=none; b=kuut3gmniLbhgwryycgvSupI5YskvLvKEylgIq7T4IFtCHR0CVnoNvx4GkQiKehf5I1Ll4cKTFPf7QWBmuVGkxsoiFZ3gg62kjlZOHNNUwdXusd4qeo0gMK5Ws18YdoL2GCJ4/XqHGp96hzVCISwtS3ze1NWHh8JwEOXlvArq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753941511; c=relaxed/simple;
	bh=cGbzmsV+xJPSNLboyu0ymV3QD2y9cWV6+EX29cXbVjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XkdYKbG6nyAbvdZnop/C1LkJrofky7/+ZnT+NazWsQ4hRuUlqyL5LuotT4PjTSPO65VkIURrLGlh0WvmkiGwlK/m4R1lomzzY+YsXdqkeduf9c2/IagjQrNPkCsh4Ai6NAGUJLU1e73f9F2+T1Dataw88gjAHu9qZXeQqgiEP9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=kRxiwXyv; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=fYaC+P1x reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753941506; x=1785477506;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=98SHBebru6MCJ/QnRQtH2DcDv15Ssbf4Sj22mQlx6D8=;
  b=kRxiwXyvXOwxLQFhVY/VeGtCeABt+8YGJVHIphP5njzAaXtyIlz3Tqyt
   n5t+ILd8AiMw7gR6jwYtROJa8AhDC4x/kR1vo6M5uTBWLBbvYEvfP3l0n
   s2zN7SKeECZcJTTKPT9i2GrEuzkjZteQnvxzrgVfxGRhWlNLlQc4pfpX1
   6tvPoyQyX0UPl0FKOo3mJ1hk4KQWvnUCQNeJhmWJZscTc/inNDvZdhXZ/
   2pP6Euq6LaPZ/nc0dxddWl7c1KO2sASpoHWeYLsgbZyu8IdGEH7PYFe2E
   EpUdSsrT3cEr3mls+xFQfumPiLmgjvhWZZmTrK0knBgwAEZnrcvq07DI2
   Q==;
X-CSE-ConnectionGUID: 42qa7/ZfSFKqzF0ESfeQZw==
X-CSE-MsgGUID: Yx8XBTCYSbecOEUDS8gpeg==
X-IronPort-AV: E=Sophos;i="6.16,353,1744063200"; 
   d="scan'208";a="45509996"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 31 Jul 2025 07:58:23 +0200
X-CheckPoint: {688B05FF-6-FE216C80-D1ADDD01}
X-MAIL-CPID: 343950EB2E7D3053FAAC216CA983035A_4
X-Control-Analysis: str=0001.0A00210A.688B05FA.005F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66CD616B0A1;
	Thu, 31 Jul 2025 07:58:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753941498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=98SHBebru6MCJ/QnRQtH2DcDv15Ssbf4Sj22mQlx6D8=;
	b=fYaC+P1xLljM/NdSckBIk110Nhmd1J/Ou3zJkfO2E39fvTHYbPAkTpDurN7pZ5dqN1zv7t
	32gjV002+v6EELCUgr6ThmxHXKVlNMeilROyXBWFtHOrK0mIg6HCLG64oHpx+lPUv3ZyOL
	oicN55gMPoRsRRX1unSIYzfpsGYiaSf0SjHtbNCOw0DDPPsMmIgElei9iCHwFM6qnOwg90
	GUNkwpWN+9KFonU63w42lG+IXMI72z4E4qP/behfKf2Z+uiAUe2y/iFVZVGqM9bgEErckL
	ahkJBbhgEpYYOzgGirYRBYo6Scj5gXbNPfS2Omwhybral1ccJDG2LLXM/Cdz4w==
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
Subject: [PATCH v2 1/1] dt-bindings: fsl: fsl,rcpm: Add #power-domain-cells
Date: Thu, 31 Jul 2025 07:58:04 +0200
Message-ID: <20250731055806.2265628-1-alexander.stein@ew.tq-group.com>
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
for power-controller node") explicitly added that property, add it
to the expected property list as well.

Fixes: ad21e3840a88 ("dt-bindings: soc: fsl: Convert rcpm to yaml format")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---

Changes in v2:
* Add the property instead of referencinf power-domain.yaml
* Adjust commit message
* v1: https://lore.kernel.org/all/20250725055835.260930-1-alexander.stein@ew.tq-group.com/

 Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
index 03d71ab930d79..2aa8e8a2643ba 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
@@ -49,6 +49,8 @@ properties:
   reg:
     maxItems: 1
 
+  "#power-domain-cells": true
+
   "#fsl,rcpm-wakeup-cells":
     description: |
       The number of IPPDEXPCR register cells in the
-- 
2.43.0


