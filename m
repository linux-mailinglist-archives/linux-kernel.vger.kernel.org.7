Return-Path: <linux-kernel+bounces-760691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F16B1EEF1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4E91AA8096
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250492877F9;
	Fri,  8 Aug 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="luyk3vpZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630E13790B;
	Fri,  8 Aug 2025 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681772; cv=none; b=LhG50N2YVprLRrYdVOY/vlL8rmP0Vq+LSMv1wf3k25sXXagvU89JXvlvhO0RnB7GbUqKdtRt03EC9tBaOjIkmExS0BcbTsmyfqIVoANHEuqXaoqwwvGJdchG+5xUiIRqHJq2ly5HvXUpHfq7fNNHiAUKery/Ex7pe2SFW0Rm9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681772; c=relaxed/simple;
	bh=1S4gIsUy/lP67CX0Xrs0Zs4bAm7U3GED0ShLh7xGT4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VuUv8EfHdKafdevd3UzwlrCB4N2bXzJ8Qau7vQG3Ojj/IRdmOVZni8uKSWE8ODCFAxSzXpiM5kRmx7gPiSiFTWmV3wa/QtYmq7LIOPLDoLf3IyEZBRB1V6Nex4+G55DPt1b7+MkuwLYq4Aq/k5FteizeT4buvXCT4OG9K6/o7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=luyk3vpZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754681768;
	bh=1S4gIsUy/lP67CX0Xrs0Zs4bAm7U3GED0ShLh7xGT4Q=;
	h=From:To:Cc:Subject:Date:From;
	b=luyk3vpZZleLUQYOIfaTqEaQsi2CMvz/TrDYdnaOkJKrBYG/VaDu0UPjjloLOw34/
	 QW1T8u4Vxk0x42MfzoLRwvGbOI5WR7gPIyHmardIs7uwtJnNFjgNoD7bV9C6BMh/1o
	 n5GKzAhtdNAKeDZxiykac45FHF3oYLQ4nizUKS7OqcHems8+OXQpI2pux0lNNU+qoG
	 VIbO2riIdyMnfy/PbfBn/QPzD2P62OWJZ4Rfjgz7lTWWXJ0QqN/CTLrlksmr9owHXT
	 LelojNN1riLUDLzCoFkhIBDr0x7DPmjtNLmewnnCTZkocarhleco8RwjNL3Fd+pegU
	 0J3eFmdsx82QQ==
Received: from earth.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3535117E0299;
	Fri,  8 Aug 2025 21:36:05 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Niklas Cassel <cassel@kernel.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Alexey Charkov <alchark@gmail.com>,
	Patrick Wildt <patrick@blueri.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Diederik de Haas <didi.debian@cknow.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 0/2] arm64: dts: rockchip: Add vdpu 381 and 383 nodes
Date: Fri,  8 Aug 2025 15:36:00 -0400
Message-ID: <20250808193602.142527-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the nodes for vdpu 381 and 383, respectively RK3588 and RK3576.
To keep compatibility with older variants, the reg ranges order is not
in register order so that the function reg range is kept first.

Also adds the corresponding iommu nodes.

Regards,
Detlev.

Changes since v1:
 - Set node name to match first reg range

Detlev Casanova (2):
  arm64: dts: rockchip: Add the vdpu381 Video Decoders on RK3588
  arm64: dts: rockchip: Add the vdpu383 Video Decoder on rk3576

 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 36 +++++++++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 74 +++++++++++++++++++
 2 files changed, 110 insertions(+)

-- 
2.50.1


