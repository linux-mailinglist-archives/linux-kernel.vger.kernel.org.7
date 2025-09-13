Return-Path: <linux-kernel+bounces-815363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 444CCB56346
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C8CAA1D1C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A59283FF9;
	Sat, 13 Sep 2025 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRaZeCCK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2082283130;
	Sat, 13 Sep 2025 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757799064; cv=none; b=Ai30ZFyyDRVOF40P3wGwyvomlB84+z5TbnEDu6heLzGd3PtcmCD77SYq41vGeQTyDEFSGlCx/vquQ1f0ACCFJTzyV2zfUOBpGdX3A+/j5MIdHy1kn12GWvAEc3/feCyMhndCo7b/YvNZxZLLtd7/MU3kEXKwx3YcnPPbD99rjss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757799064; c=relaxed/simple;
	bh=5XRfwkc2GmSFjCFXpIdslo6TCdgE2D3C6IHaqnU33bM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/Xaa0n89OU5XLE8Tt+TJEYc0j/oTOD7H7tAOgzW9gbuWmijAZJaZGwFOR4iTiZRtGl5oxFdY0TPhIHQ02aNEXMWcZHjccqgo7B9C61aq9tNQ8/v5ipnVRMKMoeddZEppl7hCaz/wEMS9PHQpMg7aBLBwWhxobGE4xlmVqmrZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRaZeCCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8608C4AF09;
	Sat, 13 Sep 2025 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757799064;
	bh=5XRfwkc2GmSFjCFXpIdslo6TCdgE2D3C6IHaqnU33bM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sRaZeCCKoOnPGl+VM8wJ4aIU4egb2YSGfTnPm7Tucq1/AyYB8pqx472cbMArm5mZm
	 ANvqqyVoriE/0DUeSut2ljhb3CJQv1eW+UleKiug+Se97kTT8eRAf0jyyapWXLQW2R
	 ALeBAJk/b+eJbQojalVFsX3g2uORARivAznpIedTelNurOci8zgD6ARF5FDWTQVyIO
	 vVISWPwBu99MIdAfvQ6Lk21VPVBW1rVvwjmFls3H35FKYCV2ymFKL4kLO1M2wwLvTF
	 e56i0udU5JQOuY9mw6D2BkIqu8lpnzXHgDvm881nbkEb2nk5o+5k1MjCdhwBpYAXYR
	 p445bXTE88ZSg==
From: Drew Fustini <fustini@kernel.org>
Date: Sat, 13 Sep 2025 14:31:01 -0700
Subject: [PATCH 2/7] dt-bindings: riscv: Add Tenstorrent Blackhole
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-tt-bh-dts-v1-2-ddb0d6860fe5@tenstorrent.com>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
In-Reply-To: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <jms@tenstorrent.com>, 
 Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Andy Gross <agross@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.2

From: Drew Fustini <dfustini@tenstorrent.com>

Add compatibles for the Tenstorrent Blackhole A0 SoC PCIe card.

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 .../devicetree/bindings/riscv/tenstorrent.yaml     | 28 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 +++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/tenstorrent.yaml b/Documentation/devicetree/bindings/riscv/tenstorrent.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..877da1b0214f6730713369f82a1fdcc44c4ea562
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
+  - Drew Fustini <dfustini@tenstorrent.com>
+  - Joel Stanley <jms@tenstorrent.com>
+
+description:
+  Tenstorrent SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Tenstorrent Blackhole A0 PCIe card
+        items:
+          - const: tenstorrent,blackhole-a0-card
+          - const: tenstorrent,blackhole-a0
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d321752ac44c91d2d7e74de28e08960..f2cb2aae8d66d21bf5c13b16b3b1d8fdc98b9462 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21741,6 +21741,14 @@ F:	arch/riscv/boot/dts/spacemit/
 N:	spacemit
 K:	spacemit
 
+RISC-V TENSTORRENT SoC SUPPORT
+M:	Drew Fustini <dfustini@tenstorrent.com>
+M:	Joel Stanley <jms@tenstorrent.com>
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


