Return-Path: <linux-kernel+bounces-738824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829E5B0BDB3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86E33AAB7D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18329283129;
	Mon, 21 Jul 2025 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="loSPmJ6x"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBDE280309
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083204; cv=none; b=cRPjPqmAFlvPZIp5en4IDOYvq2Xsp2hxlzNd2rhr1wcFlvIjKYXvA1CCuaNOKWFCVs5qS2nJ57tqjMEYOPYUF9n+WCVtzeXGOhAE0Af/ECy2O3yqANZCz5C4kLO9JgdGH6T6A/jLS+0BrqZ4zxlM9JEZZORKU5X7IkaAwX0BvOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083204; c=relaxed/simple;
	bh=jcDzaNsD8gRoGIRTVUtrz/4xnrAu2MmuOyjsJhzJbRo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=hocZu3C9lg+A8ae1blosyjf6S2XM9sPvnLosfZNVRm6QQO66D6Z7yISAc0bSulhivMYmHgo4Jx524foZlv/R6MChZBP1Iv4E+v0R3FCnFRFEXGuOPtOetchplawx4z4Ptlx4jzOfzabHTEEGojJJCE22XryQAbRb/1E8O/+Kdrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=loSPmJ6x; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753082893; bh=CECHK3/TvaUBS7vTQd/dCnJSOpEhSRdWvqHUX5n6xGY=;
	h=From:To:Cc:Subject:Date;
	b=loSPmJ6x4sz2SwT7cy8dsVeb7aSFcnsSL+uthc3IYZjzShCFMZa3Asa1s3A+08D6L
	 fm+66UvbqJskDUGs1bUwWCJVWbCkbU/aNK0DDGHsatFDPFwZlt8/sopq0HaORbIvKI
	 6FzlNruN+3z369dWPPvuJT5Z0/bg2SAdEbarpg4Q=
Received: from VM-222-126-tencentos.localdomain ([14.22.11.163])
	by newxmesmtplogicsvrsza28-0.qq.com (NewEsmtp) with SMTP
	id 70BBB67D; Mon, 21 Jul 2025 15:28:11 +0800
X-QQ-mid: xmsmtpt1753082891t74zqof58
Message-ID: <tencent_72EDAD7F6E52D8FB5933030A569A08AEC406@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5iY/9mp9LBQpbgJ/fQvfNWOtdXd/FI0PPSmsjDSeD70i+7z2hkb
	 VA81p3Zxlv1UELLkFOp77t2D3WzzAOUXgPiZxMAyEcaLWS0htXury4GJLJvEB/fPTTGlzd3ZT2rJ
	 WH2z1IwSWDiYEhO7WNJN/7xDNaPq8M19nGLiqxu2Bd8S3nCfMccWj++8Y/IC1vtAqijmXgLK0fUx
	 VYJatAySdNzUXV7ntYl7HbodyIvVFUl2w1Kz9AGlU6FFlEOdcQ71pXcxGP7CctBQ1wPvDRnHbPGp
	 vmxAnaGQebSgRXnv4DKlk7I+Qav0FYQwmUuL/GiyiJeCvVipqSf9hSjs5zpOkREfsLuCnjsm1fAV
	 4yOWaJIlo2VGgbAfxw7/ZloZrXmoeVBf/BezHOmXqZGR7E2YYwvidyVE6LL9SD5imYJUgEd9xwRm
	 6+Oko26TplZCNdpI2a+Op1xSWiVJcoYu4zTHmT9kTmzIF2yYia6quUJ0fUpjgZ7oVxITgGdyREhk
	 iVk/vbmbASdrbD8V3SjVvHmI/z0RH5YOfJjlFzJrTob05JMQzqpq7vglMEWwDKCF5acsrBjo2RBP
	 eyy2vqaSO4wSR1S29TcizutHzcdXFQPhzgWCXPURon/ZnFozRhygoorMUmRdqh4MUHvYP2GQ6qYA
	 X8UrZoLiIG10ycQrem5rLf8q1D5VRqUeSf4qAlTcZWt/c3eh7stfisUEQ1v/TNLLkLqs8eXueUYw
	 g/2Jre5OKTqrjFGPiDdcGRgJM89ZBEj6/Vxdk1UK5qLeJsVDc12e5qmVzqgaCY9bUDiUeEbO2dZM
	 e2y0wpaqp2PxfghQbn1lWmiiGnqniIQgbGovYa4tkeBrkT9BETJkJMbvlmViWlUx/F+uYaK+6Oen
	 yERmWPmJ2h29160aJNxPJ9YjXQwEDdPG02g4tYQpb7Jeq1TyoTJ7RnJ45gzjEEb73TleFM2uQ560
	 rb8r+UhRfexWudE7MgWe7vft8UoBp2jtG+80ClJ5CiF1jcO3UYmkiWqxpcUN2MK1TJbF/su2EIOq
	 Y0fL7wfCdKt/vfGVpTEDC3L/WXspq/2k1jGFt0HRB3raKDzuvszGe2cDk2Yjo=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: jackysliu <1972843537@qq.com>
To: maz@kernel.org
Cc: tglx@linutronix.de,
	herve.codina@bootlin.com,
	antonio.borneo@foss.st.com,
	anup@brainfault.org,
	jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jackysliu <1972843537@qq.com>
Subject: [PATCH] irqchip/gic-v3: fix resource leak in partition_domain_translate()
Date: Mon, 21 Jul 2025 15:28:04 +0800
X-OQ-MSGID: <20250721072804.343055-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a device node reference leak in partition_domain_translate().
After the function obtains the device node np via of_find_node_by_phandle,
it does not call of_node_put(np) to release the node reference
in both the error path and the normal return path.
This causes the node reference count to increase each time
the function is called, causing a resource leak.

This issue was detected by rule based static tools
developed by Tencent.

Fixes: 87228532e7e9 ("irqchip: Switch to of_fwnode_handle()")

Signed-off-by: jackysliu <1972843537@qq.com>
---
 drivers/irqchip/irq-gic-v3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index efc791c43d44..61c1d404b726 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1821,12 +1821,16 @@ static int partition_domain_translate(struct irq_domain *d,
 		return -EINVAL;
 
 	ret = gic_irq_domain_translate(d, fwspec, &ppi_intid, type);
-	if (WARN_ON_ONCE(ret))
+	if (WARN_ON_ONCE(ret)) {
+		of_node_put(np);
 		return 0;
+	}
 
 	ppi_idx = __gic_get_ppi_index(ppi_intid);
 	ret = partition_translate_id(gic_data.ppi_descs[ppi_idx],
 				     of_fwnode_handle(np));
+	of_node_put(np);
+
 	if (ret < 0)
 		return ret;
 
-- 
2.43.5


