Return-Path: <linux-kernel+bounces-832114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30363B9E600
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37A71BC7A66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA62ECD13;
	Thu, 25 Sep 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cbz8x5ly"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F62EC56A;
	Thu, 25 Sep 2025 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792647; cv=none; b=HZsx2ImOjUEI8b2F3UP9EmyKqQ+az2zP249wqlGtqynXjROSiwbv4pp44KIsptZ8XpjFr8VjX7+PAYT55Of/mv2oymmLbbyczg0aJz35Xb101Z2Np/hPRFm5p54bU4lCuIqkCgOjdLI89ev6DesJGKlpyQZ6jDpkWsVgYG7c7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792647; c=relaxed/simple;
	bh=UKRt7srO3wUjaepu84EGbvLIdtLH2Qx2BZwqtEBaKz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hkl1LHnc+bf/fGpSIQAxHKukq7kUQI1l68aSr3W9DQgMJB9r+f/1mXlTmVqOLnTEQcfoFIjZOWvcnz8b5jZTzdG2H5NDODL5OXqFX2hgI6zslODrmbsChK2bC+obQM1VFwlIZMcXVYYW5P2jiO8KDjA8v6GduoVdihxPAMnaj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cbz8x5ly; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=0EZWjrAJ2CRU7AyqHp2SXperS3Fl2HqgdU2yfdqsymw=; b=cbz8x5lybjSxmkU/605g3Qhewj
	OHcUgsnwbO2GfKZJSAs9Imw5ZFficCLTTKeewIGhhht+INv2j4DDXGWCQ1bJsRuKle1vZ7DTV3qYq
	peGbi8unU9YziTBgTdBB7bTfvCrqsYg2A5/CbIuvtYHI6WGeX3Km1LWJ4h/SJrG/nUCFGnatLIpET
	MxBl4cAy3njoe7E+3XD0BAuC5yey3dX1qKAHlH3vLGFN8t9Dugulqa8RkuUCZ7z0DjD6s17Zbb2oD
	1Cf3+58dsS5SKc60B/hD8tFOpDlateQSK1wY0Om13ppwiSv8P1B7JqGSQQTO+aq0mGAEvNLh5f+Nv
	no3zZwAA==;
Received: from i53875a54.versanet.de ([83.135.90.84] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v1iJE-0001Nz-Fk; Thu, 25 Sep 2025 11:30:40 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ukleinek@debian.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 0/6] Some cleanups and addition of another Qnap TSx33 device
Date: Thu, 25 Sep 2025 11:29:17 +0200
Message-ID: <20250925092923.2184187-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the 2nd network adapter on the TS433 and adds the TS233
a 2-bay device being otherwise similar to the TS433.


Heiko Stuebner (6):
  arm64: dts: rockchip: move cpu_thermal node to the correct position
  arm64: dts: rockchip: Fix the 1Ghz ethernet on Qnap TS433
  arm64: dts: rockchip: describe mcu eeprom cells on rk3568-ts433
  arm64: dts: rockchip: move common qnap tsx33 parts to dtsi
  dt-bindings: arm: rockchip: add TS233 to RK3568-based QNAP NAS devices
  arm64: dts: rockchip: add QNAP TS233 devicetree

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-qnap-ts233.dts   | 133 ++++
 .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 606 ++---------------
 .../boot/dts/rockchip/rk3568-qnap-tsx33.dtsi  | 608 ++++++++++++++++++
 5 files changed, 785 insertions(+), 569 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts233.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-qnap-tsx33.dtsi

-- 
2.47.2


