Return-Path: <linux-kernel+bounces-794290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D24EB3DFAA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112513AD1CA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB473101DB;
	Mon,  1 Sep 2025 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="BIGBMML3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="MtZJxsr0"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BEB20DD48;
	Mon,  1 Sep 2025 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721102; cv=none; b=Qd/orqeUZjPejwH9PTo1SIUt7KDLnUF1YlkHPB1gUmsPEJxJljapl7kSmF6c53m5gWtufWgV7+mj2jRku4e4TYB+YiqMsdcd4lYTpXIkrPFf/BaC576GnQSD4a+ZMjebzoqvjhNvnMrLBsnWQ9DtkD6BMVTTWs8Ih0y6Gmu4Ch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721102; c=relaxed/simple;
	bh=PqWPxJEJHF2R93uknLKaIhwfKm4lnP2A14FQDEXKsQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nyb0mzLeULahvBreajqklOLcI0H3sMMkLZyr4O2LtxMRNBR+5ODLx02f7y9dQTqyyCjAhIstLXqmglFYMFVXQk1AaaFeusclWgqQEqBXA8HD+NwjGT9fNCoWHXWxWK4F4Appa1k7HqL+exeVfdwZL2Zu6Borubv9/MyhlF5Z1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=BIGBMML3; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=MtZJxsr0 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756721098; x=1788257098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LglhPlwMqIEb5lp6QQRc6h7tbZs7go6i8tgRSxiq4X8=;
  b=BIGBMML3VjnFvvKr+NAG1LKziu70VQMJJ22LxL3d/lnRXXdKdtJK+M/5
   dyraTNa6j3s/hTxWl0LjzeheSVtW+vZbyASAo5+6n2fPjYpduUW4TN0iY
   HUbV8uibbRdNKADdcbxj7VBEN/POtKq7HTHZPz2sCFayhJwCQZvvhIQID
   R7CvpT7jFkIy2HM2SkZp+zu242FpmH45aav3uBu1MFjuGt336BP+3anUV
   UteUNtXRIPqr8b4kPzOCYAcXsUYEnh6fNsKXkb36YKRP8oFO+qaW1Lj60
   8NWQVLAqcQHUk/kqCcgjMzWc7dyedxCg9jiD1mg/PfDPfZOmbFUA+wIja
   g==;
X-CSE-ConnectionGUID: y/fatGMXSAqiuNPuVA67sg==
X-CSE-MsgGUID: ZRt67WOPR++GxyGeS8zMrg==
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; 
   d="scan'208";a="46004680"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Sep 2025 12:04:49 +0200
X-CheckPoint: {68B56FC1-1B-20CAA7DA-EC9DC758}
X-MAIL-CPID: BD1DAF44F32A66FB5B73D9DFF9139FF1_0
X-Control-Analysis: str=0001.0A00210D.68B56F5F.0090,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 683611697BF;
	Mon,  1 Sep 2025 12:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756721085; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=LglhPlwMqIEb5lp6QQRc6h7tbZs7go6i8tgRSxiq4X8=;
	b=MtZJxsr05piR25btcguKeO1U9Tx+XOs3scH1EgiBapVT4FRoy/HuRE8CcvDkY/rrx4lQRa
	LSo5jxNWt5Qgfo7sUIgiWzYFTAQdC9T49Uxay+Y7kdNdYtRPQ0lJQuH5MmLEJNN7F54CPB
	P8XAjoGxm+YcTOp9UIv72vdbMcCHUoPif6K8lh6Ws1FG20ggGJE1Ct6iskkwmS0dTlmTaA
	M6iaTr9avPZeDEb7+ft2Du9BPpxtuGQm7GDYyO0dKNMKdFVIkc6hvxaovhse82/jC3HY2q
	ePQYr7qb2iLK5N1MeSvhlO48s2QntA1cO1gJpR0yQvJJh3bOvwrJ5J6fW7F9Dg==
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
Subject: [PATCH v2 0/2] TQMa91xx support
Date: Mon,  1 Sep 2025 12:04:28 +0200
Message-ID: <20250901100432.139163-1-alexander.stein@ew.tq-group.com>
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

v1:
* https://lore.kernel.org/all/20250828094745.3733533-1-alexander.stein@ew.tq-group.com/

Alexander Stein (2):
  dt-bindings: arm: fsl: add TQMa91xx SOM series
  arm64: dts: freescale: add initial device tree for TQMa91xx/MBa91xxCA

 .../devicetree/bindings/arm/fsl.yaml          |  18 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx91-tqma9131-mba91xxca.dts    | 739 ++++++++++++++++++
 .../boot/dts/freescale/imx91-tqma9131.dtsi    | 295 +++++++
 4 files changed, 1053 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91xxca.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi

-- 
2.43.0


