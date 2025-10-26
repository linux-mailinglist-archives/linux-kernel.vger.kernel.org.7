Return-Path: <linux-kernel+bounces-870377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F08EC0A8C6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D7023491C4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348B5246BB4;
	Sun, 26 Oct 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKxdhNuQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B48019AD8B;
	Sun, 26 Oct 2025 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761486730; cv=none; b=TN/ywCgqj16qCEX2qN5hm96sZPxeT92nOtdAifJ6OjUS1Is6MGU5UVZB+on+wG4E9Y/14pxRlcIpB3HZ7LFLD2DHQqVnRz4jc3apSsv2LkUHSwK2Im4fMJOJb2FtUWmdbXvR5J5270nxdTzKxpszmPnlys/r/n1VfELE6JpE15A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761486730; c=relaxed/simple;
	bh=Qn6+VQWRGWVLcW0LssIvm+mf9owqObJv5nvDTG7kjhs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nzPR13RQKwPk8eN8ChRjkvumjH9g950duAWKDjy2f2MVpWxD5NwIuAPRFF+RpfxVs/wgRaQQov2pGt2PDV8jmSCPXxGokvPSAU8KhZD7/LffHm+fpY3z70+idMTdOGf/1m0FfnComdAPkTBtYVJI4rGC/RivRgcERBtGrEYJ1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKxdhNuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01868C4CEE7;
	Sun, 26 Oct 2025 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761486730;
	bh=Qn6+VQWRGWVLcW0LssIvm+mf9owqObJv5nvDTG7kjhs=;
	h=From:Subject:Date:To:Cc:From;
	b=aKxdhNuQdMAqLyJJpBm1CJlbszRqcjpNKtSxr6zksUikCgbt5Gqcdd3feAIzOcdd+
	 67NNPc+n8P57QeLa/uAtcPSxUV93nIPJOQxA8N/+W994+hyc5o7Zo4HUTY/+Fc9ZHv
	 sdLlxk3YCeiqIqtPVI5NnXtKtdqtJebXCDZXb3zeuu1OLze9tuy2/WkgYfHpVH0kB2
	 cUF2yP4ges7dI6Wy7xRg6S3rgQX70rRhZzt8rrBTiWwKIjPRHEuhdh19wmEby1JP3V
	 P/KSDFjrg6SWyCx2zoNGLY0kV1jP5khuX+tEpsw0WgnG7+CQngVdMGLUAEOirrf4RC
	 0qSn51nTX8FSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2449CCD193;
	Sun, 26 Oct 2025 13:52:09 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Subject: [PATCH 0/3] Apple Silicon Type-C PHY
Date: Sun, 26 Oct 2025 13:52:00 +0000
Message-Id: <20251026-b4-atcphy-v1-0-f81b1225f9c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIAn/mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nj3SQT3cSS5IKMSt0Us0TzZEtjyxQTQ3MloPqCotS0zAqwWdGxtbU
 Ao+uRLFsAAAA=
X-Change-ID: 20251013-b4-atcphy-d6a7c939d417
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sven Peter <sven@kernel.org>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=Qn6+VQWRGWVLcW0LssIvm+mf9owqObJv5nvDTG7kjhs=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Y/9cbCqdWGKQsYCn5d2ifVsPLRfIcvzk98G7jLLzGrz
 ffxu7mto5SFQYyDQVZMkWX7fnvTJw/fCC7ddOk9zBxWJpAhDFycAjCRxeGMDFue8sr92Bp8TmvR
 s5BvQt92xoscVm+tFb+Y2ui6Isr0719Ghn1tK9uWvH/mJMu/873vC277Ntm3b1Z3VllJ55ly7n2
 Zxw8A
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Hi,

As requested in the previous version of the Apple Silicon USB3 support
series this one only contains the changes required for the Type-C PHY.

The generic tunable support inside driver/soc/apple will also be re-used
for Thunderbolt later. I may submit a RFC for that this cycle but I
don't expect that to land before the next one so it should be fine to
just take that commit through the phy tree as well.

Changes since v2 of the combined series:
- Link to v2: https://lore.kernel.org/asahi/20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org/
- atc.c:
  - Removed a bunch of outdated safety checks from atc.c that were only
    required in a previous version that did not rely on the dwc3-glue
    driver
  - Addressed Philipp's review comments:
    - Added documentation for struct apple_atcphy (and a bunch of other
      things while I was at it)
    - Moved the mutex guard from atcphy_dpphy_configure to atcphy_dp_configure
      since the first one doesn't touch any shared structures or MMIO
- apple,atcphy.yaml:
  - Added a generic apple,tunable definition that uses uint32-matrix
    and refer to that one from the individual tunable properties
  - Adjust the tunable description to make it easier to understand
  - Limited all lines to 80 chars
  - Used > for longer descriptions
  - Fixed some typos
- Picked up r-b tags (thanks!)

Best,

Sven

Signed-off-by: Sven Peter <sven@kernel.org>
---
Sven Peter (3):
      soc: apple: Add hardware tunable support
      dt-bindings: phy: Add Apple Type-C PHY
      phy: apple: Add Apple Type-C PHY

 .../devicetree/bindings/phy/apple,atcphy.yaml      |  222 ++
 MAINTAINERS                                        |    2 +
 drivers/phy/Kconfig                                |    1 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/apple/Kconfig                          |   14 +
 drivers/phy/apple/Makefile                         |    4 +
 drivers/phy/apple/atc.c                            | 2279 ++++++++++++++++++++
 drivers/soc/apple/Kconfig                          |    4 +
 drivers/soc/apple/Makefile                         |    3 +
 drivers/soc/apple/tunable.c                        |   71 +
 include/linux/soc/apple/tunable.h                  |   60 +
 11 files changed, 2661 insertions(+)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251013-b4-atcphy-d6a7c939d417

Best regards,
-- 
Sven Peter <sven@kernel.org>



