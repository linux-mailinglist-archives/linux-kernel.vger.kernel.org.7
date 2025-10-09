Return-Path: <linux-kernel+bounces-846530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE832BC8410
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DC783530CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054C927A12D;
	Thu,  9 Oct 2025 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KTamAI1L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="juoREpc4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908BD212568
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001540; cv=none; b=Nip5OacS9gtJKfBbONv/Y3txH7+ZaAC2KTbJMioBcJY1FAfXrSjvNBs41VuMPZ/Aj9ZKtHEc3S/MDiXEuwymiVFxTKcjLpTqElVtPVfoKlTWqyIDKMLhptewFndLzmbBKFYy7x04kT3BzBz2IxocFw2F7Y5E3cbCnxFpmqEc36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001540; c=relaxed/simple;
	bh=HmXnlIwehpwXUPcql2B7lKPbYC1T44pGt7GB8oS1HHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e8YCnTaqlG7VrTBjObN4HRNjG3EZtcHLUZH5DNc9V0gBNzN0fVzbV+gRpXX97UdMdNsUmlGVviB1FQmGUXHQJTt8yArSijVFjS0vHXey3oPwEJWD171Tt+h0TK0ldDzzd63sivSWdkdtWZOqU54GYEInrUahAhKDCasMcMiQnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KTamAI1L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=juoREpc4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760001536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UAlkyoGOGlX43ewp3RiIlt9XuiNaKsCiHe1555MXTTw=;
	b=KTamAI1LJAlhRTJNw5n2/jzEEAawoORHlipMsayJnr05iQ3UnN/j5joDKP0ORQrJgRsVSK
	BdrYYRb7vxtdM3vtDEn1OOo9rn+WUMX67xT0ydpJjRqUTPJcMwpFgLdYUp07Jj5+QmVtDw
	xW/3TSQyOyySEPJUgBuK3yl4z2q9/62orxKX1cm9ckDFZjpynkZLS5FsTPb5iwzF916GrH
	/QTUnJUaqQ4FO0QjizxdGeyGa4GHFL98Q5i5ioJBq2vmF3vcvJuoy2eaD7aNRdqPwU4wAY
	NnwNn+TzQB+W5nFNlv6jJGmSAcIdm9fjEgxtPb4uQHcr7TqftSfaZ9lKLnHqdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760001536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UAlkyoGOGlX43ewp3RiIlt9XuiNaKsCiHe1555MXTTw=;
	b=juoREpc40lMETELBUiC8g1yaBR0p6OGGkTvANajb/qZzDnp0a8ghy5+1S0y9HsKfnU71GQ
	Apg0K8wBp75973BA==
Date: Thu, 09 Oct 2025 11:18:48 +0200
Subject: [PATCH] riscv: Respect dependencies of ARCH_HAS_ELF_CORE_EFLAGS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-riscv-elf-core-eflags-v1-1-e9b45ab6b36d@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAPd952gC/x3MywqDMBBG4VeRWTuQxEtpX0VcpMkfOyBaZkAE8
 d0buvwW51xkUIHRq7lIcYjJvlX4tqH0idsCllxNwYXBO/dkFUsHYy2cdgWjrHEx7gJcn0efH/F
 Ntf0qipz/7zTf9w85LeLsZwAAAA==
X-Change-ID: 20251009-riscv-elf-core-eflags-32e04d61d7ab
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Svetlana Parfenova <svetlana.parfenova@syntacore.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760001534; l=1329;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HmXnlIwehpwXUPcql2B7lKPbYC1T44pGt7GB8oS1HHg=;
 b=dCU5eASiT/xtv9CLMS6h1yeRtyxHvH2B5hcxXyM6Z1gmZllf43NkPqI3G4wWCVpMPHhF4IDkx
 /Df5KUWsRWgDDb0QCFXNcwqa7jE/2odJpTIftECL+swzu2JleO9eVAE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This kconfig symbol has dependencies and is only selectable if those
dependencies are also enabled.

Respect the dependencies.

Fixes the following warning when configuring an 'allnoconfig':

WARNING: unmet direct dependencies detected for ARCH_HAS_ELF_CORE_EFLAGS
  Depends on [n]: BINFMT_ELF [=n] && ELF_CORE [=y]
  Selected by [y]:
  - RISCV [=y]

Fixes: 8c94db0ae97c ("binfmt_elf: preserve original ELF e_flags for core dumps")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0c6038dc5dfd529e1fe623f6bc2729a388b33fde..22cda9c452d2a99529e7d6a268a93926db51859e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -29,7 +29,7 @@ config RISCV
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX
-	select ARCH_HAS_ELF_CORE_EFLAGS
+	select ARCH_HAS_ELF_CORE_EFLAGS if BINFMT_ELF && ELF_CORE
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL

---
base-commit: ec714e371f22f716a04e6ecb2a24988c92b26911
change-id: 20251009-riscv-elf-core-eflags-32e04d61d7ab

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


