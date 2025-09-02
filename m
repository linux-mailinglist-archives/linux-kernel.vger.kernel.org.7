Return-Path: <linux-kernel+bounces-796123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E1B3FC2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04234E1C59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44772F3C0E;
	Tue,  2 Sep 2025 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="li/lAITQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E42F3C01
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808548; cv=none; b=tvDmdhpNufaMDkoKEMXYId2G93A/s9IJMll28UTZ7xn1VZM52YsMrhMyS6r7AEk52fkV4VICs8DUTAWaEp0HU6BjQbvr7X74WF2ZCEGzGMXpbnkSIrl1pK1WqLfdpVI6oo/diy8ks7tdS/acz41AuE/FotO8eQ9vlWvuxrDNCJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808548; c=relaxed/simple;
	bh=gts/rTiszRszSd+E8YgjDWY8uUXdozvHeqnApxB8p4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzJJbg9+uM1me5U4lRS0cDMey1uMUiY0z+uhYoPd/3ZmWCczG80wbDTluAOWcqd9y07uhSoM5ijdaOH+CDSU5WL2dJjS2zzc8Z7aAB3tWDB2ljcEQmXnym0Kda848ujHuJIMy8gTwje8aFMsj9KhTtNUoaTHfhxR/Kkidjkj7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=li/lAITQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ADAC4CEF7;
	Tue,  2 Sep 2025 10:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808547;
	bh=gts/rTiszRszSd+E8YgjDWY8uUXdozvHeqnApxB8p4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=li/lAITQwCvoPOw+bowFCpbpMsWY0CiLhLPc4GXDdDgSbItyBfFlWT06CnsVcrOUT
	 hOsO3X3V8ksejEvjlBTy6Mu5XWEosfQVW6f/d8bYuRprbuj7CFowzk9kA2Uh+WUCjC
	 zA8/2oKThxApz1iQbDKb4qyTY9BmA3xQp7YpRT2uJDOV2lbdUjWVWcT5Otc4sPVegV
	 dNBaf0LQcox7s4dGawma0FuXOjXKzk/Cb80Uc9VFRqNZOWppLE9oHN/VLJMQLVJ1u2
	 y/RGf9fPJxxm9yoaSSE9Sga3ao8Du3p3VD3i6u94L9NVz4pJwhfDNEdQtv8ZZ9ThPh
	 uFoRngpmL5Ztg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 02 Sep 2025 12:22:03 +0200
Subject: [PATCH v3 4/4] nvme-fc: use lock accessing port_state and rport
 state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-fix-nvmet-fc-v3-4-1ae1ecb798d8@kernel.org>
References: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
In-Reply-To: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

nvme_fc_unregister_remote removes the remote port on a lport object at
any point in time when there is no active association. This races with
with the reconnect logic, because nvme_fc_create_association is not
taking a lock to check the port_state and atomically increase the
active count on the rport.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/all/u4ttvhnn7lark5w3sgrbuy2rxupcvosp4qmvj46nwzgeo5ausc@uyrkdls2muwx
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3e12d4683ac72f9ef9c6dff64d22d5d97e6f3d60..03987f497a5b55533ee169c9a7cb9b479d0f2d92 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3032,11 +3032,17 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	++ctrl->ctrl.nr_reconnects;
 
-	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
+	spin_lock_irqsave(&ctrl->rport->lock, flags);
+	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE) {
+		spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 		return -ENODEV;
+	}
 
-	if (nvme_fc_ctlr_active_on_rport(ctrl))
+	if (nvme_fc_ctlr_active_on_rport(ctrl)) {
+		spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 		return -ENOTUNIQ;
+	}
+	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: create association : host wwpn 0x%016llx "

-- 
2.51.0


