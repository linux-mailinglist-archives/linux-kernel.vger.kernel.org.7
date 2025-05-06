Return-Path: <linux-kernel+bounces-633060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC62AAA107
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 00:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23143B04E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 22:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2675B27D78D;
	Mon,  5 May 2025 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1OJrEj1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B14298CA5;
	Mon,  5 May 2025 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483547; cv=none; b=CBx12qrrhdM3CqrnMXG7ZIpnw5NZ17AAVBx+HizmKFTXaezT4VE7liyrJ5Lm52fzFRL3R2HzXJa+otWK+Gzo+9U3menUt/ChITu7vO7t3TIatpDFarhk8qnAa+aN5HhGXTxTuUsgTTSpyGIRbwt7sXAjaDifb6kC3e3m55JTCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483547; c=relaxed/simple;
	bh=SVbdHkmnEMzlpLXw6AXLevVh4v92tupfg6nDjZAGnNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUTgS38Ktlb0oTZyj1QLBjvQmEG1n8MGXgS2FQrwioDzY/tx5nz/G8NPMMEo1hm+KdLbukdqp/l3fU5L+fnxdnLvc9QJEazLsCT8WvsF2KWEkbJ8/X4CCREz7Zo96gwqz9BSi8l0NAknHjMwv3ceA9f5mXchWfr9oAItZAhRmxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1OJrEj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFCCC4CEF1;
	Mon,  5 May 2025 22:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483546;
	bh=SVbdHkmnEMzlpLXw6AXLevVh4v92tupfg6nDjZAGnNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r1OJrEj1rAilIPi/iDqiSxU/HwozY+CHD/LRS/sy1rQBfo1JLTIY7hwwikblUurnI
	 wm1GRYcxn+L78qX5TKgAUxUTm7XJ9bznbIbG0p9esKBbzTzcG4Kiw8u5xJ44898A3I
	 cyN9Q+TIo5Mpyjo53BHRcHXG/4m8De7swLgC2EDZLZ+clSR9z4rbOFf5ryNr9o+Asp
	 V10NPffIg0I7dkeMimheRANPHrLJ+eA4IRtWWBXiT2T/PAqqLGA0RhvwmxrrXocDbl
	 +uTE8tABw+jFutIDBc43Ft7F4FKQ8Jiux4zZJTy2Wi+vD5Quhj0ksoZaj1mLX0LvPd
	 agsdssnweneAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stanley Chu <yschu@nuvoton.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	miquel.raynal@bootlin.com,
	linux-i3c@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 108/642] i3c: master: svc: Fix missing STOP for master request
Date: Mon,  5 May 2025 18:05:24 -0400
Message-Id: <20250505221419.2672473-108-sashal@kernel.org>
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

From: Stanley Chu <yschu@nuvoton.com>

[ Upstream commit 0430bf9bc1ac068c8b8c540eb93e5751872efc51 ]

The controller driver nacked the master request but didn't emit a
STOP to end the transaction. The driver shall refuse the unsupported
requests and return the controller state to IDLE by emitting a STOP.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250318053606.3087121-4-yschu@nuvoton.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 0fc03bb5d0a6e..a18fe62962b0c 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -551,6 +551,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 			queue_work(master->base.wq, &master->hj_work);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
+		svc_i3c_master_emit_stop(master);
 	default:
 		break;
 	}
-- 
2.39.5


