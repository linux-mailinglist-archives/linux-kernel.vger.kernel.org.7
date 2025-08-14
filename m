Return-Path: <linux-kernel+bounces-768190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C067B25DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055531C880F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1FB2E7659;
	Thu, 14 Aug 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="oro9ZyWT"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71072E5425;
	Thu, 14 Aug 2025 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157683; cv=none; b=IIiwPCmJyrhGkC8KKWNCJwH2NKxk6Ie2/7qs9J4IxoBzu7QfwtvMA9s7nkdnjey/dgMAVV5rGy0c8ALGDE5jXLWE6f3T/BEyVkdbVLEUJLxklcxf8OVeNnq2qQxN66OPqD222ny2mSwxnrO1xgKF2BsxFoUPLHPvs6p7rjTJQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157683; c=relaxed/simple;
	bh=pTIvuNieM0Gn0FGD9Bw9iBkRCIHB9zfapcCHBoPUr10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ToI3K7yAi4IHVSoAKerAY6qzEDzFd/wNFtu3CWU0mP02vYqTpaiTF+X3923GgZz5Y7PX0xrrZTfmv7aGTSfeCItYapTIsHnSPRm26Y0Ia4BRnnwpddKa7rYMm2xmgR53+Udel2Yu/88mgD+aaEiPilp8cnXQU7P/gl/E8CnkUlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=oro9ZyWT; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0E9E5A1132;
	Thu, 14 Aug 2025 09:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=UyWiR7bSWSXiv1vIY07I
	B8DoVLJBraEpT/JzdCabwm4=; b=oro9ZyWTwch5Vh+Bbr4Z1EpRe4k0BQJ1CA6p
	Bwd5Eqi4/t3HNj4kSXk7OZD3/bslVJgEPNbPyTCcpH+8pCB4N8hSqyp1bZvWv+ZP
	PCZR4BXEScPEIIU0cMMXffwn4lLxgTcl1+I4IzdinSNTykI1XOdRIUPGqOZ96bdJ
	nwRKlozhh3hO59DYIhAlM10HUJ83aF6OkTZXPzss9fIyB2HyftaWxILIu8V34hsM
	Vys170qBZBTcyM7/fM0U847Fus96JKO9mMZExPgZYbwh9x0k3pj7x5Z/IVhdWnkp
	/25ILOxEkVGWJ4G4sCUIpzKeK7+5YzsP5wNPk+8xIooKhOcRc6bjTz3HKYiJTdio
	8p+5k/jLS664NK52aEujus/I+mwN3COZatvHReYuaVbcbjS1Sk0+THdbCuUg5GsT
	nF7h7f2f5q41YWqdEr1SzHauCmBLw4v0LvGISu03Nelv44EZPMKKy1pxOtzIe40S
	VZN4ftn1IjK5XuPgiOQtU6qAs85vEyfi0/V+7jN95/s9SQItqv9KxgE5pyktZqnq
	Hou+mQirGii1EAjom/S572Peh94WYuaNtrC4P81YI1+ASd+XdwWJTNCf6ieObHeq
	AM/mmiV8LVN55SNHfDwdaQM3TJeGhoHdcs2+VzAoHa9Bfr9e+GdORRsjvGG3OJIn
	IbMQAJk=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Thu, 14 Aug 2025 09:47:49 +0200
Subject: [PATCH v2 7/8] ARM: dts: imx6-novena: Replace license text comment
 with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250814-imx-misc-dts-lic-v2-7-faff7db49a5f@prolan.hu>
References: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
In-Reply-To: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Sean Cross
	<xobs@kosagi.com>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755157670;VERSION=7995;MC=574094717;ID=1088347;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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

Cc: Sean Cross <xobs@kosagi.com>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/nxp/imx/imx6q-novena.dts | 45 +-----------------------------
 1 file changed, 1 insertion(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-novena.dts b/arch/arm/boot/dts/nxp/imx/imx6q-novena.dts
index 8c3a9ea8d5b34aa395b3e8a5f34896a91eff7749..fb491588082026f6cae335f7a18edb435e3298d5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-novena.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-novena.dts
@@ -1,49 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
  * Copyright 2015 Sutajio Ko-Usagi PTE LTD
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of
- *     the License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this file; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
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



