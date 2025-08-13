Return-Path: <linux-kernel+bounces-766422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08708B24652
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E03316AF31
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EED92FE591;
	Wed, 13 Aug 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVQc14Dk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1A2F3C2B;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078830; cv=none; b=SqmR9EvydO20iDPxvsNZVwpkvLNWesLakOMdz3h7L1bsSbLz2kndzaqhopatYXd7etRyvgxHfmnY/zSm+qQoYlV2XeykwekJQSzbiJ3HE1gxA/Yo3ag+XIRrVV6mUzYiosrRx2ldp2/eNZpfmCBCtbM2g4ezO9uOKNcIbIhXKtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078830; c=relaxed/simple;
	bh=eiXrLuhR4xCamhoxoYxrnKpTHf3dzkLdi7yUfznol88=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kCpTgEEc6xeSFzA1HsYLwRELGHiIgEySRJV+lXDjRggYON79zRWbRkTlpWS/a7tjllTYZISVEdNjlBZuFquGiOPG2oXroYOL6gxUPEGAAskZk0XPKCHLZlAJ/LtD7TEtnINLXwxUjkyPH6wnS0x/r2VQOWg68CMsf9XGiZTJMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVQc14Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 254C5C4CEF5;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755078830;
	bh=eiXrLuhR4xCamhoxoYxrnKpTHf3dzkLdi7yUfznol88=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mVQc14DkJP1EaNM/NFLB+N4og7C2CwBzEN3QEZ22tuDnLg0NHojdZKfJjweWfSqsQ
	 izGRTx2CjUzF6xoaIyEWrLLly6/BGe1ms4mXF8wJLHQyFlnQpIffkTDU2uLlEkXUfb
	 /UswVtkiFrfoyuAu9f3xsq4MyzflHzP5n88JZu50ZRXSBa+2lEl03hBzqGxjY3lG7S
	 oR7I91D2xCWnRjXQuhtXZHqiWgQ4gVhStVKZNVqnOAJtHv6utT/rQ9CjFxVfYmg6xZ
	 8klurv5xze/wYBSr3OV2o0ueGPJsjSeqprI+HCitXTiZh6nQbaIX8u7smvfCVm8Z+a
	 CoJVynjcWm4oA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A319CA0EE3;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH 0/5] Apple device tree sync from downstream kernel
Date: Wed, 13 Aug 2025 11:53:32 +0200
Message-Id: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJxgnGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Nj3cSCgpxU3ZQS3eLKvGRdM11Dc90Uw7Rkw2QLyzTz5EQloMaCotS
 0zAqwodGxtbUAsOexiGQAAAA=
X-Change-ID: 20250813-apple-dt-sync-6-17-d1fc1c89f7ca
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=eiXrLuhR4xCamhoxoYxrnKpTHf3dzkLdi7yUfznol88=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhow5CWsePjDbkaGoumtOfrJAVFj2+dDzsUq7k1yFmWomB
 rzTN23sKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJGtlgz/M1h7Y6/v4L+x4oP/
 RI4ntz55uvg3i6pPmO72bOd1h52eTgz/VJgv6D9JzLx50DnkkeJZ9vf8Vu/jO3dbafPaf9vWvuE
 GLwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

This series pulls changes from the downstream device trees which are
supported in upstream kernel.
Most importantly it fixes the PCIe description for a specific iMac model
(iMac M1, 2 USB-C ports, 2021). This is worked around in the downstream
kernel by not disabling the port. In preparation for submitting M2
Pro/Max/Ultra devices trees I investigated the issue on the similarly
affected M2 Pro Mac mini and fixed it this way.
It completes the Wlan/BT device nodes for t600x based devices and adds
the missing 15-inch Macbook Air (M2, 2023).

Checkpatch emits following warnings:

WARNING: DT compatible string vendor "pci14e4" appears un-documented --
check ./Documentation/devicetree/bindings/vendor-prefixes.yaml

Which I chose to ignore. `vendor-prefixes.yaml` prefixes contains no
other mapping for PCI vendor code and the list of ignored prefixes
forbids extending it. Both options feel wrong though. "pci${vendor}" is
clearly a vendor prefix but duplicating the PCI vendor data base feels
wrong. `vendor-prefixes.yaml` currently does not contain and PCI vendor
aliases.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Hector Martin (2):
      arm64: dts: apple: t600x: Comple WiFi properties
      arm64: dts: apple: t600x: Add bluetooth device nodes

Janne Grunau (3):
      arm64: dts: apple: t8103-j457: Fix PCIe ethernet iommu-map
      dt-bindings: arm: apple: Add t8112 j415 compatible
      arm64: dts: apple: Add devicetreee for t8112-j415

 Documentation/devicetree/bindings/arm/apple.yaml |  2 +
 arch/arm64/boot/dts/apple/Makefile               |  1 +
 arch/arm64/boot/dts/apple/t6000-j314s.dts        |  8 +++
 arch/arm64/boot/dts/apple/t6000-j316s.dts        |  8 +++
 arch/arm64/boot/dts/apple/t6001-j314c.dts        |  8 +++
 arch/arm64/boot/dts/apple/t6001-j316c.dts        |  8 +++
 arch/arm64/boot/dts/apple/t6001-j375c.dts        |  8 +++
 arch/arm64/boot/dts/apple/t6002-j375d.dts        |  8 +++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi   | 10 +++
 arch/arm64/boot/dts/apple/t600x-j375.dtsi        | 10 +++
 arch/arm64/boot/dts/apple/t8103-j457.dts         | 12 +++-
 arch/arm64/boot/dts/apple/t8112-j415.dts         | 80 ++++++++++++++++++++++++
 12 files changed, 161 insertions(+), 2 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250813-apple-dt-sync-6-17-d1fc1c89f7ca

Best regards,
-- 
Janne Grunau <j@jannau.net>



