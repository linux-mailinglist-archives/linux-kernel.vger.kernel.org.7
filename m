Return-Path: <linux-kernel+bounces-877963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB251C1F70E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B454400378
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2858534E74B;
	Thu, 30 Oct 2025 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmYdSVe0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E641C69
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818750; cv=none; b=R8/6TgbxPCWh8AJtO6R3i6/IPHNEwRKmwyVKDFVuDlgitb9hKQp0d4TWZ2KQtTLEyCCWHAKm7fIY4zVXEloCEQ0ho2oUc9jv8VBokv6CC0L8JDfcZxfWtkQLXOWOrbBgVVcGa0zGVtySqpEwu4kX5IEahZaMoMUoFyVGJE1Apxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818750; c=relaxed/simple;
	bh=z/zO5AzIwHGXSvca67Xe/lROEaDfqic3LtCNKZTOdck=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BfSlw0NxKEorqbZ63kdJ+PFW1QjM9c6afQqjA8k1udgCtm6Rd8LkbuBwpFSc8ijgKhIP15eexVGncvLbmrnXSibwtlEQZe0Y1SKXgi/ItwwOaw9uG9Yyj11MRNc03xGJZGwWwSDSyG30CKKv+OfWzIGu0mugagPvEgmc6T7A2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmYdSVe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C04C4CEF1;
	Thu, 30 Oct 2025 10:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818750;
	bh=z/zO5AzIwHGXSvca67Xe/lROEaDfqic3LtCNKZTOdck=;
	h=From:Subject:Date:To:Cc:From;
	b=SmYdSVe0yFp+VVuHZh63j8huPAJBWKYezRk4c0+jpfqRyNdQMfMDSw2cyYlaGhA5C
	 9NmOqO+pWNxexKtBrNxHvra9q0PnJoIzBBORPdeHGLQo/+4MyWpckdYzSBInzqejc3
	 oMTnHa3UXcah/Axx1ekJupNJdxcI1wIPAFniPMfVSdqRmG7PFVVcPrILUVfsmrQMQD
	 q2xhOEaT8uj+90//zJ/eFzCTDOwLrfRbwm+XoamKB965LZzWucceEtqnyvVqQp67Mm
	 tKBPqdPNvvx8QiF0v79T4jlTwZVqwwGmoGBw2d9ln7tZeNemlftSoHxYIYKG4wwnqr
	 Ng49ddlnYihDA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v2 0/5] nvme-fc: misc small improvents
Date: Thu, 30 Oct 2025 11:05:44 +0100
Message-Id: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ7CIBBFr9LM2jEMQmlc9R6mC1OHllihgYZoG
 u4u9gAu3/95/++QODpOcG12iJxdcsFXkKcGxvnuJ0b3qAxSSE1Cdujzize04xLCita9OaFibbi
 TlixpqOIa+Siqdxsqzy5tIX6Oj0y/9O9cJhRoWq2kIdW1dOmfHD0v5xAnGEopX9R+ol21AAAA
X-Change-ID: 20251028-nvmet-fcloop-fixes-4e57e82f1f15
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

Updated the first patch to use the safe iterator variant as suggested by Justin.

orig cover text:

I've collected a bunch of patches from the last debugging session. I think it's
worth documenting which conditions are expected in the cleanup path by adding a
bunch of WARNs.

Also found a deadlock in the nvme-fc code, so this one should definitly go in.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v2:
- use safe iterator variant in first patch
- added missing signed off tag
- collected reviewed tags
- Link to v1: https://patch.msgid.link/20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org

---
Daniel Wagner (5):
      nvme-fc: don't hold rport lock when putting ctrl
      nvme-fc: check all request and response have been processed
      nvmet-fcloop: check all request and response have been processed
      nvmet-fcloop: remove unused lsdir member.
      nvmet-fc: use pr_* print macros instead of dev_*

 drivers/nvme/host/fc.c       |  8 ++++++--
 drivers/nvme/target/fc.c     | 48 +++++++++++++++++++-------------------------
 drivers/nvme/target/fcloop.c |  9 ++++++---
 3 files changed, 33 insertions(+), 32 deletions(-)
---
base-commit: 77a4fe6a06e265bd94d2b3cdc87fb3cde877a05b
change-id: 20251028-nvmet-fcloop-fixes-4e57e82f1f15

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


