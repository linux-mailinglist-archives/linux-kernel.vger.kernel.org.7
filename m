Return-Path: <linux-kernel+bounces-860571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F143BF06E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC9218A200C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B332F6938;
	Mon, 20 Oct 2025 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="OdOpTtlO"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091522F656A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954885; cv=none; b=TiNG6+cNgxqu8sA5rkYHul3tZYVWuVU8oIvb8H5mmFz2CWXcHb8Vc7pjFnf20JSyopBof1c7Mq5HsKrYoOUc6zjiE5TNXCSH+9CZ09hWLcJufltPASr+Lq+Te6E0wJdiC8BSJnrTL8tPyzhpVvwVM2jXDJ34g8kcjI8H0XYTRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954885; c=relaxed/simple;
	bh=15fETiTjB2kpl4NRK6Y1Mwcw2KNt8Ho9rf9d7WhzbD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6NthE50Y04TXwcouqAYWsdsVXwHXXEI71+Jq36mOLHcsUPIFtC6MlYvI4TZ3wYIpF4K5E0LFvC/xTYr39dL5obTI21fgFIYToagMEPdf+anmjPSdrDh/BqLIxGXNT4H442zzWCYKXY4FU4FhLxUnEmc6v1mdPGHSePTxi56GtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=OdOpTtlO; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=FHFcmsNZxPjCN0PuRuFzV6HzJ7Y7FUg2bMao6+29mxc=; b=OdOpTtlOmDz98ST5DMjqWG+Ore
	N+dNNvZvqwWtBy8uhe42rLKvQeCfCzolFsC35+Kn2aVmHwKJmGV5zakGcKh70dsPTBvjSOKF6j+wc
	dKkGjSjKQj6bTXXd8ektKTCJqDOt5oXvQoKQLqpkev+pd0CNLQ5alFvTRwZwPXCWai0fBYrdROGNd
	shcwmvUOphb9hbRP4AitujI9OBP62bpm+cqiz+HQwJ3fJPiGoKgnSsvUJKrQlDmU+b2HIP3nWULB5
	pTWJrjqZQecU/h1stBq9OETrzhc6XPgzqivknGhJPlXrEZrnTNuNYlReSF8fF83kmtpYhEfWLiuCE
	dDZs9kDg==;
Received: from [141.76.253.240] (helo=phil.eduroam.local)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAmo4-00083f-6V; Mon, 20 Oct 2025 12:08:00 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/3] arm64: dts: rockchip: add mdio subnode to gmac on rk3368
Date: Mon, 20 Oct 2025 12:07:56 +0200
Message-ID: <20251020100757.3669681-3-heiko@sntech.de>
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

This is needed to actually describe the per-board phys connected
to the gmac when needed.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 47968032afdc..98d350768fd2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -501,6 +501,12 @@ gmac: ethernet@ff290000 {
 		resets = <&cru SRST_MAC>;
 		reset-names = "stmmaceth";
 		status = "disabled";
+
+		mdio: mdio {
+			compatible = "snps,dwmac-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 
 	usb_host0_ehci: usb@ff500000 {
-- 
2.47.2


