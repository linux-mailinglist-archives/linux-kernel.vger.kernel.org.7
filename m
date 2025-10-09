Return-Path: <linux-kernel+bounces-847542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43942BCB25C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845653C15C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073872882D6;
	Thu,  9 Oct 2025 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wz37Bk7F"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F992874F1;
	Thu,  9 Oct 2025 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050275; cv=none; b=GlQBavbnPD+Rl7ETc92rlt7BG2IVPQBlhD3rV4VNW9Iz7jwfLpp50GnhvSI8ce2qHE8j05RjnRQlZEffgK8gWLK9GhtqewpXRG9xaeszADaLtJMzR6TRCmQ1JBMe72H6da6ob6wsZrXDRFK8F49KlPLGrU8IUbrHs76Jv5s4958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050275; c=relaxed/simple;
	bh=jYG/OB9bAIYVEcC3QqWgQ1aF5LcSMw1lQuBwbpZdunE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tT0NrdXjRkuXceeuehES10Rlw543VWgNmA3fkOSKQjMUlnz6jTOX3OIM+jHdHOHIFCm1KlNFGWnowhW/NJvQYkSblUtZ4kRENWNimzIU1jKhyrHZ/nMiLiIMWgXVRMkjUOz2qQCKeps7Nbad3FrIovdypC/lsIMLOrzdWCdW8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wz37Bk7F; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=MPeuMUNYVwG3ymlRhXbc+slsUvOfDXixxwoUlCxd4mg=; b=wz37Bk7FuSpN/XDnoWtOT57Lov
	Yn5QcLwJn80x8mOdAmWIM0Pl+8uH6XQ6a83YjLkvqcGCtri1s4NiExwYib2fv+pUhb/ia+IAhgFyK
	4TWMBrDvY0sI4/R/UqpIKAr68mGMlfemXy22uNIvY45s/cldp+mgrqn/imBFW7E59H+xoK3G5a4ww
	PvqNmaFjjsAqUoP4Fk2/0XjqekvAbePe13g0c5F0HensA1wnhDLvi1LywweT+7Dja3QQ8kOHZPLFH
	m6THVT3pEZSTfhXmjyUqdQy+qiSDY5NtMAq9oVJuqDbZMV51xkL5lhZKt0G9pY9ysJrcj2XpHJ10f
	4d/PJHIg==;
Received: from i53875bdd.versanet.de ([83.135.91.221] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v6zTS-0007iZ-4f; Fri, 10 Oct 2025 00:51:02 +0200
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
Subject: [PATCH v4 0/2] Add RK3588 Tiger DisplayPort carrier
Date: Fri, 10 Oct 2025 00:50:48 +0200
Message-ID: <20251009225050.88192-1-heiko@sntech.de>
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

Concerning displays, my current setup is

  DP-carrier -> DP-port -> DP-to-eDP converter from Aliexpress -> eDP panel

which produces a nice 1080p image, but it seems Quentin's experience was
not as nice, as he reported in v2 [1] that his two test monitors produced
dfferent tints, but not real output with:

green tint on a Iiyama ProLite XU2294HSU and purple tint on a Dell P2319H

changes in v4:
- move hpd-gpio down the the analogix-dp node
  As stated in commit cb640b2ca546 ("drm/bridge: display-connector: don't
  set OP_DETECT for DisplayPorts") the dp-connector can't just read the
  hpd-gpio and mark that as monitor detected, instead 

changes in v3:
- rebase on top of 6.17-rc1
- still should wait on the analogix bridge support

changes in v2:
- collect Ack/Review for binding
- address Quentin's comments
  - sorting in Makefile and dp-connector properties
  - ethernet alias
  - drop data-lanes comment

[0] https://lore.kernel.org/dri-devel/20250709070139.3130635-1-damon.ding@rock-chips.com/
[1] https://lore.kernel.org/linux-rockchip/0582b7bc-e5b2-4b5e-821e-8d2c4301579f@cherry.de

Heiko Stuebner (2):
  dt-bindings: arm: rockchip: add RK3588 DP carrier from Theobroma
    Systems
  arm64: dts: rockchip: add RK3588 DP carrier from Theobroma Systems

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rk3588-tiger-displayport-carrier.dts      | 119 ++++++++++++++++++
 3 files changed, 124 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts

-- 
2.47.2


