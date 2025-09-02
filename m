Return-Path: <linux-kernel+bounces-796118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 157CBB3FC20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B423B1A8870E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B124428031D;
	Tue,  2 Sep 2025 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcKriVQG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B823280308
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808538; cv=none; b=hvS5LiYWMMidFQ2qdld+iLOKqnz7QWTHX6ya8HoO7zTvANtBjGk86UYx8fLpaBl3+VYtfTk9ZOudlsPLiOvgtpPm8jCZewrxekhT3rek02hVtRP15VkKEb8v30+l/Rk6yGpSaKBGwbxTw17LCVTE90mcv4nce+AePJMmLD3/RlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808538; c=relaxed/simple;
	bh=vE8ikcJN4Iv3hs1bbiJIcVz//nLYeKz44RqU6unBRR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GQzAlbMMHouT21u288j5vmzRKbxEW0wVgyhu5b/00H6Dkdw31fpLWmSxQsSiJG7YXR428LQxZQup8DqhXncgGDd9d+wG4HbnWpZh4QX5RpXpwRDGJ9KxPpYdx2xSmF5Y/l4NKE4PlBKismmedYKrm7rXKuc85wWiSBbdea1JiLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcKriVQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E9EC4CEF5;
	Tue,  2 Sep 2025 10:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808537;
	bh=vE8ikcJN4Iv3hs1bbiJIcVz//nLYeKz44RqU6unBRR4=;
	h=From:Subject:Date:To:Cc:From;
	b=dcKriVQGxeJ2H04BX7k0uiSVTZG5zgytFTzeMucgf11t6NQy+LxZlDB27ACj1wfuJ
	 AnEhgs9VcF8BoTP/mmY4z1IdplNxaVLM/f7Gq9YzqojWJ7HT1Z+0XqwHs8/uDspO+5
	 8rgIZRlLFliFoJZSuq7BPCqEHCRMbetkA9XK+NdosjnBAQZOPHubTHqUwlYopsVEDB
	 zT5U0Nvkq8qHVk8PFkI7xSxGYQP5rh0ppV5Gs+uEOfKVOoILb2VxkaorA8iq0Miimg
	 cb3R2PJdch3hdlq32diB/AwG937FTC7AWaa0CbS37JyafOyRVWRCT+plKcrgSyWPiH
	 dvH3BfnCtWFaA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v3 0/4] nvmet-fc: fixes for blktests tests
Date: Tue, 02 Sep 2025 12:21:59 +0200
Message-Id: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEfFtmgC/3WMQQ6CMBBFr0Jm7Zh2qEBdeQ/jgsAUGrU1LWk0h
 LtbWKmJy/d/3pshcrAc4VjMEDjZaL3LUO4K6MbWDYy2zwwk6CAakmjsE12684SmQ9ka3WgtFTU
 GsvIInP8td75kHm2cfHht9STX9U8oSZRYlkr3rTJKVny6cnB82/swwFpK9GnrH5tQIFUVCaZaU
 Vd/2cuyvAHc7xM65wAAAA==
X-Change-ID: 20250821-fix-nvmet-fc-1af98991428f
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

I've added the other two patches I've recenetly send out to this series
for getting blktests with FC more stable. So this series containts all
the latest versions of the patches flying around.

What is missing are the changes for nvme/041. These patches need some
more work and more review.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v3:
- collected tags, updated references
- added https://lore.kernel.org/all/20250901-nvme-fc-fix-leaks-v1-1-3ae0aa88d5e5@kernel.org
- added https://lore.kernel.org/all/ldr3xa4muogowu2xeh3uq3xcifljfftssydgnhjdarfre4kg4p@midqloza2ayz
- Link to v2: https://patch.msgid.link/20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org

Changes in v2:
- rebased
- added "nvmet-fc: avoid scheduling association deletion twice"
- Link to v1: https://patch.msgid.link/20250821-fix-nvmet-fc-v1-1-3349da4f416e@kernel.org

---
Daniel Wagner (4):
      nvmet-fc: move lsop put work to nvmet_fc_ls_req_op
      nvmet-fc: avoid scheduling association deletion twice
      nvmet-fcloop: call done callback even when remote port is gone
      nvme-fc: use lock accessing port_state and rport state

 drivers/nvme/host/fc.c       | 10 ++++++++--
 drivers/nvme/target/fc.c     | 35 ++++++++++++++++++-----------------
 drivers/nvme/target/fcloop.c |  8 +++++---
 3 files changed, 31 insertions(+), 22 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250821-fix-nvmet-fc-1af98991428f

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


