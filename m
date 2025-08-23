Return-Path: <linux-kernel+bounces-782899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F4B326A0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 05:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F097BAF43
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB913218AC4;
	Sat, 23 Aug 2025 03:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eWFJtclb"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F788F4A;
	Sat, 23 Aug 2025 03:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755919405; cv=none; b=J5yKRLov7grUKFdoBsZUoStTnrFsd5e4Prt97U/9qLw76ocXczqN6pOOrXX6tq2lonp+vzK/wUgFFGo248iGmVFGJ3+WxQN+N3XeG1mxKOG75D0amQv76avCL9hZa0JTqFCY2immt+XdfhEzoqZgPmu5CpHG/Y3ZSWg0y+Nh/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755919405; c=relaxed/simple;
	bh=N2+g9QQo/nuNLjITgpWu4O1zL+9DvUR5KWJgniZkXsE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YNEMaLduRszmYM06MG2JOoQqFZWEDeST/QTZUqOsLH/2yOLbFJKKHqHrgIuy1CHYQUuey//xquV8Y87cIUIcT3qLNJhP69Gtk6Gi0OW0HeuOqFKsxBOjkD7VegdxLmaFgTfzfTgmlIdiA0G8e+6c7LmuuhtmiOxek1/PCDJQpIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eWFJtclb; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57N3NGsl856664;
	Fri, 22 Aug 2025 22:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755919396;
	bh=TSQ2sN3s9VBkJCPgvduSGRVkYYKkIMIbTvHVaxtrX70=;
	h=From:To:CC:Subject:Date;
	b=eWFJtclbmm25QlQ5tdIAiP0y5fm9fRAWG8lk/bwt3e6TL7yvP14PeTQM1/nI8NV3f
	 /RbBptPq1zqZb68uVvFZIlpykcQ+csjbgUHP11mtHf6nPk3NDl5nigyOd1oj+zmrms
	 mCWgDQ8RaapLycpGHdaWEI7wJjhokM36Rz3hVOQo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57N3NGQ54067513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 22:23:16 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 22:23:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 22:23:15 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57N3NEeQ288079;
	Fri, 22 Aug 2025 22:23:14 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] Add USB support for AM62D2
Date: Sat, 23 Aug 2025 08:53:02 +0530
Message-ID: <20250823032304.1085775-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This patch series introduces following changes:

* Patch 1 fixes the register length in main_pmx/padconfig for AM62D
 and AM62A. This also fixes "i2c 0-003f: deferred probe pending".

* Patch 2 enables USB support for AM62D2-EVM by adding pinmux and device
 tree nodes.

Change Log:

	v1->v2:
		- Added fixes and Cc tag for Patch 1.
		- Dropped two patches for OPP (applied).

Boot Logs-
https://gist.github.com/paresh-bhagat12/e29d33c3fd92ff17580edf1441ece9f9

Tech Ref Manual-https://www.ti.com/lit/pdf/sprujd4
Schematics Link-https://www.ti.com/lit/zip/sprcal5

Paresh Bhagat (1):
  arm64: dts: ti: k3-am62d2-evm: Enable USB support

Vibhore Vardhan (1):
  arm64: dts: ti: k3-am62a-main: Fix pinctrl properties

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi |  2 +-
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts  | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.34.1


