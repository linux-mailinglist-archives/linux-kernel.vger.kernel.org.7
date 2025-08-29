Return-Path: <linux-kernel+bounces-791283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389C8B3B49A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C783BC59E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94625284B59;
	Fri, 29 Aug 2025 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GYB4SZcU"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DA323ABBD;
	Fri, 29 Aug 2025 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453635; cv=none; b=fOzxjIaFLcQ+M4QuxkmOPo39Y+/i8x77l8/HIhTr4zkIZJ04Ey6CvAdvOzjWSFbLqYtKLJGhxSfQ5TglBZy+y1uZqyEIf4bF7YALKbqziIXfE+8Z5XGTH1O5rBO68Rde5qJQFLEjUrBsu9XglsvCbY3m54a9YcH1oBHPr8O9h8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453635; c=relaxed/simple;
	bh=b3789sOpnYbcUUtFo/25BZu2nfwApljd8zKm0RqVYFI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gJOYZz7VaRdHdOYAv+2QlsCQ2QCJ3DrKhpCy3UFbmosET7VDkwdGBsgvu3qgD49sxoPI914GiRV0LscvowWxeWKK61krS+om1LD6lvNWeUBLSV2V+K+S4ec4W9wYBS4+ar/1N6y4A0koYygNkuPJQWlXDyEr76dDulgbXwlqoYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GYB4SZcU; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T7l6Ok1704553;
	Fri, 29 Aug 2025 02:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756453626;
	bh=SSbzDEs4DoD1Kv6Y2ZtI25mfCIzDcnm2Cf5crMrd5eA=;
	h=From:To:CC:Subject:Date;
	b=GYB4SZcUazgWqd1t1R/PuJRUixUdaNPUbpfrY+0F3dvgHVigeVPdJJ/u23lvb8qj5
	 E+JfK+doEmqqK8HnluFuJ4I36vWHjLD1rRdP8repxQ/MhKbm+SYqMGA12uzLrnNR4p
	 3YRgx5htqXU2J8gl4EWr/uhHlcKVuowe4Tj50chE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T7l5C2384084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 29 Aug 2025 02:47:05 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 02:47:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 02:47:05 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T7l1fP1717407;
	Fri, 29 Aug 2025 02:47:02 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 0/3] arm64: dts: ti: Add bootph-all tag to USB PHY controllers
Date: Fri, 29 Aug 2025 13:16:57 +0530
Message-ID: <20250829074700.1531562-1-h-salunke@ti.com>
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

This patch series adds the bootph-all property to USB0 PHY controller 
nodes across multiple TI SoCs (AM62, AM62A, AM62P, J722S). 

The bootph-all tag ensures that these USB PHY controller nodes are 
available during all boot phases, which is required for USB DFU 
(Device Firmware Upgrade) boot functionality.

This series is based on commit:
8cd53fb40a30 Add linux-next specific files for 20250828

Hrushikesh Salunke (3):
  arm64: dts: ti: k3-am62p-j722s-common-wakeup: Add bootph-all tag to
    usb0-phy-ctrl node
  arm64: dts: ti: k3-am62-wakeup: Add bootph-all tag to usb0-phy-ctrl
    node
  arm64: dts: ti: k3-am62a-wakeup: Add bootph-all tag to usb0-phy-ctrl
    node

 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi               | 1 +
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi              | 1 +
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi | 1 +
 3 files changed, 3 insertions(+)

-- 
2.34.1


