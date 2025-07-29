Return-Path: <linux-kernel+bounces-749688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B56B151A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E7C18A3DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F606292B35;
	Tue, 29 Jul 2025 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatechautomation.com header.i=@novatechautomation.com header.b="pqbGafir"
Received: from gwf2.litvpn.com (gwf2.litvpn.com [216.244.76.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B84F5E0
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.244.76.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807821; cv=none; b=n2lBPJ1iVLSUOj1Hr06p+2qyLkWTOKiAeW9Ku/gCOPtrggTFp90M56p5SiTuRM2Aw1FUJ+qHl033KdptZKr7kFo2WJ5xeQEv+RzbBhy/lbMmQV/WgJfuX0um9JBqm3oXDM4vDKEMa7R5bcb2umL8KLEqxJCtIvY1DQ/GmKy5acw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807821; c=relaxed/simple;
	bh=Cw5KYyKS3N/z2f1RAwTSJVaunW+NwDhMP4qYTxYaE9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nv8c7KqirtB/vaD8csxkoHHomnFM0aN11wLvKVA8NzyG46ruo8tdl6a9bKmsixGTyS73n/vA5uFpNx/sKIa+L4JnjaJeFG0SqGeRfAZ+aN7WKmJtCHDSvyt5YQk62393xm+DX6lpEFDDJLo+R7Vuo+4nU+QxVztAlH14KZYh8V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=novatechautomation.com; spf=pass smtp.mailfrom=novatechautomation.com; dkim=pass (1024-bit key) header.d=novatechautomation.com header.i=@novatechautomation.com header.b=pqbGafir; arc=none smtp.client-ip=216.244.76.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=novatechautomation.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatechautomation.com
Received: from gw2.cammew.com (gw2 [64.182.209.149])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by gwf2.litvpn.com (Postfix) with ESMTPS id 0EF2D1869DA8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:50:11 -0400 (EDT)
Received: from eric-Desktop.novatech-llc.local (unknown [38.62.160.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gw2.cammew.com (Postfix) with ESMTPSA id D1EC2EDCD0;
	Tue, 29 Jul 2025 12:50:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 gw2.cammew.com D1EC2EDCD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=novatechautomation.com; s=relay; t=1753807804;
	bh=iL1mFb01gIw1cBTKAOyCBdsA3egaSAxuur1ZlhzkvnQ=;
	h=From:To:Cc:Subject:Date:From;
	b=pqbGafirTZ8XwNexBp8nVhVFNfTD4+9OPIj00YTlViijizXym6zGQscLpVnxTy8yR
	 Rzmg30SAU++cmTlL2V/OP/o9XOEdIkbz5UCG6nknnSS2n9rUzsE+qMRWPB6RMXHWNl
	 9z9Fb3p81xzyU0y4jaedhI60HltuW2ExleUEntBE=
From: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Subject: [PATCH] x86/apic: Silence LAPIC kernel warning on early boot
Date: Tue, 29 Jul 2025 11:49:58 -0500
Message-ID: <20250729164958.935066-1-eric.schikschneit@novatechautomation.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code currently issues the user a warning unconditionally:

WARNING: CPU: 0 PID: 0 at /arch/x86/kernel/apic/apic.c:2129
	register_lapic_address+0x3d/0x50
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.62-rt31-yocto-preempt-rt #1
RIP: 0010:register_lapic_address+0x3d/0x50
Call Trace:
 <TASK>
 ? show_regs+0x69/0x80
 ? __warn+0x8e/0x160
 ? register_lapic_address+0x3d/0x50
 ? report_bug+0x171/0x1a0
 ? early_fixup_exception+0xb8/0xd0
 ? do_early_exception+0x1f/0x60
 ? early_idt_handler_common+0x2f/0x40
 ? register_lapic_address+0x3d/0x50
 ? register_lapic_address+0x9/0x50
 ? x86_dtb_init+0xdc/0x2f0
 ? __pfx_acpi_parse_lapic+0x10/0x10
 setup_arch+0x8e1/0xd70
 start_kernel+0x66/0x6e0
 x86_64_start_reservations+0x1c/0x30
 x86_64_start_kernel+0xce/0xe0
 secondary_startup_64_no_verify+0x18a/0x18b
 </TASK>

This warning may lead users to believe they have a early kernel panic,
or major issue stemming from BIOS. This can be avoided unless the
kernel is being passed a non-default value for LAPIC address.

Fixes: 81287ad65da5b8 ("x86/apic: Sanitize APIC address setup")
Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
---
 arch/x86/kernel/apic/apic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d73ba5a7b623..e71cc6f776fe 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2078,7 +2078,9 @@ static __init void apic_set_fixmap(bool read_apic)
 void __init register_lapic_address(unsigned long address)
 {
 	/* This should only happen once */
-	WARN_ON_ONCE(mp_lapic_addr);
+	if (address != APIC_DEFAULT_PHYS_BASE)
+		WARN_ON_ONCE(mp_lapic_addr);
+
 	mp_lapic_addr = address;
 
 	if (!x2apic_mode)
-- 
2.43.0


