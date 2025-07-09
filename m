Return-Path: <linux-kernel+bounces-722979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ED2AFE154
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A418B3AD805
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525252701C3;
	Wed,  9 Jul 2025 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="IfPVUmc5"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5B22154D;
	Wed,  9 Jul 2025 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046301; cv=none; b=SNAHONl5j+3PsZbb2hkQVPM4RRRQ4Dhw4JstiUhPRi1zjw7XEL1o5V1N4twrWud5VEyouxm33KyOX/jHsktfL+x+XWK4x2Bo5oz5X75vdBMX+1NdvShG9uZVAmqdgRsBnx2jifoBTZswt6TKZqBhnmZ0lvJU59PQwwOXH1LEqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046301; c=relaxed/simple;
	bh=0WJSDopx5bvByfhztE14V1M7f3ua8wtGYEXx6Hjwh0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=u+6wVQYYFBIs2w4mwgCFNE1Tm3UtHPBMjX9q0frdKIYBENMLhyZ5P1Hqhvt0Xut7hOa9hsXDmljXgDb7h9lBcPnS3bij9AV+DlTAE6XZirOEfEvrprQ3xhDveO39aL30XU8KgeHAml7+Rdjt2u6Mg+GheJzvjf3TygA+kKktzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=IfPVUmc5; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 57D28A09FF;
	Wed,  9 Jul 2025 09:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=BE4ao5MP8rbHBjdHtNFtYJxy5/GgWgE6oAwjYaQQuHw=; b=
	IfPVUmc5nGkKUJ2/gUmLmw3mXJbQ6DsJ5mv4G1Ejbj65lMP/J0EActDUHgNqCIqg
	5+aM9MFTqnsA0rETeAu0b4GajsZV1qBbBfL0qLoPMKmVgklLgIhEY+5HSgr6eE6o
	VPX0I6T4/Vxoc56sIcbVoQbQ+plNBlEO/igUUS8hKdoF+4BIiRrvX3uif/AJdcvV
	BuLjVCRPOuIRUVVsf4OzS0iS4smZHvHfAPcVfkcQXqn5eOy3BEZC4AFJKM0y08S6
	gwnsqEI3GOG6mFsPRYe6/8iQPQl22WDdMp9n2XSMqqlGUSRFeag88CCr2WDbNxLt
	u9P2A8Rl/QB0XxrLANVV/2PdUfFlfLA9Javbf642waryKTGE5Zbs5GPUs64dZxNx
	Ni9u4z3nKb+IrShp7zAzQJKYwrzN7lsEBi8NdJQ6SMpDqyIkMw9Pu/zppo//gpWw
	H3tfDc40xOBePIdhgL6uivqJOjFNwiAm8m0xwFDQwldOQcmBECq4oK0eq9FcpS+q
	qw4Z68oLrwcCYXJ5LmSAbPqoYxqCAjZR4kkpFAQB6DeHNN6zkm5n3vgPbzBxPqyO
	cTl9TxWvSUNWlNxn9ja8EMOblozrJAoORU4HJHaxKwlXPl1k2SaeBd1Mt4cjcp7i
	A6NVvoTETjj+JvnlwpauMEHES5CNKbDLCzg509GV9nU=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Wed, 9 Jul 2025 09:31:31 +0200
Subject: [PATCH v2] ARM: dts: imx6-litesom: Replace license text comment
 with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250709-litesom-dts-lic-v2-1-b907084ced96@prolan.hu>
X-B4-Tracking: v=1; b=H4sIANIabmgC/3WNwQ7CIBBEf6XZs2sAMY2e/A/TA5StkLTQsNhom
 v67tHdv85KZeSsw5UAM92aFTEvgkGIFdWqg9ya+CIOrDEqoq2iFwjEU4jShK1xzj8bd2laTdXR
 xUFdzpiF8jsdnV9kaJrTZxN7vP5PhQnkv+sAl5e9hXuRe/y9ZJErUQpJ2Uks7iMec02ji2b+h2
 7btB2ePFS3HAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Marcin Niestroj <m.niestroj@grinn-global.com>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
X-Mailer: b4 0.13.0
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752046297;VERSION=7994;MC=3525334923;ID=156592;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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

Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
Changes in v2:
- Fix msg
- Link to v1: https://lore.kernel.org/r/20250702-litesom-dts-lic-v1-1-401e4d141bf0@prolan.hu
---
 arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts | 38 +-------------------------
 arch/arm/boot/dts/nxp/imx/imx6ul-litesom.dtsi  | 38 +-------------------------
 2 files changed, 2 insertions(+), 74 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts
index 5e62272acfba..7a4127670a6f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts
@@ -1,44 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright 2016 Grinn
  *
  * Author: Marcin Niestroj <m.niestroj@grinn-global.com>
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
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-litesom.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-litesom.dtsi
index 8d6893210842..c387753f833b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-litesom.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-litesom.dtsi
@@ -1,44 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright 2016 Grinn
  *
  * Author: Marcin Niestroj <m.niestroj@grinn-global.com>
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
 
 #include "imx6ul.dtsi"

---
base-commit: 66701750d5565c574af42bef0b789ce0203e3071
change-id: 20250702-litesom-dts-lic-ad9774ebde3d

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



