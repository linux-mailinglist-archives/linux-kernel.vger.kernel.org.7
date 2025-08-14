Return-Path: <linux-kernel+bounces-768186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED62CB25E05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2983F3B4C35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABB62E370F;
	Thu, 14 Aug 2025 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="kn5yB+OM"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D920C00B;
	Thu, 14 Aug 2025 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157680; cv=none; b=SM/tfCtjS70BP9DRKGvS3ZAzT2ES70NOKwu0FvyB19Fa0urRiN5oEFzGlnzr7XiJ755Dd5gVkGMV/rLj4XPL8owvl9AFBEaVh0b6CvFzgeyPCkpm0r8AT53FhI4AUSa1ftrvF8vftQCvK2UHEmj+IqxdWH9A7MAvtwqGrMxdQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157680; c=relaxed/simple;
	bh=LAh0MC5i+bVzKCcs6Az0+z6hqfUeTjSpyc5iykRrnTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=B3BcPtTIMJOd0yAD78c1QrPS1nCoK6nuQ1HjMWgURvMg0NSLpNo3xvIf2QtOkiOBqZIzxGqhUQ0kE8gRFQF+ybNkwk4ckBG1P9W8XA+1e44FixBf+DJLe+IW57eRGrNPwyc9qD3T+PYCGIVIbdtn7uUwKEiMuEWBhgQ2dnxyrus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=kn5yB+OM; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 8A179A0F92;
	Thu, 14 Aug 2025 09:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=mJNp+wg038R4K9WJU61O
	GOSJ2cYgVjVUP4sSaAcjd4s=; b=kn5yB+OMjQn9v8OMbXfKznI5zLAfn/Dp2rvV
	/6s8yyZPttXIUJ/6BRVgAz9iQRftRS9EVfrqr+jyacrozjG5zoOuxMXP8oC+HkqU
	FmcD4XfcayNlZyKxUEecIPb0HXL7fwZiNByz4xoGH34Xj/0QemMeJzKT38TS5wSU
	8nK9Nm6o57XPjcbrNKgZZaiBh++BgstRRRbbTH0TIRI+Y5Wt1oGnhwPsIPL/NE2g
	krxk+CVjESytxKMyz6A+YExIsRhVjv2h8vnaHTqbaZI1HLGINBpkx0VY3yJyfVZh
	7mqs5swXWXky0YvwnWAP9FdaLZXcyzlK1mpt8nngADNqi4fY5E0vrxcxW69PnBF2
	/Cw8jH1WfTayUd9K1eD6b8nnNdLTP0Ct53AO3nHWbF/U1/EJ2JAwE4pp6ro8oUq9
	BxQ9O+mvFWUYRy3OaLSH7N6NPlq8qD1RyLX1c6uJebdoxfYv/EEPoCYoQ7miuUMT
	sPCtjSE4+zzPUSIFvhJ87FVRZ9lycrykmWTEmB0KsjUIF9+edLSJHu5GlY97WIra
	VORf3P0+kkhmDCDN/PNcP+nahN0HtNjDFKQYp9wLyFW7+ngK0mF4oJr5UZivcTpU
	PJcCltevnIcTAkxxXdNFTkKcJfr+e7d4N4ht9bPQSulq8kic5gBhCK+P6PmdN1qD
	/mcGQNc=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Thu, 14 Aug 2025 09:47:44 +0200
Subject: [PATCH v2 2/8] ARM: dts: imx53-usbarmory: Replace license text
 comment with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250814-imx-misc-dts-lic-v2-2-faff7db49a5f@prolan.hu>
References: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
In-Reply-To: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Andrej Rosano
	<andrej@inversepath.com>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755157668;VERSION=7995;MC=4228736068;ID=1088342;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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

Cc: Andrej Rosano <andrej@inversepath.com>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/nxp/imx/imx53-usbarmory.dts | 39 +--------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx53-usbarmory.dts b/arch/arm/boot/dts/nxp/imx/imx53-usbarmory.dts
index acc44010d510695b28dc8e6599ba006856a89efb..3ad9db4b144254f5400ce894f99fb038e51f64f4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-usbarmory.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx53-usbarmory.dts
@@ -1,47 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
  * USB armory MkI device tree file
  * https://inversepath.com/usbarmory
  *
  * Copyright (C) 2015, Inverse Path
  * Andrej Rosano <andrej@inversepath.com>
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
 
 /dts-v1/;

-- 
2.43.0



