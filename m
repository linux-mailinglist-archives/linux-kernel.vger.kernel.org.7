Return-Path: <linux-kernel+bounces-807001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B346B49EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BF73AA810
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811F122D7B1;
	Tue,  9 Sep 2025 01:34:17 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6421C9E5;
	Tue,  9 Sep 2025 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381657; cv=none; b=uslfwgwdabw7kQ976MxFkSDc103lek0J9sdeCsXvMpd4apgzaq13JdrsVxiHoMjs3VbwNINy3+l/OjZcR85lsp5MefUDuFRWOolH7MIF9DDaJEBj26ydatKCk74CB4ayFK0ksddAgtb4Gb9+5QhoKg1bhp2zJEG8peY30hr+BDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381657; c=relaxed/simple;
	bh=PWwZlOMgQZ5EsTgMntBi+pBYkolk7r3+koDiGloawY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fG5Jd5F1whbozY4bPd2OkaL8VPHnsUH/FzrhSGqMfTqBwow9mlbNEMgQqvbVJcE1eLGaLSZ/7HMJ/30jRjdFsosTt6TGX0sorO0yqC4OS/Ml7LGCwPYT0R/V6sCGnUIIJ4NsMstLUc/J+bX4x7naX6zv1b1Ll57RrDmiWNhPEf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn; spf=pass smtp.mailfrom=t-chip.com.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-chip.com.cn
X-QQ-mid: esmtpsz16t1757381628t9ba36c9e
X-QQ-Originating-IP: Mh/hsRNNK39po3NG8qvNWg5UqjGRImn/yE4N+a68b9w=
Received: from localhost.localdomain ( [183.51.121.90])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 09 Sep 2025 09:33:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1423506342381787432
EX-QQ-RecipientCnt: 16
From: Kaison Deng <dkx@t-chip.com.cn>
To: Rob Herring <robh@kernel.org>,
	Jimmy Hon <honyuenkwun@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
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
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add Firefly ROC-RK3588-RT
Date: Tue,  9 Sep 2025 09:31:47 +0800
Message-Id: <27b2ce7950fdbf28c6c8404c3f8be3c1c35d6b3c.1757322046.git.dkx@t-chip.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1757322046.git.dkx@t-chip.com.cn>
References: <cover.1757322046.git.dkx@t-chip.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:t-chip.com.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MKaR9rzCpvw0jKGvvVVWo81KjrVT6EWIy+fh4qImaz9g1TR8ddlV5hlA
	peilBeaV5S61bOqEMDHsLVgqq08ifS2oyIHzcYYyQ7E1vLC2A96cUurQf5KB7HIP8KSVT6V
	l6MRrZk9YimixCzZKdM8gQNgux7C3KVUcvSR8vrrpHD1EPJY6JCl7Fg0FySVA02UYK3+3N3
	0hukTUDL+7Yg3znivmgaLOOVcrWCSGCIs6PJ5q+l08Zwq7/IoqBL7cLviOxFSKVWfm4pWEz
	OfeZSjlS/ch/EhukWNs4+6Ouz80m/BtWjdSzcv3chRv9t9WKKp4HqZjmmc/0J6CqWGq5lR9
	VKGxFx1GpMffVkdR4P7AbzxZyhXBjPe4PHHNW+kPpN2EQWDJMyFHKlGT4wuJEc8DJJ89qR/
	/OZFHWMCYyp3S1OHtjUSIE585UWQN31X+gRfxJWITJ2B30FmcNiTTWycVAs8x0HgeKAAlUS
	cP4hYAcz5wjSC97kh1uS+WYxRowEFjDuVpUY8lV5ID6Bl1Emk5o5rI7UvCl67aklMAjIrGY
	K9YaT+5CX7uSUt/pP5DY8opDseX3+qrdvNBZk5dB9k6Kq7+briY5vCa0Zms31hvVk/ibJG8
	2fcBmrhYgMKag4ZJRqrX53zFsDi8taaPkMXBaK8dchNilVmQgyJ+Cqcq8tbrVaAA64W1AT2
	sR2q1OcVo/bIXrA7wefwXbAegfle+sttZF/PlHQeaFIekBFwYtTwLPGvgktB2QR9sXCWW0L
	APYic2/YBBxlbPiLKVF73hMIYr4an91g/y/cO35y4vHbMvHx5l6KCJVzJdoad8B1OfaNCKJ
	jU3L8/vFUGD+LoHe794DKJHt6mm+IwZcO66f6bnunpASIHRuSBAKmOrqHCYdBv+kLug/83k
	MYvdQVMR24JwUB4lz7/MtuvoxHcGtWtUnPVb3hO+xRCp5ZnN8TaZa+VC7008nh5unlFr9t7
	aMGJyHXmG9460U/fZSuCEKuTIEAd34vkeoFi7x7iTrr4t3Mskz7UJ23/20F3YExy3tvLmhi
	FiIqOd0lpR2GhpnFoLo/ym2ClvYzHsjEenFqadRD+cW8MgoZeVKMEZU08Y8LDJMLmfwC+/v
	KLFwYmjxqeq+eyxvY6cNr+A7wrZ8QTaiw00Ee5mvpuThKpBhCIX/LM=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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


