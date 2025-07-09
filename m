Return-Path: <linux-kernel+bounces-722974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0CBAFE14A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7E2173351
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5997E2701CC;
	Wed,  9 Jul 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="XIeuWo+U"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2226FD9F;
	Wed,  9 Jul 2025 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046141; cv=none; b=Dj8T/fkMmo+CBWSgCZQenUDE9bENEGYbEx/6FIhm8X1wDW0WxZeCFNzAGhNlvokj7RMlw2qokvhDHZMCAWUyOSE3D0Gu6OYKjyjqfhgpw5w8FjW4KsPAZW05/g73kS1gtmaQYZTrtPGP7LyU4g8zDsp70YSHhS17yGAo1iieuxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046141; c=relaxed/simple;
	bh=yxDCviYLRpqQzr+PhVjdnq+ZY/SnTAd8y5gvPCXv2z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=gi1v0Sn2VNGnzjMW9B9y+ToLyh4tbEhUuNyvnb5yRBZ20nUtcndkWh3lBrgrcsSUTSCz/3zHndJkgNfGuvLnpC7cvBYN+5wXQhgE33E3ooPj5GIv6TnE0g3TSVtvhcdmJsmDkIVegXC/nvYk/mym0F6cicFhwfOoHP+ObPoruAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=XIeuWo+U; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 15670A09FF;
	Wed,  9 Jul 2025 09:28:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=4yGoqH6hCqcVDfbu1fH3f7JCK5DTeUO8WKovpLThK58=; b=
	XIeuWo+UND5iVp+ch2vlTq5fLSbIlf6o5AMp/68ACKlMTYMqBPSZhwnmUBwm0yS7
	Kkd5iuI3J/BDJWS9tR/9fQFmIQbUxKh/vzZ+6CtfOy1PdsTQCDSI97k/gSJ0zMjj
	zCr0SF1hSWwZ8G2QX551/SkzGTKr51+OC135eomGFydKhCmk2QMytkcmN+MhwbbO
	o3PCzJxy5e4fpGGNRfgRfof0Y3HtXAcsa8FkRlfiMbHfM85Z4f+JM6pq2XMHHbQP
	P0KxcUbli6MUmGO4BXvCBUrMAF/Fuw+5p5zFY3XvyHgjxVwKXq6lTJZHtc2RCrJy
	cbN1p4+54IG57TcUEstq9HFLAI7zxWkrsjEwFEyOYasiubVlKX0wkOLpXovErFFq
	AvTuDDN9nePoM1Dn7Md7Bni93sGHSrxDIPrqmY/yONVJVa7bI4d/okJhPeQTdAqd
	SaeCXDXD+Ez78iIYAW7Z2zGK47gcsh+YdRexC6AiVYMdnhILelgiurmrpdCnRyip
	CN8VPncnjzdS3rtCpGByWY8EoRc30wq9gWYaMFPPfNXC/XIQa6qXWRR0grAfxIj+
	rDh1cthLt9HZaf1fQa+PbI/7tyFVHdyRf1dZ5ZeWr/w9QCrVHmXlUWJG1MZNVx+w
	Y7wVRkpjxZ+HLv8k6Lc9yyW+jOG569SJqVpRRIAzBSc=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Wed, 9 Jul 2025 09:28:47 +0200
Subject: [PATCH v2] ARM: dts: imx6-aristainetos2: Replace license text
 comment with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250709-abb-dts-lic-v2-1-adc5e4781f65@prolan.hu>
X-B4-Tracking: v=1; b=H4sIAC4abmgC/22Nyw6CMBBFf4XM2jFt5SGu/A/Doo/BNsFCpkg0h
 H+3sHZ5knPPXSERB0pwK1ZgWkIKY8ygTgVYr+OTMLjMoISqRCMUamPQzQmHYNFZc2mEbO21LSE
 vJqY+fI7ao8tsdCI0rKP1e+Ol00y8iz6keeTv8brIXf9/sEiUaKRSvatdWdX2PvE46Hj2b+i2b
 fsB7cITPr8AAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Heiko Schocher" <hs@denx.de>, =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?=
	<csokas.bence@prolan.hu>
X-Mailer: b4 0.13.0
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752046136;VERSION=7994;MC=629786266;ID=156502;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E657160

Replace verbatim license text with a `SPDX-License-Identifier`.

The comment header mis-attributes this license to be "X11", but the
license text does not include the last line "Except as contained in this
notice, the name of the X Consortium shall not be used in advertising or
otherwise to promote the sale, use or other dealings in this Software
without prior written authorization from the X Consortium.". Therefore,
this license is actually equivalent to the SPDX "MIT" license (confirmed
by text diffing).

Cc: Heiko Schocher <hs@denx.de>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
Changes in v2:
- Fix msg
- Link to v1: https://lore.kernel.org/r/20250702-abb-dts-lic-v1-1-b122fd6d456c@prolan.hu
---
 .../boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts    | 38 +---------------------
 .../boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts    | 38 +---------------------
 .../boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi    | 38 +---------------------
 3 files changed, 3 insertions(+), 111 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts
index c9b2ea2b24b2..fc62ba2a4fcb 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts
@@ -1,44 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * support for the imx6 based aristainetos2 board
  *
  * Copyright (C) 2015 Heiko Schocher <hs@denx.de>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License
- *     version 2 as published by the Free Software Foundation.
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
  */
 /dts-v1/;
 #include "imx6dl.dtsi"
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts
index 5e15212eaf3a..a7400d42475b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts
@@ -1,44 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * support for the imx6 based aristainetos2 board
  *
  * Copyright (C) 2015 Heiko Schocher <hs@denx.de>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License
- *     version 2 as published by the Free Software Foundation.
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
  */
 /dts-v1/;
 #include "imx6dl.dtsi"
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
index 7cc7ae195988..57970f29367d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
@@ -1,44 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * support for the imx6 based aristainetos2 board
  *
  * Copyright (C) 2015 Heiko Schocher <hs@denx.de>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License
- *     version 2 as published by the Free Software Foundation.
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
  */
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/imx6qdl-clock.h>

---
base-commit: 66701750d5565c574af42bef0b789ce0203e3071
change-id: 20250702-abb-dts-lic-dcb37019c894

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



