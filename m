Return-Path: <linux-kernel+bounces-722987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E15D6AFE16A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A861B189DA67
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187E1272E50;
	Wed,  9 Jul 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="oOiQ9WVr"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD51F2BB8;
	Wed,  9 Jul 2025 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046569; cv=none; b=JrXDPOzKe+Wd/wyZkV1IRXDDah9W/5maZsQk6ONr1YMZCXMg66vmb28rGWjsxmVHzeYB8sEroP3vke25jfDiL5zMsasWO2HSgTYP6BwlobpbdPgh4NQLthTN+HuwsrcvC2Gwr2TgHfLP41bblVDPXZxmWEz8ljeR8RcfeeCRcBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046569; c=relaxed/simple;
	bh=mWTVKweSOXfstjYpxFXMh6r5pISwlzNqrdwxgHaSp1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=t8EuqSQCcZw+ry9Ti5D2vuEWI0+qLJNP1c8A5M9I2gaYd4bJOvpxrqH3yI0s2dbUwzDHsXqieMDCz/2blqU5Xo4+m4cNW5nP9b6uH6lve/b/XpKu3LYSIuTUobGTT+uDyqmjjz5Id0c5wQfhkC8kKGlr1vfwu5VsZHmgUagVsbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=oOiQ9WVr; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id EDADDA0AD0;
	Wed,  9 Jul 2025 09:36:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=KTVznTTTOElagJ2REmXi
	QMSOLI1VQpdqSAxtVGgGl38=; b=oOiQ9WVrYEFhOUipB9nC19T5HmnG6Ubn6UFB
	kXEj8X9H+tyYEjHGyfRJ9SOEiBz5Bm39zqHfqtkZgJUdWUk6mdneWbjgXSYHrXB5
	0y3/nzTr0oDzdA4lxxzDaSmsDP17sw6Tt4bb4/diqQ2ermMuM7NguaZoKm5rM7ES
	VQ+E2gs5RLaCIQE7JK+ZADzsRu1aDH2CKqOkRLbl2cj2y+bkbWLRfh7/ALX6TOiJ
	+So5U2NndnQVDIuEwsceY09GybVlUGKNHei9Iw9zgFaEXROUiocYDVK5gjvsvKnx
	KxK46V59xb8p42mtuB99xvZNKc9SfU1CfL5mt0bW2CO/zNdrN2847TecMN3oDwxI
	uO8UQ01GzO7SLlndJeMXt1UeJxZgdUCOjJUMVynZupaqqW+fpEpIQo7EpH6l0Rb/
	R4I23kHkb0eTTNiwc3d87saPpgjNme2Vk4VwJI16lpvbZVy8XmI5aF7BSULjX5aN
	2TSJ9o5D1B0cMlSGREcZ+P5f/zzZzNdrxlNRXHK25neN+giMKEo1pv7NgOre6dJJ
	/rvidBHQMTE1yIkYm+BDAxt/XVj9mp3jraZusJ4gzemB4eN0fwbWPRdlrdjCMAde
	A0aT8wD8GiBeVXUaSJVw9wGstOgLuTpyRubXwcrPbbZkKbCbW/a1X9AZOe3y1pB5
	ydyzMRM=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Wed, 9 Jul 2025 09:35:42 +0200
Subject: [PATCH v2 1/2] ARM: dts: imx6-compulab: Replace license text
 comment with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250709-clab-dts-lic-v2-1-ae14e0fd0bf3@prolan.hu>
References: <20250709-clab-dts-lic-v2-0-ae14e0fd0bf3@prolan.hu>
In-Reply-To: <20250709-clab-dts-lic-v2-0-ae14e0fd0bf3@prolan.hu>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Igor Grinberg
	<grinberg@compulab.co.il>, Ilya Ledvich <ilya@compulab.co.il>, "Valentin
 Raevsky" <valentin@compulab.co.il>
X-Mailer: b4 0.13.0
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752046565;VERSION=7994;MC=1491387272;ID=156667;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E657160

Replace verbatim license text with a `SPDX-License-Identifier`.

For imx6q-cm-fx6.dts:

The comment header mis-attributes this license to be "X11", but the
license text does not include the last line "Except as contained in this
notice, the name of the X Consortium shall not be used in advertising or
otherwise to promote the sale, use or other dealings in this Software
without prior written authorization from the X Consortium.". Therefore,
this license is actually equivalent to the SPDX "MIT" license (confirmed
by text diffing).

For the rest:

The header is cut short, there's no mention of either the GPL version,
nor what is meant by the "X11" license. That would mean a SPDX of:

  (GPL-1.0-or-later OR X11)

However, since the header seems to be a truncated version of cm-fx6's,
I'll *assume* that they meant to use the same license, but CompuLab will
have to confirm or deny this.

Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Valentin Raevsky <valentin@compulab.co.il>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts      | 38 +------------------------
 arch/arm/boot/dts/nxp/imx/imx7d-cl-som-imx7.dts |  6 +---
 arch/arm/boot/dts/nxp/imx/imx7d-sbc-imx7.dts    |  5 ----
 3 files changed, 2 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
index 299106fbe51c..e1161a750d60 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
@@ -1,44 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright 2013 CompuLab Ltd.
  *
  * Author: Valentin Raevsky <valentin@compulab.co.il>
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
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/nxp/imx/imx7d-cl-som-imx7.dts
index 713483c39c9d..a0e73e71ec5d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-cl-som-imx7.dts
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Support for CompuLab CL-SOM-iMX7 System-on-Module
  *
  * Copyright (C) 2015 CompuLab Ltd. - http://www.compulab.co.il/
  * Author: Ilya Ledvich <ilya@compulab.co.il>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-sbc-imx7.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sbc-imx7.dts
index f8a868552707..4f989c3b0ef7 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-sbc-imx7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-sbc-imx7.dts
@@ -3,11 +3,6 @@
  *
  * Copyright (C) 2015 CompuLab Ltd. - http://www.compulab.co.il/
  * Author: Ilya Ledvich <ilya@compulab.co.il>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
  */
 
 #include "imx7d-cl-som-imx7.dts"

-- 
2.43.0



