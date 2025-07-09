Return-Path: <linux-kernel+bounces-722998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFF2AFE18A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51901BC090C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B8273D9D;
	Wed,  9 Jul 2025 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="mbX82a42"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D14271446;
	Wed,  9 Jul 2025 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046945; cv=none; b=crrSihqfZK2gaIjhc+jY0MdkhhtJh9XvkSUvO58E0L3mG/cFV4UnbABKki6D0r6FlXtzNyVbhZZ1KH6QNvCIdhgCAK+X3tMmz2HT5TYkbe4N/2/bjw7lhZtcmXyy64iHoK9TeFchM6U7bs0BVZCW0v4Sz4XjimgSayOSTqUD8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046945; c=relaxed/simple;
	bh=sn6+L9T8LXlwEPq95mr2h5m46SbrPvXWFYmA5PdDErI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AS3TiSUnXfc7edjemjbOTN3qIgQkB3auksiFjUvziX5nUC5cEeoXNTLFu+hwKQCBp+TciZrQnO5LApdn9aF4W2A3t4oJ8v8EeqBZRt1mwvIDG/QPiPo9oxmu2Gt7bU4gvcpphs3YFuIAcmWNFur+QsEO3OSfue+tg1u6dP8vjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=mbX82a42; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 4FA0FA0ADA;
	Wed,  9 Jul 2025 09:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ZLkoBW4KcjWj0y/G1Sqx
	Iam+xOIBFXwFZtg/dcSN0sM=; b=mbX82a42k6kCLeTb8swKYWk9JOW9APbk9JtK
	P4LLU8jHxUixXajRW+3Gy3ZtrGil8EH/OuUKinvpDuhVmHIcEbjtQ7YFQ3+xnixF
	tDXrH0y+gfnaH7b4g3nezGlF1cr0ammTmb2fWP3v7HnaeDhdZI4nqQvxek24Fn07
	l0kSzvCb/I5nu4nHoItwphCYwIi7hRGylCMjFyob/uEqRH5JVZf1/0k2AdbgJ9HN
	vCTlymCgxXvXjxRXJNKtK2Ot4NVY8pQX5apDXDs+mJT3pKuDUDx0jov0uFVxmSAM
	rM8seh3KRNHsiBpSlJPqJB3ankRJdRwiWBBgrdKOtt+YAoJjXwvcgT9hwue6vwO5
	lPj/pzmYFY+ILsZWgijPqSkE31vRBaUeDwWy1r1UYiAAyct0A1nsN/oi+kBY1bsr
	rVeOd2QU/s5meHVTbwvXwsdo8iqDzFka7rKl8pvp9NX2oGq5jIDUvr8p1+wMtC7q
	uegsXvlHx1HeZZCHTSW1S6YsIDbkP1pGcIg53ebmcBSKoO8CRUqBXN8K8G4pKryx
	W97rK4e7pE2HyrWWok3RyRSDrHuCmCn1TVHMgXTc1u+VoXwK9TMR0BSOTXPBln9G
	bZDs/YSW22UjgU2A3oNvGPMzRUFR9qD57IQHF+w7V/eMTTIWcDS9hDZuvircpEt+
	Q0HXLqc=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Wed, 9 Jul 2025 09:42:02 +0200
Subject: [PATCH v3 2/2] ARM: dts: imx6q-h100: Replace license text comment
 with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250709-sr-som-dts-lic-v3-2-51fcbd61aef1@prolan.hu>
References: <20250709-sr-som-dts-lic-v3-0-51fcbd61aef1@prolan.hu>
In-Reply-To: <20250709-sr-som-dts-lic-v3-0-51fcbd61aef1@prolan.hu>
To: Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
X-Mailer: b4 0.13.0
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752046939;VERSION=7994;MC=1202330779;ID=98590;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E657160

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
index 46e011a363e8..c6161546a34e 100644
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



