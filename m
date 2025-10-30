Return-Path: <linux-kernel+bounces-877966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A46C1F717
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85AE42274E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE93351FBC;
	Thu, 30 Oct 2025 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm1ZBE46"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A6351FB1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818758; cv=none; b=bnpxTdFi3d+nrbknJlpNVElOnU8/iFU1zGlJLzGnzyawxUEOh+sJHyA0Ju0QbJ5KLi6c2n4u4RNtyfxq/DttKwqTnW/cGi6Eo4t/R1bm2k5eE/DkRWW00uCtdFEI5hQOBsQTmyuH04lUeABwSNiIvuyWsnIdvTbAWckRNND0lNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818758; c=relaxed/simple;
	bh=v/bwxwMrPgUrZzVMTssoD2ipJp8loXVDoDEfaEXxUas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PjWVB1GMdkce5qTPOfzHUMPoTLMf17b7jyKf4jPFIwpkG/JEPMKhwav5pn6A4Nuo324lOSAn4baygYK7Pic63bAA1SwZTR36jfflj8evBQ3HY1l8NPCfSkGFV4FD2++z4omJ76mguT5cs/uj+vjgCcFKS4zwiQWI7ArZZZAvc8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm1ZBE46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F715C116B1;
	Thu, 30 Oct 2025 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818758;
	bh=v/bwxwMrPgUrZzVMTssoD2ipJp8loXVDoDEfaEXxUas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vm1ZBE460FFKUGimLHP50dR5K9qwZcte7C31bHO6CkzQrGsy+co0uzHGhmohmHBDs
	 9/QJBBq/pimwj2Xu/VA65y6IvwIp7uGxfegWUddymSYGIwZEzLJY4tIXUOh6q8KepU
	 n5v1f3qaagsSm3hPoBXmpz1KL/p1Ae0ua6ki4zi52xSEZKu0M7QjLLtsZKT4+zWkGL
	 87a9Wd5p202LZF9OJGE37BmcWsvuq2ceSn9U1HZh0AOWUGVUxYKG2+bvdWkDGH4HaJ
	 jEYJuFgfIwDNyyS04FPxQcEdUuY0hUwNTCykYnjDoPyFhWMejeuBABODWqM8tAT9+q
	 DXYvupmk7R5aQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 30 Oct 2025 11:05:47 +0100
Subject: [PATCH v2 3/5] nvmet-fcloop: check all request and response have
 been processed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-nvmet-fcloop-fixes-v2-3-b8d66a322c51@kernel.org>
References: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
In-Reply-To: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

When the remoteport or the targetport are removed check that there are
no inflight requests or responses.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5dffcc5becae..4e429a1ea2bd 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1111,8 +1111,10 @@ fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 	rport->nport->rport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	if (put_port)
+	if (put_port) {
+		WARN_ON(!list_empty(&rport->ls_list));
 		fcloop_nport_put(rport->nport);
+	}
 }
 
 static void
@@ -1130,8 +1132,10 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 	tport->nport->tport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	if (put_port)
+	if (put_port) {
+		WARN_ON(!list_empty(&tport->ls_list));
 		fcloop_nport_put(tport->nport);
+	}
 }
 
 #define	FCLOOP_HW_QUEUES		4

-- 
2.51.1


