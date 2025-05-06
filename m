Return-Path: <linux-kernel+bounces-634781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F762AAB754
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 08:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE151C23A64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 06:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757B54784CD;
	Tue,  6 May 2025 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqwIN+TR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8EE2EFB8C;
	Mon,  5 May 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486661; cv=none; b=YyPNOOLEatY40K29vQ97n3U33DnHwC4MCxdRqDxsSPTenb6vkt/z07ZR+3258ge/Zzw1iYnGgxhgvJxiTlBxBow+1tQAFrZgoiMPzPlHtOVZGPKfG//OFyKxlG3v1mQG1dRS/C7JGXcin7xTPrbNKiiN3E7jh+qzWujVUtrrROY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486661; c=relaxed/simple;
	bh=PvcQv3IFn7mpaCHcHeFH1JuyezztlM9bYk+8URrRkEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X6KaindAAABBK6RJ7IEofcJjEA6e0GQjHbSBCpnqLgPR0EqxNUd9C7l3fCs66l/o07wO0A4XVF4zTaPNixCugfrxd7VIXSeHcbWXOEjbiSOPuSUorOIfDcAXxumBHmaQQ97ejytbvzkj4GIn0HwjncdJbkhHk2ZdwKCocBC4rhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqwIN+TR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81625C4CEEE;
	Mon,  5 May 2025 23:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486661;
	bh=PvcQv3IFn7mpaCHcHeFH1JuyezztlM9bYk+8URrRkEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqwIN+TRyOMDv8faX9F1GG8A7l5feOpiz3PSm4Am5iS2n9f4gHA2VIfd/6b6S1yEW
	 hMyAURLaoq0fwreoeVjlXE11RbMF1g20wEbj0SVsUUrrFcX3GdzO8quDbhFtHvkn+N
	 pfnzR0bSgkLEAyB8Hp5Kb7yd1zsPkIJ/xv+F6jhVGFT0p52hDOY6Klet4C+qQQEP3u
	 YiVJn6BJjS8lUS6dAf7ktJ1eKmP0NSOCCisnAx2o/KUiPPNXiD16TmD5zq2iGjtavp
	 bCuCHmjzIpS8GQp1VrQc45g11Lk8ob0GBkFenJefsMDuaqk74ixXwiMYguxya3xye+
	 6XVrBMdGhA1UA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-i3c@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 143/212] i3c: master: svc: Flush FIFO before sending Dynamic Address Assignment(DAA)
Date: Mon,  5 May 2025 19:05:15 -0400
Message-Id: <20250505230624.2692522-143-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index cf0550c6e95f0..8cf3aa800d89d 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -833,6 +833,8 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 	u32 reg;
 	int ret, i;
 
+	svc_i3c_master_flush_fifo(master);
+
 	while (true) {
 		/* Enter/proceed with DAA */
 		writel(SVC_I3C_MCTRL_REQUEST_PROC_DAA |
-- 
2.39.5


