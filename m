Return-Path: <linux-kernel+bounces-774294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D54B2B0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900FB3B14E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DD1274649;
	Mon, 18 Aug 2025 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="BpgbAlog"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD0270577
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543427; cv=none; b=RYaBjrl7LlTNmOY1IWEVS8/7n7WxOyMBKtETE/QOdQtMB1fczhDrb2v099XyG6yfrZnd+a9OuFEESWPoZiI5NG7vdWL9qcku0cdTq1yt9Dgk9RGPsk6jrSKobNJLPS+75Sk2p8WweGzBaMaXJXGRVzOOjH24bFq+xmN7KosbIFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543427; c=relaxed/simple;
	bh=2NdW87PW5GTjsMl1707lWcIZl6TzB6oCVOOruGf5iJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fev7Xhe0TnKYAsRH0+2/73ZB9mRUnLck05+B2Ahnmzgr3yU+7+2hxBfGTGUVaxI4V35FxgTuYrCiEBT0ayLqPSUp8FHVC8gCjBRBSJq57MeIb5qJ9zjqpoiM0NH6di0l96HL+HvjpgOdhvuPw+evPZkDrQuevYrJXlwk4XUZIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=BpgbAlog; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=JNzSJeGA2KVxjQ7TVG5iBiBWJP0Ic6o9XHWVyDGQ9O4=; b=BpgbAlogHLKVjgwCEw/QM0WqT6
	FVgoewGQvCQyGv3QE+E9kNg3AGrJEmVaBCieK17JVP1JFDLl80xi7WryocB/hmIj+hxaHw+UjtEoc
	AcHZjUhWol7ofNpV9z2Jd06w+fbRReyOseVeyKDsr/kS9i+gBNmw2tuBeIDcNjZp0TYhrjMwU53Ti
	mI36yh2vjcsv351JTCiyhEYvg94GaqCX+6/V/nd8VvJnXXDJJp7lVnlJntRNbJ8kkS9q5qZMupsoZ
	U+6KOdRPExCw00aRJxWvxPQyr5s15y5BEjihuYqdyEgFx3Nwxav4gEaT4py0NDzz7xRN8cKI3y4T+
	uJOle4sA==;
Received: from i53875ad4.versanet.de ([83.135.90.212] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uo52T-0000l0-Bf; Mon, 18 Aug 2025 20:57:01 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: tomeu@tomeuvizoso.net
Cc: ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH] accel/rocket: Check the correct DMA irq status to warn about
Date: Mon, 18 Aug 2025 20:56:58 +0200
Message-ID: <20250818185658.2585696-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now, the code checks the DMA_READ_ERROR state 2 times, while
I guess it was supposed to warn about both read and write errors.

Change the 2nd check to look at the write-error flag.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/accel/rocket/rocket_job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 5d4afd692306..3440b862e749 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -422,7 +422,7 @@ static irqreturn_t rocket_job_irq_handler(int irq, void *data)
 	u32 raw_status = rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
 
 	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
-	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
+	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_WRITE_ERROR);
 
 	if (!(raw_status & PC_INTERRUPT_RAW_STATUS_DPU_0 ||
 	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1))
-- 
2.47.2


