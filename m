Return-Path: <linux-kernel+bounces-722976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6834FAFE14E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DE63B4B96
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8D52701CC;
	Wed,  9 Jul 2025 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="qBGVyoMg"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47FD26B95A;
	Wed,  9 Jul 2025 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046217; cv=none; b=X/yHu/8v7M7VaVzrl1F/zT0GVKRAHxW5NxnbNXI+e52WCTmcq25zI2If9aShvgzslRrcoA5nvsBedBV6+rHWdEXQyXnpX/ejuHHcMPECQKqGCu6Is+ZTwcwNvUVMoKZT+nnWTvdwbr4qF3wNNDQZUM8HTp32Yvk2hVasazMXSnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046217; c=relaxed/simple;
	bh=X5thlOsBPQpf0W5zLV+W6jgSjyImuqYbsC1VDkInS4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=QSFMlL+lfX7sNZqgDIO4dgeM0ycmpBH6hecb7y/YT5SUhq1ThiBRl9D18BWg4o8sdmRyKmBNMeeFIMT3c+3AUjFkwDlADq6SjpWYBv4jQVIO+h2IQrDqG2vkpi7+MJBl2yoR4HCvsirC13pemHUKt6jKTdgTCYublwXobpmhiJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=qBGVyoMg; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 1BB26A09FF;
	Wed,  9 Jul 2025 09:30:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=uKoM0l3QzZ9hZFpSP5XstB7rOaEjiUp4zb31SP3+sc8=; b=
	qBGVyoMgI61wTszcW+3LRxZBey9JN4u6NSXJ3sIIzTtc2fWVox5nj5ZUeRW+s+vp
	hQYCVpIQDdBbYaUIbG1mQnvxbhqOuLWgpACtaPrU1T0BA/DrtGJTQ5isJRcJS8nS
	INfV4DOgbwRq+3u7qKl3rM+WiMBNNWyqolff2KfMYDlbr0pckBMWAleZi6n8/scn
	H5HrxhYqxEKjV8Rxf5CU/0PRA1ZYG1V3jKSAqQr7ky/qvhjo5fJoi4a/1r6pnkJH
	A+znQz5rd86ueKrF/PAojbvsw76bwqsq+w/dobG339uQrSk0weZajjF+++4nAgmr
	v00f7EVA78HptiuV869O2VhGMZb/xmVdLmPACc7x3Z3CjN4Tu3oEs6zDIBjt+zzb
	fuGq4UGEpAFeFcfiR99y3THClFgJpIWbn8VbwCnlXejg0+9m9mzeIk+mNHnZyNB4
	r+Su8bI04iIjKNWpg3nNDPTSvpuIuu7PqhB79SOpV4Q827TiIYhiWtVtclDjjJr0
	hs2QOXBmFUDrFexjCwUN+Z73g+ypWfcq9js7XPSiMhyRhviWnQqLVWGb2Pm2n5CC
	LbUKgH+Ye7kzB6PqBpnci4pdwlaqLAdTnUDlMeGWqxmVIZCiRVsuE/ozQb0XqhvF
	aJoXyyRtwTrH/ygMrECMXJ7IRhQvJKFDRanbHM5XqXY=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Wed, 9 Jul 2025 09:30:07 +0200
Subject: [PATCH v2] ARM: dts: imx6-savageboard: Replace license text
 comment with SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250709-savage-dts-lic-v2-1-07e0f827bd18@prolan.hu>
X-B4-Tracking: v=1; b=H4sIAH4abmgC/3WNzQ6CMBCEX4Xs2Zp2I3+efA/DYSnFNsFCdrHRE
 N7d4t3jN5mZbwNxHJzAtdiAXQoS5pgBTwVYT/HhVBgyA2osda1RCSXK6bCKmoJVlhBtM2Klqxr
 yaGE3hvfv8N5l7kmc6pmi9cfNk2R1fBR9kHXmz0+czFH/60hGGVWWra2bntqLaW8LzxPFs39Bt
 +/7FxAO1sTFAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Milo
 Kim" <woogyom.kim@gmail.com>, =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?=
	<csokas.bence@prolan.hu>
X-Mailer: b4 0.13.0
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752046213;VERSION=7994;MC=1975551790;ID=98254;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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

Cc: Milo Kim <woogyom.kim@gmail.com>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
Changes in v2:
- Fix msg
- Link to v1: https://lore.kernel.org/r/20250702-savage-dts-lic-v1-1-559c78ba9419@prolan.hu
---
 arch/arm/boot/dts/nxp/imx/imx6dl-savageboard.dts   | 39 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6q-savageboard.dts    | 39 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi | 39 +---------------------
 3 files changed, 3 insertions(+), 114 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-savageboard.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-savageboard.dts
index b95469c520a4..21a536c01011 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-savageboard.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-savageboard.dts
@@ -1,43 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
  * Copyright (C) 2017 Milo Kim <woogyom.kim@gmail.com>
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
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-savageboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-savageboard.dts
index 717ac62fc2cf..2dc20d70b200 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-savageboard.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-savageboard.dts
@@ -1,43 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
  * Copyright (C) 2017 Milo Kim <woogyom.kim@gmail.com>
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
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi
index 6823a639ed2f..c54cd2a7b7bf 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi
@@ -1,43 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
  * Copyright (C) 2017 Milo Kim <woogyom.kim@gmail.com>
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
 
 #include <dt-bindings/gpio/gpio.h>

---
base-commit: 66701750d5565c574af42bef0b789ce0203e3071
change-id: 20250702-savage-dts-lic-ca22c8f26067

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



