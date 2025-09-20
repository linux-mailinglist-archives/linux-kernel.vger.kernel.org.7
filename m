Return-Path: <linux-kernel+bounces-825935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641A6B8D293
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 01:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7959E7E1D39
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 23:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C3928D8E8;
	Sat, 20 Sep 2025 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2AQ33HP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD6289340;
	Sat, 20 Sep 2025 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758412323; cv=none; b=dKn6NKPmUWJJcHbkPYKeKTzdx3SA8VB1nSRZv3gAVL+VrvgjE3OQRjyoUViuuWuTsakNo4IREaQFQBkvWqZKYslovoXSSjM8+bnKcaa4THWx91nEfEivqQQnb0hyQoVfqMS7Z14wSbsg4fU8SwSMH8RXZVF7NvzmibxvRO1/Yx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758412323; c=relaxed/simple;
	bh=yC4eaX3wOdUcK33cK+HQkfZ8d6SN4O3x0pVIpqRJuz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gmvGumPM+K3rrM3Muo8qpeK1b5wWhdCxwFRY9NNLXhNm128QTtC8Es8JvsqdRr2kleicaKQoIW8mmSX6JhRxAwb5hsQlJp3OCgB+8se187LWP3eyc0sP0A51ZyVuJwYqiTv/sjC0nFoy4YefagnfSqN0h8VRAun4Q0Q7l7yKEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2AQ33HP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D64C4CEFC;
	Sat, 20 Sep 2025 23:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758412322;
	bh=yC4eaX3wOdUcK33cK+HQkfZ8d6SN4O3x0pVIpqRJuz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X2AQ33HPeZrDNNeWEO4bkFAOKUFmb7J9snEByep8a8QODLI9qtRS8kfIuwKIcLE3L
	 zmZsELg/HcED8pWb2Sj3uPx9RNMho83sylrpnRGFUfKUpxkpb5vELZyjnbHAdJIELg
	 WyKfCAs/HXOh09fY/8E+67qZB676ugTXTJCcEzilMjZU1J09ZwKF/4ERazjPSfPmq5
	 FdGWQlzqZ+poGpCp2PhRejTZSkC0RoeQlbmyTfu0xzRxZhjalVJy5J7iQj/UJ6pBnR
	 lH95vhwUC6zl6Q5kvQEqyVjcgpHYVMxrMZXjH8NgsAfXS2KHB3aqZTCSwV1XeMM0Qp
	 UwBTvhfHZsaog==
From: Drew Fustini <fustini@kernel.org>
Date: Sat, 20 Sep 2025 16:51:43 -0700
Subject: [PATCH v3 2/3] RISC-V: Detect the Ssqosid extension
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250920-ssqosid-v6-17-rc5-v3-2-5093162922d8@kernel.org>
References: <20250920-ssqosid-v6-17-rc5-v3-0-5093162922d8@kernel.org>
In-Reply-To: <20250920-ssqosid-v6-17-rc5-v3-0-5093162922d8@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 James Morse <james.morse@arm.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn, 
 liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.2

Ssqosid is the RISC-V Quality-of-Service (QoS) Identifiers specification
which defines the Supervisor Resource Management Configuration (srmcfg)
register.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
[fustini: rebase on v6.17-rc5]
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index affd63e11b0a344c33a73647351ac02a94e42981..b4239f4f092d036ee3d037177b990e317d34a77f 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -106,6 +106,7 @@
 #define RISCV_ISA_EXT_ZAAMO		97
 #define RISCV_ISA_EXT_ZALRSC		98
 #define RISCV_ISA_EXT_ZICBOP		99
+#define RISCV_ISA_EXT_SSQOSID		100
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 743d53415572e071fb22851161bd079ef3158b7c..e202564f6f7b550f3b44a0826b5a67d5c4ebee96 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -533,6 +533,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_DATA(ssqosid, RISCV_ISA_EXT_SSQOSID),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svade, RISCV_ISA_EXT_SVADE),
 	__RISCV_ISA_EXT_DATA_VALIDATE(svadu, RISCV_ISA_EXT_SVADU, riscv_ext_svadu_validate),

-- 
2.43.0


