Return-Path: <linux-kernel+bounces-807219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6723EB4A1BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A18A7A2ACB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC53009D5;
	Tue,  9 Sep 2025 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="StZn9836"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA712F3C30;
	Tue,  9 Sep 2025 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397805; cv=none; b=k/ROEE2ixW5B5kv2LL4QSa3ZuP4rIwRmNe3brcmZqsSWXwqS+tKoq+EPZL6ARH9n6Jhcwdwx2YzFx/mtytCArvDSacUeGva5UUMrtNT9RZqZI4cWUP+n16Ulf1Fo73KfkHENWuCeTaU74nwI58xXkHPyUhyQLnFxv17Tr/iAwfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397805; c=relaxed/simple;
	bh=H5k8uPZvJMzYH8U4tK6rrXQNNgQdzSg6be4wefv7iRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=f/NaBm08quxYrnG7jMPuu94INaJXk3UBzStUXwZznA6iaQJxLFDSTOc2eqFi76gmwsBBjCajmK/2b+HO3iJyzUkTwQh/YkHnHIcl5S8gtjChTHiXECjgjFPzSffZZ2fBqDH6mujGNSrqEO7q3HIT10ft6eRs1+aYEjks2cYsHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=StZn9836; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 47FAAA0B10;
	Tue,  9 Sep 2025 08:03:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=j3hayuDfHkSiaf21en8K
	8f18jrvM/67ABIR7N++0snw=; b=StZn9836bpGmTgRW/uCNuPgevJ7Qautq0os1
	/tLNoFtb9Ps7d3mDuQR0dWWakYzAHUzoIaM1QTCrwTAdjt3yK3/HsVHebJgd5Zs4
	CTuuoF5273HUXpV7wgiLNgKt/Rh5Sa7dEuxoUr6Gi1g+m7nuVIDcRkTh8pkTqZjO
	ivNLMnb0QsoCcttN+o/F0BTyva3k7LGZJ/1JCNhfc2aH5GKHlQ2D4Egpm3qGsR8I
	Ew/pvyUhX7kAK4XIX5RitvmnQjUvfkPayuJZ2RfqtVEfEHx13wY2y+Fj/WqwHYq6
	eKcu0RMB0FWfbwl4KJu4T07jE81GX0Gq8eFFE6Yj0+BjtlMlFq/rcrFt/OZr3TDD
	3hRzbi7HClNiU0DlC5Krza95LK8gBn+za018pDZNflXsc0Mnmn8FsGGAMe91FvFF
	eyAWJryoOtQCM2JXtNbKKZ8EsEVgNd5ifGCzT19tkg+eakMnqCHjIry4CLNHxNCa
	SQd8vnQbYC314mtuzDwjNXWh6fBmrFblsF/QBdGv2GomvPlfCiTGwE7f93P/suwV
	VzHa2V12071Rbt33jO04FIE15uI9wPsS3OOyjjJKkhfdhJQg/w5M/8Aipyvz++7L
	F05XA1yKHlZ9KGa66cKBr86+hqdp8EqOcu8q70skXre7nrdzuyUFz8POmlY5GdAi
	ibxwMec=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Tue, 9 Sep 2025 08:03:12 +0200
Subject: [PATCH v4 3/3] ARM: dts: imx6q-h100: Replace license text comment
 with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250909-sr-som-dts-lic-v4-3-02f4e0e440fb@prolan.hu>
References: <20250909-sr-som-dts-lic-v4-0-02f4e0e440fb@prolan.hu>
In-Reply-To: <20250909-sr-som-dts-lic-v4-0-02f4e0e440fb@prolan.hu>
To: Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Rabeeh Khoury <rabeeh@solid-run.com>, =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?=
	<csokas.bence@prolan.hu>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1757397799;VERSION=7998;MC=2184406358;ID=61061;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E627462

Replace verbatim license text with a `SPDX-License-Identifier`.

The comment header mis-attributes this license to be "X11", but the
license text does not include the last line "Except as contained in this
notice, the name of the X Consortium shall not be used in advertising or
otherwise to promote the sale, use or other dealings in this Software
without prior written authorization from the X Consortium.". Therefore,
this license is actually equivalent to the SPDX "MIT" license (confirmed
by text diffing).

Cc: Lucas Stach <kernel@pengutronix.de>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/nxp/imx/imx6q-h100.dts | 38 +-------------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-h100.dts b/arch/arm/boot/dts/nxp/imx/imx6q-h100.dts
index 46e011a363e8827e84008dead0390a5e9548ffd0..c6161546a34e16cc9cdc9fe08a569c8c1d8ceb11 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-h100.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-h100.dts
@@ -1,42 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright (C) 2015 Lucas Stach <kernel@pengutronix.de>
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

-- 
2.43.0



