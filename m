Return-Path: <linux-kernel+bounces-843482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA266BBF90F
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E3744F2737
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0D42E03F9;
	Mon,  6 Oct 2025 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snJ4lU9F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D702DFF04;
	Mon,  6 Oct 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785717; cv=none; b=W3CV2T4ho/YmzOYsEVYBm1JWCeLBRTQfoBlZNwk33Z1Xff4rRc1tKpDDXovtnDtzzp5skhjqnTYrjnBYBmdVVnakE/2dDNTzRfX/599JDv6sghjwHaAAW9jUljAYxf15zi6ShTqi9Ss1/c+NzEwNSXhI9WDtMEFb+g2yRP6xPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785717; c=relaxed/simple;
	bh=MV4imc3nxAbsHj6lhsk14sOp0mfBOvMYNKi6rHeS8I8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5CJVBx6Hc9af5mMihY/OxZ6BtEpsvBQtTnmJExahIyd7iB4ljA0iIOkF3F4pxxCDTxgJeqyxCEezYj9S1eu3tAn9OaKufKxjNGDgE3T4jpftKXfC/VaQCRbJCoZk7gu/Glb8fxgMy1PXMGyJwKjPGiXjm3/jqKeDBbfTMn5U+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snJ4lU9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165EEC113D0;
	Mon,  6 Oct 2025 21:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759785716;
	bh=MV4imc3nxAbsHj6lhsk14sOp0mfBOvMYNKi6rHeS8I8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=snJ4lU9FrM9qLBzb9P+zAFZdkpSHQXUBCRGEQw23hW1ApW69bWqVZDvIBaixfAJax
	 hboaV1v22a0FROvB4UT8g/g5LtV0zW3KHboXFCwoRsgiKp3Yp7EmDutsJ6vEG1SH74
	 oj7zNb1jwLJ3a3StC+w9bq9lFnyr9bOskg32L9FU3DTP/3xuscSgFOLp13LJlz6vDh
	 OLw8ZeBHBY8/lC1n+Ou1frEbwnYatTEFGk2BeKn1I0E1po90oaajNdxQJXh/hIO1Jg
	 Ezsw/9mywresDYyPQSoBkJWgK3xVKp/vy+MghCJFCUFnnJiknMP/6ORIdVq39frEOe
	 2yiSoAQMMwCKg==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 06 Oct 2025 14:21:47 -0700
Subject: [PATCH v2 7/8] riscv: Kconfig.socs: Add ARCH_TENSTORRENT for
 Tenstorrent SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-tt-bh-dts-v2-7-ed90dc4b3e22@oss.tenstorrent.com>
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

Add Kconfig option ARCH_TENSTORRENT to enable support for SoCs like the
Blackhole.

Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
---
 arch/riscv/Kconfig.socs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 61ceae0aa27a6fa3a91da6a46becfd96da99fd09..61c83a9c9876e59a11662da778a4bba0709d3e95 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -57,6 +57,14 @@ config ARCH_SUNXI
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


