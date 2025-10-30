Return-Path: <linux-kernel+bounces-878696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E344BC2148D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27E704F24F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553D3683A2;
	Thu, 30 Oct 2025 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f/wgvFeQ"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8193678D0;
	Thu, 30 Oct 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842632; cv=none; b=RuX9Stpv+6ySI8dexIgk/5t3E2ZsUO+dRYk/J9xBLpu1zBJY0aMDsbmv0HlI8FMptdgHC7qkcB3pppwggemHbKSV9vbSjqP0GLkI2l5N6OGy3hCdaF/07PrQS0m5QLPNjDDixwDKcKNMrJAiCPPcXLvJsdERXQN/z++mowt95oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842632; c=relaxed/simple;
	bh=rVfyl+pgmeFK0Y407AbklcW4AJUJ4qHRNL3mYtIHjnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ptk/uahbKopFbBbGtSnxxMuuARqMC2ZoXzkJcjx9KSBEo809NsEtGN53ITH5vbBKETB7P4n5HobjT7xsDGZ6EbQrQzVHjIvZYMTxzbNEx+TG1RunzZb0RN+rrf2tdXbeiSLgPq6yQPXK5LtDSg+TnVQMLGU8A+BLRdDQbqLdCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f/wgvFeQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B6A464E413FE;
	Thu, 30 Oct 2025 16:43:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8C28560331;
	Thu, 30 Oct 2025 16:43:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D6F311808C40;
	Thu, 30 Oct 2025 17:43:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761842628; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=8ulDJoknkJyiEMiD+sux6OU4HHrhPcfi/m+a05DqKY8=;
	b=f/wgvFeQ0iy1nNEdWzYBXfqLoyio4I+jITijGDz709akZ/FHS139EBBPH1AvjAzAuVOGTo
	e09qUn91Nd2dOP8i9mb61oppChhsPWLONF2+BQCxwWQdkQ7lnC2fKppS5AvYJjDeN3lyse
	VJE0KaOdut5L7dlEO8l56UmAXn9C6W6OUXTT32Jv+BfdCT+rA75alWcYsWHi92/pLhaZxh
	+sLbIyo+8YcvY9zWdxUEUoAstgLwhIVc/TXe7+rV/oSknSWMSq4eTeJrJIyKOyjJ1ZkPBs
	N3td8e+POQLXFMYRmyFigwnRu+izCITsHk5aIGCzCFmCWAPEqd6yUmO4UEL6RQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Thu, 30 Oct 2025 17:43:44 +0100
Subject: [PATCH v2] dt-bindings: interrupt-controller: Update license for
 MIPS GIC header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251030-fix_gic_dt_licence-v2-1-94444b458e36@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAL+VA2kC/22NwQqDMBBEf0X23JQk1Kg99T+KiN2sumATSYK0i
 P/eVOitxzfMvNkgUmCKcC02CLRyZO8y6FMBOPVuJME2M2ipSyV1LQZ+dSNjZ1M3M5JDElhXZrD
 GVrIhyMMlUG4d0nubeeKYfHgfH6v6pj9d80+3KqFEP1Syvkgsyajbw/s0szujf0K77/sHwMv2x
 7YAAAA=
X-Change-ID: 20251028-fix_gic_dt_licence-c876fd6d709e
To: Andrew Bresticker <abrestic@rivosinc.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gregory CLEMENT <gregory.clement@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

According to Documentation/devicetree/bindings/submitting-patches.rst:
"DT binding files should be dual-licensed." The second license should
be a BSD-like license, allowing the use of the binding in projects
other than Linux. Initially, this file was submitted without any
license and was later automatically converted to the default Linux
license. Let’s now update it to follow the preferred license for the
binding.

Acked-by: Andrew Bresticker <abrestic@rivosinc.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
Changes in v2:
- Add acknowledgement to Andrew Bresticker, the original author of the file.
- Update the subject prefix following Conor's suggestion.
- Link to v1: https://lore.kernel.org/r/20251029-fix_gic_dt_licence-v1-1-af70840c5e61@bootlin.com
---
 include/dt-bindings/interrupt-controller/mips-gic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/interrupt-controller/mips-gic.h b/include/dt-bindings/interrupt-controller/mips-gic.h
index bd45cee0c3f05..647f22d5f0622 100644
--- a/include/dt-bindings/interrupt-controller/mips-gic.h
+++ b/include/dt-bindings/interrupt-controller/mips-gic.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 #ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_MIPS_GIC_H
 #define _DT_BINDINGS_INTERRUPT_CONTROLLER_MIPS_GIC_H
 

---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251028-fix_gic_dt_licence-c876fd6d709e

Best regards,
-- 
Grégory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


