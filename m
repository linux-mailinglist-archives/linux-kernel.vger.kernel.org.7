Return-Path: <linux-kernel+bounces-876675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAA8C1C15C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5C8965CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5983A34AB04;
	Wed, 29 Oct 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuTtSTQL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D634AB1F;
	Wed, 29 Oct 2025 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754314; cv=none; b=qHOL7oPVe7hkM12XQbODrRvZSDs9MsDwfCHwwYgYzfIrmSF92UJj5QodHEcGKwFg2nHHMOC0MkSlmxsCal61wrqyO9hNYB7/Azaf2hL+mZPTEk0oeE2abaw9DTHWWVjytWgiAnN0KEXt2KYT+9RBA9Kl5wpgcMCiyzctJLyF6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754314; c=relaxed/simple;
	bh=E43Z5Y8tSJqRgamwuiELwt0g0OSF4ium8fxWSOTU1R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLuVg7oyamOB46EVg+9rz2ZxdkNpDAgntR2JGcyfDAWkMj1mLf0RD+qyEkBfISVON0Oghz7OhGS9a/VPteyMw1SN/zAG59sSQMjDKBC/Cn1wqaGt+Pp1up45Ir2h0q6gQlYJfCxwHzIHVmRavrderi1AfZ4MptQla+jSp5ix3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuTtSTQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416E3C4CEFF;
	Wed, 29 Oct 2025 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761754314;
	bh=E43Z5Y8tSJqRgamwuiELwt0g0OSF4ium8fxWSOTU1R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cuTtSTQLMy3fnNiduDQZvyUp5JHLt08l6kcgxU8V9U+NVbB2/rb7/phdVDs89J/BE
	 yYXTm/8RLSbtrTo+Sin6ArdYWC572FSz3vJk30Tf6bJ4twOuyK45LftApfqB0aM0Sl
	 5ujEYXPhRHzLWnd5RonWzEpIgKTD+w+Y/YhLg8knFxKQCNXN9AJbt+RLZq+/2glumL
	 R6q7YpophojoKXEgngZFcbV4WAQ8CwEuOBJ+geOWjXnWNmyQL7aBk/ZWbf44N8LzHQ
	 aPNiBaBszcZ+Rr8gTOqOWZADHIU2qeTmpQ2r8nftSRuatuvSoKu81J46zk69Tl0tp4
	 LlMTxpTnRKKsQ==
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
Subject: [PATCH v6 6/7] MAINTAINERS: add new soc drivers to Microchip RISC-V entry
Date: Wed, 29 Oct 2025 16:11:22 +0000
Message-ID: <20251029-bonded-uranium-0b985c14a758@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
References: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=gmAo0f4txEXEqIJYVzrDbfZIGVrUbtgonOlTrrMh7lQ=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlMNuuPTn7jwGt0ibH5lOFzyWtXUicz7d/c4yDh45s0v 7859c3UjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzkFB/DfydvuX9pd5UO6bv4 FT3WU5jU56nCpPpQ1vCDvW/c/yNxLowMb5KfdE202efKZjKz28Bg6c1XZyJ8VNVVTY5ULPa4zHC ZDQA=
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


