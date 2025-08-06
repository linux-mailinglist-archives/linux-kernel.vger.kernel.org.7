Return-Path: <linux-kernel+bounces-758392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B653CB1CE65
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E173ABC8D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C78226CE5;
	Wed,  6 Aug 2025 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1IeyHck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB65224AF1;
	Wed,  6 Aug 2025 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515701; cv=none; b=nF0H7tqwwMaqGBT9D+hhu3MRFRzCI3jD7dVw2163JGC05xqDSv86bEKOstF72tbtANPdMA7ny8xw/JY7Lm8MLYI+ZPtXiVO/hLcil5//47qKhCiATJLU4siqqv8dkN68lMhkc+OaUBkBtaGgKXcyn5k96p39VUtUlZMbRiwqipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515701; c=relaxed/simple;
	bh=tnVINnlcjZVyGMxUZ1JOlgx4QEfSZ+8xLfws7QFbDP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GEmzpic2qIVeM7ha/OcYvqhhGxxNilBucAS1Yek7mS16F8DfyYcg3TFZdtkIOTWR9dk6+LvY+/iiv70Ug0w9XUp3QU22pOSBOfIkaQKU2+jp6Vq3pnXgnnSvixyZ3v7UZNFJzyf5kpP1N7x7B/dJqiSmO+yf3qt62u/7sowrk/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1IeyHck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACECC4CEE7;
	Wed,  6 Aug 2025 21:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754515699;
	bh=tnVINnlcjZVyGMxUZ1JOlgx4QEfSZ+8xLfws7QFbDP8=;
	h=From:To:Cc:Subject:Date:From;
	b=o1IeyHckSxws9//XGC61A8UA5c0AC6v8nRzDfW33062BQACGGalP4hmw0uH9c0mv0
	 j6X2c4wwSa60AFvzu2tHZyWBwM3fLB4YgB1e0nJpIFkVCpIUAGilolfdgviU2/2WXU
	 M7DEchzk17i3iBhwX+Bf+2KQ2/dLKhQ+qLXj0hncA/GaP/d4LddCxsqdHWmHAJho9o
	 LLoAFZG/eAYPpClmUvFm+IK1eGOAeOke8wvolDSP+mMsGDdrif9cegH4sSXrdxYt9X
	 xk8gqG8FcOfSySGMNn1INVP+M7JkB93aLFG6k135fgAruFeO8oe50nVnPv8ceNYjEj
	 UFAuN6m2KOTOg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Robert Richter <rric@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Drop obsolete cavium-thunder2.txt
Date: Wed,  6 Aug 2025 16:28:11 -0500
Message-ID: <20250806212812.1634740-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The binding is already converted to schema and is located in
Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cavium-thunder2.txt | 8 --------
 MAINTAINERS                                               | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder2.txt

diff --git a/Documentation/devicetree/bindings/arm/cavium-thunder2.txt b/Documentation/devicetree/bindings/arm/cavium-thunder2.txt
deleted file mode 100644
index dc5dd65cbce7..000000000000
--- a/Documentation/devicetree/bindings/arm/cavium-thunder2.txt
+++ /dev/null
@@ -1,8 +0,0 @@
-Cavium ThunderX2 CN99XX platform tree bindings
-----------------------------------------------
-
-Boards with Cavium ThunderX2 CN99XX SoC shall have the root property:
-  compatible = "cavium,thunderx2-cn9900", "brcm,vulcan-soc";
-
-These SoC uses the "cavium,thunder2" core which will be compatible
-with "brcm,vulcan".
diff --git a/MAINTAINERS b/MAINTAINERS
index daf48a47f0be..8b9548bbbdea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5545,7 +5545,7 @@ CAVIUM THUNDERX2 ARM64 SOC
 M:	Robert Richter <rric@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Odd Fixes
-F:	Documentation/devicetree/bindings/arm/cavium-thunder2.txt
+F:	Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml
 F:	arch/arm64/boot/dts/cavium/thunder2-99xx*
 
 CBS/ETF/TAPRIO QDISCS
-- 
2.47.2


