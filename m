Return-Path: <linux-kernel+bounces-724586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8691AFF493
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F15F17696A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF2F2459F8;
	Wed,  9 Jul 2025 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBfvFcaZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDE1238C3D;
	Wed,  9 Jul 2025 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099710; cv=none; b=HcFguV4h5Uin9NEeXvn1fl+aLinITtp7XCLCtx0lpZGlLMsQjgiF8CoA7PQEW9QynjtSXT+2+O4nKWkNXwEowVREkceEGmYdvalHPA291OCre+HXj/cETmMNyk8oIHVT9FuaY/emWfIx8x+bEDwNhdGXWjT+yW81BOV+INk6/H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099710; c=relaxed/simple;
	bh=8Py4CsLgnmpWgZRh1uEJmzkqgvbjtzPIElp16HtIFTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EqEBWgFgsUy4RFZ7ddUBRxKm79FXEnrF35aSChxJ1t+83fZawxpftYyLGrc0kaSYH2nzGLjnp6Wfzx3EpNRureDVZ/1qIRrened75D8V1IzYi7L7nHgHSVb+Ts9ofgSL1p74UQUUj3d6O8qVpvAr/eoFm1Il0+9u0w7CbdAXDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBfvFcaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A46C2C4CEEF;
	Wed,  9 Jul 2025 22:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752099709;
	bh=8Py4CsLgnmpWgZRh1uEJmzkqgvbjtzPIElp16HtIFTs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=HBfvFcaZ+8jcr+v7imsDJsg32eBayfg4OcN1N35Rb/2WdL3QWZ61xxmERhRqq4YoT
	 zb45D1+W93gMKq0V862RxNUQXNwUotFEI3l/EokenOgRh1uklRlMJ/1gJV2z0OsbMW
	 uQup/ezaDSDf10wOudk9RfnNP+D8xaueV+SjJ3imfb9A+FlTv+MjGCZmLACbSbyRTV
	 VAhBh85qPsdfc/l4ZfBTW9Xis31W+f3fuwtCfmObZdhx5CmZy6ceg61B4TXBNG7wF1
	 4NcRiWGyllrd/XjplJu4FD7gKIZYjuJmjRMCZyx85o+0IOfpTk1CU/5pLbCbqZdHfu
	 gwc82rCxwFHig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912FFC83F10;
	Wed,  9 Jul 2025 22:21:49 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] Bindings and DTS for Apple SoC GPUs
Date: Thu, 10 Jul 2025 00:21:43 +0200
Message-Id: <20250710-sgx-dt-v3-0-299bb3a65109@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHfrbmgC/02MQQqDMBBFryKzbkomaVS66j1KF0lMdKBqSSRYx
 Ls3WhBhNm/47y0QXSAX4V4sEFyiSOOQQV4KsJ0eWseoyQyCC8WVRBbbmTUTu2k0+aQR3EMef4L
 zNO+h5ytzR3Eaw3fvJty+/0SJRyIh46zSiF7WtbIlf7S9pvfVjj1siSTOmjw0kTVvhKkatNL76
 qyt6/oD8URQgdMAAAA=
X-Change-ID: 20250531-sgx-dt-4a1ba1b3b20f
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752099708; l=2111;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=8Py4CsLgnmpWgZRh1uEJmzkqgvbjtzPIElp16HtIFTs=;
 b=foDGSjtL1i/eBdaakPKFBpNpRz+4dnUGdroXFiKgmtpeTraJsuKgTFcqT14/2KXYfD8btZ29F
 VgtSzPatqGjCLkIaADJVX81nV5WUK5aJBdeLBqmWQ1JDECJJphLr7mB
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

Hi.

This patch series adds the DT bindings and tree entries for the GPU
present in Apple M-series SoCs. The driver itself is in Rust and
upstream is currently missing several prerequisite bindings, so will
be sent later.

The kernel and m1n1 (bootloader) that are using those bindings are
available at the following branches:
Kernel: https://github.com/WhatAmISupposedToPutHere/linux/tree/starlight
m1n1: https://github.com/WhatAmISupposedToPutHere/m1n1/tree/bootloader-cal-blobs

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
Changes in v3:
- Just adding trailers, effectively a resend
- Link to v2: https://lore.kernel.org/r/20250613-sgx-dt-v2-0-fb2b7d1c3ff7@gmail.com

Changes in v2:
- s/firmware-compat/firmware-abi/
- drop the agx-g13x compatible
- rework reserved regions
- Improved memory region and register descriptions
- Link to v1: https://lore.kernel.org/r/20250611-sgx-dt-v1-0-7a11f3885c60@gmail.com

---
Sasha Finkelstein (2):
      dt-bindings: gpu: Add Apple SoC GPU
      arm64: dts: Add Apple SoC GPU

 Documentation/devicetree/bindings/gpu/apple,agx.yaml | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                          |  1 +
 arch/arm64/boot/dts/apple/t6000.dtsi                 |  4 ++++
 arch/arm64/boot/dts/apple/t6001.dtsi                 |  4 ++++
 arch/arm64/boot/dts/apple/t6002.dtsi                 |  4 ++++
 arch/arm64/boot/dts/apple/t600x-common.dtsi          | 34 ++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t600x-die0.dtsi            | 28 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi                 | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi                 | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 293 insertions(+)
---
base-commit: aef17cb3d3c43854002956f24c24ec8e1a0e3546
change-id: 20250531-sgx-dt-4a1ba1b3b20f

Best regards,
-- 
Sasha Finkelstein <fnkl.kernel@gmail.com>



