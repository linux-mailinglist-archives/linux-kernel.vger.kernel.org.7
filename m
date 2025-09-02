Return-Path: <linux-kernel+bounces-796122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0919FB3FC29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 688167ADC53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34792F39A6;
	Tue,  2 Sep 2025 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7BLtbSm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4935528134C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808545; cv=none; b=NxOhgHqJhVl9/Tea+HR+aYoryPmRrrbqMsYrvNqNcH9kZXsqhsn6xh5C2zFcu2cDMQc3C5xH8VGSnBSziH5WyvDkmfa/DgejA8WiLrUCRn3kkMFnCTynVtFMM37CWmpUf36usXPFKqftbMFJpkasujSH5r7m88IhgBTOUPJOaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808545; c=relaxed/simple;
	bh=XdaLPKat6GDbBRPcO/Jf/i/b/c+Fok3IBE+4J5oQnYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PtNDgGhw/POiDUqfDNLtGexCgJNZzUV2ffnoYnyGOZylH6uRg1cbEiEbVAuqpFREJigX3NBsEWhBtihT3WHAzOXwBLGjsH9/MR3Gu0sL/PUQCjSE2MdPS1uGIlZ7JKD+Ohokg52a4Wtp3UiiJT3DPdNNYTQQarSu7cUdoAPW19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7BLtbSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8697C4CEED;
	Tue,  2 Sep 2025 10:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808545;
	bh=XdaLPKat6GDbBRPcO/Jf/i/b/c+Fok3IBE+4J5oQnYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d7BLtbSmF14hRfoeGMjdBAt9LFyXVNfLVyv0PN8J6acm1NrMFGjxJxyzZRVqfkPS4
	 TrCDmBDnfdJ5Ub2mcVKceJKFcivcKg2tyh2nMznlPN7VmJoXLSQ0cGtjQJhoqUCDle
	 YWqROghliDxD+WCwea1io6nTpy4iuXMo3RBLxBHv9j616/koUrvpIggV0WkFSG2Jvo
	 sc3XcnpX5TEjkjadv9FMNJre+0MBy6FOouiyrf4UMfd1eY05j/+XdjpvWvRVIGoTtC
	 MDiBbT2uCtg0dMRST/XoEy7Of/+KpnCZGIStKT/7cZVfLPExF/zV6qJpRgp5GFpdze
	 zDQNU80Ez9KiA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 02 Sep 2025 12:22:02 +0200
Subject: [PATCH v3 3/4] nvmet-fcloop: call done callback even when remote
 port is gone
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-fix-nvmet-fc-v3-3-1ae1ecb798d8@kernel.org>
References: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
In-Reply-To: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

When the target port is gone, it's not possible to access any of the
request resources. The function should just silently drop the response.
The comment is misleading in this regard.

Though it's still necessary to call the driver via the ->done callback
so the driver is able to release all resources.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs-OBA0WMt5f7R0dz+rR4HcEz19YLhnyGsj-MRV3jWDsPg@mail.gmail.com/
Fixes: 84eedced1c5b ("nvmet-fcloop: drop response if targetport is gone")
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 257b497d515a892a39da82d2f96b3fa3c6e10cdd..5dffcc5becae86c79ef75a123647566b2dfc21f6 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -496,13 +496,15 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	if (!targetport) {
 		/*
 		 * The target port is gone. The target doesn't expect any
-		 * response anymore and the ->done call is not valid
-		 * because the resources have been freed by
-		 * nvmet_fc_free_pending_reqs.
+		 * response anymore and thus lsreq can't be accessed anymore.
 		 *
 		 * We end up here from delete association exchange:
 		 * nvmet_fc_xmt_disconnect_assoc sends an async request.
+		 *
+		 * Return success because this is what LLDDs do; silently
+		 * drop the response.
 		 */
+		lsrsp->done(lsrsp);
 		kmem_cache_free(lsreq_cache, tls_req);
 		return 0;
 	}

-- 
2.51.0


