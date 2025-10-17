Return-Path: <linux-kernel+bounces-857744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3064BE7D81
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757141AA2701
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449702040B6;
	Fri, 17 Oct 2025 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ikjvnVPy"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDAC223710
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693864; cv=none; b=RfmZPJ7yeGKcnCXuduOiAUbE4jIIAa1fohCrMK/RT7uzhrD1+tGQYdo7xQ3ZvYxu2GFwui7N2S7Yz+Om8d4qvn4X9T6JLLBUUo30qL3CYUOl9O2OetAhInGDZgWDdD/NL5QNTpsJ9iqkmyy7z54ph/Did+RPVDiM7TYP+lrCwyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693864; c=relaxed/simple;
	bh=kG/XQ+koZva2N0IsJhFjDoZbbk5+t6+2MnH1jmZzry4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INO47nKS1+VED/wdbJj51Jo/1AsFJDH1UX4n1/n3NwOjwfynM/HdD2uVqy03gjuF33xCyXsmcsHB6jSlgpD+QmH2q4hfS96vG7U5NpkQ3D7FoxDrXovZyKFal8iQg3HtfLI9bxxVelCyqnI8afHGMsKr3yK0f1G+zsrBLFEBJu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ikjvnVPy; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760693858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FLBYN9hxjP1ZEXOKeUWi+RhuhLrIWgdnsFzXHfFvcco=;
	b=ikjvnVPypXR1CmRzxKu02pel8Zj0SApHyVeLGHRuUefsNxuy+Un3DmyDkEEG9qV6mh2Ycx
	G4hhKwNTJJhSJZK5AQ9mNwPhyUF7qqnMW9oOjScOsQkzj6NAPSjmHQH1orsallqRqyj0/F
	xpzns8Ru6440OJ22hyr/CbonC31Qb0o=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steve Wahl <steve.wahl@hpe.com>,
	Justin Ernst <justin.ernst@hpe.com>,
	Kyle Meyer <kyle.meyer@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Russ Anderson <russ.anderson@hpe.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/platform/uv: Use str_enabled_disabled in uv_nmi_setup_hubless_intr
Date: Fri, 17 Oct 2025 11:37:12 +0200
Message-ID: <20251017093711.38194-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace hard-coded strings with the str_enabled_disabled() helper. This
unifies the output and helps the linker with deduplication, which can
result in a smaller binary. Additionally, silence the following
Coccinelle/coccicheck warning reported by string_choices.cocci:

  opportunity for str_enabled_disabled(uv_pch_intr_now_enabled)

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/platform/uv/uv_nmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 5c50e550ab63..565ab43fa6b4 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -18,6 +18,7 @@
 #include <linux/sched/debug.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/clocksource.h>
 
 #include <asm/apic.h>
@@ -340,7 +341,7 @@ static void uv_nmi_setup_hubless_intr(void)
 		uv_pch_intr_now_enabled ? GPIROUTNMI : 0);
 
 	nmi_debug("UV:NMI: GPP_D_0 interrupt %s\n",
-		uv_pch_intr_now_enabled ? "enabled" : "disabled");
+		str_enabled_disabled(uv_pch_intr_now_enabled));
 }
 
 static struct init_nmi {
-- 
2.51.0


