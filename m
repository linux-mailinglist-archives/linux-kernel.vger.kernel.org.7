Return-Path: <linux-kernel+bounces-815368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A477CB56350
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6E816871D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AF42874F0;
	Sat, 13 Sep 2025 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zwei8rxL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0A286D50;
	Sat, 13 Sep 2025 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757799068; cv=none; b=O/wUkFuGJsCJVakO4E4bAq/oT81sh0bcFl9XWR98O62CiS+btJ9fV3JlwiXsKMLJvjpuhkZWPd2nF41FVuOplErf3sKNEmPlbxeqmI2PW2yYHRf1vEQWjyKMF6f1rMDZWXq6KhOwb2zhpeZd+WgyDu3rRbVoCImJvpsmm08bJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757799068; c=relaxed/simple;
	bh=C8WWgCrN+wbiLl32X59QvMva79V13DrPaEv4X3Biqs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VskrdARW5rHi+4m80g2J3sz4A/CNg9Y6PUWi2JCseW6bwebibCp0kK7lD+AVrWLAHKuO7rxebu0rSE6pph/Z0xlVDl9fI35pERMt8k1NIePWTkHRGH1uygvkfyKEIPmqkU/jwAes1ex8O5jfpCvZLlghxTZ+hSHe+oUs/iF7lGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zwei8rxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51889C4CEEB;
	Sat, 13 Sep 2025 21:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757799067;
	bh=C8WWgCrN+wbiLl32X59QvMva79V13DrPaEv4X3Biqs0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zwei8rxL/qA5np37Xrd9v/dFZLa5DZRG/NaH3fYR6FxvgcQRWku2IjSK4v4aj9All
	 x1xwtcI0egOfPvHbLrDD/TLnEmYkaEHibp4mKoXQgIMe2/+Cf9/RalVylukELm0R8+
	 fBJ5C/b1fagOUtdHUpluZ/T+Uh+sNonpxDtu0ELhjaPaVnZ0GwsGU6Y1a+b374YCYT
	 U0rmxe58yO/NO3qeod7oYSj9NEl7Nner2SBL8Xoe54xDL3H4IAvlGXqn3U29iPkcY+
	 M2owLIuVadvDQgQJyIzxbn/v54sZdWxgJ6tczuokvt/3xk7SZIvHAAOslRzCefOGxE
	 oj7W2LRt+pIoA==
From: Drew Fustini <fustini@kernel.org>
Date: Sat, 13 Sep 2025 14:31:06 -0700
Subject: [PATCH 7/7] riscv: Kconfig.socs: Add ARCH_TENSTORRENT for
 Tenstorrent SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-tt-bh-dts-v1-7-ddb0d6860fe5@tenstorrent.com>
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

Add Kconfig option ARCH_TENSTORRENT to enable support for SoCs like the
Blackhole A0.

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/Kconfig.socs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 61ceae0aa27a6fa3a91da6a46becfd96da99fd09..ff733a998612d429e7b1e00276eb86290d8331a3 100644
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
+	  The Blackhole A0 SoC contains four RISC-V CPU tiles each
+	  consisting of 4x SiFive X280 cores.
+
 config ARCH_THEAD
 	bool "T-HEAD RISC-V SoCs"
 	depends on MMU && !XIP_KERNEL

-- 
2.34.1


