Return-Path: <linux-kernel+bounces-874069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 329F8C15775
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A1F0506629
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B0340DBE;
	Tue, 28 Oct 2025 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHCpIrRA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED74340DBB
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665195; cv=none; b=QSKSRa5AukW+z/TYFU+OPEgSl8iyXLMgglB76a1tkNIWEBEawSWzLSxdgZiD4XpXlgR3o1yi1A2jPbSYv5KSMuShW0lGwKGoAkn0A05q6yjwgxOT6TrBefTTFTMrBkcl2+74PZomUrBgBBS8dTkoq+8C0pK+prSiLz4GPkfWdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665195; c=relaxed/simple;
	bh=Ak6jGISt8Tnwrl6aQtFstbUZY6A+aNV03E07Eu6cuf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XzxYDVweD8nLybaAzJ/+F/VOYfJUD4qgSxAqNU92JH5FhJuJiJMuIpih/Durzy79r11oZ8DP5TaMzr1OnfiIYCofobUKgvcE+s5cicYa/AgnvDkPlYd+/qNK7h8YmXVLosKFS2zwlT7+3lj+TuGSc7hONmZMYmNPEzT5Fy8NIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHCpIrRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B88EC4CEF7;
	Tue, 28 Oct 2025 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665195;
	bh=Ak6jGISt8Tnwrl6aQtFstbUZY6A+aNV03E07Eu6cuf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YHCpIrRADrOHpz/kLnfTOZNXd5IKsPMlV2ysYBdKG6lH2z56BQECWKKKwsmbD6cA8
	 JY2fJRLbSSmYWl9XeP1Dwo/wQlrLL3/ifOUUn5rsiXFd0vGJh3FRVZxFoSMvL+A8aY
	 32fJ0npjLfR8UXFIyuTBEL4cG7H3xX1c/oCU4Ajn5MtkHbi1a4X1LvnNPT9hU2amvM
	 6s5d6R6jP70mu/7dmhGQiMb0259RH5vAjjHJReigsQfB+5GpsEEKR/z0dnXw7mmoUV
	 pzTb5xgtMouxunlc85k9p+T1H638Vc8zw+CXj2TSIhLk0N/bLL8cz1+D4sFhqKnGtJ
	 Y7pfLOtnl08Eg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Oct 2025 16:26:21 +0100
Subject: [PATCH 2/5] nvme-fc: check all request and response have been
 processed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-nvmet-fcloop-fixes-v1-2-765427148613@kernel.org>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

When the rport is removed there shouldn't be any in flight request or
responses.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2c0ea843ae57..dcb7fc2ca0b7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -520,6 +520,8 @@ nvme_fc_free_rport(struct kref *ref)
 
 	WARN_ON(rport->remoteport.port_state != FC_OBJSTATE_DELETED);
 	WARN_ON(!list_empty(&rport->ctrl_list));
+	WARN_ON(!list_empty(&rport->ls_req_list));
+	WARN_ON(!list_empty(&rport->ls_rcv_list));
 
 	/* remove from lport list */
 	spin_lock_irqsave(&nvme_fc_lock, flags);

-- 
2.51.0


