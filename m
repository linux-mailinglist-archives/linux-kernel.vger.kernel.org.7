Return-Path: <linux-kernel+bounces-768184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5670B25DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AF51C87E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BEE2405F8;
	Thu, 14 Aug 2025 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="rT2moRWi"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A40728C03D;
	Thu, 14 Aug 2025 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157680; cv=none; b=RVBle7XJL4i1Ahpaby1rVcmpBB0vMuugu62SSKT5QfEyAB58Zuka/ZZf1I1E0lRghnl/ET8Gmx/0wiFhrw3lXMyL30WNILHFIEdZbEp1kdbQsPkUocoLYa7vJVGvz1iX8VoeoF/tyGMAqc23jm8cD9ljAvmyBO16D2WxPDDLKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157680; c=relaxed/simple;
	bh=wxuKAb6q4iGhEPqbftzHO0G/sNXjz8XjKdVik2LXr2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dTTXtQUs/i4sZxBdJ1eN1clWhO3sMYoejJCggLx3qq2AbLdcXrG21BNnVWbYh0iPuKfUUZoSOQ0wuh3e0qN9MOCAM4PkZbSTHiASqp6ZYH8ZaSm3n+MrdypNU2cDafgD3NZMZA8rJ1ZVla+wjIlE7txK5qUEbhckLeN9ju9cYyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=rT2moRWi; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id EFEACA0255;
	Thu, 14 Aug 2025 09:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=bYZQGMIsBZJ6zesK/ZZP
	s9ypTUtEAFj7kefQq0k9z90=; b=rT2moRWiJtxd9erkYOaIuYXi9kY+9/GFH8MG
	aIm8VrOfhQxfVKCkj6IjpNfZ/abglSiJ4h0MX7CTZcGJExz/nJiXg3rEiCiNxZh2
	g0EoWOaQjKIwrKU/nKaSbJG2ZmVVyIHWnhkeYsFqQdD7zG0a8AFKFEMJzQxqC79N
	LUfKTRvDi8veKf6jiNionLhuyRaYClRv13YgOqpUiPKh40gZmGhRWL/lSVw6xXs3
	rfAKzaePCxKpQ5HY9qBp0sigePLtgwe0sBRW5gDJ9glHt3WTwNqWr+56NhyiVJn8
	+y7ogRgd3ciVtJBj1fBcHjrXLFNr4ON9A3a2ACEWa6hTAGbk/yiLJgOXeZVlbc6v
	8maZIB3/ZgmewWPMjM/SZmdl4uwHg0s4yHgPL0ThryHYoHJqVyPkG56RM+Xn8GWU
	l5nm3qxW9begVmF02CNbPKzgRrNdoVcuI4iP2Fnecggyj4m1jUEb8WiZ9YpRdGym
	sH+sj0Liv3iO//0KZcTtbLz86D+OtKUEkQpE6Cg6CeevZM72hTSM2Hweng63hxrw
	tgUeV4BldKCRQ3TGzHbp7blMwuTp7mg9plETNPEzP4EcZ3Ofh2nDXYV9oqgztseY
	TjwJ1Td3LSWclWh8EkgEaBiXXK/KPkaf2b0LiiBYQ2xN4OyK8XLFpRZJ4JrQy65u
	Hd8G9lg=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Thu, 14 Aug 2025 09:47:45 +0200
Subject: [PATCH v2 3/8] ARM: dts: imx6-sabrelite: Replace license text
 comment with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250814-imx-misc-dts-lic-v2-3-faff7db49a5f@prolan.hu>
References: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
In-Reply-To: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Troy Kisky
	<troykiskyboundary@gmail.com>, Gary Bisson <gary.bisson@ezurio.com>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755157669;VERSION=7995;MC=1443896893;ID=1088343;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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

Cc: Troy Kisky <troykiskyboundary@gmail.com>
Cc: Gary Bisson <gary.bisson@ezurio.com>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-sabrelite.dts | 38 +-------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-sabrelite.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-sabrelite.dts
index 33040761b253ae704c57797a1d04589094a7c7db..c0771645cad78f22e1bafff77fd29069d4db4c65 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-sabrelite.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-sabrelite.dts
@@ -1,43 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright 2011 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
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



