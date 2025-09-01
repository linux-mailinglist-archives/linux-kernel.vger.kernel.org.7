Return-Path: <linux-kernel+bounces-793681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDBCB3D6BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D408A3B52DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D91EB5C2;
	Mon,  1 Sep 2025 02:40:56 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348C1B4F0A;
	Mon,  1 Sep 2025 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756694456; cv=none; b=NCBCAHGVh3mpjcJR6+nYJVq3LW99ujZelQ4rBGXsGwhDsct09WL0npL72LNHmiX9EF1zTVW/MEldj6pWh55FUlHPT5lM5XXMIhAwj62bJcEEiDpZdlsr2RFceSIWrzpv2Xwbge4/RotCXc8NiDITOeaCm6PF4guaWtdoCGoyVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756694456; c=relaxed/simple;
	bh=I+Cv8PiQcSXtM2CwDE8uenb/2ypOEo/Pu8cMOSxDztM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BHsNvWZT1oyjEjNLJG548WHKguiR1JyTVAUM+LPNXlFOtIQZeJ7Pz4sWxRSLvWta3CCOfdvSqx89OYWXz1s1gKhff0w1DRxR5PfIYxfSLR6NHyd9Qul0FvgJcwiDSETSGMi66bBV/xOEH94bnBbrTJ2LuekTcQMJo7cfpCybgH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn; spf=none smtp.mailfrom=chainsx.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chainsx.cn
X-QQ-mid: zesmtpip2t1756694307td2e1bf31
X-QQ-Originating-IP: NrLB7mJd79dihQ9nNVJSWFisUrfti/iWIEdFtxameEs=
Received: from chainsx-ubuntu-server.lan ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Sep 2025 10:38:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4630617426018902388
EX-QQ-RecipientCnt: 11
From: Hsun Lai <i@chainsx.cn>
To: Fred Bloggs <f.blogs@napier.co.nz>
Cc: Hsun Lai <i@chainsx.cn>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v3 0/2] Add support for 100ASK DShanPi A1
Date: Mon,  1 Sep 2025 10:38:21 +0800
Message-Id: <20250901023823.75199-1-i@chainsx.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:chainsx.cn:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MwxbfVbCPSF14T74UfoytvhzlkAFctPj+EqcQTm3BKYHwwu/0Mnm2O8A
	ir67ndki4jvnLIPWjzwZqRz8hNzK/4aZkucqUlSLGZ9LNuLtzz0t5yCCdHkO6mrLsM/WDaI
	pWC+Db+TljemlRZKADf7i7i6p2lhQ5/SIAWh4XyABzko0CcVwQlFRuIXe7GSBJAVkKc6ZV/
	LouN6qvRUL29EGDt53VcHH+smKqD/gJkxO2935inQ+/b7OPr1mSRiw/jwU2tM0NJkMM+GGn
	+HKN+ClX2ZBz0pRLnCqgzA5BtmEl0Lw3Yh+qngweIWtefVWSfcFKnfKb9PjCTgEYBadmSWO
	y6nnkuKC8VWAbrTY73tuW4Y64D2LrYTeko2xCGw+ou+/4Ey006SUQf7T+A6ahsPvHA7VUpu
	pabqkkb4l4Cc/shELFIZRlVDYq2qhb8M81m0srWsldbceq3eJ9J8I0bydd/8sDMfmYjEExX
	hno9kKRoqBKbD2T9HcTTfOR5Xsu4+GBBAmNpKRehQuJnckaENauGsPsG3RC1jYUT6ql+Tfd
	rmYOEzfcervZkLi/DGiRueEI5ld42dwhu8tvGslRFCfgeXg/sdokG7h4E8ystsRvRoTcGrY
	vZ0i2WITEUxGZsPQRC3omZuOZse7Z+TTqsbzyVmwCs2yOfDEp8N1Gb3j0nKkcDcOQxDS50d
	4obYGmNvknhdP04SpXiVAW9+66h6OE8vJajFO89iZs787Bd7p39nUEMPXtMxVfIXwldmX0A
	P8Do8zXyWS7Uc1PPNWOjwit5Fm/GQ66O0STAfNzbUgjbXWB+uQC0+SB5s+JOUloHHExS554
	AZhlHSFFMWZEcc5TGVUhjb5JtA83grUEzUOw+amdHZ1CIaPIdaxmNmm/KFqLGBtdheqBAwT
	LbmGncYeIExsWh1E6HZD1u7/kVDKa5mgJPGPIpvNjCEuWX9NhGVntEfQtsohi/NiUuEcewp
	Hd0En3Oa4OXf7ykjd33Yj5qKbrsrtSpxhqoXmIMmE7JS3JWq2RCEwvLFL8HFFCqWlNzZKKX
	7lQiUlZbyjhob/rs0MGj6fNP+jiP8V3aTGLdYkh9LWmUUCAvwT
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

This series add support for 100ASK DShanPi A1.

Info of device can be found at:
https://wiki.dshanpi.org/en/docs/DshanPi-A1/intro/

(no changes since v2)

Changes in v2:
- Delete the pwm include file (Chukun Pan, v1)
- Fix vcc3v3_pcie gpios (Chukun Pan, v1)
- Adjust the order of some nodes (Chukun Pan, v1)
- Fix sdmmc (Chukun Pan, v1)
- Add phy-supply for u2phy0_otg (Chukun Pan, v1)
- Update the name of vcc_in regulator (Chukun Pan, v2)
- Fix PCIE (Chukun Pan, v2)
- Update the name of typec5v_pwren_h pinctrl (Chukun Pan, v2)
- Fix USB3 (Chukun Pan, v2)
- Remove i2c2 node, unsupported RTC model rs4c1338 (Chukun Pan, v2)

Changes in v1:
- Add support for 100ASK DShanPi A1

Hsun Lai (2):
  dt-bindings: arm: rockchip: Add 100ASK DShanPi A1
  arm64: dts: rockchip: add DTs for 100ASK DShanPi A1

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3576-100ask-dshanpi-a1.dts | 795 ++++++++++++++++++
 3 files changed, 801 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts

-- 
2.34.1


