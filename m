Return-Path: <linux-kernel+bounces-750492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE03EB15C46
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E2457B0DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5CB36124;
	Wed, 30 Jul 2025 09:40:41 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B4019D065
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868441; cv=none; b=VqQZcf3dDfzhlPtRXMJJ6tzxYSlBpnvztozvupXOLwUM9CDYHZz5L6drkomg/bnB95P6PlJNcnFOXYDKSIEBPRmUoFauR0SCYA+JJYB09ypd93BgtfC+I1utq08dKl1xwpba54fEtLH3YPPWRWvNwwMDJohKR3ws45I+jk4M1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868441; c=relaxed/simple;
	bh=CiAKwiX+j6CEGgY++7WJYsipqIoKeWrZdZMWO31dzzM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vCKc59scIiQugqy58gdiczPuGO7mqTqXs03JhFZsJ+PTfUT9dJ0MuxmzT5Tyk05D8O+/FEYinjaGHqCPxZvOJeNgFWhj+ZAoQRlEyHLgEZY4wJr84GMdSOx6x4RJyh5BCx2vyR93eFhXn2LprpTSCdq42Q4oaf8yJht6yDYUKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201608.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202507301740262167;
        Wed, 30 Jul 2025 17:40:26 +0800
Received: from locahost.localdomain.com (10.94.11.126) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2507.57; Wed, 30 Jul 2025 17:40:25 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>,
	<nathan@kernel.org>, <ebiggers@kernel.org>, <linus.walleij@linaro.org>,
	<rostedt@goodmis.org>, <kees@kernel.org>, <ruanjinjie@huawei.com>,
	<dave@vasilevsky.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] ARM: Kconfig: Remove repeated word in Kconfig
Date: Wed, 30 Jul 2025 17:40:12 +0800
Message-ID: <20250730094012.3200-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20257301740267c554ea7e2085ffd15d81d4884a3010c
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Remove the repeated word "the" in description of the help field.

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b1f3df39ed40..20f88ea59818 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1502,7 +1502,7 @@ config ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
 	bool "Extend with bootloader kernel arguments"
 	help
 	  The command-line arguments provided by the boot loader will be
-	  appended to the the device tree bootargs property.
+	  appended to the device tree bootargs property.
 
 endchoice
 
@@ -1644,7 +1644,7 @@ config DMI
 	  continue to boot on existing non-UEFI platforms.
 
 	  NOTE: This does *NOT* enable or encourage the use of DMI quirks,
-	  i.e., the the practice of identifying the platform via DMI to
+	  i.e., the practice of identifying the platform via DMI to
 	  decide whether certain workarounds for buggy hardware and/or
 	  firmware need to be enabled. This would require the DMI subsystem
 	  to be enabled much earlier than we do on ARM, which is non-trivial.
-- 
2.43.0


