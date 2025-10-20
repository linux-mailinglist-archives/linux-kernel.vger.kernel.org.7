Return-Path: <linux-kernel+bounces-860569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92836BF06C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA73B4F132D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A430E2F6576;
	Mon, 20 Oct 2025 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rCM2TdgV"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091D72F656D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954884; cv=none; b=iZteuvTodOljOu6gmXnTmjAeMtLAv8AYuYLJnNTSQdx1dQsI7oSkuJyvFKKlxAn/HSjvjvkDqq6YRvuBGFiWcoBl102OizAvssAlkEG5pgWciF3EL3of+DObevmqooXaLC3MDkk01foYuf9Wa0YRV/5S6aOxOT4xoQJOKO7eLrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954884; c=relaxed/simple;
	bh=7F505EyqfkFtmrpifxRl5wmSCrZThEdiVBnZl7jelyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPwGEeNUwV4B0KFkDah3DXFD39Jkm7Ad7kOG1UQ8BvKhXazbsoOTtxULIyP+0J2vmzvw3f2ba8TdFxBpgCIlKf0oPFQ3/zoqAQrdhgbE7nxjOuLy43EyJe/v6Ll8z8Qh4U6lNdZMSVUAxChfC0WwnOKROdgicpNVct4h187/1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rCM2TdgV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=09O5QDNgkPI4J0LH95vZriOMzylPRPvgRsjibc+KLU4=; b=rCM2TdgVQO/paW6fIz653Btvxa
	iTs+PWamYf6h0kV/WwF1PmzFXZzZtBIOipE/VYCfjrkZt4F674JKtaiy7ZVnYJopGc6bLrTwwxB+1
	pnwgOwBFhX/6texL6G0B8JH2QOHdA8hkUX/+o2tdAbG0gLGo/nncyaccdvDAsHM7WymAO7Y0plpuB
	m3Sh358k/iaO5a2jzL/40wmYwvXNyOxss56f+0H9KchiEvt6fDFsEwkDVlzg7UZTpUUqtHNYtlO0Q
	hiZF6HybGrOnQkzDusNCMKH9EKrpv6jZ3wv8Kse3BU+/+lWvAoUyKyWJzHF0cOmD9Icdkg4jAjlx1
	D4nzK9SQ==;
Received: from [141.76.253.240] (helo=phil.eduroam.local)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAmo4-00083f-0U; Mon, 20 Oct 2025 12:08:00 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/3] arm64: dts: rockchip: add gmac reset property to rk3368
Date: Mon, 20 Oct 2025 12:07:55 +0200
Message-ID: <20251020100757.3669681-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251020100757.3669681-1-heiko@sntech.de>
References: <20251020100757.3669681-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Add the reset of the gmac controller block.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 892d35242259..47968032afdc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -498,6 +498,8 @@ gmac: ethernet@ff290000 {
 			"mac_clk_rx", "mac_clk_tx",
 			"clk_mac_ref", "clk_mac_refout",
 			"aclk_mac", "pclk_mac";
+		resets = <&cru SRST_MAC>;
+		reset-names = "stmmaceth";
 		status = "disabled";
 	};
 
-- 
2.47.2


