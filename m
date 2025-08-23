Return-Path: <linux-kernel+bounces-783041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C22B328A5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BD83A3931
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6607C2797A3;
	Sat, 23 Aug 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkcr/VNG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C57277C95;
	Sat, 23 Aug 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953034; cv=none; b=myjKIb7l4zBm6Q2PSgwACHLCVOYjGUnmU2/1iOM0jLQfjr6sFhZctliY0+eAIjEgrJtbAyvIdOSU9ac9xQOyIDxEQiU8ueozL+fbnlXK/nIwwGOrMLr6/bgfxF6bMA7ZY4ZTKc/nXaoEKsKsM1XSOOqAdjsgg4kNgWQDqPVbHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953034; c=relaxed/simple;
	bh=qmoItphEwgbnOc3Kx/jB+wrA6iB1hYbkpqBVKQ9GP5s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ntpkjXuQb04c34FY3E6Vu8HFkihFHncsEQsi37DfwVVCgoe7UirCcM62IKwVnV0EpDgZXmuVp/uvPGfglUo88mHNRwq/v8nwJoSt5TNbW3pb2N9qvusnVzDzt85x48eSgAxqB1JnzntXp8wa2gTBTbvpvbyRem2T86NondeU9c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkcr/VNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30C83C4FDF1;
	Sat, 23 Aug 2025 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755953034;
	bh=qmoItphEwgbnOc3Kx/jB+wrA6iB1hYbkpqBVKQ9GP5s=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nkcr/VNGpWb5PG1mW/7ygJZllF1tQ25qboFfjFy6wNJdiQjNIs/va/ulfNXZvyRB9
	 dii9XUInFa14HlWNehBX3frQmZZMkY8WRX5HJ8OfY+zSFB6vip/+BVN5Dq5fjpAsty
	 I2Y+vwcZPX7OrWSDZU+Xlaifx3i4/WIrtww8EkMB5YdbsKFtbNjIGED3hB23/rPF8B
	 flBvs3Jy7vv/PbRB6L7Tep6IzgSH4z9gvbxQgm/59mSbUxCpE9ktRMtGSKwC6Ledvd
	 nw9ilrB7Jm5CH8z/vhf+5c6EkYCbzXseQ0wifSVtL4xF8B+j3vRD/1num4hnzo4I1O
	 FJQNuQal1xtCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BBDCA0EED;
	Sat, 23 Aug 2025 12:43:54 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maud_spierings.hotmail.com@kernel.org>
Subject: [PATCH 0/3] arm64: dts: rockchip: Improvements for
 rk3588-orangepi-5 and friends
Date: Sat, 23 Aug 2025 14:43:49 +0200
Message-Id: <20250823-orangepi5-v1-0-ae77dd0e06d7@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIW3qWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNj3fwikGhBpqluokWyhYGpuWFyWoqBElB9QVFqWmYF2Kzo2NpaAMS
 YGExbAAAA
X-Change-ID: 20250823-orangepi5-a8c80571cfd0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Ondrej Jirman <megi@xff.cz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Maud Spierings <maud_spierings@hotmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755953033; l=829;
 i=maud_spierings@hotmail.com; s=20241110; h=from:subject:message-id;
 bh=qmoItphEwgbnOc3Kx/jB+wrA6iB1hYbkpqBVKQ9GP5s=;
 b=XW9abXAO3w57Ix2LwWlF3Yf5as+Mfqdo0VxxzjVLdssOTDU6o907NIN3Z3Qkd8L2uBlWiRCoe
 hxfh6KYtzBVCQMRvy6MCvp55sK409dtkfYwwmBjZtik20y2cSgMZ2UM
X-Developer-Key: i=maud_spierings@hotmail.com; a=ed25519;
 pk=CeFKVnZvRfX2QjB1DpdiAe2N+MEjwLEB9Yhx/OAcxRc=
X-Endpoint-Received: by B4 Relay for maud_spierings@hotmail.com/20241110
 with auth_id=273
X-Original-From: Maud Spierings <maud_spierings@hotmail.com>
Reply-To: maud_spierings@hotmail.com

Fix the headphone detection logic on the orangepi 5 plus.
Enable the HDMI receiver on the orangepi 5 plus.
Enable the NPU on all orangepi 5 boards.

Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
---
Maud Spierings (3):
      arm64: dts: rockchip: Fix the headphone detection on the orangepi 5 plus
      arm64: dts: rockchip: Enable HDMI receiver on orangepi 5 plus
      arm64: dts: rockchip: Enable the NPU on the orangepi 5 boards

 .../boot/dts/rockchip/rk3588-orangepi-5-plus.dts   | 19 +++++++-
 .../arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi | 56 ++++++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)
---
base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
change-id: 20250823-orangepi5-a8c80571cfd0

Best regards,
-- 
Maud Spierings <maud_spierings@hotmail.com>



