Return-Path: <linux-kernel+bounces-768242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 212F3B25EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844CE1C87C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9745F2E8E0E;
	Thu, 14 Aug 2025 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="F0MSg3FO"
Received: from out162-62-58-69.mail.qq.com (out162-62-58-69.mail.qq.com [162.62.58.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594A25B2E3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159907; cv=none; b=h9ShUEuQl88BWcyMjFiLtoxhBqIdl+ohTDW9TatxtcrdLsPznIzem1IL7qTfNilVBCdixsobUSrfsRmBNRj+qpvrMEGq2zVWKNl+1YhMAxSthTQ6kZJeGeXx7/Ap3gNaNdwim991yQ2rW3X8IkKMgEEjQK3m/zDbrpRW69Oz/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159907; c=relaxed/simple;
	bh=fJwA3Wsi5qpZzCtNYjIXgQ6A+h2vJij5+Dz6yEHJ+es=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=WMCxI5lRtx937dJyvNt/avR1gH4MlNxFcjIEsgNTOcEI4IC8GiB/7zTQiYx29ej/sAp0gEn7GWBC6iiONSyfJkbhZs+/KctviF8uzbnbG/twsjLF633x2kbJXrf+ixypYeavgcUoEiEO11mGzOrOkid8eFa6lysNgyKDYQ2UBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=F0MSg3FO; arc=none smtp.client-ip=162.62.58.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755159899; bh=N/RCDYzoGGGtQMS42zug99z+6gLmBa7KLqRyaAfRQUs=;
	h=From:To:Cc:Subject:Date;
	b=F0MSg3FOlNs2vGs3bDCfIVEbgE1E74QInyw5Sx/iDFyW1vIgU9azlrjle7rafOVxI
	 hKM460+dRIiyFEZBsjWGEm2/3WBWeowTG2RF3XCK4oq36QXnyaTygY+lHvyqv/o0AI
	 UrARqvSTqEAN027jkPsNREjxkOMvSFXsmGDaLDW8=
Received: from VM-222-126-tencentos.localdomain ([14.116.239.37])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 63929001; Thu, 14 Aug 2025 16:24:57 +0800
X-QQ-mid: xmsmtpt1755159897td1m5xjle
Message-ID: <tencent_E69E39D3C1EAC68651075BCF298FFE81BE07@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLKNB2xFolFIhnp8fqpIAbYDBcppu4/+J5bh+jYbKiU3eQ3k+1eg
	 v73kX6H0N/eucNuBgbFhJVIUu+k8tChg/BH7fqmDif42EFJ1RlCdnTRBGqw7knDp3WUqdfpC6bQN
	 OuLt1YsmD5D5m5P4ri4YmCtK5iKPdU8EnlUxDUm2hw9HJi9iaScsyRGJSezuwjVTR3pxddtgaxue
	 9QEeiDkeXcivFLSCHtHHTrlktTPUhMCMO54eaaUQ+80IPDWr+FEUSoAYQm/R7nlOizd4cFX/g2vX
	 uNUC8X98Ucrs2Zof47PW+QJLl2KC5/SrnuALStYPNKr5wPK3So5zIrswRLVn+cpn6NXc7dgIgKGm
	 Oli4eZKM6/Cj/vxrGrQGHl6KzBx8mpMtG2KCU3ZUgSAfYutlAEtlA6pqOSox0czgc8uc46jQ4/ID
	 DWSHq3FwTdDwCcLsxuyXhlVeeJWh3WUf1/M0khm83l3I3H1nsqLzducwr9aqGV5ap+FXAMm0+cVo
	 HC3hOzwGwIqTlna3R61m/uvPbNScXlHwf4foaNJvbg9YbTJPeceFMcW89LbnvMBSDDKBHTUXgvtE
	 tCO6k2UQacJztek8fITzHM6hVg+5ArXinWOSiuUh/lXIoiHTiaoEznOBOY45YTSDvGapfp+qtn9G
	 U9v5neRfW68QWOORqun7h+9N2PeMvmTMzR6jbNbmsf1BQOkNGhsfnKuGvL4elHWmiKTwkGgCsozR
	 EKI7upytjjq8GeE9XcsxyXSls+yIDnYfodLpKYd0q0/f+1PAzTr3XXqQeQR1tFZVhImaqhW6vAZZ
	 20fO5rPn+sivcuo87RcDEjUUIucgTd2618O2ObJ07dg+6hQh0QSItyOfQoZSX+yQLsuJUoJhT4gD
	 96fDNAWV8XoqvH84+NAOD72MnYsDKa1jx35FyHXRu+gMq5g247wVyuTH19XdRaQ3r05LI9MsLF4K
	 fFLyhTUNMz+57olKOppUFP6kt9aaMJYdA41DqIM6Q24jwfTCIMOWCXiTDI1mSUnF1fSPUussg5N+
	 9uvQBsu2VpkCOniCZnhV0Bgrzr/CDPZmiYdRFYeOcdVxl2CLP69b1Xet1ZhJrqPL0nWyyngwejQH
	 Z9QpFB
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Vencent Liu <961342126@qq.com>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	961342126@qq.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Vencent Liu <Security@tencent.com>
Subject: [PATCH] powerpc: Fix resource leak in ls_uart.c
Date: Thu, 14 Aug 2025 16:24:50 +0800
X-OQ-MSGID: <20250814082450.768340-1-961342126@qq.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vencent Liu <Security@tencent.com>

In the ls_uarts_init function, the device node
reference count wasn't properly released on error paths.
When `of_get_property("clock-frequency")`
fails, the function returns `-EINVAL` without calling
`of_node_put(avr)` to release the device node reference obtained by
`of_find_node_by_path()`.

Signed-off-by: Vencent Liu <Security@tencent.com>
---
 arch/powerpc/platforms/embedded6xx/ls_uart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/powerpc/platforms/embedded6xx/ls_uart.c
index 6c1dbf8ae718..b889206bea4c 100644
--- a/arch/powerpc/platforms/embedded6xx/ls_uart.c
+++ b/arch/powerpc/platforms/embedded6xx/ls_uart.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <asm/io.h>
 #include <asm/termbits.h>
+#include <linux/cleanup.h>
 
 #include "mpc10x.h"
 
@@ -114,11 +115,11 @@ static void __init ls_uart_init(void)
 
 static int __init ls_uarts_init(void)
 {
-	struct device_node *avr;
 	struct resource res;
 	int len, ret;
 
-	avr = of_find_node_by_path("/soc10x/serial@80004500");
+	struct device_node *avr __free(device_node) =
+			of_find_node_by_path("/soc10x/serial@80004500");
 	if (!avr)
 		return -EINVAL;
 
-- 
2.43.5


