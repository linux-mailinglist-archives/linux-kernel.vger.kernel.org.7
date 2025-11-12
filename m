Return-Path: <linux-kernel+bounces-897408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAABC52EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 706F8500EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619312C0279;
	Wed, 12 Nov 2025 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lY2KHR3P"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E22BF3C5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958238; cv=none; b=Iupl+E/M6O4DDz12fff+h7giZMNzlVUtp4SmmDUIEkiVPMURKf3JBADClMZa49qTkpEjykXnfOjGQJ0mnOM81z4Xyh/XG2McY7WmZDF8gpyygtJ5CcFKrDxTEQvVM75aLZbPix5tDVexFlgdh6UOsIcjfgYiu0opow81yF7yujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958238; c=relaxed/simple;
	bh=rFdkV8BtJFuneZDFlffAsIS8x4aIK6ti+OGgqdl4lEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogrhMj0Q2xx7oDQV91cxDMaqLBAxPtoQGjXozrpIVAgY1AVCohCRIIZJbLSW9yd4DLuAcyBobOq9Mg5U4GyBKr1vC/Ud1N7f8Rln4dXD1s6t7r+yu+X3SAbgVMcna1Rw10Zd3usfP7/zQHAGgijB+b+3R/4i6SpmcqmVbLnwNxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lY2KHR3P; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762958233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3yCieyHDoW3ITh82IhI4hK06ZWR3IHLaCTPT9+BieoU=;
	b=lY2KHR3PU43Bc8+D/67TfG8jVYd8ms7a4soa1ifgPGo+Oi8OEg5Amp597peqHokZ037rBf
	LDqTEefACtoufJB3/eGaiASAi02laNL+/2E17lJJjlf1KK78d6UjPEAAA+MdasOzsAe9b4
	HAJT3fpv9Jwe2PzZ2auDRY9fXW6qCa0=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	James Morse <james.morse@arm.com>,
	Chen Zhou <chenzhou10@huawei.com>,
	Baoquan He <bhe@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH 00/10] of/fdt: Some bug fixes and cleanups
Date: Wed, 12 Nov 2025 22:35:10 +0800
Message-ID: <20251112143520.233870-1-yuntao.wang@linux.dev>
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

Links to the previous related patches:

https://lore.kernel.org/lkml/CAL_JsqJxar7z+VcBXwPTw5-Et2oC9bQmH_CtMtKhoo_-=zN2XQ@mail.gmail.com/

Yuntao Wang (10):
  of/fdt: Introduce dt_root_addr_size_cells() and
    dt_root_addr_size_bytes()
  of/reserved_mem: Use dt_root_addr_size_bytes() instead of open-coding
    it
  of/reserved_mem: Use dt_root_addr_size_bytes() instead of open-coding
    it
  of/reserved_mem: Use dt_root_addr_size_bytes() instead of open-coding
    it
  of/fdt: Use dt_root_addr_size_bytes() instead of open-coding it
  of/fdt: Fix the len check in early_init_dt_check_for_elfcorehdr()
  of/fdt: Fix the len check in
    early_init_dt_check_for_usable_mem_range()
  of/fdt: Use dt_root_addr_size_bytes() instead of open-coding it
  of/fdt: Fix incorrect use of dt_root_addr_cells in
    early_init_dt_check_kho()
  of/address: Remove the incorrect and misleading comment

 drivers/of/address.c         |  4 ----
 drivers/of/fdt.c             | 14 +++++++-------
 drivers/of/of_reserved_mem.c |  6 +++---
 include/linux/of_fdt.h       | 11 +++++++++++
 4 files changed, 21 insertions(+), 14 deletions(-)

-- 
2.51.0

