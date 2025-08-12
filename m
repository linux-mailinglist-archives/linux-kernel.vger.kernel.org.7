Return-Path: <linux-kernel+bounces-765439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252BDB2353B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37009169E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9242FE570;
	Tue, 12 Aug 2025 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="aDOmLxzn"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2363C2FD1B2;
	Tue, 12 Aug 2025 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024452; cv=none; b=fWLPY82Qlf6p83clgnUenshtHyiZ+YRgUKK1zSmg+OoUmN9M3diiiSQz9CgPywS8PKMcWdDohN6lse4nUQAcQkEbDrVvmJZgRqkKY0KZ7FzzCrXU2b8zb/uHcHm3ormIM7wKrSaydGSfGHYi10X47Db68WzBpnqVo8NkwkDXQUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024452; c=relaxed/simple;
	bh=AGwDMxw8ZyZ47b4x8r5WQmJJdyok53ebtNAJF9tPEHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=t6702JCjSbTn4FgEse/PSy0psEspltZxEQIphVmbNHJ3L2Vx9FzQdsIV6Ze+w/ciqIzHCWMrbjmfYrhLV5vqm/1x20SROWQ823OycLJ8KNH7evetx3JEK1mpRWtUXKOxJM7hqgXOMLoIqIA7NJgkRsXfCTyeGNwltivs9Jn+foM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=aDOmLxzn; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 12B67A0A91;
	Tue, 12 Aug 2025 20:47:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=oQpFCPkQ2gBSs+m1fBfcJCpRchasPj3qAzp5b0KBTmA=; b=
	aDOmLxznYAYglw6g6uFhIdWBgQ6mKZ98FsNVtcPNUnOIoRb2h+uAdP8exBz6nzjL
	Be1kScblnQqZJ91G91qioo8KAyyxUQ/uHUofksX9RwaLA5XBJP/vGrUOYH9ozy04
	iN32YuqVUAuDHaYFwzB1+RReNOr7DPySe0oNwHQqQ4GICKLdGzbb6dZmlOXtKZjG
	pfUugwjSJr74kGHa5+SusXknx8tuvSiD/JAbACgqHDd5KauVOOXUVGE+2Kz6SBZy
	WLFYuCaS2owVvSHqaRwc/59RgqBgVDeSXmoD0U8V34IUVDwFLHzNzfLw+UDVmz5w
	cY5L0jnEx96wi+dzCVj9K3eo1cillGRk07I68yICL5qtYvi8h5HVjZXwf4qMLI2n
	2Ie8E8UN4B1V5woen1TxnyPQboZ9Iy0cLtUAaXl6HcCWGt0pCsShbMdAtoiU/hwz
	DcjlYN+Sz2EnkIPsw/GYi/2e10FcU/9VafDJPGTvIADb5SBhK6v1MMQJSFbt/CR7
	zshBoHKTKZKUUt8XRrbA+iGI13eAe8cli1lFvUoRHs11xb5NkaPA+KIjPLXflD5j
	nWH29Lb3GS5Ett2R/MENM2TT9BRndNM0jn7wEZ7mzOXznMo8glFj0nAMMm6xGvE0
	47RZ20bXPE9g8emSTqo9EOgNqKk4XkcyxBtjUfr+NBg=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Tue, 12 Aug 2025 20:39:28 +0200
Subject: [PATCH v3] ARM: dts: imx6-cubox: Replace license text comment with
 SPDX identifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250812-cubox-dts-lic-v3-1-1eb7ef334934@prolan.hu>
X-B4-Tracking: v=1; b=H4sIAF+Km2gC/3WNQQ6DIBQFr9KwLg1QFe2q92i6gO+3kFgxoMTGe
 PeCK9Oky0nevFlJQG8xkNtpJR6jDdYNCa7nEwGjhhdS2yYmgomSSSYozNottJ0C7S1QxrnWUBS
 Mi5okZ/TY2WX/ezwTaxWQaq8GMPnlrcKEPg+NDZPzn70beZ7/S0ROORW6BWygqjmw++hdr4aLm
 UlORHG0m19bJFt2skIsG1kyONrbtn0BqR8KXQEBAAA=
