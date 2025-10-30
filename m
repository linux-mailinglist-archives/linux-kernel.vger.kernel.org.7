Return-Path: <linux-kernel+bounces-877965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56315C1F714
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F8A4220F2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890CD350D6D;
	Thu, 30 Oct 2025 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNgKP3CL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92FC350D5A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818755; cv=none; b=t9V+4LnEDU01xpXiGAvXw4c49F3jxazdJMrCPf6npO2e7D7X+JIu3Ondm0rHovMLCtGoaG9bDkWnqX9p2y3U2cPxsM6XCXRGKtdUxpi7fpaUz0wmGWusDRZ3kbcOvxmmVOk5hnPvv1W4kXParFDR5B+0DO//+tVwxWUCR2fnbYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818755; c=relaxed/simple;
	bh=pD88QTQwhCsd1dD9Fb+TDQoClhSOHeNyLN7H0zQpYAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNOga1c1kwW1DJdidpypGOvpUzSNDehPfpiP2KTIzIwYjKtdf8s6YDuB9R9hMeT1D1nkg+qJWEO5ovT85YZfsNTBIB1VKsXg/HHd8nQQyLGa4rZ6Ow9MXjUUqVLJpTw6p/xRYL9BtzZ9xeaSVrUKEA7hqjUng+RM4BDfIullmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNgKP3CL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56797C4CEFD;
	Thu, 30 Oct 2025 10:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818755;
	bh=pD88QTQwhCsd1dD9Fb+TDQoClhSOHeNyLN7H0zQpYAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uNgKP3CL1kYsUxeqYTrEnq8RP3483/KZhRisETibvx1WZM1//MV+Q6vTCRpDsjsw3
	 A7LfthB4qyHNZ3WQrux/XIqPxSqz32rNzgt+yukr9r3/rWMiVA39XitblrgFtHaULm
	 wXnjTAxb4/kX7kW0/7H4T/ogGMIAfmnKKp9CrRRNxiVlrWhQJR3SsMHPhvYbFG9IkB
	 VJt5MRaTMlcPfKRZJKfPsLEJv4E8TnhT+bihoBJfF94CwQMap316KxEhWbo6+I2rSJ
	 vdhJ39nKBVQa2lqmnVFDv3a5ipuDXZtMtjl/psErTlzgp5r0ZqT7eqrY3hiF5JcNTN
	 XrE9QuOxMYqhA==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 30 Oct 2025 11:05:46 +0100
Subject: [PATCH v2 2/5] nvme-fc: check all request and response have been
 processed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-nvmet-fcloop-fixes-v2-2-b8d66a322c51@kernel.org>
References: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
In-Reply-To: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

When the rport is removed there shouldn't be any in flight request or
responses.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3ff70e6e8131..b613fc5966a7 100644
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
2.51.1


