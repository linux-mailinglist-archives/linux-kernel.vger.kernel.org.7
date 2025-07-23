Return-Path: <linux-kernel+bounces-743118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B825EB0FACD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AF8567D66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926DE235071;
	Wed, 23 Jul 2025 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="eeRm4pL/"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5D4223DCC;
	Wed, 23 Jul 2025 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297769; cv=none; b=i13I7p6PCCs8QYyvJNEsoUJhfGNmChCXl5SrVQ9L/v0uQqOElUZPetiMUuXcBL7zHsXKPKIKYkgwG4jZnUwSibY75Rc5bwvvu2/NypqJTSE39HeHjuYVkcVNzlsTEI0jgQm9CQ4UREY7ZLYwlrf9T5hWog/A+yd/dqfGcQXydXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297769; c=relaxed/simple;
	bh=C6Sb8f+sbo7OpwoT/2GY1uDliorEjKd1MCNpkfYwH6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1zatz7N9vaLMmWerVYveSoCJhng2tJljing0dpzqYK7YLrPKsw42WrSMaEGqBlm3S2eHPMTvJe9cDupYFTymuCjDij6hQXK1NQOz8+5KEGGzRvXRWAnz5VjtuqQGQHaCXoBgHtSCy39qjvopRE+Zf1letOur6z3f/Ta4J3WgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=eeRm4pL/; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=Gc7jxMLVybdHk7DgSun6tr7+libXogPdGfREbeOZcBM=; b=eeRm4pL/BTcPjmqST4Vw5jSTRw
	kyw7P/NRIR5G/LTjlkNI0rB5HdQ1+1WDjQvaROGzkwxYUY4ERqD8rAqQgb+VPOWVj1TSSzaNP1+cJ
	2HuAy4BAWLGqEF2SUtgs9z+6rJbf0VPiaosd7oW5NuJqQZIrSoPM/oW4Kyn7PHBh+vhsF1SUoe6U2
	tz0nINYTxY7YbKskJzTqj9pnJYzNGuSnfVDBDO/l5/h3l1HHVEjjheN2FarqWdjbj6JRekirbiy23
	B5h37vyB9NJcZoKsdUlZEg5Gbhw0RbK4EPMC66bwZ8U2frpMe8Lz4Q3IJx6RtAA2ae7vnkWHJaias
	CbvCQY2g==;
Received: from i53875aba.versanet.de ([83.135.90.186] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ueeq1-0007Mn-0F; Wed, 23 Jul 2025 21:09:13 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	damon.ding@rock-chips.com
Subject: [PATCH v2 0/2] Add RK3588 Tiger DisplayPort carrier
Date: Wed, 23 Jul 2025 21:09:02 +0200
Message-ID: <20250723190904.37792-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A board that allows easy testing of the Analogix eDP controller on the
RK3588. Requires Damon's recent work on allowing bridges in the
Rockchip variant of the controller driver [0].

changes in v2:
- collect Ack/Review for binding
- address Quentin's comments
  - sorting in Makefile and dp-connector properties
  - ethernet alias
  - drop data-lanes comment

[0] https://lore.kernel.org/dri-devel/20250709070139.3130635-1-damon.ding@rock-chips.com/

Heiko Stuebner (2):
  dt-bindings: arm: rockchip: add RK3588 DP carrier from Theobroma
    Systems
  arm64: dts: rockchip: add RK3588 DP carrier from Theobroma Systems

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rk3588-tiger-displayport-carrier.dts      | 109 ++++++++++++++++++
 3 files changed, 114 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts

-- 
2.47.2


