Return-Path: <linux-kernel+bounces-874067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2B7C15771
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DB39505143
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDBF3314AB;
	Tue, 28 Oct 2025 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbvCKjM7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC532222A0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665189; cv=none; b=uysW0KqeASfwTxD9vu5TqkyMGcN0kbczwBhB0uVn2IbBn96mWZbKuU8oM5KvlrgOMNl3ZQRavm02i4wfh3ILx3z180TZiheDZsvMH3XW6HG0CHojzNXYxftqWDhoP85lHhcPseKGQLYuZjHZrGyBaFYSxf+Ff3QzCigmZh/xUr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665189; c=relaxed/simple;
	bh=3r7v1bznx5QjNt6k3+3hxpxHKtkAoMs7IeUHquPgrJ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=he/KqQIruZS+bAEAUfppSta+VgYCfAExArRliPlTN1Zw9l6UlLpSkSIe2RZwhtiDFsuzRrqBNBeXhYNHi5AqGHzVQlAEXZQ8jO2Ku/eM7Rw/iiFApfLl3vsIKOJ1lXFqDLDC2D7Vq4OD1fKUbtrrV0zVe0kWYD5HVDdZi9MyqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbvCKjM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DAFC4CEF7;
	Tue, 28 Oct 2025 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665189;
	bh=3r7v1bznx5QjNt6k3+3hxpxHKtkAoMs7IeUHquPgrJ8=;
	h=From:Subject:Date:To:Cc:From;
	b=jbvCKjM7+D6EenQEeDFueRf0kmFHtWySvcbbTi+LdSvSheekTm4YGFGsQ0tVaT/Mq
	 wlezMIs11aul/0ay30vIuVgBJMQOAlH5MWrhuiAxkmxZ7CYfKUzIHNXvDs8RbF4P2m
	 OS4u67Pl3FKa6h05OS0KGNOM0BmSPfuTcSWMVk4Ku3hZiGQjl7qjumEsOMegKRHo3e
	 LZBoymmvw46m4M8vcZ+qJP+5x5OKQ4r6+91R9jcMx3YYAXiNiaRueioq450i0Bepsv
	 w5W171ye4AZ3aNvbFhsHTc4RPrX5ORf2aYEYkhaOW08DStBiD0UnLvKrBFBMooWWOA
	 vWh6iUWXTe+fw==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH 0/5] nvme-fc: misc small improvents
Date: Tue, 28 Oct 2025 16:26:19 +0100
Message-Id: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJvgAGkC/x3LQQqAIBBG4avErBtQSZKuEi2ifmugNDQiiO6et
 Px4vIcykiBTVz2UcEmWGAp0XdG0jmEBy1xMRhmrlXEcrh0n+2mL8WAvNzI3sC2c8dprS2U8Ev5
 Qvn543w/0/SDwZAAAAA==
X-Change-ID: 20251028-nvmet-fcloop-fixes-4e57e82f1f15
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

I've collected a bunch of patches from the last debugging session. I think it's
worth documenting which conditions are expected in the cleanup path by adding a
bunch of WARNs.

Also found a deadlock in the nvme-fc code, so this one should definitly go in.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (5):
      nvme-fc: don't hold rport lock when putting ctrl
      nvme-fc: check all request and response have been processed
      nvmet-fcloop: check all request and response have been processed
      nvmet-fcloop: remove unused lsdir member.
      nvmet-fc: use pr_* print macros instead of dev_*

 drivers/nvme/host/fc.c       |  4 ++++
 drivers/nvme/target/fc.c     | 48 +++++++++++++++++++-------------------------
 drivers/nvme/target/fcloop.c |  9 ++++++---
 3 files changed, 31 insertions(+), 30 deletions(-)
---
base-commit: 77a4fe6a06e265bd94d2b3cdc87fb3cde877a05b
change-id: 20251028-nvmet-fcloop-fixes-4e57e82f1f15

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


