Return-Path: <linux-kernel+bounces-826066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F588B8D727
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC0D17D5E7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4C0246333;
	Sun, 21 Sep 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcYkOQeU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6720F50F;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758441860; cv=none; b=FfQdsmeXZ916bFDSNejIO5o0+JuDGMfKib218v76yvzClRoqeJCq8gbpGnVXvYTCDTYNTb/hoGFZt/mudpfR2uZVkn3Dl5pd2ItlNIHwqx5R6Lc783lqNc/A1sjBQn8w4fpcvnrdAQt4rlgCSSJrl2cGExMBIW3kHOZ3hjjOOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758441860; c=relaxed/simple;
	bh=FgPJvqpqOwscoSmbcR68/IeWY3DU89hmprNU9y1mNWo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=La9LMrmxckep5WKn6YeCV4O4W/y15Utzg8udW0m6odteJAZtUhArqriYFLbiliLdw5PNTQmVoYH8sYEu2L0W4bLPJEoyUZ2TnvuaAKBNk+go9N2c6TDW0/21Qww8prlmu6wnJrwg21TBl8uusV5gl14dO4YYYHkhWY++8+yCBfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcYkOQeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52C69C4CEF7;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758441860;
	bh=FgPJvqpqOwscoSmbcR68/IeWY3DU89hmprNU9y1mNWo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mcYkOQeUuvZpXq9ABNgmVKAmLX1OeoM4xY11vgCPjq5K1o+q2TCklZW6ihT1KDRjK
	 Lj+/PV10WEp13JHp5LgfXtJzN1gm4S0qcKNQE20z/jem9fV0gKwL+IKZy24IcHlMIH
	 pcAkWu9PS1ltSv6WrO0av7/mvhferYJw2f7g6qHT55CjtrukmQNVDwPPngSBBx4uC4
	 ceAOPCBwmZSIPWlIzyYS9fbynR2vDg1YK/PJCjO6Cj6YbmV6lOMsgla6XiW7ZMcpkk
	 qEs0ss1hWq/Q7VrY3wj1zYuhG44FgA0rhPumOwPiTDqquYzWfVDlQhwY6XU0xEho/m
	 nLGisSNIbooOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F40DCAC5A7;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Subject: [PATCH v2 0/5] Upstreaming Pinephone Pro Patches
Date: Sun, 21 Sep 2025 01:04:18 -0700
Message-Id: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIKxz2gC/43NQQ7CIBRF0a00jMVQrJE6ch+mIRR+6U9oIdCgp
 mHvYlfg8LzBfTtJEBESuTc7iZAxoV8r+KkhelarBYqmmnDGr6znjIYQpEM7b1JpDU4uysrsHTX
 +tVLR3rToJqNAGFITIcKE7yP/HKpnTJuPn+Mtt7/1z3BuKaNajKM2F+DQdw+7KHRn7RcylFK+3
 xP3xcgAAAA=
X-Change-ID: 20250920-ppp_light_accel_mag_vol-down-817c84fdae8d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>, 
 "Leonardo G. Trombetta" <lgtrombetta@gmx.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758441859; l=1475;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=FgPJvqpqOwscoSmbcR68/IeWY3DU89hmprNU9y1mNWo=;
 b=7rJt2/J0HOq5hczBdqnTmVEddXZp8Btn2v7rl1sz+OwnW9PYE1e4/lCkq3o6XbA2eJGLX6xsa
 X4VQXHQ1qiuCWHmmFZAhmPbtr7K+04ysADOacc7pEiORI0It4AzVzti
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

Throughout the years, many have contributed to the Pinephone Pro (pro)
development. Unfortunately, these patches are scattered around various
repositories in different states.

I will be attempting to upstream these patches. I will start off with the
following small series:
- Add light/proximity sensor support
- Add accelerometer sensor support
- Add magnetometer sensor support
- Add mount-matrix for magnetometer
- Fix voltage threshold for volume down key

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
Changes in v2:
- remove usb-typec node in dts from light/proximity sensor patch
- Link to v1: https://lore.kernel.org/r/20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com

---
Leonardo G. Trombetta (1):
      arm64: dts: rk3399-pinephone-pro: Add mount-matrix for magnetometer

Ondrej Jirman (4):
      arm64: dts: rk3399-pinephone-pro: Add light/proximity sensor support
      arm64: dts: rk3399-pinephone-pro: Add accelerometer sensor support
      arm64: dts: rk3399-pinephone-pro: Add magnetometer sensor support
      arm64: dts: rk3399-pinephone-pro: Fix voltage threshold for volume down key

 .../boot/dts/rockchip/rk3399-pinephone-pro.dts     | 40 +++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)
---
base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
change-id: 20250920-ppp_light_accel_mag_vol-down-817c84fdae8d

Best regards,
-- 
Rudraksha Gupta <guptarud@gmail.com>



