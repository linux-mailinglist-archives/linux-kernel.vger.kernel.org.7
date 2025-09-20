Return-Path: <linux-kernel+bounces-825777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7637EB8CCD2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2811B25530
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6FE306493;
	Sat, 20 Sep 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdpzhaRE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01C22F7AC6;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385493; cv=none; b=BjnoEY0laGQI2mRQ5SRmjcMpR3yuD/DlIYhOrf9k7jcnYvqobFC0DKeappiGB3i/2dqabWx/oqhi3hnrOlpZc/4loVqdJYWkw/gGZ965gzjHjYPeKY4//Pmq/dThG2NqT3VS3eEnGmmZj2DLugo3QRZAYgo7WWjYy973o93Einc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385493; c=relaxed/simple;
	bh=wmglTdOzvnu1osT4KrcPRK2F9+u7HUzFQhkD3GLaJoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2nTpA4UBZYxErQL3nuYS+BfW7kPkBIMNOimyGOQCscJK38wv0bviJlaLYUdEkHOGhZ9j6nraMjFDtBAkHyscPb+pJbj3v7/nSDrRcoOQaqGWBxLgRB6sZ5m+Nl2KM7Pth9+eIgcws2/qMC++Sza+vhAofqGaYbWUVsa4oT1W60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdpzhaRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 664E6C4CEFA;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758385493;
	bh=wmglTdOzvnu1osT4KrcPRK2F9+u7HUzFQhkD3GLaJoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IdpzhaREvgAq/lTr4gTriUHIyxCA3wqGmRdDHZSvTQatSslcjFkb5ur8pnBWSxY6h
	 JJhWA+W6+ABPPkryP6N5+e3VSr6s/egFk5uY7dcJ7PhtigMejK88LhOCxoYrEfrXuc
	 umY7loUIaCUZZQj/REdDP1gktzuOIhHHFyR3M/WpAnZcwyUOaPbxcgf2c/Bd4u8V58
	 1SbwTGMT2ihdEFabJstE8mUaHgJ89KFCESLZQg4ent4JnDpe/Oi7KIqBjrilMF6h2+
	 tkMYGWtKFtbIllPovDExgiuqe3fGYb/bNl1H0zgfDCYavbG2XvkNg4Gl1yWR7kjD3c
	 mjbIaqBp4XVOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4A5CAC5A7;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay <devnull+cristian_ci.protonmail.com@kernel.org>
Date: Sat, 20 Sep 2025 20:23:31 +0200
Subject: [PATCH 06/10] ARM: dts: mediatek: mt6582: add mt6582 compatible to
 timer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-mt6582-v1-6-b887720f577d@protonmail.com>
References: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
In-Reply-To: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Cristian Cozzolino <cristian_ci@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758392693; l=1128;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=r6SXHQbEHcaMnuM7G635DvBb4GqKr2d885SMc7iqSiQ=;
 b=z6YTtrGMN5Tgfi5hnkCwEdqfPbpmjia5G5oRbA2+IRGF5mPfUNLHlgAQk0ZuNJvauGoo5Me3t
 R8K3WtIxkAJCQdUJ9uVrnv16xY0b3iunHZm/GNJ2V73/uCjtEtDAHBq
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
Reply-To: cristian_ci@protonmail.com

From: Cristian Cozzolino <cristian_ci@protonmail.com>

Bindings already have mt6582 compatible for timer, so add that to DTSI.
While at it, remove clock-names property (which is not required by timer
node) and fix node address.

Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
 arch/arm/boot/dts/mediatek/mt6582.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mediatek/mt6582.dtsi b/arch/arm/boot/dts/mediatek/mt6582.dtsi
index 8a14dc1759d6f65fa75accddab83c1b6424d1632..54d675ecb390c52c7ca0f406155bfc59e32137ec 100644
--- a/arch/arm/boot/dts/mediatek/mt6582.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6582.dtsi
@@ -66,12 +66,11 @@ watchdog: watchdog@10007000 {
 			reg = <0x10007000 0x100>;
 		};
 
-		timer: timer@11008000 {
-			compatible = "mediatek,mt6577-timer";
+		timer: timer@10008000 {
+			compatible = "mediatek,mt6582-timer", "mediatek,mt6577-timer";
 			reg = <0x10008000 0x80>;
 			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&system_clk>, <&rtc_clk>;
-			clock-names = "system-clk", "rtc-clk";
 		};
 
 		sysirq: interrupt-controller@10200100 {

-- 
2.49.0



