Return-Path: <linux-kernel+bounces-811400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE3B52897
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589A64600E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E51257843;
	Thu, 11 Sep 2025 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp9pIKGD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B6257453
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571381; cv=none; b=NCyHdFKZUgmTH9oq+Sl1IJ0O4t3qoNE1gABW/1xiJLXPah57z4SPBgQyRJz/SJZCV9u79HTYNUyUKMpkuUTITTg1yLF/x2BAr93eIFBu5pGmVzoR39ZVKZJCmayidO6RmYACbH7cJIy4LKvkFdd3JUaQ/bAVuXc42MLPyua0c10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571381; c=relaxed/simple;
	bh=bQfgfWONvdz/3iYAkuBR5e3H14h6gOvtW3RNK3GueZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YpcyJCMopX9xmEjiPA2egwGkto7m/SmKlVuou4iyyHpoZSq2r4cj+pEVgWUATVCuNK0pBQfWZ3azIltwQWfnx3ngmWepM9Lq9wUou+zHu9F5IOPX2OQJK9a9klkWwLNCyGsdXR7p5x4pVOwIid6xyXH1y7fYPt4BeV5c+nUmw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp9pIKGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDA0C4CEF9;
	Thu, 11 Sep 2025 06:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757571380;
	bh=bQfgfWONvdz/3iYAkuBR5e3H14h6gOvtW3RNK3GueZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dp9pIKGDDaayfu9vUTe6fUhaqaxz/OKt0qMUDdvy1zxBI4SyxZ6YZ4zKZCcjF2JY6
	 C+IhcQFdur8x7r4FwOr0g+hmHsd/cRzepd1o7sVOTMqSk/fp/AOuPcvj4kFsXjgqSG
	 7V8UVYRYFq73c22jvOtL1+n0wxxSnajBZ1pi/mPPyBNc/K7rRH0PQ1hZdwBlEtSRjH
	 dZZhfKbSfWV16kyxnAYbpM9kj1CdC0IpyGCEA9IRJu6aZCmqIwmwHZRZKc1zEFaeji
	 P6kUsCe+jWGl0ZsIXd4VLZ1qXVHj5Bs+6+y8zyge98TvPw4DmiUzsoT8jfPAsQL6IZ
	 dKgghe2j7s9kg==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 10 Sep 2025 23:15:29 -0700
Subject: [PATCH 1/2] RISC-V: Detect the Ssqosid extension
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-ssqosid-v6-17-rc5-v1-1-72cb8f144615@kernel.org>
References: <20250910-ssqosid-v6-17-rc5-v1-0-72cb8f144615@kernel.org>
In-Reply-To: <20250910-ssqosid-v6-17-rc5-v1-0-72cb8f144615@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>
Cc: =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 James Morse <james.morse@arm.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn, 
 liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1721; i=fustini@kernel.org;
 h=from:subject:message-id; bh=bQfgfWONvdz/3iYAkuBR5e3H14h6gOvtW3RNK3GueZw=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWQcyjSOX/H7dFblKT/nC29r983LWpv3smDT4jcBl2N9b
 2aIu+uv7ihlYRDjYJAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBM5O9Nhv8R0rtv8hw1SjO7
 ySE2+R93eCrXc39TjaoHT2svSRxS2v+M4b8737yps16XHbmh5u93/3OnbGXViohrKb+41OQ8o18
 s/McJAA==
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


