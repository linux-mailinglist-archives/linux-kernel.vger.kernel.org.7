Return-Path: <linux-kernel+bounces-826026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA5B8D5C6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B505617BE4A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 06:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BDE2D12E4;
	Sun, 21 Sep 2025 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tsqd3dN7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C68284B4E;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758436864; cv=none; b=Culjq5eDAnLQ3N1Hxlo58o87jXDMYeoDUCiM9qE/NmXEoSIXhyoyxLLXNqu+/JWGBNeFozn23+JSIENm6F1o8BJ0RP4gX7EbsookVjoTOl1Vu7IXy6iyJ1e/x2d0ohwHyDnmFIjimYpViYJSMa7Tr5iKwgvzNYdp9Zk0EP7WJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758436864; c=relaxed/simple;
	bh=Gpfoi+txALgRhI206tlvm8/xAq4M/UZUJ6YgK5XGaYc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I/M6vyu0kmTGlYxSf/eMbGaWvLy1/Rr1qw18OlODFYW0SSYHnI39e+2Bk/CojgQUSqwfbaUzjF9TiCsHwPk/8d0P48O09OWjcBspq3inTl/kOLjBc9CPUcq9Qhku/qS2NL6JODXerbzkFZyend5eiq8iLwywDm3KNmQNY7exKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tsqd3dN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27C9BC4CEE7;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758436864;
	bh=Gpfoi+txALgRhI206tlvm8/xAq4M/UZUJ6YgK5XGaYc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Tsqd3dN7ILapalT1LHywkpPUGmv7qOvHPzboPVLNsogQmRQ46vQKG8Fv9B6asVeF9
	 hiDs3fHM0UCASnmfg8thmOAjFj5c5iILU60lUvY0qOlh5O6C62/cmo4jExOFFyt5Vv
	 +OKMPVV5l8GG+bFeqGZSOCwpyen/2i6P2tBYkuMYbmukMWbVg+btm+PbQ74J9lkew+
	 fP25EwzFPpk0qabokQvi+bQm1dDYDCs1n03XeSTydw8kH92EzhLaGyXfMy7FBPHokw
	 rZXQhsNapSmMQToYy6HrgLh5wg/sdhopLuwJv6oQ5GKgFb1qqgGsMpQjfZmP1TzKWq
	 umMqWCEjhi0oA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D653CAC5A0;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Subject: [PATCH 0/5] Upstreaming Pinephone Pro Patches
Date: Sat, 20 Sep 2025 23:41:02 -0700
Message-Id: <20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6dz2gC/x3MQQqEIBQA0KvEXyeYTOR0lQgR/eoHR0WHZiC6e
 9Lybd4JDSthg3U4oeJBjXLqmMYBTNDJIyPbDYKLmb8FZ6UUFcmHr9LGYFQf7dWRI7P5l5icFiN
 fzmqUFnpRKjr6P/22X9cNCKWy5m4AAAA=
X-Change-ID: 20250920-ppp_light_accel_mag_vol-down-817c84fdae8d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>, 
 "Leonardo G. Trombetta" <lgtrombetta@gmx.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758436863; l=1279;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=Gpfoi+txALgRhI206tlvm8/xAq4M/UZUJ6YgK5XGaYc=;
 b=H+bXwIwkxn8Ao42UiF3krOmUE1zTnaFt42PKrB9qR1FNOkjde318DvAeJAsg1ROzBO3ok981k
 JzlX1V3OaJIAeP1gpeKsQlucOP8fuBuWbeECsRzKcrj+WllofRT7NOY
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
Leonardo G. Trombetta (1):
      arm64: dts: rk3399-pinephone-pro: Add mount-matrix for magnetometer

Ondrej Jirman (4):
      arm64: dts: rk3399-pinephone-pro: Add light/proximity sensor support
      arm64: dts: rk3399-pinephone-pro: Add accelerometer sensor support
      arm64: dts: rk3399-pinephone-pro: Add magnetometer sensor support
      arm64: dts: rk3399-pinephone-pro: Fix voltage threshold for volume down key

 .../boot/dts/rockchip/rk3399-pinephone-pro.dts     | 46 +++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)
---
base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
change-id: 20250920-ppp_light_accel_mag_vol-down-817c84fdae8d

Best regards,
-- 
Rudraksha Gupta <guptarud@gmail.com>



