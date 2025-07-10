Return-Path: <linux-kernel+bounces-724847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E4AAFF792
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF421C46679
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07604284684;
	Thu, 10 Jul 2025 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeV4YdE0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F634F9D6;
	Thu, 10 Jul 2025 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118572; cv=none; b=EaBaLyNnQFI3GmH5ICUomAOzyOgCYVrUwl3BN2+dls43NPg5E/NLeFSo5MYObJoRzg7zpxXBWW3saM4OGRxtesAThh67tzoRAxPWDyvSruADD6itaAhz4psEUzaI4tZLva0AsewRb7L/Jwd5YKcAzaJOu2esao3Bk5nLl+FFlDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118572; c=relaxed/simple;
	bh=5MnEx6d6Bp+tncNEQjSvFZsKEzB4p23EOo3WP5jzh6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LAsAfWqPcZYQ3XjbDkk4AYDip8F7EA3qbkSSwR0TdgTgL3oCRZU+gTLa0d0Ef4wZvBWhTlN+ACg7U9XI74NcnVqDDxWr7Tovt5uGQcpbN59iE1qn7eoEXMbt8Pam2rJN5m/uFtadb5ELGUw+9gX9YB+zR5wCFWzTTDRsvhTeiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeV4YdE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04152C4CEF8;
	Thu, 10 Jul 2025 03:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752118572;
	bh=5MnEx6d6Bp+tncNEQjSvFZsKEzB4p23EOo3WP5jzh6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TeV4YdE0/0rnz9PoZCBSS2MrMka0Ys//W3ff1VsuYSM17QAQbVkcsklxFr/D9Apat
	 fh+3yvYWUwzvpa3nEAB6lzngn0tVUruGp9w6VBZVCGnjQkUbMWVfaNaE7uJgJ+g1ti
	 YTHYCOV8KMRsIk1FQO7RpBuitvp+n0WOdatTDDYc4Ri2fO2CziHqRz13/AbajVo7ZS
	 QntSU3Abvrm6NuDncOZai5be/6EfLpvZaWlj5Cx4XTXZAnMf6un5wf4zm4TAWUC/bX
	 NKyiUjhxbRJAwuTCaQFL0xBNU7/lLx4+Jc09U1Six3HVhRt0pDVQzk3ZbX6afuz2oA
	 iroxenrl49U+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B5AC83F0F;
	Thu, 10 Jul 2025 03:36:11 +0000 (UTC)
From: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Date: Thu, 10 Jul 2025 11:35:39 +0800
Subject: [PATCH v5 3/6] dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-audio_drvier-v5-3-d4155f1e7464@amlogic.com>
References: <20250710-audio_drvier-v5-0-d4155f1e7464@amlogic.com>
In-Reply-To: <20250710-audio_drvier-v5-0-d4155f1e7464@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752118569; l=873;
 i=jiebing.chen@amlogic.com; s=20250110; h=from:subject:message-id;
 bh=x6WA+WpOIp5OPvSngtyt9yMnHRZE3lLhDSWKJO4Usbw=;
 b=8pDuK0vyXUAHxnZ7z6r+YQxBmz4b0lZ/mfWeKQkyV5k1GOC4ZXtfvhBnjtVB12AUjeTjzEuO9
 AkCwFAr9iapCq1hjjNtYMbmLOyfFx1oEyxcMurQyj0Sy/tSiJe81BaI
X-Developer-Key: i=jiebing.chen@amlogic.com; a=ed25519;
 pk=6rFvvF45A84pLNRy03hfUHeROxHCnZ+1KAGw/DoqKic=
X-Endpoint-Received: by B4 Relay for jiebing.chen@amlogic.com/20250110 with
 auth_id=316
X-Original-From: jiebing chen <jiebing.chen@amlogic.com>
Reply-To: jiebing.chen@amlogic.com

From: jiebing chen <jiebing.chen@amlogic.com>

Add S4 SoC tocodec compatibility support.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jiebing Chen <jiebing.chen@amlogic.com>
---
 Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
index 23f82bb89750898d20c866015bc2e1a4b0554846..ea669f4359bc81b0f45bc2105c832fc2b11d8441 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - amlogic,sm1-toacodec
+              - amlogic,s4-toacodec
           - const: amlogic,g12a-toacodec
 
   reg:

-- 
2.43.0



