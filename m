Return-Path: <linux-kernel+bounces-768187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97802B25DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051B2163E35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9094E2E3AFC;
	Thu, 14 Aug 2025 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="moeDmzO9"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B462D6622;
	Thu, 14 Aug 2025 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157680; cv=none; b=fI5ufwpwUaDv/XIu1puYHZ0d53AwO7Iy2gZS9w5PDdq0BilA5zF+FWGG1KYJRHK9merhnz4cBNjFgFXdZFhF7zCox0SnedCumHBE8WR2CB1/WQCurGrZQJ+RD+VO3wX+t47UT6eXGnc+WGhiMjXc9xTxywj4XVlu2+h9Z6CT2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157680; c=relaxed/simple;
	bh=zCHAqKKCFtSFWeMLfl3j4tqWJEwqnZDL20gwMjLCAlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cB3K0Vvpg2HkCguhBNJbbA3sc8naVLiG2we/2uN1rsu/J4L1XPWdi6qPBq7S/4Fg8wuWpbrv7MIJTm3X2AtiAfmC2cPeChH4Vz1SFLtug/Uh01m4dTp5ANxj2qrOHV1nHI7XsSGZMnNLKBiGsFS6DFMFEdxNCFxF8mAIYhUY25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=moeDmzO9; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 15D59A0F9B;
	Thu, 14 Aug 2025 09:47:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=U5KR1zgb+2iVheVTOl3S
	X/dmkA++aT5srmWbqsDAvzc=; b=moeDmzO9rmAP4cez4/AR8ncDqL5x/F9G7Wuh
	BtKAZGeOCCS1dpIWqa3YwQK8jIbVmjyjRLNfahu7cqgWFilaeBITn7auGr+4hZET
	NQtGwArkN5QSk5eT0YVEtYJcHBkQABU8YfhjvXkxsA7MZxT+dFGqU6BXH+N1bfG/
	MIJqNKX1Gq1PEk4uKsH/RAiOWXh3hQZT/BRhHKe2cD2l9Q5z3QrP5+tqaABaieGu
	bm0idR7OC5hbBbZhCj/WyqOFneUTTGQ5ykjalqXEpWjnogR70ZohyZkJaGz7RhwD
	yOlntFjaYtAppG6YG/wpf73cEIP78sF1NWzgX7TS70DBClmHBMJE+66b8sLX54lC
	uWPvo8//LI5AMDozCEq8/+uf+Uekw6UupA64muC7MVJJShxHDmboDco1xcbK4v5X
	IL9dtCprXtqOISPFz9vq0tnHdG0AFF+RltnkRnGalDG0NlNMgsyuIqdOEABvAdDP
	ajUnNa8CVGwhG1EPADzIrBxjgOlq2nLjbTp8wN77ma7+0sgmgQp4Ley8VXgUIHW6
	kB3ETzNGDUqu4CB/Zek1/Nniu5qCHMJPRSC+yi6MYc3Bs7N3eEPrutqV/6/u+mUd
	CerbdBrFuK5DdLGPQMmLG7DVMWlbicjgqFYJLHx2XDXFafpyMZ5Ip76C71a0xhp2
	wgWFAG0=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Thu, 14 Aug 2025 09:47:46 +0200
Subject: [PATCH v2 4/8] ARM: dts: imx6-evi: Replace license text comment
 with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250814-imx-misc-dts-lic-v2-4-faff7db49a5f@prolan.hu>
References: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
In-Reply-To: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Joshua Clayton
	<stillcompiling@gmail.com>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755157669;VERSION=7995;MC=3336485094;ID=1088344;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E617667

Replace verbatim license text with a `SPDX-License-Identifier`.

The comment header mis-attributes this license to be "X11", but the
license text does not include the last line "Except as contained in this
notice, the name of the X Consortium shall not be used in advertising or
otherwise to promote the sale, use or other dealings in this Software
without prior written authorization from the X Consortium.". Therefore,
this license is actually equivalent to the SPDX "MIT" license (confirmed
by text diffing).

Cc: Joshua Clayton <stillcompiling@gmail.com>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/nxp/imx/imx6q-evi.dts | 40 +--------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
index 78d941fef5dfb288c69d702ed190150caa92ba7a..0268b7f5a7d22c9abac848e71b4b05b76dccbfca 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
@@ -1,44 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
  * Copyright 2016 United Western Technologies.
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- *
  */
 
 /dts-v1/;

-- 
2.43.0



