Return-Path: <linux-kernel+bounces-872088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8476C0F38C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E361882245
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F71C311966;
	Mon, 27 Oct 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GnE7CbsZ"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D75695
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581745; cv=none; b=bYJ0v/f0eHT9Fk+owk1aCc9ZjEbWAvEMdhAyp5uZT7Pbu8GCswq6OacGzNHUA4afZGUqWwFE6n9ahcURq66FgKqHxfvtrt1RGRoA49nxSmCLj08UHNqmY6X7q+LGxmeqDijF67X4xQYPd9T7ZFAf3xfq4mpweFvhwKxTajx2EEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581745; c=relaxed/simple;
	bh=c3/+0slUM57/EcYztzT+r5Zikk/wyIOfFEzOQ3Lm16A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qWEjDFqpzggXSjnXEM7yD0d+6sAWg5N6HP57SPPZOtwEh08Y40/uaFmRbFUWTIujOfqkuuvQYmM5gQLpnUtXlORFQ1eUNBXW7mOxCCBQfKXjDgYYZKcfYhW77zjw4qLFF+tocYNnPCSdD+pTl9sZnddWOt1CTkxfgEuofj1/pjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GnE7CbsZ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C6B96C0BE82
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:15:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ED0346062C;
	Mon, 27 Oct 2025 16:15:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A02E3102F00CC;
	Mon, 27 Oct 2025 17:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761581740; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=qurVgCoEOWNMfKzqoeELfrnEOh/ndNaXvS6N4y9te4o=;
	b=GnE7CbsZefVVGYT/5MKI6YZv8JLN2VycykrHk7MXBPpEmkJlDKrbMU6dE07FFSgqR8d5Qu
	vDP2MLNvT2bbbbSHWTMFWkN51cRHr9fqwAYjrDiEY/s/UVNN1xQOYbrI9ad5IWz8k2sfwj
	whqWms733o669/GsVWYT7ohSIivWXyvV1XK+Y1XjylzpOMb/80bCV+VEAbJCG7HZqrlFNi
	+MjKoFKDy+EXt8YzUqoIhMuODyyGEB6kaoiHUl19lCAPY6k4ICpFvP/u6ocJ72LS9Tjtq2
	mzh5RnAi/+ur2FbVpgT+wAJVbehsFq1mUgHIvK9O/KyrPiEcRgCNHiZkKWquNQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Mon, 27 Oct 2025 17:15:35 +0100
Subject: [PATCH] MIPS: Fix HOTPLUG_PARALLEL dependency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251027-mips_paralell_hotplug-v1-1-82567f3e4b85@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAKaa/2gC/x3M0QpAMBSA4VfRubayU4hXkXRwNqeGtSEl7265/
 C7+/4HIQThCmz0Q+JIo+5ag8wymhTbLSuZkwAJLXWCtVvFx8BTIsXPDsh/enVZxQ4yjNqSxgtT
 6wEbu/9v17/sBLoAc6GcAAAA=
X-Change-ID: 20251027-mips_paralell_hotplug-e9ae2b1fa126
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-mips@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

With MIPS, it is possible to have SMP enabled without HOTPLUG_CPU
selected. However, in kernel/cpu.c, some code that uses
HOTPLUG_PARALLEL also requires HOTPLUG_CPU to be selected. Therefore,
we should fix the HOTPLUG_PARALLEL dependency to depend on
HOTPLUG_CPU, not just SMP.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510270120.21wA1aX1-lkp@intel.com/
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e8683f58fd3e2..b88b97139fa8e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -658,7 +658,7 @@ config EYEQ
 	select USB_UHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
 	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USE_OF
-	select HOTPLUG_PARALLEL if SMP
+	select HOTPLUG_PARALLEL if HOTPLUG_CPU
 	help
 	  Select this to build a kernel supporting EyeQ SoC from Mobileye.
 

---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251027-mips_paralell_hotplug-e9ae2b1fa126

Best regards,
-- 
Grégory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


