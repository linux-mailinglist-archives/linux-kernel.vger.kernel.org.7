Return-Path: <linux-kernel+bounces-850361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE60BBD29F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 642B04E78E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3406B3043C7;
	Mon, 13 Oct 2025 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="C/IUQwJR"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC0D303CB0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352508; cv=none; b=j/8dKL9nJXxc0VDTSwBjzTWDpek/pkCbD28YKELpfl9k9bz/T+oK5dayGBELvRsVmv0dS+Zs0jpnj5rVI78xhQ8Ezw0NRU7rFOUGNk313IFnv0Q15Y5SWexJ1HhKbtA0lUowDXBWmr6oBs5JKf2W4iHRnjVHQ5ukM7xZKM22uPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352508; c=relaxed/simple;
	bh=fzbFR5HRnGrKHRndRJ8HHP3IHBABgYcit+jrA4C+kmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQe4BdHshbpowcvjvd9BsjLbMPWmseNGsALi6RSXULOgJUcVmwg8wkRY3Ed+yN4Ycb74zHf/GYl0JVO4brlz6ly/yRhTOEuuCANP9AWDgTFb2XoElJQQ/7bnA+9dXMRUs5r/MlvVsgQN/lE6Y4RZkwzDe2E7207X8m5mXcElnvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=C/IUQwJR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760352024;
	bh=fzbFR5HRnGrKHRndRJ8HHP3IHBABgYcit+jrA4C+kmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C/IUQwJRljYYCG64In1mr1nBxn9Tmc/5hOpZiMh09bqkYMVVIFFirEqV+s66BiwcS
	 /PZlG7UCuvio8IhpNmitlH2pvfLYu+7G3KxBZHxqATtPFcD+f1Jh0w84XMh4K6COw1
	 SW+LaqUQkqMUtV1Isj6A3RRL/FzEElq3Vsf/0rI0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 12:40:21 +0200
Subject: [PATCH 4/4] x86/um/vdso: Drop VDSO64-y from Makefile
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-uml-vdso-cleanup-v1-4-a079c7adcc69@weissschuh.net>
References: <20251013-uml-vdso-cleanup-v1-0-a079c7adcc69@weissschuh.net>
In-Reply-To: <20251013-uml-vdso-cleanup-v1-0-a079c7adcc69@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352023; l=749;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=fzbFR5HRnGrKHRndRJ8HHP3IHBABgYcit+jrA4C+kmQ=;
 b=oTuqtMKWBTQHe1Og6mGe7pRgLqIMi3izMEb85Zh1vxzG84LlxI8l3H7Rp3s14EZTLfbcb5KzH
 H3XYP1eH6S6B3wX0SQEBZCcMsonIIQAMT74yuPXPlK5isdMR19SfGO3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This symbol is unnecessary, remove it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/um/vdso/Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 7478d11dacb7..8a7c8b37cb6e 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -3,16 +3,13 @@
 # Building vDSO images for x86.
 #
 
-VDSO64-y		:= y
-
-vdso-install-$(VDSO64-y)	+= vdso.so
-
+vdso-install-y += vdso.so
 
 # files to link into the vdso
 vobjs-y := vdso-note.o um_vdso.o
 
 # files to link into kernel
-obj-$(VDSO64-y)			+= vdso.o vma.o
+obj-y += vdso.o vma.o
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
 

-- 
2.51.0


