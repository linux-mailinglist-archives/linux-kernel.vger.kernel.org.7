Return-Path: <linux-kernel+bounces-616725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9767AA99522
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 18:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD67B463A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4336B2820AE;
	Wed, 23 Apr 2025 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU/7KPp4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2469281529
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425802; cv=none; b=cTjys8Mzny+CJnx7lG3D9SE+sZb/Iorm3PN8riU041qlJbr5bUFjmbBX2vPvXvwuEvQN2ZqeyPsqKPY1RtKHgGWWe3aWY7fHbo53LNFy3GLoNR2rPaPVtLgl+3Kds7BzgxpFFJI4yRrx58U+n/nBTzIIEEMe36VABDyDUOzUqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425802; c=relaxed/simple;
	bh=N0YsuSsw6LR3Wlo+UHK1R+dAY9Z0n1sTB1iAGMETzA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MMiKUyFbI0MtY4F1NvQlN9RT/+gA4iQgDWflNX9DeqscAWlmWWnETbxgObN2GLhFI/Uf/ZAHeStIsLcZFemZcIcgd+QaNntDpE0Yic1MncaZRL3UJLmke+ODuNhWnYgOUM5oSNRKXqo1A4P0mOfI1cY9xwyTgfQ5yWTlyqnSUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU/7KPp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F861C4CEE2;
	Wed, 23 Apr 2025 16:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745425802;
	bh=N0YsuSsw6LR3Wlo+UHK1R+dAY9Z0n1sTB1iAGMETzA8=;
	h=From:To:Cc:Subject:Date:From;
	b=RU/7KPp4/suA/UnOfYAmeq4B9hf8W31UfZR5LRkYWcxfLFZYBDMKjvgXLGyReWrX8
	 cS2SyM3sVpgpl6SGTACLiUHe627IB58+zUmIQm2SrtID4W4+frlAS5ouaQwYz+ktdF
	 0u04e7SzXOt6kRrvWwOJQrmzJ/51E5u553kRkWOgcgCDBfWsub/zNq44crTNxZEN6U
	 S6pUqfqOKKlTWe5EeQf6cegnxJMg3ajfGPjLmGuve0FZbJ4XNNiUol+ZBlaeecm7zU
	 Bgip2TS4nNfEwva/VftKSzlzirD5f8Y6BgTBrrVdeM0F42a55oy5/2KfecU22d5DOo
	 j7zCE+QlnwIDQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Georgi Djakov <djakov@kerenl.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] soc: mediatek: mtk-dvfsrc: remove an unused variable
Date: Wed, 23 Apr 2025 18:29:52 +0200
Message-Id: <20250423162958.2223689-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This structure was left unused by a previous patch:

drivers/soc/mediatek/mtk-dvfsrc.c:542:43: error: unused variable 'dvfsrc_bw_constr_mt8195' [-Werror,-Wunused-const-variable]

Fixes: b06785283ec1 ("soc: mediatek: mtk-dvfsrc: Rename and move bw constraints data")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/mediatek/mtk-dvfsrc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
index 7b8486ce1c66..41add5636b03 100644
--- a/drivers/soc/mediatek/mtk-dvfsrc.c
+++ b/drivers/soc/mediatek/mtk-dvfsrc.c
@@ -539,12 +539,6 @@ static const struct dvfsrc_opp_desc dvfsrc_opp_mt8195_desc[] = {
 	}
 };
 
-static const struct dvfsrc_bw_constraints dvfsrc_bw_constr_mt8195 = {
-	.max_dram_nom_bw = 255,
-	.max_dram_peak_bw = 255,
-	.max_dram_hrt_bw = 1023,
-};
-
 static const struct dvfsrc_soc_data mt8195_data = {
 	.opps_desc = dvfsrc_opp_mt8195_desc,
 	.regs = dvfsrc_mt8195_regs,
-- 
2.39.5


