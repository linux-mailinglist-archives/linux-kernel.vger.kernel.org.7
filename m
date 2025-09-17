Return-Path: <linux-kernel+bounces-820589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D17B7C612
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652CB1881B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AD7371E82;
	Wed, 17 Sep 2025 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wildgooses.com header.i=@wildgooses.com header.b="bmE4l/oz"
Received: from mail1.nippynetworks.com (mail1.nippynetworks.com [91.220.24.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891B2C3261;
	Wed, 17 Sep 2025 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.220.24.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110085; cv=none; b=VmLIQvRZdBsSOW6KaKHdWhno+DU0mzSSvc9nrM5/9SFvwwp+ganTMIs52zd6hFnkjRpH1NBXhb/gYhe1xWWt+LABUCPuSKxp5j46SfuMp+5amXyXyZMiQrl5hPFH1Xb7O2ABergbYUtTPImtOm8coLqJlHTwfZMpkykyum4lAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110085; c=relaxed/simple;
	bh=denyi0t+iIrj1hhs1gcM+x4fviiNYp0SHlSGp5y6UzQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UPv/k6noPQcs/OP+ROSNH80uDeFLqpfwEiOx/J1HlmPsqiMwJusNr0p2oAZBRQZwp14MnHfY8rh1x4Ib1C8GtsQHiedN/MupCQVIHEGCUNH+mTY2UvI2wwmnkBRQGEhVhkgiiC3NUVTrF8PTQJOvWY1ltfnsddSjQcL3CHSr1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wildgooses.com; spf=pass smtp.mailfrom=wildgooses.com; dkim=pass (1024-bit key) header.d=wildgooses.com header.i=@wildgooses.com header.b=bmE4l/oz; arc=none smtp.client-ip=91.220.24.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wildgooses.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wildgooses.com
Received: from grunt.nippynetworks.lan (unknown [94.228.36.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lists@wildgooses.com)
	by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4cRcYC3FT0zkd2v;
	Wed, 17 Sep 2025 12:51:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
	s=dkim; t=1758109871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C3JLm+WtAgOBOP5ZX8TVm1Cp5vhXuI2GzWj1bb042eU=;
	b=bmE4l/oziTF0VmvvghpjBK3QAb49FXUE5rBADlKvSbHSr3lK9Wpj2rWXJ8iBGmy3m7olQU
	1tGerj1aotI0U8cQOISRLXp4zBnrJL4kqT3AMXk2bzCUyqchkEbCgPRfsbL8xbvTI4RL6v
	KkSbE8V9DN8Vjuz9X0cjY3SrPsk68p0=
From: Ed Wildgoose <lists@wildgooses.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ed Wildgoose <lists@wildgooses.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: rockchip: fix dma and pinctrl defs
Date: Wed, 17 Sep 2025 11:49:29 +0000
Message-ID: <20250917114932.25994-1-lists@wildgooses.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default pinctrl definitions for the Radxa Zero 3W don't match the
datasheet. Possibly few people enable extra UARTs and hence it wasn't
noticed? I needed all 5 UARTs for a project and the first patch corrects
the pinctrl defs. Without this patch, enabling the extra UARTs causes
issues such as the MMC devices disappearing, due to collisions.

Second patch adds a dma-names property, which appears to be a
pre-requisite for enabling DMA on the UARTs. I've applied this to the
base rk356x-base.dtsi as it seems like a change that should apply to all
SOMs? However, I confess ignorance in this area, so could I ask for a
second opinion before anyone applies this?  It's tested on my Zero 3W
board and appears to function correctly and DMA is reported as enabled.


Ed Wildgoose (2):
  arm64: dts: rockchip: correct uart mux for Radxa ZERO 3
  rockchip: dts: Enable UART DMA by adding default dma-names property

 .../boot/dts/rockchip/rk3566-radxa-zero-3.dtsi    | 15 +++++++++++++++
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi     |  9 +++++++++
 2 files changed, 24 insertions(+)

-- 
2.49.0


