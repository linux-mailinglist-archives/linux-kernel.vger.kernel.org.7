Return-Path: <linux-kernel+bounces-768188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 869C0B25DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D864F1C875DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5042E54A0;
	Thu, 14 Aug 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="QJ3pIdjS"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357012E2F1D;
	Thu, 14 Aug 2025 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157683; cv=none; b=slh9d63nzlOa1kC9E6HUxTELKlaFRRZqHqm2SKxP422YUyfOsuQdgsqMB5GMx9KSrrhHqHPULBZoGZ+qDRFIiSvRKdv9WaMaFsqYiloUBv1n0GuoFAI0w6m7fH9T0aM4/crlz2YViYmg08FhO1E6p98xiH/NRoYxp2KvNlolWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157683; c=relaxed/simple;
	bh=Iw7HAs6rSBnNRlmcHMEH/R55LWtd2r5t0gHDhIivMCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JCXlIutYkhWt9MDO668WBoX71fF5Nr0kGkVkSsFWUFl5hTP85dxWut9ONFJCWLwnkut0XplnTcbRwXYainZSiIgIH2pM2q/tDKpebP/6mMgVfXMMYa9YVd0Jb1/vdNWuI1BBlYf4tKophrwJCjj2gOopnpKtT3Q0L8hwjco1U1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=QJ3pIdjS; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 59DC2A05FE;
	Thu, 14 Aug 2025 09:47:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=bzwhe6wx91tLEyKuA/da
	oDX+QZG0jTUxkCfGQJGuvzk=; b=QJ3pIdjSku+r0medOnyWGWX+Bxo16aWmhsXJ
	lnB4jnXJSgu6HUA7HiC6kjJHgxEv950CVpAbeLRDw+B/E+gOMe5fbMFUmEWZBk//
	L9ve0QSY8vXOfUkJpuewPXMkST6+lPCDZ0VYMcblByDFfEk+Q3O0ALIWysFnsZsD
	7t1XAQ89vSiGXW9RMlTX+14LbqmVQGyuxvT8WSuiNieMwa/52kbLRSZafT0FisG7
	ba09JC4U+2T7bICpQvQNuV3s2HXnGAFGa6jXfQb1vM2wcmXJ6mysTd8Q/kWZkWL7
	Bg8NACqoxKFYHEnFYqcx5Jcl2L9pSuSwUhelUkQkvWeptDyLB9wkiyF/a2H/8ZmE
	H3jRXsWoPZnyfCVrhP0mqAfsnrg88EXsBGyfmsGVDk7eJE8JsjPDjDjs03OqsGeX
	IXHuX05e0EVaSy/k5Q4/+q0CMSo1Up1kShPysioFFtpvP1T9YEVrXHd0vkQ6u+y9
	VWcGw97NBPhRB/EbZTP6uxvcztwg27eCsNgQyzjLeqIBwWxaKuJ3PRMD9Z/grxmG
	n3zH0IxVIgHrBfJ4pclW3KMyY1iWxRbU2CkQ86KAReuWQoPB20PuNa5C1v8AVECg
	Eo5gSX+DasCA4E3DYp+3ArF+GreTBQpylXfV/8HEtE62OTRN6gkRixsjGmyJDwPz
	GX4tiAU=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Thu, 14 Aug 2025 09:47:47 +0200
Subject: [PATCH v2 5/8] ARM: dts: imx6-marsboard: Replace license text
 comment with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250814-imx-misc-dts-lic-v2-5-faff7db49a5f@prolan.hu>
References: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
In-Reply-To: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Sergio Prado
	<sergio.prado@e-labworks.com>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755157669;VERSION=7995;MC=851896819;ID=1088345;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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

Cc: Sergio Prado <sergio.prado@e-labworks.com>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/nxp/imx/imx6q-marsboard.dts | 38 +--------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-marsboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-marsboard.dts
index 2c9961333b0a8656b648c7a848b6c20db61f790e..37de44d1b84be1c578fa7d51a7ff86071dcae13a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-marsboard.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-marsboard.dts
@@ -1,42 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright (C) 2016 Sergio Prado (sergio.prado@e-labworks.com)
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



