Return-Path: <linux-kernel+bounces-793691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E4B3D6D8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D681896DBC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1D3214A6A;
	Mon,  1 Sep 2025 02:53:15 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA538212572;
	Mon,  1 Sep 2025 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756695194; cv=none; b=e3zYQeb9JkmAt6NO7KxzZgXrwnn+Z4S2RHI9zxYCg+euwEFVFgd5Epc0q/mBBkd0g5k/2gtu0e2Q/g4cS3pOCfxZLdXUycFzGfiQaYwpcRcS2AAM3F4XD3BpDkxITXxR32pzp3ntwDVgd8pTXXUciN/bkn0GUWR8jEF5t1yb3Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756695194; c=relaxed/simple;
	bh=C1oUR4w2D4vfePiU+8EoHjtmudu/vxsFw7sq10XfzS8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VBX634HPrj/RWCYcEJeBLrG5otqy1cDdabQsqbc45uhvCakmNz/LYjysMp9FQUr7/oUGJbbySoi19lSK63yGEOWYkimsKX03lLSqqieqe56SCOKreckDh1iCOs89ap+jmL+kc+qJRnR5OfgUv6H69jMqvh+krqVUavlhSAjslLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn; spf=none smtp.mailfrom=chainsx.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chainsx.cn
X-QQ-mid: zesmtpip4t1756695042t09f9844e
X-QQ-Originating-IP: inLk59jgu4rpfAkLnWECGvGqi7aoweVxElPZLVfOMls=
Received: from chainsx-ubuntu-server.lan ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Sep 2025 10:50:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12657077797693184159
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
Date: Mon,  1 Sep 2025 10:50:35 +0800
Message-Id: <20250901025037.81548-1-i@chainsx.cn>
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
X-QQ-XMAILINFO: MEfSrlLLfgMrvUHZOaV9S9TDClVc4goCp2856XzfhJTy55GiHayrICyF
	PCl6He7EgEYw/iovBsXGJjwh4Ku9yqGZAnR9kfEwcVu1GB24KHOUu8TF5IoGyM82HzAmMgc
	67wGmToWjV3r4hNCkIPtMXKelXlKOoSdbY3je9EkWtR3h8m9VIb5crtYgWTZb+x3wpcMgjM
	SdsCZqTWc8j1RMW6gvjk/G8/um4VAiplN2R5ju4QQGLPvChUQwTNT+8K3HrRHiPhW6F0oNG
	gFiNdxGbvVI8OydRioSASaaf3SEUJW8jY5xDrefXwx14DM502A02CFy9x2xxo6IManj8wLy
	XONnGQySrgmhfMn6owBa+dBVro0PTybFkh8C9RwOM+NHtSEmF6b14bqBrpqNDiM9G/XMXaC
	cvMppmgWzurQmMvq/JmNBpAhER7M+G2x784Nnay2bXW2HsJijX04Tnj39mB9st/Iwj9OTgg
	M2K+Wzqs9xzjIRZstZwn0M6q8eSD/S0ionDq8RgOWsune9CUqMKLiFNAFLtDC9IcdVL404n
	+8O33hfuVKirDcu+xO9uWTmV7crTMSQleONhN81fuWPpPa18lBhj/u/u4jR5IMgNvb7gR5Z
	B0dFeHBGznCymB4kS8w4mGMLJExApNXvtfUV5vBuCK3wCsxGJIHoapkAoxZEMmqv9030Xsb
	IlTAZtsw1JVEdOT0FoRUnqBRTzDokGRWHscpkhkxJRUZOO2guSZOHN4MwsyItHqwSAKhEGS
	P/uBbYWw8/ds4+rx/O++zuvH4n5YXN0oEfTSElyhTI0zE4aXjnDnxFT4KqKp3I8mJwGeRSB
	UVM+S/XEN8YQvPcJz+033fP4Y40pk/lqfESZ5C9CnulI6324DhRNphcWYTud9oHbbxmcX1+
	MSGWMQT4NiARWQKpl35SKqDfAkyPSV6zOUi57GgotZe6DqN/lMeof1JhqzB+uF73uCqqsXD
	7MN24xYygaaHhmtNlT9tbnioJJRVA4NKBrkLY9wh7RvUnoudya3paoX5QNE4+SU7xHMlpNX
	OBedgenukcSGs13ic3mAx8aDJl7s3+Vqnww86O/1MclerFIDdqdC4kR+mSt8b1mgNibUTmh
	+rVvot8v7Ba78MY7992kog7jjcXRuISjGOE8cV9Jd8qVwEe0jsKKT0=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

This series add support for 100ASK DShanPi A1.

Info of device can be found at:
https://wiki.dshanpi.org/en/docs/DshanPi-A1/intro/

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
2.34.1


