Return-Path: <linux-kernel+bounces-768183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B49B25DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B79F1C87185
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1A0288C9D;
	Thu, 14 Aug 2025 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hdqdb/y+"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ACE2D5C86;
	Thu, 14 Aug 2025 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157679; cv=none; b=u5unMKRd6Z7jYwbULFgiNZbqLF6vxFWs3Yz/7yt95fVLyvg4Lehuzyc8SadEuTLSXqLLPrInomCNk89sEfVeu6A1wND2vLTsdjdw9q0hKDE/SMNIXPFKsrArJ7rZsqqWgobYnL43xJOBBbphXwDHBMjLK8q9vo0sUoCDa2lEKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157679; c=relaxed/simple;
	bh=GeVu6uM/4tdVwYkz8tbsf4Jb/AwQtJauZvsoGMPc064=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YcVMHx81b1wR0MqXFmV5LZxFTycT0Xk1kLoKw55kbqIo/OJsjJBvT60Uc3hJCXs+JBMmwOZYh7cyXZVXAgoWn5WD6z0Zcsv6JDaVII0oObyTkYv8/98yz9XfLJh3HE5hENfvK+rOm3QqHIEE9CxE4W9hRAisD8g2q7G+SpG/Dvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hdqdb/y+; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 806A1A0C24;
	Thu, 14 Aug 2025 09:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=5WROBXDUdvPcUQzLxywu
	NcwJQ4ygTXe/a0Y+F+T+8IY=; b=hdqdb/y+IO8YdbM6ssmNO8OkDn/+miE6EALy
	b8/OAOkDoOggGprTul+XnAv229bwLGSTx9GBHFTvKxJme6bpC4t8gmdwf3ebExCU
	dO3R/IbEYnGVAsVZDaVyRjD1B8O1dvOy9jdRZEOhhawfProO4cb3rxRqcsEYfh0P
	FJioxamO9R+Ys2Xlw+7smXVSWEc77gNlnXbrQpAdW+JLSdoPFnA1lWEsCS0a1yAT
	/KdC8vrpqSAHK1DGxVZiIimzpxQjJuz5moEaZD1SAiOehKbsHbBuBJcLxpwQzQ5M
	5M+MrzH08+yHvgFBuGvhPKRjXzGnhABqU5w0ilHHvgzcWdIAjVjw0lbtSFcEHYps
	qU4hyAvT0qzJ/80Z6T36N3uuM9jHYDbYfUspSzEX1Uj2tDUB1TLc5m2lGG6TgHLl
	oem5zC9p1Y6/vgNXhIY+BgBYzhJaCvrRVOIoWZoiHLDYO61WX3qXuxrnZiRW2pRq
	7inpFpX5pzBqCU5ZNn0mI9r1iPR8TSkDiMHTpcsmo9oDv/+MSbmT8/TXTOYHgo0I
	b7drU1h4lZLMnYT2TVcTljpBznXZLzglQiGKtqL7YhY4GJPvKwivegWV5weC1SW9
	aCe9A4b5zHQE8wIKbuj7vLN35dzZl5AJuBKXl4SwYmStYzFXYLgkuwWSSqijaRVj
	dPuRe+I=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Thu, 14 Aug 2025 09:47:43 +0200
Subject: [PATCH v2 1/8] ARM: dts: imx53-ppd: Replace license text comment
 with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250814-imx-misc-dts-lic-v2-1-faff7db49a5f@prolan.hu>
References: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
In-Reply-To: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Fabien Lahoudere
	<fabienlahoudere.pro@gmail.com>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755157668;VERSION=7995;MC=3219109158;ID=1088341;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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

Cc: Fabien Lahoudere <fabienlahoudere.pro@gmail.com>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/nxp/imx/imx53-ppd.dts | 38 +--------------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx53-ppd.dts b/arch/arm/boot/dts/nxp/imx/imx53-ppd.dts
index 2892e457fea7ef79ac5877f0a3c893f29b614fdf..8c1c15bf7becaaab808ddfd5dfc1eb4a9b75930c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-ppd.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx53-ppd.dts
@@ -1,42 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright 2014 General Electric Company
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



