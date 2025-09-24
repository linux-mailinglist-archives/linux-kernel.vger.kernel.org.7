Return-Path: <linux-kernel+bounces-830551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6A8B99F58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE6A32871F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5272E1EE1;
	Wed, 24 Sep 2025 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dMgPnnXF"
Received: from mx-relay98-hz2.antispameurope.com (mx-relay98-hz2.antispameurope.com [94.100.136.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613D2D660B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.198
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718867; cv=pass; b=Wv+Cwjy8wBhRfEwtiKEXHkh3sVZkXa4q3YQUAUoK8ckbqsdNc+ch4BhnbKGeMVnpHgZj2FULFygPTlbaXWuM6WE75QS0RBUjlw11k+jHSxlkr1rYjGykphHv4VQ5XmVOR+XLAgkHh+hOFD57exel+PodrJmyNmwgPO/3NRYegCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718867; c=relaxed/simple;
	bh=tRFO2lmj9fh8+cqEU3EcQ/kLEOghCXUYGgOwKHAIOT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKv1zSiP2kvoI9/SWo8mcCz4V4UQFmsEFjFC+4OdA0D0Q9cDVUePzYXELgtHhrvtBMD4oYq/vqIdKuqj7z8R3iMxmTrDUNvZIQCMuxGaf/dQ+lHO3an3MT54094Ms6lPBq6wSlTWx2h4Z8sx17kLmFsFFSOfURTDLmy7fvEj8Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=dMgPnnXF; arc=pass smtp.client-ip=94.100.136.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate98-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=9UDISnZw3L2CnlLPkLi4dm5l+dhut+bxyAY7QFGqaZY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1758718831;
 b=YV37sbsoBsxzRzIClrFFXwiy8dPlK1nA2sKxVcpHlzOteAz4cH1/8OyZrP/NXsC6R9NVV+rt
 SsOJu5r7v1NrSESSYvTsmIPa9CeywmpN5HcxIG3GUxIZiuCfQ/cj9tXA4Ta7Uv3dEhXUX8kghGE
 AeqRGzwvxE0FkKRqiOh0FeEn11xsGbuk8qqDzks7Wfsxyl2SZXTA+7T6BTT2UoK9MnN2UpYNCyV
 DNejCATpq36Dp4RgDSdA4Y39m241qWUnOtsaVpXQNAAL3Kz2Xz7TcdpwrDza/koE9F/2cVUsgcm
 5+VmXycTQ9FgZ7JnwRjkJNnyUObpppWy6AGdezvwiryVg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1758718831;
 b=jISLSrYEKn8QVNX2Cs/bzm2VT+8Dy6+AYACQLgJUUibL3ukIZQrMtsmFj/QzGfV2JS+pXKGv
 Kpj/3oPriPJOziBinZ5eADjQpY+IJ22Eaf/PUgGWfzU5+CZqp2AHZgC8bW5wsHaLdETtJlXE8Qu
 IwklxtWfxd33/b08572XkV6/bWH2xY8CYPrV/3aJTTvQOVMXbu+OO/jkHkRodhDjEEKDkgR2lzH
 S1W2sjBi+Q7qOp6IQg5qTKAhms+nCLz5mix+Q8ng8K5RrcFtca3oqMjWZiO4Frd5X/lk+PoAxRz
 YDm8T4kXB1Y2GJGvP0ZTqIVw4hroNt+06z7Bn/gDZV30w==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay98-hz2.antispameurope.com;
 Wed, 24 Sep 2025 15:00:31 +0200
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id B64FC220CCC;
	Wed, 24 Sep 2025 15:00:20 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Max Zhen <max.zhen@amd.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dmaengine: xilinx: xdma: Fix regmap's max_register
Date: Wed, 24 Sep 2025 14:59:41 +0200
Message-ID: <20250924125941.742020-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay98-hz2.antispameurope.com with 4cWxln2CYmzJVhx
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:80bcfa90857a8c74b541e95d24a74b4e
X-cloud-security:scantime:2.129
DKIM-Signature: a=rsa-sha256;
 bh=9UDISnZw3L2CnlLPkLi4dm5l+dhut+bxyAY7QFGqaZY=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1758718831; v=1;
 b=dMgPnnXFkAz2lIAEQLzDaAs2ypXEhdZX+9a5G8wVnKCGYQtlGE0u8PwONcJm+6RC0kiLUJZ6
 QVfQuApva+ZyY2/EY4E8MOThjRxSU91mFLeX9yBHKHEQ347R6dBFf0Xk5qcG9XzoCFqHxoLUnAR
 EdIxvfTQsFfDzIGptLiXFzR+9hlTGFXxk/Slhi9mOLI3bTKrjLsdaMRokjkGbze/sYKV9/1ox4I
 OwKKKXORbqwlYjUZNb9Xq6QC6lMCeSznYJz/u57n+vepN1DFZPCKTpd91tOOZ467EHd3lagZyh+
 PFyuLNyNCejIppaFFXKWgZ/WVlrBJHbqlVfYtR7kWqK4g==

max_register specifies the last valid register address. As the BAR is only
64kiB in size, 65536 aka 0x10000 is too big. Restrict the XDMA register
space to be actually 64kiB.

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/dma/xilinx/xdma-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
index 6ad08878e9386..c6ef198ef7627 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -8,7 +8,7 @@
 #define __DMA_XDMA_REGS_H
 
 /* The length of register space exposed to host */
-#define XDMA_REG_SPACE_LEN	65536
+#define XDMA_REG_SPACE_LEN	0xffff
 
 /*
  * maximum number of DMA channels for each direction:
-- 
2.43.0


