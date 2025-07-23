Return-Path: <linux-kernel+bounces-741918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E346B0EAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32F74E5979
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BD326C38C;
	Wed, 23 Jul 2025 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IllGGqIK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C5617BA6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753252127; cv=none; b=gR8Nt83HZ4WknhTxiav9SSOKcA7DsHyJW9wkfCyWMiB7Y2pv+hyBq2U1TfQ8ydqvZ2KCHKK07Y5wiax7nCMQuBGl8Bw5CLWmy7UgpXTCmPSLF55qYA8oPJWlVfOcj0HCpbmhKHchgKl2zrcGotn9zaaNpt0nnpuiaENIWmINtnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753252127; c=relaxed/simple;
	bh=5dVsYbzQysdejWGSuGgk224YzC1unOLyHT1JvVpqD7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAIbZJGtEniB4xBxjsPCEyaaWNjwpH6dolOlRQJ+esoO/LlYu0pa9t5Y+rl525B/rYwnl1kFx3Wrw2N2n0CPQBStsO8D8eAPvP4BozKq/LCf9DbaB3SN+f1juYQgSwOZ1HksYIENTu7K2rYs0+BHlUlSIzQ9XORBlc6bF5PCTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IllGGqIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD443C4CEE7;
	Wed, 23 Jul 2025 06:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753252126;
	bh=5dVsYbzQysdejWGSuGgk224YzC1unOLyHT1JvVpqD7Q=;
	h=From:To:Cc:Subject:Date:From;
	b=IllGGqIKV+Ku6evPtePgfH4uQ/IEF5TY0xEeNfKoxZLzSopgYGdgpoc9POizj2D1t
	 TFP4D0qPM7P0TSDTF/Ji39roPgTw2ryu+NWea7DTP0pvgK1nmouHtNRPXjbOqK0IEx
	 EeIsqNwcwd2iKUUVziKA64A4Yl21Qv5oksKzJLoRqA+AcFKCZcoq/G/Bcpm8WD2f0k
	 x6XxAYYzlwpcAzifIKSp7CReq4mhI6/xY5x5AHbrVWYK8k+Um6ASjN931FJs3mrZMv
	 X3JZbQGxTN7gJOR12rEUqAkQ7qWvF+JqvRsQcviLzcTS8/r7n8bnRfXr0D9geLJh+m
	 fTIHqXFqByElQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -resend] powerpc: Use dev_fwnode()
Date: Wed, 23 Jul 2025 08:28:42 +0200
Message-ID: <20250723062842.1831271-1-jirislaby@kernel.org>
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
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lore.kernel.org/all/4bc0e1ca-a523-424a-8759-59e353317fba@kernel.org/
---
 arch/powerpc/platforms/8xx/cpm1-ic.c | 3 +--
 arch/powerpc/sysdev/fsl_msi.c        | 5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/cpm1-ic.c b/arch/powerpc/platforms/8xx/cpm1-ic.c
index a49d4a9ab3bc..3292071e4da3 100644
--- a/arch/powerpc/platforms/8xx/cpm1-ic.c
+++ b/arch/powerpc/platforms/8xx/cpm1-ic.c
@@ -110,8 +110,7 @@ static int cpm_pic_probe(struct platform_device *pdev)
 
 	out_be32(&data->reg->cpic_cimr, 0);
 
-	data->host = irq_domain_create_linear(of_fwnode_handle(dev->of_node),
-					      64, &cpm_pic_host_ops, data);
+	data->host = irq_domain_create_linear(dev_fwnode(dev), 64, &cpm_pic_host_ops, data);
 	if (!data->host)
 		return -ENODEV;
 
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 4fe8a7b1b288..2a007bfb038d 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -412,9 +412,8 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 	}
 	platform_set_drvdata(dev, msi);
 
-	msi->irqhost = irq_domain_create_linear(of_fwnode_handle(dev->dev.of_node),
-				      NR_MSI_IRQS_MAX, &fsl_msi_host_ops, msi);
-
+	msi->irqhost = irq_domain_create_linear(dev_fwnode(&dev->dev), NR_MSI_IRQS_MAX,
+						&fsl_msi_host_ops, msi);
 	if (msi->irqhost == NULL) {
 		dev_err(&dev->dev, "No memory for MSI irqhost\n");
 		err = -ENOMEM;
-- 
2.50.1


