Return-Path: <linux-kernel+bounces-899706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF9AC58BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7DC04F824F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C401A340DB1;
	Thu, 13 Nov 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O70z7SGs"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D9033B96C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049134; cv=none; b=BraQ2tbX/IJgNKnt7Q/fSulAeTrGj0Nzrg9F1puNVzr/UdBoNxxDgFab+RAGr8SsmNIQ/w9TFvwuw7iFc6Hn68b+HjPHUxowp9GSwm/dONCREEE+ZYEe3Xy7NOgmS32b2AY1b9aHNya7sFgEE5JnCspSGji6waJnVWJxs1gM55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049134; c=relaxed/simple;
	bh=7WKzXKew6KgiSOeZU/u8kGox8b1sYC8NnUAddHTdcGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zz997hM2ey2HYpRms2fFGNv9lUN2f22JkxoVAce+8BUkthKLpnSOfrKFz0W/RvBYIfZtWGgmrbPI6JZrgqsXw8M0l0/NAVzEIZy4WCMTs4sC80LonJ7yComKziZSu396VaQoHL9dJGCIj56+1PnIYcRHcLFjg7yidSkpwUYkf/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O70z7SGs; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763049130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9RqZn7CnG+RuCFOcaoApPmBzNHLrXH0MNcl0E1VTIG4=;
	b=O70z7SGsb21L/G0AQDCsfxFpCGWD3ZstkzMgKtDdXanqHdO3LozC6xKlSDCJ4fVmuozpbH
	tzzWUoRAMxTTo9FQP1XRd0Ls7wdUdrFrnB7pyaKM2wRQJEnxhbU33eVGEeDnRq/djTXuK6
	c/TxUdBU6ZlukJ+2yk8Yb/bKdjddUlE=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	Baoquan He <bhe@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Geoff Levand <geoff@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH v2 0/7] of/fdt: Some bug fixes and cleanups
Date: Thu, 13 Nov 2025 23:50:57 +0800
Message-ID: <20251113155104.226617-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series fixes several bugs related to dt_root_addr_cells and
dt_root_size_cells, and performs some cleanup.

Changelog:

v1: Consolidate duplicate code into helper functions

Links:

v1: https://lore.kernel.org/linux-devicetree/20251112143520.233870-11-yuntao.wang@linux.dev/t/

Yuntao Wang (7):
  of/fdt: Consolidate duplicate code into helper functions
  of/fdt: Fix the len check in early_init_dt_check_for_elfcorehdr()
  of/fdt: Fix the len check in
    early_init_dt_check_for_usable_mem_range()
  of/fdt: Fix incorrect use of dt_root_addr_cells in
    early_init_dt_check_kho()
  of/fdt: Simplify the logic of early_init_dt_scan_memory()
  of/reserved_mem: Simplify the logic of __reserved_mem_reserve_reg()
  of/reserved_mem: Simplify the logic of
    fdt_scan_reserved_mem_reg_nodes()

 drivers/of/fdt.c             | 93 ++++++++++++++++++++++--------------
 drivers/of/of_reserved_mem.c | 37 ++++----------
 include/linux/of_fdt.h       |  5 ++
 3 files changed, 72 insertions(+), 63 deletions(-)

-- 
2.51.0

