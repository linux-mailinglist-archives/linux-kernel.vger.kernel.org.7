Return-Path: <linux-kernel+bounces-873358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8931C13C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3961AA78E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9033019D1;
	Tue, 28 Oct 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="A7PL0Uet"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706692EE617
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643044; cv=none; b=b86oFBz2prSdjVZHG8T59A1R8Xk5iPXAxCPDmor79ma8NsL5BSqaPrBNoNCTmdZ03lDYlEBeJee966RC5NINEJ8S1IMac/BXQn4YFmUb+FjiR7wtbKToatafRFTPGgIdYFuwJE4tUXsZrGMrq7rL1vjtIx6orKasJj94YWewSEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643044; c=relaxed/simple;
	bh=wVCfXhX9gFOuIM1xQSYX/MuDADsnjta9ksjbCV8j1aI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgI0Twoes1K9J7dHZoeJI8sebAjRU+wBTWEc83ihOM2Sh/P45SM+13+HGcOGM+Cm++Sg+h/DpgcEJhvZParxIBb7a4i1+jLFK4fOqrGAUHBpAeIgResC4+riTDgF1871yEHmG6JmKmv1l3ZBf7TKaVtM8WopiFzFY3f6NXd//HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=A7PL0Uet; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643037;
	bh=wVCfXhX9gFOuIM1xQSYX/MuDADsnjta9ksjbCV8j1aI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A7PL0Uetb0vlc4ijKa9jjavmz5+neq80T0IwIUe00l43iq8uhX14/EuBt+ppWAmDl
	 KUf0q8mnw6o2DB3eCoB98duMuZSTfwBSxMkqpziZzyXFjCEzZw2205LxAL7wXOtD3W
	 32oxXXyxHPoHZBqibMOS/9ma5dHYKOaK9T1jjWzo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:36 +0100
Subject: [PATCH 01/10] um: Split out default elf_aux_platform
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-1-e930063eff5f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=1040;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wVCfXhX9gFOuIM1xQSYX/MuDADsnjta9ksjbCV8j1aI=;
 b=LhVFRghTmmP714gZhBulmaoihKd0f0VHzMs3eM+Bz2Cmqsv3SkDHbn+Naifonr7vh0qOBz1qm
 +z67DoHCAyeBU8AmUiQXuyNKzejI1lEP2jTG2CUIC4+3TqOBckzoq7J
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Setting all auxiliary vector values to default values if one of them
was not provided by the host will discard perfectly fine values.

Move the elf_aux_platform fallback to its own conditional.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/os-Linux/elf_aux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/elf_aux.c b/arch/um/os-Linux/elf_aux.c
index 0a0f91cf4d6d..a62fe39e85c9 100644
--- a/arch/um/os-Linux/elf_aux.c
+++ b/arch/um/os-Linux/elf_aux.c
@@ -62,14 +62,16 @@ __init void scan_elf_aux( char **envp)
 		}
 	}
 	if ( ! __kernel_vsyscall || ! vsyscall_ehdr ||
-	     ! elf_aux_hwcap || ! elf_aux_platform ||
+	     ! elf_aux_hwcap ||
 	     ! page_size || (vsyscall_ehdr % page_size) ) {
 		__kernel_vsyscall = 0;
 		vsyscall_ehdr = 0;
 		elf_aux_hwcap = 0;
-		elf_aux_platform = "i586";
 	}
 	else {
 		vsyscall_end = vsyscall_ehdr + page_size;
 	}
+
+	if (!elf_aux_platform)
+		elf_aux_platform = "i586";
 }

-- 
2.51.1.dirty


