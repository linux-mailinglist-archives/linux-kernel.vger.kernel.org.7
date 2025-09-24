Return-Path: <linux-kernel+bounces-831203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A0EB9BD64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62BE57A121C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAFB328592;
	Wed, 24 Sep 2025 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtvjJ1lh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C37327A1A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745122; cv=none; b=rAdQXJh93qOkw480CoIUcJ6xVPnq3q/5Z7UmWXVIrloRsI8zvBIah7JRq06lfDlINJYBxeMd4IEJMlipzRwVWqfGG55ZlnhRm65+g0p8TAf6qS3YzKLNfp2rgkPT+3xHRXBlsOTUQ3pC9qBtfqQ8N/iOwAFaTpkhlzRam7eNAJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745122; c=relaxed/simple;
	bh=FVlJZ6+brrbtentTGI5KcPkX7kbX636lXkfIMMbwNLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nvrSOao9iQNh5WXizBg5dpNFZk0nQQkmy1vu0xGe4gphDQqxOSChtcGBBEfz3uNOMUo9+IXackSm4xkmpGAka7zh6TiRgxgk3dlJEgngMQl33QM02xuUnpQxMt4VZ9fU1TBZP1QCCbgJ8S+tuoEk8qv3KzlxMvCzQ7we0Bf42+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtvjJ1lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15483C4CEE7;
	Wed, 24 Sep 2025 20:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758745121;
	bh=FVlJZ6+brrbtentTGI5KcPkX7kbX636lXkfIMMbwNLA=;
	h=From:To:Cc:Subject:Date:From;
	b=QtvjJ1lhF7NPqosw6SjTaINVd8X4ZZKsK4P17e/a4LdtseYZTvVFXYhs7FRhIzTq8
	 zvPsyhKlRj89oQB9IzTJHvpxAKGKmB4zyT4868ywcB+j7oDenHSAJGk7L5CDNT2e37
	 ilZhZ1DLwYDZXaFjAdNr6k8JFsDjuBt2pxE8ymekX4H45koFhnJ6ULYbn8v+lFRVSr
	 BjgFi7tqzThkST4KQjNDPK7S2WOfrlLhsTcXM8tlE7z4HPw/uo1i5t3EIP9TyTMkW/
	 X9koHX6Q7tm/C8GFJDInkn08dNZmp8iZVrn0FcJWlwfIoHw3pKfz+tUdHNAXP5C1Ig
	 Ha4NIIz4UWwaw==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] i3c: fix big-endian FIFO transfers
Date: Wed, 24 Sep 2025 22:18:33 +0200
Message-Id: <20250924201837.3691486-1-arnd@kernel.org>
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
MMIO registers. As data is copied between a FIFO and a memory buffer,
the writesl()/readsl() loops are typically based on __raw_readl()/
__raw_writel(), resulting in the order of bytes in the FIFO to match
the order in the buffer, regardless of the CPU endianess.

The earlier versions in the dw-i3c and i3c-master-cdns had a correct
implementation, but the generic version that was recently added broke it.

Fixes: 733b439375b4 ("i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()")
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This was a recent regression, the version in 6.16 still works,
but 6.17-rc is broken.

v2 changes:
 - add code comments
 - write correct data buffer
---
 drivers/i3c/internals.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 0d857cc68cc5..79ceaa5f5afd 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -38,7 +38,11 @@ static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
 		u32 tmp = 0;
 
 		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
-		writel(tmp, addr);
+		/*
+		 * writesl() instead of writel() to keep FIFO
+		 * byteorder on big-endian targets
+		 */
+		writesl(addr, &tmp, 1);
 	}
 }
 
@@ -55,7 +59,11 @@ static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
 	if (nbytes & 3) {
 		u32 tmp;
 
-		tmp = readl(addr);
+		/*
+		 * readsl() instead of readl() to keep FIFO
+		 * byteorder on big-endian targets
+		 */
+		readsl(addr, &tmp, 1);
 		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
 	}
 }
-- 
2.39.5


