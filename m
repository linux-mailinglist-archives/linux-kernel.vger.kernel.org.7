Return-Path: <linux-kernel+bounces-898230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03DBC54A50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E573E3A3502
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14512E2EF2;
	Wed, 12 Nov 2025 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Xb5mpiC/"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6B2E283E;
	Wed, 12 Nov 2025 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983740; cv=none; b=InoR8S6DeOo+OIwu6JSQNtCuY2mYmsnnqygNJtXbDXi+No/5/Gl57cbdj5n0Uofl2CchLpkwe3Oe/lHUeSQfJsBzSX9qIMZp5nYC7gbqSvvsvJOTLyDv+aPYWT9R2HTRnoatl8P1pJfdv4EmBf5sEGVs49c7e9wY6wgiHcdutDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983740; c=relaxed/simple;
	bh=M/S4kur44JVP8CpAn7ihJDTgtaDjMhfXYbDXoeGhmU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RoiVEaFXAex5Ur1FhVH9hhs5DthEULsWdncZreFBFvPFz02F1Be11dbM2eGl94mhIi0ChmG8qRPCOY/EC6Q21EoKjPopVOvpeiY7/I8XTVjrXyP9AWZ+iIqs0BKiCMJmtG1kl8ASLOMBFZlfwy5eqf+rJ0Ta7R7rjGplta0uub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Xb5mpiC/; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=9H6Yl33lWxFcL5cnXd0ZwovzYtSFUimaXUf2T4oleVU=; b=Xb5mpiC/qSge9jpy0Gl4gHLvVR
	5rq8G4d+oHppBvCulVXB7HiRNj/p/CeGMYfiOudvYbGzKksCkF1rpDIDtoV0jCRB9MUlElvATfpZL
	SeLmkgUI3jOeC8Lw4O2GynQx63LNxMpiEyXlvW9ViVAwJ4s3h+eAwdcnmfbV51bKzt0OccGndjZ4A
	pVv27p5JaRUaicA1mRW4vMPoP1iQfrI8edt100vgWYMX1Tdtf/ooMQhLjc96DK+qJHy4lwiOzouEv
	W03O0BRTtz5TmznEvqFuAtJ29aYWeOCb+QXkqslk7HqsUttSgLpk58hUJJZGFAhF7Hf0L5ChONiH3
	2WxgYgOA==;
Received: from i53875b63.versanet.de ([83.135.91.99] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vJIbX-0003tg-Um; Wed, 12 Nov 2025 22:42:16 +0100
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
Subject: [PATCH v2 0/5] Some cleanups and addition of another Qnap TSx33 device
Date: Wed, 12 Nov 2025 22:42:01 +0100
Message-ID: <20251112214206.423244-1-heiko@sntech.de>
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

changes in v2:
- add Conor's Ack on the TS233 binding
- drop TS433 ethernet-delay patch, as that was unneeded and resulted
  from me doing wonky stuff during testing and are completely useless
- drop tx/rx-delays from new TS233 dts as well

Heiko Stuebner (5):
  arm64: dts: rockchip: move cpu_thermal node to the correct position
  arm64: dts: rockchip: describe mcu eeprom cells on rk3568-ts433
  arm64: dts: rockchip: move common qnap tsx33 parts to dtsi
  dt-bindings: arm: rockchip: add TS233 to RK3568-based QNAP NAS devices
  arm64: dts: rockchip: add QNAP TS233 devicetree

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-qnap-ts233.dts   | 131 ++++
 .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 604 ++---------------
 .../boot/dts/rockchip/rk3568-qnap-tsx33.dtsi  | 608 ++++++++++++++++++
 5 files changed, 781 insertions(+), 569 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts233.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-qnap-tsx33.dtsi

-- 
2.47.2


