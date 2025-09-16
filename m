Return-Path: <linux-kernel+bounces-818164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E65B58DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12C4523886
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347CA27B4E1;
	Tue, 16 Sep 2025 05:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejGOXm2J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E1E265CA8;
	Tue, 16 Sep 2025 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757999787; cv=none; b=DshfQMXc5DeZjL+Kv5x0cOjLl+8PPqe8bGXSzm4RU+bb1dRZJEiRwYWHJJBYCWIyLSUXIlrvH+ObZ2hVHqjgOUbNxBKCjh3Ox17ZgbEf7P+CMnX0apUL8wbw90sjym3fiasOeFcPVZdeAAJQTjkHNtSU3W+3Hm2qidiVkfkJbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757999787; c=relaxed/simple;
	bh=bQfgfWONvdz/3iYAkuBR5e3H14h6gOvtW3RNK3GueZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=etmwT1/jDFl0jUEyalWcuaxkK7/GQGy0lT/Z+8YoyJDZGu8l6GkWStUrYExsn9+9+lNu9SXLBa1k66OxN4AkaMlR24MSNjPDNlP7AacCjAWzLih+Xb9mDewmRy17uzWbGHpaGZlpPOU06jC2el/Z2nTRJCAjGHsmcxh3orKWUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejGOXm2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC2BC4CEFE;
	Tue, 16 Sep 2025 05:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757999787;
	bh=bQfgfWONvdz/3iYAkuBR5e3H14h6gOvtW3RNK3GueZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ejGOXm2J9PHvAOLy1syrQNRsx5NZYKFFhpwpos/XQHj6HwPl4EvOPTVmCZrYLvanB
	 D/8xgwmI6acmo3ThkI080/xtnCGlpqRfUxJzPYKrPGW9TVprd3fD8gEwZfspFENaXB
	 PmLkiFPRgZp05fm843j3JkPpk82QkEFn8HNsJdgRvDYDsX4iy5mWPP6TS1bbeuJ/W5
	 5BMSvhU/io2NZaQdRGxvSf0q68dLoIuEvfecXDv9hhTre0SenL6KNsXhcaukWg+WhW
	 +2Jmo1zReLA5cQP6Rs0SFX793O01SkHdGDl9J9iKfEZOJpXBK9feUn5aJU5K8/SqJ7
	 pfR/YjH1V8Few==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 15 Sep 2025 22:13:42 -0700
Subject: [PATCH v2 2/3] RISC-V: Detect the Ssqosid extension
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250915-ssqosid-v6-17-rc5-v2-2-2d4b0254dfd6@kernel.org>
References: <20250915-ssqosid-v6-17-rc5-v2-0-2d4b0254dfd6@kernel.org>
In-Reply-To: <20250915-ssqosid-v6-17-rc5-v2-0-2d4b0254dfd6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1721; i=fustini@kernel.org;
 h=from:subject:message-id; bh=bQfgfWONvdz/3iYAkuBR5e3H14h6gOvtW3RNK3GueZw=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWSc+LSyiX+rVtf3+3tcH/O9nPrRUDrPfzrfh2/H7kX3e
 UhYvv3v2FHKwiDGwSArpsiy6UPehSVeoV8XzH+xDWYOKxPIEAYuTgGYyN7FjAw/reS7hGK8dhsn
 X3kh/tBsevzNK7wKou+fCrRkn2O5pRrAyHDuhnHpiY11oqef54infMi/t0EnxvT3moU/bpysSxV
 Z/ZMNAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

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
2.34.1


