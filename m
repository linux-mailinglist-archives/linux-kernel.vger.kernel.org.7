Return-Path: <linux-kernel+bounces-778996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939B4B2ED95
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B35C39CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01A32C11E0;
	Thu, 21 Aug 2025 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUhvOiMV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C9241679;
	Thu, 21 Aug 2025 05:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755754186; cv=none; b=iTIgHWlI1l2XBqP61l/wL5WpF5GBnDhZvYOAzZu1WAN/RWAf0Z5oVBnh7WHJvWhqtXQpXCxA7RjdIB1IEkFuSAJeMWDKpkZQKLPM5Wj4KT9Et1kcQQAEP3HsuqPDNQApKC7KHrxwRE5z924al/zgfHyOVcthLv0VsOpEn/KAt0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755754186; c=relaxed/simple;
	bh=okRW6FFazSlKUnEisFp7x3V8vbljvh2Ty8xEGZtNcDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pg1G1+2Yyq6f4y13r3VyDaYa78k/91DIxEAMSyfzGcm99kcGAp1W0iEgIH4/FskQhKGtpl0d113yY9AXA77PaL3t4+XPY3/V1BAEOhxQ6KNoGnQ7UnZE2qV+uVR0DzA8jWyZ1wZ34GaA0iJVEteXx1jLg1CNYqK5qt1Y9TBHpbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUhvOiMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B327C4CEED;
	Thu, 21 Aug 2025 05:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755754185;
	bh=okRW6FFazSlKUnEisFp7x3V8vbljvh2Ty8xEGZtNcDM=;
	h=From:To:Cc:Subject:Date:From;
	b=fUhvOiMV0uLCi8BqtXnIpiPSOVnByxHq+hizLdvyE3gl8E3jsx36yX8KrdLWTqfs5
	 Ro/K2EmyJx5YrK2asUgQlnfATVohbSfivo8s91EwBhzHc0Hm5Hgt3lC34isdy9jGqx
	 3qMFTvDfGO45qv2VHEynRgP6XG/VqPbfCivfPTLtmhmIaZ62ti+ccDUTy3ACD1ZKKO
	 QUeDzqq3HTA/hcxzDkgr5wiaHY0Zm/iOeOKBCsmLga7kLy4b9Ubiff6mKjdE/rm7JK
	 orNdpjf6+1RMfnDf6QX01zZ3mCoNb7j+OlbazBSVp4+WuVCFC972LRQr08AH9b+XU6
	 rxM7XcccZXxLQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 8A9725FE2C; Thu, 21 Aug 2025 13:29:42 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chen-Yu Tsai <wens@csie.org>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rk3588-orangepi-5: Add supplies for eMMC
Date: Thu, 21 Aug 2025 13:29:39 +0800
Message-Id: <20250821052939.1869171-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The eMMC description is missing both vmmc and vqmmc supplies.

Add them to complete the description.

Fixes: 236d225e1ee7 ("arm64: dts: rockchip: Add board device tree for rk3588-orangepi-5-plus")
Fixes: ea63f4666e48 ("arm64: dts: rockchip: refactor common rk3588-orangepi-5.dtsi")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
index 91d56c34a1e4..8a8f3b26754d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
@@ -365,6 +365,8 @@ &sdhci {
 	max-frequency = <200000000>;
 	mmc-hs400-1_8v;
 	mmc-hs400-enhanced-strobe;
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vcc_1v8_s3>;
 	status = "okay";
 };
 
-- 
2.39.5


