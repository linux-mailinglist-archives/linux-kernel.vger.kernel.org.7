Return-Path: <linux-kernel+bounces-748812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BF6B14633
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246421AA1830
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF65207E1D;
	Tue, 29 Jul 2025 02:30:26 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2277DA6A;
	Tue, 29 Jul 2025 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756225; cv=none; b=qtMlL/FMvbhHMQSjbhP+2lLx9J8QmraGL5/Jg8hbFAp+0cPLt40BKWSqblnk2Wzh9dih1zmAhwOXcqtvTed908eHm6J/8xRO6ix3HwbE3O+5e9tbXkChQMj1rmC8rR/cpG0akfJ89zRD5wDbUvzpr60NiiqN+qaRQv8PZGWTEFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756225; c=relaxed/simple;
	bh=qOsW7T559V4XhaeTYvWyJ3OKiGkGhLKIeTw6gX/ZkfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qIeAgDkP2VI5w+LURPRInaDi50cbXtaFSeaRFkn0q23Nkvgcxsq7+at/kuGQTPKo7tzdlIalrDuOeR/9je0NdYhrvptMSnuAi2I+H5TaRV8TNTmQkfAi9++NqhlOSvxytxPBLC8p0tKKg8pdEZJQBxQvT/SaAzT1cupxup1j/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABHNqo6MohoTWXUBw--.64118S2;
	Tue, 29 Jul 2025 10:30:18 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] clk: clk-axi-clkgen: remove unneeded semicolon
Date: Tue, 29 Jul 2025 10:27:35 +0800
Message-Id: <20250729022735.1437560-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABHNqo6MohoTWXUBw--.64118S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw4DArWDWrW3Jrb_yoW3Crg_u3
	W8uwnxXrn0yFy0vF15J3Z2v34Yyr98Zr48u3WSqw45Ca4UCFs0qa9rWwnrJw1UZFW5KFWD
	W3Z3Wr1rCr17WjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x0JUrl1kUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/clk/clk-axi-clkgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index aec62301fa06..fa5ccef73e60 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -540,7 +540,7 @@ static int axi_clkgen_setup_limits(struct axi_clkgen *axi_clkgen,
 	default:
 		return dev_err_probe(dev, -ENODEV, "Unknown speed grade %d\n",
 				     speed_grade);
-	};
+	}
 
 	/* Overwrite vco limits for ultrascale+ */
 	if (tech == ADI_AXI_FPGA_TECH_ULTRASCALE_PLUS) {
-- 
2.25.1


