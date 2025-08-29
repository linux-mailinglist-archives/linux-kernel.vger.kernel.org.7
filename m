Return-Path: <linux-kernel+bounces-792026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5662AB3BF92
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A39167B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A6B335BC1;
	Fri, 29 Aug 2025 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIjAQDXy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BCF334723
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481853; cv=none; b=sw/ToX4YZbqEQGKVJE9cUr3NlqIVQwrYNf6SeaduGPY3fvPAccCmQRiwSNyQN/t5QfO40sWNn2NsrIduHtz6fjPVseU3/2G2986mQCntuFzEeqnaT61+4cF2/M8h4ZDmE5wcTD8t2o9Tc4zxuIIN3FSvigwnxoldpwg9Sd56iJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481853; c=relaxed/simple;
	bh=6pYeQyWaLKkJ+BDYnkitu7taheegSWA/VRkcoPPeuFc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XgbIKvz3fHv5Dt+z3jicCfaPuLK7V4pDWwN3CBuVNLfBJ6C7P4oIDePl70hA3S7o2TtxUk+8jDTE99732eUnhiuMfMM07yobqhdv/gC/82XkFiLNiVmjiOViAGSt6Qcz7MAD7pAnerHU4BNaCrqsUaDQu9syE+zZ4LHEAkKt8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIjAQDXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9143C4CEF5;
	Fri, 29 Aug 2025 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756481852;
	bh=6pYeQyWaLKkJ+BDYnkitu7taheegSWA/VRkcoPPeuFc=;
	h=From:Subject:Date:To:Cc:From;
	b=pIjAQDXyzdlj5WrHtUK2PprPk85Eox3uJ3Ll++ZaxwmNCzgc800J5dZEjnEoscpxK
	 g7VE/Bftpxl7dDT4AfYcYUmgEKc7Mn+HgWHmpjme1OWhagExjmCKnkDa3gYc5wnPyY
	 QxZE2eZUWMNIvFJWZZfLfuE+K26s1THlRE6hFad43AnHPQU67lb0alisdvAZDHmwo7
	 RHbDkgf6V65UMj7HSPudQBM0CJFNgxprxKc2FY6tyYK7WKkL0FzLyT6RP8PJ4B49TX
	 9+sF/C+zO9f2DLb14/ORluMiD5lKRuTpBllfggv+6lPIenyIJhSLgBs17TYH2xW57L
	 S7LhsAXeGX0QA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v3 0/4] nvme-fc: fix blktests nvme/041
Date: Fri, 29 Aug 2025 17:37:24 +0200
Message-Id: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADTJsWgC/y3MQQ5AMBCF4avIrE3StCmNq4gFNZiFokWIuLsGy
 +8l778gkGcKUCQXeNo58OQiVJqAHWrXE3IbDVJILYw06PaRsLMYTmexaWyuapVJrVuIl9lTx8e
 bK6vPnpYtVtd/vO8HWH0sE3MAAAA=
X-Change-ID: 20250828-nvme-fc-sync-bbc73a36255d
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Another attempt to get the nvme/041 fixed. I've decided to make the
synchronous connect an opt-in feature, so that we don't break existing
users. I need to do some changes for libnvme and nvme-cli so all works
fine when users update either the userspace or kernel.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
v3:
 - rebased to current master
 - use explicit initial connect flag to distiguish between retry and
   initial connect. Necessary to keep nvme/061 working.
 - added 'nvme-fc: refactore nvme_fc_reconnect_or_delete'
 - updated commit messages

v2:
 - renamed flag to connect_async, default false
 - add info to commit message why nvme-fc is different
 - merged connect_async with 'nvme-fc: wait for
   initial connect attempt to finish'
 - https://lore.kernel.org/all/20240221132404.6311-1-dwagner@suse.de/

v1:
 - renamed 'nvme-fc: redesign locking and refcounting'
   to 'nvme-fc: reorder ctrl ref counting and cleanup code path'
 - testing with scsi/nvme dev_loss_tmo on real hw
 - removed rport ref counting part
 - collected RB tags
 - https://lore.kernel.org/linux-nvme/20240219131531.15134-1-dwagner@suse.de/

v0:
 - initial version
 - https://lore.kernel.org/linux-nvme/20240216084526.14133-1-dwagner@suse.de/

---
Daniel Wagner (4):
      nvme-fabrics: introduce ref-counting for nvmf_ctrl_options
      nvme-fc: reorganize ctrl ref-counting and cleanup code
      nvme-fc: refactore nvme_fc_reconnect_or_delete
      nvme-fc: wait for initial connect attempt to finish

 drivers/nvme/host/fabrics.c |  40 ++++++++-
 drivers/nvme/host/fabrics.h |   9 +-
 drivers/nvme/host/fc.c      | 212 ++++++++++++++++++++++----------------------
 drivers/nvme/host/rdma.c    |  18 ++--
 drivers/nvme/host/tcp.c     |  21 +++--
 drivers/nvme/target/loop.c  |  19 ++--
 6 files changed, 192 insertions(+), 127 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250828-nvme-fc-sync-bbc73a36255d

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


