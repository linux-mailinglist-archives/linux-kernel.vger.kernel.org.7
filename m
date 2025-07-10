Return-Path: <linux-kernel+bounces-724849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A5BAFF797
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116063B2E80
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179AB28469F;
	Thu, 10 Jul 2025 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5hSEqGT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F627F18C;
	Thu, 10 Jul 2025 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118572; cv=none; b=OSjUf3Td91pBKV1mrMUTOfCuCJnnGkJvFsrIaICoLBYCKQSTNG+FbHApJ5HK5JWFO8ibfyXZeOoy+DqaKRZUB2Ov1zwb0zMc0kbi5cwIvTOPyEYu8vaiHtBNfx/LiIEtoROr4p3Iweoigh6MRki0fTrf3m6CKYYv71XFJuKB60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118572; c=relaxed/simple;
	bh=J9IHr1KctOiK5uQHZbL/z3dzePJcspSYALMm97MYSQ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KNL03EwOUHoRyBJsTCUhpwtrQmsB3rN/X+x0qTujbtOInucAmihWWd6Un4GgWrNPrn7eT+ie7FTB7ra8iyPaQ1yikUK2aTuR7vRg0YscoXiUjq+bse1REPiZv6aiOPCCiX1WxWWIaDUb23q4G1Te1NFx2FUSQgeDGxOme/0W1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5hSEqGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDAAEC4CEEF;
	Thu, 10 Jul 2025 03:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752118571;
	bh=J9IHr1KctOiK5uQHZbL/z3dzePJcspSYALMm97MYSQ4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Y5hSEqGTXu/Pj3yyA4uWS0LpBDCYQuOGTxum+FvU6lh+QU+0iRrgASLXoH8nCmxVD
	 Sexi7U27kS355BYYEQVuJb18uGpgGEoSf/Ne3MghxggY+1RHKU8nmkkIuPsCCVitET
	 UzjAHhC4vSkVMjaKGstgMX3QK9ymKfXBEhIRNaQTrLt8BF54F7dl95H0Qt918XzEtI
	 0HB69onL0ZDh/sWchE6WSSfnpYFyvvltuHb4Z9anqALLGfRmdhiMfYyv+kNmfFhhdN
	 q0y3SdSytqVo+uflv/Uv97avlpJzLzPitppHMTWN3UoOFIystTvykHZHRagTUUUsVO
	 bmmM/xpWo1w1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B920AC83F09;
	Thu, 10 Jul 2025 03:36:11 +0000 (UTC)
From: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Subject: [PATCH v5 0/6] Add support for S4 audio
Date: Thu, 10 Jul 2025 11:35:36 +0800
Message-Id: <20250710-audio_drvier-v5-0-d4155f1e7464@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAk1b2gC/2XM3WoCMRCG4VuRHDdlJpM1WY96HyIl5kcH6qZkN
 Siy994oFHVljr6B572KMRaOo1gtrqLEyiPnoY3uYyH83g27KDm0LRSoDhBBulPg/B1K5VgkGNe
 RRa97vRWN/JaY+HzPrTdt73k85nK51yvevv8heg1VlCCtR20MJLIOvtzhJ+/Yf/p8ELdUVQ+uU
 M+4apyMtZgcGd/Hd05PXNkZp8bDNgWCDkzU/p3rByfsZ1w3vrTtTHLBYP/Kp2n6A3i68TRnAQA
 A
X-Change-ID: 20250110-audio_drvier-07a5381c494b
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com, 
 jiebing chen <jiebing.chen@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752118569; l=2849;
 i=jiebing.chen@amlogic.com; s=20250110; h=from:subject:message-id;
 bh=J9IHr1KctOiK5uQHZbL/z3dzePJcspSYALMm97MYSQ4=;
 b=rqiq0Hm8pHRGBFSUb4QfYzyj05BRkcTHYujviz7z7Z/l5KLn0NWIymzBLMeVCmcJ3cqtxuVOm
 LGEhApJJnhPD/vCifRnMFRD2RT6AyICY0sQw5MuzIpTVJl80EgjXfNv
X-Developer-Key: i=jiebing.chen@amlogic.com; a=ed25519;
 pk=6rFvvF45A84pLNRy03hfUHeROxHCnZ+1KAGw/DoqKic=
X-Endpoint-Received: by B4 Relay for jiebing.chen@amlogic.com/20250110 with
 auth_id=316
X-Original-From: jiebing chen <jiebing.chen@amlogic.com>
Reply-To: jiebing.chen@amlogic.com

This series completes the end-to-end audio support
for S4 SoC from hardware bindings to driver implementation
and system integration.

1 Device Tree Bindings Updates 
Added audio power domain support for S4 SoC.Defined mclk/sclk pad clock IDs in AXG audio bindings.
Add S4 audio tocodec binding support.

2 Driver Implementation
Implemented S4 tocodec driver for G12A architecture.
Add mclk pad divider support for S4 in AXG audio clock.

3 Device Tree Integration
Add Amlogic S4 audio subsystem support in arm64 DTS.

Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
---
Changes in v5:
- Fix warning Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yam when make dt_binding_check
- The audio reg is mounted below the APB bus in dts file.
- Deal with pad clock in a distinct controller.
- Fix warning for sound/soc/meson/g12a-toacodec.c
- Link to v4: https://lore.kernel.org/r/20250319-audio_drvier-v4-0-686867fad719@amlogic.com

Changes in v4:
- fix dtb check warning 
- add maxItems of power domain for dt-bindings
- fixed audio clock pads regmap base and reg offset 
- use dapm widget to control tocodec bclk and mclk enable
- Link to v3: https://lore.kernel.org/r/20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com

Changes in v3:
- remove g12a tocodec switch event
- Modify the incorrect title for dt-bindings
- Link to v2: https://lore.kernel.org/r/20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com

Changes in v2:
- remove tdm pad control and change tocodec base on g12a
- change hifipll rate to support 24bit
- add s4 audio clock
- Link to v1: https://lore.kernel.org/r/20250113-audio_drvier-v1-0-8c14770f38a0@amlogic.com

---
jiebing chen (6):
      dt-bindings: clock: meson: Add audio power domain for s4 soc
      dt-bindings: clock: axg-audio: Add mclk and sclk pad clock ids
      dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
      ASoC: meson: g12a-toacodec: Add s4 tocodec driver
      clk: meson: axg-audio: Add the mclk pad div for s4 chip
      arm64: dts: amlogic: Add Amlogic S4 Audio

 .../bindings/clock/amlogic,axg-audio-clkc.yaml     |  55 ++-
 .../bindings/sound/amlogic,g12a-toacodec.yaml      |   1 +
 .../boot/dts/amlogic/meson-s4-s805x2-aq222.dts     | 218 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi          | 387 ++++++++++++++++++
 drivers/clk/meson/axg-audio.c                      | 435 ++++++++++++++++++++-
 drivers/clk/meson/axg-audio.h                      |   6 +
 include/dt-bindings/clock/axg-audio-clkc.h         |  11 +
 sound/soc/meson/g12a-toacodec.c                    |  42 ++
 8 files changed, 1152 insertions(+), 3 deletions(-)
---
base-commit: 6ecd20965bdc21b265a0671ccf36d9ad8043f5ab
change-id: 20250110-audio_drvier-07a5381c494b

Best regards,
-- 
Jiebing Chen <jiebing.chen@amlogic.com>



