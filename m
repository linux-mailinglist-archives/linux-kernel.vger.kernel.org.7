Return-Path: <linux-kernel+bounces-725165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A12AFFB83
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAE2586B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F1B2874F8;
	Thu, 10 Jul 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMw4x54B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168FB221F31
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134436; cv=none; b=U1WO2Y0U9EwIo+VRKOGyVtf5D0WSDfDOyPbQ/BAWJKATYOItG68ULOSIRvAntCP0rGFjadxpZuGy5qLFuLIxArCYBPD5ScU/jO+QKIwd+sWTd/o/Neb8WvExGS8oPM5HaCXmSvYWWk+Unpy7OXiaJJYCn94pHAt6z8rMR72lqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134436; c=relaxed/simple;
	bh=RztAeMqrnYhzdIwlYo1YkeTFsF+36QA2jM59BRKwf1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jbWfn8ZZum0qmqFgYON1v4bWRi4sLMEOJbrDDUN9THkwoqtbOn6jt3bhVfAyZi/zYbICjXxNKC0b/cNCrW+etN7IeGcswyC9BNDY8DPxilu1zvBDL++HFj7Y8/nFKUBmVjzPcMt+wa6It7GFOG0CUAKT/+GZBtEHBmlcA8L7cAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMw4x54B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2932CC4CEE3;
	Thu, 10 Jul 2025 08:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134435;
	bh=RztAeMqrnYhzdIwlYo1YkeTFsF+36QA2jM59BRKwf1g=;
	h=From:To:Cc:Subject:Date:From;
	b=aMw4x54BezLBLZ1ASoRFDDQB6mWAUPvEGRe3FB577j6IT0t9yokHBMuY1laCBreIg
	 AoTdnyHGSxkhqrgIBMnRXnumGAo76TbRHmyAIPPmXwNgG1ocfC8Em+vW7zbjVtx771
	 fvRq7jKO2/OTJUwoMQBZZyGfd47g/7cnCH0JMR0M12z9zv7OHQ9i1mrJ36LGPyTIoZ
	 fkCB1iS/ubba8CoelFfeYlk8rH1kbqHhxu9W+bsCsf9Jxo5mmo65hTVwhdEWV10UNK
	 mRoXw5o9LHro+YsLpjSxOHZPh7Vt8gMi1L9Y6KMTAZ4yAJhW+16qjeRAQysano5O96
	 6KfDo8G5JdE/Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: irq-msi-lib: fix build with PCI disabled
Date: Thu, 10 Jul 2025 10:00:12 +0200
Message-Id: <20250710080021.2303640-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The armada-370-xp irqchip fails in some randconfig builds because
of a missing declaration:

In file included from drivers/irqchip/irq-armada-370-xp.c:23:
include/linux/irqchip/irq-msi-lib.h:25:39: error: 'struct msi_domain_info' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]

Add a forward declaration for the msi_domain_info structure.

Fixes: e51b27438a10 ("irqchip: Make irq-msi-lib.h globally available")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/irqchip/irq-msi-lib.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqchip/irq-msi-lib.h b/include/linux/irqchip/irq-msi-lib.h
index dd8d1d138544..224ac28e88d7 100644
--- a/include/linux/irqchip/irq-msi-lib.h
+++ b/include/linux/irqchip/irq-msi-lib.h
@@ -17,6 +17,7 @@
 
 #define MATCH_PLATFORM_MSI	BIT(DOMAIN_BUS_PLATFORM_MSI)
 
+struct msi_domain_info;
 int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 			      enum irq_domain_bus_token bus_token);
 
-- 
2.39.5


