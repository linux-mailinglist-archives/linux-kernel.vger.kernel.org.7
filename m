Return-Path: <linux-kernel+bounces-767918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD21B25A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CD21C254FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228801FE47C;
	Thu, 14 Aug 2025 04:33:39 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6611611185;
	Thu, 14 Aug 2025 04:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755146018; cv=none; b=m37NYawKytzl/0vUskIkublsH36z7t7ODgeGJsX8s2CPKTI+3kiIIE6NVVwI3ueO/tPN6yohMvPJv7rEkS3UbzOgjTVMs7DfxZq5DOKiWi3l4bKlFuCYQxE73ELIkP/fSpcJoeJ7U7CSLgI0AcZZ9OaA+H6kxkS5UTNBZDGu8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755146018; c=relaxed/simple;
	bh=0UChQ8NT6vgwHUxSU2UAnaKaxvepeo0bFHfSHBvALBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M93g5wKf5IGRnD+3UMYoeg6U+7Cv070DIPwQ+hlENjJuDKQOo1FJQNkzIQO7GggZ1GLlNH+8IB+oZ19Nn7iMHZNwG2scKmrFZYD1Z+1WmrPehDN7tNhJBpzHcwLUQQVgPxYPIE6aIx5QaiqUTb6oa6ANcZXJGzpyD2K6nRU6gYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn; spf=pass smtp.mailfrom=t-chip.com.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-chip.com.cn
X-QQ-mid: esmtpsz20t1755146002teef8830e
X-QQ-Originating-IP: Peg8pNWex+cqhVtTMZ0ezMqa3HAUy9biynpsprY/6KQ=
Received: from localhost.localdomain ( [183.51.121.135])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 12:33:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6940595432327476163
EX-QQ-RecipientCnt: 15
From: Kaison Deng <dkx@t-chip.com.cn>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: honyuenkwun@gmail.com,
	cenk.uluisik@googlemail.com,
	i@chainsx.cn,
	damon.ding@rock-chips.com,
	jbx6244@gmail.com,
	sebastian.reichel@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kaison Deng <dkx@t-chip.com.cn>
Subject: [PATCH] arm64: dts: rockchip: fix es8388 address on rk3588s-roc-pc
Date: Thu, 14 Aug 2025 12:32:30 +0800
Message-Id: <20250814043230.2774813-1-dkx@t-chip.com.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:t-chip.com.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MLtv/SBKWfQ6vyMfDVz14T/w4Z88LK3E5Ts5efiQ8sb49PfgSJ5b7Vx4
	xT4huA5DNZaXqT7RQ5VkuQpi+V8aEcuuGCyBdjIQkGW97Yqaqw9INZ7DREWu9q6oyp6vv77
	fAXJsk0sNhAKkvB+8iwCTCLOm4DwqVRCtFTBC9pGfG4ZzvcWwcIAj58iGzckFBeIK320u6j
	qN7ak6Lk8B9cfE8JsmUJNfGMD8p1BKX/G8w2gijZYVfWcVzb3A6JOZ8zU87a0jSs5dPADVg
	tdZtMhXxfMDULWmERN5U4WPq0sXT3h1OA6m+ea/wsq9vFnLQRzSly8TvQr/sc35aj+pSu6Q
	ZLG7RsA0+PBuVV69493q0VzIir/dUmb8gCZh1gicS1HRaeSOUTihZaU/dZJHH2bbG2bTe44
	D3TFgWp0/rL8BoSE/cTiGNqq+xfRNxzBvdh7yMRYfUxDMB84KVZrTuAoWWbxtxn9kA2B3uf
	9TSy7bREcPWMPQsv2BSvLJua/640KZPTkOHsOYnooBL16A5X30uF//30gG5iqjobd/J2kUK
	3ZotavFxG6Wzvla1KFmceVHaWSdhdHA2g6tOy0Z8M7b8rhGqbrg18kqP3HbaqmJ6zGgBOHy
	xhfWRAWz0ih6m34IjvwFGxmn13Ask7RW/EZauYkqgiC7w18KXe3ge7sP+3ozjvajME/AFdY
	I/3VD5Y249rim0xRNPmPK6PncPvZIxcCw950sTD9Thv8ypFXTeKfcftAShijUtUWYPf1Cfi
	o7C48soGuf6lOdRaAK393QcJ9IP5LVZwwVnbTGlk7T1kmnQB9DrjqLr6f6pgl/PZ1vVdZsr
	CWGjOjgMd8xSvUt+1g03a9fLngRVqNyTvY/CMWP5U8eWcUyDU8nfODG+ZW0fs+iQaz7bFK3
	YZUwi844i9aziaipOGEid9DtiDTP3ENUdB2JuzNv3cxFFn2nPaGXyO6qFZ7tjq6vTUeUEo5
	ijzgXEhIKgKokX5sWDIAGCrlcgxaYRILKuAKGY3hru355G2dpi21xVeZSzr4+1MHP9BXYYB
	nFJ6HKNzRiMb9pQN3S5IpuWnu7HTcu1oy8v0mgmfwsYPuJ4zQ2YXZVePGegoPOXL2v0/Q6E
	A==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Use the correct es8388 address for rk3588s-roc-ps

Signed-off-by: Kaison Deng <dkx@t-chip.com.cn>
---
 arch/arm64/boot/dts/rockchip/rk3588s-roc-pc.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3588s-roc-pc.dts
index 7434ac39246f..7e179862da6e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-roc-pc.dts
@@ -320,9 +320,9 @@ hym8563: rtc@51 {
 &i2c3 {
 	status = "okay";
 
-	es8388: audio-codec@10 {
+	es8388: audio-codec@11 {
 		compatible = "everest,es8388", "everest,es8328";
-		reg = <0x10>;
+		reg = <0x11>;
 		clocks = <&cru I2S1_8CH_MCLKOUT>;
 		AVDD-supply = <&vcc_3v3_s0>;
 		DVDD-supply = <&vcc_1v8_s0>;

base-commit: 7f0817eee7ba40b48e956955d6fd8ba14750168c
-- 
2.25.1


