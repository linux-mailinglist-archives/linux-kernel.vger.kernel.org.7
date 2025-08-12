Return-Path: <linux-kernel+bounces-765450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B25B235E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898DE586BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690CD2FFDD0;
	Tue, 12 Aug 2025 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="dyvn+s7M"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7BE2FDC53;
	Tue, 12 Aug 2025 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024909; cv=none; b=g8arc/LqfA9bsSKPNeLOABy2EsF8Fq5WBfQk1wJFR11FIEF9ARgTbLpeN7jn5UsBJGys6tEGYUc4In73zVhC01TxhivxsihdslBgwhWufb4hp/1W2+QhMjlnjOWtZll0ZFsFqcKT5Fxxpc7Yl6lW2xw8wEOptfrZHwHM52c4YIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024909; c=relaxed/simple;
	bh=RB8juClNq+aUYJhxBRZpy7smEVp+4C5UiPc/1AlOe6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ka+kWnXd+cZPwnOvqvx2FIp29atvfkjkL/gQE92KhzQ8tT7G8yawdbswnNsVxAVXtGij2lUQQ5CbmbsBqBNKKfR6iSjCawlt8VkhGZ7AOiKusB5+5RxQLT2kjPXbN/+Xm8f5j1mFgpp5BDT7irJAkfAd3w2I2CIueFjqbPMBEIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=dyvn+s7M; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D056BA0BB5;
	Tue, 12 Aug 2025 20:55:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=VQvzMpdG/lpDTyZqOGMb
	FkyGK3P4E/gLIvxpQQf0iBg=; b=dyvn+s7MbM0E93Kh+8Dd9hGfbVtIn68AHHA+
	Lwl0vGRI/Ud5UQS+gM8S5p0PQ4HOarMaafnJioqPfLzPAeLV3pGzJVQOrHLshQ60
	u75I2HleiKI/hJPiA+4q5SleaDekEtBmju3SgcL4FcZVael4i1vCpIbxoSXE6zgN
	W/0BoV6+PMaC7G5GyQL1ZLLrX/59Z6Xu54UypCVrAqHLLlxY1FXqwTxIvAPKTFGT
	Ora1BirVP0vbpTOZt5lLGQTvvAdozso/FxB78E5h4FzVqmMkAhqwFLQjYF2WxP9O
	EyFtLDMuyAFLJt4/slnaeoq86VJxKWJnwObKhmwodjJeOARf2QBUEU/dDoFK8yuw
	dR38A2wf+dv5eokKYTg3evAjFaschTt5PATONZIXMB8/OT6RmLyenebMYhgDxUuD
	QsT1K93VBnJNqfVQEc5k0RkT1ycASLVBTkRxzIT+PFxtUFvsYpx4o/WGiQIMaT01
	glh67zHbzZLbBrD5jguH39ZJAsVFkNdybnINxX+6ZVksLeW0lL+pPAo1iz6N9QWN
	lPXK8mkQHY1o4043Slupz/jjmrRnTaZ4dII4+FgQrlpqsVVVKEJV+NW/j2uO5alo
	3JivW7k2dKtVs80JctVI9vFcCeFNBeGNbwNXXaoa+RrqBVnnxM1D1zB2/py5ugVA
	FwFEFxg=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Tue, 12 Aug 2025 20:54:43 +0200
Subject: [PATCH v3 1/2] ARM: dts: imx6-compulab: Replace license text
 comment with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250812-clab-dts-lic-v3-1-bf7aa5462766@prolan.hu>
References: <20250812-clab-dts-lic-v3-0-bf7aa5462766@prolan.hu>
In-Reply-To: <20250812-clab-dts-lic-v3-0-bf7aa5462766@prolan.hu>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Igor Grinberg
	<grinberg@compulab.co.il>, Ilya Ledvich <ilya@compulab.co.il>, "Valentin
 Raevsky" <valentin@compulab.co.il>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755024903;VERSION=7995;MC=2213591864;ID=1014993;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E617465

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
 arch/arm/boot/dts/nxp/imx/imx7d-sbc-imx7.dts    |  6 +---
 3 files changed, 3 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
index 299106fbe51c4ac1e9e0a70a4ec12e16b8110497..e1161a750d603ff2f9083def003a96ce97dc4222 100644
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
index 713483c39c9d0e893a1ebb2eeb3091120471a623..a0e73e71ec5d1986f9174fc65d48a02cc49364e9 100644
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
index f8a868552707124b3e1a86d074c62718927c3805..cc231dafa92e0999b94aab3db96cf99ce071a2c2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-sbc-imx7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-sbc-imx7.dts
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Support for CompuLab SBC-iMX7 Single Board Computer
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



