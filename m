Return-Path: <linux-kernel+bounces-851733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCC6BD7285
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A4A421747
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7C30B52C;
	Tue, 14 Oct 2025 03:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf300Fh8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50082309EE1;
	Tue, 14 Oct 2025 03:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411546; cv=none; b=Wzknr8asyVY4IRYVxEGlqfjwVLVLHxh9RpEUfODqaEsM24n9cctnno3ocjz4DPaI4x6WE8yT1UtbaM98ORjb4ETVUn3B3wpfIHe28qvGYhRIYfTdzoONWJ6DLBdf88/XSOL0GCKq5mfCx8M4k2BclLnchHE4MDcgmKM1QE+g60M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411546; c=relaxed/simple;
	bh=DyOTgkiOX+xxSODVH7p8ZivJ8z1IhKgwy7RRwUpzEkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9ICeDGKDxdY4SF+0DM4VRlZhhP0EOrcUzOlmTWk4q8IGiHlPzBKPBCdbfT08HE+zhO0KlB9wtZNXP7RzR01ahdnN86xWXAP4DMxSCBh/MwQro+hIZ/Ciyjf2TQoOLnigFmYhsoh2qvv1Lg7gsj0Av3bNsRHDhlgocfZbo/geos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf300Fh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DF7C116D0;
	Tue, 14 Oct 2025 03:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760411545;
	bh=DyOTgkiOX+xxSODVH7p8ZivJ8z1IhKgwy7RRwUpzEkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vf300Fh8Gn1gX/9ACvdev9mO+38QsC94iA1HEP84CSvee+tQyudUfnsNbfBbenv9C
	 1bBYfGvfjzTf5MnMm0VRlOFlo7cYYlXiDF6NDYPT8nbQbY4Ri6eeggwMy6bMrScu6N
	 FQdVVZopLsOHcqzy6sgj2RS+Jlk8eLUxrlO9ZpToTi3mpTnmKo+H8pIEReuap/Fv9a
	 w3lZ7xS5lrf7G2lyfs++8TwcZBevpd+xDL1KzS/gE0REcARrHvysZPyKqnwhbiquvD
	 auQxq2nkKkZTv12298dkDtkuGh0NIVnxzw3V54yZ21bzlSOW7XsQflg1nOPVCAV3S3
	 gK4qKbdm7rNdQ==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 13 Oct 2025 20:11:59 -0700
Subject: [PATCH v3 7/8] riscv: Kconfig.socs: Add ARCH_TENSTORRENT for
 Tenstorrent SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-tt-bh-dts-v3-7-9f058d4bbbda@oss.tenstorrent.com>
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

Add Kconfig option ARCH_TENSTORRENT to enable support for SoCs like the
Blackhole.

Reviewed-by: Joel Stanley <jms@oss.tenstorrent.com>
Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
---
 arch/riscv/Kconfig.socs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 848e7149e4435ad3ca138b62bc3b3c8efb594a18..0b4d408aebfa5dc441abfb8e78153acc149951f0 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -63,6 +63,14 @@ config ARCH_SUNXI
 	  This enables support for Allwinner sun20i platform hardware,
 	  including boards based on the D1 and D1s SoCs.
 
+config ARCH_TENSTORRENT
+	bool "Tenstorrent SoCs"
+	help
+	  This enables support for Tenstorrent SoC platforms.
+	  Current support is for Blackhole P100 and P150 PCIe cards.
+	  The Blackhole SoC contains four RISC-V CPU tiles each
+	  consisting of 4x SiFive X280 cores.
+
 config ARCH_THEAD
 	bool "T-HEAD RISC-V SoCs"
 	depends on MMU && !XIP_KERNEL

-- 
2.34.1


