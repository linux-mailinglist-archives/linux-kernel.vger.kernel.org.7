Return-Path: <linux-kernel+bounces-750875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68567B1621B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD93B3D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F02D837C;
	Wed, 30 Jul 2025 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3TOXbtV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE527A93D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883979; cv=none; b=ZoHOpNLiOByaz3d+ucWkNkbp7EmEQFcSSGZ8YgYbDJwhewLkDK95lwFUYO7wXPec2PBgmnyiVMOe4MIko9CCUnaCBdy3HdC46+ZZ+mDP02eqF3ajnRUklOVGkb944DT/fay9/w3vfJCTAUKn+dlDwAkdJkZbMUrOxv2HWuFAPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883979; c=relaxed/simple;
	bh=N3+NIbm5eiDev1M+UzrXcz/aTODki3H4qf2X/mq2JzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WmnFmvtQR3tzYO1yaqGP8H5q+3oFpBFDmyi4D2n16K1pEfBEMw2QGMi+KXghYKsZGtUQtmo1SRNlNZHFf9vHpZXQICUT3CRl8ZulMWntLmjojrZLQMIGdPMx95q1w4B1HuiRdfP0DDl22CDVKbW5iXYVluXDFN5NeOacaB25dMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3TOXbtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17DAC4CEE3;
	Wed, 30 Jul 2025 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753883978;
	bh=N3+NIbm5eiDev1M+UzrXcz/aTODki3H4qf2X/mq2JzU=;
	h=From:To:Cc:Subject:Date:From;
	b=U3TOXbtVl6wxmpHXPj4zmgqZHrEbB0UeMs5FY0LVR3iDlJ1NVNNeXxlOwovBrnyD4
	 GW/yRVZFNUxtmw+0pm9H491HTmFyEsLfbV23THcTNPhIfjU7yioP3qnhNLDnQW5JW3
	 Gkq0ilv9VAlJ/ZQas0MoQjjgyoTZonO7vK5r/HMqHgrnSNOPInheXuU694Jg9FPtfv
	 pIfYCRwZsyGmPYW+w6+G789nzBgXd/7JDBbHkC134sD5xmzPrrGA4YjXVFB67LHhlh
	 YNRtwNrisSprnh/av5slh8r0QSzEmuPaImkWjzPFZD7zp/3UvkLWYg8Swjb97icOS8
	 yeBpUlVf64JUQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: map: add back asm/barrier.h inclusion
Date: Wed, 30 Jul 2025 15:59:24 +0200
Message-Id: <20250730135934.1712198-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The mb() macro is used in this header:

In file included from include/linux/mtd/qinfo.h:5,
                 from include/linux/mtd/pfow.h:8,
                 from drivers/mtd/lpddr/lpddr_cmds.c:14:
include/linux/mtd/map.h: In function 'inline_map_write':
include/linux/mtd/map.h:428:9: error: implicit declaration of function 'mb' [-Wimplicit-function-declaration]

Fixes: 56eb7c13b97c ("mtd: map: Don't use "proxy" headers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/mtd/map.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
index 288ef765a44e..75b0b2abc880 100644
--- a/include/linux/mtd/map.h
+++ b/include/linux/mtd/map.h
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
+#include <asm/barrier.h>
 
 struct device_node;
 struct module;
-- 
2.39.5


