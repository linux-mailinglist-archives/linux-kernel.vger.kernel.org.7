Return-Path: <linux-kernel+bounces-851729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A10BD726D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 703FC34335B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D441A309DB1;
	Tue, 14 Oct 2025 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALBNeGkL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA43081BB;
	Tue, 14 Oct 2025 03:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411542; cv=none; b=bcVW1nK3/cT3Nc0EPfIobckAsiqoIIBU/D8/cWJLnmvyIRtuzmlovI2hEeOUUbn90HKXNqDK+pH+xwh3Kl+3FJglNpx32dxwqV1SUeu+HfK4Ol22UxKNPMG321RZv9mGhgRdFrToM+bv0aB1QeThXb2cn5g0MFex0cBKboDx638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411542; c=relaxed/simple;
	bh=uj0E2jTaczy5H/DyUV24AyFpvMVsr+233ShE7T89wmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VfUIuJOCCet9r/2js+mkvLZELpxOwJvWoey29SO48LasP0ajHgwsOR82F3ID0yymnfwkLz0A/N0w91aosWhzsXH7rf1zaGykLKQp1082btTrBXNS+uShtPTpYhTrRtYJLe2hupXlL1eQhUIuvLsP7Ih5s2YBng03DxzzaKyzs40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALBNeGkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1139C116D0;
	Tue, 14 Oct 2025 03:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760411540;
	bh=uj0E2jTaczy5H/DyUV24AyFpvMVsr+233ShE7T89wmo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ALBNeGkLJTFY1jgSp4K6oAFfbkHpD9tdZxGFMiR3IPkX+sgB9NtDJhJLoO4P132vN
	 U2zU+qRz9Zft0fNd65qoy0AxFpKn5Ndz5sl7PGXfF3h+J7XR6VemWHdzxus3616zc0
	 jFABcwh2Mcqk5N76lGSN1LUOHc9RyLCgVyX81Sxc5gm3I4Zmv571YePxwnDxgjLvnW
	 Q7PdRWRJE4LRw2cjZMsKyhdHS+fDiO0bgnNmtxXi2R+ivK6kEt7R4EYwttn3vtfaVX
	 asMMHF/rND0zyghKjte/EMshH4SP9hr1iTPmxzDAqLdczM/Xe/NxZHpFkkIn8BfwSR
	 jvOwARhLtxN0g==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 13 Oct 2025 20:11:54 -0700
Subject: [PATCH v3 2/8] dt-bindings: riscv: Add Tenstorrent Blackhole
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-tt-bh-dts-v3-2-9f058d4bbbda@oss.tenstorrent.com>
References: <20251013-tt-bh-dts-v3-0-9f058d4bbbda@oss.tenstorrent.com>
In-Reply-To: <20251013-tt-bh-dts-v3-0-9f058d4bbbda@oss.tenstorrent.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Nicholas Piggin <npiggin@oss.tenstorrent.com>, 
 Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@kernel.org>, 
 Andy Gross <agross@kernel.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Drew Fustini <dfustini@oss.tenstorrent.com>, Paul Walmsley <pjw@kernel.org>, 
 Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.14.2

From: Drew Fustini <dfustini@oss.tenstorrent.com>

Add compatibles for the Tenstorrent Blackhole SoC PCIe card.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Joel Stanley <jms@oss.tenstorrent.com>
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
index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..5a29636b2df010296cabead26a6f9e557747928a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22158,6 +22158,14 @@ F:	arch/riscv/boot/dts/spacemit/
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


