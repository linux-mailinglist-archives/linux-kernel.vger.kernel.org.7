Return-Path: <linux-kernel+bounces-751662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15CBB16C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1307E580BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7671A253F2C;
	Thu, 31 Jul 2025 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="I5+qkNu+"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC613D52F;
	Thu, 31 Jul 2025 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753943201; cv=none; b=rrydYAkj0iZjadMysw3s2Qa0tFpZXCJZcojGAWuJWmJMmfvndFSdVGhUgCHBVhJAwC44lPucVw/izZ7Yph5PgHr9Jw5raV8mWDlAUrGJ1+jfE1aSKZl6lgwh0s4AxNvp0YTVqaRr/ksJbzV3MdL1zSos9znjT2TJIsobK6Vir9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753943201; c=relaxed/simple;
	bh=PM3yueoThv4/yVwquaywYcGevdIzRvmAY/QtcldV1qk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hRh0hHKj3sBlkUENm08BTYtV3+Ty7PfoqceZhMiqcBFpXRTjiwuEbYQ89vZs9XhqdKB3gruMGJZgRE4u2efn7w5BiNfkItj95J2Nyznht5CvXYjOCk+9d59fEud1LObxq6Aim3YY10Wk4cRr4QV7i85BDPxr1lVWLB6smosmaYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=I5+qkNu+; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1753943111;
	bh=/XZRRwln8zZt/L+45jSn1EDXrXjAeJJRPzpTgOE9Ijk=;
	h=From:To:Subject:Date:Message-Id;
	b=I5+qkNu+J1dYX1Gm56VcXpd06JG9sC8V9NjHV9Of4AyZuRVEoAQzdSje0NmVKD5rC
	 JNAzBjU6po+LSw8P6HpxTPyJmmLtQWeqzlGGn3GY1CTIyis0EW49PPOTZps2aUiI8u
	 7i75UKM4IhzXkARd9qVPEUa8CKl6a8v5vFq/DFwA=
X-QQ-mid: esmtpsz18t1753943109tfcdbbb8a
X-QQ-Originating-IP: 6KrmzkmmKpLZr/I1Po+usBh5ILwo6prMsK8XHxjwqzU=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 31 Jul 2025 14:25:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2550660293380765054
From: Chaoyi Chen <kernel@airkyi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Enable eMMC on rk3576-evb1-v10
Date: Thu, 31 Jul 2025 14:24:15 +0800
Message-Id: <20250731062415.212-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OBlwWD/GWDEoG5KfjqtGMt2cKFbPfOq0mbLLJXO9w1LxbfhDAXz9GTkU
	phIO/mlxZMk1gcZlf0bKJ0TFe7A+LVoaOFS2YtJ3BvE+EQ9IfPUVSPzeid98b9mkDM9YP9Q
	26RqaCR6GOcDWtF8kh9uqcVSkLH7ta5ecvmjolr+AiVTQityNsqgdW5rZeJpI22m7Y2ulC7
	RqruWiIvM4DJgdv3f4LDQ0a47ixIHYm45zo+/TwU4ypEsFOiziPQvs/9ST5VEZ08xBiPe/A
	a6ODyv4Qw0nbyCRS7wYF/WkvC25mJymftcoAjRZkz6c1gUjUHmJg6SLUWQ1LFCeUzkAFBdX
	NriBvOxJ+h/qMmp/edle5pHZEG/lJM55+lLG6bBmvTbSpNxgT5a8KXHsAND9uXJ8zp9kdsW
	EyRrXKbXv4/JqXwqfaZvwoYQqioNJnOxEl786fOQAh1bnGVLrIjfYWdQXk1qxI6l0kWd5B/
	Fv1PFDUH7im8Zl14FxOPF9Ecxf9DxvmgTx1SkwuA3Wn9K/d/iZ4Ml/mjcE2gyJndgzMCCne
	Xf1nyz5rFLLbYTq2cOVkLqsKPe7ZG6ua+Jgk+Se9N747QLYNdEwWqbiB/DaPP1RHOJBrwH+
	ACsjrCFD+6pVcN2kGdWnQ4XUT/Lfe1ChYh9MLi+J/XmZvn8wq/gTIrRV4kPm2IKaxllPDaQ
	xz7WIaWCb1auAJLLPCTlO9TzXAKUIP2MNzbQatpHWZRNcA9Detf0oKEZ2Paa7BC9cVCbFXE
	90NlUAJJZf085kgbshKBlv1V6SVqZbMmR7bOMSdu86WpXJKiNOAkwKcgukZzP/X8dDRXOaU
	XHOyfjlOKnbM3gvN7Bt1gK0O08RLcbGuF/ZW1ImwY/HAj7wfItCH8aNbAHR0MLRuc8NNvpT
	CzAit7E5tuaRnDLKvYatQTYJgTDG+dbhNhDvkkjj/9xdFhtRdNd1B9p/C4fOLNHrc8zseuH
	QTCOaiiFKISIAM/9YVLNCkCQREzBcxW8i2cE=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Some rk3576-evb1 boards use eMMC instead of UFS. Enable eMMC for it.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
index 56527c56830e..a60dee0de9f9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
@@ -723,6 +723,18 @@ usbc0_int: usbc0-int {
 	};
 };
 
+&sdhci {
+	bus-width = <8>;
+	full-pwr-cycle-in-suspend;
+	max-frequency = <200000000>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	no-sdio;
+	no-sd;
+	non-removable;
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
-- 
2.49.0


