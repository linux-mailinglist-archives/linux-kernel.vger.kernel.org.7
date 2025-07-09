Return-Path: <linux-kernel+bounces-722982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C9AFE15B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6EF4E305C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFF72701CC;
	Wed,  9 Jul 2025 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="T6S0v3gl"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F126CE18;
	Wed,  9 Jul 2025 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046381; cv=none; b=rg8NwJrMYDeR44d2uERtx9NXhedWMAEJT/zPsDXWP3tzwRCZtPSvZILJWDzYv0lNNFcexTkCdnM0MHq8+0lvgWxtNAg4bSFvg7VvZDB0YdyOCSU+2uPiivAGPHAbNIgbl1JJoXa+oCUPhXrIoMwi2X47Y9T7oY5O0B83uDtGfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046381; c=relaxed/simple;
	bh=Sy8iu66InCx0Di41hZZkltZFq+PKF9yCkPlZT6+6dII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=TC4M6hh0olfjxEMZuH+MwlTyB3zmAV2h32DGmM/dv/JDKN2XHSJfT4eEC9cK3YZk5FZ3/o3r1vZ1KxHnrNcxtUiq9v35bNY+QH7rqdmhtVmbYtn4sOOdmJkrBMDwd1niPASRVPgSlaVQUL8iU7rP9+Y4HMoH67ki1/Rcx+JFizs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=T6S0v3gl; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D53D0A055C;
	Wed,  9 Jul 2025 09:32:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=INofVc3vayZ17omOmsrTU0mCKgOXj0EdNGj9WOSzMF8=; b=
	T6S0v3glKutswVxsbHf0SPuEAyb29Xy/bC++ria2PhKawxQ+2pFa50TFti1rUhzz
	BeinmgQaZDSSk6EKw1KccI2xVZKHx2veUmqUlf/NcOc20tbJjh4x3s8U/3+2HZUP
	hQcdjVaODvc+0mIBmRvwPPezbuCWS0g/cre0cYEC5QHPhMsEDABZreBRaD+ihHIe
	ZlkDIxQeJX3IgBC3QQjG0N4Nov5pOZd+QJIPni55jo2YR6hA5GqwW8zfB6KYYmAg
	OzfkDZjNFZQv9KGHaMYCxaQtmRKu9ZLakXsjDyoXVpBQX3VBkwkq6sKH9SYJwHRc
	h8tyPYniW3YlQaSKHLzEdjqFWi2r63840SDwNpIKzxsNse2vPSVX3q/9npEfBuSA
	KsfCy5quVTU/3yOTw7uRL3hsUjyMg/+TFWPge6OVlR7XfgQeW7TA1vRXv1Th3jZJ
	dVUxzCVE9K/0iUjLc//hHYbNoyWrjZV1y4oeZnY0L8QOSsgxW5tObkYzVrIKOgsi
	lLDT/s+aa2TZvkhw0bI+7au0Cx9DkQLPKgkrS8sJvU2ciZn848EV5w2OFt44GdA7
	oGiclZZ5t5mC6pXxROfUomD3fZbRKsEWhnmxA6abyNc27QQdohpgv/RNlAdjBFMv
	Vg/D0BBSaI0vot6+Q7h1XyjC8/YWmEj7HHiad0zcLTc=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Wed, 9 Jul 2025 09:32:44 +0200
Subject: [PATCH] ARM: dts: imx6-display5: Replace license text comment with
 SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250709-display5-dts-lic-v1-1-81e46a650d3d@prolan.hu>
X-B4-Tracking: v=1; b=H4sIABsbbmgC/x3MwQqDMAyA4VeRnBfolOq2VxkeYptqwHWSiDjEd
 1+343f4/wOMVdjgUR2gvInJOxdcLxWEifLIKLEYald717kbRrFlpo/HuBrOEjA1nt2d2hS6Bkq
 2KCfZ/8tnXzyQMQ5KOUy/0YtsZYXz/AK8LjR/ewAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Lukasz Majewski <lukma@denx.de>, =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?=
	<csokas.bence@prolan.hu>
X-Mailer: b4 0.13.0
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752046376;VERSION=7994;MC=4240065730;ID=156625;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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

Cc: Lukasz Majewski <lukma@denx.de>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 .../imx/imx6q-display5-tianma-tm070-1280x768.dts   | 33 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6q-display5.dtsi      | 33 +---------------------
 2 files changed, 2 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-display5-tianma-tm070-1280x768.dts b/arch/arm/boot/dts/nxp/imx/imx6q-display5-tianma-tm070-1280x768.dts
index 16658b76fc4e..059750270fc4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-display5-tianma-tm070-1280x768.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-display5-tianma-tm070-1280x768.dts
@@ -1,38 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright 2017
  * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is licensed under the terms of the GNU General Public
- *     License version 2.  This program is licensed "as is" without
- *     any warranty of any kind, whether express or implied.
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
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-display5.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-display5.dtsi
index 4ab31f2217cd..4e448b4810f2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-display5.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-display5.dtsi
@@ -1,38 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright 2017
  * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is licensed under the terms of the GNU General Public
- *     License version 2.  This program is licensed "as is" without
- *     any warranty of any kind, whether express or implied.
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

---
base-commit: c435a4f487e8c6a3b23dafbda87d971d4fd14e0b
change-id: 20250708-display5-dts-lic-f35e09a6fc73

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



