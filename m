Return-Path: <linux-kernel+bounces-633328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C036AAAA552
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 01:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F93118897F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 23:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444AA30E6A6;
	Mon,  5 May 2025 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGCSdMrf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55A30E696;
	Mon,  5 May 2025 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484150; cv=none; b=beGr+tfFXnRCybDGDAigM/rzqrDBL06+y3c1HbC8BVHv60WalCJc/E2jHrRJJgTNJ3D/svtglT15xznh1djX3Y2lJHCsnr68v+7YG5UunPb8pKj//ahniEv2GIaf+omCx9mxpJ7RwOT/hnos88uN84UzENgDMrQN3PRm2StZmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484150; c=relaxed/simple;
	bh=Qc6sRplHBpINBzNC6KWWgZA7v4kgorJW99xRFGHuJ8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KsQ4jCCZOndlw4Vnpw67tM+tzuGprg6kql+4Hm8TZkYukL5jdb//J3j0E+sP5vJjCIZ1BnxLOVcenEeceI879Ke/S4tRq3eKbvrPEkWJZ0e1iDo6sELQ8l5pP3rcFAeaBLySKLdQoY1+efTwJiZmdjUIDZTIjhf36l05UqzL4RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGCSdMrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83508C4CEEF;
	Mon,  5 May 2025 22:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484150;
	bh=Qc6sRplHBpINBzNC6KWWgZA7v4kgorJW99xRFGHuJ8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGCSdMrfWcm2KZOf1gNj6FXjfigvCfmR38jiCEKvrlm79hrrLnJCmX5ctbV12nLCd
	 AF16ZgTxVGDER6XGHM+uHk0J3NmaFEqnsfuqyF720wDGujqyVwcJz+SikPyIBkZEfm
	 EpC+BLAYx8Rh9fr1N26QILyTUJ3aRkcW7+SE3WK6nJUPnmRwiMGSZ4PCGWUxkzvaKJ
	 KmrIJwTIP8N/FM2RC4GkSzCc+xxipmQOVcTrqthgZyX5v32l94+A0MFaZat3L6pKAF
	 aPjcGe4zkS/kiuWeTaXqTQ1nbrn26madsBSVpgpivFswLfdv9mTQuSdsJYlJLMhoEe
	 qhZvuQ+1/Rw6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-i3c@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 376/642] i3c: master: svc: Flush FIFO before sending Dynamic Address Assignment(DAA)
Date: Mon,  5 May 2025 18:09:52 -0400
Message-Id: <20250505221419.2672473-376-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit a892ee4cf22a50e1d6988d0464a9a421f3e5db2f ]

Ensure the FIFO is empty before issuing the DAA command to prevent
incorrect command data from being sent. Align with other data transfers,
such as svc_i3c_master_start_xfer_locked(), which flushes the FIFO before
sending a command.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20250129162250.3629189-1-Frank.Li@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/svc-i3c-master.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index a18fe62962b0c..2cf2c567f8931 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -899,6 +899,8 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 	u32 reg;
 	int ret, i;
 
+	svc_i3c_master_flush_fifo(master);
+
 	while (true) {
 		/* clean SVC_I3C_MINT_IBIWON w1c bits */
 		writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
-- 
2.39.5


