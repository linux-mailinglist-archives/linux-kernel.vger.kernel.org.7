Return-Path: <linux-kernel+bounces-720768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF81AFC035
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF35423B61
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D971F4169;
	Tue,  8 Jul 2025 01:45:12 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F592040BF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751939111; cv=none; b=TXAvrE22qfIF89//ZTmVim37tBMGK9Eew8bVdIEBH63F8Di7KWTesfAW0ECbCPFVIjuwaUhbLU1jsBdNUQB2wqVtav+xEiqQ1vZoud1Eo1v4A2l6pTO+Byxi1rwZOBBjNYerG+CW/0/OroIoJVPFuWRp0cFcYOaJCod6x0MqR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751939111; c=relaxed/simple;
	bh=DND5Hg+FtbnxrbifP2m8JGMpr6rBRSxqH5N/7bwtAy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DErSlb5+tXtxU3BcGLXnNT4Bp1LDldiS79kJaVrw7Rdi/OX8R0z4Te6EHTVaaVcpEl98VDTdFGMjWbHK4uTLcHDSf4iw2s0kmjzxJwZihom2xl1u+Shwu1LqZUuzqfiWtIIYUudPsema0+xMgdmdbnuvk9J14d2lw2NuhYUWu14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 35948340D1B;
	Tue, 08 Jul 2025 01:45:05 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 08 Jul 2025 09:44:56 +0800
Subject: [PATCH] riscv: defconfig: spacemit: enable sdhci driver for K1 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-02-k1-sdhci-defconfig-v1-1-73c631717338@gentoo.org>
X-B4-Tracking: v=1; b=H4sIABd4bGgC/x3MTQqAIBBA4avIrBsYpejnKtFCdKwh0FCIQLp70
 vJbvFehcBYusKgKmW8pkmKD7hS4w8adUXwzGDIDjTQhGTw1Fn84Qc/BpRhkR6Z5dtqbIdgeWnt
 lDvL833V73w9zJmOmZwAAAA==
X-Change-ID: 20250708-02-k1-sdhci-defconfig-e099c1d25fa4
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=DND5Hg+FtbnxrbifP2m8JGMpr6rBRSxqH5N/7bwtAy8=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBobHge8G18X+Mhp+CBSQ6ZdE9TrfQtejcKsnbZg
 ewJzJ935l2JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaGx4Hl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277fyLD/9j/olE0QLiTGKumY
 noTFZYOFJbQi+xwectDOv+C1hN/+Ah+xXeFL+daxQyDZ5ZI+6UF35dIWnQwZ4ROy6rBy4ga73nS
 cmpOHDlWtOmzAqdxfsMPPbWCxn4s094y4GO420pU9wEDEaUNVG8qdV5/DXrFu+qd0l9gNPgIGZL
 DxjgQ9pCXKeK9gMHejSXUIeTW1zdTT1WWKW7hRLVIAcWPcgBWfnA1ry750wxlrktcmK5Yfxpdpc
 k35aRKh4XW81f7sKgN9B9iaip7Qdd8mzTX/csJdjZeEnozy5yuTYs/7XyjZKs3nl/lrRHrnfU0b
 eiYIOPfsgP4nUtLXmE68r2kNli9ne/MaEJ12XOMTvPJ/W/udzS0V2O4bpK51wgJaK1K2fp1C1gN
 S8xbGFgJ2N/litO867ikP4ZW90qxRbUlaEEehQmhE+hheTdN9zxLJp7zoj5SMncJ7daTTW050mJ
 JOKeFFSqJLmbCKGe8mVr9tbBUXIzgkR7V8q+P5KUf387VSGAnpH800VprdwcUGn9gw3qJCA0kW0
 TjLU+gjaKwM4HgTSc+mQgfpWqsKVfsOpbT//J4tdtVlsE5FV3MSIgpn3eWgmT3nm9/lxr+euHoX
 Bu/MzhojeqUrvkhfisQd5oyLieG8ZfPGwx5hR6slr8MhTjQiM40ZCB++invQH3VJ6D4Q==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Enable sdhci driver support for SpacemiT K1 SoC, so eMMC storage
will be probed and activated, Tested on the Banana Pi BPI-F3 board.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
Since the K1 sdhci driver is already merged, and the DT part is 
queued for v6.17, so let's enable defconfig of this driver.

For the convenience, this patch is based on the branch 'for-next'
of riscv tree[1], and generated by command "make savedefconfig".

Link: https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git [1]
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 37c98c0f98ffc0ee9d021e4d07aa37a27d342f7a..d8e1593ceeca487c6af67c73cb176c488f38bf13 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -230,6 +230,7 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_DWCMSHC=y
+CONFIG_MMC_SDHCI_OF_K1=y
 CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_DW=y

---
base-commit: fda589c286040d9ba2d72a0eaf0a13945fc48026
change-id: 20250708-02-k1-sdhci-defconfig-e099c1d25fa4

Best regards,
-- 
Yixun Lan


