Return-Path: <linux-kernel+bounces-733067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F3B06FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0154A1AA1AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0867291C35;
	Wed, 16 Jul 2025 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2dySIp3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3811B394F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652458; cv=none; b=hCi6BQ39ujvX9Prebsv23MDfi7Lwj7aRQRg5KUX1lYposfSsdj3jUCmHQa786jVqszOPBwJTNhnf2n6wTWJEfdaDQCTo9HWqWuVSen6durfd4m6goaYz/KLfVnwiCm8fFiT2jfeFwDN/h8nJMZXIr2JwbB8RXFSPG7+PVlDnkQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652458; c=relaxed/simple;
	bh=eOQfVfK9c0d6cPAF8dxhvIlkA+51E8dV5o03YAVgnTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LoL5TIlN8I2bm50NBvi2wZsb40+0dAi5OmNel1XzqIevaixL0uMACBDYqJtSeyYTzXOtYL9YCFDg+6J8HdBi24ZjT8Amx5ROvrJjPtYoFRES+d76m/QQTf8/5S3ncb5iv/b2ZdRCxTQPdN3i5+WGWm1G21nr09OthySwhmOak6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2dySIp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC652C4CEF0;
	Wed, 16 Jul 2025 07:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752652457;
	bh=eOQfVfK9c0d6cPAF8dxhvIlkA+51E8dV5o03YAVgnTE=;
	h=From:To:Cc:Subject:Date:From;
	b=h2dySIp3kNXTqozrOT3mpGqSA+uw/eUKeg7DxLIhHCTjXdDTFXIPXZ02bA5O2/NEW
	 pF0fruvWiZ4dZFiDvyPG2MLvneYm+o5+YvwVN/nOD6ZwfWp9G4r4UfkYlxHkUg0MTM
	 MaevLZz+zQIUnPa6xRG/C1a1rYtUvUwPppP3ARaUnU5+iJhw/vku4WyAi9JEFA3DBr
	 Jejlb4E5IhUcyw4BO4odNVLGdX5DgpdcJlhFoI/Azdt9yrM48A7VSh5snI6qEbw27T
	 uu1/fE2brBZsltdevOoj0qjvFeflym3faAywkg93Ik9PCzkuGH5qsu+HtkQ8oTo4R5
	 T2wtjktPVvMIg==
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Dan Moulding <dan@danm.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH] x86/Kconfig: enable ROX cache in execmem when STRICT_KERNEL_RWX is set
Date: Wed, 16 Jul 2025 10:54:10 +0300
Message-ID: <20250716075410.82578-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Dan Moulding reported that kernel configured without modules produces
"Found insecure W+X mapping at address 0xffffffffc0247000" warining:

[    6.022847] ------------[ cut here ]------------
[    6.023020] x86/mm: Found insecure W+X mapping at address 0xffffffffc0247000
[    6.023200] WARNING: CPU: 5 PID: 1 at arch/x86/mm/dump_pagetables.c:246 note_page+0x6ec/0x790
[    6.023381] CPU: 5 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   6.16.0-rc6 #1 PREEMPT
[    6.023558] Tainted: [T]=RANDSTRUCT
...
[    6.031153] x86/mm: Checked W+X mappings: FAILED, 10 W+X pages found.

The 10 W+X pages are the pages allocated for ITS thunks. With
CONFIG_MODULES disabled, CONFIG_STRICT_MODULE_RWX does not exist and ROX
cache in execmem is not enabled so execmem_restore_rox() becomes an empty
stub.

Enabling ROX cache when CONFIG_STRICT_KERNEL_RWX is set solves the issue and
makes ITS thunks memory properly protected.

It also ensures that memory containing ITS thunks is mapped with 2M pages
for kernels compiled without modules.

Reported-by: Dan Moulding <dan@danm.net>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8bed9030ad47..d6d8050683ae 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -89,7 +89,7 @@ config X86
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
 	select ARCH_HAS_ELF_RANDOMIZE
-	select ARCH_HAS_EXECMEM_ROX		if X86_64 && STRICT_MODULE_RWX
+	select ARCH_HAS_EXECMEM_ROX		if X86_64 && (STRICT_KERNEL_RWX || STRICT_MODULE_RWX)
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL

base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
-- 
2.47.2


