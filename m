Return-Path: <linux-kernel+bounces-816023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F5EB56E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956C3189C14E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270E822258E;
	Mon, 15 Sep 2025 02:24:27 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189021D3CC;
	Mon, 15 Sep 2025 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757903066; cv=none; b=a1qiK0pgR2xWVo1tks0wGZYVLryXiZu0T7H6JvKu4cHbxWep/LxCNURk9SUsR1+XUJh66tKxk4NcE0RBIJDxXSN2PMgjcpw3ZncKHw6AD+OaU0MVKlXkZ5FpwoDGVC0jJgvpbHYYMUvype/oRMi578rmKPGrmMASlaHRuXdvT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757903066; c=relaxed/simple;
	bh=PWwZlOMgQZ5EsTgMntBi+pBYkolk7r3+koDiGloawY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ays2upJA/nSxLpkx1bEJc56/kkEBivCp3U1P6Fu8QqduEodbxRL2saKrwo8P4Rltow+GACy0b3ecppQmfGvV5zXdjxRSk3BiFNnUe1nuLzT7GW4MqUMe2UMolFQOWcERYoOKm4wqnZdLIEGTF6HiMWHozFWIl58j2yqMqOIOOqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn; spf=pass smtp.mailfrom=t-chip.com.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-chip.com.cn
X-QQ-mid: zesmtpsz9t1757902965tcee76ace
X-QQ-Originating-IP: 8SygWpMkLfN+wjomF1uQCBSYsTX1NhwX4hZX4glgh2A=
Received: from localhost.localdomain ( [183.51.120.121])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Sep 2025 10:22:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 254777178612388058
EX-QQ-RecipientCnt: 17
From: Kaison Deng <dkx@t-chip.com.cn>
To: Rob Herring <robh@kernel.org>,
	Jimmy Hon <honyuenkwun@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Wayne Chou <zxf@t-chip.com.cn>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kaison Deng <dkx@t-chip.com.cn>
Subject: [PATCH v3 1/2] dt-bindings: arm: rockchip: Add Firefly ROC-RK3588-RT
Date: Mon, 15 Sep 2025 10:22:04 +0800
Message-Id: <27b2ce7950fdbf28c6c8404c3f8be3c1c35d6b3c.1757902513.git.dkx@t-chip.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1757902513.git.dkx@t-chip.com.cn>
References: <cover.1757902513.git.dkx@t-chip.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:t-chip.com.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OfLzXF8J7RicqsXlIkQfTJro4x3QBkNzd3vqu0LRrLJSvtoXCKbfCqvP
	qUmsIfbYPUbd5FUxyBt3nbUxkfyluE9oyhe8lh3Wb1WiEu2Bd/pva30WiQlXLvKD2n6EF4a
	VqmiO62Io3GUJAyGMfVZothxWptLxIV7jyvLr5Tn24r1F/MpDS8rcELHaG8ZKbxYY5euDmC
	crbi6Wgy8LBSlW9vWpdB2onSeCOe2cIEeMpb6jZb0WZhzWIg8BJb2mT1ojSayiYgsEbWSyU
	TNq26F7ZFSq+MpI6xvkpK9KEsBsSTCuZ8FDL17qOUPb/i8yNJPSgya18kGP4/MWdXet3sg/
	fvfrgbRiF60QK067dh3oIgV1YbEJpywAGol0nm+wutl5CiKVxMhe0byuxeqgakuSZdUOP5s
	QmrvkrfeA7dYcHGKmm4Al8l1RtUe+MfWz9a2nkUdGgcH2Ckjhz596Z2Vw5I7qYKJxHCJDt3
	wQBQ1xPVOF5aQBVu2au0b8cWlYM2lhOMCyGyaaevURSvjUdlf0AZpHY1cRuoKUZztS3F9Za
	TcySivRzMOYFLj2xjlYg8U24iC9K4nQzAOGJydzUU/rULcElJn1pVr1gTRc5lOlTYJCfy5j
	8AY85o1xTtt0XK3r37HMjiv9m9eWXWS1aybMn8dCC6xlz1ndKyErJ80Iwn/32j4mWbfjaO8
	5J7OHFtlfWznw6aBTXpdPwaq6KaJl7s0i7mVMhwp6pHXVoJFHtz2YIM0CzgGkwz4XqukiTm
	T/Lw9wT50Bpd8zIXdHeqCbD1IBFzoGqGCbKy36OHayKqWwcF8d7GV8f8PYw8p2DvkxEXc6D
	nabxqOU7JoOvAEWtNZf660/I8ip2QBwQNWEzYatfaL0++JnuPNhtzifv8nHBbgDgZrAR/MU
	XVk48QdMVokRQycCG7VDHgO/K3YbSOe55Vz4sGgH9lYNHBskDUjNvLcrQhRYH0hMKOa93ji
	MjbWQ32kNh/m1o4LWiQuY+hblwRNhOrXXQkqF0Y0OZKpOZiCv69Y8JNxPwlaFbK+hH664Fq
	67WGnt6416ZCrdYp8Hwa9GiT6Mz3x2567YJ5qPWvBgMht9GLm2QRzVa+JHAhRcKYbo4nI6z
	8VNqlPUU+Jeqg5Kb1YSfDyVLFwgmUIdoVuVvkfRqyPpQRP1M8hAxP3lct5rn+xuHUgzqp5Y
	4U/Q+C7J3Exv0oLWFik5mpn+rbc4Z81J7Ad/vtkOSJ/veAA=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

This documents Firefly ROC-RK3588-RT which is a SBC based on RK3588 SoC.

Link: https://en.t-firefly.com/product/industry/rocrk3588rt

Signed-off-by: Kaison Deng <dkx@t-chip.com.cn>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index f9ee77f17ad7..6aceaa8acbb2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -258,6 +258,11 @@ properties:
           - const: firefly,roc-rk3576-pc
           - const: rockchip,rk3576
 
+      - description: Firefly ROC-RK3588-RT
+        items:
+          - const: firefly,roc-rk3588-rt
+          - const: rockchip,rk3588
+
       - description: Firefly Station M2
         items:
           - const: firefly,rk3566-roc-pc
-- 
2.25.1


