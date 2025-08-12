Return-Path: <linux-kernel+bounces-765449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E841B23615
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8876E40EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688C52FF16C;
	Tue, 12 Aug 2025 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Esv8hrOE"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D72FE57E;
	Tue, 12 Aug 2025 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024908; cv=none; b=D+scHlkl7kzS9mY3e1FOyOzgR/GV5+oSyyM7CVdDSXCnoHlRjYMsbXRH+r69vPI+xYpof4WpOiYKs042743iY+jDkBChRAB6SC92E0AQpVfcSXa8nrNAW+sbPSmsBLDOsyvBXm1KxlpxLFSezL7jYjVWiWQQV3jlfhjlWTSTY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024908; c=relaxed/simple;
	bh=7PhDiTML2Leu6mAZAooPW7UR7XwEZjCvYHbSTEynN8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WYKJIdkKr5QIS6LD7T3+VSywE1AfV4jdkEp4m06V8JS8wgIEV/TYCAnyCHfA6UARv2WKBdtuh9e3EDgdOVMFjP59ZWPffU9AMuKjEr+XIKgSOjrWk0HLVLSsbA3w/58A7dagWEMQb7SB/bzY/kHDmH/EqMzkMA67B9wPUEovQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Esv8hrOE; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id EC733A09CA;
	Tue, 12 Aug 2025 20:55:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=wCnuwYNdbOLXRQStadB5
	ZhpjYXYSEvPGQdAZSpeQblY=; b=Esv8hrOE8VaDXHhKzo4wS30ry+q1SjiBDOvl
	8iTup1pIRTj3lX1msjbxwSGDJRc3BGduJEgZ4qbW1Qq6beoiiZGUHrkIWschKGqw
	O1UODUtF5tcCnn9uQQjGGyathNxxeSFYsjkqenh0kz5jmJIgT/MXBvLO2gtST2cW
	gxGhkC0nAIztR3Y+MSY6petwGAt9VFr9/W5z6snx+dj4rkPMdsRWEEYLPsocNFTy
	LsrBRlR9dxC1AfHMVP5LBbc5jYADj3zMMEaA6W2icnKX8PDAMSERYDEgawWT9Chz
	KP5m4jWS5dkwF3h+APGFXjyKxPaEVpfh1myETVlPj9Ngc2NVtXhrIXC7gY+umsVt
	vEEYOQb6ZVjgl+fOQPi3o/Utl70anBOmFNCsvPBecG9cWOLDC4M4NKplgs2oiIwb
	KQOWWkXbX7FdhvJdQNSsUNmYX8K3hKVslroxieEjDt7iAUC+7NosDZU7JHZ8zCO9
	9dq/HLOnOEzaGelBfE/4wvwwYBIFIje9diG8nyw7lEZCSGrR7k983JGnKH+7Z7he
	BMzyHpr/8VsbFSfdC0GYMjqfnwKUUqCsM2yeOUg7WyWG0G69X/MGclmR1ONZLmOw
	1vHwmJhz3fKla6GEfy4fpp6DbOUEiSYFsLB3sA7QsIX7tQ9HCN0MsuMRdICrH4wu
	J5pc9xs=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Tue, 12 Aug 2025 20:54:44 +0200
Subject: [PATCH v3 2/2] ARM: dts: imx6-utilite: Replace license text
 comment with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250812-clab-dts-lic-v3-2-bf7aa5462766@prolan.hu>
References: <20250812-clab-dts-lic-v3-0-bf7aa5462766@prolan.hu>
In-Reply-To: <20250812-clab-dts-lic-v3-0-bf7aa5462766@prolan.hu>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Christopher
 Spinrath" <christopher.spinrath@rwth-aachen.de>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755024904;VERSION=7995;MC=4075309719;ID=1014994;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E617465

Replace verbatim license text with a `SPDX-License-Identifier`.

The comment header mis-attributes this license to be "X11", but the
license text does not include the last line "Except as contained in this
notice, the name of the X Consortium shall not be used in advertising or
otherwise to promote the sale, use or other dealings in this Software
without prior written authorization from the X Consortium.". Therefore,
this license is actually equivalent to the SPDX "MIT" license (confirmed
by text diffing).

Cc: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts | 39 +------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts b/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
index aae81feee00dba2761f140fc2a76a828f69a8308..f7ba19141ffb70a811b78537a7149333e52b054a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
  * Copyright 2013 CompuLab Ltd.
  * Copyright 2016 Christopher Spinrath
@@ -6,44 +7,6 @@
  * Utilite Pro:
  *	Copyright 2013 CompuLab Ltd.
  *	Author: Valentin Raevsky <valentin@compulab.co.il>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
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
  */
 
 #include <dt-bindings/input/input.h>

-- 
2.43.0



