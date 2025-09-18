Return-Path: <linux-kernel+bounces-812269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BA6B53543
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42581582477
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC433A03D;
	Thu, 11 Sep 2025 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="patOuB01"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A715338F27
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600810; cv=none; b=QvPCrgUne/WHcoToiWtDWsc2PXML8/E1lFNh7hPjUZFwl3uYKJyV/d58CaMtOdcXmusmNd8dj9lq2j+D7VHWu6EsYp9UShowAHJI2EJK1p+B8votBiiHusGiBXPPmlfIWJl7rOYhW/nkdl5Vrl5DaW49XHwvvhmRgjdWGBmLz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600810; c=relaxed/simple;
	bh=mbPCGX4UM3HTT02k6+HyBLV9KQeGijMJ1WmgYeVW2tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=uqLKNiSiIgBdezytpT/xi3NMvCMoRn9gFjicWIRN5IOJGkwZOZ+7ssch0nmfc1xFQ7fBZKsmyQU5NresL2GKcfPq5LkPioTtAk8U6RXdjHsxWp6g1xCduUZKVioL9OIsZjHU3WvGbNHa+OCgVL0qtYbdXu5pwzP2sRz+ia4D+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=patOuB01; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250911141704epoutp019b0227af0f56dfbfa85c892316cd4d4d~kQBeYN6w51193611936epoutp01t
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:17:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250911141704epoutp019b0227af0f56dfbfa85c892316cd4d4d~kQBeYN6w51193611936epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757600224;
	bh=RLpdNx7Q7daLl1m5w+1HBX92mGtsG9KdY01cT624FQQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=patOuB017iAODXDePtilJ66dkb0gEC6N1VU/RJczUip/26hnOiE/qxD33Lp5kZbmY
	 HnvpnuPfqwhQWE3wLQ6cGeNSuwY+SvXliiR96oEnnTExZwoHk7SsF+lM/M85luGu2p
	 sM6X41V8dqUBe4RkQOFJTk3ahTWUXeksV8rj0kqU=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250911141703epcas5p45f1cdb7fe1cc1b01d11f889708713a03~kQBdmAcvf2847928479epcas5p4v;
	Thu, 11 Sep 2025 14:17:03 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.95]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cN04G6Kmdz6B9m4; Thu, 11 Sep
	2025 14:17:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250911141702epcas5p23d6a0708919eca66f9b29104efafbc1f~kQBcMU3Uf2246622466epcas5p2c;
	Thu, 11 Sep 2025 14:17:02 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250911141658epsmtip1c22551d755a82731ba8ba8a915095e45~kQBYqjAjg3172231722epsmtip1b;
	Thu, 11 Sep 2025 14:16:58 +0000 (GMT)
From: Ravi Patel <ravi.patel@samsung.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jesper.nilsson@axis.com,
	lars.persson@axis.com, alim.akhtar@samsung.com, arnd@kernel.org,
	krzk@kernel.org
Cc: andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
	thierry.bultel.yh@bp.renesas.com, dianders@chromium.org,
	robert.marko@sartura.hr, schnelle@linux.ibm.com, kkartik@nvidia.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@axis.com,
	ksk4725@coasia.com, kenkim@coasia.com, smn1196@coasia.com,
	pjsin865@coasia.com, shradha.t@samsung.com, Ravi Patel
	<ravi.patel@samsung.com>
Subject: [PATCH 0/3] Use exynos8895 driver data for ARTPEC-8 platform
Date: Thu, 11 Sep 2025 19:46:02 +0530
Message-ID: <20250911141605.13034-1-ravi.patel@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250911141702epcas5p23d6a0708919eca66f9b29104efafbc1f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250911141702epcas5p23d6a0708919eca66f9b29104efafbc1f
References: <CGME20250911141702epcas5p23d6a0708919eca66f9b29104efafbc1f@epcas5p2.samsung.com>

Existing samsung uart driver has separately added ARTPEC-8 specific
driver data, which is added long back (> 2yrs).

This driver data can be removed and other similar driver data
like exynos8895 can be used with some changes in the dt-binding and
device tree.
This patch series does the same.

NOTE: This series is useful for the upcoming ARTPEC-9 base patches
where uart is exactly same as the ARTPEC-8.

Ravi Patel (3):
  dt-bindings: serial: samsung: Update axis,artpec8-uart to use
    samsung,uart-fifosize
  arm64: dts: axis: Add samsung,exynos8895-uart compatible for serial
    node
  tty: serial: samsung: Remove unused artpec-8 specific code

 .../bindings/serial/samsung_uart.yaml         |  2 +-
 arch/arm64/boot/dts/exynos/axis/artpec8.dtsi  |  3 +-
 drivers/tty/serial/Kconfig                    |  2 +-
 drivers/tty/serial/samsung_tty.c              | 38 -------------------
 4 files changed, 4 insertions(+), 41 deletions(-)

--
2.17.1


