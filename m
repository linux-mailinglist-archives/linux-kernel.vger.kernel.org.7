Return-Path: <linux-kernel+bounces-822416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D54B83D18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEE7483AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5859284688;
	Thu, 18 Sep 2025 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wildgooses.com header.i=@wildgooses.com header.b="Ic5GZJM5"
Received: from mail1.nippynetworks.com (mail1.nippynetworks.com [91.220.24.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC23C2582;
	Thu, 18 Sep 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.220.24.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187982; cv=none; b=c1tN8XeSe0023BcSNA1mGUD8/2gDh3jKnfgeNR5FEuriFoqvZqvElMG7Jl1Cr5J9j2W4ZCrUHT/OZGZMu8eYTuu7XAKXo7kAFinmy0FIrl4IXGZ9gacQh0/3ivYJYejKEXJPffCdGYaSYzuxtPCXAzFt/oWLCKPB3S942jQ9510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187982; c=relaxed/simple;
	bh=Vpo7ZRRZCNMZypv1yIN+qGfh6XwMn0TwsXnwY40oMdk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4Y7O97N9dd+kgEqKO5QGdUBW+aigO38Xvkq8hF7cfM8dgGTfAJNXJpFIzh+j41g3Bp8AI6qmJv3ESLTV1LkCKeWuW1EcTcF0pMW5lYx1G8VrctPqn3xfz+ws0+XCEFSVaNfcMGLXSYB8AQRR8PwE2r+tkQJeaU7EQRgZVu9sHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wildgooses.com; spf=pass smtp.mailfrom=wildgooses.com; dkim=pass (1024-bit key) header.d=wildgooses.com header.i=@wildgooses.com header.b=Ic5GZJM5; arc=none smtp.client-ip=91.220.24.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wildgooses.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wildgooses.com
Received: from grunt.nippynetworks.lan (unknown [94.228.36.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lists@wildgooses.com)
	by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4cS9RF14Z1zkd2v;
	Thu, 18 Sep 2025 10:32:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
	s=dkim; t=1758187977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tc1vqbLWYKdxdC2HbYUBoMGCTCbsrF5FMeM/L5RcKc=;
	b=Ic5GZJM5984XdM2DRZFc3j9G/IxFWtBsnoLYqs89Tak9cL/KN1MavtLM3A9vSSdokNn2bc
	EhocY5Yr/iwhY3hyHSu7h4qUjuN1l5WiLHkvLbPEhs9OaB3+u1gpLLdgwIwr/8iqElCciR
	bJlmqVCvzqPYiVtgI0m+wVqQ1BbU8GU=
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
Subject: [PATCH 0/2] arm64: dts: rockchip: fix dma and pinctrl defs v2
Date: Thu, 18 Sep 2025 09:32:44 +0000
Message-ID: <20250918093246.15623-1-lists@wildgooses.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250917114932.25994-1-lists@wildgooses.com>
References: <20250917114932.25994-1-lists@wildgooses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on feedback, I reworked these patches. I've re-presented both as
I realise that one had invalid formatting (spaces vs tabs) and I've
moved the dma-names definition into the same board level dtsi. At this
point it seems reasonable to also squash the two patches, but feedback
appreciated?

The default pinctrl definitions for the Radxa Zero 3W don't match the
datasheet. Possibly few people enable extra UARTs and hence it wasn't
noticed? I needed all 5 UARTs for a project and the first patch corrects
the pinctrl defs. Without this patch, enabling the extra UARTs causes
issues such as the MMC devices disappearing, due to collisions.

Second patch adds a dma-names property, which appears to be a
pre-requisite for enabling DMA on the UARTs. I've applied this to the
board level dts as feedback suggested there could be unintended problems
if enabled across the complete rockchip dtsi.

It's tested on my Zero 3W board and appears to function correctly and
DMA is reported as enabled.

Ed Wildgoose (2):
  arm64: dts: rockchip: correct uart mux for Radxa ZERO 3
  rockchip: dts: Enable UART DMA by adding default dma-names property

 .../dts/rockchip/rk3566-radxa-zero-3.dtsi     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

-- 
2.49.0


