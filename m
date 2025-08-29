Return-Path: <linux-kernel+bounces-791871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0115B3BD18
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C581C86C52
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257A531DDA6;
	Fri, 29 Aug 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XhQnqRZ2"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC827D77B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476262; cv=none; b=CUzJjXhl/UvAQkDUxohCD5YtfqxsRCt3frC+rcDkJNzeja4/RU1+OA/G05fzRxLb68JFuXZxkdKsa4FLri5yNeRC2/bo/ODYjcEEyDbe/Ksst/ayxmOPk+wHYG4MZdSPAznzhwWVO7Nf7Fri4XIlJM3+iYw04sXs4tUxzLKeadY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476262; c=relaxed/simple;
	bh=Ef1NuRo2w2WdhPk8MN+4gOvRdA3R3v+pDc3iILF8sqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=kFFWUwQlw9IZkpgVZUY6Dkmg2e119nE30oQqj5yqNL8X647BTXrAHTiYyKNuw+1n/VaGBYXIW4S/4yj6aKCFY6pXvGXnHvpkBUM0Kc00TTz2+PABMymSK65diTD/26rEV8jQJKoWMFYJ4TmQIQ226zU3quJcNjEcwdPofgoFkHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XhQnqRZ2; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250829135700epoutp030e71f31b5296a294beb342f466e5393e~gQXPhU3fW2671626716epoutp03s
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:57:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250829135700epoutp030e71f31b5296a294beb342f466e5393e~gQXPhU3fW2671626716epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756475820;
	bh=P/PSg7LV+0qqtsWnBqc+ufwU9SbD3VXOH9HxTbYXVdA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=XhQnqRZ20aj3IeB4CADNg0A9R9TWeCz4W+QlskSMqapwucLEj1+gQsR0VVBypvJHy
	 Ckk9k27vHy/5OyQZx5dgMViAR0lhnZCW6DVIUQianAjNZdlMgwz/YRNTEH30X/NCpX
	 FrYm5Tbm5vb20s8Xfis0S9A9Ifppae84x2nuKaoc=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250829135659epcas5p45f243a9e12d857393ecd714dc6c5d133~gQXOyXHGE1269312693epcas5p4C;
	Fri, 29 Aug 2025 13:56:59 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.94]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cD0F66JMtz6B9m8; Fri, 29 Aug
	2025 13:56:58 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250829135658epcas5p24bb23c6fef2092aa7397faa10e0d9228~gQXNRLo_I3096430964epcas5p2d;
	Fri, 29 Aug 2025 13:56:58 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250829135656epsmtip2c943b2ae8c7c97158101f6967f651497~gQXLjQJAl0722807228epsmtip2Z;
	Fri, 29 Aug 2025 13:56:56 +0000 (GMT)
From: Varada Pavani <v.pavani@samsung.com>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: aswani.reddy@samsung.com, gost.dev@samsung.com, Varada Pavani
	<v.pavani@samsung.com>
Subject: [PATCH 0/2] dt-bindings: watchdog: Add support for FSD SoC watchdog
Date: Fri, 29 Aug 2025 19:26:41 +0530
Message-ID: <20250829135643.105406-1-v.pavani@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250829135658epcas5p24bb23c6fef2092aa7397faa10e0d9228
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250829135658epcas5p24bb23c6fef2092aa7397faa10e0d9228
References: <CGME20250829135658epcas5p24bb23c6fef2092aa7397faa10e0d9228@epcas5p2.samsung.com>

The FSD SoC features 3 CPU clusters, each with its own Watchdog Timer (WDT) instance.
The DT-binding and device data is updated to reflect the cluster index and clock configurations as per the HW user manual.

Varada Pavani (2):
  dt-bindings: watchdog: Modify tesla fsd bindings
  arm64: dts: fsd: Fix Clock handle for WDT

 .../bindings/watchdog/samsung-wdt.yaml        |  9 ++++---
 arch/arm64/boot/dts/tesla/fsd.dtsi            | 24 ++++++++++++-------
 2 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.49.0


