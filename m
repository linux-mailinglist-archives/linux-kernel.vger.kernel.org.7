Return-Path: <linux-kernel+bounces-843483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ECABBF910
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFB214F2BAC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD7D25A2A4;
	Mon,  6 Oct 2025 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtlKtv1w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA92E03F2;
	Mon,  6 Oct 2025 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785717; cv=none; b=RSmOQnHmT4xFmTA4Kn7DOA/7exz0AAl+5skUwrR3lvuCm5sTpk0Kac1jRG0PB/vWBYLMtv7qChGFONhsFBssBZRAoZ633tf50EEDpm6J82eDXyQsdmsbE86s4Dg7OuOtmMikmyC/fi11oFbrmlPCHJFCcyrC/3c1smVe/ZZS0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785717; c=relaxed/simple;
	bh=KaLZw6EnRFqDo1Q2vZRWuIPK9V6qjnWoh4bOBSt73+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yaj/jllp2qn7f0fiN1kN1x+ITFxw3+EvH1/R5ILTXBF3hSyAmPuLupl5muzDvjk+y3oAlxnbRviQi30xgnlOpoU5rj99p50jGOD2g+wqkTue8mkioe1paySxeqIIVLDasLRHXsE+RvevnSt4EmBjWUp+sz0IdBP/BgZ7UbYCcak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtlKtv1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E895EC4CEF5;
	Mon,  6 Oct 2025 21:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759785717;
	bh=KaLZw6EnRFqDo1Q2vZRWuIPK9V6qjnWoh4bOBSt73+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JtlKtv1wmeNw3UxPzsIp69DSuFSfRMYN/4neNXoDpRqyhzJZiZyaum758KpSm0/oN
	 jh9CDMTymoroGfg06d2uXrXah3HEHSEtPJ9E/Mfbi3ieAX5YtAQCY8pogTDeFmcvhp
	 DqlKjgxCT6QAVzK6F56ALzys22spnpY4uoMC8Eisj2FzBFRw60RTuMKwPTcny0D13g
	 uzOi0cSHO4r1v4sV/tA8uSmKWYc7SA6fEc8/JfoWv1uHpsDMvV2u+B2tIg0i0TkThn
	 1qeFTTD3EF6rcGeOhdeNe8URLgoWAUcUjdn+UsBlKmSXkBuodo0wCeFryYmRzrgerV
	 mWmHfKI7ZfSrA==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 06 Oct 2025 14:21:48 -0700
Subject: [PATCH v2 8/8] riscv: defconfig: Enable Tenstorrent SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-tt-bh-dts-v2-8-ed90dc4b3e22@oss.tenstorrent.com>
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

Enable support for Tenstorrent SoCs in the default configuration.

Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 7b5eed17611ad2260a28f9fe9985b88682eb1ebe..031d8f8f6e9d278eb802d195111f1cf9075b076d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -29,6 +29,7 @@ CONFIG_ARCH_SOPHGO=y
 CONFIG_ARCH_SPACEMIT=y
 CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
+CONFIG_ARCH_TENSTORRENT=y
 CONFIG_ARCH_THEAD=y
 CONFIG_ARCH_VIRT=y
 CONFIG_ARCH_CANAAN=y

-- 
2.34.1


