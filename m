Return-Path: <linux-kernel+bounces-873356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06FCC13C20
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80AE1AA72AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD12301484;
	Tue, 28 Oct 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="n3Cna5cw"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9702E764E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643043; cv=none; b=l6lvACFqLREa6cR5moplhk8mwnccge3j5OEshhHIFjHuzJYPVeUM+9gu0/7FM+Qgn30tAMNU1+0zdXSchDM7WQdeGfTvJnduofPwmnZrngyi+Rb1sSc85LVibfTV7u81IV/MuQpAR7yZM1YFfMLxyCKjwcRhMlCjkThd5YBGYXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643043; c=relaxed/simple;
	bh=xB7h3ce2gbt35UPG3jOGIq2cIVnYk+vgnnNmKPQ3hUc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R24ArwT3/leZUkYzy6DMmMesIsj+JKd5qk09M9UoEKmuF6z0758T3Ii2qcnp7AxFiJ3rVoZ8rfdrFQ+7urbc5ZrvbO3sHHNYwcxy6Mc+cqPx6h83ESPU1o9ZwFINAOErrewUFXFEzt2CuoGjRsePvrMsclX7VwxeIt/+WpCQUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=n3Cna5cw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643037;
	bh=xB7h3ce2gbt35UPG3jOGIq2cIVnYk+vgnnNmKPQ3hUc=;
	h=From:Subject:Date:To:Cc:From;
	b=n3Cna5cwrHoFXFZwXsYyr7xr8U1JWDVfqk8mrpEf4PO2s+yHzfo9ae9GaHIoF8OAT
	 pZxv9lkhfM75w4QdyKXmE+mYxFbn4uRlRg22lrILG3xbdF/DL60Hb0d1d53sXXv02R
	 62OfOdhoO6A1fBQUiI+iFw7EzH6AhO4EqQgAt/tg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 00/10] um: remove vDSO passthrough on 32bit x86
Date: Tue, 28 Oct 2025 10:15:35 +0100
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALeJAGkC/x3MQQ6CMBAF0KuQWTtJHQHRqxAWYL8wiVDSgcaEc
 Hcbl2/zDjJEhdGzOCgiqWlYMq6Xgl5Tv4xg9dkkTir3kIr3+cMRc0jgmwy68WrYfeDkLXAzOLl
 LiaaWmnKxRrz1++/b7jx/CUHeqW4AAAA=
X-Change-ID: 20250925-uml-remove-32bit-pseudo-vdso-8b02724e8626
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=1974;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xB7h3ce2gbt35UPG3jOGIq2cIVnYk+vgnnNmKPQ3hUc=;
 b=fy3Gznoqa4idS4vD+Qw7c736OSjfulXJWRQdumuwvFU5YCVJrhuicwaakAQoBCgYhdehVlJzU
 ntwkq3FfWbvCXZdNvbbkRNDKA4+YT8j8iaJXv5Yyc1gTYwqKH/G2rWl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Inheriting the vDSO from the host is problematic. The values read
from the time functions will not be correct for the UML kernel.
Furthermore the start and end of the vDSO are not stable or
detectable by userspace. Specifically the vDSO datapages start
before AT_SYSINFO_EHDR and the vDSO itself is larger than a single page.

This codepath is only used on 32bit x86 UML. In my testing with both
32bit and 64bit hosts the passthrough functionality has always been
disabled anyways due to the checks against envp in scan_elf_aux().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (10):
      um: Split out default elf_aux_platform
      x86/um: Move ELF_PLATFORM fallback to x86-specific code
      um: Split out default elf_aux_hwcap
      x86/um: Do not inherit vDSO from host
      x86/um: Drop gate area handling
      um: Remove fixaddr_user_init()
      um: Remove redundant range check from __access_ok_vsyscall()
      um: Remove __access_ok_vsyscall()
      x86/um: Remove FIXADDR_USER_START and FIXADDR_USE_END
      um: Always set up AT_HWCAP and AT_PLATFORM

 arch/um/include/asm/page.h    |   4 --
 arch/um/include/asm/uaccess.h |   9 +---
 arch/um/kernel/mem.c          | 107 ------------------------------------------
 arch/um/os-Linux/Makefile     |   4 +-
 arch/um/os-Linux/elf_aux.c    |  37 +++------------
 arch/um/os-Linux/main.c       |   4 --
 arch/um/os-Linux/user_syms.c  |   6 ---
 arch/x86/um/Kconfig           |   4 --
 arch/x86/um/Makefile          |   5 +-
 arch/x86/um/asm/elf.h         |  39 ++-------------
 arch/x86/um/elfcore.c         |  78 ------------------------------
 arch/x86/um/mem_32.c          |  50 --------------------
 12 files changed, 15 insertions(+), 332 deletions(-)
---
base-commit: 83e4187d1b952c36ffc2d01a2e532ad8a9e80a76
change-id: 20250925-uml-remove-32bit-pseudo-vdso-8b02724e8626

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


