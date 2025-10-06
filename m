Return-Path: <linux-kernel+bounces-843477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AFBBBF8EE
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E89D188AE79
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D832D4806;
	Mon,  6 Oct 2025 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqAX8OHi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B4263F2D;
	Mon,  6 Oct 2025 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785712; cv=none; b=C2DVLPIuBIFMoh/kdY0P3ckKcxEdutSbsFetw3j3Px6pB7mz7U5oO417gJ/CCg3+ABDCVFskATJtQOCWtjkkK3e8EmrsrgpU+zv5C79E0UDnEUmS5fivB3ggaGe3FcYiKbBqHprulv2jj96TJv02Zi99Y9etNSeLcNap+AQD5Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785712; c=relaxed/simple;
	bh=Je3t2wNCDHjv0HsCYHuY3bGNQq0tRVc4Yh64Ve4NzdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuwUPo6/xTU+y5CmArTtlsatUlHhpj/yq0+JkilQXRCMRA23e8rXq0lj5nOc97RVnyRPaZ7uUBEhOtZL8+omwNSn8t/seDFMOM+wDfc1Ga7KSvDCGj7bBGeffaI2Yc9SCfA5SnFPeC3TMSPrEvlOkpQc+ksYlUWLtZs8YjTLPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqAX8OHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FADEC116B1;
	Mon,  6 Oct 2025 21:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759785712;
	bh=Je3t2wNCDHjv0HsCYHuY3bGNQq0tRVc4Yh64Ve4NzdQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tqAX8OHi5MCl72Ys82Lbd+zNX+oAEwktnstM7ffEfFfvf/BBVJMNeEfsdaHlc5UAY
	 PaNVLFHV/qzR9+bx8JzrUh54x1dWC641tMtJUF9yeWuojwEDj4hNXMml2eU5LZPsEB
	 BdDSB4I8y1Ypx9SomWXljYeehYLrMPdE1v81gkTfNm551YQmkI5OheG36tRm0rzQcK
	 d2VjtomioEjlu5S9PvU6wUdbN8+xx2Z4KcGoH0fYmd1xU/JzvgHoqB9B9jmk7UdYXr
	 ysTUuo56BsRNhrGlYpbnzr+zMkFxNJsWU7JAMN6CFxLn0FMbmyogBU57ueYW5Y+l6V
	 0OedtYUPGCo0g==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 06 Oct 2025 14:21:42 -0700
Subject: [PATCH v2 2/8] dt-bindings: riscv: Add Tenstorrent Blackhole
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-tt-bh-dts-v2-2-ed90dc4b3e22@oss.tenstorrent.com>
References: <20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com>
In-Reply-To: <20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Andy Gross <agross@kernel.org>, 
 Anirudh Srinivasan <asrinivasan@tenstorrent.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Drew Fustini <dfustini@oss.tenstorrent.com>
X-Mailer: b4 0.14.2

From: Drew Fustini <dfustini@oss.tenstorrent.com>

Add compatibles for the Tenstorrent Blackhole SoC PCIe card.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
---
 .../devicetree/bindings/riscv/tenstorrent.yaml     | 28 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 +++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/tenstorrent.yaml b/Documentation/devicetree/bindings/riscv/tenstorrent.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e15359b2aab63a57765139fb5d11dc848f5e21d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/tenstorrent.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/tenstorrent.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tenstorrent SoC-based boards
+
+maintainers:
+  - Drew Fustini <dfustini@oss.tenstorrent.com>
+  - Joel Stanley <jms@oss.tenstorrent.com>
+
+description:
+  Tenstorrent SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Tenstorrent Blackhole PCIe card
+        items:
+          - const: tenstorrent,blackhole-card
+          - const: tenstorrent,blackhole
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 97d958c945e4ffa3031590823f7a2867f577ebf3..125b5498c3bf8e689adc665fc6e975b05a484abf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21741,6 +21741,14 @@ F:	arch/riscv/boot/dts/spacemit/
 N:	spacemit
 K:	spacemit
 
+RISC-V TENSTORRENT SoC SUPPORT
+M:	Drew Fustini <dfustini@oss.tenstorrent.com>
+M:	Joel Stanley <jms@oss.tenstorrent.com>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+T:	git https://github.com/tenstorrent/linux.git
+F:	Documentation/devicetree/bindings/riscv/tenstorrent.yaml
+
 RISC-V THEAD SoC SUPPORT
 M:	Drew Fustini <fustini@kernel.org>
 M:	Guo Ren <guoren@kernel.org>

-- 
2.34.1


