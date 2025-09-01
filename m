Return-Path: <linux-kernel+bounces-794464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2F4B3E221
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48DD1899136
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C5C2522B4;
	Mon,  1 Sep 2025 12:01:15 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D76A8D2;
	Mon,  1 Sep 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756728075; cv=none; b=UPASDOcPhXB7Gniq3DAOfv6WYtX4W2QrgaEIBUEM1S8Tfu5C4KsIhZIERvsyhWeEGdr6r+rW3fJLg+hgEnfjAxUp5bHcQDzuLMiRYrH38sriOtSCfU078nDYzxK/ERUVuhGeB6L9YfTAXEgcdPyUJDlyNEoedJNYDqGigsSzHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756728075; c=relaxed/simple;
	bh=Sd/4Fn/fDhIJR8eH4u+iA98zALhcB4J6HidnQDDkU3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l0Xg7We8zbgTgf4TPBHfre0wqb334EYPDfntCSYMqnVyPqODxBeszqv0CD3OVDye2HuOaLfreyBoX8gIPvbVZclue3jwLxb1AUvJG8O60y4ccD2MwncRf/EWAZLq3W13BWFavzkbvZhUmWxIEiHLLj0cOdjxrAkWv9FMerZSoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.212.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 214c55591;
	Mon, 1 Sep 2025 20:01:07 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] arm64: dts: allwinner: a523: drop redundant status=okay
Date: Mon,  1 Sep 2025 20:00:20 +0800
Message-Id: <20250901120020.181414-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a990527058503a2kunm4ecba7364004
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSU5DVkNNHkhPQxoYQxpCHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVCWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+

Device nodes are enabled by default, so no need for
status="okay" property.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 6b6f2296bdff..cdf844eb8e05 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -218,7 +218,6 @@ wdt: watchdog@2050000 {
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&osc24M>, <&rtc CLK_OSC32K>;
 			clock-names = "hosc", "losc";
-			status = "okay";
 		};
 
 		uart0: serial@2500000 {
-- 
2.25.1


