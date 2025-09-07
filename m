Return-Path: <linux-kernel+bounces-804774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17318B47CDA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAA817A42B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A7329B216;
	Sun,  7 Sep 2025 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CmZvVuXY"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7227CCEE;
	Sun,  7 Sep 2025 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757269724; cv=none; b=MW6uSU2S0sAYbCQrjdHlaGhWubaQbOpZRH2FfZLXPRzT3lzsbQvtUXX5bvn74P6Cqo3z2U+jo+Kwirfxf0Lv7enhFkVtr+YJdJ5NiV/CWrcBQfZ4gZzIG0y/5FMlmNTjij97EjnNrzrj1/nlZQVP8SRjTjUXRefxRu8TEI7iifM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757269724; c=relaxed/simple;
	bh=moIVlpzVYcicYu+EkYy9XXYQuaKTS6F+sErzALej2eU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o5DLMGu3NZF2BKR/g9ijSAf5W9ChB2bbPWtZ1+vFzJAak4Lul/ofZWr3NNyTc3NeuyYay6jVeivPLhcyNDg88iwRNmyeyZ+ScOKPunz1uN7mK5XHtRv2Bxkm/C0x4z8/CvP3vQDCFpxfaTeJ5A44kqwYTII9VBXDRUShJMq1Wao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CmZvVuXY; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 587ISDn33631540;
	Sun, 7 Sep 2025 13:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757269693;
	bh=bpb81yFs8TLty9/uuEQTt5yzSnG2hj/7jGaEJRUiQBc=;
	h=From:To:Subject:Date;
	b=CmZvVuXYFzDpFe7L9aA6SP6fjbb3/a/0MKtNAlwd3w1/5FwgKaJ32B/+RPprZJNpq
	 5JO85VvzqlirwhCXm04COJ2Fcl9MdrCMGgpFSSC6fV9jocPPcHY+t1Kd5ARXgtrRvz
	 t84rO0ZNEzFiaDY8xMVBp5sNrUh+0y2z9o3zie0I=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 587ISDQn1851301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 7 Sep 2025 13:28:13 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 7
 Sep 2025 13:28:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 7 Sep 2025 13:28:12 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 587IS7UQ3565173;
	Sun, 7 Sep 2025 13:28:08 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <r-ravikumar@ti.com>,
        <m-chawdhry@ti.com>, <b-padhi@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tomi.valkeinen@ideasonboard.com>,
        <aradhya.bhatia@linux.dev>, <devarsht@ti.com>, <s-jain1@ti.com>
Subject: [PATCH v2 0/2] Update DSS EDP integration configuration register
Date: Sun, 7 Sep 2025 23:58:04 +0530
Message-ID: <20250907182806.1031544-1-h-shenoy@ti.com>
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

This series fixes the size of EDP integration connfiguration register space
for K3 J7-family of SoC's.

Changelog v1 -> v2:
- Removed extra line from commit message.
- Added Reviewed-by tag.
- Added fix for j784s4 as well.

Link v1: https://lore.kernel.org/all/20250904050940.2913567-1-h-shenoy@ti.com

Harikrishna Shenoy (2):
  arm64: dts: ti: k3-j721e-main: Update DSS EDP integration
    configuration register
  arm64: dts: ti: k3-j784s4-j742s2-main-common: Update DSS EDP
    integration configuration register

 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi                | 2 +-
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


