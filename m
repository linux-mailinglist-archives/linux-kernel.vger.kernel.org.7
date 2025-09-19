Return-Path: <linux-kernel+bounces-823951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20606B87CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD267C3711
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B260257435;
	Fri, 19 Sep 2025 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KfIWXTgH"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51CE34BA2B;
	Fri, 19 Sep 2025 03:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252545; cv=none; b=EbkeoEWWikpWIQ2FfS0dWbWDTwuHBsrTNO1JSxbPGHY/H0T/iDnJnBq0fuVjLvbtv2lkhtxarehNDqwcBN3p9ibix/585jwSkVQHacrANR1d6g6bxx8O9rqRCSMyA8Jv+sJ2UUKeu+FjFHLAuvf6ZTt6+jGYFFeklWCsq2GP9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252545; c=relaxed/simple;
	bh=wvmowbwTXArDbVodDc+wxs7J5XrWKjh/Af74xjtzoq4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uhatay1wd/ujmPIgQfKvgbrLp52WFxiCNqUdccO/XiIpgaS4XGDaUSmGdkGLxByunRuHOy0g9ucMJ0gTijAiNBfu+bXjrDtRAnCCgOODaGlpHEyq4QKW57RsTZEF2Gq3MnJU2g3sXqYywyWMw/+2BoM63okG4QBEpTCrEqdg/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KfIWXTgH; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58J3SrCD151725;
	Thu, 18 Sep 2025 22:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758252533;
	bh=fm7EbK8iCdBY8MyFpYjSk6v/Dd93EhSIFsL/bG1/W7c=;
	h=From:To:CC:Subject:Date;
	b=KfIWXTgHSZworZl4+c0lPgT4HMiC8jPBo5NgzMnEH5R8HpSioCtIT6OXcwT0pTqdz
	 U8G1ZgOnN8bjosp4bSY2e3g1bR0T2Pn843BHBLZcVOJAt81nKHl6v3vVRtnZRkevrU
	 msCMS6K1zbYqBiPS4n8Y+foMtsRuMLz6JUwYYTc0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58J3Sr2n2842067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 18 Sep 2025 22:28:53 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 18
 Sep 2025 22:28:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Sep 2025 22:28:52 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58J3Sptd1901011;
	Thu, 18 Sep 2025 22:28:52 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-ramamoorthy@ti.com>
Subject: [PATCH 0/2] Add PMIC support for AM62D
Date: Fri, 19 Sep 2025 08:58:04 +0530
Message-ID: <20250919032806.707926-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series adds PMIC support for the AM62D2-EVM.

The first patch corrects the PMIC pad configuration by wiring the 
PMIC’s INT pin to the SoC’s EXTINTn input.
The second patch enables the TPS65224 PMIC on the wakeup I2C0 bus.

Tag used
next-20250918

Boot logs
https://gist.github.com/paresh-bhagat12/11dee1b07be3019d5f92f893fa11229d

Datasheet - https://www.ti.com/lit/ug/sprujd4/sprujd4.pdf
Schematics - https://www.ti.com/lit/zip/sprcal5

TPS65224 Datasheet - https://www.ti.com/lit/ds/symlink/tps65222-q1.pdf

This also depends on this patch
https://lore.kernel.org/all/20250916090736.2299127-1-p-bhagat@ti.com/

Paresh Bhagat (2):
  arm64: dts: ti: k3-am62d2-evm: Fix PMIC padconfig
  arm64: dts: ti: k3-am62d2-evm: Enable PMIC

 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 93 +++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

-- 
2.34.1


