Return-Path: <linux-kernel+bounces-845082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918C5BC3759
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 08:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853023BAFC4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 06:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39572E92AD;
	Wed,  8 Oct 2025 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCwA/is7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444D2E11AB;
	Wed,  8 Oct 2025 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904485; cv=none; b=qzmkPU890pboNVVzgONlRSrBfPz7dXpXwXH8RnwXKKdOQLdxOP0ucrRnYbeP+92IWRwTtezQbTycJQXAZvQNIKPsQ5ljal03UiUbtylQSBPgF2FLgitFxaweXIEeCjKYo6nFK1WD7N2g6orexILlyZIE8prZW5EY4wteL3BkzPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904485; c=relaxed/simple;
	bh=/LslsVm2PU2aso1D4HT5XrqG3MUk4kBy4l6EV30WaHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbTFOTAOlRvMjHdXJyqJfWf9GX/56VVu8Wgz+ec1a3yROe5WFup190ZyKNwS/WOBuK0yVWO2kYjlxo6O39/HeaBUqsfKIwa+wvGubNyDM3ZulHwcnYV3Jbg8id+p+m/CD/DQBEKv58/tyUclmQ/piZwQHxgGm7Fxh28CnBY52sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCwA/is7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711EAC116B1;
	Wed,  8 Oct 2025 06:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759904484;
	bh=/LslsVm2PU2aso1D4HT5XrqG3MUk4kBy4l6EV30WaHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uCwA/is7U6Ln3CKvgxGsdGc7Ki1TLD8FP3eRUjPIzdtgpruN3lbIIMGW5tA74p05+
	 9hvmjzUqS3EdvLMgkXuBDTEIWa0JnCLBe4dJlWP192dCzT1cmDd9/OjMEjvUnDL+J0
	 aCRfJjvuSLqaq9eQQf5A1onE2jT3IenmnPmpS9C1krocKR5V0A+NY/Va4ey9uRv/pk
	 uxK1EpLF9upDm42OZ6qpfddHhnOhNeTU4GLRuWYUl2gZKu1e0SEGu8U7CnLN7MWZ+0
	 FepNfZzMaW7WMTZ7uk9uTRFjLj/uCraHyYpnIAhZHdBztVQy2/vx8QvQnFJZoJ4nIA
	 0GsqxxzH4NJ9A==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 07 Oct 2025 23:21:11 -0700
Subject: [PATCH v4 2/3] RISC-V: Detect the Ssqosid extension
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-ssqosid-v4-2-e8b57e59d812@kernel.org>
References: <20251007-ssqosid-v4-0-e8b57e59d812@kernel.org>
In-Reply-To: <20251007-ssqosid-v4-0-e8b57e59d812@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 James Morse <james.morse@arm.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, guo.wenjia23@zte.com.cn, 
 liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726; i=fustini@kernel.org;
 h=from:subject:message-id; bh=/LslsVm2PU2aso1D4HT5XrqG3MUk4kBy4l6EV30WaHM=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWQ8Y3ocsJCJLSDnY324xA8zs1uPp3O49O8VPD0x0G/BL
 5MW1xbJjlIWBjEOBlkxRZZNH/IuLPEK/bpg/ottMHNYmUCGMHBxCsBEbj9j+Cstk3LFPvYl7/mO
 Jyc2hd3bekxN49eT06lsh2Nvdnh2793L8D9Gc3qf6C3BJGM5Zuvio5/sxeQPbC6NCrHRsZmZZWx
 byg0A
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Ssqosid is the RISC-V Quality-of-Service (QoS) Identifiers specification
which defines the Supervisor Resource Management Configuration (srmcfg)
register.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
[fustini: rebase on riscv/for-next]
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
index 67b59699357da8010db919b4ea2c24cd0d51182a..aeb14028bd91aa62bab854c87a11e20bdb848364 100644
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
2.34.1


