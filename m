Return-Path: <linux-kernel+bounces-734106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE4B07D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B88507B22
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DC029B78D;
	Wed, 16 Jul 2025 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="FcsGtWVJ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1822857DD;
	Wed, 16 Jul 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691837; cv=none; b=QK/EbLm4hFbawkRQe7TORUvZpmxbTs0pTTuSqpdC/0tHsD7sye1RRuyZWgJpYu3u1P+eNy63tFRj+2P8xcXjFjoIF9IGHoECB5wBtVLOeGTG/iH8x52oraAE8B6iCSWK9KHcTSfsDPWbRw99732mDdGo246xvUWVuhqlGkU/F/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691837; c=relaxed/simple;
	bh=+Oyv0b7CLGfmarCRE3R5PJiXCS03B/SCHCAgkikL12M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgQz95tpHCGG61ulGBWZNOkTC11cJy+AFPOfokCdnxe6Tw1/Llm6NdIprZ08Wbn9NczioSUInq38DvLd4s9lXCmLGQKiX+CEnS5L3w4DRnTesHvomVowwHqTa0AaDhvZIABCDk5ltZttfLvhxRDuiCeX+M3Xu0cDc9czV6bhs+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=FcsGtWVJ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=fYPmBx734h8aMVi3LVmqJ5rE2UTZl3oi7MbL+EzuaaU=; b=FcsGtWVJjnpVFq+nyaEvhMIFq3
	zl1a/Px9fLQQA6Z29+QVZCdrEUHr3CP1O2nYM+MsGWC8/37X7ZVwxUWs/mmrc8AFHbIr6he5qbW2a
	cAnpMwqXzsTSnw0zuKGwuxwY5h/WBiGgr1VllmZqOQpn8IX0RF8pg+kj+HdcSv/JZEqZCS1dG7GmL
	jFC+LvbnAHRzA+ApT2l3msLBQC3tTG67CH8tvAECTEki8bwBrI4BdY0qpSLbYIXZXuY5NuZOYUHQc
	8ePuai3O6tT+EspH/YHlSCazXtgPiBWPS+6sVtsmfGJj14GusPybHqsm62ISPY5SV5vIv6k5Z++uH
	rd/hacGQ==;
Received: from i53875a74.versanet.de ([83.135.90.116] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uc7D3-0004Hf-FG; Wed, 16 Jul 2025 20:50:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	damon.ding@rock-chips.com
Subject: [PATCH 0/2] Add RK3588 Tiger DisplayPort carrie
Date: Wed, 16 Jul 2025 20:50:25 +0200
Message-ID: <20250716185027.2762175-1-heiko@sntech.de>
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


[0] https://lore.kernel.org/dri-devel/20250709070139.3130635-1-damon.ding@rock-chips.com/

Heiko Stuebner (2):
  dt-bindings: arm: rockchip: add RK3588 DP carrier from Theobroma
    Systems
  arm64: dts: rockchip: add RK3588 DP carrier from Theobroma Systems

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rk3588-tiger-displayport-carrier.dts      | 118 ++++++++++++++++++
 3 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts

-- 
2.47.2


