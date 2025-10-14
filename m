Return-Path: <linux-kernel+bounces-851685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD409BD70E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC7864EDC30
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292ED3043BC;
	Tue, 14 Oct 2025 02:19:12 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48170303CA4;
	Tue, 14 Oct 2025 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408351; cv=none; b=PErJJILvoeQWFEQQebwv+rpHRpsYXJkVuhhn1hA7WH5KCyzhCEhODXCvgxwZvettfRKHhwMUhDEyZCzCHFOJvaf48oFBJBMLjNaFjd/ScwPQu9hk71Vq0v8j906qKr0YxlRl3XKZ6xAkcHou5YFrgOoZcopZE2w5dwxi6RdQYc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408351; c=relaxed/simple;
	bh=HVpVRrmHJlqJmF1o/ezJZ8hp0mzfHJeinjOifMtTY74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sY1H6sthsRfp7/7V7gdAWR5z9m0xDNNbzcsGNjxdx1in5WgkyZJCq8MFxl6hL6Lw0bzlV692AMbNfxBgeKYY+f2StzrxA9N+qn2EyCWepZplbnLkPPViJsRwQFn7A8YPveZusEVedq8GamsARj9C6RvcmSTTBV82EwaAJwAAVi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn; spf=none smtp.mailfrom=chainsx.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chainsx.cn
X-QQ-mid: zesmtpip2t1760408189ta749c9fe
X-QQ-Originating-IP: GM/C8VTwsjaS1Wi9rzAmIB6frejU/WcqC/QEBzy6m6k=
Received: from chainsx-ubuntu-server.lan ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Oct 2025 10:16:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4392001371169270697
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
Subject: [PATCH v4 0/2] Add support for 100ASK DShanPi A1
Date: Tue, 14 Oct 2025 10:16:12 +0800
Message-ID: <3559F82126DCDA36+20251014021623.286121-1-i@chainsx.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:chainsx.cn:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: N7k3iE00JiuZFQe0rE85YjVL1V8x5yUhmtOb5CTUfbt0zIcVN5K2nF5F
	A90PsrPZ6rjBnebmgxG/fXSlapyCG3Itcw2HEE3qC40nEfI6t8fHiQnWccVqTwYrLm5TNhO
	E+0sObvfCGlCOog1fVKD+1HHmVcNDLtpt6grl8qBgTJO5a4jCAPjy65Yc2zhzp60HTM9kbm
	kSd9InAMM042lEIwi6PeutRW/spJRgfDS/5aVnLxS2HAe0IcK1Qp5nONTugtzuVvEbTGugp
	pIf+O5WBzDbrUm68ls1UHE+FzRDAwY33gUhOkyNhc2gyzmM6LuVVxLKOETq3NAjAW1x0ZKi
	i7XVrr+yKlYBXOTsjBVCKsQc6cysu5SEHw/Fa/wp41gOEGtL6Z4M5U8Q5Fpih5767KbTXJ1
	ecEDuECWG+mJ5aUHiv82rrjB0lhykKeE3hcdNB7zeaQfsCSr6VYSFfk7CtGEnBUOZm6fl1T
	49a5bdemslsORi5CwuaQ25+nDNU7j6fW9UrjLVqpO6214P8XUO2w/BRKto6sgjUsBKTL4yZ
	YIYr1OMdPDg7I6IP0nFp8kY0W3BckAR/YIsa5wKf1tNvilK3dJumV9hHaXzXQplXO4poZaJ
	qluLUINffrw9rHdHbELR+NNWRA/c7WObZ+36s+iEZNkm27funLEGmoJVYXFYABHmwPYI3n1
	IKA1pwIKj8gWozy5NLNeoZU+yj4MgokwLFL/m8xQWFh+bHcSVEl+E2QTgw1xGAsCfrojXUZ
	eDwrNME99NNCubx+K2yRJBat6h/p0wY1UmNghnDvXBKqB1ybUSY5lfyRXZD2o75QHXh3nPp
	gOoouFmG5S6sUj2gblS7tkxKaZaQG62QwpLjbr7zBXu0cUTm1KIWrnxAg8mdfMsfsSaCR2r
	DYNKmQWW6pbyuNew4+LQS/sVBKt4M2b1xsFS0ugn6S+5Qguh8Go9l94rNIL160Aa39sTvLS
	umDz0g4YIECuqD9wPgE0o8rtpG6N903PebydLBfOmgz7U5I6jWzE5r6/6eE6jfLjpRz7dDF
	XIRuzlZS4KI3tL8vMoUi78IXAfcnI=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

This series add support for 100ASK DShanPi A1.

Info of device can be found at:
https://wiki.dshanpi.org/en/docs/DshanPi-A1/intro/

Changes in v4:
- Fix PCIE

Changes in v3:
- Update the name of vcc_in regulator (Chukun Pan, v2)
- Fix PCIE (Chukun Pan, v2)
- Update the name of typec5v_pwren_h pinctrl (Chukun Pan, v2)
- Fix USB3 (Chukun Pan, v2)
- Remove i2c2 node, unsupported RTC model rs4c1338 (Chukun Pan, v2)

Changes in v2:
- Delete the pwm include file (Chukun Pan, v1)
- Fix vcc3v3_pcie gpios (Chukun Pan, v1)
- Adjust the order of some nodes (Chukun Pan, v1)
- Fix sdmmc (Chukun Pan, v1)
- Add phy-supply for u2phy0_otg (Chukun Pan, v1)

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
2.43.0

base-commit: 7fa4d8dc380fbd81a9d702a855c50690c9c6442c
branch: master

