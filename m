Return-Path: <linux-kernel+bounces-873354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D539DC13C26
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A827F426C58
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933472FFDC0;
	Tue, 28 Oct 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="U+a6P211"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AE62FD696
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643042; cv=none; b=Da/E2MAge0Zp/ZZy2zkp7qg6Luy3C4kGxwlkn2xGpYmp26bQLzpnP9+cI83siXh6t4vFvQdi9Tgmqrxv6UezUcVCfmZE3gLjsg5Eulq4givyGxyzKMpEfTmX315woOxGMCwzLy6S19YHuSV5Ix37zHuAYVCIStg+5W2FUGbVYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643042; c=relaxed/simple;
	bh=pLpK9WMmHxQL+UmXL2BRNL9YHlr3HJAmGpPpWZh9za0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E33IPIWHTdfw4L6Vq+qsGX8oXZ9mH/5/B8qJl8EUCe2buXowuN9Y7T9VxOD87jRHTx3s+TTDat6jqhk962ZcBlZcW2cfjRK40B1X3F7hvrF4msF6ovm3HRX/xvyAyWTPMyGIMUqlEwxGm8tg0za8LizSzuVRU7chrlMuXUUgULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=U+a6P211; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643037;
	bh=pLpK9WMmHxQL+UmXL2BRNL9YHlr3HJAmGpPpWZh9za0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U+a6P211/4XvUxWAKsYQOUFks4HNaWzQk8OLSQf9m41OMxtrAQAM4Bw89Ces0WUiX
	 v0AHKlr7R/J5zIR02pXLsR95jwlpU7cs9/lmyuvXp6pFW5X9JIFdzeidNG9xyOlrHO
	 2uNN9h3tYOgq87JRV/pzbYC8noegWMFq7VlBTxdE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:38 +0100
Subject: [PATCH 03/10] um: Split out default elf_aux_hwcap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-3-e930063eff5f@weissschuh.net>
References: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
In-Reply-To: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=941;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=pLpK9WMmHxQL+UmXL2BRNL9YHlr3HJAmGpPpWZh9za0=;
 b=O5gJ+jOwEsAHrk5KZPP4TwQau/fdz95vgKIKxfOYVp6/PV/ok0lwndsYaEsJfWY4HcGigVgsg
 LyWjDLG7c/TBFz9ODtVE6y69f4yeLZPtk2aonTCktjVxwFlAwClOMI2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Setting all auxiliary vector values to default values if one of them
was not provided by the host will discard perfectly fine values.

Remove the elf_aux_platform fallback from the vDSO ones.
As zero is the correct fallback anyways, don't create a new conditional.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/os-Linux/elf_aux.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/os-Linux/elf_aux.c b/arch/um/os-Linux/elf_aux.c
index 4aadb9ea5ae3..9ee0e3199790 100644
--- a/arch/um/os-Linux/elf_aux.c
+++ b/arch/um/os-Linux/elf_aux.c
@@ -62,11 +62,9 @@ __init void scan_elf_aux( char **envp)
 		}
 	}
 	if ( ! __kernel_vsyscall || ! vsyscall_ehdr ||
-	     ! elf_aux_hwcap ||
 	     ! page_size || (vsyscall_ehdr % page_size) ) {
 		__kernel_vsyscall = 0;
 		vsyscall_ehdr = 0;
-		elf_aux_hwcap = 0;
 	}
 	else {
 		vsyscall_end = vsyscall_ehdr + page_size;

-- 
2.51.1.dirty


