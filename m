Return-Path: <linux-kernel+bounces-603125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A20A883D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 16:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D72D16ED5A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FAA27F734;
	Mon, 14 Apr 2025 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNflNOq3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F93427F729;
	Mon, 14 Apr 2025 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637502; cv=none; b=reVxZeMZtx23qoomZDQB1kQGebaL4o1RJRY7f4nPYvs8Pppn/DjakIuXaJ0tRj6Y62BpKSq+4Bamf2g8yUL9L2oyNpwDaOj4qQ6SUBkW7xiDmrXR/9b+P+ojZMqaDlXhmHkVPiWBBxaPV+8Ha+YVRXvMNHqoC3ob96K60U3o4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637502; c=relaxed/simple;
	bh=6Q6vcdSjw/C5L40fa3MSw3GHDhL1p1g+Cc+qUbskpE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iax00hhbb+Ogo1sgkjSOStyYsCJSzSEE564AVyG84L2A/XkdpJTtf7kl4XGIm8bo4ebwPdB6s3Kzs4gpmV+qUvWFLf+IiFUb2AGaaH4qRHASrZ9o0913715UKLeKyugqKdf7mxKgrqrl7JZ2rtXKnfLeWRAoMDDOwFz3KM9FMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNflNOq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C983C4CEE9;
	Mon, 14 Apr 2025 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637500;
	bh=6Q6vcdSjw/C5L40fa3MSw3GHDhL1p1g+Cc+qUbskpE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNflNOq3HuCHv8i78in5evv7N10jHlqvQESJmuLqW+vPWOwGEUbwF2qcMm43QLtNR
	 iwb1xdQc6Q1ZRI2/V+wG2s4K8gfByKJa9gv5Nt58tWLJQ5xZMnVryH5YqPeAx31A70
	 My83BEhjFk1Ze2D99N1TFG8gUwiThweu5YpcdFVSDOSGrLWwcJLTQwCjgYN8x4/r01
	 ZWnoDM3Y6zgMDimBNCPqNerks4AccxsEoMcFnr1EjFfXsBMVkumQd5jHHRyGhEVlZd
	 zJ9ZjdlvYIjXL/GgBrbFk2dzHOdAraW0X9iQfT82j3L2uFBo0laWcGsUjpGCFnnQIg
	 5HTQ6aSqYfzDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 07/15] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:31:17 -0400
Message-Id: <20250414133126.680846-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133126.680846-1-sashal@kernel.org>
References: <20250414133126.680846-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 62baf70c327444338c34703c71aa8cc8e4189bd6 ]

When scanning for new namespaces we might have missed an ANA AEN.

The NVMe base spec (NVMe Base Specification v2.1, Figure 151 'Asynchonous
Event Information - Notice': Asymmetric Namespace Access Change) states:

  A controller shall not send this even if an Attached Namespace
  Attribute Changed asynchronous event [...] is sent for the same event.

so we need to re-read the ANA log page after we rescanned the namespace
list to update the ANA states of the new namespaces.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85d965fe8838c..68d4546dda3bb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4225,6 +4225,11 @@ static void nvme_scan_work(struct work_struct *work)
 	/* Requeue if we have missed AENs */
 	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
 		nvme_queue_scan(ctrl);
+#ifdef CONFIG_NVME_MULTIPATH
+	else
+		/* Re-read the ANA log page to not miss updates */
+		queue_work(nvme_wq, &ctrl->ana_work);
+#endif
 }
 
 /*
-- 
2.39.5


