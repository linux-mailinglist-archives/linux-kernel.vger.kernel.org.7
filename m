Return-Path: <linux-kernel+bounces-816022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A1BB56E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634053BDD8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E90B221DAD;
	Mon, 15 Sep 2025 02:23:48 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A32522A813;
	Mon, 15 Sep 2025 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757903027; cv=none; b=nQ6ZfMxVWymTtuOZryPw9F6Z80gOKojQkzGNOTF0NunMlTH1M2PiZnhrTCqqEDF0+XBK6/H8HequCGo0qI4yc/jMSP9dcEanJOBxvVKgK3ZNS7mbKD6mHaZtUXO60J4bQrJ0oT6QMq/qtZp9mjey0HlsTd78OnFNZDysNKXcUq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757903027; c=relaxed/simple;
	bh=xb+HZOfs3ptFvxV1EQjtGYImBOiILs60XGe4+tUl180=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K0/CDCyc9CFw0+ax/g3n0LDzsfxxi1D1YUKap5ArzLLc7CzNm0Wxkiak+nOXR9egdoGU7AZ33Dw7xzYOY0GpqW6ohtfJqfhtqUWQYrXwYwdRdaaKB4/PWZJWj9trzerApLx3OhyFQCn/fsLs8YhJJtdhA0X3fO2o2i3Z1E5k1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn; spf=pass smtp.mailfrom=t-chip.com.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-chip.com.cn
X-QQ-mid: zesmtpsz9t1757902955tdbed93ca
X-QQ-Originating-IP: zIT1IbJ0qW2TnaG8tjt3QQf9A/JGH1fEpFPpzLnG+5U=
Received: from localhost.localdomain ( [183.51.120.121])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Sep 2025 10:22:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8988539609789202725
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
Subject: [PATCH v3 0/2] Add support for Firefly ROC-RK3588-RT
Date: Mon, 15 Sep 2025 10:22:03 +0800
Message-Id: <cover.1757902513.git.dkx@t-chip.com.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:t-chip.com.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MoSajO47Aaee+UEni6K1QqgsKL2pcVxijYtol3cDicoG7vETWyU7Ggft
	+11Zar6XN777Ols42ij/DeRKWHQCCmxpPEdTj7HbvE3n22y2+0ubmkk1vO+vha8y9TsaFqI
	yLnWIcUc0nXaIUWJY7G7IINm4cGqGs/ptQVHGNul5jyRhumC0LvvU2hlAymks7n0SA3SPaJ
	FDLyHjaVoQiav1YzLGWWlnCgiG+xTApHCwhhfY8M5woeBmP0XxwFdrHibFstTPLW3UN5Z0N
	GgT6ey6p7SbmN6xLIAWn07cJIolbTOAw1nIeIzM0jCkkBQMwVZvg5wVlJlkwJqzmpBNPPne
	8zVot5PTXpPoXOQtOGD1S4IPqiiGGLLSc7b+oAE1e5yrTMDQFO9gJygHwHzIsWA0QyZ0YhW
	Bbv6AQN97CJX5iEFlemwlkkQdgWxXe3O86t7HOWB5uCqwsNVaUFvUIEgPdO0msWLOZnZMd8
	rBoXYSZj7hZisCm0Ov5hJOaIrg51hVH1cCrZRKrQl2I2+YPWXIsA3I3ggTQ7WTdcnwoPV3i
	aJJZxDdb6P5a+vBf+Md0tro+UjZaKO6xyUZB56YkbXdw4M8p0/orz9atpTAh3WZwduk9RXF
	E2n0fbR2QQHtooNnNcedBU0nba466WJF7OqGaCNShl8uUiTiiAeaZaTizKQfEJuYY4l0NGE
	FYklHpaoJWX8xbVt4idCIW2FgBACA7RrxF1JR87+TdnzLZkMRDvlMV6FBbpDOnOf5aEsHtk
	A7+zSoXh0DzDG0NlL7J2Ko+sE0vz70REHGtId+rlckUvTuNPSw9zr/XH1MgoIBE2jxtemt/
	2EnCpMQ1HcQW/sLXbO1zYjsnUXU8+nzBzuYIJh4TCxIDx50bK18kr/KX2WFiveVHDCSUeb/
	rJSud870MSWpx+m9kz4F8TyKNcArKvuMdPA7HSc6/s6mXb9Qx/Sq0hY42jimm3T1fqT5g8B
	E3x9wW27TvsejDQp0OswRrFXw2MzJPUzUk10nTAX7jr89zXhAlNAcuK1MkaNYBi1mPNu09o
	WpB9ijcbZZvF2LlDw5/h+4qFp6RjmVpcwNOs0T0OhBX4a7zcEa+8K0k2yKmNaKnR6kzInpp
	kQMjDNOSfS3RcuaOHwEK6UW2HGY0XKVFZTlEqO60M9YpNiXPPmGUVpxboVV2fdLew==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

This series add support for Firefly ROC-RK3588-RT.

Info of device can be found at:
https://en.t-firefly.com/product/industry/rocrk3588rt

Changes in v3:
- Change rgmii-rxid phy-mode to rgmii-id

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
 .../arm64/boot/dts/rockchip/rk3588-roc-rt.dts | 1134 +++++++++++++++++
 3 files changed, 1140 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-roc-rt.dts

-- 
2.25.1


