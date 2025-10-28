Return-Path: <linux-kernel+bounces-873787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717A2C14B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD4B4878EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E68232E68C;
	Tue, 28 Oct 2025 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCJ8k5/c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70622129F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656100; cv=none; b=NnzFF/06LTPzFsf566+0RoDT0cUuIEGdl8kUFnMRrL9oIKHYeVgh5EZScsE4wnJu40Y3yhpj4By8S0Aq4McIGKY119rtbZkJE2xWFyx34WjNdrkMx+uH/WzBGkdd23qHSmFxZAGEAIDY3XYvtKLWO0s0PvI3LY1RsBavbak73XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656100; c=relaxed/simple;
	bh=PbHgABvRssCMQ5NTXVe30ouhmXUYCCRKnKq46Uusqpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pBG+4YwvsR6lpCKWQCfY1d6KUTppsOMDILLHtdCPVr7WVlp4WQgMElTCMmUQ+Sddo4lkRvn4szohM07l8gro8z0MhjO+4FGOke9QwTv4BOlRbz4jImmkk02p4FG8pPUyddyn412bszf72KRbNIySFc2PGfn+naQwDIjKr0u6Ii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCJ8k5/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AD3C4CEE7;
	Tue, 28 Oct 2025 12:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761656100;
	bh=PbHgABvRssCMQ5NTXVe30ouhmXUYCCRKnKq46Uusqpg=;
	h=From:Date:Subject:To:Cc:From;
	b=qCJ8k5/cngvc9UOrcRoSXlI6gjl8f9KiOOfEha51nc6ejmmwwxmmfHu3/aIgeSAf5
	 tBcawuXzbqPpxJw9DjJCpJOELRRx2UWg7JpXt+RviRiiVCMwIM3f8KEXcJFtLBi+k/
	 usp7Pk86ZVcoKIYdNxNkwHddb1sl3ufQwcKuTtwLeqkjNe9RXj66VkUnZnUyniZil9
	 OVCqqvh3LtStjR/cwHDoTPSnJAk14+2zGTndSGVCJNkmDiPrYMOugJlmDU40ImVZVL
	 TnyOwN4aWge5T5jYu629BrVMnQOCSqbHVFrrduPg8vucN0p6yKLkk1vZfCwrc5iFWa
	 J5WNDRBZo+W5g==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Oct 2025 13:54:56 +0100
Subject: [PATCH] nvme: drop bogus nid quirk for multipath devices which
 passed id test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org>
X-B4-Tracking: v=1; b=H4sIAB+9AGkC/x2MQQqAIBAAvxJ7TlDBkL4SHUxXXQINpQjEvycdZ
 2CmQcVCWGGdGhR8qFJOA8Q8gY0mBWTkBoPkUgkuNTtyuOuQzEa0JzNGOLRq8d5rGNFV0NP7D7e
 99w9lek7HYAAAAA==
X-Change-ID: 20251028-bogus-id-check-aa1dec56fff8
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: John Meneghini <jmeneghi@redhat.com>, Bryan Gurney <bgurney@redhat.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

From: Daniel Wagner <dwagner@suse.de>

Dell Express Flash NVMe P4610 reuse the Intel device id 0x0a54. The
Intel P4500/46000 device needs NVME_QUIRK_BOBUG_NID whereas the Dell
does not. Thus clear the quirk when the id check passes.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217981
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Hi,

Obviously, using the correct IDs is really hard. There are at least two devices
which share a the device id and one needs the bogus id workaround the other
doesn't.

We discussed the idea to pass through configuration from the kernel command line
at ALPSS. I am not sure, how far we got with this yet. What about something like
this here?

Thanks,
Daniel

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 734ad725e6f4..881981c2a3b2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4005,6 +4005,13 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		memset(&info->ids.uuid, 0, sizeof(info->ids.uuid));
 		memset(&info->ids.eui64, 0, sizeof(info->ids.eui64));
 		ctrl->quirks |= NVME_QUIRK_BOGUS_NID;
+	} else {
+		/*
+		 * If the device is a multipath device and the id check passes,
+		 * the NVME_QUIRK_BOGUS_NID is not needed.
+		 */
+		if (ns->ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL)
+			ctrl->quirks &= ~NVME_QUIRK_BOGUS_NID;
 	}
 
 	mutex_lock(&ctrl->subsys->lock);

---
base-commit: 77a4fe6a06e265bd94d2b3cdc87fb3cde877a05b
change-id: 20251028-bogus-id-check-aa1dec56fff8

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