X-Change-ID: 20250702-cubox-dts-lic-011bbc440128
To: Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755024438;VERSION=7995;MC=2183211758;ID=1014970;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E617465

Replace verbatim license text with a `SPDX-License-Identifier`.

The comment header mis-attributes this license to be "X11", but the
license text does not include the last line "Except as contained in this
notice, the name of the X Consortium shall not be used in advertising or
otherwise to promote the sale, use or other dealings in this Software
without prior written authorization from the X Consortium.". Therefore,
this license is actually equivalent to the SPDX "MIT" license (confirmed
by text diffing).

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
Changes in v3:
- Fix erroneously added `GPL-2.0-or-later`
- Link to v2: https://lore.kernel.org/r/20250709-cubox-dts-lic-v2-1-7f76ee59750c@prolan.hu

Changes in v2:
- Fix msg
- Link to v1: https://lore.kernel.org/r/20250702-cubox-dts-lic-v1-1-2bdce9c681c0@prolan.hu
---
 .../dts/nxp/imx/imx6dl-cubox-i-emmc-som-v15.dts    | 38 +---------------------
 .../boot/dts/nxp/imx/imx6dl-cubox-i-som-v15.dts    | 38 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i.dts       | 38 +---------------------
 .../dts/nxp/imx/imx6q-cubox-i-emmc-som-v15.dts     | 38 +---------------------
 .../arm/boot/dts/nxp/imx/imx6q-cubox-i-som-v15.dts | 38 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6q-cubox-i.dts        | 38 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi     | 38 +---------------------
 7 files changed, 7 insertions(+), 259 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-emmc-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-emmc-som-v15.dts
index 2b2fc360b8653fcf2c01acb6a936564f1ba65452..4d6a88268513481d5d65a7c8e3d71870d8fe8b47 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-emmc-som-v15.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-emmc-som-v15.dts
@@ -1,42 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright (C) 2014 Russell King
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
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-som-v15.dts
index e09c565d1d1febd4efc1a69f4dba677e9784a545..3007f5aa02d6d9e1f7be00add37cde140a141944 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-som-v15.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-som-v15.dts
@@ -1,42 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright (C) 2014 Russell King
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
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i.dts
index 2b1b3e193f53cf9ea679e6a8e916093d64946599..d8e599a6e1cec77cd1c49951dcf49e381732f985 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i.dts
@@ -1,42 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright (C) 2014 Russell King
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
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-emmc-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-emmc-som-v15.dts
index 3e59ebbb360864b5d36ae85e609d8af26884b147..615c1693e31ea07597f6530e96690420f3c3b2ce 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-emmc-som-v15.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-emmc-som-v15.dts
@@ -1,42 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright (C) 2014 Russell King
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
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-som-v15.dts
index dab70d1230a294ab7b2e7eb4cfe13ac6ae26d270..48e2fc272f17e1e59423e35ccda05df745017513 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-som-v15.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-som-v15.dts
@@ -1,42 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright (C) 2014 Russell King
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
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i.dts b/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i.dts
index 1c7b262e370949da615d7aead5e5ff141da8145f..ac37d7df9eb321d8858abe907826d9702bf4cab0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i.dts
@@ -1,42 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright (C) 2014 Russell King
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
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi
index 41d073f5bfe7a5d42ecfe34341d8dc8a39f73801..11f6b1befc8d5f222042d9ecaf7e552f71900c8c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi
@@ -1,42 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Copyright (C) 2014 Russell King
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
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>

---
base-commit: 66701750d5565c574af42bef0b789ce0203e3071
change-id: 20250702-cubox-dts-lic-011bbc440128

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



