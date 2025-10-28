Return-Path: <linux-kernel+bounces-874071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0EBC15705
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31AE1A20DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DB83431F1;
	Tue, 28 Oct 2025 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3OzIWXx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7C03431F2
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665200; cv=none; b=GPwbqUxb1x5jUZvGyfA/BfNKC0U+SYzYzn1cNGv7pgz1606yMPzHu4UhUzNeKXzLqbTsRDMkSrsBPszbvzMva5KjABrt42Iv27Sa9snJ2Xyrn30x9HSgVX8hy//7tdLmRenu64HPI+J0anLatPQD9nOOUJYDe86v5bYjbzcPp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665200; c=relaxed/simple;
	bh=YGr8oqXsuwQl2oaUuC5Tyt7qh0xLJoY3vVHoY91jBAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G0XfGqtAwP5b00fUZ5G/OpiuAted4J2Y8jfyWZYNur+las47XOKVX1jo2FaJ1so8MCsuQdSeamqegsamSw6kOGWi4hj/tMitGJoEH4jT66UBPfNRgEha0uwzgyeOW7iRyVY6PGtN2ccjHvrGemK74USoXXALyALMeJ/p2o7d0AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3OzIWXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A4EC4CEFD;
	Tue, 28 Oct 2025 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665200;
	bh=YGr8oqXsuwQl2oaUuC5Tyt7qh0xLJoY3vVHoY91jBAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y3OzIWXxOgFPQG6dh/EqiDS08OFQV3bFSvXHMGOIpuJQ+LHFdaocmoA1on+H8os5o
	 /mMsLpTdkvWKuOg8eXHonN22bgow04jLODZISZqQW+dJ8ywW57/kRrk1GEx7FEdxE9
	 bQJYob8jGTagkCoULYnM3mbqWMLKcyM98Q6xNA8ApGDUjk3M0kgB+96PQWZ2LUioLf
	 TY8/fslTj4oPF/HjsMYqm7UVXABeRqx1AEbHkMMoKz5sIXxgexvgRjYmp5MREzh1je
	 FbqdBXoed6TvaslrBdQJScMQ2uZUoxnE+Jg6HWoSsUkRLIOBDJXSRG1MhQGhPbH0I5
	 3uKa4Y/DMhW/w==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Oct 2025 16:26:23 +0100
Subject: [PATCH 4/5] nvmet-fcloop: remove unused lsdir member.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-nvmet-fcloop-fixes-v1-4-765427148613@kernel.org>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

Nothing is using lsdir member in struct fcloop_lsreq.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 4e429a1ea2bd..c30e9a3e014f 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -254,7 +254,6 @@ struct fcloop_nport {
 struct fcloop_lsreq {
 	struct nvmefc_ls_req		*lsreq;
 	struct nvmefc_ls_rsp		ls_rsp;
-	int				lsdir;	/* H2T or T2H */
 	int				status;
 	struct list_head		ls_list; /* fcloop_rport->ls_list */
 };

-- 
2.51.0


