Return-Path: <linux-kernel+bounces-899369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5604EC57851
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C3E54E124C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68782350281;
	Thu, 13 Nov 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zmRLx/Cl"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D834D91E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038918; cv=none; b=q7kCNUsS9rBiw+HO98MxkM9RRJ0oB9LNeH3TZ/4kc4LG7UI8ZyGJFGRDBDYSp2DrT/jPiYLj2/CXMcVPuB0+Cs3MgPuLe94q0dyAsUCJqUKfGLed2uM/OgVSnevVV4FsnUCbGCJqM/2jSy7IPJbQrwuqSlEwULoMcCNBNR1h8uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038918; c=relaxed/simple;
	bh=sOv3gpVFSUTOf8qccBUFlmorrQlW6YAkct0+Z3bQd3Y=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=eR9adwHRUxaHkzgyaRLovkt5Z5idpu0VYImvuurG/hHpy7u+imKOpsPymAvDyzJygxabZ9aPmSO0dM+RPv8H+6WiC04/D0rNvNviu9l0AzGGsA/i1cI1kSfWnY5cy+JzNb1Z7y1ptZ2i7Q3hwEPUChZ247yV8CXxDwnlEMmjn28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zmRLx/Cl; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1763038912; bh=/GQTtJfCoEQKgTxPit1J56QLlgdP/pwagyLI+EW9z0I=;
	h=From:To:Cc:Subject:Date;
	b=zmRLx/ClAQcwckMcZR1MZwQutgvY81+YK+sekMGUBQ3uc/4Hghkw2iBRdQICuwIpc
	 qVsU0PSF1fA2i5Z0g0gkAkWyO3LQp/zVE/HVbaCQ61M7dK6FpIhSaJUeqTCKUo7YgL
	 LUzgdQUIlo1o2EQoB0SkjWFuqmw4t4F0BCSecnrU=
Received: from cjz-VMware-Virtual-Platform ([110.176.66.153])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 71044C0; Thu, 13 Nov 2025 21:01:49 +0800
X-QQ-mid: xmsmtpt1763038909t8bqh70fz
Message-ID: <tencent_7710B04B6BEE52903BA2F56376DB9D18A907@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuDkyxHrl5zINS911HPJeNGCbHELH9l+vnjxOT5Bx7zaZyTUd9/w
	 /gMcG0QZ8vKBexkGg+7xSWnLg0yp5ZkOsVDsZ/IO9Hy3mLNDURCgTYkL7vbhcjUIUaaJHtAPmfTc
	 DOxKS2vHR7psP07SL4rlf8w/9t6Ykjc1pFrIAgdN5tomK32H+wy3gEjScTD9VVhU9XhRYXky4V54
	 ML+HUmt/G0UxfUrDITWKzy0xbECN6pXzcZWSRGPGe0Dzjs5grXfvajtLM5cOI8uUDzd81aTBDbgd
	 FvTgsG9USwVSnWvK6gQNFDGSqp6DxCc0N0RuwTcQdtaAOpkC4Ns7qVxcCVKsDzRp0tGFWkDGgGLR
	 CaQAFDKnv5Hhkz4rxKJ3X1Wg+BP+3dJjC9zFQuwANF4t1Qm3DDSaH80CfRD/ZS6t9d9U6uNVCC1p
	 rGmzEiHA7ePkEZB/hHkZKfJEH4TRCPxY2R/4/NLYT/yBSCHd730VogMpBWMIGJYRH0MardF2PBgV
	 JLwa2FHJ+HRMjPBJDx1NiJxM+hgPrW1fhrGTyMaSsi6ONSN2LVsaW04yFqILPCmlVytXkSvOR3Sk
	 OCZolXSb+AwADDLoBp/IZPkU4DMmqQumDOCERWaKmWUFSlFvG0FbxArINiMpLq/xae8nKM7hYfIF
	 l+3uG7oP3m+LZc1Qbql4noqHYPgnqctFmWuqk6zxs46sV7ylGIYz6c2C9gvlC08tBB6lEUR3OcBh
	 E0yB70/Uj0Lm+/+R5Xfu+VDZDSK8XIizbCat0jFFBPO0sa2GYg8iskfSwOBJO+RBTRneSOXcw01l
	 RsNLsJ6/Rz3dWHnCSkNhKAkvVJ+VhnvI+Sjb1QAEBhEkB9oi3x9l96AJ7QNCdFVXeHMXJ1STJ+2C
	 zDSOELsXcygqTP9CAYRnwgItvEJ4+WQkaKmW5yvtPZNixep58RP15720Tp3BRX1HR+qOpLzBZAHv
	 o9eV7d2E8KcQqaBwyhO4z/6LYY4fqr9joy/5tec0VgMMRjsiRHRUrE58kZt37DZuSyv0rTgiQgYP
	 K3VzlK9XhLpzps6A+URTb18ocZSm4Be2wbHM1Yc444v/deAoSBMyOuoDmoCqLutEEmy6uhdU822r
	 rHM+pkGRZFSerB1dw=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Chang Junzheng <guagua210311@qq.com>
To: outreachy@lists.linux.dev
Cc: Vaibhav Agarwal <vaibhav.sr@gmail.com>,
	Mark Greer <mgreer@animalcreek.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	guagua210311@qq.com,
	Chang Junzheng <guagua210311@outlook.com>
Subject: [PATCH] staging: greybus: audio_manager_module: make envp array static const
Date: Thu, 13 Nov 2025 21:01:46 +0800
X-OQ-MSGID: <20251113130146.72831-1-guagua210311@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chang Junzheng <guagua210311@outlook.com>

The envp array in send_add_uevent() function is declared as a non-const
local array, which triggers the following checkpatch.pl warning:

WARNING: char * array declaration might be better as static const

Change the declaration to 'static const char * const' to improve code
safety by making the array read-only and allow for better compiler
optimization. This follows the kernel coding style recommendations.

Signed-off-by: Chang Junzheng <guagua210311@qq.com>
---
 drivers/staging/greybus/audio_manager_module.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
index 4a4dfb42f50f..ca6a2cd0bc4f 100644
--- a/drivers/staging/greybus/audio_manager_module.c
+++ b/drivers/staging/greybus/audio_manager_module.c
@@ -159,14 +159,14 @@ static void send_add_uevent(struct gb_audio_manager_module *module)
 	char ip_devices_string[64];
 	char op_devices_string[64];
 
-	char *envp[] = {
-		name_string,
-		vid_string,
-		pid_string,
-		intf_id_string,
-		ip_devices_string,
-		op_devices_string,
-		NULL
+	static const char * const envp[] = {
+						name_string,
+						vid_string,
+						pid_string,
+						intf_id_string,
+						ip_devices_string,
+						op_devices_string,
+						NULL
 	};
 
 	snprintf(name_string, 128, "NAME=%s", module->desc.name);
-- 
2.43.0


