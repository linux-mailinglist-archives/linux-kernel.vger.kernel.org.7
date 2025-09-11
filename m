Return-Path: <linux-kernel+bounces-812987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2330B53F48
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEF01CC29ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45F2E92DD;
	Thu, 11 Sep 2025 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH9caTF9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB02D2390;
	Thu, 11 Sep 2025 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634732; cv=none; b=sN5q6dbK7oxi0uW8zf3nrWsxbN1xQAyPWZcvMnfpE1dk+3QgL5zcgZxTZDe45Wjx8J+TlXDKa3lftL/35G91GStJ3wt1M2McbuBGE4kxLbeTT2RpyPtHEUhHjDey3I0GmN3iLS+P8QgsmC1JWcah2sQsnXQoJSqrAljvLPWOxo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634732; c=relaxed/simple;
	bh=rXQlLipzuO460hLM6yk6F8xNPGedj1EQygxLedmpBzk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nZs/sY0luQxiWpqwZuEEmAiusbIbgowlQJEmrzBAWhx9IaNWwaagGNFLQfJ92qWIT2lp/c0CoCXfv/JtFZ2Oi3QyfDVlnugawOUs4spVJaAJfIPlj9Kp7vI874Nk6o7Im7rDNHRKzYUS86kSF8hW6VUMdQsKUKnMcv+3G9mCzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH9caTF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62D95C4CEF5;
	Thu, 11 Sep 2025 23:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757634732;
	bh=rXQlLipzuO460hLM6yk6F8xNPGedj1EQygxLedmpBzk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=BH9caTF9ac1H+H/LjH1X37ysQw2c8Is712Owi6XkgEIQC+cE6cknDD3lWn4UrJ9cz
	 fWyQg5D/WTyCQKU+UZCW4yv2UOPgiIemWFzDUWuAlTx7kwkf2EWi2nar5WHjBdtXbr
	 GEnn/HwzziVxLTJgirGXAcd93UFng7kvhzIp21y88y+MKkb44o61veubkUF/BrEmog
	 vdo8CyQNuaGsbQb3zXiFH00vUxKY2RJwuOQasExrS7iUBLTrzrLZ2mqzPo0D1/cSV2
	 dvXvlnklxNC28aXOkhMJEYa77G+KKvinTHYWzlEZLEYrXpaA+kxlMGk9EIdQ44OVMA
	 ToBgTu+JBLuVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE7DCAC592;
	Thu, 11 Sep 2025 23:52:12 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/2] Initial Amediatech X96Q support based on Allwinner
 H313
Date: Fri, 12 Sep 2025 01:52:08 +0200
Message-Id: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKhgw2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0ND3QpLs0JdU/NUM2NjCwMLA5NUJaDSgqLUtMwKsDHRsbW1ABhukK1
 WAAAA
X-Change-ID: 20250911-x96q-57e63380804e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757634731; l=937;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=rXQlLipzuO460hLM6yk6F8xNPGedj1EQygxLedmpBzk=;
 b=M0EgaUBY/bR66z8j4+11q/JqRm4pXPtp1UZ7NvBJPd6gL5yfBzHzCDkiWsBp+AaLirOtDR1Dr
 DGry5a6MTTIATIpQgaOccON/kpyi2do+5HKGBE9ZynXJ1z/i4K7Kkk6
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

This patchset adds an initial devicetree for the X96Q set-top box.
WiFi, Ethernet, and HDMI depend on drivers that are currently not
available in mainline Linux, and I didn't enable them in the devicetree.
The builtin infrared receiver produces IRQs when a nearby remote sends
events, but I have not checked whether the events are decoded correctly.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (2):
      dt-bindings: arm: sunxi: Add Amediatech X96Q
      arm64: dts: allwinner: h313: Add Amediatech X96Q

 Documentation/devicetree/bindings/arm/sunxi.yaml   |   5 +
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts | 235 +++++++++++++++++++++
 3 files changed, 241 insertions(+)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250911-x96q-57e63380804e

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



