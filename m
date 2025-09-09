Return-Path: <linux-kernel+bounces-807002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 953E5B49EBF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A8E7B2730
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E122FDE8;
	Tue,  9 Sep 2025 01:34:28 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355221C9E5;
	Tue,  9 Sep 2025 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381668; cv=none; b=AEwL1DstT+aobFkFdVK0NGrA0FGQCwe6ZitWj+N2J4W77/PvngsmhmNzkn7LwsCY8hbKTNK1R+KiBzRPJpLnca5mGDh2aFsUCo1sjDngMJG1ZZ57QAjxq+Vh9/sDy43fjyltPXREr/o+SkCv+gJF71CzAuyS89BkLGvjOArDrIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381668; c=relaxed/simple;
	bh=GR5EMTRphhCH44tJC9xw/gzcmFFoMIZVZOMaa4839k0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CYB0AwyUatzw91V6rVEl7ztW44CiLzUIQ11xJtf06FKfsyIobrpQpTmkslzHCO2UA2GF1uAvxC/IfjXnYhxaNY4jB2uCtqWBaBC0g5HcCyhrf3avJAcGv0BOA8c8m1DHaX12VjOT2kSt4+A57XDZ1SuksGMOId/8pi3AJ55hXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn; spf=pass smtp.mailfrom=t-chip.com.cn; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-chip.com.cn
X-QQ-mid: esmtpsz16t1757381621taf35abd6
X-QQ-Originating-IP: GkvDGhRfvU5f3ziOtpKn3TX27MEXcp6MDTyVpMjXBxk=
Received: from localhost.localdomain ( [183.51.121.90])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 09 Sep 2025 09:33:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15890518757870112891
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
Subject: [PATCH v2 0/2] Add support for Firefly ROC-RK3588-RT
Date: Tue,  9 Sep 2025 09:31:46 +0800
Message-Id: <cover.1757322046.git.dkx@t-chip.com.cn>
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
X-QQ-XMAILINFO: M/5qe47GLMYO7J3VNDqF1neGr/2SGH9GQfI+Yb+JBzt0PyeyHldPYxhu
	nTNscmx8DcEdnlZmVGHoe2HT2d754bxzchs3y3qGSjzkADBgTf3g3jCC3TCnFTSqZYH1H59
	UJ4Gqj+Hz7gsB9Jq87pzkHGi8vktb2y3YAgITx+wOrv6lTIqq7JBBld8X/oBBmnx9v4zgQZ
	RTMAtY7gmAjszFLLIBG0rbbUV0DyL99+01Wnt7UYB+irVi9ub+OOob/1LnT0Qe8S1HcL1Vx
	YYQwKXnDrZIO2/kX+QC+rPwXomU8T1BHkfc+P7kf10xhB+pn+cg9/TTCGxxX3g6ezRMG7sr
	pcc1xxq4QxjAd8mSfcbvjY2m+voS4vQC7n5dSjOf7JWKo6NLmd3IIfvyvklT1G8zgQD+4Si
	gV9dQQmMAb92S7JAMpkLKKH3CLv23TBkeOxz0yZ20+R4Y3jLS1vHvJHo5ydrYXBU+Y5Q+cW
	LGTagn8Bg1QxkP88DQ9ZeBJIPVxfgC7nFVHjaBEQQlwwjB+iKrfEVmmQJWvyoM0OjdofNrM
	aQwhF0xD5WJiOFZ7hwwjXFmkDMafrNm3UHZnxf36YeFUwS3q0sQmr0xsVyQu/62/ukF32g9
	3U/qTS1Cg4bCsnT0/c5fvrFt5ok7HX0iPIg+3Tsjww8BLV+5hfOZdzG0/vT/McXN2X5KHg+
	HTNbLfdjMwdmY/kaDSkDDutl4a9c7zMM1C5jguwMQF61Vp2IE1yEl+zz1FsGdN0816ZLG4B
	vQ11YDrBCRzE+EpdEH7MY9SOOcMnapdQ82CCrOoNkrQjC5Lx6cE8uwTNb0W0nTWpfUt8BCl
	lUbNugkDuCaVG3hrwPAYxDPQVH0uqcGiGOFma5ZGOhlJ8bTNPaHbdFxswNbjVXhFzwetZDI
	CuntXKsSghck7RxKYM/4KScB9O7+TFIkGF4ntq9jPiZXTgNw+RoXSo2V5O999DSK3WBs8jC
	LWbNSt4Ogaay/qux/75GaABhv022FWhmJopsGjVAhZKcuc9aPAh51D393R5f9JfquyG8OdY
	tpupLAZn6XFAuKvv2TsSCLBzRiDZFtwmaYv3HfT/3mQcfOCdx4GD9JBqYuLXvLOQ/i4GPhf
	JTe7MgfffV0CN9d+SuzUxOLayoaQ7WD8svBYIzCxfp4PCJj2Vx6bQTDg/3d0ShFLA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

This series add support for Firefly ROC-RK3588-RT.

Info of device can be found at:
https://en.t-firefly.com/product/industry/rocrk3588rt

Changes in v2:
- Add devicetree binding documentation for the Firefly ROC-RK3588-RT
- Update the description to match the device tree
- Adjust the descriptions of the model and compatible properties
- Add audio support for hdmi0 and hdmi1
- Adjust the attributes of sdhci in alphabetical order

Kaison Deng (2):
  dt-bindings: arm: rockchip: Add Firefly ROC-RK3588-RT
  arm64: dts: rockchip: Add devicetree for the ROC-RK3588-RT

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../arm64/boot/dts/rockchip/rk3588-roc-rt.dts | 1136 +++++++++++++++++
 3 files changed, 1142 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-roc-rt.dts

-- 
2.25.1


