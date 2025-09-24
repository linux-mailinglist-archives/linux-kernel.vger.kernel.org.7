Return-Path: <linux-kernel+bounces-830766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D120B9A72B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C51394E065D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F049830C344;
	Wed, 24 Sep 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqUjFlZ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147730B51F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726190; cv=none; b=KgEKJBll9YoVjqoJIsAD2VPlDpi37nfn21K/iNYvg6A7TLV5Y0/Tg0EfdY2c5aX+M3bZuhqSGs+wm8fxtxjpX3nNMYTTwclHTHc2O8O6UsuhrsXk9P6NkEzCH9+rrRE+tSjTj3O/DZ0JnVJ30RsPM+lL4feuSJlAbprx1oXW7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726190; c=relaxed/simple;
	bh=NHdaRaD3D0V/u38JlJWZFkww+I34dCOx77Sm+WqQ4E4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hw0NO0GLMPOYoVzDpQzTx+5cS1vgAX7KJKaFIFLUl4EnX6CP1MYkhiP90Uw9NiML5g/FJtYbEODkGYU1i8LnhGh2meEKxXUboei9lSYljaym3xrYqHsnzMb2I61TD0KA1Yw237Zxkp1pgz4xiKABzIgYQ57SZlxq5xRBoMmFHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqUjFlZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A9EC4CEE7;
	Wed, 24 Sep 2025 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758726187;
	bh=NHdaRaD3D0V/u38JlJWZFkww+I34dCOx77Sm+WqQ4E4=;
	h=From:To:Cc:Subject:Date:From;
	b=oqUjFlZ9Gv5Em/Ipd0DIbSyJNrIXgyjvqXFpcVeFsMHJP+hAPQGVdXyBnDJEQ2evu
	 jFEXm7AtkfUTpC6bLNBtY770dMIB+mFc2qqH54sJA1ESdf/292x688Ln1PYnCUJOhC
	 LbxRwAngvm4IoYZyYTwkJ8aVUCwW2N30xFYPMG3FR5Zh7x7AkiUh+eal5BeezD+uwT
	 2W51kiodc7aI/PuFTTbC/IxB7cKPU5CfyRTeth398J6pGJVVIXeUfu02sQ8EHsuCzz
	 FgMz0kHeo/LCtn/XQVRI01tbY9J8dAHQsYOsocyYk198KBDgBBk3qYZ3S5sX6BdDgF
	 iOEcIpMLQFRSg==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: fix big-endian FIFO transfers
Date: Wed, 24 Sep 2025 17:02:53 +0200
Message-Id: <20250924150303.3601429-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Short MMIO transfers that are not a multiple of four bytes in size need
a special case for the final bytes, however the existing implementation
is not endian-safe and introduces an incorrect byteswap on big-endian
kernels.

This usually does not cause problems because most systems are
little-endian and most transfers are multiple of four bytes long, but
still needs to be fixed to avoid the extra byteswap.

Change the special case for both i3c_writel_fifo() and i3c_readl_fifo()
to use non-byteswapping writesl() and readsl() with a single element
instead of the byteswapping writel()/readl() that are meant for individual
MMIO registers.

The earlier versions in the dw-i3c and i3c-master-cdns had a correct
implementation, but the generic version that was recently added broke it.

Fixes: 733b439375b4 ("i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()")
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This was a recent regression, the version in 6.16 still works,
but 6.17-rc is broken.
---
 drivers/i3c/internals.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 0d857cc68cc5..0f8a25cb71e7 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -38,7 +38,7 @@ static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
 		u32 tmp = 0;
 
 		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
-		writel(tmp, addr);
+		writesl(addr, &buf, 1);
 	}
 }
 
@@ -55,7 +55,7 @@ static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
 	if (nbytes & 3) {
 		u32 tmp;
 
-		tmp = readl(addr);
+		readsl(addr, &tmp, 1);
 		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
 	}
 }
-- 
2.39.5


