Return-Path: <linux-kernel+bounces-874068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48509C156EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F281AA0315
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351DB340D91;
	Tue, 28 Oct 2025 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llQGr5a1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE5340293
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665192; cv=none; b=jxOkb4JxPyIS1AVsok49VXl6fNlixqDqTQ/F4Ow19xCNaryiJjwPszarar2KjIxjTyYanfi6gu1RpEfs5owLr2CCGx0Xtx5ry/bQkw7R4P0Cmqwtqrk/fvUwvxmKBoIDBmBXxRTgcfpu9ley5iUtGNrWhtXQ1l2IPbZoCZcvGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665192; c=relaxed/simple;
	bh=GTIbNeoxU6ONRl0I+KD8gbQC9oD3AKOkwvSlwjKDCsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pf95QKgrKDencZ76N3fW0ceFt8f3L9+oxopVhKXs1Ll/kQbUVzpyGpTgImstgVPzPCikrNnVXWW/0J6uRsrXpyHLYfr50fUJ6gfGuTn9IgYkrBaBW0KI5qlNk/qMbClISrkAy0TvW51Tv3kz0cmAJ2Av2TYIQNfx6qhIAjQIADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llQGr5a1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEDDC4CEFD;
	Tue, 28 Oct 2025 15:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665192;
	bh=GTIbNeoxU6ONRl0I+KD8gbQC9oD3AKOkwvSlwjKDCsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=llQGr5a1BBWCntIQeV9zjqYoyxE+seNU1Zw5jkmdOLxnsjCFuguj5txU0sxwS+50a
	 Z5QZChZeL0H2DknXq/Sz7fs5cUKfphY/nzoGH5Wpu7/PyyS1MX5glZ78ZpiOTIdjoe
	 Wj8fIPjpSZhg0WRCxRVxxUIvBwTbz7quh7swuXAyMwCPNE9fdnqWf0fVXrhzI3/0PW
	 GgFRqVKts7wIhdGxEU02VTM0gTgS1LRRAmVvAWnYFQBCDdpAAsOtW96t+Gd72fFuMA
	 Qb95KsV/Eop1151XfVwckglZ75Nq4DYOp8FA3533VdZNnDOFqbQiXri2SjxpNP6R3G
	 6UtBKfurXnwSA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Oct 2025 16:26:20 +0100
Subject: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-nvmet-fcloop-fixes-v1-1-765427148613@kernel.org>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

nvme_fc_ctrl_put can acquire the rport lock when freeing the
ctrl object:

nvme_fc_ctrl_put
  nvme_fc_ctrl_free
    spin_lock_irqsave(rport->lock)

Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 03987f497a5b..2c0ea843ae57 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1488,7 +1488,9 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 		if (ret)
 			/* leave the ctrl get reference */
 			break;
+		spin_unlock_irqrestore(&rport->lock, flags);
 		nvme_fc_ctrl_put(ctrl);
+		spin_lock_irqsave(&rport->lock, flags);
 	}
 
 	spin_unlock_irqrestore(&rport->lock, flags);

-- 
2.51.0


