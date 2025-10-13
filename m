Return-Path: <linux-kernel+bounces-851121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72488BD596F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F54B4E8B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640AA27FD52;
	Mon, 13 Oct 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qujdbc16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A4127A129;
	Mon, 13 Oct 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377690; cv=none; b=cctD4uANmpe4VqaE19QKERvomhhCswj1lc8Jnjj2C8EpP6ls63O4NSH7Yjy/F+8ehf33f4+iHIEFnQn3HSFtr/fHhYINiZTuYdsGXkwZTDp2NGjIL3GKfn0OeFlVOup9Ei/wUekZ7Exn9yElDaHRMVMi4/D7XrIuWUozbmBndzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377690; c=relaxed/simple;
	bh=E43Z5Y8tSJqRgamwuiELwt0g0OSF4ium8fxWSOTU1R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjnQGv8+XSDttxvk+2oRGPwjOouR6FVn5WMuHmJDJQ5E4yI475d4NmX/BeZysv7aaDE5W6l2UQ5T/oxvdv7sNvJilb/Ay9xmVXL8uzMd1vHgqOTnj86mLlF5ERmonhiAqQISDrgfTwjFNPxpBWDeRM7JyDCT7vXkbzogLMsRuCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qujdbc16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F9FC116B1;
	Mon, 13 Oct 2025 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377690;
	bh=E43Z5Y8tSJqRgamwuiELwt0g0OSF4ium8fxWSOTU1R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qujdbc16f7MiyfY0lPmh3IzN15hzoM0c3atnmpR/raocNuIMANh9SeMnOtgU0iTg1
	 estioe/QofSs2DoK4XPJmkXrAX5A86hkijot0EDgzQUjHCopWtGoAtpugAugArvmLG
	 5BIf0RQBiWlVeII843aqhbp6KQHKL8jDQN8PcURW3+RTKl4qn8DC6kGsLU/CeMUsIW
	 MtsXm/SiQ9289Y2DzfC0itMJiEw+aY1g54cHQC8CMLheppwLxK+s8fV/2LUWibD4o/
	 S7pVrrr6JFH0F7PLacIWRqCEfb535DtfXlKirChMkmdcYaZ/k13r+fxbc2PZRI/ozX
	 BNobxQsi+zuYg==
From: Conor Dooley <conor@kernel.org>
To: claudiu.beznea@tuxon.dev
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/9] MAINTAINERS: add new soc drivers to Microchip RISC-V entry
Date: Mon, 13 Oct 2025 18:45:40 +0100
Message-ID: <20251013-sinister-undocked-be95b8e93df8@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013-album-bovine-faf9f5ebc5d4@spud>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=gmAo0f4txEXEqIJYVzrDbfZIGVrUbtgonOlTrrMh7lQ=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlvrQ7OP/OqnuvG5oBDh7/oCnxc4nvkfflzdwPXPRPOx 8Y3JPYf7ShlYRDjYpAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEroQyMrw7w2M31f/CVylX HXsOm6POc604723If3T4BYfACceTsxoZ/pmbVkiVH7K5lSV2py30tULRjXlnpvZdEYtJu7Wt9Gf +CxYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Add the two new syscon drivers to the RISC-V entry for Microchip
platforms.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..a28740a7d87a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22105,6 +22105,8 @@ F:	drivers/pci/controller/plda/pcie-microchip-host.c
 F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/reset/reset-mpfs.c
 F:	drivers/rtc/rtc-mpfs.c
+F:	drivers/soc/microchip/mpfs-control-scb.c
+F:	drivers/soc/microchip/mpfs-mss-top-sysreg.c
 F:	drivers/soc/microchip/mpfs-sys-controller.c
 F:	drivers/spi/spi-microchip-core-qspi.c
 F:	drivers/spi/spi-microchip-core.c
-- 
2.51.0


