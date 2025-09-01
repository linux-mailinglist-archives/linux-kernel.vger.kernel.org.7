Return-Path: <linux-kernel+bounces-794993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E32B3EB90
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF901884B5B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB752D5927;
	Mon,  1 Sep 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anQyuVvd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94CAD5A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741877; cv=none; b=fIh4cAKziRR5AbKr0QXove+fWbgrF/7mYbY6t8kIvgoWxTSy/hLj7EjLXOAiZ9w/7ydpUZeVGUfURG/p6FLE6Y/8tvWC9REwn4L8g+uB+Q4+HhwVIhQfgN0kqNLFegGMSCJoEkVIiqXCgSY5Cz5N9f3heEzP1CbXPyaPMRmJZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741877; c=relaxed/simple;
	bh=+d4/imJUBiI3Xursn4W/oBtcM8JHT5OMCHlOTWaPeoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rdKMqMs2sX1uQHDgIZKIy4G00eVE/o/wLeoliZs6olEHVomWYtAz7WQiYa65OqrquFByn2v/PcEQ1NZROaaX3ixeyJcz82T0z1G4g5NSJcjAz+uMzTUS5fMg4u0m85bbWsuS4jz1wYe8HMFSXqNVExxpLecLLRv7d8KOx9GtmNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anQyuVvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0227C4CEF0;
	Mon,  1 Sep 2025 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756741877;
	bh=+d4/imJUBiI3Xursn4W/oBtcM8JHT5OMCHlOTWaPeoA=;
	h=From:Date:Subject:To:Cc:From;
	b=anQyuVvdGy5pkqnFSRSjk+XpK46Zk9Se9/r+byAPbSZYqL64rFOO29O7uxeWWIG56
	 zX1b97FoWVQVs7guBPkYeUdPz3mxl+XmCg+QBGFeK8VhQnSK4mMWWnyv2RbMOwRKbR
	 3eV0OvB/D7wOKgLqipJpO1qTjHWzeWD4dkWBKQMTEbcpDFMfBUkXhVK2/xxkkBrq7Z
	 xtWnzbARjGbUAx0OsNeD9J68ZtaSN3H65cMPUXLCausjKHSrr/LW1eSx9WJNffb4Id
	 b5clSzOptCyyBIuzomJ2IXI7dlhqm4U6U4gNffA7Q+/V8ABwJharudZIUlrK1Wd0ym
	 7dQZzltzGPpiQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 01 Sep 2025 17:51:13 +0200
Subject: [PATCH] nvmet-fcloop: call done callback even when remote port is
 gone
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-nvme-fc-fix-leaks-v1-1-3ae0aa88d5e5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPDAtWgC/x2MSQqAMAwAvyI5G6jV4vIV8RBrqkGt0oII4t8tH
 odh5oHIQThClz0Q+JIoh09Q5BnYhfzMKFNi0Eob1aoC/bUzOotObtyY1ogVaWOpbGpDI6TuDJz
 k/+yH9/0AmPJ1cWMAAAA=
X-Change-ID: 20250901-nvme-fc-fix-leaks-4a25ca3875ab
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

When the target port is gone, it's not possible to access any of the
request resources. The function should just silently drop the response.
The comment is misleading in this regard.

Though it's still necessary to call the driver via the ->done callback
so the driver is able to release all resources.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs-OBA0WMt5f7R0dz+rR4HcEz19YLhnyGsj-MRV3jWDsPg@mail.gmail.com/
Fixes: 84eedced1c5b ("nvmet-fcloop: drop response if targetport is gone")
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

---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250901-nvme-fc-fix-leaks-4a25ca3875ab

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


