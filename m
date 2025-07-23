Return-Path: <linux-kernel+bounces-741916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4BDB0EA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF103BFA33
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F87826B942;
	Wed, 23 Jul 2025 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHTxszWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A7225BEF2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753252061; cv=none; b=BMSrQV22cczPc/yjpG+DvxhhDblDZHpdZ+EM5bW/ru+8tX8KZiw5Utnc/gxpTcR+xUY55+36Hy27EHE+LNSCsr6iTbxG/kBpivjm/AwUNuODtnun+pdWGve8NB22h+WqEjRfgH/DaCNSxU2mha+F/6jEHAAlfwSXR4q6zUs6QU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753252061; c=relaxed/simple;
	bh=y59ijpVlyUu91O/9y3LLuf9U8G20b+NWq4NL4oCIB/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=liygBGued3qQvRQAsfiYMN3ecgf5JM+ui5ORo/eI0nJ4Z8lCCsgieEGuI7w4kfiP6Rc4Kbh0Wv49CLFe2ZO3/LxWl8BBE+c3fzXIyYds0TjTzq9PHYHKFzlLth8VfG7c1wo1XMbAcmwyLsXepbRWUJfrRjfEkgFvRvJ5RFOBlVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHTxszWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACB4C4CEE7;
	Wed, 23 Jul 2025 06:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753252060;
	bh=y59ijpVlyUu91O/9y3LLuf9U8G20b+NWq4NL4oCIB/U=;
	h=From:To:Cc:Subject:Date:From;
	b=mHTxszWX7ngfXlQ18eFEInffYgWl22ta7psvY8iKzPopS8eV7p4d19kvpksmKKRWs
	 +6Km9xMjAh/Ajhm9YwxqBUUuroJjMX+piq09CC3HrzJ2GUCQ5nFa6sSESYzqL0tlCo
	 9DItOY2nBu4GSywdmEJjbsozLygifs3hD911zS5WtNmJOYWl4BytEJ15yfiILotuKW
	 riGCYSxZ9je1unTs7Pd9lRyD+uKOtbzFQ5BJzckqGOEIh9A0ujPR1BRf3DMqMpxtaS
	 Ke+hEtyTDpBpFL+CUO/8j2My/OzT/mF64BEDDfM+FZn0GUx48Vjg/ju/wZvXqnI3zI
	 HpQk37fRMsq2A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: p.zabel@pengutronix.de
Cc: linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH -resend] gpu: ipu-v3: Use dev_fwnode()
Date: Wed, 23 Jul 2025 08:27:37 +0200
Message-ID: <20250723062737.1831015-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_create_simple() takes fwnode as the first argument. It can be
extracted from the struct device using dev_fwnode() helper instead of
using of_node with of_fwnode_handle().

So use the dev_fwnode() helper.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Link: https://lore.kernel.org/all/4bc0e1ca-a523-424a-8759-59e353317fba@kernel.org/
---
 drivers/gpu/ipu-v3/ipu-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 333f36e0a715..521d7ec10d85 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1169,7 +1169,7 @@ static int ipu_irq_init(struct ipu_soc *ipu)
 	};
 	int ret, i;
 
-	ipu->domain = irq_domain_create_linear(of_fwnode_handle(ipu->dev->of_node), IPU_NUM_IRQS,
+	ipu->domain = irq_domain_create_linear(dev_fwnode(ipu->dev), IPU_NUM_IRQS,
 					       &irq_generic_chip_ops, ipu);
 	if (!ipu->domain) {
 		dev_err(ipu->dev, "failed to add irq domain\n");
-- 
2.50.1


