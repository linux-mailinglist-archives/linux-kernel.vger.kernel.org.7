Return-Path: <linux-kernel+bounces-816079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E14B1B56F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 940094E06AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732A5271454;
	Mon, 15 Sep 2025 04:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hfFuUruA"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8151A83ED
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757909267; cv=none; b=Rx55jvTLZDnYWsCQARhcnQC8M71E7Fj3XrGhKZXvQj7+DQI8oTt7UPLI47j2mb2bHapYvLYUS8ADSHv8c+j83b73AvEBGdY6lI5KPsY6Ytov3RJ8NgwEWLH0WGmTjLG3EbjkZX787lSQ70vcBxjKzn+RYiu9pKZFSWryA/4OZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757909267; c=relaxed/simple;
	bh=niYSmtyyUlruk4dkrHY/anirHG38e8wf6rtLr8ewLg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=lZ0epFYmrLdlSimsLWeB1JLraVYSEf+gMR3LQRLCI3Gml1Ni1Z9EXeOgFpFAHY4NHtBM3jvXRRXdGmqcKL6Sg81suHZvGi1JYwVxhumhRzgjdZY3auU4bPKYCb99tWVuR7MZNUziiabtvF3WujN696z1amIC8AFSPNrr/nWyT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hfFuUruA; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250915040736epoutp01fabf5dcabfb0b118ec6644e1c5e1aa5d~lWSe-0viu0640806408epoutp01a
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:07:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250915040736epoutp01fabf5dcabfb0b118ec6644e1c5e1aa5d~lWSe-0viu0640806408epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757909256;
	bh=btKaJBlrNnrUR0+zJOQEy3Co8PN8ii1OF5xNJWEYFBk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=hfFuUruAsZlkr8fXb8kb9pJVMcYmXdiNY1oIwltR5cC3S4YGpWpgxYy+Yx1zbEFyz
	 Db5qw/hCacPEyetWWnNOq6jV4Hc3bEhDVG57+utO3eL1tO/Cw+Ah/sfI5RRpa529Vg
	 khrGGNUGKzQni0MI3YodvNLyZ4reL/OJwVysoeko=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250915040736epcas2p118d7925c640c42f3435e05266b26f931~lWSeUBN5m2098120981epcas2p1b;
	Mon, 15 Sep 2025 04:07:36 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.102]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cQBMC3Qbdz2SSKg; Mon, 15 Sep
	2025 04:07:35 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250915040734epcas2p4746a8f668f570e362f65ae39cc9e11ef~lWSdKAssU0669406694epcas2p4K;
	Mon, 15 Sep 2025 04:07:34 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250915040734epsmtip10b64002befbd74060737ba3518b84b22~lWSdFILZ73237632376epsmtip1O;
	Mon, 15 Sep 2025 04:07:34 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Henrik Grimler
	<henrik@grimler.se>
Cc: Shin Son <shin.son@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Add exynosautov920 thermal support
Date: Mon, 15 Sep 2025 13:07:12 +0900
Message-ID: <20250915040715.486733-1-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250915040734epcas2p4746a8f668f570e362f65ae39cc9e11ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250915040734epcas2p4746a8f668f570e362f65ae39cc9e11ef
References: <CGME20250915040734epcas2p4746a8f668f570e362f65ae39cc9e11ef@epcas2p4.samsung.com>

This change merges the new exynosautov920-specific register definitions and
timing parameters into the exynos-tmu driver, ensuring consistent behavior
across all Exynos series. All new code paths have been tested on a
exynosautov920 board and verified to correctly read temperatures and
emulate behavior.

Changes in v3:
- Removed redundant commit message.
- Rephrased the sentences to describe the hardware clearly.
- Restricted sensor indices to V920.
- Set #thermal-sensor-celss per variant.
- Replaced 'additionalProperties' with 'unevaluatedProperties'.
- Removed the duplicate #define and use the original.
- Used lowercase hex in #define.
- Simplified 'temp_to_code' and 'code_to_temp' to one computation
  path by normalizing calib_temp.

Changes in v2:
- Replace the generic property with a vendor-specific one.
- Added an indices property instead of ranges.
- Shortened thermal node name and made them more generic.
- Updated the indices logic accordingly after removing the ranges property.

Shin Son (3):
  dt-bindings: thermal: samsung: Add a hw-sensor-indices property
  thermal: exynos_tmu: Support new hardware and update TMU interface
  arm64: dts: exynosautov920: Add tmu hardware binding

 .../thermal/samsung,exynos-thermal.yaml       |  40 ++-
 .../boot/dts/exynos/exynosautov920-tmu.dtsi   |  97 ++++++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |  31 ++
 drivers/thermal/samsung/exynos_tmu.c          | 324 ++++++++++++++++--
 4 files changed, 453 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi

-- 
2.50.1


