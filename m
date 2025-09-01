Return-Path: <linux-kernel+bounces-794378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6551BB3E0DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD56E1896991
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D32D311953;
	Mon,  1 Sep 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfWQ9sjz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A6217F55;
	Mon,  1 Sep 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724700; cv=none; b=IpaIlRhxRIOyvyB8myWEtwW+NNZLDOi7kZdvXyVquGSEvvurfRu2Cms9iM88qvfqsaTtt7DnzcC9OghVGuRxmx1QtpHHKnNGQfv8eSmvHCAkYoYupu1jxhMZMDem10+RAbH0W3epqaZaROL5ILqB6C2pxcyPgPKXKLEafv137CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724700; c=relaxed/simple;
	bh=jECQWUPeqYIp+kYy0qMp+mxlsYrMNhCp3lRCnaD5i0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8If7SZMFE7uZ+2a7w9R9sG77TsH+jQZpLDwsNXHtOYkVhdnaXfYtnxeqBNy3KOjmt5b3FtRzRrqGGqsSh3FxVRJfE93Xk9l++5+ExFobcCWnK2Q3IKrY3U6atxQWvARinPU/mUcdqnt5dW44kvEcbhJkdX0MVklUS/kQFAujAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfWQ9sjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF20CC4CEF4;
	Mon,  1 Sep 2025 11:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756724699;
	bh=jECQWUPeqYIp+kYy0qMp+mxlsYrMNhCp3lRCnaD5i0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AfWQ9sjzOXKkzgqnkTBQAdhVnJYC42z1ZpCbvzM6Ofdj71q+CKR4qzih3qMObRcqK
	 2EjhcTUaN3J93IPSS1pp1Wi+z88E56LFeyOHwuHMEla8MP7CrWYXoiKlQUL7JGX9GE
	 S0lpQmaavEZpx41L0ByTP8Tz9y5/zHuTQec39Us9ocDGA1Xo5dtFAZArV06AM6IwgS
	 FD02yt4WO/1F7ze2Roly+MB7PVH8vEAvAoC+KgR/PK9TxsWr1u2cdnpFryHEFOB+j0
	 fBN7IAQ1lQ8DSxOmalTnrt8aK4haCMCerEReBB9dzzHZVnnEt9v0sl6FrrD3cR9BeW
	 57XhFajTAsWMQ==
From: Conor Dooley <conor@kernel.org>
To: sboyd@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/9] dt-bindings: mfd: syscon document the control-scb syscon on PolarFire SoC
Date: Mon,  1 Sep 2025 12:04:13 +0100
Message-ID: <20250901-shorten-yahoo-223aeaecd290@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901-rigid-sacrifice-0039c6e6234e@spud>
References: <20250901-rigid-sacrifice-0039c6e6234e@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=5rg4qG6+r0Tz8RYgLEQxmEix629uHarZjM4QelP6QtY=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlba9ceDjmisSn0m1FVy/3tt/Un8UrKr/j4d4ooV3PWg l+NsyoFOkpZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjARBm9Ghjcx7eELJzgLlW/+ dJNDVVdPO7D7uZxLxe//VhOnCqVe+szwV/p59wtRNY+mH61y13XP6EtxvSx+WHD2QkxYbdeHhKn WjAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The "control-scb" region, contains the "tvs" temperature and voltage
sensors and the control/status registers for the system controller's
mailbox. The mailbox has a dedicated node, so there's no need for a
child node describing it, looking the syscon up by compatible is
sufficient.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v2:
add the control-scb syscon here too, since it doesn't have any children.
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 27672adeb1fed..d18be50dd7127 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -90,6 +90,7 @@ select:
           - mediatek,mt8173-pctl-a-syscfg
           - mediatek,mt8365-syscfg
           - microchip,lan966x-cpu-syscon
+          - microchip,mpfs-control-scb
           - microchip,mpfs-sysreg-scb
           - microchip,sam9x60-sfr
           - microchip,sama7d65-ddr3phy
@@ -197,6 +198,7 @@ properties:
           - mediatek,mt8365-infracfg-nao
           - mediatek,mt8365-syscfg
           - microchip,lan966x-cpu-syscon
+          - microchip,mpfs-control-scb
           - microchip,mpfs-sysreg-scb
           - microchip,sam9x60-sfr
           - microchip,sama7d65-ddr3phy
-- 
2.47.2


