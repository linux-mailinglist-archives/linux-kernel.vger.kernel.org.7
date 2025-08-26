Return-Path: <linux-kernel+bounces-785877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A2DB35213
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB8A07A7273
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05C92D0C6C;
	Tue, 26 Aug 2025 03:10:58 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B81163;
	Tue, 26 Aug 2025 03:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177858; cv=none; b=QbHiUrRa/vWB3neVH1iZ/OqtTSpnKzwVbPeAwAW7mZNxh13/o+Qc4siN1It3f93H1Zk/bzWaamojL/DCQ6Tl+xrBqP3zfNFQ/m+WZNiyN05q5+beS4P+tX8ZAG2kpm42R/3ur2UgRhWJtx5tUZP7NPBe1ZEJ1GbR54szgqZUaEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177858; c=relaxed/simple;
	bh=AHElAJ7fo4dGD2XmxNk8k0lFHI9YlUs91t0/V4rTw7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hoX8D8mtd2fy2w9CxX5/91OCPJQ9/B/IcymZHJgG/fc4iXFbEOc4PUgkANEaHqiZSj6fEiMsPv4q8CVD4XLOkXogSw2o2X3hahrFHBTziHvNZigQDT4M8UcDNvpCGM9gROoIgEsFwxnMaTjmKNt4Hg3N/wh+zietiieqCyPSNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn; spf=pass smtp.mailfrom=chainsx.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chainsx.cn
X-QQ-mid: zesmtpip4t1756177704t2fb025d3
X-QQ-Originating-IP: kXz62wQIAgQ5fDoxb092TxXaej+6UJKZlmADOPHVy6k=
Received: from chainsx-ubuntu-server.lan ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 Aug 2025 11:08:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15050431008221731089
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
Subject: [PATCH v2 0/2] Add support for 100ASK DShanPi A1
Date: Tue, 26 Aug 2025 11:08:15 +0800
Message-Id: <20250826030818.3485927-1-i@chainsx.cn>
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
X-QQ-XMAILINFO: NSTsyPg8kQQYEWo4wIjbJseHhQwT0UXY7NtBwCn1y7wOdMfP2wp9QtJT
	VW9udeaOBGlStOqxHWfmUaMi1W5AhERlNoEz46AMYu1b2+8Xh/Hs5jJ5fl2mhbdqESOHxad
	/aJga6v6P2K1OdxkJAmMN587nVc7CPqpfAkWKgUjnJyeES+xyMTW2J3fcq7ZHWH82nfUSaT
	Kwv+aNmxUsyNwouYMmqvFDh2JNQnaH90iEit+ygSnv6EE7xzHwiyVyVfUewii77SiGcqZd+
	LuJW3YI6ih7RJKE1+XzQT834QLt+j0bJW79CdgM2Tx7uk125GrTv+pXtVd2kENJWz0lzQpo
	GLcJfH3K6rKfLd76clGpF0pfqMh7mr5b944iulTPvnahX4mf69hg2q/fEiCIJ716SxVUUUG
	hNUEMD+JGRGYMeLRwkPIslnEqlIz1ZpUaJkfZWDpNBiFFj6K9+Y8DTFmAOwUcBDqVlCjW6L
	cDzi+70+4nlXJ0aSCv0F657uzg9HBFXaUNmnJPXBsuJANHsP9xi/CMfTElEPDTrEEpih1t4
	eSM7ZRxzabP6cF6SQgxOMBUzhM8FG+ioqSGc4tFaBWU3MoWCEgJ6A41vX5BErzdUZNJYYl4
	0KlEz1OIhpZhQFjykICZ6Fbh3ws7TX4AXuqI2bVGmWeIxa2yziQKdWvKUT52XC4dbzUa56t
	fJ0CC2jV7IyWLhnt4Ph92En8xyQ+rGqc5W6uIkY3WtLWcNYaibEAUBpJxYd7oEN1ak+L4DQ
	AbDnF7E45/7ZLTRdPi2n/PuHTkh4lyiA5w0NwA7twSdNysE36dA1JBfs2mhc04QUW7AUCOZ
	iTQrHcLaBqfu2bBspVLLC9uc1ZkV4ZMwEgirk5LBIJWUVVrq7qB7CG/rbBoEFEkm44icZ6i
	M9fRRi9TEJeCvHMRPMpjP5Sh34ixghP+K50Zc49r1btQtObTyoaPtwCo39sPQHRufQw6pi4
	g+cDPk/G/L8JhTscZWxEoNhfjf4o/FWSzeGUnNYdk21fBpw5T+IhWaXntMAvZnxlqQ9RCjV
	ZRa8S658WhsXJoFyMaz5hDxR3/NiWVJIW9VIC2exd45rEnVHcB
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

This series add support for 100ASK DShanPi A1.

Info of device can be found at:
https://wiki.dshanpi.org/en/docs/DshanPi-A1/intro/

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
 .../dts/rockchip/rk3576-100ask-dshanpi-a1.dts | 838 ++++++++++++++++++
 3 files changed, 844 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts

-- 
2.34.1


