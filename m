Return-Path: <linux-kernel+bounces-853701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79929BDC5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6858F4E40C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8312BE7D9;
	Wed, 15 Oct 2025 03:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="xLbMLvvL"
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD01DE3A4;
	Wed, 15 Oct 2025 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499633; cv=none; b=SCP34qcArR4iCiHbo3GNmLEAIKoPqmt/OqzdDvHVNlhZCBqfeAW7vzM6LPaaJJznj1OvyG22taJd582qryMELt5dEs5VY/uqKrnLnY+TXzrNRtUHdMtK1lXo7fJTREBbFnUkIfqizfs3EPMGlK3Ym4aZT9Flu8SpCmtdzdhdq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499633; c=relaxed/simple;
	bh=tF8UVJ7iV9XbY4WtnFX6iDlveE635HSDujJ70qOG/W4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBJlBGzp0l5KKdsiXVT3R5YdiigstIrEpvmdMth9QV/xjAl/YjDO7r338SqT2jeKsXHXMezpbyurAR2/hAMVpYv9nLy7X7/58fTQoS22Bx6+XJBURU3M6fLGYdq74rnt1SZgAeUpgtp4oN9ZXibE3pFTl54MS0d4Yuk/QOnSyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=xLbMLvvL; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1760499630; x=1792035630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h+wM+eAwDJ3fdxxHZktrCzap9vXJ+Q0aN8qJ3Pnqwx0=;
  b=xLbMLvvL5qMZl3kuH5Cf4vmk+SRYsQx8WT4a3ayNU9+GZuIOEB8FNDob
   hwFlj3h1jz2H2NLrFF8fV+/lwpDpzii6e4p+B2pL/QwR6ts8ROLLm4EGZ
   5SdCyCqxM4IfkFiagXiMdJDITq3PKmVBfipQWPFs1bLIl3lM60b3+000E
   1qv4qmtR80fwYObWw/LpNRpxCg1ZkFetOwGHkIeeyQq1/HYlA4624zTSU
   fwHB5qqmY0Y9aOzZG0zkYSIFow994NwK/+96FoSqyhhM2Ys3mAOaeyQ85
   fofSwJl/ZndfkpwfNszZB4NQBFIfzyuHD435vsrg9cfX3C0/IFIieAPeu
   w==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:30:21 +0900
X-IronPort-AV: E=Sophos;i="6.19,227,1754924400"; 
   d="scan'208";a="45749282"
Received: from unknown (HELO asagi..) ([43.11.56.84])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 15 Oct 2025 12:30:20 +0900
From: Yohei Kojima <Yohei.Kojima@sony.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Yohei Kojima <Yohei.Kojima@sony.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: admin-guide: Fix a typo in kernel-parameters.txt
Date: Wed, 15 Oct 2025 12:31:03 +0900
Message-ID: <edda15e3fcae13265278d3c3bd93ab077345d78f.1760498951.git.Yohei.Kojima@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the stacktrace parameter description in kernel-parameters.txt

Signed-off-by: Yohei Kojima <Yohei.Kojima@sony.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6c42061ca20e..f29ba44b5be2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7150,7 +7150,7 @@
 			limit. Default value is 8191 pools.
 
 	stacktrace	[FTRACE]
-			Enabled the stack tracer on boot up.
+			Enable the stack tracer on boot up.
 
 	stacktrace_filter=[function-list]
 			[FTRACE] Limit the functions that the stack tracer
-- 
2.43.0


