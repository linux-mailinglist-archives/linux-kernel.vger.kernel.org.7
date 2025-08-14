Return-Path: <linux-kernel+bounces-768191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CD0B25DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745DD7B9771
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566972E7BD4;
	Thu, 14 Aug 2025 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="DMJ2TZxk"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31CF2E543D;
	Thu, 14 Aug 2025 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157684; cv=none; b=hC1qMlCxkXnF/J5uI47cM/d4ab8Vt/8EcSvSRVJnaO6JpZHkyoB1sq0mb1F28H4Z8DL0SbXvgln+Pdp8A0pG/t7aG/vYBpanQUCKQOZnVv25hNI7gc7I2wv0AZuslbrzk/BxXMwS3Hn0PreFLJHUQ4v+vdApK6r1DFifhIOZH28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157684; c=relaxed/simple;
	bh=Ys8S9Gi2tWS0ibhv9GaGHjXPzKWi37q6DTGo4n9wQ58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=j2sqgF2+bFDx77Oeynw+lNU30OjQZRMmzvTQstdl5eMtA5u9t90Wce0IeRVzwIdNA8i3t2zyFV3b5Tq4rOi8+Wyb7MdMV5ZXBLCXxTylY7TZQSRE2arH9pqWFXS7336wnKbZLKy8ZEYCdsIYisa54dg5eEI8f0NdgZaKwmadZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=DMJ2TZxk; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 004D1A0F98;
	Thu, 14 Aug 2025 09:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Jd+mW0dqDBBNJFPpLDeq
	YPCWuu1dhZ7cjyPln0mpEfo=; b=DMJ2TZxkHpKPFgOJTdF1CzOMsBy3itSpvwTF
	blsfCORJF6FUU/gmybuRsg0wBY47dgdGX8WLLvRFeFU+6i7+hT6YduGJoR9oh7rP
	nS3w7XMjtEQu1evodDNQ8ofq3fd9AIqz0KNq1NZ5qLtMlu9HC/GhBVkbc5expFld
	Ie3wQrxab/BOgnQwcgDBXtA94+89afMNsdDxii03SVcODvo1QY4YauAdSMrw08n8
	ZD7n0Uz/syC4hgiOSYFhPutL6kMc96smA8976YURK5uAIH2UXaaPhI+ubV739WtX
	h2E0Ez3A7PD+8gj5FPiZNfXrpqunzmk72/YqDTne5C4eFNOUGNGKC87mZ8pL24LP
	YC66begiOvIjOEaffJstP0DP7ACmti4JeWjf1Xf/waxOvFFi9VRbTF5cYz9qoX0m
	vfLSOQDHfiKpB4AVUegyJpfuZ93sqKw0djpW6LZ/z7Z378m32cI4TXAE5IUTpQ6s
	lWCv9LoI/SGzSLUQ7M9DdqGW8SN+uJlDyLuWAUXeJ0KQlfLneNoz29v4FoIp3LSm
	c/27WXbZcROAZDGXEp21D9P0lV5ZbLJMmowu17VOZlY+ocXsrEQ31PpqioYUwZlc
	rEQprMA/k/Ht9/SfzLN3k2UivX8BTQq0e8uhLfXbc+Dcj+f8hT0JwmeQrEaGGGeS
	e6CYP2U=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Thu, 14 Aug 2025 09:47:50 +0200
Subject: [PATCH v2 8/8] ARM: dts: imx6-warp: Replace license text comment
 with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250814-imx-misc-dts-lic-v2-8-faff7db49a5f@prolan.hu>
References: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
In-Reply-To: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Otavio Salvador
	<otavio@ossystems.com.br>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755157670;VERSION=7995;MC=2051148838;ID=1088348;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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

Cc: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/nxp/imx/imx6sl-warp.dts | 44 +------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sl-warp.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-warp.dts
index a5d48c38231467cbb6ecbfaae47c17b68b7d46cb..da58477ae80d27a4d52adc772e83addd8186fec4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sl-warp.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sl-warp.dts
@@ -1,48 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
  * Copyright 2014, 2015 O.S. Systems Software LTDA.
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
  */
 
 /dts-v1/;

-- 
2.43.0



