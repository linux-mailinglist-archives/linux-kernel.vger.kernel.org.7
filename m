Return-Path: <linux-kernel+bounces-789656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144E2B398B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D106156090F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399332ECD3A;
	Thu, 28 Aug 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Kqz5WfXi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="WJnDbO2Z"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5FB2E1C6B;
	Thu, 28 Aug 2025 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374480; cv=none; b=Riwlrxjmrd5sIStUqjBPEUp2eBq3H3u0dgZB4qbGYbbylCwjiRygfnhN9xNbntfEP0uftZp/bxGGZnvRUuuW3cRaP6ej2v0OIdzCS5NA+abuZ61S7d4MvgK7mUdntxw+9k4s/+g2CidDjayP1nV/1Ub7ZJ6Wo3VsN3dqyAjNCec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374480; c=relaxed/simple;
	bh=s+VkfcYq0dyXtAWi6tWSiU14NTiOmlsqgXkt52AbAIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvfp4JeaUkA+KvcP3wSAKabBlxf72jnqr4cJTSMgDixZMGXq0PzSmjX3JtYUSXx14Nd0wQ4krLKYO4Ny8FFxyYGBgCpPLI6Roa7tWqxlvDTynUleptssQNXfo6dRoJm33GyvQMLBa0jaLe7B3V9k915nSpOzip9/fcZZ1z3S/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Kqz5WfXi; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=WJnDbO2Z reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756374477; x=1787910477;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J1QSK2ULqq2r1vYO2KfcbQsiEjNnS0EBsknMN+1oquE=;
  b=Kqz5WfXivaIir1RXbAnb6cPWOnruFBP8VZfJK0bORvoR/EBWI0fEzqQk
   z0H5s1QSgZTzUcGzJN2lBHl6rY5+xPaPQrtmC0mWj2e6ThyQA2kVo5GZ7
   sKdyKcFS2nuwFpvAz0Gi15FS57ITRlJ1zGllhkNAveonZS+pntfwMslzH
   oB3KOPfxmMhw7RZW+aG3BjzYd7RKf7gW+g2H6M//hGyMPi9FT2SGdAW0B
   avJ8A4dprpUIjRpDweqSy/2tnsnQrkitTWLsSlva4KUa/9bPTmHw+zOwm
   qJUyCN18ZiuTb4eBJAWROofxlPqVaNF3VN7RiDfiKFUGLFoudWTre+d7h
   w==;
X-CSE-ConnectionGUID: 7lUzfuzXTAqqlHLic1NFYw==
X-CSE-MsgGUID: 2AtPNRG6QMy7snIQECxo9Q==
X-IronPort-AV: E=Sophos;i="6.18,217,1751234400"; 
   d="scan'208";a="45953046"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 Aug 2025 11:47:53 +0200
X-CheckPoint: {68B025C9-1-410E8DD8-CEA8F0F8}
X-MAIL-CPID: 97701C9BF41BDC5479A47DE668FBFA7D_3
X-Control-Analysis: str=0001.0A00210F.68B02518.0003,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10058164884;
	Thu, 28 Aug 2025 11:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756374468; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=J1QSK2ULqq2r1vYO2KfcbQsiEjNnS0EBsknMN+1oquE=;
	b=WJnDbO2Zhu5hbOSQwvLbPAiAxSOrRUXiMz7VEcxfmq4mAmM99j2Z5nTBsUre6gxiGGyhAp
	pkPTfXrmY+r+f7Z3oOy4wslbQy3r2s96gcjKgVb+8ZPDnnih85ivYz2NiLpyy1vYoW0vrL
	lrUVm+kryWrYUxlglZkw1rKS8PXN/gmCBd0ZTkJvAT8/j0EtJU06MW2eptPWNvZZIMkMmW
	bUdE0KfSbv5V3xQOh0cSAudasDvbQL99YOVzxprU8Do/uBhfZ+RV2i2RSAQffxCE6WNyut
	pCzVCROF99egK/x750QcETbxsqM61KcpfUEaf9MlrF3nNmiO9Jh6d+zFQXtlrA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com
Subject: [PATCH 0/2] TQMa91xx support
Date: Thu, 28 Aug 2025 11:47:41 +0200
Message-ID: <20250828094745.3733533-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

this series supports i.MX91 based module series TQMa91xx. It is available
in a socketable variant (CA [1]) and as an LGA variant (LA [2]). Both
are covered by the same device tree file.
The hardware is identical to their TQMa93xx counterparts, just a different SoC.

This series depends on the i.MX91 SoC support [3].

Best regards
Alexander Stein

[1] https://www.tq-group.com/en/products/tq-embedded/arm-architecture/tqma91xxca/
[2] https://www.tq-group.com/en/products/tq-embedded/arm-architecture/tqma91xxla/
[3] https://lore.kernel.org/all/20250825091223.1378137-1-joy.zou@nxp.com/

Alexander Stein (2):
  dt-bindings: arm: fsl: add TQMa91xxLA SOM
  arm64: dts: freescale: add initial device tree for
    TQMa91xxCA/MBa91xxCA

 .../devicetree/bindings/arm/fsl.yaml          |  18 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx91-tqma9131-mba91xxca.dts    | 737 ++++++++++++++++++
 .../boot/dts/freescale/imx91-tqma9131.dtsi    | 295 +++++++
 4 files changed, 1051 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91xxca.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi

-- 
2.43.0


