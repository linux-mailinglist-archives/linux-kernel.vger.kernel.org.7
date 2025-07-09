Return-Path: <linux-kernel+bounces-722951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40158AFE110
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252231AA2B4F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9197526F449;
	Wed,  9 Jul 2025 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="YOpLxbPB"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0146B8;
	Wed,  9 Jul 2025 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045380; cv=none; b=lUdWwczZap0V3dw9CrR1AtdbgkQR9HfZNLNHIWcHlaa6Z51aGG+tnVa2lT0jYkno1M6bwje/f7XyNPXycfAGQqxBVOwo8H/HpQQM5tdxKq7C6eCWFxnR+0bL+YEnwNuImUHyi/N+ez6Syd4LEcu7PODFRM2u40KvcxPOuMDCbFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045380; c=relaxed/simple;
	bh=rxn+o/fYVdBBDL9xtmjY1WUe0QN8BAwGFVnmr8XjEKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bC6rre+/C+cTY75uoEga8GGDxXwqF6VqRIiUMku9/mkOp9aTdR1lpBT4s6XUT8oCQDmWRU9LIIerUmOcS8I2Sbm9DP8lH1UnEP0LAnQ1jyRfnxJC+xGIPCDSs2la3AFuAPXXeI2R5+JVu4+HD7y9kQr9kc4DFOA2f3hRI7LDH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=YOpLxbPB; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DC37BA0A58;
	Wed,  9 Jul 2025 09:16:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=IFXNzZgsIkYiG7MwBsHn
	psXKT3JPGcxCmEcZuEJEixk=; b=YOpLxbPBy2sB/nRcqt71Dov82gF3X8WjyXPt
	wRe479PuI8GNgFnakhy0wJ7b1xqjOD5JkDnkCWdouEAL6Tfqjc5zAf564Bw9ucdz
	pIsvic96F2/mJXPQJN3VfH/r2aStQfXRQZT30a3NIbcx99ET5FAL7j4NbZ6IwjVy
	7y4e9scKOpy+72Wu1JlTwFdAGH6c0cpnHAdW6eb9sJGAA8xnb/M3qzfmp8QCBtFV
	jEaWsrUD3QW9tpY3jJypm1yd5cF/8q5CiwZqMF2zy/HXDJ73ebiNlQ1mDSG9hO2i
	kY0ubMMiSocsf72JszPYgSTDrnn9ziiQw5ywSeeoiAkNlVAWokN5ChSktMMfex9R
	Hq+/MeQP9mxzP+8ovSoEqmijP0yyamFyXfMimoFUrYUC9Zi/IfBpH8cZcAuaL/rO
	KG0WGUj77KdRKWqyYt1UZfcHSRgT1hZ8WjUeiF/IgyRbaNS+1IGxDay+dkRuCzES
	qwVGonZlz2Gh8LyazjU7DJ2ze0tD5iOtDIPvHyYy4sVvrWgnf55mfLLyswh2Lxlt
	WT8GQqqr+PxhoOiBrtOlsLBz23kUr+iUZWI+6qPvjIGMCnpOVqhdQ8iscQVql4RH
	AZ4VjCsuBzz6fXJyAz5BSGwWGaaDZiYHRGLXEOUbgkl8oIZqwXa0VaoHJ0H7DvqO
	nhCaqTs=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Wed, 9 Jul 2025 09:16:08 +0200
Subject: [PATCH v2 2/2] ARM: dts: imx51-ts4800: Replace license text
 comment with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250709-tsx9x0-dts-lic-v2-2-b9b7d056728b@prolan.hu>
References: <20250709-tsx9x0-dts-lic-v2-0-b9b7d056728b@prolan.hu>
In-Reply-To: <20250709-tsx9x0-dts-lic-v2-0-b9b7d056728b@prolan.hu>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Damien Riegel
	<damien.riegel@savoirfairelinux.com>, <contact@savoirfairelinux.com>
X-Mailer: b4 0.13.0
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752045369;VERSION=7994;MC=1191366156;ID=156413;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E657160

Replace verbatim license text with a `SPDX-License-Identifier`.

The license is specified as "X11", but as other TSxxxx boards mis-attribute
MIT as X11, this is probably the case here as well. Savoir-Faire Linux
will have to confirm this.

Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: contact@savoirfairelinux.com
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts b/arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts
index 079bd3d14999..aa7298e34a10 100644
--- a/arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
  * Copyright 2015 Savoir-faire Linux
  *
  * This device tree is based on imx51-babbage.dts
- *
- * Licensed under the X11 license or the GPL v2 (or later)
  */
 
 /dts-v1/;

-- 
2.43.0



