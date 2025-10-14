Return-Path: <linux-kernel+bounces-851734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA35BD728B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B0F19A0B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AED30BB8C;
	Tue, 14 Oct 2025 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmmWUMji"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A030B536;
	Tue, 14 Oct 2025 03:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411547; cv=none; b=ieKzMvA1v68Hz41xQrj4lDeOQvSRsuh9S/OMYiB9h52MG1Z63CrpezLtlSwPtSkOq0XidjK0C9Gmz6QuvhlSPLBz71gjJM12vvsV7AZ/M5K26WFKhzJRdlAI/TUvGdbbnlAbx9IkPCBqPrK5fatDg2ss5+bgQYYJE6JN/irKG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411547; c=relaxed/simple;
	bh=nV2p0fpU6/3+kXwweayj2niuZrElPFfqUNZw9N2j1qE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpYL2OJ8kmZgJkCiSzZ8A8r0eOk4PZVkxh5Gx0Qv2PEiwQCc2cz05WjV9kSC5nZtpbMuDOXsI8+4b0tbzbW0BS6cJ5Re+KM6Z41OTa4FJTnDzvIc7sbui1Ih445VrG4YRq2CFdZwuzRE6A7CVw6NX0c+SSrXpwfR/WSw/xJzuNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmmWUMji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CE0C16AAE;
	Tue, 14 Oct 2025 03:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760411546;
	bh=nV2p0fpU6/3+kXwweayj2niuZrElPFfqUNZw9N2j1qE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SmmWUMjip7JnHtECL30mUNkNSEPLXytoEw6OHD0CEvRv23fyoCvpnXII/A2iP8hz6
	 IREn4A9AtbohAZNmgxsQvGuP094lqjGk0R5lNp2YHIE2DQ2mAOFxEkuoeC9/5qDMPR
	 MP7aP765yWUoukTnBPIXoIgIVq0kUn1tOV3Bys+XPCGuEJ4tIoS2uxPE8PwyY1Wf4C
	 8oC04Rh76lhEBEzQLAc7hn1utiQJNujz92q88OGZci438EsEUsbbP0ketq9zJuoLNn
	 X3ssHKefSS1k6AkDR1QHbeRGr414zrE6LnByAKCZJT/RLSyOjXAtcewPK0GGFfXH5Q
	 YrJxb5+6kjVBQ==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 13 Oct 2025 20:12:00 -0700
Subject: [PATCH v3 8/8] riscv: defconfig: Enable Tenstorrent SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-tt-bh-dts-v3-8-9f058d4bbbda@oss.tenstorrent.com>
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

Enable support for Tenstorrent SoCs in the default configuration.

Reviewed-by: Joel Stanley <jms@oss.tenstorrent.com>
Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fc2725cbca1879c181d179a3d59ac3a0ce206061..95d5230c00274893df0502174037fec348d700c7 100644
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


