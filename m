Return-Path: <linux-kernel+bounces-857606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D404BE7403
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120AC1AA0480
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603C29BDB1;
	Fri, 17 Oct 2025 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j3F9NO9/"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A24409;
	Fri, 17 Oct 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690830; cv=none; b=fA5ZGTkfGgnjZa0a0BzMyOg735iCMiK8mTVa1Z0ahXMkLLwUeyZkwj6CAO1D3cdkUfW4QBrzJblWG9xeyKLHO0neZZ0g1Vst4vfYSntHqctV2LvVEJBBogqBI0PdVaat4vZOhv/sesk2XTjFadSkDDbSuoae7dnvOu3IMusaiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690830; c=relaxed/simple;
	bh=I/DK4QgG1RToKmhQ396ckKRjMkYNJTJTwzpY2Pvi2bk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cK9EUwo1I1J3g+6fr5MAsIxOKAF7PlHVGf91J3e+wlGhfBFnt/WLzgw/gb0s3Vqz2gmqXa+Z/5/JWEL1S2hajFu3Y67ZUx5vEDi65aWov4T8V77SFkywzlgvdcNV7PlUH35pVCa+0lpfRupXlT8C9PMNCCSLpynBeqeT7ZS0xIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j3F9NO9/; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59H8kxSC2320864;
	Fri, 17 Oct 2025 03:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760690819;
	bh=+V+t5Qcu4oo0uZHpVh5RjBz4WkY7IKdvDOVT53rvnWI=;
	h=From:To:CC:Subject:Date;
	b=j3F9NO9/kak6w5gAMHn5MRai9CsA0HQzoDsIh/2upp2jmNEl5lkGFGJYty5fiPqAc
	 UhsdFELxavfMn//MvO+fqqBExDIT7SVALFTsIkrWadaw9qXTohpJGkdTLzUt2cdFMH
	 UaX1kJIZ4GcJNjCvVKB155DS8jJ6NHvWFVmuxzDc=
Received: from DLEE201.ent.ti.com (dlee201.ent.ti.com [157.170.170.76])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59H8kx4c1870929
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Oct 2025 03:46:59 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 03:46:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 03:46:58 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59H8ktET1019203;
	Fri, 17 Oct 2025 03:46:55 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <danishanwar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] arm64: dts: ti: Add bootph-all tags for PCIe boot support on J784S4 SoC
Date: Fri, 17 Oct 2025 14:16:51 +0530
Message-ID: <20251017084654.2929945-1-h-salunke@ti.com>
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

J784S4 SoC uses its PCIe1 instance as part of the PCIe boot process. This
series adds the necessary "bootph-all" boot phase tags to all the device tree
nodes that need to be functional at all stages of the PCIe boot process.

This series is based on commit
13863a59e410 (tag: next-20251014) Add linux-next specific files for 20251014

Hrushikesh Salunke (3):
  arm64: dts: ti: k3-j784s4-evm-pcie0-pcie1-ep: Add boot phase tag to
    "pcie1_ep"
  arm64: dts: ti: k3-j784s4-j742s2-evm-common: Add bootph-all tag to
    SERDES0
  arm64: dts: ti: k3-j784s4-j742s2-evm-common: Add bootph-all tag to
    "pcie1_ctrl"

 .../boot/dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso      |  1 +
 .../arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi | 10 ++++++++++
 2 files changed, 11 insertions(+)

-- 
2.34.1


