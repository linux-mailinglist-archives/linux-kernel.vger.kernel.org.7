Return-Path: <linux-kernel+bounces-722988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E48AFE16B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CE1189CF9D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563D7272E63;
	Wed,  9 Jul 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="q+JLsAhH"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CBF2701CF;
	Wed,  9 Jul 2025 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046569; cv=none; b=RcpkGV6eU8dzZfbCAPqlO0UQsay6WekFBQimEJblVr8zI1vQ/LwQZMV/Dr6hPJH6vqyuhnKk95HBu1JHa+rVGXT8j3dZn0Yr3fmEGveO+GPMRwX3XB+SHbo0Xh6E4H+pnHBcVdte5XujJ4RrxQFE3iAeM7FyTFfHnrF4Gny1bdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046569; c=relaxed/simple;
	bh=4nsS6LpCAMn3RqiFq29BM4cPdciljmDA3zwX/7A3V14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RTsNvHxif10JDjQHp7/56vIDR7g2ppVIQCYgeiBvJuUnJmU3JIXw63Afr2dvQloBuX5Qg5CFgNnr4hKrFnyIKw47RnQC7D/k6NZqOTpOKfRaUxVF6lWD9+/KUxnpJ8uBrdBEE5J6YRbNx/PTfTPHXoZY/Cna9j7rvKiP1ND3wq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=q+JLsAhH; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 05572A0AED;
	Wed,  9 Jul 2025 09:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=naDAgVEz0v6CFo6A5lww
	bZ4ycQOU+YuKAc76hTSp4NY=; b=q+JLsAhHPG7Slqcbgdyd17dfe5IIAec8r90q
	eaYUvt49jalar9TDNa4/nzUjekUnmMO+JHO9yBh58zvGp15d+9DbeQ01PfSV0xlp
	VUxEb7K5Q+oetM76i6+2aTmGjHztFF+7MxcBfytOvM5E2v5nXzRUooKeYBcmUBp3
	COOO0MhZh74Y/FF9+2OLdlRtvN322+/fEfw7zAlgKwBUPANHYnredp0LGILsG7PJ
	P09QgOf7TiVWj8nhDO1EMmGAlnCXcclGe2i2a0ZKVUvLi+wNredAEcFSca08pt9Y
	ferfpB+dwB66JwN1mRc2tpO3LEplSuaoEe6rHVol2Szfi+754LtBrpW/6GxPA5nm
	4WmJs2B/55Q8I7o3VA2qqvv2jrVElwFOD0yDyBGl6Hikqbj7rE8TMcEH81zsI4na
	UvB+Ig/T+WoDv9D/p0Ja4PAkCKo6mPO7EY+YEHaE35T4zZV/HFTRXaDnCIBINVsu
	ot2BsGJvKmKrEK1sA6iH6L030IKe1tOXUtPWjtlTA0i7M2tL++tbGRPKhjAyFeLe
	SI/iAjPMcdneGjabqpX+UC2hzL6kF0VAskAvryINAFq8AANjWIOALyIy1x0rIPNQ
	x1bnL1Gx3LowKIc89MzKpkGNl3y9s4zvWKuEy1LX4xYopxzC/kaYHKmRImccaR0E
	NtTNU/8=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Wed, 9 Jul 2025 09:35:43 +0200
Subject: [PATCH v2 2/2] ARM: dts: imx6-utilite: Replace license text
 comment with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250709-clab-dts-lic-v2-2-ae14e0fd0bf3@prolan.hu>
References: <20250709-clab-dts-lic-v2-0-ae14e0fd0bf3@prolan.hu>
In-Reply-To: <20250709-clab-dts-lic-v2-0-ae14e0fd0bf3@prolan.hu>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Christopher
 Spinrath" <christopher.spinrath@rwth-aachen.de>
X-Mailer: b4 0.13.0
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752046565;VERSION=7994;MC=1895809622;ID=156668;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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

Cc: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts | 39 +------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts b/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
index aae81feee00d..f7ba19141ffb 100644
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



