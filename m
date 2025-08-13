Return-Path: <linux-kernel+bounces-767561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C73E3B255F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA5E1893A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696D21638A;
	Wed, 13 Aug 2025 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E+VfenYN"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE82BDC2B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121862; cv=none; b=egjKYD2LEQLyhWio/JYD9kypWbTd2/kw/2r2ENQny7PPh5nFVnrYPsLHh6btV/ebGdxILB/azX9TgoVIBXtvNpfddCxICHjh3a2usxQN8lSAA9ET0HpW5lSMbhxqWc370guc/C+L/8E6Gkm516FK7tFFgora6DECi0K6vByMUjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121862; c=relaxed/simple;
	bh=y+vKyrlw3Ew4NzpaPTgoDaZAUvW2b82tT61U2pj8ovM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jRuWRUAesPDq2GQJhGXekD9/1qUpBI0afh7UeRuHLHEUeU0Fcu8dPXG0c8BEV1ZYoSDFS7AfmviUAdkbUCBhp7pvTU62kunTWrTds6SUPqYibDiD+ObGw9zHCbPpDAyRp5F7bD01hgWdEWXCb2jThPRdn+saudMWaTi2EAuPB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E+VfenYN; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DLok371738293;
	Wed, 13 Aug 2025 16:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755121846;
	bh=Q26Q+ekksGKEwhnH7ILghZQnmCPvicAfclZHAIY3oOU=;
	h=From:To:CC:Subject:Date;
	b=E+VfenYNF7AsJdVz/1vTGkcQ3zgZH/C4/m3/A1KJDP3xYur4NZ57+DxkereeE2/Wy
	 fH871ColrjISBzB/Id2mEKPqNG2RGJyE0jJgXxYtFkuIjvrT43ERfmlGz0MnhiHouv
	 njv4blOwIOCnIfJC4XlatyOBk+vS9TboQaMzW0G8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DLok3E357657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 16:50:46 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 16:50:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 16:50:46 -0500
Received: from fllvem-mr07.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DLoj9r2619389;
	Wed, 13 Aug 2025 16:50:45 -0500
From: Andrew Davis <afd@ti.com>
To: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH] ARM: setup: Use register_sys_off_handler(SYS_OFF_MODE_RESTART)
Date: Wed, 13 Aug 2025 16:50:45 -0500
Message-ID: <20250813215045.543957-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Function register_restart_handler() is deprecated. Using this new API
removes our need to keep and manage a struct notifier_block.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/kernel/setup.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 0bfd66c7ada05..8e21634109ef8 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1081,18 +1081,12 @@ void __init hyp_mode_check(void)
 
 static void (*__arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 
-static int arm_restart(struct notifier_block *nb, unsigned long action,
-		       void *data)
+static int arm_restart(struct sys_off_data *data)
 {
-	__arm_pm_restart(action, data);
+	__arm_pm_restart(data->mode, data->cmd);
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block arm_restart_nb = {
-	.notifier_call = arm_restart,
-	.priority = 128,
-};
-
 void __init setup_arch(char **cmdline_p)
 {
 	const struct machine_desc *mdesc = NULL;
@@ -1160,7 +1154,7 @@ void __init setup_arch(char **cmdline_p)
 
 	if (mdesc->restart) {
 		__arm_pm_restart = mdesc->restart;
-		register_restart_handler(&arm_restart_nb);
+		register_sys_off_handler(SYS_OFF_MODE_RESTART, 128, arm_restart, NULL);
 	}
 
 	unflatten_device_tree();
-- 
2.39.2


